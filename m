Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B26CB217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 09:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="EX7zTlVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbeLXJ05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 04:26:57 -0500
Received: from mail-eopbgr150072.outbound.protection.outlook.com ([40.107.15.72]:37508
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbeLXJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 04:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwLSdmP+OIGkn9Z5nqrWiY+/fj4Mo10HDhk1STPjU1I=;
 b=EX7zTlVnsCwQSpiDdSAnwJH6UFXSrWpsfaO7sBcH08TmHg+HKd+BxD+5BwOXTpesVsqLQrDyFiCA3RhivWx1Gr9EiyvAnSF+pXk48ZOl4Oh/3/P/DusbqIvz4JEI6jKohkXSBMRqScngQogtP5nVAQ2hMdas0/RJ5nCS6+Tnm+8=
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com (10.163.188.149) by
 AM3PR08MB0262.eurprd08.prod.outlook.com (10.161.35.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1446.23; Mon, 24 Dec 2018 09:26:53 +0000
Received: from AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d]) by AM3PR08MB0611.eurprd08.prod.outlook.com
 ([fe80::3c73:534c:9c6e:352d%2]) with mapi id 15.20.1446.026; Mon, 24 Dec 2018
 09:26:53 +0000
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
Subject: [PATCH 09/11] drm/komeda: Add komeda_kms_check
Thread-Topic: [PATCH 09/11] drm/komeda: Add komeda_kms_check
Thread-Index: AQHUm2rONVL1eL96PEKP9cqW77BNYg==
Date:   Mon, 24 Dec 2018 09:26:53 +0000
Message-ID: <20181224092435.2792-10-james.qian.wang@arm.com>
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
x-microsoft-exchange-diagnostics: 1;AM3PR08MB0262;6:6+ubTd1WDFlwQ0SMYGiv/bh2jyOjTSnR8d7mMXZJEYTnIPU3RDSbu71nUd6dIOnduN/mDeuIT7L4HBJxRHl3WkJzBVGpM+YQ/vL7/kHdmhoOOpKCapuydXjPqur/qvjKpxPJclgR59eXzfYKbShJSb5ApBO9kLGV+n4tTDhpojkzJj1o9SQ/JDIjjaqmnzcNL/eQyeHJh4z+9OejlfFUANdlg4EgbxhePDxS3OrsomgKpi7NgAQzBb4tJafA2RkfZ2vKkOCPRC5fYrrjDWb21QJ17jBUPoKxxYvyIrS/iryarRb1ah60VrrMEawsersLxRs+6GWIrbDdMlTCnpk6oza4JPk/T2O+wB6K/V+/+s97BO0gUWTfJV9q+NhngcrZSE5nKeUXFBEpZMMngQLaZgJTIT458pQmaNAuFvUl/SEH8s2otrdxtYBuR/2GzkJc8TKMbKT9tF6ndRaf5bqTKQ==;5:unW8oDEXM6XMwpao4eysx+BIzOPuf+DIvonJO0et4QB6VIdzKfjr1oBoOy9+mLdh8KA0rUsOyciL3tyg3StAhwB+vtU+DQrVn5lYkCSkYOYJP8nMviwsW+R88pgKF8aGFn+rC9xsMbcsc1gzRT6I4xm8uC35q50ldWdN25V4CDo=;7:lBXh3Bb6PQWHgpIUclzLuRca2myJph+X4bdh92z34qhhQr1jLE7fY8UwCMI2r26NYisRuLSzdjzMrbGvaoXd7mBKLE4eqDOAqfxiOB3xPB3oE9dY4bPByh8QEM8c3DWk2Lz8PX0f88TjWuJG6+T//g==
x-ms-office365-filtering-correlation-id: 9cfa1223-36ca-45b1-7179-08d66981f0b2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM3PR08MB0262;
x-ms-traffictypediagnostic: AM3PR08MB0262:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM3PR08MB0262A1558D9BDF723877FB32B3BB0@AM3PR08MB0262.eurprd08.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:AM3PR08MB0262;BCL:0;PCL:0;RULEID:;SRVR:AM3PR08MB0262;
x-forefront-prvs: 0896BFCE6C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39850400004)(346002)(199004)(189003)(4326008)(256004)(305945005)(53936002)(6862004)(71190400001)(71200400001)(486006)(7736002)(97736004)(446003)(2906002)(52116002)(6116002)(76176011)(1076003)(6436002)(86362001)(6512007)(5660300001)(11346002)(186003)(26005)(68736007)(3846002)(2616005)(476003)(55236004)(386003)(102836004)(14444005)(6506007)(25786009)(103116003)(14454004)(105586002)(99286004)(54906003)(37006003)(6486002)(106356001)(316002)(8676002)(81166006)(81156014)(8936002)(6636002)(36756003)(478600001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM3PR08MB0262;H:AM3PR08MB0611.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nGs7zlEikI9NIVrR3I88DIWPhGcGhCDvVCF8hux7rSr8JEVaHHzHMCs1wahqWzbA+5XdBcNMeLgU8xG70LNLZBqVJodKlHr0jm75M5V1pvBhc+eT1rmtGXQIUj+GWPEAkxWNJlLeqkZhzjiSg2bYb2VKaU6t7x7hoo0jWqJxw8PwKjA8wEDwTx+V7i8MeKhUQW9ytDIqL50YUJaToMIbXkXmCB6dnmIxagHIHzWM3XH0/2UOlaj1tUZE5Q3zyJm6WTmuSgsiWlZoMNSnBcA4gKRqMERwW6jKYZSHhmNM5FSAqY3o1yH3bxLp4GrQzl/U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfa1223-36ca-45b1-7179-08d66981f0b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2018 09:26:53.3010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR08MB0262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement komeda_kms_check to add all affected_planes (even unchanged) to
drm_atomic_state. since komeda need to re-calculate the resources
assumption in every commit.

Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>
---
 .../gpu/drm/arm/display/komeda/komeda_kms.c   | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c b/drivers/gpu/=
drm/arm/display/komeda/komeda_kms.c
index 210e5c05bf49..ae97db7e447e 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.c
@@ -95,9 +95,37 @@ static const struct drm_mode_config_helper_funcs komeda_=
mode_config_helpers =3D {
 	.atomic_commit_tail =3D komeda_kms_commit_tail,
 };
=20
+static int komeda_kms_check(struct drm_device *dev,
+			    struct drm_atomic_state *state)
+{
+	struct drm_crtc *crtc;
+	struct drm_crtc_state *old_crtc_st, *new_crtc_st;
+	int i, err;
+
+	err =3D drm_atomic_helper_check_modeset(dev, state);
+	if (err)
+		return err;
+
+	/* komeda need to re-calculate resource assumption in every commit
+	 * so need to add all affected_planes (even unchanged) to
+	 * drm_atomic_state.
+	 */
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_st, new_crtc_st, i) {
+		err =3D drm_atomic_add_affected_planes(state, crtc);
+		if (err)
+			return err;
+	}
+
+	err =3D drm_atomic_helper_check_planes(dev, state);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static const struct drm_mode_config_funcs komeda_mode_config_funcs =3D {
 	.fb_create		=3D komeda_fb_create,
-	.atomic_check		=3D NULL,/*komeda_kms_check*/
+	.atomic_check		=3D komeda_kms_check,
 	.atomic_commit		=3D drm_atomic_helper_commit,
 };
=20
--=20
2.17.1

