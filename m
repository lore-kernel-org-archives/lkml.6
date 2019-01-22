Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177ADC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78632084A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="fEEylx6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfAVLMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:12:07 -0500
Received: from mail-eopbgr70058.outbound.protection.outlook.com ([40.107.7.58]:46804
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727996AbfAVLMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p3LV6P62C0hWlbi/KwwrdjgdAnOXQaEaNqZmgClF6hg=;
 b=fEEylx6lBDJkEarxQsuF6ICSax1lH9WsholA2ZQDn0XL7YaNOLcYWMqPgHZVFRaox7G6JXVX9YxQg+EE1DamRjH8WRNET8i8RoZL2jZkqm9uYuq8r9PZ1Pv2XdB/kEFlPQuWM5EnsEgic1JExKVlDOznYZ8QTl7NagzMbqln5Fs=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2085.eurprd08.prod.outlook.com (10.168.86.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 11:12:02 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:12:02 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>
CC:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: [PATCH v2 11/11] drm/komeda: Expose bus_width to Komeda-CORE
Thread-Topic: [PATCH v2 11/11] drm/komeda: Expose bus_width to Komeda-CORE
Thread-Index: AQHUskNN9SGO4YEklkqblbMQ2M6ApQ==
Date:   Tue, 22 Jan 2019 11:12:02 +0000
Message-ID: <20190122110932.5138-12-james.qian.wang@arm.com>
References: <20190122110932.5138-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110932.5138-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0034.ausprd01.prod.outlook.com (2603:10c6:1:1::22)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2085;6:nyGqCDmLRFqnR22fKXl8O03IMvJ8uscuD1khTfz8lmBP5KXsK2ojTNT1WABjF9Heq9uRFQpRFuhgOi/y1tuMJ45HhGs502f3IKp7yFXGc54vkDXsSJ0dCTg4QHu/d7E4BOpBiDzzfG1x0zOIpkH+YmTSyLmX00mEn8kvY7pLiTCB5qVfOmcpX9nxS42rJCYaK23yoQEdHeWIrs7IVFaO8XzNoZ5YAIuAIZbzPkwB2juAJWcERcnRlQTSI/DnBMEuQzz6aPn/EDZfbex9ZQD4BuaGidDRenfLnON/zZ14rnWMRPpTKkF0gDTpds5A5GGQbVDxctoASRjnGjrKKxJFdOym0aCZEd9DOw1jaRLf9FxN5RJ5qkBneCu50veu3QaC4Hmk6PV07aq7AqKtD9vVylfjUeX+YJBAejwvE83AbV1DSBqBMveYyb4XxBCjGe4wHO/ExupzepOy9jDefUibqA==;5:triTfbrJMVV+AU/IujoRJqU1plsLu629d3MkOhlScX80cjsw5luhNGrOAqkFEi4On3TpOfywMOqW0Bipk2riBry59nQgmpsAAIcYm4VyXQx1GdfBusbE4OSAgWmX6KIeq2RIAHG2NtjQF5OZPHmC/Rp8XnVUPA6Ava0Nq1G5NicY2hgBRNlFTv+gR2enaTAofqm1s5V38eW2MAJR1t4WHA==;7:79VvgADO/Qf9SAWMMrq+JMqo0ciS+TTdB4QTDyfQTo8pa/KOCMV3bd5OHq1v074qyVT0XaDBRGdPU5Sia/FVV77diVzIcR83gObhwGmWnwcidNe3tiYmQLp5Eo4BwYxGEDG3CH5tfQBLmHyDPZ+EhA==
x-ms-office365-filtering-correlation-id: 98d6943d-0550-48b1-ca9f-08d6805a6f3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2085;
x-ms-traffictypediagnostic: DB6PR0801MB2085:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB2085989357820241A7078E9EB3980@DB6PR0801MB2085.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(316002)(110136005)(11346002)(71200400001)(99286004)(6512007)(53936002)(36756003)(2501003)(4326008)(25786009)(26005)(478600001)(71190400001)(446003)(476003)(2616005)(486006)(54906003)(186003)(1076003)(68736007)(86362001)(2906002)(6486002)(52116002)(6436002)(103116003)(6506007)(6116002)(97736004)(386003)(14454004)(102836004)(55236004)(105586002)(305945005)(7736002)(76176011)(106356001)(81156014)(81166006)(6636002)(66066001)(50226002)(8676002)(256004)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2085;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rbkcqTcm7QVUych8fAWFntSRQLwk8a/p7fzmvk0J3ncQXK7TdY+4P/WdF3Vgo5champ45gZXVTSOIGyO8NehXztaRYvkJhLbqE6tXIzsd7+8RmXxPAGBF4htBmnE0S9WbDwzPdKCWvDgZHveiQYfW1rAgLUAgJ2FlanK/fo7lcGpy+H5vPO++oU+Z0hBAXsyte8aPi7AiFgA/W52ItrmdVVjnnF6IldBvpE/GbFGKC4oYo30lSAG/I9DlkfO1QbqpgrVjJc1TLWK1bgobZSGXGUBWph/yTwkalrE5fI85m0dL1biWYDf6cTQHYJ4Tmap+/HUyovAa9hty0s5bzCY07shIAsyO8noYYh8/JioDxJun7sLWI+qO3SJ4IVx0mUs3V/eiShVCqOkHxHrIerXIqokG6Pvsjb+VejFPoBqELY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6943d-0550-48b1-ca9f-08d6805a6f3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:54.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

CHIP set bus_width according to the HW configuration, and CORE will use
it as buffer alignment.

v2: Rebase

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c | 1 +
 drivers/gpu/drm/arm/display/komeda/komeda_kms.c  | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c b/drivers/gpu=
/drm/arm/display/komeda/d71/d71_dev.c
index f517ab0ceae9..a6ca3ff16fef 100644
--- a/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_dev.c
@@ -518,6 +518,7 @@ d71_identify(u32 __iomem *reg_base, struct komeda_chip_=
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
index 337e6fddead0..ed54beaee2f9 100644
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

