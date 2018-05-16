Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeEPKQm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 06:16:42 -0400
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:47520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752611AbeEPKQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 06:16:34 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v3 20/26] drm/mediatek: hdmi: provide an owner .odev device for the bridge
Date: Wed, 16 May 2018 12:15:04 +0200
Message-Id: <20180516101510.13215-21-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;3:Jr0IadajyNIky0tGnmjQ/6jXxDF8IZAI4qH/z4FV5LialYkl3AB4yr3kPxt1wnLHoxnGpLqYpAW60qMG317rHyoo8oxU4nUTMoeMRAgjYjQ/oRYQ3Ev9CM83I9TryvYzW/mNIN7bEl6a+8cuoFFhooW/vLmjgjFb+8zh0koSEOJMO3+ZoHcb+8ohBhVwnG0ojFvXnKMp7sZ8AII93+dHv5/zmUWRKoWC8XVeRV7nLGAJkC9rmjf5mIYAAwZ8FNyx;25:Sgs9TLj6nxBbBRfhqLPCo3GlDLICj7fK78WUI85lp2YBp1q6/HEmRGuulQLfogPiHDhXrRWF5dG/KH28Fq037+5+2FhemnOw2zYK0b9MTG8OlnSRcIni7F2I4w//JWSPwEi12B0xHtLrfd4O07TABIuyB3L8DMkFUOA6KEb5AV9VEO0JdCi8TGo/9BS2h5UDHZ10cHuY0HSHnJq7nknWXctOEeV6h2yQA8PSxVxNbJ8zvZRHuzLXD1ei9I9qghJSeZOJCwXbj9V6Z9WyFJej9Sc7/KOuFyVPh0Qms5ju4RplCpYUzIGQkidblcdFwOPAcLlTASiIySxv7STlHp3Azw==;31:7JnNVGqHBBStWPhpstUesTf58t5v213jfFUbou3KM7+3J2Ezmpj3i5YlR+w8gVezeGZu/fsMaPUNm8D/oNzGQ0YuUuuTlDG9UzLueCB9vXLLFdPJ6uf0Vg1ktuHyFgqBMldES7YZsckdNciBp3nEnBFqp+eEUo+ydI65enWMRc4vg6JolVW4mLypn96UcmktgVxXaoEskxnUQgO4Yp75Hx1WCkQdkweM+qUaiUGP9KE=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2772:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27727878DC7AE19F3D656A96BC920@AM4PR0202MB2772.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2772;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2772;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;4:ATmOvUZz9a7A7yh4L5PIrQvYmWoM9FhIf88Ijw91ZeBCqF4UPiTjf0lyQUXZH8MtW9ynoDDMuo/AMc7n7PDC7dE4d15kPvyBGb4Vbx2y+N8vDu2Mb1ID7+sniaWqdzaVvLJxubPJAioXeuR+GuRVHSBJ+tJzDn3xBCStirqYUhWQ4EcrEO5Wu9Ac46dWOWCE8/TAYZdlDYS5FYxvcnabdK2749vTetsazwhVhOueMNmjsQyQF7kn/kDghgbW1j3tQkZ8+XrWIeNWtkvHWNP0EQ==
X-Forefront-PRVS: 0674DC6DD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(376002)(39840400004)(366004)(189003)(199004)(86362001)(7416002)(25786009)(48376002)(50466002)(68736007)(36756003)(2906002)(105586002)(97736004)(6666003)(6916009)(74482002)(2351001)(3846002)(6116002)(575784001)(1076002)(478600001)(106356001)(316002)(16586007)(2361001)(7736002)(50226002)(53936002)(6512007)(305945005)(51416003)(8936002)(52116002)(8676002)(16526019)(76176011)(446003)(66066001)(5660300001)(39060400002)(54906003)(47776003)(81156014)(476003)(2616005)(956004)(81166006)(186003)(386003)(6506007)(26005)(59450400001)(4326008)(11346002)(486006)(6486002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2772;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0202MB2772;23:B1jMLzsmam1Gx8ooHJr8FAW3OSLVdbp5jDVcxNv?=
 =?us-ascii?Q?Et87ImLbTV0CUaCMDEdPNgGJ/OINUetJp0a54FT3y9TwP10DsRVcUvCZ4fB/?=
 =?us-ascii?Q?KZ6dfDpUT8ilgSUcZxJ9Ua0DVExC0M3cm78Age//KMy40A+GJD7xTNNTtEk9?=
 =?us-ascii?Q?Fgs1nwvF76gah4pRGN7mLxZMyMFW7jAJ/mYcwcXXWmRLa3kTqztRj4C+OI6u?=
 =?us-ascii?Q?BvrpZknh1zeNxgnHlaFFFBo+3YEjSwI7H6jdu1epSolXEeoZJx1YNZX/WaXM?=
 =?us-ascii?Q?PRoBh1tbr1eGcxpuW0PNoF1F6dSHpNGZlsYq34ybenti+4343oTfqJHx3Qk/?=
 =?us-ascii?Q?ce6qf9AK5PVaELiUAwb2qqBqRUHPBUmMsNQpua+uKGYw5E3bM9o26gG4fZ9m?=
 =?us-ascii?Q?4ZEL4BJF+Bo7k6q587feHeACdiEWnszYsGpaUwqArbDcJU/g5HAXESECy+X2?=
 =?us-ascii?Q?fxGCUX9kdehyVG99OU7PvcooEm7416pK7aU7T6IC6KjYyHVEyobWJnxlChYO?=
 =?us-ascii?Q?Cx+gkYYN8uh6QBo2/Ieuu29dLzOuYBfZGJkS8+3/ItNDYFOccu0z1AjbynpV?=
 =?us-ascii?Q?W7cSAAitY9qssGs7/07tvxH40Oc8VHEMBUDgDH8P9jzvIxBAm6a3sMIxlvIT?=
 =?us-ascii?Q?R7RqM6YjWSJXz+4475HbdCOA1nIHCleYAaE4m5E5gwTzw8RRMTxq+YMJbqHe?=
 =?us-ascii?Q?oWNExs7Mf0WQBSY1kZcXZ+ehM5z07OXvYgSz6LSm57NhvHe04EwvMESjBDu5?=
 =?us-ascii?Q?1JzenlHYuUnutRqer2cNk/Hbkbzsr88b0Om2LzYf8AfWE7TPui1Y3xv1dIpf?=
 =?us-ascii?Q?vO3U3v9MQ0FAzIgJqyaaSsoPxEfdZNDUMdA0o+5m23YHA4lac0QY8wcPCQZV?=
 =?us-ascii?Q?Mjg3nhXLG35QoBnFWUYyGLiFEs/bYLj09vOH4WI6StwsU9fytoSWJsI5ofMS?=
 =?us-ascii?Q?iqGlXwaC3zIhj4XQU3b7orSm7g+iD8PDYNNSYdY5CBNBC+JB1F+LRlLcqBLM?=
 =?us-ascii?Q?G4gQSNFyMrbQbOlUyM1hleJD5f2gHtATjGaOTYuV3L4+Zg7kn6jgsgYPA4g9?=
 =?us-ascii?Q?34f4sxOhBWNPytAHlRVXlGmTpwi2WTB3oLr4kccRXjtQjiosGMlHphrk2F49?=
 =?us-ascii?Q?l2c5D0Apxukq/9EmpzBNPy8eQw8wRh6xOyTqi6U2iU0ySe7Mm1qZhfyexPJb?=
 =?us-ascii?Q?91DbjsQ/sthml4XLtSV3Djw+lID+9ca2ALqLNrtWphLs1beIJTaTrDlqvi+E?=
 =?us-ascii?Q?m3hrKRgsPz6c1OBQmlFuooYUpcub/fRSRf7c5pA8X+8QzMAT0106EgabV91i?=
 =?us-ascii?Q?Xa/fv6YZJPx+00IWm9YclsUXy88KylaOnBX/oPJkwS+ABOPma2hNaiHIDxD+?=
 =?us-ascii?Q?UhY6qTUSsR30JkK/zjnzENyyLU4xM6FWF2seCSOKUJVBIeT+hyPijhBJ1fDQ?=
 =?us-ascii?Q?ltrR57veYug=3D=3D?=
X-Microsoft-Antispam-Message-Info: rtLOwDeJRVaD/Gd0MQtd36NOKwScEPz1xziQi0Vp27hBHuLutVP20G4Yah/ONPZ4172+5SplKV/HsejWQMPuDWXjDqa/N4rhk54CTsC9M3xC92N7b7DuhE5N++y2POy5OE5Xmv1bkfSSfsD6bS7VRJtyFcVUqn8Pbw8mjqtk0bLVBTdBQjoC0XBYVwuSuMw/
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;6:/LqW8rYDyjzIey9Hx/kYd4iqXIHnL0gjGMBHb5o/9xFtlOZTS9zd3v/m6QQEDGp9EinBPpjq2v9ykw1MGt3SacibMxyEGBeTca/XXZG+r/Ywhy6ngftCCIh1snBQhFnzSZ+09ukN3bCfKds46ElWdhQ5X2JUGj2a0U0soFzL61iKMa2ikgQb19sTAxs4a/RT3P90i5EqAmxGOBybWP5JcvcEg98NpTof3b2+feHBEstg4VT043yaAtMRr2AZc3sjxlNN4a82Vw1/ct8FcVDE2VeD8Y4tQY48IGCHnI+gViKc6k7n90lCe+jn9zSIDdE010uo3c1d3iGzj9KgGmBNqx2KUz+wnjz3HorIIbY/GDAUfHqb/QcJUHXT6z7Eovp+jkLMr42Velh4yZtNXkQE4cIIV42qZXpDvqyu3RcaQKHyB96SP/DoK51y8Kg9nNO5de6VVqm4YAQ+JTAepWET7Q==;5:6r9yFt6yWUwij72fB26aJQg0J3y9bG+jJdhGRC45lul0VFdiyWyOMU44d7H65bN+3eRExau6b6/1XYYlq2ur0OsToRDoikrtrI2kXY/yMOGJe3B24rsqZf5khn0QLaFfhZEB5krFUPOkfvMcDCsM7M/FROQd7a+BJbnH5S1cJiw=;24:RGIENSxwP5gMtbLc72wxensVfpgU0rCi4Nxl4Xkva9UV7BcPzLmiKMZ3Y6rClogZOwVm1tkDKBud8O50t7HJGnMepBrd3y5AzpdwGV4RWCg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2772;7:olX7+NJXeIZsOQ6L7h8D1b4ZDnZgb7vqA3Id262fKw/8BfBYvcyep49Ex41xHtrc101GwDh1B5mAeW52ETKnDM9oAOMKcV72GA0fXlzezQamsaUq8BDL9KN1jI0ZGIvzuWoV3Db680CIswUJSq05XG85CvDU3/lrjWmDNHz8yo4IoUkGHnzeaHdS5qpb4I3IbXDuUBUJO9l86NkvTlDMzMph5p3MwSB+u3FScERplxJj2plRKcHyXGwnOglmS7S4
X-MS-Office365-Filtering-Correlation-Id: db17df66-7ff3-4c34-3658-08d5bb161867
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2018 10:16:30.8609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db17df66-7ff3-4c34-3658-08d5bb161867
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2772
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 59a11026dceb..d8c7d93d0a87 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1694,8 +1694,8 @@ static int mtk_drm_hdmi_probe(struct platform_device *pdev)
 
 	mtk_hdmi_register_audio_driver(dev);
 
+	hdmi->bridge.odev = &pdev->dev;
 	hdmi->bridge.funcs = &mtk_hdmi_bridge_funcs;
-	hdmi->bridge.of_node = pdev->dev.of_node;
 	drm_bridge_add(&hdmi->bridge);
 
 	ret = mtk_hdmi_clk_enable_audio(hdmi);
-- 
2.11.0
