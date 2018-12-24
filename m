Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4FC7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 843EF217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="g5C9Q6VF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbeLXJZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:25:31 -0500
Received: from mail-eopbgr30040.outbound.protection.outlook.com ([40.107.3.40]:15331
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbeLXJZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:25:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/V+pQX4zuds5ukiYoPamO4lROd4rl7QkoVT+56qnKg=;
 b=g5C9Q6VFArc93H2CDabNctJ9/vrz5BpY93lxMI0IetFBlWbxTdCVquDvH9g3B0nuervFP2yhoJjOhgTFAjvzQ9BTe2cvQoTpvUXGC//qVWLJHNtrpWopYUbQaPcU+U2gRJI9JBe2qZMSRQkZmEUrcyzvfQC6wEqPT0xB3OA7d0I=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:25:25 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:25:25 +0000
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
Subject: [PATCH 01/11] drm/komeda: Add komeda_build_display_data_flow
Thread-Topic: [PATCH 01/11] drm/komeda: Add komeda_build_display_data_flow
Thread-Index: AQHUm2qZC6xKu3wy+Uult4VG6P08Qw==
Date:   Mon, 24 Dec 2018 09:25:25 +0000
Message-ID: <20181224092435.2792-2-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:Z93qgQVVng+0Ret4X3NOkOpzwh+at9GeLBCYeJ/zAip8IMfIVX/8Z7WKYdsApNmysjIY5ggk9NnsfAvB2ASQIRqi8hyNfNjj9P8/SGWtxgFs+p2ExvhUpLWrd1U8iMllOABUaezPjhBSaQO+mnLpR1t2JJfD1gnSmxC+A5zlefaxhxruV9Gls8iyS+OkJoiFXHACZMQuAm6pyCmGMZzH2rO9n/qTcORZQhUphvb7NR+foZ4CkPEZyBLXI1W+PmzHBEpq4nm8yI69lby6mvaCZHBNHXp5DVT67fn1X8d6s4wXl1MV4QbiQwHe6s6B0jPHqhvlQ0LbEi6cmoLBoOqeRxMQh0paXJWnry7mzN8Asu1jJpysdhF+5Yrcya1rLBJisixjqVUkZGjUQ/7DNpRJOzNVNt6/SDSHTsTBIyk0essWBl4SNdFx2pkl0iomduJaI16g7QWMTIMHqEieAr1O/A==;5:VjWr49Dvexaf39Az8occ0brSDE+CwGHW+KwBAkKXC46DmLskSw2z4t9l9ZGi8yOmgo3gRWPoTAPSNz1qQ0W08peBKNfw1RtRYgWdfs+2y+OjAcQJRFAO40bFPZl4h4QJSIRpu8xhprxRRACl+Rj33c4umVYJGH/lXseF27JixC4=;7:33p574qtKyaHtn94DhN1oinVOrI7PZkgMNQPP+CM0d3jgJfym+Zav3YMGciXWuWXinaVb6RRXeO8LHSaGU8tMjECG7N25e4LkdzGO1QZJK550rOcF2HQ9jLECkwlL3qdGKPkM8wfgF1XdDcNa4WJEw==
x-ms-office365-filtering-correlation-id: f878fcc6-fb6a-4993-0283-08d66981bc2f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB02626634A1C60FC2751C7771B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(14444005)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: o8hEqycgc60rMnRXHEAP3dJJOj0M9BXYkMHCQIW1yRf6wm8ke32U5Tm3aRLpRUy+js59XTXc0gF1GzGI4HCQPkR2VA9Vh+OKHjKWXTawraYtwmzWAGOGa5uJh78AzNgsdFrP/8Hv9u1RRBbzKCz39WPJoRBLCJp/Qi0hUFBnQp5FpIeLyJdWM2wfO9lphVMGeAOkWbblrKYcVsXqMx1tUSehJNqdrYQ2cEQTfqprj8NzQ/YRZQz5mr1TfuEkvy5mgkZ4swoKOMks8m8bFa1/ICG194uKGq9Zq8HV7jxyH7fTKvLKWADfgjwcVGCXmFD8
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f878fcc6-fb6a-4993-0283-08d66981bc2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:25:25.2122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function builds a display output pipeline according to crtc_state.
And this change only added single pipeline support, the dual pipeline with
slave enabled data flow support will be added in the following change.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../drm/arm/display/komeda/komeda_pipeline.h  |  3 +
 .../display/komeda/komeda_pipeline_state.c    | 72 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers=
/gpu/drm/arm/display/komeda/komeda_pipeline.h
index c78edfc6ed5b..bc4ed1513348 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
@@ -408,11 +408,14 @@ void komeda_component_destroy(struct komeda_dev *mdev=
,
=20
 struct komeda_plane_state;
 struct komeda_crtc_state;
+struct komeda_crtc;
=20
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_component_output *dflow,
 				 struct komeda_plane_state *kplane_st,
 				 struct komeda_crtc_state *kcrtc_st,
 				 struct komeda_layer_viewport *vp);
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st);
=20
 #endif /* _KOMEDA_PIPELINE_H_*/
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/d=
rivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
index b98163211cfd..05386e9d1749 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
@@ -380,6 +380,51 @@ int komeda_compiz_validate(struct komeda_compiz *compi=
z,
 	return 0;
 }
