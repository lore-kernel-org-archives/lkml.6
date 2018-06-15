Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646EEC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD45208DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ukCKp80r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD45208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966312AbeFOToY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:44:24 -0400
Received: from mail-eopbgr80045.outbound.protection.outlook.com ([40.107.8.45]:2496
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966075AbeFOToQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:44:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tijspAPLGys5uEatIftSNA1e0a/Pxn4k6E43Y0fltrQ=;
 b=ukCKp80r0s2HTqTk23lhOuwthpULjcyeJS8GPQ1RzOR2tvFCi2akl43jztdKAVlQXeeHe/DbklyA9+t1j9cREsiWzsKY7ziSvU6y4pTHzKYe2B61ifVZN0izE4Yza4z4jxskc+RlTCq8y/sgd4kCutA++mUYz4iMhIN3f1Tx90k=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4292.eurprd04.prod.outlook.com (2603:10a6:208:67::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Fri, 15 Jun 2018 19:44:10 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Fabio Estevam <fabio.estevam@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Franchi <marcofrk@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Enable DRM_MXSFB
Date:   Fri, 15 Jun 2018 22:43:44 +0300
Message-Id: <e7e902fd04097a4a5c15440a63d0acc87e28e37f.1529091248.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1529091248.git.leonard.crestez@nxp.com>
References: <cover.1529091248.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM5PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:203:2::27) To AM0PR04MB4292.eurprd04.prod.outlook.com
 (2603:10a6:208:67::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f0ba2aa-b86a-492f-b15d-08d5d2f85dcb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4292;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;3:9vwUvRir7vnZ3/IEIQnCbpbnAABd3Fiy3FetNXTcl4M1tcEfPH7u8zAPUy8GMPCGLDIrkooRmoEhlB9Sr6oJpFE/D+zbW2B3v/BRS/8tN1fiFP37Fp2rWm62dw/3cPJKi4YMKr04jMFZuDokHgBpGIxdONr3a+SERNM849gfdQxahf+7IiB8kgBYBQiNiEaktHlmp6ATfF3BLRqJN36K/Nkx1iM8s0Hm4DwCsw7UFBVIMfMxlCW7ic9bPUY9bMG+;25:KzbHJxivdY1kLn0jNiiWZK3R+djrJiPkb0vj6eJi5+mcq9YJQdQc1lHuZQBCbR6cXsW6ljyC4yQM+T15Jny4NP2KTTdpyaFqG8xbjLNrRrn69yds+tv78V+3alGwqiS7u2EDMnlOtG71NDYU3rERe9QvkZl4HRct0iY9AFbtcVul54ZAczmZIAlGVV9Wj3Z7ceKrjFzbVtUqhqjEMf65XrQ/U+knlZ1mdhxNkC/vsvdvQQ60GzPv3hX/nv2nJEP8Rx43+TZ2l3A+4avLreTiBC8d7+txzpYeJEELPFf8T4Yluu8tFOB0Me0f+LLBj8bWwW7tDmMH4SE6b6hndIIlZw==;31:wVB8YgpsUZ3q9rzmdeEKfuR7FwcKr7PKY26YFtUgwPNnUjSSgVfrhJYqDMI+18zj5/fgE3AsN9JIAKLN3Xn5lGOt/IlIiEOX+jTqUWuE/R0prGstu1MfzERokq6v0vatrrhs1w7YBw+cYSEJYA1qIf9tK4cvfwd1+gpRjeovU+yOgjyLitDDA/+02gUDe2cis8oQiA4bPBQeFYHT2XOumReW/YFLS+fgnF4r2lKOUHM=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4292:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;20:krjxm9dun8E7bfpiF2Qc3weXelSTa625UCRgqUj2C9u/dTJ7wWlYI3CEAFWCDoVyPNOzXsxu3TX8+nwPeMUi6vqKMlPWPigbQU//t7myGCna7SphInhYlk7IlBw1dVvFtgH/r0lepGZnPJea2FD0TJbXEL2wdCbikquxIjIx/v9dNuQUBGGzM5OALoOXN44GSEjrt97FQcSM10I0QQ8IuilHctjUd6phZ+SRuHh39ulKA1yKIjBLNUlD1lPr8PojMpeOpvXZ6slNzV+BSXQ3K6tRaPazPWCHjB5sSrbRA6BesXqb7fDR7k9DfA0dGD/00rD4YB9JTGQJeuMtFLMfAQTzTLy1MyGQMFKw/Pm5mzd4pWQYmtYzFzVoo8lRALIexn4oDtsOdmHfIy9zzKuHXLwV18AGhTulDB5ZLUoKTN+EEBd36/Ky8xnmum+r2HKSV+PH0lxwyPAkECYIypFvBvUXoQL1OgWm5dzdfi1q61gjn60+0giHn1r8BsA38l6B;4:Lkt6UUjZDwCT9wYsEfiUBaHW5K/pTXT9tUkFf6kiZ1KlqewaB7Un2jV0o+KipJaNyKlczlCPPuaUxixjQpyymKmIgG/B1lv3B/c1FVyTmNy8XmUyQ9n+KSVbURZfaAXmWcEHcbN0ajm+a8MAN8TP503SKWi68EiUJcdQTr0MQeF6CkEOpm64XD7La4I+v7VE+hImzt5WvxMwTchlg1TE2OUp1fQfWYsKd9TDVJvBxEqXcuDK1P1gnm9lvrPOBju39IIckAkJqsG9pqqXNkt68WFYiX8xukczX0aMO+1ifLUlFr25aHjOonuP31/ifrtR
X-Microsoft-Antispam-PRVS: <AM0PR04MB4292E29A2FA13A2182B940B6EE7C0@AM0PR04MB4292.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4292;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4292;
X-Forefront-PRVS: 0704670F76
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(189003)(199004)(39060400002)(54906003)(5890100001)(110136005)(16586007)(53936002)(106356001)(316002)(36756003)(118296001)(25786009)(575784001)(6666003)(4326008)(305945005)(66066001)(86362001)(5660300001)(26005)(47776003)(478600001)(97736004)(105586002)(7736002)(16526019)(51416003)(386003)(81156014)(6116002)(3846002)(52116002)(68736007)(8676002)(6506007)(50226002)(81166006)(956004)(76176011)(15760500003)(8936002)(486006)(48376002)(44832011)(50466002)(6486002)(2906002)(476003)(6512007)(2616005)(446003)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4292;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4292;23:HTSNISBiQbctUvJageRU0aouOMfbm3uODL4UIZanR?=
 =?us-ascii?Q?XncIv6afvyK/uUFDvKAPRc3+xObqVF9ZXVqZUuKxKwddzCTprkRomoe2IKKD?=
 =?us-ascii?Q?V3aZK8MMkj0bjBPw+EgkkupiRKZhduRloelqo2R/2Zdb36iJ+vWr0+sndo2+?=
 =?us-ascii?Q?VgwnW9dwRIbzK25vPTdNti+++2QSTJNEtoq1jOVrF3Q2eDyu8kFrHdLz4pmY?=
 =?us-ascii?Q?gfNn1Z7+29BvXZaQZXA87+aFMo3KhuQk1id4mJTLyHMWuew1OwPBGTyB/4St?=
 =?us-ascii?Q?t9FR6LvQNWETSvH8dzCFEAiJ+C+I/u9FBX9aZvsa79CDkYZxfdU0m8XFC2CS?=
 =?us-ascii?Q?XeXZDn4HC1kuWfUDo5BsbmKo1OVfQwelhgpi69d+iT3fwKXmI96rm4TIXyUv?=
 =?us-ascii?Q?ahs8kHEkbQ/LSUN6Vdt9dXYMXv/eq2CeVpMNndte/U9UhzRGSaYbdaqoSmFY?=
 =?us-ascii?Q?TV4XaVNKihCvm8zYHC+4OjopOMHr50PNI80SwNwXXm0JnjPFfuUz0sdsmi2M?=
 =?us-ascii?Q?qA86ZNMh0DjlguKriF9P03fRgbRozlTO4Yu9M+cFD2V3O8ax5rwqLS2nNElH?=
 =?us-ascii?Q?aqf+7qT6QfENbmz/94AYdotPvbMin+b+aTKvG9YT5hWhYDkRf2ssT7v/xeeG?=
 =?us-ascii?Q?kD54hZRwZ0mG+eWbeXty2jW+gBKJiQ6+a3knWrOBTa3/zoHXwmDCqn1FY7oE?=
 =?us-ascii?Q?HsIPgYD0pFCpqCrPVCnHa0B4Ku9sP2TlnyNxFeypr6+Q6s23p2BRxiofTo+M?=
 =?us-ascii?Q?b98jM0afUDE7zy+2KW4pE78pNYangYI9uCJXOevQpPdaHJZo/uaoRC1WwHVw?=
 =?us-ascii?Q?xj8ekOna7rvlEkREHNFDWCvOjpDlZNJ4bFpJfnqdCKUhZ8Qo1BtoiSbgu4NF?=
 =?us-ascii?Q?NTvtyiRZNxN9j8g46cA11yQM9+8N1GZ7Y5UJ24e0Bm18iB68JxaHxEHBrl0m?=
 =?us-ascii?Q?J+kQXmg/8fmNMBuimGUPLoU7Q1/h/7J8L3sSRwCldgN4waVwgvfONG/vr+Ir?=
 =?us-ascii?Q?1CiIYYjccV7tJS1VaKwp07dpD9A/Jp/Okve/c5/jOoKdXE3TNa8yQyDjzzAA?=
 =?us-ascii?Q?d5LnAUZqZrw2z9kLPaxG+3D+YhpCsLpNaObMXNHsnvE4Ykuwmj2LxGlgBzLw?=
 =?us-ascii?Q?+N3cPO29K5J9BOU61r87s1SKKyXlGAeFRsWTxOr3Dw7RVmJl6B/imGMmxoul?=
 =?us-ascii?Q?uoXYctb//qSLs7MlZiEZFCTUqmNkKyO5tLr7avJJQfuv0jV7HhMKZ1rSsTt0?=
 =?us-ascii?Q?O4iI0b3C+8Q09kD37SbBjC3G/Hqijg5Xv8oOEFSR9g0RuviKUjYLdV5QXvtL?=
 =?us-ascii?Q?Vxv+vo2iAJcI/ytA6j8UfXFQygaUFkkFS4H6wl1379NmTkh5WIjxH+p1DUkv?=
 =?us-ascii?Q?4rj5Q=3D=3D?=
X-Microsoft-Antispam-Message-Info: 12pL/s2e5pLg1pArxsPTt3gkmGGQzIR5g1Z0gMk6nMn2b8ztp2aXjVQ+U9D1I+xfY4oEMf3S9UFpkL8+yebwb9z2QLy7TeldlzJy9044dd6OeowM3G5Pg/DDeydxQg8TdK5FP4R1b4OS2QLG6BvRfpPex20uVrlaG44DocizYhs0XsHWMQGV++EoYpuf1ek/
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;6:nSLgYEzCglaVSqaqL1uTVDi+Lwt+54+liYkJ6RRIi9gdXLEHlJkTxcqFuKaTPuLIqLfsNKil1Jtu/MajFt5eolXyWX5daHgPdkNKMtBrtZtZKGskloSUuzsLeY4Kx0p5UOzqllOjkOE8amDw32e8OcqXWbfFHwTpABdpMFY7kDkJhjhAARSl6n8DVuFTn18BdQwATjWRSqUciHuEo3sSgLjLsCJiaQLiv7lUjVpSWMS5xKkg7jd9bFYMS9zyuTLBq7zpEMBuYgYiAXfB4XDxlJ/+ITS/ojAC2fhPx2XTCjrCAsrM+eKq6yRydv4pVJeSot6GqLh50PqBeZd75F539APgZ/oNSECv6epsbfkj84Apn/XmL2mUanWJa/EXwPXOdSeG8RPHAMhZsVeIecwfbynDXzOFDbp9Hghz4+GLaUyXDL2Ob18vvYS1Bymfu7G2YKam1QDGZrn16Mut9/kpEA==;5:1MZVX2WRw1O63tz1+K/sZBLjXh3Tmr17qNrf3sF0Y31Q63VqrmG6i9V7UghJExYrHr43FL9t29dHk1ali7vIlkSJKM7XF8lH8o9scPaJbeti7A4EyQsX8+sSb3qhyILtr6CKccNBBOwo1LIh3V8P2vXLML8TqYU+iZ4C53reqNc=;24:D3jiZm1uZ3nEECP5DGgV2h7GVRr1AFh5Bc+jv6qmjAWkFCpdeCeKp0NQVlxc9DwZ1Sl3tky8zXM9+wK6uNLGZuJqvR9SaYUgoaWcPPP5mjE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4292;7:UWOGhi4+G0/nhn5A9vFY1mk8DgMzbYrWILwt05Tnnwsl05CSSPPJevv92oZGAI+NY2QnnHKSRHnm45f1wkmsfzIFEOwIM//6sVazGB5Ird5VhadYU0digldxPTmYdBWXy30WyLV59JVwSUAcFhoxcxQ7260ZR6Fxh21/+UPpKqWhPgOLTXYgbe5j/BPeWfRzYHR9NgeDnLUn0lnx2DNx7sSLGCxkPC1UkydcTP21qj9QFq2qzSiUxbW6Juc1u9Rg
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2018 19:44:10.4833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0ba2aa-b86a-492f-b15d-08d5d2f85dcb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4292
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple boards have drm-style bindings on imx lcdif nodes, enable the
driver so that they work by default.

Also enable DRM_PANEL_SEIKO_43WVF1G, it is one of the supported display
attachments for imx development boards.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507ab91ee..dd0f64da2243 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -256,18 +256,20 @@ CONFIG_VIDEO_ADV7180=m
 CONFIG_VIDEO_OV5640=m
 CONFIG_IMX_IPUV3_CORE=y
 CONFIG_DRM=y
 CONFIG_DRM_PANEL_LVDS=y
 CONFIG_DRM_PANEL_SIMPLE=y
+CONFIG_DRM_PANEL_SEIKO_43WVF1G=y
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_PARALLEL_DISPLAY=y
 CONFIG_DRM_IMX_TVE=y
 CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_HDMI=y
 CONFIG_DRM_ETNAVIV=y
+CONFIG_DRM_MXSFB=y
 CONFIG_FB_MXS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_PWM=y
-- 
2.17.1

