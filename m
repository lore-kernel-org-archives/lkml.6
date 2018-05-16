Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeEPKP6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:15:58 -0400
Received: from mail-he1eur01on0117.outbound.protection.outlook.com ([104.47.0.117]:18608
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753213AbeEPKPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:15:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 07/26] drm/bridge: lvds-encoder: provide an owner .odev device
Date: Wed, 16 May 2018 12:14:51 +0200
Message-Id: <20180516101510.13215-8-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180516101510.13215-1-peda@axentia.se>
References: <20180516101510.13215-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0013.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::26) To AM4PR0202MB2772.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:GAThRiuEkO3qdq1jBharXnCf5CVdtxyOZS4wETqloqNuuO9Z4nq7dBbIHz2bA768zI976DFAY3tYwfZEu4IobHoCtKsrt+ptw77ZptOdHokYhTcEM/Ht4MNi5qkXiQFRaetnWoHcd2frlh0iviupgwrklzltI7xkT0o/zyEgqSDCXqYS3sNRhEfSqp+kDVLj9+8b0xbaZ4gvTYCq07h0Xw1H6WPLNNz268HEUclwbDr6Olc1inJsyabkHuWQovi5;25:XSMUAlDqliLuhh1JToaj4rA401unqEnTG3d9Xzsd1wuyXntVoyJR8Fbf9EOHSE8tN+MWJmexBtZLy7K6my/HzNM5EqVRcyFh39Wc8VoSWkYa77CqOz9dY+0aC/CsK9Xh1FNl56DA/Tj8mQeOvFLlJeO+UN6nBcTOxx51iOqwnIxilTblsmsdIsXslnD++MLfeIAHW7ahbE+xDakmExC6voigYmoKUojblFbOIRliZHUrPRS/mGqTSS9fB6q8EynoNV1+waqRHiKGi4cwCZxGsfdmgh98aphb+QirKgO9smIH5l9iPOStIyTJGve4nu5zbuXzRrgb9iGdtUMAM4pB3A==;31:nB7mMETvbqcH5hJPz8/gBvEJTgp/+wbifX57BvRCVjJRfJChQonVkZJJvKC6PW3WFPAoCCjBeCJjg0nwx+Wdl3fCiGzkb4UCL0I2nB5lIlSWGQEto+RG8aeiUqgsnekELsQr3x3NXgC+tV7/VgIfq0ptn8zyl8KYolLPmI34io5vdNlNjoXC7Bijho6UFxdXgEvFg7GDCJgTg2IN5oW5zXCcj/d0zXVshu3p/SWhSfE=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2772C07E502F657236CAC4CBBC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:IJtpo/02iScmRDVwsVWtx/JdjUKp2lc6k+jdxvGd+NHIHhHzlxLbvaz8GeSU/OLHnGUQlvmEZoSsc23xW4bKsBZ70CaJoNvKYVQFj70J4GzHdCpKg1YRrU2+b5UdeFCXO3mfoSK+LbI+kYFZ5vQCHUVzPSbKxQbmJebTR1XmF4/XRITkkcQdfzbrAnnBofX4gYx6Nz2RQ9Ech5WSMDCYrc6wzoVY66XEhlagDiZFUVRaJ4QNWNyCmHjPQZOCcubsm8K2Wml+qiaiS304QZsuGw==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6916009)(74482002)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(5890100001)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:6xvknIGLCaaVbf3bZnQ/z/adFc2NNZfKNR7jq+F?=
 =?us-ascii?Q?JelLpulDXoCbF4qYmrvmI56N2L3XyUx05uTQEkFKyvRVcKHWTZEG+JPs1KHb?=
 =?us-ascii?Q?ow6+PpHdhigNVjtmT8UtxZsw6qVidBG7A56CHKMVelOptR8OmcjH8IsPZng0?=
 =?us-ascii?Q?F34Jjd5gbVvP9hfaTLMLedzjlnOMvVrqCLFpsTF7SqMJZeCbV+oZEaFZYr11?=
 =?us-ascii?Q?tTfx67ZTe2naUfw8GV2Okfawhixkq9u3cdwfNFQ4RtijpdEkwqRGYzeI/q5b?=
 =?us-ascii?Q?mVeG1mGC49F3nQUYTQfBfUmJc9yOZfykcxhMh4/S89pwSsFMDnIfAVygZkHZ?=
 =?us-ascii?Q?V+ofEL8xVNcTSPgEUkGYgu2PvD/bxfrSiD9xx+ApG0/h/IaizKQjzn/9X0/i?=
 =?us-ascii?Q?RIhwh0csi6xrxBxHMTlzqHPD2L6nHl7YolLaLjiZMeWD9Q05OY9e2Z0mJGrX?=
 =?us-ascii?Q?Q92F3M8eYG8WeiXXxm/55adQLXn/aE123lUGsS0CS2i5CPB81TvM6o8WRkoU?=
 =?us-ascii?Q?XlrZts0ZEkBQLdR26kXnw05dLC2Hf/5uslAqu0pDJrBUsjrHLIXUxtBL6//C?=
 =?us-ascii?Q?jzcIU20G4Ulkj6h/HGv4rOiDrrwTrDJUK56iOU4/SLfYDfWzXOu6QZHGEEyJ?=
 =?us-ascii?Q?2OzTLGMmjXOCmB6clGIIEJxNO2qbwQDNOlnLQr/gPG8tbS1mqSyirQt4SlaN?=
 =?us-ascii?Q?nsGNmG9rWs02ZyJMN4P5dYbNVDWyqFoeoJh2VZnpbYkE5+/OJFkqEiVJNJHz?=
 =?us-ascii?Q?uPBkeE2pFTYCoqRrGWrP9rHWV6LaD5N8pJ+Whln7Ydb8FCI1O4RTfPssUwdt?=
 =?us-ascii?Q?WSeINiNQfjICyrxthCO9E48svuwFPsJNH8OD6qHxjX4xWfZLLnWIfRlRbgHR?=
 =?us-ascii?Q?T8KaU1/eZjWkDAfAkrKZ+zlt6z3tN20kSH8Da7vM0+WCUQxbu5oxspLrcxIG?=
 =?us-ascii?Q?1eRa8nwGf7DJ70A0wnywYv2BzLFliwaIumwm21JHYMm3n33Z85CAk4vJoSef?=
 =?us-ascii?Q?/4s3wMfSWDo+Zxf9R/e02gq8pmR/IGslVriaCj0KNL0cphPwiC3piLJnvlfw?=
 =?us-ascii?Q?0q5G4vzFktOQRULwGN7XyV6MssUAABcEOsQ7XONw8gR/F+yzOQ/nm5kvh8U+?=
 =?us-ascii?Q?R3hT5RQe0z4kJ6wx4Vg432c4zk+VBkHKSpeTDD2KE468X4Q+H0k9RgTCKb4X?=
 =?us-ascii?Q?AV5fD67h+G0q3p0LBoKXP4ndUwmW6EVb04anqtcCOL19UMLMdFmHLppUJI+g?=
 =?us-ascii?Q?kDSomk0DYaJKlmAPh0G++T+0dV7F/nCpCaq4WXCeokpl4IUoGwHebuBYASJR?=
 =?us-ascii?Q?LPhoYJ4jqvJz3iZ/Wx7P9qKrNVmJNL2w+Okl+JdCxGjdlAHD5EGyrQOWzEBE?=
 =?us-ascii?Q?y9xDTc3lHdywMns+SXOjkO+mtl5I=3D?=
