Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932294AbeDZWe4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:34:56 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757185AbeDZWdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:33:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 18/24] drm/mediatek: hdmi: provide an .owner device for the bridge
Date: Fri, 27 Apr 2018 00:31:33 +0200
Message-Id: <20180426223139.16740-19-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180426223139.16740-1-peda@axentia.se>
References: <20180426223139.16740-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0366.eurprd05.prod.outlook.com
 (2603:10a6:7:94::25) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:HnDGw9EOKha89THUQXOZmkxj0xJqZBNdyziKjW06EDQ3hdfALSA1ciYbVIi/Sf44/hBPhTceEMiAfKzunY3SFNBI+J/OVoRWzHPtrGDpmzJhpQEF3fRuEvRPcixLusXsw7eRAgWMukjfv9TQLO2KY3dQhqGmT60bUV8MaXvGMeF3KkMGxUCOCwO1Gjde0qJU9ZHXrPgxDknItM9et/zZ4F6PYuKvR4f5SJsoKdqicpcwCPzQJO7YVt7p0FJpu0fl;25:8KDem3AdDIjUxAaGki3BErx6c3R6YbXzc4LO/c6WodiSOlYjnzpblULdc5ItM3Hvd4a3c9UnBOiaLcEq/U2PqJ88iB5YRXAMebrXZrA7Mce8ZRFImULajwd093GoKhLy9zHDmUHXFvRjGu5or6eMa3xUe+MKBAX/3bRYa6tfxX+zEmfLNO5jYc4dYyP8uDtinpMkSPiOu6D7Xrbi5asphzi/uIcd8S867xE3HPBHUTIRz5cOn5h3Mqh7iolq+Q36sg9Lu4fYG/yMf5qBaE3sZGSd8AhCVIv7kEQDRXPE8wGXWXnNR0e7INSLfsNvFTJWjl0tcWqKiRyW8wGqtjiTLA==;31:joeprh6hN6ZUN3x13igVQGByJc4819SlgksKXqkk/+4i5BGuXL9l/7EwqCr98Q8ChaYe69ajsK2cpRVC5YZP0eo/PKwRYFiwO4yO7MmmQgJ/6b6eEHuh1Yvkzjdg0k1Efk997wy1OvCLKqwqlubVYyWBdr2rXhSZSm1VpInakK9yZW0aKF7LdNCP2IEPlRCgt7FFHiWWCBTj+4stJ/NdFQntX4TBQxoHu8UgAu+a7KA=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27821B03087CFB86D82BBD06BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:cu5QqzMHb6F4nrguEEOf0w1On7uo4W8Cg4Ha7m9ux/vz+gqdKnPN3KvK87wjf1zS44TmGvo2Yhz0ffC8BUIdufBhen8v4Nz5+vruH+xnNFtnwj/Cn7Am8+hL5LV95i3bxa85MOFbepOG9t+f9nFZ+zQ93+KRU1GKLHs17i+icOdaQ1Fe/Zlvnvc2BF2jUiB61uWyFlj/4BmCvZEyFm+E+9LsLqlCTvnqJhKDwihOyWkuXajvo+85yK6Qqk6JiPgxo7nxD8asmIdRxBNgXLbGbw==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39840400004)(39380400002)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(2361001)(66066001)(16586007)(6666003)(105586002)(3846002)(7736002)(6916009)(6116002)(36756003)(74482002)(6486002)(48376002)(2351001)(25786009)(8936002)(50226002)(47776003)(81156014)(2906002)(16526019)(1076002)(81166006)(53936002)(11346002)(51416003)(54906003)(68736007)(97736004)(478600001)(446003)(186003)(50466002)(4326008)(476003)(59450400001)(2616005)(86362001)(39060400002)(956004)(8676002)(76176011)(26005)(6512007)(575784001)(486006)(6506007)(52116002)(386003)(305945005)(5660300001)(316002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:Qsos+IuroUJBpUyl/G7TyKik+tdO5y4uVWlDyWp?=
 =?us-ascii?Q?hiiIK/uVODNibl2S4O9hxRg2oHRYLizA/C9YgEWvq/GcFoAS9vzGXMzEzxEx?=
 =?us-ascii?Q?yin+pLsSecxDR7pEjkDOsCbhWDapnhqX7AqEwCvTOv2ZN0k62YWz85s9qGl2?=
 =?us-ascii?Q?7sI/+4oSi3OIFyfmauMq/KqqqJq6Fvx0b2720x2hkcY4ZtYK0DMGIV2+X0q0?=
 =?us-ascii?Q?NtfAuiALFkjyiy2iosYjCBrS2rsOaZm4+fgaE/7Nux7zxIxmPUA2so5AuTmr?=
 =?us-ascii?Q?I7xPqbgS815xuCrt6KlrAV0RQSNcv6xgZK21n3Fg/kQr39GhHL3DJLG7dTu6?=
 =?us-ascii?Q?pUwPeqrD8dl4CoL7kL0yMlWdPtC8aVNG9VQFNd+v4w9+fIjAOM1xswSpUvLV?=
 =?us-ascii?Q?AdoT5unMiduwppF/P53WyDFJ4xxVVIpDy/RF6pBxpdssb+HHl++SkX0ahsr1?=
 =?us-ascii?Q?LkhWk84ymqb+5OVbgmCqGz2ge8EpNfBJNeuyqdm5A1pya1it/hKhiNd6khz5?=
 =?us-ascii?Q?A9LrQ7tm2aIpyw6Ilb/DJIx7EAtuyU2qSkvG3m7+ZbUBmO21o8JkEHC41o1q?=
 =?us-ascii?Q?efl70DGYLAexmnwOOSHG6nzb4n50fp0SOG67HXPuzG8UoAnzNI/Tzxi0eDXm?=
 =?us-ascii?Q?Jbbg/Ex7gQjFWgM4G7tIAz7b/4p3xhHbKdy7L77iVdmpwZdmzIgiugaEqcZJ?=
 =?us-ascii?Q?D1vI7nq8SXxv3B8IYGs7lo6J53A8cVv3B9AFT+HBC5czc46g33Ak7DiW0qhF?=
 =?us-ascii?Q?8JLOS3FElxvZZhtYvk+EmhDwDcDCnmeBEWfx0wiLzTw2cW+fcCZ42XuaJVZu?=
 =?us-ascii?Q?8yDVOGDH2+IwQiyZiliblcOnzCrmzyeZq65Ivj7G02d5GF73231fE025QDzW?=
 =?us-ascii?Q?f4Dap6FNdoPw/DcMLXtnTedH/Hp1Vx1If1FYzE0TvUahU+YcMGkLw5eXj21a?=
 =?us-ascii?Q?I/p/EJcSWCM19eiYMt1/9obf5GMD3bUWwwm4c9ZWD7tlPrGLSLPBsO2Sk1bW?=
 =?us-ascii?Q?wCm8zLAOyXdxX2xl3zJrj++Y3Vs9FA6Mp6hodHGBoTc/W+fkc2bc/Bwb+MI6?=
 =?us-ascii?Q?Dv0rxIOj2jgYQ+FC/uSn2LirakbcXeTpIVTgCC2wmCCjmioLisRMhe1Skgz3?=
 =?us-ascii?Q?dCtUE+0xGSlQ1gm8h/5N2yeFfWcG4bvY3Rp6w+yAlGElyjERwZYfQbjrhrVe?=
 =?us-ascii?Q?Any0sBUC+xcS0DEHqnpUZEMuJO4WzQ7Bmp5n1C1UVjZshqS7UJ5yNv3wDfNb?=
 =?us-ascii?Q?/kHf1xW8Y+sqGOMVm01DJuF6mc2mhYn/XhUeJckdrdUI/K0QPVI4lMs5iwLK?=
 =?us-ascii?Q?wUeIwVZeGVyexIe/gBAeHhOk/M7XS3SFuxDW9gv3RXQSLnyClT+0cMXziC1D?=
 =?us-ascii?Q?0ie89uiHGDW1DxGfqWi6D0UKxZO8i8QQ5uJf4nGyx7zcupWQd?=
X-Microsoft-Antispam-Message-Info: 1uqOciPFIn2+jOTmw+cYQPQe3rsTw7/S9cfu+cFVNzAJBxUzLPW7UrrS16LRpxjIlrk4upt0qG3VoNAUgm5cSfgO3N7ZD3Rd8qDgnk4oeFkZ+DxU453iJe1nQsMf8wh3P7OnP4ePiA5R0No87NhtPW5KCE6BnsqesvEWRIU1Ea5oJ2rcznnjfxVK4h7HgRe1
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:dJhmZBvTaOfrAb8jz7jGy+carjk91fI8knXe0ATBeJZjtEY9i8Zdc5U3hDJrRTr6OmPxcO0hEEHIV5uFmh+1ORwpztwG3eC69GFrC1ktpQahuu2N/If7srppMCszYXNYnRMnPlkeRrtujU3BGMNg4bZQ3+MVDizkuQ5otYEWuq2iHwIokUAExMeoEMujSeMWK+vXZdNfIfy2EMKOITrXrXlO1c5Arlx1f8OnE0N/Zt2h7s3ckWAXq/kh2lFs4o2EeNUxWxhhCz7AkCrd4eklJxbD5/mTa782QZitpyhOkJvxwIVM3TDQeQrStpl/2EffvrrjsyDPTA5+2LzhPYdfMl3XPKUa2xXZ71LpwyPCSH4ge7f8qb2ZK8wTNL/ajdRllSf75tydP8hL5NilttKkr2c9H4zOEzFPst8xZJvZFsf/0nF5BRS3qwW/1kLd7G3iStZNpN++IhNxWeRhjK+tOw==;5:+9QdtiZktluLjEv0xERmzjqehmN0t2jdVpPtyw2Uz9jE3n9nHC0Z9MtZHKkid2ZrcvDIUERj+aqIWrr0W/SoXaju4hv3bIOVikG28IgSMlmQXZiVDh8TdNCP3Mnq++nOsBzUYcztl6mbG1UY5q3UwpDPvfaDeodiqmWq6NBzCnw=;24:nJ4FKLThWlLwSIfbiZlKDzAcxJA6rz/0eYwL4i09ie2WelPbijV/oaw7B+IFJuIFr+AI6PJqZkKnkFlrMpYvPa9HTueHjMi6S48FO9QOZeU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:oPhcInUiy2ZeEtiY8lQfYXDwtbvo9ezBCOdvXw/y/JctCOqhsschTr/d1e1emm3n57tlA70aww9BqHtjH/oXm3Cl4kcHmo3zG67B22Cv4TgpUAWX9TZH2I8ifcdsKbWkYB7qWn2NhxYAPwwmMUasT6NK/ksnkZXmQid8hKbUh+ivJ+hEmmDcdXfDgbCCYHC6witT0S2G/VfMgzChXdwpXH4HYESWCWPJ2m98go6jVCHJsz6EiXYd0WhVKiQNzBw4
X-MS-Office365-Filtering-Correlation-Id: 1e94a86e-3864-45a3-8008-08d5abc5a523
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:50.1985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e94a86e-3864-45a3-8008-08d5abc5a523
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a11026dceb..b4a7908e0cc6 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1694,8 +1694,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 
 	mtk_hdmi_register_audio_driver(dev);
 
+	hdmi->bridge.owner = &pdev->dev;
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
-	hdmi->bridge.of_node = pdev->dev.of_node;
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.11.0
