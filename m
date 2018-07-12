Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD7C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C2F20842
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RM6dlsci"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C2F20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbeGLNsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:48:32 -0400
Received: from mail-eopbgr50068.outbound.protection.outlook.com ([40.107.5.68]:35088
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732410AbeGLNsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwHOJh8aaqRR7G0rmOUGNAuZmcBh3Lh/l60xdPNe4iw=;
 b=RM6dlsci4oPwwZjTLsA1jV9FNRaPGU1Mq+m1tVYLnyrR2Ve852YgnNjzGpCgeTSi9GCoqB1dWjnwskGttJHhlb/ksKfuJAFm9rr9pXN2CA7GGKUqKUlvPT/A1YmCED/LtUG53zB3IvhYA9TmMQ8tvWo/DaXB1kYNbY8aBIk7hpE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 VI1PR04MB4304.eurprd04.prod.outlook.com (2603:10a6:803:3f::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Thu, 12 Jul 2018 13:38:31 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Marius Vlad <marius-cristian.vlad@nxp.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH] ARM: dts: imx6sl: Add vivante gpu nodes
Date:   Thu, 12 Jul 2018 16:37:59 +0300
Message-Id: <e056c4b8a850a81a15bf090fa6a88d9a50fae3c3.1531402278.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: HE1P189CA0033.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::46)
 To VI1PR04MB4304.eurprd04.prod.outlook.com (2603:10a6:803:3f::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea9704b2-a28c-4252-c06e-08d5e7fcc31b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4304;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;3:vAdUSVt4ZLWTBzi94DmJXBSMqVqh0J2GLmmglOcci5Y5ZBzwncwZmTREnQknkB/THHQZ5EfoeCNyO6PoAJo/NzyVN875qT2TcGTwF0MbMvkFeopA5Pzpd0JiG75KykLfIazjv5d9yLmGE9Htd/5Us5fPh3LY4tCm/8HJ08Go5NEDH1vSfVfMp/iMi14853Wi0ThmaScxAJfNn+gDvOd69gM1/TfpkNzwH5Cn8ekmT6RKUKQfMrcuCS6GKvMa53yD;25:RcoisMgnWJOwGV4lJPa28XW0LKmqviy0+8v5PAfSVevow9gtVBbDFxO8mYBrsc49QoJhR0TyQ3v+rKgv1g2lUIzVxXiArrSxgkthLDhDLaKe2s6gpV6QpN2DPnq2G7DvaqOzbHiJ91wU9LRYqC2+UmXL5iyRns2CMjr3kvJIqtl0IyxDwwx6okXAA4OxhFClUkR/spOENS4kKQ8Fo2pM1D5BVXzWYSEq1tMS8fNGq1hTEmej36hv7xmuwgffCelBbBiAxWvoj+SnQIOV1zRG/2dezzQuAETZg0KEvrOT+usF2lu+JuR/1rYX6NWsgEpiCgNDbPLvAwpEiHb9qRNMVA==;31:yvr8I0lA9K+NVJubLaxrXspKVdZqjkhcyunlAlln0gGtnKqPjiDgea6WQjEmLEtPSeQPBRfkAw6JNHSVYbeE0qM6K5kOTUtrti8KyXQ3ajDpuzlhY+fXunNoeaP8JBTWVvX/r3OWB6xdCdLdFmE0DHoeYuFs277WkW+no/2fyMiUBk9ZhaLwgph02NYdKSkxFfFr+GpkPAo9fnKBoBOFQjkAae9RKGvzdo+vDPHhWts=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4304:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;20:Cvfa+nDzZajD46Wf6QrN8qELbGKg631oveprnctxpE/4KZwjcxcfvTLHEuFPZHz59PcuYCx72iifIEC8/GVNhm2/5wykTqO9c+fdXMxrmvy2CCCLNJ4vpttud50c+y1LXhwCO6+EK8mlIqDCl1je/VnXZos1SXS7c3lw+vxDahYpP9kW2M1rygKjWxHzYKhfulDaUxblyCNQ/dmNdlRvGlHajded+AjYo+8ovcw8QroFs+qvBY6Eghc3+7EHnNyhMsdJnN9SYBTBwVOv0XZXkJi3ki7j4JljorMGNofhIL625dZGV4FTZdmHTbPG405ykcYkMCc2x+wzwsmWXOn3IOt9wNM2jEHNsjjD7sRC0+5LmY2GgYK+OaXgbtd+XtfxIa0BgXrKkuYEn75zbNa/M+EFiXnV1M+5E8EPuRVMjHJePOr8Jw+aBCWxjP2qQjucIhE37QbUBNMdw7rKY6aqKimHQZixoVxdUeda/dnMgpnHFIzp4ovWdy3PzUkmMBiL;4:ueaYt8PefrZtXiLaW1IaW0IJyR8/X3pqBtBhwF4xiqU8buv+hAyMXsKIyGRYxexlD5tUgEenAdxP14G4NhJ7F6varImTiXvqsB3iLgeAg5/ii5L/fDwD6NdUwXsh+sUXNI9oKovTo6yDdCTR3tZVp8mZ1OQ4g2zbPM7WeWhWFhlgKOMUPReeCglnhmGJvQQfhr0gjNiKY1cjTs6Se7fv+dI7oN3X9o2GhN/EhsSo6nNpWnMJPVTdZCbrs07hQl+Y20JZStqJgkR9dw1IwRnbEPajzDaqmVquBbEGwDlepEEDgC6QldLq0NO/bsFQgGkZ
X-Microsoft-Antispam-PRVS: <VI1PR04MB4304D44004F0B005A5145C8AEE590@VI1PR04MB4304.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4304;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4304;
X-Forefront-PRVS: 0731AA2DE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39860400002)(396003)(346002)(366004)(376002)(136003)(199004)(189003)(44832011)(486006)(7736002)(81156014)(106356001)(956004)(105586002)(8676002)(118296001)(8936002)(2616005)(1857600001)(476003)(6666003)(53936002)(39060400002)(52116002)(51416003)(386003)(6506007)(6512007)(6486002)(186003)(26005)(16526019)(5660300001)(6116002)(50226002)(36756003)(3846002)(68736007)(81166006)(4326008)(16586007)(54906003)(2906002)(110136005)(316002)(66066001)(47776003)(97736004)(478600001)(25786009)(305945005)(48376002)(575784001)(50466002)(86362001)(14444005)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4304;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB4304;23:MSWPP7B250YFKKKMDJFqnR5niTc3L+EsIqasw3+/0?=
 =?us-ascii?Q?BFlTgd+kOIaYIM++/xl2glBtMInVDAeD3WHEv7Ucnue/CEE1t6D+dpFXDVAa?=
 =?us-ascii?Q?ESzfOe31kUFKTS9GSjS/ow1q6ct7gnJochPt9x5V6PfPMDfBThn9VIVCot09?=
 =?us-ascii?Q?yArwcvBjzO1Bl86fPF6fnCvIef7zoLtGWj81c433suRz9EeKb5JMvbv5KApk?=
 =?us-ascii?Q?mA9GCg/JUfDlIDevLfe+dS20O739GkastZV8x8XyP1pezdBD8nZ7iw8essnh?=
 =?us-ascii?Q?8GojEhfzo8xSeBCwkFTDrT1uRWaZuK5Yyx6PovCQbWno/M1SDXUBha7+mwEs?=
 =?us-ascii?Q?K33zyLuC60kOZt4kGQMw2TlaHGZBdml0s9o6+jDd5g6azWpORgc8DAYCmfF6?=
 =?us-ascii?Q?HIYZLqeLQNltYu4qINdeB7yMZeEcfDEYU98VojxzhWmLmJG4lbVcite9wD0w?=
 =?us-ascii?Q?7NprtIFcQScP2CFrqgSrh86YixWTp4Prt+crkoyuRPMBxSAcgTEn8+uyRlL5?=
 =?us-ascii?Q?myGQiwdjL+Rcnnmhw5Kdkl6dTZ2kIRG0erCKlgsvVkcsRxCmkPuiPBfY13co?=
 =?us-ascii?Q?A4XtwSmOxlqlILXc3CxOkWOliAMz+wvg9ZAL6OKCcIYCkx1nFRwIGbYCBYay?=
 =?us-ascii?Q?8n9Fq5wZxBVaabX+nhUiOURiozIv8iBxNdOoSJ6FX7II1JDSA0YibabOm2jD?=
 =?us-ascii?Q?vNrvDxinSLx+urAj9VdNO9CVNtRL7QlCAJUg280+5yRzdHXDZXkR9jrQJ7b7?=
 =?us-ascii?Q?OW0AgeG3BeFoKWVPaQCrWtTh6e1ta55+fKtvHGLgOXy8nNSrllbePOzzwwVf?=
 =?us-ascii?Q?nPuM5ZMMmQqAQI1X0yQtz0LVsvlPdHEtXrI8VFdbHfskkoZS5DiUN3IMtGHW?=
 =?us-ascii?Q?eEPr/shOK0dk40ib3d1BYUWtV65J64MNGh01er6Df9j3utvdsi/8fLCfpDQZ?=
 =?us-ascii?Q?fsLgggfXpkEHEgvh6hBGfopyd2da3YZhBymkry+mrs/lhvtqMHRkgJ8RsGpm?=
 =?us-ascii?Q?TgwE4viL8SZzcK6ywqHE4OVR7xTVKTvl4eZZqSEHaooorcHBrqC95RpOGWLV?=
 =?us-ascii?Q?QHZCHzmSHAYPM4wCYN+bIGEqcaa2e95nWwDdWuE8GZ3yXZgWCKn/WGAcT1Mg?=
 =?us-ascii?Q?Ui9lzioatDe6eeF6WeLoLs/7LUbT/o2+py1nAh+httl8sFPwUDQpMj2SXHrr?=
 =?us-ascii?Q?bJQ36Dr9H6xxZg6r1E6qO5Kc6oW6pskJ/WLzgN/XT4TaLP5dlcjdxt2xT7LU?=
 =?us-ascii?Q?vQic9B+mNAMr58Rb+o5MTc+oDLWgTSdgxNVd8g2bdvSNbIq6hoBMLrLDg/Rj?=
 =?us-ascii?Q?6rJHW2xD5oDqsGrsIRuuYw=3D?=