=20
+int komeda_improc_validate(struct komeda_improc *improc,
+			   struct komeda_component_output *input,
+			   struct komeda_component_output *slave_in,
+			   struct komeda_crtc_state *kcrtc_st)
+{
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
+	struct komeda_component_state *c_st;
+	struct komeda_improc_state *st;
+
+	c_st =3D komeda_component_get_state_and_set_user(&improc->base,
+			kcrtc_st->base.state, crtc, crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_improc_st(c_st);
+
+	pipeline_composition_size(kcrtc_st, &st->hsize, &st->vsize);
+
+	komeda_component_add_input(&st->base, input, 0);
+	komeda_component_set_output(input, &improc->base, 0);
+
+	return 0;
+}
+
+int komeda_timing_ctrlr_validate(struct komeda_timing_ctrlr *ctrlr,
+				 struct komeda_component_output *input,
+				 struct komeda_crtc_state *kcrtc_st)
+{
+	struct drm_crtc *crtc =3D kcrtc_st->base.crtc;
+	struct komeda_timing_ctrlr_state *st;
+	struct komeda_component_state *c_st;
+
+	c_st =3D komeda_component_get_state_and_set_user(&ctrlr->base,
+			kcrtc_st->base.state, crtc, crtc);
+	if (IS_ERR(c_st))
+		return PTR_ERR(c_st);
+
+	st =3D to_ctrlr_st(c_st);
+
+	komeda_component_add_input(&st->base, input, 0);
+	komeda_component_set_output(input, &ctrlr->base, 0);
+
+	return 0;
+}
+
 int komeda_build_layer_data_flow(struct komeda_layer *layer,
 				 struct komeda_component_output *dflow,
 				 struct komeda_plane_state *kplane_st,
@@ -406,3 +451,30 @@ int komeda_build_layer_data_flow(struct komeda_layer *=
layer,
=20
 	return err;
 }
+
+/* build display output data flow, the data path is:
+ * compiz -> improc -> timing_ctrlr
+ */
+int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
+				   struct komeda_crtc_state *kcrtc_st)
+{
+	struct komeda_pipeline *master =3D kcrtc->master;
+	struct komeda_component_output m_dflow; /* master data flow */
+	int err;
+
+	memset(&m_dflow, 0, sizeof(m_dflow));
+
+	err =3D komeda_compiz_validate(master->compiz, &m_dflow, kcrtc_st, NULL);
+	if (err)
+		return err;
+
+	err =3D komeda_improc_validate(master->improc, &m_dflow, NULL, kcrtc_st);
+	if (err)
+		return err;
+
+	err =3D komeda_timing_ctrlr_validate(master->ctrlr, &m_dflow, kcrtc_st);
+	if (err)
+		return err;
+
+	return 0;
+}
--=20
2.17.1

