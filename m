Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0A3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7320870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="GaOJ16IV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfAVLLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:11:43 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:49312
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727701AbfAVLLn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JXoCa3BKJehQOVZ6C3DavPm1yK5k9bQrAGZlsGwgUL0=;
 b=GaOJ16IVhdpZyxvHzmSFr07QymsQBUYytMqabdC6riSoTEXbtx5O60VyTD8Rh/B5cadaJ/OtNEyjhlLFx7TRacnzkDzRPMWJ0BOLdozTx3x/IxNx7ELwkeynq4IGdGkQNwEMmtr1wQAE/WzvQSs45yV/1el1boVvCdBGSV1FI0k=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB2085.eurprd08.prod.outlook.com (10.168.86.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Tue, 22 Jan 2019 11:11:35 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:11:35 +0000
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
Subject: [PATCH v2 08/11] drm/komeda: Add komeda_crtc_funcs
Thread-Topic: [PATCH v2 08/11] drm/komeda: Add komeda_crtc_funcs
Thread-Index: AQHUskM8rTJckBFvX02tgR37OXQTZg==
Date:   Tue, 22 Jan 2019 11:11:35 +0000
Message-ID: <20190122110932.5138-9-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB2085;6:oFZ1dUbJTXue6o3dgjYSQHBaIQu6HpA2miKDuV6cwepbPorGTtFXFJ2IMSLBnpStRWDlRgEOhN7Oq7VwQmE5Q1oTwZhrrbFf2Vvo+P87aEI5FXbBwVHORaLSkkr01i8Czd8aSLa8eh05ZMgsmWp913AyNwKwGoCUOhT27XaIjHeI2uG4tFaiNWL89iTlP49pKfOq4qeoyx6PfwoAK4TJIzaw6DmfZUsUNFKtKUDMoYqq5QNfWpYH2aKFpIFfWobcIWFW0XjmRwR+MvgEJAycOyzAWPsqIsRwAF4YEiTOTcaSxKIywldr9jNfbTmhRfWNGgiaAl+Ct/vl8LRpCjPnrDvvqMZsGXJT7qEV2KtBcxzGMmItHk8wi+4MQwExXlV5O201rY/yUxRThMcP1RnFmzh6TIe6fy+LvKR91Qv2eLXOeZi7Oxxw0IxKRAlf3BoggWxS0+qGn+hJMECiJVIXYg==;5:R2e/OnwQjxhlmFu5R9CBs8G61UCW7zUkAaCtUCT6KJCGIHVKPNta3G5fVUTjyrHTlZPNVuxNqtOoeo0jIvmm0sbQkZ1G4XG5vERIMagaKoEoXPOi2AEpu3Kwc41O40mrrYhMbirUiBTlO3Q9b5SmRO2TodaEUCj7D7hUSQT6X+JnU9QMer+CbUNWA+j9QizZNm+c7vu8BAReRd/kHUeqBA==;7:vAwUUJ0Nw3DDnBddePiUg3WYNl/X29tZJtaL78xLKmrVpWVH02z/DMISH6TeJnrOyqCwD3UP5K27kC5T5CVC2BWVsktjB+ejfVPT2ZEQkOjrrB/RRIkQYpFYOL3Mt7mNNlYzayBlR0H7imicVsUEAw==
x-ms-office365-filtering-correlation-id: 96b0ed87-77db-4c9b-37fa-08d6805a5e96
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB2085;
x-ms-traffictypediagnostic: DB6PR0801MB2085:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB2085E0BE80F1E3C3D0A5D062B3980@DB6PR0801MB2085.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(316002)(110136005)(11346002)(71200400001)(99286004)(6512007)(53936002)(36756003)(2501003)(4326008)(25786009)(26005)(478600001)(71190400001)(446003)(476003)(2616005)(486006)(54906003)(186003)(1076003)(68736007)(86362001)(2906002)(6486002)(52116002)(6436002)(103116003)(6506007)(6116002)(97736004)(386003)(14454004)(102836004)(55236004)(105586002)(305945005)(7736002)(76176011)(106356001)(81156014)(81166006)(6636002)(66066001)(50226002)(8676002)(256004)(3846002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB2085;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xYZF+AHm1PcjBHuH0w3VSuN0A3jT7C8UpLDcjN6jgPZ0PMdAVW+XhnxUkA/0AJcF3vkRH0udIbguXyTvp02CLg5dQt5JKRwAFTt3upPkEjmzysjdJgwOWtJqwb7EbzmJzXO/cX8MyeEvvdIYK210dfggXA5njyOfVUrAIpX4wDad4m/1TrDDYT07Vd9TKgKNXfkG/vujzDCuaQo46J3HmRGcFs0GxXAfBNMyORs0vF7+vrjrgVK2AZpj2duuAy15relTrYD75WZ+kRIjkqigTW9V3uUKWsahgn0AwgXMlA9QYjS+qyjJioBZpK4JH8gu9AP4UTSQsR4zgCVFHpp+9jqceuc7ABfYlLu8+J0FigluHKlolZlpLkM1xfnr/nNHwTP30jFJnYRqtcj2a5erm1TXO35E9oKFI5ArRT9U0Js=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b0ed87-77db-4c9b-37fa-08d6805a5e96
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:11:25.9005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

Added functions:
-  komeda_crtc_reset
-  komeda_crtc_vblank_enable
-  komeda_crtc_vblank_disable

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index e19ba9468d31..7adda663b956 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -347,6 +347,47 @@ struct drm_crtc_helper_funcs komeda_crtc_helper_funcs =
=3D {
 	.mode_fixup	=3D komeda_crtc_mode_fixup,
 };
=20
+static void komeda_crtc_reset(struct drm_crtc *crtc)
+{
+	struct komeda_crtc_state *state;
+
+	if (crtc->state)
+		__drm_atomic_helper_crtc_destroy_state(crtc->state);
+
+	kfree(to_kcrtc_st(crtc->state));
+	crtc->state =3D NULL;
+
+	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
+	if (state) {
+		crtc->state =3D &state->base;
+		crtc->state->crtc =3D crtc;
+	}
+}
+
+static struct drm_crtc_state *
+komeda_crtc_atomic_duplicate_state(struct drm_crtc *crtc)
+{
+	struct komeda_crtc_state *old =3D to_kcrtc_st(crtc->state);
+	struct komeda_crtc_state *new;
+
+	new =3D kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+
+	__drm_atomic_helper_crtc_duplicate_state(crtc, &new->base);
+
+	new->affected_pipes =3D old->active_pipes;
+
+	return &new->base;
+}
+
+static void komeda_crtc_atomic_destroy_state(struct drm_crtc *crtc,
+					     struct drm_crtc_state *state)
+{
+	__drm_atomic_helper_crtc_destroy_state(state);
+	kfree(to_kcrtc_st(state));
+}
+
 static int komeda_crtc_vblank_enable(struct drm_crtc *crtc)
 {
 	struct komeda_dev *mdev =3D crtc->dev->dev_private;
@@ -365,6 +406,13 @@ static void komeda_crtc_vblank_disable(struct drm_crtc=
 *crtc)
 }
=20
 static const struct drm_crtc_funcs komeda_crtc_funcs =3D {
+	.gamma_set		=3D drm_atomic_helper_legacy_gamma_set,
+	.destroy		=3D drm_crtc_cleanup,
+	.set_config		=3D drm_atomic_helper_set_config,
+	.page_flip		=3D drm_atomic_helper_page_flip,
+	.reset			=3D komeda_crtc_reset,
+	.atomic_duplicate_state	=3D komeda_crtc_atomic_duplicate_state,
+	.atomic_destroy_state	=3D komeda_crtc_atomic_destroy_state,
 	.enable_vblank		=3D komeda_crtc_vblank_enable,
 	.disable_vblank		=3D komeda_crtc_vblank_disable,
 };
--=20
2.17.1

