Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9825EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAFA20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 11:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="CYsI0bDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfAVLGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 06:06:31 -0500
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:47728
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727775AbfAVLG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 06:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kjp0xBOYLv/D9P6ubA6VlmpuUy5cLeaICgTq4kOTK+I=;
 b=CYsI0bDncVkJVWKEwkCFJ/P9uu2xhMHhKuy8pfllJ8jZSFQVjZUc2xJrLRhhU/kJ4HyP2UsFDMEiGgmwIvBwtrstaI+wS9Zlc9gA5k43OnX8fHdQJ2gZ+XotmKah1iU3tExFvZa8IXhvkppJnx1h/AN+8MJp3YDVr4LdWJDFSBc=
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com (10.168.81.21) by
 DB6PR0801MB1671.eurprd08.prod.outlook.com (10.169.226.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 11:05:51 +0000
Received: from DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33]) by DB6PR0801MB1990.eurprd08.prod.outlook.com
 ([fe80::b9be:3d28:78a2:6e33%2]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 11:05:51 +0000
From:   "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
To:     Liviu Dudau <Liviu.Dudau@arm.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>
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
Subject: [PATCH v2 2/5] drm/komeda: Add
 komeda_pipeline/component_get_state_and_set_user
Thread-Topic: [PATCH v2 2/5] drm/komeda: Add
 komeda_pipeline/component_get_state_and_set_user
Thread-Index: AQHUskJvY0A0BIanXk6La5fKStczuA==
Date:   Tue, 22 Jan 2019 11:05:51 +0000
Message-ID: <20190122110431.5025-3-james.qian.wang@arm.com>
References: <20190122110431.5025-1-james.qian.wang@arm.com>
In-Reply-To: <20190122110431.5025-1-james.qian.wang@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [113.29.88.7]
x-clientproxiedby: SYAPR01CA0021.ausprd01.prod.outlook.com (2603:10c6:1::33)
 To DB6PR0801MB1990.eurprd08.prod.outlook.com (2603:10a6:4:6c::21)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=james.qian.wang@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0801MB1671;6:YY8ApOn8wwXRUO+/4d2CJQgrkRKa+j5zTLnjqQrYyyOVrDmn/rDViiIXtH33lyTF3APugtp+QUJKSPoUOngbO89SHa6B0RrVsyslWWLCT9Vg1ygPLKg0VvA7apgp3upkF0KLZy6mXNKeZ/cPx6bbGrEUFQrv9dRZ6mX4zWqQC1K+Hy226VkTK1GI2BMpu6BAiyKzkAsJW8EDAmunwpcOsgBHhMA9PI1fPd0QEd9OS0H0bpkuScDMz2ZTXdYB4n1QwZkUYSzpwM/8u28Qnr+xmOtvSw7sfwyYuBqqgDvfqVLQvc8KsCZyvHXfE7ftGfIubgP/M0AG3lKbcLP2B/UgNcdteVIEP69d+E/XapJLlO9FHb1Pey0vNbijosumDFu9LYRxCFg6YC1KCzzkLfZ27etSv+gMlV38swKkhXorMBpnv9UzoTVgf9ZhgU82FiMh3HQ3KADo0gr45JcCNG2+pA==;5:MKh0zQVXgMZNduJC0oUWCmhVtk/51JglQ3c88XuN1h7LQ6On8qGHh712NLdytq4hZKTnHNMXqqYyyHkp6B6/HOTYdxmiEwRKhSd9qZVj7zFMobmK0FBf8taEhXBsvByUf9wF404PkCcOL9GeSfjFFqzVFm4J0AGFQh5kxUPhiSfHz9h/0lmJIldWWlwIP0i85ZXe/GLUC5gMU++ATjecRw==;7:dogdJWT9hM44Ng80POpRwxH9IJcOvRKAdGmI0gJ+aPCNHqGtCeSrkachA6FpC2Np8SNNPUNiZc26bVNWHn/xm4DMisAzoeJcFkar/1/+hHm/tVZ0UxhQIeiCB6560TZfBic2rnV8x1sbJM1ygztaCA==
x-ms-office365-filtering-correlation-id: e1fb1516-cfbe-4e60-6ddd-08d6805991d5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1671;
x-ms-traffictypediagnostic: DB6PR0801MB1671:
nodisclaimer: True
x-microsoft-antispam-prvs: <DB6PR0801MB1671B930F02D720E41C0F526B3980@DB6PR0801MB1671.eurprd08.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(376002)(346002)(366004)(199004)(189003)(2906002)(25786009)(86362001)(36756003)(6116002)(3846002)(4326008)(2201001)(6486002)(103116003)(66066001)(105586002)(106356001)(6512007)(2501003)(53936002)(97736004)(6436002)(446003)(68736007)(81166006)(476003)(50226002)(8676002)(71200400001)(71190400001)(316002)(6506007)(52116002)(81156014)(486006)(11346002)(110136005)(54906003)(99286004)(305945005)(102836004)(14454004)(7736002)(26005)(76176011)(386003)(55236004)(1076003)(8936002)(478600001)(2616005)(186003)(14444005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1671;H:DB6PR0801MB1990.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Mi3J/mA2ihNxH5XgqpcUyeRampgDmGAu/4GeN1kPhxB+lMKl+VzXcpN8HRiHXJp/tn0I1tMNzvCRg07nN5eVk20wkJBBwybKShIE8tCEvz8iVsn3nGdGAMSwhoIfnWZ+cTGHYsnTfCqXcJhpU9ASU2/s2XHV58u8CouPI/JHLT40siFa4rbOjDfLRdJnwfnjIlzjaZ/+TBQ0dJfhqa6MfBPOy+K0PwxF+7BJN8VCTnIZAoggZDtUxmtXspApnCogKvqIP5k0GZW9vwWpH/cXQM3AKm5tadAf6akaQ6YZW3/YgvQhXFRe/l9vkQmwjob0Zil8YxkZUPiqiEE6yD6ytHNhweKhCQajCtcvJCuRzSwSZNTiRD26RDjWqQWyNs5BdwfxCj5J6qImbJhk0H8AJwGzY9HxtoRsdwCJSwx7/Uw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1fb1516-cfbe-4e60-6ddd-08d6805991d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 11:05:41.6475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1671
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>

get_state_and_set_user packed get_state and set_user into one function,
which get pipeline/component state for a specific pipeline/component, if
success set the user to it.

v2:
- Rebase.
- Applied commit:
  b962a12050a3 ("drm/atomic: integrate modeset lock with private objects")
  And delete our private modeset lock for pipeline.

Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.=
com>
---
 drivers/gpu/drm/arm/display/komeda/Makefile   |   1 +
 .../display/komeda/komeda_pipeline_state.c    | 142 ++++++++++++++++++
 2 files changed, 143 insertions(+)
 create mode 100644 drivers/gpu/drm/arm/display/komeda/komeda_pipeline_stat=
e.c

diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/drm/=
arm/display/komeda/Makefile
index d593125236ae..62bd1bff66a3 100644
--- a/drivers/gpu/drm/arm/display/komeda/Makefile
+++ b/drivers/gpu/drm/arm/display/komeda/Makefile
@@ -9,6 +9,7 @@ komeda-y :=3D \
 	komeda_dev.o \
 	komeda_format_caps.o \
 	komeda_pipeline.o \
+	komeda_pipeline_state.o \
 	komeda_framebuffer.o \
 	komeda_kms.o \
 	komeda_crtc.o \
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
new file mode 100644
index 000000000000..7ebab4fae567
--- /dev/null
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * (C) COPYRIGHT 2018 ARM Limited. All rights reserved.
+ * Author: James.Qian.Wang <james.qian.wang@arm.com>
+ *
+ */
+#include <linux/clk.h>
+#include "komeda_dev.h"
+#include "komeda_kms.h"
+#include "komeda_pipeline.h"
+
+static inline bool is_switching_user(void *old, void *new)
+{
+	if (!old || !new)
+		return false;
+
+	return old !=3D new;
+}
+
+struct komeda_pipeline_state *
+komeda_pipeline_get_state(struct komeda_pipeline *pipe,
+			  struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+
+	priv_st =3D drm_atomic_get_private_obj_state(state, &pipe->obj);
+	if (IS_ERR(priv_st))
+		return ERR_CAST(priv_st);
+
+	return priv_to_pipe_st(priv_st);
+}
+
+/* Assign pipeline for crtc */
+struct komeda_pipeline_state *
+komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
+				       struct drm_atomic_state *state,
+				       struct drm_crtc *crtc)
+{
+	struct komeda_pipeline_state *st;
+
+	st =3D komeda_pipeline_get_state(pipe, state);
+	if (IS_ERR(st))
+		return st;
+
+	if (is_switching_user(crtc, st->crtc)) {
+		DRM_DEBUG_ATOMIC("CRTC%d required pipeline%d is busy.\n",
+				 drm_crtc_index(crtc), pipe->id);
+		return ERR_PTR(-EBUSY);
+	}
+
+	/* pipeline only can be disabled when the it is free or unused */
+	if (!crtc && st->active_comps) {
+		DRM_DEBUG_ATOMIC("Disabling a busy pipeline:%d.\n", pipe->id);
+		return ERR_PTR(-EBUSY);
+	}
+
+	st->crtc =3D crtc;
+
+	if (crtc) {
+		struct komeda_crtc_state *kcrtc_st;
+
+		kcrtc_st =3D to_kcrtc_st(drm_atomic_get_new_crtc_state(state,
+								     crtc));
+
+		kcrtc_st->active_pipes |=3D BIT(pipe->id);
+		kcrtc_st->affected_pipes |=3D BIT(pipe->id);
+	}
+	return st;
+}
+
+static struct komeda_component_state *
+komeda_component_get_state(struct komeda_component *c,
+			   struct drm_atomic_state *state)
+{
+	struct drm_private_state *priv_st;
+
+	WARN_ON(!drm_modeset_is_locked(&c->pipeline->obj.lock));
+
+	priv_st =3D drm_atomic_get_private_obj_state(state, &c->obj);
+	if (IS_ERR(priv_st))
+		return ERR_CAST(priv_st);
+
+	return priv_to_comp_st(priv_st);
+}
+
+/**
+ * komeda_component_get_state_and_set_user()
+ *
+ * @c: component to get state and set user
+ * @state: global atomic state
+ * @user: direct user, the binding user
+ * @crtc: the CRTC user, the big boss :)
+ *
+ * This function accepts two users:
+ * -   The direct user: can be plane/crtc/wb_connector depends on componen=
t
+ * -   The big boss (CRTC)
+ * CRTC is the big boss (the final user), because all component resources
+ * eventually will be assigned to CRTC, like the layer will be binding to
+ * kms_plane, but kms plane will be binding to a CRTC eventually.
+ *
+ * The big boss (CRTC) is for pipeline assignment, since &komeda_component=
 isn't
+ * independent and can be assigned to CRTC freely, but belongs to a specif=
ic
+ * pipeline, only pipeline can be shared between crtc, and pipeline as a w=
hole
+ * (include all the internal components) assigned to a specific CRTC.
+ *
+ * So when set a user to komeda_component, need first to check the status =
of
+ * component->pipeline to see if the pipeline is available on this specifi=
c
+ * CRTC. if the pipeline is busy (assigned to another CRTC), even the requ=
ired
+ * component is free, the component still cannot be assigned to the direct=
 user.
+ */
+struct komeda_component_state *
+komeda_component_get_state_and_set_user(struct komeda_component *c,
+					struct drm_atomic_state *state,
+					void *user,
+					struct drm_crtc *crtc)
+{
+	struct komeda_pipeline_state *pipe_st;
+	struct komeda_component_state *st;
+
+	/* First check if the pipeline is available */
+	pipe_st =3D komeda_pipeline_get_state_and_set_crtc(c->pipeline,
+							 state, crtc);
+	if (IS_ERR(pipe_st))
+		return ERR_CAST(pipe_st);
+
+	st =3D komeda_component_get_state(c, state);
+	if (IS_ERR(st))
+		return st;
+
+	/* check if the component has been occupied */
+	if (is_switching_user(user, st->binding_user)) {
+		DRM_DEBUG_ATOMIC("required %s is busy.\n", c->name);
+		return ERR_PTR(-EBUSY);
+	}
+
+	st->binding_user =3D user;
+	/* mark the component as active if user is valid */
+	if (st->binding_user)
+		pipe_st->active_comps |=3D BIT(c->id);
+
+	return st;
+}
--=20
2.17.1