X-Microsoft-Antispam-Message-Info: AdlI0o8LpZUU8npobhU5nHnT7NgB+07VKugEcInhc5rpzCN7ywAve6fLFa9KqnuHjWjzwyIW0Mz/ZUmBsplrdNQj94YPqxmnvLPgY/PRDeTtmqZ93YE/z91hxvWGnfL16WHMdIeR8YDJmZf1qiNqdCn0LmNA7QVSZ7JD95dZHR53gTzr4vaallh/g8awxMzVHOjcjeC7NJ/DUSvO7LlmS1ly5+7G83G5+aQ42Um/wmwHbM3y/VryydPB8gVpJT/YKeZUmSATX3wVyS6hqueZ+8ZsxOQjWyF7P7R/f83mVx8FD/+ur+e9lGpkcPkUzeqW17K+5aqTqdfQCjuYXaXtZ8XOT+e24QtKAfDqyGWYdGU=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;6:kKltJQWQfEiSEnivs/eRpK04/vZojmO5QB1lAp3lpoc1sPdMRiLDO6IoXsLptl8gTGGcysobS0gKgLWW6yByRE5tBupXZ5a/xpCs95q4NAVAmblKoOHPILsw658kA6hmKfmq/pjqWzGrh/LF8qdZfLojGe6Wd5krbucKJzaPQzj1qptMfLCVz17tVL5ePFNW4FbH+WVBSUg3llhNTlIJwI4AfQZHTVfSAJSst53RqfWyOKDzQU2tjGCsC1bH8W4DAO6qRpnGdY5V6Nk2WvWuGA6HW3kgMVF2SOMqyJqhAAVHtgF4EbDJY/MccyfYM9V2qY7iWDjDWHoHGNp7wlnRgZNe9tsESayU5d+KAM7ED7QZcu41bLUG2lhljWAuUytbNcIevBJN28okfSzylIFrtlkPUK8p/Mr5Fw6ng00GntjEYJqaU5ZbH6zm9AACOeYLh7V3ccSjtBOVj0ZQYoiArQ==;5:ubmiEg7e3nYNliVBHfGLFWB187sRnIj6lhEYrOGp/aJgBRu1JizFhjUuELOxfnvZ4BSt/XFwcNmMm04Fl232r0JiJLmDqUbr8P6+ePWBuY3cnF+729r9ZEX55cGUTQ49BnniyEPYFddycZd97EfTBekRzjv8XNlFSLHxkLn94JY=;24:64lb+HFtWd06iaN9H+g/sdcT1fwuPPOgi1oX3PsDaN+dEscM9nQaBHbYbRMKcj8MALaOsw55zCb6LRAk7iWcPrvCMSGEvsjKwaM6xYpIuGc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4304;7:2vF28e1oN4yW62wxgw33Thpw7mJuNQx5hrKmebaX3+iLcysg+Q210idA3EtKDZUgKmw1JVUIWsqMHJBh0vSGzC+JzfttGRlig28uGzQgAzCR7/MONC7+asGJAGkx2i3Et/9CwXhBJwKWBzuFptx3t+NEhu1lpWH2ih4S26opTXFesYejf4dyRh6OhgW+shaNUISXYu4yBLbkwNJE7ppkVo5IEb9/Eb8Tz6mO054vYiJf7Dxie5W11QsCMWEL8u05
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 13:38:31.9100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea9704b2-a28c-4252-c06e-08d5e7fcc31b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4304
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imx6sl soc has gpu_2d and gpu_vg, no 3d support:

