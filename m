Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932320AbeDZWfi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:35:38 -0400
Received: from mail-he1eur01on0132.outbound.protection.outlook.com ([104.47.0.132]:61408
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754968AbeDZWcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:32:50 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Jernej Skrabec <jernej.skrabec@siol.net>, Jyri Sarha <jsarha@ti.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/24] drm/bridge: synopsys: provide an .owner device for the bridges
Date: Fri, 27 Apr 2018 00:31:29 +0200
Message-Id: <20180426223139.16740-15-peda@axentia.se>
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
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:IhXFWhWGy3Ir7OkXlFxzIFumEDu+rhQoG9ovKvs4IxGnOrrii8yntxyQo3PiQ1QAm+9oGpoRkiCbPwD05weFn7AMQ1WjLqcDIlcCpdN/2LP0VFw0iQ3bSUgWAkLgFEFC2oYpqVM5QrEUsURdfCwcsTMe8uChtChVedrrJHkbGnOeQ2P0X06Rz4M24zoyTxwz3+B2owPCmjxmEsE2KrxxqkFUq2COZnqu1uMtseeJ8RAzb5mmaNNBksQjH3lo1sCS;25:4Docm16BCx0JlmplCrs2fIdYEV3xtfOsgXzZkZc5I//Eku4gp/+EMTpySeXIllBP4pDI44y8nivkcdDZUNaF+sJ19xL46+c0PWrYFXnDfGbQgIVizLfverfWC3nQP2DPuRFdXYEcuHdbANUm2BRoRzsy760asbSi5vLcrMDZJUa7fd9GcnhH0rg+4BINXvfXmAgqA/qr5kkIYwx4LQV7lh385rOjIKcPLFFjKtZDavU4LQhmeH0+WO1QodltTUWaVUN6dd1EgaSZ9IwT3ViyGbSs2ka4sHfOdY39gSMeFkoqTt+zpej2Rg/N5TIMoLbeyMmWlQwmeDb30G6pdo4B/g==;31:curubrCTIZ9KGSJzCeiwhWT4xuiOCxPzCIC1I5mVN9a2cpHBgpP9pgu7tEbX1Eh0cQtLf9OYqnipyTM43koUBPODsLUFxpAqyx+1l/zTFndRqIVXZjqDU9v5NSfCqscOxvvSzsNTr/0THsPwerJjISnos21V78lmGer4v0tCMuDck4kIK39jkTaXhmkVoj2KblAVcaa2anLIgK4Xy+SpXv2CDFK5w6kN5DOuM+/P/p8=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB27822E0C32E79DABC1097650BC8E0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:t+DWOgTb9ikw6zZMb9exxtlSstAZsN9/a/pAsfSzgtCoHpbz/AjwVmPfP2O8ehCBE/jrWVXQ5q0K3HelV8tYYNoAJ6HT1NJf9CPwhDfOQCS4eOZSgYcixkaOvlsCMvVhSYpatz/sEYkoqzIocoKX6CEy1n5dccd3jxJJaXZG9HFzkWmuZYmBWewTImbK02iPYBpHtYtDaP3iH92fTShunlsjQm0oI9QQbGMJVjbDtJFDVhRyIq22RcACBJfQ8i5KZxpSiV+UywdZcphwAThYHQ==
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(366004)(39380400002)(39840400004)(199004)(189003)(50466002)(186003)(446003)(86362001)(956004)(8676002)(4326008)(476003)(2616005)(54906003)(11346002)(51416003)(53936002)(478600001)(68736007)(97736004)(305945005)(5660300001)(316002)(386003)(52116002)(6512007)(76176011)(26005)(7416002)(6506007)(486006)(3846002)(6916009)(6116002)(7736002)(6666003)(66066001)(106356001)(2361001)(16586007)(105586002)(81156014)(8936002)(50226002)(47776003)(81166006)(2906002)(16526019)(1076002)(74482002)(6486002)(36756003)(25786009)(2351001)(48376002)(142923001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0202MB2782;23:IOb1AaOZXHq1KHS/Ay6Oy3oucI7I344j9vBVt4u?=
 =?us-ascii?Q?lxbYEpURtc8nko9+ZIss9oVbZrD9Aryy2riqshWNfuL8bpuO6OTU71ir/ABw?=
 =?us-ascii?Q?0Ab1/iO5eIYfk8ZCch9m75TZWqUixdcGEQRxgMJx6NxYiv7hiKvjhq7p1Qpv?=
 =?us-ascii?Q?HMcs0KPKMP377d6aIzZ6jpIl5q4xdkJrirucf4PAJUy2sWO3HbmLlxF0geVP?=
 =?us-ascii?Q?oQevO9EADtzRDo5adjp/TihyGWYeKjwbFrg+NvUMCpWpIqNNsJkRLSh1Xs5Y?=
 =?us-ascii?Q?O8dQiHIaz2EcaKE5r+1uaDp8zW5quo62hYDDHUtUOiMytRMHJV9NhzpKpai/?=
 =?us-ascii?Q?GelRr/vcIuE8oo862AdIYCNUyZEaBspmiRKROegOZMtCLdvjKVAyGyXei5/m?=
 =?us-ascii?Q?6mVD881+fDo9xmV2+yuvJuEKSZhO2LCTYWpGB4XQUt2CLDT9W3HtpviD81tn?=
 =?us-ascii?Q?DTldRBiUlBk0fZli76nE41hPcG7G3vyCvK3bNpQcVUMPgJG6RtggXx1qYqNM?=
 =?us-ascii?Q?Da9qGN6FZ7Z7Fgr4QPjL44M4LNEHq6mgx7QmvXbPj46fAyZV/OfDT1Ejytr8?=
 =?us-ascii?Q?3Sy+J1NjUFGrvGzvtcpqGjBXjVcC06+HTog4HExyzPokuDM6Lq6UQqBNJiPn?=
 =?us-ascii?Q?uFlAb7FwDwooN71xJjp8VyY+QAYRP9a1tZ+TjzjnmzlvA+/7TcdZr6GeGG5M?=
 =?us-ascii?Q?v2jLdWa2lHS7aa9EZ5gzOY4ZgOKg62SQVqaZ8geLeG/tGrXe8IVET+bHpK93?=
 =?us-ascii?Q?O0+xRuHtRfenP9+mB+0lrnK+/ougV9DElw05xbQn9jN7TS2Ffgir9kQ41rCW?=
 =?us-ascii?Q?zo9aKpecPGgOLO4OzGnNzU46g5D8dH4FUoszlEuwyJuDSBPvGFZ6DjZUK/Ji?=
 =?us-ascii?Q?736H/wf9kr+3SlT4jwjJrdaz222CZx6qv8w4HPbWTUt6R0gs3aLs/DpvbCyJ?=
 =?us-ascii?Q?pMpIE25vAmsc1SanNJvchM4Ul9ZSkMbJsVkQB2cHgW4a0OhNQ86pxrq8Ocw8?=
 =?us-ascii?Q?tC1ggBiREkDjFrF1hqp1DBHm8EW6U1UHzhmJdz1b0pGhvDSPXhD9DxVs96Be?=
 =?us-ascii?Q?gFHtwfySyBH9VhdLLV3Xby0pxSfh9zyfXeucchC5v/jsFfCUxKIR2yZpqIHG?=
 =?us-ascii?Q?EHg4YsqnmCEc8NKdGv/DksuJ69bzWPRL5qndMUZSfEn17XClp/VpNpXTuSFt?=
 =?us-ascii?Q?RO6tzhySUs4+HtoHITC6vsSgxEGPfKhA1rdRlehfeadRxyCO8sQhuW5WYqjG?=
 =?us-ascii?Q?qtCQbJJ8AaHNzKTr5v2z+A6vtd2w8h4WjkQJiXhlSL55jKwTP41seIdUSqQI?=
 =?us-ascii?Q?wSchtqriid4X/OQ2k+yfAuJXgXvS3IC1Y6N03jDBwcxgo?=
X-Microsoft-Antispam-Message-Info: 9Dng+U2gcki9RhzsO50fKaeIqGNst5xu3eAgOodsoX7qdH4TwUtPzHL+0VvygFVoKSFj8/Dp/SW2Uvc/4hvUQWLfJyk9UEtdW5DpyuXz1jcpjz+0r7ZDdNkb4Ogsjcqcy8wZbdKfUvphNqqGYjLB9d7N53SE9p9UooHBAdwe8I8TZmldhug6FJICvQyxzuuB
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:4Dwapr0Qgm0e4sHRa9zoNCRCBZCf1L7JWWjjsbPP2sg84agw1R/Yx+R7tSxexK3lOJ88Rc2Bv2bJpfoVZhNVfJnzvAvUY+l3jAdMBQr9Ldoxi15Jc40QSPyAaJDjqBzxcZUl3QBCNeTI84/ppGM0Km6yF90WkEy9ELHzG5x2COPmsVZjSmkkvPpIEXHrjm5ewJ3ModK+jINx3beImBVnZsqsQjugXaHHBzFfe9vHmp/sSA7g0CD8W3uTwxkM9ZE08q8mCtaGcKIlnA81LoOO7i7gAsPbkBlDitUiAZZ47x47Ed4HZA1iBZq7Vogy/YGIaAvv79HkG/frxxFyV7qK1CQupgKrUOyw14mvIrkPnuzUS9TBaklDfNOrKJNBbZYOwhTOZC8W1+m0d0KNOUOvFO9S77eUjSIRJnz8OA+mxFB9aN3xUH7jHNEuQ2snKaXSCwrLEBXn1atnWCs7INqL7g==;5:r+bWSa2cU+p/wwJDVeuupAKsL5RCc0U5toqGoQa/niDegjfbZKSP+cSRMTKUHkNaGOz7Zx3ZqjijKojKeXHQESPjXMPJ1/S32rcSoiNJTf3MWN6V7yYPsNzoaZT/RR6AhyQj/gdZrju0CcxpidYQUXCPwoFvZ4BmeuYn58C0ON8=;24:a0kNQGvl0bRchG1LS/SpMw28r4f2ZAXzoEeT8YazSLy8FaHYnamZnZAgRlXr/qaeAjJgzy5xqv6Wv2Mo16/D6/9x7aMzWb8R+O37eOx/tMI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:2+2o2/mRfOsLWM/G+NWLpQb3MVPL3E1HeVHOXENPxe0GksLs/Px4xahv/NAauButcDPyfs//a+MmhvGTQ6z/gfrLVZ615RbwzEPj6vvwMuhQU2PKrLWiPKSG/LFLiehwBPObjgJiDwvNYS77ifXZUg7WHoTkiv/VnSMePqQ2kjv4HJLI6fGIX3/75Re9Ylmx9RWCFz69AKo39iazZj+ZqLuMtbv66KLyPlXCdnYfrr0Iovb0sLoP/Nf21/M3Y/Aj
X-MS-Office365-Filtering-Correlation-Id: 0b426e8c-ce72-473f-a7b7-08d5abc59f7e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 22:32:40.5890 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b426e8c-ce72-473f-a7b7-08d5abc59f7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It gets rid of two #ifdefs and the .of_node member is going away.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c     | 4 +---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index ec8d0006ef7c..48ad6888c967 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2471,11 +2471,9 @@ __dw_hdmi_probe(struct platform_device *pdev,
 			hdmi->ddc = NULL;
 	}
 
+	hdmi->bridge.owner = dev;
 	hdmi->bridge.driver_private = hdmi;
 	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
-#ifdef CONFIG_OF
-	hdmi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	dw_hdmi_setup_i2c(hdmi);
 	if (hdmi->phy.ops->setup_hpd)
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 226171a3ece1..91e2cc3da90a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -934,11 +934,9 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 		return ERR_PTR(ret);
 	}
 
+	dsi->bridge.owner = dev;
 	dsi->bridge.driver_private = dsi;
 	dsi->bridge.funcs = &dw_mipi_dsi_bridge_funcs;
-#ifdef CONFIG_OF
-	dsi->bridge.of_node = pdev->dev.of_node;
-#endif
 
 	return dsi;
 }
-- 
2.11.0
