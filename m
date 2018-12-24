Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97AC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDDB21721
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="YHkjKDTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbeLXJ1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:27:21 -0500
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:52256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725385AbeLXJ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BuSrLr/BGre4MkXmLNVAzYjqX5qH/wIPvnMqBeqVo2g=;
 b=YHkjKDTaZPGjet9SXAUOFc/BwvwVSOUPsFRhbV4zK5WFI2rJxX9OmkI/EQ/76UxbhdF7sZPKEBaPWmemQejTwzKz7MmhNyAmDdEEjkGtOFntC+zezL/KWRAmnVgMgvww8O2ctxXjMsgDxaHXpjthyEpCWm9we2lBpXxvIv8L/Wc=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0676.eurprd08.prod.outlook.com (10.163.189.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.19; Mon, 24 Dec 2018 09:27:16 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:27:16 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH 11/11] drm/komeda: Expose bus_width to Komeda-CORE
Thread-Topic: [PATCH 11/11] drm/komeda: Expose bus_width to Komeda-CORE
Thread-Index: AQHUm2rcbSck7e4B0kmJSWl7/E0qug==
Date:   Mon, 24 Dec 2018 09:27:16 +0000
Message-ID: <20181224092435.2792-12-james.qian.wang@arm.com>
References: <20181224092435.2792-1-james.qian.wang@arm.com>
In-Reply-To: <20181224092435.2792-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYXPR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:2e::32) To AM3PR08MB0611.eurprd08.prod.outlook.com
 (2a01:111:e400:c408::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0676;6:VwAkrsG4LjOmOGVqUwnKJjp5XN4+NCewT8qm1SzO0xgFaGoVnzfXyV52rgS5dIBL/CRB9TR2OK2kJRSisopoQqo+TuD02V9hTmQBPyjrTIDRZwzhfh5HRHnEAzATauyuUXTTsBICNMvwEskHEu+JUYhU6/sbHh93cocwI1YJ7SL4amyuMz7lpWyPoyHwgilPqacQrGee22n6qxCvLsf9lUoWKbXIr+15pqo4oMO43dXNB8M7EcG4EmBaown8DUaoLOVuTcztGtY43hQ6E1qxJIp0pqR+C+W7daXJH3gXdhqLh7X/k9ebqMb2au5UNiBH76ozvz56DssbC7aKak9+Z4KX9RAWSIP04T0eC8ifpuPvI8Mko/tFpcdWMQ8lLc4kYKpOS4E635R9VkYXOPBELxnha/Wd9Oof1JOLvaL3V6ysK8uvOg7M23o76HZ48tUE7DN0M86mN7HLuMxad0I0fA==;5:gvspH60ZRN4Y6IYwwrR9+pbh95YlOJ4NF+pdbYBh8+SSpO792PIKAqfsUb2IxCHqAIHSUjg1lbeS8zpJoAYjRWXRTdWrD1JvrxMO9hpiDoCLofN+/LmkD3jQxID+Brc61x25pU/IfrZSDx7qtIK9p06YVFEhq/RMH2epPImtkbE=;7:6EtlbRGbsMUszj+bjAoQRXYAx2zaVq6JIaK5XhTFXHBn8PSN42KB6fXGGxlbVItWj/ulLZ55pRq7/0Jquu3F46ekVMCPQhGA09wPkDBf4a5Q4iEDGFkDQdcSM56SUi5DkqFo2SWd7sCQlFTP/W61XA==
x-ms-office365-filtering-correlation-id: 5ee53ff9-68a5-4970-853f-08d66981fe75
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0676;
x-ms-traffictypediagnostic: AM3PR08MB0676:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB06768E460312DC4F80ABC27FB3BB0@AM3PR08MB0676.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(93006095)(93001095)(3231475)(944501520)(52105112)(3002001)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0676;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0676;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(39850400004)(396003)(189003)(199004)(4326008)(1076003)(25786009)(97736004)(53936002)(6862004)(8936002)(6512007)(256004)(2906002)(68736007)(76176011)(71200400001)(81156014)(52116002)(81166006)(2616005)(486006)(86362001)(8676002)(476003)(575784001)(71190400001)(6486002)(6436002)(103116003)(3846002)(478600001)(26005)(102836004)(105586002)(55236004)(7736002)(6636002)(186003)(6116002)(386003)(305945005)(14454004)(6506007)(316002)(37006003)(66066001)(54906003)(36756003)(446003)(5660300001)(106356001)(11346002)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0676;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eqwR0aG+ep8DoBlCR+rczXbvpcAsJs8Oxt3Ble0jD4iJbok8YjvF7kNBSVO6emU4TzPszg39+04tKG8zTvMdPQia26YmeZOioXip9Eknk6BcibRWYj3nmrq0okZRFRrDh6yGcdo6y3kQc2GDKOJrSqyYoZJi9xRRG99Xejp7cdo9nirp2IkDvmXldqXKqtosnHsm6CHWMQ6NjiTFkGWMtyXh3/vxRSMlNA7PIzxbFLKM4eaw/SppaOlZNPj6RJaMTk9N6j5XU5UMe8CFHLwcbRRpS4eKcIclYhch29Yobekmhsyuu6SpfzvhP1oLkSu/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee53ff9-68a5-4970-853f-08d66981fe75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:27:16.4429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0676
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CHIP set bus_width according to the HW configuration, and CORE will use
it as buffer alignment.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c  | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index 31680bc0ccba..b5d7edf0870b 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -512,6 +512,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_=
info *chip)
 	chip->arch_id	=3D malidp_read32(reg_base, GLB_ARCH_ID);
 	chip->core_id	=3D malidp_read32(reg_base, GLB_CORE_ID);
 	chip->core_info	=3D malidp_read32(reg_base, GLB_CORE_INFO);
+	chip->bus_width	=3D D71_BUS_WIDTH_16_BYTES;
=20
 	return &d71_chip_funcs;
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index ae97db7e447e..9ca24990495f 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -21,10 +21,10 @@ static int komeda_gem_cma_dumb_create(struct drm_file *=
file,
 				      struct drm_device *dev,
 				      struct drm_mode_create_dumb *args)
 {
-	u32 alignment =3D 16; /* TODO get alignment from dev */
+	struct komeda_dev *mdev =3D dev->dev_private;
+	u32 pitch =3D DIV_ROUND_UP(args->width * args->bpp, 8);
=20
-	args->pitch =3D ALIGN(DIV_ROUND_UP(args->width * args->bpp, 8),
-			    alignment);
+	args->pitch =3D ALIGN(pitch, mdev->chip.bus_width);
=20
 	return drm_gem_cma_dumb_create_internal(file, dev, args);
 }
--=20
2.17.1

