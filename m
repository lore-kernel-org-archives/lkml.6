Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941ABC5AE5E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCD920652
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 23:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="sTRidzAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730122AbfARXLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 18:11:43 -0500
Received: from mail-eopbgr10125.outbound.protection.outlook.com ([40.107.1.125]:55773
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729847AbfARXLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 18:11:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CVF4AGDPcSuX9U/YUHkUaZ2xyyIHZO3EuhJdOj53Up8=;
 b=sTRidzAjMfqn4cZrX1Z9qjyLsMRV3HK+pcdI/y93D06mJZkGaHlm43MwGiwat1p5QYhdFRcfQ9n+nKc0/kTX7uP+Rz4+zh+dX9zSRTlNb+y98TyiC2cEN32x8RGaRRl2J+J4cLeryi/G+BberLNGFMV/qusGg0dF1qU8EHodBfw=
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com (20.177.191.218) by
 AM6PR02MB3767.eurprd02.prod.outlook.com (52.134.113.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.26; Fri, 18 Jan 2019 23:11:38 +0000
Received: from AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453]) by AM6PR02MB4470.eurprd02.prod.outlook.com
 ([fe80::e5f3:a239:2ec4:4453%6]) with mapi id 15.20.1537.018; Fri, 18 Jan 2019
 23:11:38 +0000
From:   Peter Rosin <peda@axentia.se>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Rosin <peda@axentia.se>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: [PATCH] drm/bridge: lvds-encoder: remove surplus NULL checks
Thread-Topic: [PATCH] drm/bridge: lvds-encoder: remove surplus NULL checks
Thread-Index: AQHUr4Mq4Jg55lDhA0SXDBbXaZHCFw==
Date:   Fri, 18 Jan 2019 23:11:38 +0000
Message-ID: <20190118231129.8281-1-peda@axentia.se>
References: <be258481-b3e4-8051-abb2-ca430ecc2836@samsung.com>
In-Reply-To: <be258481-b3e4-8051-abb2-ca430ecc2836@samsung.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.11.0
x-originating-ip: [85.226.244.23]
x-clientproxiedby: HE1PR05CA0200.eurprd05.prod.outlook.com
 (2603:10a6:3:f9::24) To AM6PR02MB4470.eurprd02.prod.outlook.com
 (2603:10a6:20b:60::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR02MB3767;6:s3Sgay6tPliM1+sUKusdRt/OwYFU5rGjsNUhWiWr8ao9mm8LDjUdkxbxoo/23xNjlC1yiKYNK5PdBJeFytfLBQEfB+yigDIwYHgEeM1UT07Cp7IobODBan+g26/hJFmhwCypY3HM+/Kz6rhwqERHbNvwCX/yY8sd/An1Xwoy7yx2TT41OXUJ/ddKbbsNTwEeALAyMY8q5yjASktf7DyNGlfWpeLrBXn4PG5brF1MUCkuo3BPr/1lU5mr0w1uI83WkFiFLwBvnoVq6xRedOr+3SvUPzMBGv4ddGL2NJpg31MMHQfReHMUJEsR409aKk3zJJEKE2SJzw+Qyiw6VXF/l3fWasvgGBKZTjQtNjxN8ErQfS0B6hIhKaajqRgWFAOIw9ydu395+bin2Y6AzkV8C4gEw8TSK2+Fi9hHLHaTJj40ZZG8FQUXIhLAad0BYpJ9Ieib1XqpoRw0gQU4XcAzTg==;5:X4jagrAw6HKU0FSx3qydrLRIyZ/OpqYd7g9Dg93KbYmGqTTmrWTPjOat6gG+bx1lAepu19tJgQFLTWjzQoop+bdGceD9JZEn4DSpM20Wo+2xRm8411eVQXOb4ABY7NGXcNfOJ9TRlGWxpQwYDsiEFXB6PiWhs+oWMoW1diTAQi1rbGBl5yf/ITsgj2L9sYouYF6S3Q0mEIQXDeQpEOkPrA==;7:zDMltorczdSHzigEMXdogbL5a7k3Bp2bi3F8S5f9Ex5/IQ05/sUXoV+wR11GKaO/aBkpw1aHm8anpjv+kIR3lopDCSPRKx25DaPof8ohAc0J9Sld06+hnXURf6hlBxQBRZJAOHKYFk55An1psuzDgw==
x-ms-office365-filtering-correlation-id: 1ab2840f-9807-40e7-1c40-08d67d9a4c81
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR02MB3767;
x-ms-traffictypediagnostic: AM6PR02MB3767:
x-microsoft-antispam-prvs: <AM6PR02MB376789F6AAB3D5634F7D7199BC9C0@AM6PR02MB3767.eurprd02.prod.outlook.com>
x-forefront-prvs: 0921D55E4F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39830400003)(346002)(396003)(376002)(136003)(366004)(199004)(189003)(6512007)(52116002)(102836004)(105586002)(106356001)(36756003)(3846002)(76176011)(6486002)(6116002)(5640700003)(50226002)(8936002)(186003)(25786009)(8676002)(66066001)(6436002)(81166006)(508600001)(6916009)(97736004)(81156014)(14454004)(1076003)(71200400001)(71190400001)(486006)(2906002)(2351001)(476003)(26005)(54906003)(386003)(53936002)(2501003)(4326008)(316002)(11346002)(6506007)(68736007)(7736002)(446003)(256004)(74482002)(305945005)(2616005)(99286004)(86362001)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR02MB3767;H:AM6PR02MB4470.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JRQgyQXFbMEonX+nm+NLmF+99s6o0yD9Dbr2R18Sk/xmCZeGxm5GdzwKAn/LKT0bHsAq0x2r6xsdtxZlO4rG0kUfWMxptRrQftI0tWnkSceLvZypxEJnVLTxhzwtnZ2XRJBlVazCCkxI+nhc8SzbhiDU0R1/5/ps9h9CEbxvlfZ+CXeknip6SB6nGW8G81Uu2pcSuTWUFcKwD5GAXgXL6jc8vkRptxt8dRGcJlQaBsj19HC4Ct9pR9iJOhvHLvexD9HTg2t2bZXaiVyfivaPpfHMXAyQOnQgNPfacOXYki8/xWC7BispJAyZhTBcdl4OqdU4BbtNyhjn1jW4TkT9rgQSgZ2RVexp6IcIeo0+Z1U2kTgZnPlwwZ7QmFksC2/HCSvdMRK6TmO4KCWmu7yhS2BJxyTkdWTiWWhmeyaZz1g=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab2840f-9807-40e7-1c40-08d67d9a4c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2019 23:11:37.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR02MB3767
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gpio API explicitly allows skipping the NULL check, precisely to
allow for neat support for optional gpios. Which is exactly what is at
play here.

Reported-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge=
/lvds-encoder.c
index 36d8557bc097..584007eaf6e1 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -36,8 +36,7 @@ static void lvds_encoder_enable(struct drm_bridge *bridge=
)
 							 struct lvds_encoder,
 							 bridge);
=20
-	if (lvds_encoder->powerdown_gpio)
-		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
+	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 0);
 }
=20
 static void lvds_encoder_disable(struct drm_bridge *bridge)
@@ -46,8 +45,7 @@ static void lvds_encoder_disable(struct drm_bridge *bridg=
e)
 							 struct lvds_encoder,
 							 bridge);
=20
-	if (lvds_encoder->powerdown_gpio)
-		gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
+	gpiod_set_value_cansleep(lvds_encoder->powerdown_gpio, 1);
 }
=20
 static struct drm_bridge_funcs funcs =3D {
--=20
2.11.0