etnaviv-gpu 2200000.gpu: model: GC320, revision: 5007
etnaviv-gpu 2204000.gpu: model: GC355, revision: 1215

The IP blocks are close enough to supported hardware that they "just
work" with etnaviv and x11.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/imx6sl.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Tested by using yocto fsl community bsp built in "mainline" mode. This
patch makes x11 start up and turning on drm.debug shows that the etnaviv
driver is being used.

I don't know if such a patch requires much more testing: all it really
does is "describe the hardware".

Patch is against shawguo/imx/dt, it depends on newly accepted
commit 13211eec7b0e ("ARM: dts: imx6sl: Convert gpc to new bindings")
This is only because of the way it references the PU power domain.

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index a6bc21433839..49a56b4fd393 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -130,10 +130,30 @@
 			cache-level = <2>;
 			arm,tag-latency = <4 2 3>;
 			arm,data-latency = <4 2 3>;
 		};
 
+		gpu_2d: gpu@2200000 {
+			compatible = "vivante,gc";
+			reg = <0x02200000 0x4000>;
+			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
+				 <&clks IMX6SL_CLK_GPU2D_OVG>;
+			clock-names = "bus", "core";
+			power-domains = <&pd_pu>;
+		};
+
+		gpu_vg: gpu@2204000 {
+			compatible = "vivante,gc";
+			reg = <0x02204000 0x4000>;
+			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clks IMX6SL_CLK_MMDC_ROOT>,
+				 <&clks IMX6SL_CLK_GPU2D_OVG>;
+			clock-names = "bus", "core";
+			power-domains = <&pd_pu>;
+		};
+
 		aips1: aips-bus@2000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			reg = <0x02000000 0x100000>;
-- 
2.17.1

