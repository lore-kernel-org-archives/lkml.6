Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53BDC004D2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E0C42083C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 00:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Lxit7gCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E0C42083C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbeJAHPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 03:15:00 -0400
Received: from mail-by2nam01on0116.outbound.protection.outlook.com ([104.47.34.116]:2013
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729563AbeJAHO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 03:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2aD/nNGn8Jvx3/iLYWL2cQqCvnOTN77kLhMEB8mBvY=;
 b=Lxit7gCazrg8a88NCPymNlA9OwEU+1qXG5kxQRSu4Vzz3N87yaLNX6YsD5uTDS0E5mHq9PkDtOb0mQQkeCSsvijDp0e3bxKMBvPQP3qzdOiCVVl0bLXoWiPw3nkQOZOfJyf2gF4YtF9+e1VI/imZaAjzmou51Rgi1FN3llYeKf4=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0854.namprd21.prod.outlook.com (10.173.192.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.4; Mon, 1 Oct 2018 00:39:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1228.006; Mon, 1 Oct 2018
 00:39:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 18/37] drm/nouveau/TBDdevinit: don't fail when
 PMU/PRE_OS is missing from VBIOS
Thread-Topic: [PATCH AUTOSEL 4.14 18/37] drm/nouveau/TBDdevinit: don't fail
 when PMU/PRE_OS is missing from VBIOS
Thread-Index: AQHUWR8nL5rPLydo5k+sxrqs6VUzsQ==
Date:   Mon, 1 Oct 2018 00:39:04 +0000
Message-ID: <20181001003850.147107-18-alexander.levin@microsoft.com>
References: <20181001003850.147107-1-alexander.levin@microsoft.com>
In-Reply-To: <20181001003850.147107-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0854;6:kWNOKMlQ6OA+e8J67JyKxHp98seSJ/nH8qx8tfpZUe4WOGZW44vtwgNgzWd663A0DnSQSgeIlWCmCkT0rzflVuN1/7McDGZHlxHaEuEfHzkQyOzLMuTnC9Tx9H+qZCtTMTSeKF2E4ftLLOAmMerQHRmx28DwYV9Uf+euq1rXoTupTe3Cbs9TLu62blXNCYHYta9mMMd7emQ5aaPGJHDThXTenEL7N3I9kZBQtqvM4eoI6r5Sb34aD6L1Lrs7NBdKhr/F0Ke2amkGu7hNwFG6HAS1JjmtxMlLchau0ry15gv1ol+EgcuZzUcOlb7WpB9VP5SF+or79+ChjCfQR8pAAV9fzz78jhTQUAabY+1Iwf1337Bri2poV2HlxF6kcLfA/zlB0axLkuLWBwT1Ymeq6ozmBf+PqCH3u1mzAkWwYbUUdotbn4xRl6aiWRK002hkE/sPDxCUhQ4SZa9YzXGJ/Q==;5:mAZsqSRqyRTNxQwQ1r2mcnoHnkg4Aa05qQ+uvMKBVWHb3svhHOGP3SClvuL/VDCiOyFO+5LK5yEq2883M/bdVNmwUMnYuIBrwVl6PkJHheJ30ZW8Nn5DzGw4N7+/TCc8fbujyWhXFNckUOLYdMZD4hF9hy0g2dWreNA5qRDfh0c=;7:v6/xqfuHEhAd1Q2pH2K+Hl7Gcr/EDb0pt1CIwfgZIetIrsPvREoyDdCBMwraOAbhlzfd6at1yFFZWpJW7cvd56FzBMgUHP0itUnIfTyMMh4Gn+ehhXsgKN7ehxN/7ZZ6h4OxstcAtt0o2U40ckVGufFOSVMK0/q8YBfg4k29bXy8g9SlQrd3QL3Z8v74WiqkWC3G33NcNaa/UhEoHxYww1bVynIYkgeGrtTgVw9U03l3muRWvpafB7vAtor3BZAs
x-ms-office365-filtering-correlation-id: 995f537b-168a-4f21-4d59-08d6273661c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0854;
x-ms-traffictypediagnostic: CY4PR21MB0854:
x-microsoft-antispam-prvs: <CY4PR21MB08540CE98F8641E7B551AB23FBEF0@CY4PR21MB0854.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0854;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0854;
x-forefront-prvs: 0812095267
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(6116002)(3846002)(217873002)(5250100002)(1076002)(71200400001)(97736004)(71190400001)(76176011)(6506007)(99286004)(36756003)(6346003)(26005)(2906002)(575784001)(446003)(86362001)(11346002)(476003)(102836004)(2616005)(14454004)(2501003)(10090500001)(14444005)(107886003)(4326008)(22452003)(486006)(316002)(34290500001)(186003)(256004)(66066001)(86612001)(305945005)(25786009)(2900100001)(6486002)(106356001)(7736002)(6512007)(53936002)(81166006)(81156014)(6666003)(8936002)(8676002)(5660300001)(68736007)(54906003)(110136005)(10290500003)(6436002)(478600001)(72206003)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0854;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Tx2mOiVslIYvs4ErwoSWnVb8xxPwPA7E5VrgZ7Y09XkzXCbo+RMxrkGIc7tXb3zHjTakRyQ+p1g9PjzGQpHc4lQkbFnZL4hQ7OY8o/p4NtNqvzQaJNutuTYF8KPVq87fzjPP9KE2XajXxbqqG8d1dzEaWcysi0oO4pQKDf9zhAU9CE+kHzxFY8zxFlgwKNB0h2y8aoDmeEtX1vqyqpOW8PAfLYHEizxwZCQ/zF6WwJfpLSX1i+cuOOOTZND+WVsGgH6yRRYedTzNODmdFurxmpPpwZdrertl7t0ZOUZNrz4j/0CL5GckWfUsCztKXxQibAFsq73R5U2apSYtLcqhBzKUnBAGt+ZFPwxyjzLRglE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995f537b-168a-4f21-4d59-08d6273661c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2018 00:39:04.5206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 0a6986c6595e9afd20ff7280dab36431c1e467f8 ]

This Falcon application doesn't appear to be present on some newer
systems, so let's not fail init if we can't find it.

TBD: is there a way to determine whether it *should* be there?

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c b/drivers/=
gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
index 1730371933df..be0dd6074b57 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c
@@ -158,7 +158,8 @@ gm200_devinit_post(struct nvkm_devinit *base, bool post=
)
 	}
=20
 	/* load and execute some other ucode image (bios therm?) */
-	return pmu_load(init, 0x01, post, NULL, NULL);
+	pmu_load(init, 0x01, post, NULL, NULL);
+	return 0;
 }
=20
 static const struct nvkm_devinit_func
--=20
2.17.1
