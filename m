Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75317C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E26217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="ilc3H8Sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLXJ0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:50 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:64112
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbeLXJ0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a20ZklzBdUbYKexUFKm4SvVRy1PAe0YyLcStPMdQSWc=;
 b=ilc3H8SdpqzXtp5vISr+rxXoHQ17MaicszLi2IX5whHsUwVJrthiYNPFxnI6XILagDQ+tGw4KEac7ga8n3cqqvgRVXvPAjHnOYyk2wbDE4KukejlP5lfwKSJi1RPac8SyjRUCkDNbLLUwD/SvULfWZdhqhguu+frW3rOEb7luyE=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:26:42 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:26:42 +0000
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
Subject: [PATCH 08/11] drm/komeda: Add komeda_crtc_funcs
Thread-Topic: [PATCH 08/11] drm/komeda: Add komeda_crtc_funcs
Thread-Index: AQHUm2rHxJ/QoI5+q0mpQIwQisN8JA==
Date:   Mon, 24 Dec 2018 09:26:42 +0000
Message-ID: <20181224092435.2792-9-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:AdEefwiqoWQwuBy+hM0/MSzAi8eFzVyPIfnaN8bRr/REZFma+LrvNgZ/a3azM7k8U8IUUqFkxCXN5UIwfn9oeTUmWpqcjHl9FLMUs/lDXbYjH/buyPd9IsMIb52vrendPetmecdGOKIphVpLfgnGrUzdnD3BLracnETy1l7a7ae/JmKKh552YVWzhbdzjbqOhgziO21sx7SJwlS6NZrjcP4GhwKe5NaF7rlNCLZQqQ/Ze3Zx9dibIW2kNqsbDljRr6zufmK6p519/NoPIHmZR018q0BWT+cWkVBvPq3EBSvJlv4YwgYXD7knrVfn9uGZL1JwNTX0NyPy6++Ra6BOYFngW2PIPy8HoIelNmYKz8n3XPlQOplabLSxA4pyeHnHdvAqlst/0PN7r9Gf8re9SEVHXohBUORu4l2qHg5eiKVBtR7dnjzBa3ofYKkUN4fIDBLUZvBdyI96g/pGLCegRw==;5:pxpeSRjNdk/9HOeKFT2pHJxWHdt3qRRU3SWNxTRSsIRdQVEfl5UdDNFnhsQuTyYmo9RW/eCqLpR6LAwsAZIX1AfSMDSNvVWr4GOf40u+I1dduqlSslqPmeF9+4+dxbfxKUKEejNixogihTa0VJfvpl+9jELNF9aSQxakk11fJZU=;7:h9nYHelNhJZoZCEemqCXRSFlOejkKER+CjWbhWoZUsS9NTVCA2ER+xZ0lfGpoc4G/lFgAZGFyjiO+TCraH2jvJRoS1T4rMuJ3d9YyxjukeQ/wa8zg8xvvBjaSeIBzKiPIMAlfvU+ZoOhc3bWGYSEaw==
x-ms-office365-filtering-correlation-id: 3e3498b3-43e2-432c-768f-08d66981ea2b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB026216DF11033EA4433765B5B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: A0k1O/KRk+5SqXUkZuq1Y2akb6FPU2gqCN/Y9oicpNtSuMX2RgEjy7yxDiJm9dYfhYnrTD5pVMKgwoqQAE4FhUN2CYgE4QIiinuiGp+0u9CkMDorzSqv+2eyr5rgY2Z5QOZQK8ohiKk22y2uzpszA96K8FLRTYgQKpAAIaZwNEcsvP5oHCeG5xrMHlaIgW5l6qdCW/VIy3sHBQaBcIpUuGrwO8rXGuhBw2u3ouhZzLALR0Y/Ifh3YMyAHuw/uW3BDBdAGddAvLIqFxg+mfk2OxB/Pb8UAEnIPCCz6F/uj4lLWjev22/ykrGy20V2sNtI
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3498b3-43e2-432c-768f-08d66981ea2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:26:42.3691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added functions:
-  komeda_crtc_reset
-  komeda_crtc_vblank_enable
-  komeda_crtc_vblank_disable

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu=
/drm/arm/display/komeda/komeda_crtc.c
index 6d9fb4626ba5..cc7f67fb08fd 100644
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