X-Microsoft-Antispam-Message-Info: HHQ3sCxGuQcYTiCmVQRFItyO7ppD8msnYP+SGoCAmu00JYDGdz7IS4xw953YlDUYMBsFkUA/Q6vb8Q/fDPdlQFVBF+g00b/jirf7DieB6upTGv+C7HMmAIp9LX6FI/oSwcgyKj+P0nQ3GDh9iHk6JNxkgtZuRb21jguFZTcF/wUyV0Ue4MloPF6gS/OQyoZK
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:EccKA3+Bw+H6M9q9zrkqNPCkNY6081wsffKk5helCWjIpcl0Mqv9n6yZg62GhnVL1E/qiSdu3gU6lh3FnMQrOF/Rsc5KMlQV5HZHGaBsDRwHZBzOt2/V4EcDQ/EzA0dqYAm7a8ooqc0sw4TF023QHqs3Ls++KpTpQNHWM1zoE9gBuLJo+1g1PP4vD9aZ96mN/w1L/rYNaMerbL4hfz+lodLa49qvSimzecrQfRntGKWakaZ9LqGNJj/fAyj22sd+Ntmfe+PhMOUsDBziJ6ZAMeYk9F46kuw08IGCAoGdO4tGllOa9Wd56206PppaZ6URSgkT3SIviw8dKBs5Hp0Rg1r5cLwiRJSv8l/tSz0VzumvpeGO7hvjMyIkW91K20zVGbYfx46laR1uMJalgjh92qFDNIsInV53F2OCljMhIHAVA1oEln5f82OOB1qgGViN3Ij9EA3lFQSkTrRK/2rT4w==;5:DKaxpT8BWqe1mRFDpeb2fD7ChXrrRk/3UOIiI26L2lmCN4NyndiuIpknY3tM0arkl2gGfgpA0Un/R4i6BhgOkJWyUOHhWa1o8eqtLb7nd1uZu8f6dH2zkszhaevRIcAlNJLPZSYYVb9EEpnI9WrU7Q53D5px+OrKgDtCvB1RF2k=;24:skZOL4d5OQUNR07/lHdqdojBC+sZivdjEUGf9BXAvXPHPwD3CbWNGpBkx5xisRu/3/U+Tf1lSciz/anKMyXC5BfHZD9Lbd+iSn5tI/y/70k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:YKg+5jqi9RKgFnFrRzDU1tc/f5cwRN91AU1u7rf3z7G/mQFASufC6j0mDSAGLNoT7rZMdV7p8Frvqlayw2FwMa9gtelL6/ANDQ6qqsu9x4r4mmESHYcM2cOo1mzT8h2nYzFzE34fEvjutqVsezZK4hBIQESMM9BxBn4IGVuJ0R7pu80XnraEhr1RlFEzzdS3/a7ZlT0Qv9X/d2altpOQQdy57qODN3NxSwNdw7MyO+xMBd06grx42N7602b8QEK3
X-MS-Office365-Filtering-Correlation-Id: e19d943d-db85-45e4-51f5-08d5bb160037
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:15:50.3928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19d943d-db85-45e4-51f5-08d5bb160037
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/lvds-encoder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lvds-encoder.c b/drivers/gpu/drm/bridge/lvds-encoder.c
index 75b0d3f6e4de..a80eec17b13b 100644
--- a/drivers/gpu/drm/bridge/lvds-encoder.c
+++ b/drivers/gpu/drm/bridge/lvds-encoder.c
@@ -83,7 +83,7 @@ static int lvds_encoder_probe(struct platform_device *pdev)
 	 * but we need a bridge attached to our of_node for our user
 	 * to look up.
 	 */
-	lvds_encoder->bridge.of_node = pdev->dev.of_node;
+	lvds_encoder->bridge.odev = &pdev->dev;
 	lvds_encoder->bridge.funcs = &funcs;
 	drm_bridge_add(&lvds_encoder->bridge);
 
-- 
2.11.0
