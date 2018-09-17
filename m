Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0403BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A397F214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="bnLg2dLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A397F214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbeIQIfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:46 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730814AbeIQIdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNqY2akM5m3F0PykNQXTFuK2qQFIAOFRnDaujIPeZto=;
 b=bnLg2dLP6QoNFQE9O4hvgNApN9PAOgND7PBFlBSRYktxgejvpH2mHL5KSj/gu5wnE3oqWbKsu8Dz1s7nmI+wtjWX5ffs4uSiRZF9ZNlC2nki8qTWek74S8DMN+9XWnUnwvIxXVeBOOuvoiy5s1oXRTHgXKDL4S0z2FUqIneyBVI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:52 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:52 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Nicholas Mc Guire <hofrat@osadl.org>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 14/29] ALSA: snd-aoa: add of_node_put() in error
 path
Thread-Topic: [PATCH AUTOSEL 3.18 14/29] ALSA: snd-aoa: add of_node_put() in
 error path
Thread-Index: AQHUTjNT9oZg9T/D9kGioJKPg6HOQg==
Date:   Mon, 17 Sep 2018 03:05:46 +0000
Message-ID: <20180917030533.592-14-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:97S44Kbbn+DLWy6g5X1q1Mm4GIKs3V1oFQFos5bIf9slquzZytnS2E73y9GIygslrCh4fPkxgxpqxFOhHeFgKDUsD4aSrpfRmPuFeUn5XJ2UEfkMcsHD6POZ8FAvaEiJhVX7sPF0VFz97zZSLMhTM1ntVvgPChEeMWp+kolhpSB+YhpVfrIe8zYgKTbuh6UJrT3J/FcI9di3dzV97OsBAnXtph3i+mYZJAWdVQSsxT9fNXbqzT1LZ5U4Yvn/dta/duMJCoVxxPV8gasPaKOZfRD1cxBweSVe3vgB5N99Dw9ze7wZC1I5Nzk+URV/4+0UUvMI+uTOmx2yp5lokZmZE447HL3RgmgxbER+TumRY6lb3WOgQjNctW/1ssFWo8FTFKNiShsgbXfMQcrxR1a/U8OII982HchnbJO8x2Xo+3KZ92fFAsRLPybzQKIiKbkGhxzfL+U4HtsO88H6/6AMfA==;5:eAXPGHyjG6wqTg1iWhs5+TFS42EzT3oKj8liQnJ30ubyOQwzDxKVruIOj1gg743mN6ZBI2/EKL8qziTtSK85MMoWmw/dmjF/Xm2j00U184azPwXHs/xyaqsSHRXtle/rZc/E6APG2jcCws6OCIKgviQqbODeEUP46LapaZeGfF4=;7:74uAhbp6rQAkl92dNRrMURL6qR0GTG6ZoWIj76+onbCLD6ARI+rvHKzh5jN/0IdE79vwihFc5D+pF5ha0ip/ui0vJr8svYT5wQz+v0AQ1cEs4fjzkommaAfZt7ed/37jT6V5+3YknyO+XHvv+MAA82ce3GrrVHGqj7wYpS9yTg7VR1072yIQ0775iBcMfc4HauWhLb5Ng1v7sHtAXTvHhzkmRCqcLGE0cHWb/o+2v3tcgM+lHVpKue2oZnSMWZ7L
x-ms-office365-filtering-correlation-id: e3df9926-7501-4dd5-7d99-08d61c4ac200
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150D22A417D65718FC04138FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(14444005)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ww5BSmE7YHJQ7zxy5Aj32PjvUS4REt2IK3T6mh9MPG3fgWzzRvVBmwTFpVwNLu2iSIJQ+DwRsWG5nzar2DKnwrIuqpMGvRbz5hpP6KQ8blh8b9InAYXtey6Jaid6kqIlajuaLe4+inm3wI53Q9IvFK2h05b/MSZaz88QjK2gQGPpE/nxOteBFE2L/JZ0yvfrnehJTJxWf9NXB+3b0vXFlLfh+ag7J+2Qu8+1J6lOx2SEIvWCPpYwQLIySvCd54QnMspYqPSx/ZhCX6FzYKREAZQnfqSeTPafSUthzzOsfWV8r5KR0VLod/TyfrkeCi3J4p0396+8kdOYPKtlHN1qh8L0YV006eKa74zUoS5lSCY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3df9926-7501-4dd5-7d99-08d61c4ac200
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:46.0296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Mc Guire <hofrat@osadl.org>

[ Upstream commit 222bce5eb88d1af656419db04bcd84b2419fb900 ]

 Both calls to of_find_node_by_name() and of_get_next_child() return a
node pointer with refcount incremented thus it must be explicidly
decremented here after the last usage. As we are assured to have a
refcounted  np  either from the initial
of_find_node_by_name(NULL, name); or from the of_get_next_child(gpio, np)
in the while loop if we reached the error code path below, an
x of_node_put(np) is needed.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: commit f3d9478b2ce4 ("[ALSA] snd-aoa: add snd-aoa")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 sound/aoa/core/gpio-feature.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/core/gpio-feature.c b/sound/aoa/core/gpio-feature.c
index f34153962d07..585b594bd838 100644
--- a/sound/aoa/core/gpio-feature.c
+++ b/sound/aoa/core/gpio-feature.c
@@ -88,8 +88,10 @@ static struct device_node *get_gpio(char *name,
 	}
=20
 	reg =3D of_get_property(np, "reg", NULL);
-	if (!reg)
+	if (!reg) {
+		of_node_put(np);
 		return NULL;
+	}
=20
 	*gpioptr =3D *reg;
=20
--=20
2.17.1
