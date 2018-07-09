Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C316C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09BA205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 12:23:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="vfZjZO9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B09BA205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933012AbeGIMXq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 08:23:46 -0400
Received: from mail-eopbgr50064.outbound.protection.outlook.com ([40.107.5.64]:62272
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932445AbeGIMXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 08:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clhVV3K1pVyTlrZ9/Brd+8PDGB6PdBvJ2Y9wA6QFDiI=;
 b=vfZjZO9XRZf3PlWs8BEUjMyismISK3RB7wXGQYyEuIvNFn60yFwfp4UXFe6PQg08SWNS5jEX8eLCtnIjtRmz4ElQODZOHFmy15mf5/UzNfICjIxej2qjFJygGWo37RsO8SNxOBmkCobvlEZwdtzhxe2yiZHG6l2qENiFgAgYpzo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonard.crestez@nxp.com; 
Received: from localhost.localdomain (95.76.156.53) by
 AM0PR04MB4291.eurprd04.prod.outlook.com (2603:10a6:208:67::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Mon, 9 Jul 2018 12:23:33 +0000
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de
Subject: [PATCH v2 2/2] ARM: dts: imx6sl: Convert gpc to new bindings
Date:   Mon,  9 Jul 2018 15:23:02 +0300
Message-Id: <e4a8935644895fad4d01b927a3476b271b604fc5.1531138446.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1531138446.git.leonard.crestez@nxp.com>
References: <cover.1531138446.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: LNXP265CA0038.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::26) To AM0PR04MB4291.eurprd04.prod.outlook.com
 (2603:10a6:208:67::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93bbddaa-991f-4d1d-3343-08d5e596ca3d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(48565401081)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4291;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;3:kpKr4Qo5gZo5aU2opzk5smAswrmgJ0KIILWRSi4YXtcvFseqw4OQZ7by5o40ELE8pnlmpoMnqmOgsQe3713y7g4Q/+fMMB7bIuuLMLVN3ea/8P/Vbhii3qgrz3w2q1p2eJBlnYK1PFEi8zKGFUxoX0sh//wIa49r1XEQVx95x674iKGJQ+FtSpHeKFBNwitSSUOuF/7wXyvRel4saZUKaPolBJXY9G3GbrlTlFs2CinjmYeWz2W6J/PT5Uw7WGrn;25:L0buCw+40B00Bmg95JfA6fPJYcudHi2+hWb+N6ORb/K/+MC6ouPUAFGSu+fykkyOj6n1jmVOQ4iDHAo24D/EzhcNhPDcYzotlVbRHE8GQ0GSe3s8kxJ/NvJsCus89PPYQuAf52jGZyKUo9430Q/CkCZbkAppEvldvyEMHXaveKEbBwi+ADnmhG4zVdi+DRyKI37RanJ4ntbI5iZNBmZH4lknkGFtPnrbhlOfILvLHwHl6cC+neMEqjX4Wd2grxPG257au618hHs+oOxA70PRH4EI38hMTwh9mJwA+RX8OJusyCBOvkRX5fTcyJD4AbJ3aqvcS7nmHfdcKooNeRcRPw==;31:FAxOJT0FJ+EF56h157+VV2Ue/Te3G0Q30b9BanaHwzZKFl1r/1Cm1y38ovS9xmt+Acwd9BuzegQWyk+UrFhEemcxyG4dPANB0IlnksWMBSrwpqjGrMz31Hrp0QyVbFQojAdtcLQfDbx7zFCdp7O5lqHUjN4/ijxlPvvVAVXTpxM4WfaDtbbvH8BXsfIl9NhMFPkY/8vq//3zidNKZwiyfBsPwj9i0JPXh1fq7MZHXzI=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4291:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;20:wA9YQ/uUS75TJNPLKL/DvzU1AFBqWLPrx7IHHrsSweGjes56jF2jN/LJfKehJQom0Ec9x0WCK4h52NtPxFATla7eyPgwb0qJ6BnoO2d/rB15+uayU3KyVQYh6XZddomKWATDZD1VOvHBHmEZi15GlH74b8QpwhwAznd9uwcaPkFbUp7wTl4wfeDJTtxzNDyu40AHKnpSTWh3P6fZjyYU5khaBtkUnyNzj9GIZT8PaTCNuc/ca2Abin3htbVR286xYSN+NH7iCJFS2gbKVSs7U2+Zcl1jXMaf4QDL3K2xVSlk9EbmV/fwg/ksvbNHKXUphQs0aJvZXgf0PfKS6D+hav9Eo049+vif0hnzRSvEFCAPtgOEhbgbDAhWY4oitNJgnf8yCVeDLiVwMCb9VLdhqzsiVskW5SV4TYpI8QH5QfGd6oVEZ5qFS1jU4cogdyJUekY8n6DP0Bkh4m6EZGXS/IeHRUuJ9PCg5fCh9WiMoKvWPlu+HZ9YyFVjdtBpovlm;4:5EM1+blzToj+rHNfG5DjwzA0ta8oxVP3tEegRBbHqq/tbcEpZqXvbAc3LusJi+TWI3hFwiI2bD5KyfdDd09SPKLUI7a77StmW9D3b4bUpE5O6crHG4fECk6NgguYk9ifD97n1FH5PYqZtufWAlLkdSuXRH+iltDwKeadZp7DpG8QdLQclY4lEG+tv3o771hVPvntWR6Aq60TDviwjwWkBb2wv9A2m9s+SDtpJWf+sMwlgIcGgLnG9Js51oeCnt4vw9/acQzBq4iE2Wfunru3UM3YLWeOczzo0ftJsmfzEvF/h+u68xPv6NtKlMtReXyg
X-Microsoft-Antispam-PRVS: <AM0PR04MB4291DDB7921955312881AAC1EE440@AM0PR04MB4291.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4291;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4291;
X-Forefront-PRVS: 07283408BE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(47776003)(110136005)(97736004)(6636002)(316002)(106356001)(86362001)(36756003)(105586002)(14444005)(44832011)(16526019)(118296001)(3846002)(25786009)(54906003)(186003)(8676002)(6116002)(956004)(51416003)(26005)(52116002)(66066001)(486006)(2616005)(305945005)(476003)(81166006)(81156014)(446003)(11346002)(6666003)(50466002)(16586007)(76176011)(2906002)(48376002)(8936002)(53936002)(6486002)(50226002)(68736007)(7736002)(5660300001)(478600001)(4326008)(6512007)(386003)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4291;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4291;23:b4w8zPICwpywMLf79mazyrUsmvHDoR82GBGISTBCY?=
 =?us-ascii?Q?0Nju3a3KEJRl1hN+t2jAW9RQP12uJKqag3Ic0qBExVYYtGC4MBGlDLbD4PMY?=
 =?us-ascii?Q?zs9M6lXtKN75b0Y9UiQbuuPagr+PfztaYMXhLUnCr4IvqEzU9hGw5ZxsLbdh?=
 =?us-ascii?Q?DtQsDgLo+afOvQcECpw6hjmmIOxkwtKrepniJeLzgmUgkTs2LV/UylAjSLFV?=
 =?us-ascii?Q?EdK0eybuOcm0cGLyun7Q1Hj2RuxSjAjJjT8L1qB+O6y0Sd95+Ezv2dZMfzY4?=
 =?us-ascii?Q?RGZFaP9s4AMwyPLXfjKKc+2jnSWdxc15dtuT3fo4m6hknNhmyHG8y1LYRLHq?=
 =?us-ascii?Q?PCQh9HftgepRWzbJPlwin5oMJNrsbqbDhvbUtBAdNC0zXKqIxs9DVZ58wCIz?=
 =?us-ascii?Q?aupbIL6LKZ8ronMz/5k/4f3889gdSe0RLYkmj7tMM7IwKk0UTmIFsscOBozs?=
 =?us-ascii?Q?CN/KwbwHJJrXPLHZOfigjI/r3Nt2QBZ/u5oE1DUBVm652mCibRC40kj0fgvg?=
 =?us-ascii?Q?UVnMlAzy7o7UjALMy/Ma4eokln08P/KuJE7nX8+SBFILRPfLA9reeoxpxc+i?=
 =?us-ascii?Q?qWPcTkdaZk6a+P8TTDiNB0nEwaEK6Fp8fTZrcvBuT7bJ3el2LcvBHJlBaDWt?=
 =?us-ascii?Q?jOAPk/CMGTsVWRggFEOh/FzMz/by0sI/v3tGDBxaF7dEx8jAQLmYFoVuNCuK?=
 =?us-ascii?Q?sjkugo9/AqBNPD6raESW2Bl5dDVO7sNDyblapX+aH1nw2lqFK2Be3lZNtqUy?=
 =?us-ascii?Q?lfdWP7G6brWpuc3akJnIMUwP8cuFqEQccm9kUE6+4Ag55aqnBrj+PKyRa5k6?=
 =?us-ascii?Q?k9dR1jEn6EGSN6N/T/X9qXYA2sIYEwlkQXRKExXeYZJqNAC2zWJenQdgswgy?=
 =?us-ascii?Q?Y6cIKsSP1KBV7xQd4etRl400zI9RJ7f1NCfcknR8GYyFyOhxhONhHLYyVeN2?=
 =?us-ascii?Q?cvXxMkG7HKzr2v9EXAHuw7dGzCyNvoPnVacTycAcy/OrNFEoBYajb+DiBxHg?=
 =?us-ascii?Q?xpzu2ybMvCdMdyje4KrpNEmdeWQdZ66cZB9i2SZp+hB+Uiihu6ZpHCCZDEe5?=
 =?us-ascii?Q?R89iPtNf9KIqqdTAKohKM98lPXj86S76dR96Uur582NUOlJXcPwWr3rdw1tx?=
 =?us-ascii?Q?gkqNh+48z9zoYQlf2ApSQaKWgiK7S4YFvoWqM9MxH7N1ArrT659l+zSwXAq0?=
 =?us-ascii?Q?7StcH6ah6nJD7kXxC2+gFjm7PH5Vv1HWVT24qf3EPrfjViQrKQsQYndR1emM?=
 =?us-ascii?Q?aHWRTnRLygjzXxarK962GVVdZfKSsofvMKIKs/owmnzLB4VPqyDu334JUFFS?=
 =?us-ascii?Q?lZhFSAyce+PTyXAcHufiEg=3D?=
X-Microsoft-Antispam-Message-Info: FH6i9DOE0qnuc7oxj9wUioadVV0emfo5tj2ImIxQAfuU+X4vNB7JatVhy0MaOndp4E+VXJvGhWC4pmmj4NL8kOj3Mz+m0BYwY9p/7XRMI7Gp229YJ1C+dOoH4MsnX7tWO2Qw+FaQ7DbnSrP7WcElZ+F2uxafVyZucacTj8rj9S5GkgXl1J7EZb6J97KidVXOWJAWA1FhurdGJu5lxFcd4cdmYDNJ+eWI782ut/L7NiVuFj9rxvPnzAMy9cjqXwLqfNjo3td3hE5G+OW8wjQrU5r8fO/rpNZFOM+BWFZjGZws8ZIe77k2Oayeom76gvtyx2tHq9xK26vlwpMvysdBHO1Wp5g2bxOLktpAymykl5g=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;6:h7cgpIgGIilNFXkgax2GJhaCjelLfXshp1Wx1w2StgRgilFm6asOQiXL9yq5Wag6etliYDoko3UG5u9tNHkiqeDVa1jLZfv8gifYgmmTfB5mDbjE5R7ygGoMk8niZ1dpvjSOD9/LFOCj3ibUSJdr87hAMgxCxuFXXLVhPm/LDll0Rr2yaHsgNKSewX6Ze+rxhDWJG8Wl+DBWi9xpBg8303/C+OaVUKuN9wjETGDy4R30ArEU4APVCBFfdAI2/3gJpmvZLM/i6AjR70SH87YTFsrJAs2UUyzm2Szf+b8ppXcN4jsd9xATayD/sw93XgIJZFM33GtT66GX2PEPLj0DB2gh/bbWsY+EIPFKtZJ3okplPvFGte8SkBQ5+1oHhVXPWjf+75hxWbXukU3DqqlsDnzHzvK4y4oJQ6TAIrJpdeFJV4+jC+7+WySWevsp+LyvtphCjHOY1mzQFTBihfWB4Q==;5:Z+cPiVJDjD4LppRIRZieTiXeloziGDnhroM+UsjNeJn2QRWNjA9c8x8hF3n3yuFFoWHn1WSUHgND3g6nXFzMf4lN/LvngXYjkz5JvlJuGwpdx+ToGReRV949aT9xWECU6Q3HoTiGLxobIGfk+T70y+iMQXtJJb+aZGEcIHyEWhU=;24:KMsWtVx79w5GXdb95i7xbJAf7gMueBi6RFFrIGWVjisn1tOEGtrTTLgLb5vhviUkTlPI2E1PVqIK4SQ/pgYlPgWgMjhHtnZbmh1NBTOUBJg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4291;7:21z+2SbIxqZmHwyEyM/7E6fpDMCpRRUMBZiVDZFhdF+o1EGUDvJFJHICQaBYQqfe0FBKkT4eot3ENY6l64sBuGzNWH4T2i1yd/3m8AGNYIYobrPJ99Gu7+Zszc9XrSjVoTEuLpc9rOYCW7lkPYf9rcBxR2YNeELCn3vV2QbEW7dAUjcM4lzdk2eFwyGUt+tKZ2R2iusBi5vGgjyMEZ/AnT0OaVEgbck6uwqbO73H1XMTwdw5E//eiN/1JwxecAsT
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 12:23:33.6591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bbddaa-991f-4d1d-3343-08d5e596ca3d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4291
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With old bindings imx_gpc_onecell_data always sets num_domains to 2 so
the DISPMIX domain can't actually be referenced. The pd is still defined
and pm core shuts it down as "unused" so display can't work.

Fix this by converting to new gpc bindings by adding pgc nodes and
referencing the newly-defined &pu_disp domain from &lcdif.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 36 +++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 994e48dc1df0..3aaa8d5d4804 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -678,14 +678,41 @@
 				reg = <0x020dc000 0x4000>;
 				interrupt-controller;
 				#interrupt-cells = <3>;
 				interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-parent = <&intc>;
-				pu-supply = <&reg_pu>;
-				clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
-					 <&clks IMX6SL_CLK_GPU2D_PODF>;
-				#power-domain-cells = <1>;
+				clocks = <&clks IMX6SL_CLK_IPG>;
+				clock-names = "ipg";
+
+				pgc {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					power-domain@0 {
+						reg = <0>;
+						#power-domain-cells = <0>;
+					};
+
+					pd_pu: power-domain@1 {
+						reg = <1>;
+						#power-domain-cells = <0>;
+						power-supply = <&reg_pu>;
+						clocks = <&clks IMX6SL_CLK_GPU2D_OVG>,
+						         <&clks IMX6SL_CLK_GPU2D_PODF>;
+					};
+
+					pd_disp: power-domain@2 {
+						reg = <2>;
+						#power-domain-cells = <0>;
+						clocks = <&clks IMX6SL_CLK_IPG>,
+							 <&clks IMX6SL_CLK_LCDIF_AXI>,
+							 <&clks IMX6SL_CLK_LCDIF_PIX>,
+							 <&clks IMX6SL_CLK_EPDC_AXI>,
+							 <&clks IMX6SL_CLK_EPDC_PIX>,
+							 <&clks IMX6SL_CLK_PXP_AXI>;
+					};
+				};
 			};
 
 			gpr: iomuxc-gpr@20e0000 {
 				compatible = "fsl,imx6sl-iomuxc-gpr",
 					     "fsl,imx6q-iomuxc-gpr", "syscon";
@@ -736,10 +763,11 @@
 				clocks = <&clks IMX6SL_CLK_LCDIF_PIX>,
 					 <&clks IMX6SL_CLK_LCDIF_AXI>,
 					 <&clks IMX6SL_CLK_DUMMY>;
 				clock-names = "pix", "axi", "disp_axi";
 				status = "disabled";
+				power-domains = <&pd_disp>;
 			};
 
 			dcp: dcp@20fc000 {
 				compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";
 				reg = <0x020fc000 0x4000>;
-- 
2.17.1

