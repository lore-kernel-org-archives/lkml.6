Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930BBECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E4D208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DouzWSKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E4D208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbeIQIy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:54:56 -0400
Received: from mail-eopbgr710102.outbound.protection.outlook.com ([40.107.71.102]:64704
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbeIQI16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pQP+ofbpPUd2XyMUe8cW4QiGY1dn4cKyWAQlaKGpbjA=;
 b=DouzWSKCSEd2OAO5HOMIg//BcJhx6JqkzfLSnP0g6nkuT877VmpAGqgASOeCwo3WFF0SLANelsp7zmqvtm8MkiGVbyLOXeSxOFV0b0l6MUJJJBGPwLYUr3l6+UFRUzg3RivhRo43+YgZsvxMMhl6uRN3vL8+GOr7Zkrx3ia63L0=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0790.namprd21.prod.outlook.com (10.175.121.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Mon, 17 Sep 2018 03:02:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:02:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Tim Bird <tbird20d@gmail.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 099/136] Documentation/process: fix reST table
 border error
Thread-Topic: [PATCH AUTOSEL 4.18 099/136] Documentation/process: fix reST
 table border error
Thread-Index: AQHUTjKyHec9DzGj406WKqU+446r2A==
Date:   Mon, 17 Sep 2018 03:01:14 +0000
Message-ID: <20180917030006.245495-99-alexander.levin@microsoft.com>
References: <20180917030006.245495-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030006.245495-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0790;6:EAHoaKUMgn1Yrqt3VMxlgmDfLUg3opaQLTHIkTrGWOgWnn+qeMa8jExMsSczTtFWbUmvCq1WKtx+MMoP0mVMy+0jADwCn/uuutlcew270CDFKvdtkTbPicGEwDNtgtnRGB2ria66GCPp76+zWkwZVQ0p7FDW3Ijh1SjM0uWcaTai9g2bsyOZGxU1jMfw7b+pGdaQMevPMDiI+nCj85vF8yxLN7FC1Tvc2XEN20Kf5zX58JBTAUpOeZdFn62noRxtmtI5fR1TTEwAi/GUOTTcOg64DtNgQXrruDaHUtpYguzdSz39EJWmPUvezXuQvnKGW9Gh1fQ6NNfUy9psMXW+iNtfvXhT6g31Ip4nUSmJ0ARPBEAiSg00lGM4o/leiJyGv8KYTlT5P+tg2aUokmKP2MCCT/b3NVBk8947Jvj1QJLTBFFeahXkSDHW7KWeVk46WlRQBKuZsmi4tt6doQz0yQ==;5:s4YgI7OiMrSycCMN+jYQoDzagClFXGXIIJmPSB8ExJE22Q6FM/s8ThzQtowFV8hmSHIcHoESbYY2pf412P6VDTOG9MY9WXItmjZ7BDGbsDh0a3cYJNtT9ttW8p4NHrMAIIL0LN2MLtrrUODuljBAx6uaJNCyaTdAR051XudgtXc=;7:9beUMorBlABKv8QG+73GMe8nIDzo7Hgllvndl417m0aE3ASb8WanM02OyLFKMOu4OUAf2Fw5nS08yzMDzoLmohIZP+zaGesjY4kNendVsjrVAM4VsEp+7QSDzyFNB80SvUdKGGOsXb7XzD8HDletM77teLXfctb5g1A2oP+iIs/pp39mYIxJPRf/lzkDVVq5UQS2TdK7MXcCLkihhVrUwtUMxAtfAr3a5x8hmIF/bsjUxQzzlpivOB1wMKftB33p
x-ms-office365-filtering-correlation-id: 0efa86dc-1213-401d-8e24-08d61c4a05e6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0790;
x-ms-traffictypediagnostic: CY4PR21MB0790:
x-microsoft-antispam-prvs: <CY4PR21MB0790318DC37AB54C30F53876FB1E0@CY4PR21MB0790.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0790;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0790;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(136003)(396003)(376002)(366004)(199004)(189003)(76176011)(22452003)(6666003)(110136005)(99286004)(6436002)(6486002)(2900100001)(2906002)(54906003)(6346003)(10090500001)(5660300001)(7736002)(6512007)(19627235002)(14444005)(217873002)(316002)(256004)(53936002)(36756003)(6506007)(45954006)(25786009)(106356001)(26005)(86612001)(10290500003)(1076002)(68736007)(476003)(6116002)(3846002)(478600001)(5250100002)(11346002)(446003)(72206003)(2501003)(81156014)(81166006)(8676002)(14454004)(102836004)(107886003)(186003)(2616005)(575784001)(97736004)(86362001)(66066001)(305945005)(486006)(39060400002)(8936002)(4326008)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0790;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Q8YqlODwLc33fodG5PoJtkwiGPG8/9iukzUeddduPOnWhoKaWjNs24fTICbteAswyWg3n4VVNX3UwCsz5cS06hYM6+RiE+hgBTaGwTjEHTluG50J0FxpWvpYDV8GUUmHuRdCNlyLr0px2eCFYd5O3aGkTifWSXPEj2d4D+ES4D3e0evR7PAjhDMaEypSddOcXv9ddMVGCqpgzJ7Cm8OO8OVhv+dhGMi5YVX/Bn/WV7Usp7y0PSwE0uSNRR5NnvIp8vimke8L8y4Rm3NLEdofBQR5BBgKeInlVDoKW5TUcI3Xg7kNVxkPAO7lfAdHpgH6bgrDH23Czf5ylmWjNhjNfiEgRmLRga07kzM5H6d5NZ8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0efa86dc-1213-401d-8e24-08d61c4a05e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:01:14.4010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0790
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit cccd289f12d0e827070c847b1ff96ba02eb20eaf ]

Fix reST error in Documentation/process/:

Documentation/process/2.Process.rst:131: ERROR: Malformed table.
Bottom/header table border does not match top border.

Fixes: 8962e40c1993 ("docs: update kernel versions and dates in tables")

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Tim Bird <tbird20d@gmail.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 Documentation/process/2.Process.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.=
Process.rst
index a9c46dd0706b..51d0349c7809 100644
--- a/Documentation/process/2.Process.rst
+++ b/Documentation/process/2.Process.rst
@@ -134,7 +134,7 @@ and their maintainers are:
 	4.4	Greg Kroah-Hartman	(very long-term stable kernel)
 	4.9	Greg Kroah-Hartman
 	4.14	Greg Kroah-Hartman
-	=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
+	=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 The selection of a kernel for long-term support is purely a matter of a
 maintainer having the need and the time to maintain that release.  There
--=20
2.17.1
