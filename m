Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019B4C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25CD218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="ci7qgq3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbfAXUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:55:10 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:35760
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726208AbfAXUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVm2c8vqgOrqml37KWdqFZnxWfatTQM7dZw+4i0DAmE=;
 b=ci7qgq3MRhjprfzgq8Rj0hK77ttFo76sOhy5ECrJc7fnbavPqBBmuU2dzEwBG7JPeiicPgI7OT1ZE1qkxnvK/4+YkV+Eh4EMegKmImI75gOqkWNPL9/o6fe9y8jnqPKZ74f2gvfR8mzytG5RP/2w4lTyStcDlCitRoc5emRFnV8=
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com (20.176.163.138) by
 HE1PR05MB3419.eurprd05.prod.outlook.com (10.170.244.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.29; Thu, 24 Jan 2019 20:55:05 +0000
Received: from HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::bcfc:95fc:17fc:11d1]) by HE1PR05MB4601.eurprd05.prod.outlook.com
 ([fe80::bcfc:95fc:17fc:11d1%2]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 20:55:05 +0000
From:   Jason Gunthorpe <jgg@mellanox.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NeilBrown <neilb@suse.com>, Jiri Kosina <trivial@kernel.org>
Subject: [PATCH trivial] kernel.h: Make container_of_safe type safe
Thread-Topic: [PATCH trivial] kernel.h: Make container_of_safe type safe
Thread-Index: AQHUtCcVBuKr2t5aL0ypcH5AlR+idg==
Date:   Thu, 24 Jan 2019 20:55:05 +0000
Message-ID: <20190124205451.GA19634@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:301:60::15) To HE1PR05MB4601.eurprd05.prod.outlook.com
 (2603:10a6:7:99::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jgg@mellanox.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [174.3.196.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR05MB3419;6:Ld/PAAtM2S+bCQu/LMN67tvJ3l/+iuj0nbRqKO7ddr5vsMw8nPK1k3HcUGkoVswMvNfajU+kEQyFwI3BPUfXOlhlZMyRseatt2V6MU+jPhIQRWtZSUYgiQefJTo9+KDKoxaTvOWEHvRGpScTpBNxdHNhBwyucTjxwlYLx4jyWotRRdE2Bj0UrZxCwXDRe+p1yEWJR4Od/PKdrKa9IeH6KwQ3B7SAUCfl8OCATY2kOwqGoU4+EJY31S6AIhPNdhDJj7KJFP42iAnJXHhjkAaxnxAon1Y/4sB8qv1BuRZ4xUjy7s11j/9Afl1fqH1abpH3GaiXlKonUaz07+gHchyYOrqW71Xbiqg5m5ij/+7rTR9Xj7VmCdNBz/d7mC55i+0r+mOpkDA4z9US+EhvM2/K0d8Qgzdjdde4/qr3mvK+o2wAJP+5vJS/HfVtzMlsvxeO44XVfD8XpahsSoqP38aRYg==;5:wlYEoylRfciT5hidJrE3BTiYS/JKgJWvD72pPMO6UiO5KvTz8tSpATV+p5aabZX/IOnMxK0MzK1tbH8iK8m4vzrX1LV/68Xd3nYcaJFTSUoDVsLX+MdeM1t1ipw1B2r6hfIfvGyPiw4+dbh3051uOOs0RVYJSIVB1LNYkaUvVqz9CgywGYfP83iaYoQ9T7Ty6DN0zGsjRqEp/onpJ+CkQA==;7:896DPl6oFLORkpbfV4R4c4lWqxwNPF5yD0MD57s9J6B1F5zeN9ARTOLCMCQwBt6k8OvlRqrQf9umGVLfwvCGU9HAYdaKYCb8NvysUVdPTmdBO3EBOKi5DWlQxdoG+D/lmdAiR5mZ/UiJ7aMlSwRj6g==
x-ms-office365-filtering-correlation-id: 1fda62b9-c78a-483c-a0ac-08d6823e3705
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB3419;
x-ms-traffictypediagnostic: HE1PR05MB3419:
x-microsoft-antispam-prvs: <HE1PR05MB3419734384DADF59074BC289CF9A0@HE1PR05MB3419.eurprd05.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(396003)(376002)(136003)(199004)(189003)(36756003)(6506007)(99286004)(386003)(6486002)(9686003)(6512007)(102836004)(33896004)(186003)(2906002)(14444005)(256004)(53936002)(97736004)(68736007)(476003)(26005)(106356001)(486006)(105586002)(478600001)(6436002)(52116002)(7736002)(316002)(66066001)(110136005)(1076003)(305945005)(81156014)(71190400001)(8936002)(3846002)(25786009)(81166006)(2501003)(33656002)(14454004)(71200400001)(6116002)(86362001)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3419;H:HE1PR05MB4601.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: odLlDZ2Cvg3gGp+HCoa01iifI/bXMrSgcIke4u+lLrJwtFXh9YT6yjP4fK7hdBcgzBOv/laBjWjDQfKWdVPQo7ZCeQjC17VtB0nlPlBDsVOyiC1iCqmkqm8Db88aetjKdvVQTfOHlMd1VGlJ6GYP+qfwUDkYW39x7EL65mNVURCMinXYJVZiDSknw9qy0zXShOUb3ufp9AGB9sl4Z+P+UfvEhVKTqFwXp6FuKmnZ53FImxiiSdTnLMmlqvWgEordU2OFfWilvn0NM42gMCM8liTMPMxJH03x1r2vYctJUJ258bcGUXauCpBhz2YQrqQx/Gmf3081OBeoUw0MClEC5ic9tgUl/dgBY/mMX9oRfQ3gfP6BC0auFQgUJtA94FU26O0yQ9Vtr57H6MdS1tdAK39rgm8lNwq0DcQQzTQvSfg=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F448688FE456524B891EBD25CBDA07D6@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fda62b9-c78a-483c-a0ac-08d6823e3705
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 20:55:04.2202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3419
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The final ternary expression is given void * and type * as arguments, so
the resulting type of the macro ends up being void *.

container_of returns a type which maches the argument, this provides type
safety and allows the expression to be immediately used as the target
type.

Explicitly cast ERR_CAST() to get the correct type.

Fixes: 05e6557b8ed8 ("staging: lustre: add container_of_safe()")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/kernel.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Jiri, can you take this? Thanks

Jason

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 8f0e68e250a760..7b85aa607eb876 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -1013,7 +1013,7 @@ static inline void ftrace_dump(enum ftrace_dump_mode =
oops_dump_mode) { }
 	BUILD_BUG_ON_MSG(!__same_type(*(ptr), ((type *)0)->member) &&	\
 			 !__same_type(*(ptr), void),			\
 			 "pointer type mismatch in container_of()");	\
-	IS_ERR_OR_NULL(__mptr) ? ERR_CAST(__mptr) :			\
+	IS_ERR_OR_NULL(__mptr) ? ((type *)ERR_CAST(__mptr)) :		\
 		((type *)(__mptr - offsetof(type, member))); })
=20
 /* Rebuild everything on CONFIG_FTRACE_MCOUNT_RECORD */
--=20
2.20.1

