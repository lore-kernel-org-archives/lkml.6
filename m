Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D0EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B55E20658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8Y2zdHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B55E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeHaOjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:32 -0400
Received: from mail-eopbgr30049.outbound.protection.outlook.com ([40.107.3.49]:45696
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHaOjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i53RJaXwfe0j+/MkFWaIKnsOteyq20ut+x2xIp3laPg=;
 b=X8Y2zdHg2DYHoXfaUt7KW9AWpWHSeq2xzyr9xsM/KF3i6ybKPyfn6N3RyKVBC841BLildyFFJ27cVN7a3y+s1zWWqTL8o8qDkdqGuIvorO0OwY9a30cIR+aOd6EOaMS4IR9W2xQE4GS3BqhlCUo4DZG35eir9awyTDNPsOCyT5o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:32:16 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 5/7] arm64: dts: lx2160a: add fspi node property
Date:   Fri, 31 Aug 2018 16:00:02 +0530
Message-Id: <1535711404-29528-6-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR01CA0100.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::26) To HE1PR04MB1034.eurprd04.prod.outlook.com
 (2a01:111:e400:581a::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a232d2fc-ae4a-46f2-1655-08d60f2d086e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:MYvWDqV+9rRF73jonYfkPUGw/DQJ5ObcDbn5AHI8fVLWFLIqhPXKkMd6frPfPBKjYR5ru+ZSyUVQIgawh0h2q2tWRr1veEv47hSkjiojcyoPf/7KMo1nHggn/2pvrZWMhCrHRLQnxqhLogfr7bDvAouvS0BbBGueZFLDXmjgSFqX3iMIyXMjV1XOJycgiRUSW67p2jon4SePs0x/n0Nu0boxJC0cACfrkLRsEE4B6d//VinpgWC1uDOADWQ+Hgxl;25:QiMeY1LDUEKgwbhc47D8TG+tXodNAKTK0s94+PE90DhXW2QwEWHaNNpiT8DVGuy8l56aI5/8ggD50wg8Z2WQkP73hXpDph11yfxQUAK84TK5XAumDRdlVRudZjcJfOaOCkWCeWx3y94Ub1q9yuki7GiCBjm7ihHl4FaCa1rch3SvxCybxZcOkKHOziI8d9wHmdfNk+QhKtBn8x3bddteqRH8TcGGv50LDxXOFy/1M58M/D+MCeh3W85tFDb4U4/nUvcfU0AHM6Rb+UlaqH2GhsInDJ+dlBUeBCpsgdfrJeu/KQ8Acc9O7q9Us9+nHq365sXltyMQoacfgXKh1Y0rW1wh17GJaeWXZOI/THlFmDs=;31:d87C8TEnQj1A/7z2NnTfC1BYx0pmmVoWgCqhGHjDamtj8bCjSjBIKDjYrFXIJeCs4NTwoj1HsqpvNPb8PwtrX96fyj/sli2N8MNEkvaRzGzTU0B5jFkGmHlKjwbCAMXuCBWkgpZHypjs0EAkT/uPFw2KVpTv1PRRA+fEsJGrbn59xdRsDqBtBUQQ7Sj++1mSLTAd16MP5Cd3XgbE9IX1TvjkywLlEtl8y9zPSQzpXOA=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:645bBl3Smu872PmElNUqvnnI/SqN4rbtfbERMpaHWx4tdNCcGdQr50JrN+8pRX126ArCEwJIcrxZ1C1ovUpoik8d5xzZZdEyMZm6BVcM2om0d43GvYmlUA0GH1ES98XrPel4WgWH4qhUmZsZyGBen3KJ4Gf+i9z2Bte6x7Sb8iDog58YDibhyh0uB6DJy+59Wvp/hAGSvdoypn2hdLbH1BSOOCVCccIytAYYSNzWZY2AqkrhZT0geqzmWzGIfxJIEywqNVYicOW8JrKFAlrVr5ZDaULJAbGT2d9pB5Pfw9XYOk32T+Uq84bSWXHgUA9nEHcOH/+IvcAGNJy1/5/kqRdHCxi4JPRJ2FGD2N4LZvCtahVFI4L908nnS9eIQDn1RiVLj2bhNzzW1glz4hevxrHR+EsPD2ChOkUhOLwdTmuUOP5wYszPlG+dhSEST3yVwT2Mc45QvLnCxXsELBu7ptQzgbnzFgDJ2ct4epPEez8w4w+Chvp2e3TCfK0tIDP3;4:BxypalvYD0BDQRIoEfNF3xGhSz/1E5RqvaRNUcR14KrF6BqwRfj6L5oTAejluFwi14d1wRh6mOeOCfV3eLLB8kN+O95S8XVkIOXYCEK6F0NoOMEeWkjTK/kja4heamQZzLtbswyXMt8h0yFWYp9rQpjIFB3I3cpusrBiMO94dylIh/1FW9vcW/gVABvZjPHZCCzWyUhZAs1s3hK7DfOCcxFTmwCPcgWH/iEe8yL9H+WssWmPr1+dzcc32rdfHJyqACL1Psj3cLf01sd8DkWSRoj4WkWx24dGwujfoaset64iZ0DJITI3+a/LClIaeOMt
X-Microsoft-Antispam-PRVS: <HE1PR04MB1034C4235E1F61AC348A4C67990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(14444005)(316002)(6666003)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:1EW3TzIbo14W6Lp+xCe8xlc/gcoxCYqGb5xQqAHZc?=
 =?us-ascii?Q?Cahmslkg4tQt0wuCSwYJH2Qk554DwdolWaeyxykr2yEAc+937BlXb+fYEcrb?=
 =?us-ascii?Q?mqXI1yVN0vknufwTeb9tdrztFTjkNqdhV9KFMr8nM0OjLSMrZh6Vhx2pFos4?=
 =?us-ascii?Q?99rQHs4LoZi9CPT0aeuJJNFNlHW95yb/LKgzxKA1R9znDC18Lmw6/quzN3/p?=
 =?us-ascii?Q?4bcQwh4ueyjGtVRbKHHhuF6CG1wu/VvWPvvdtP5Q1dB0ECtr7MaxZYp6hDha?=
 =?us-ascii?Q?VXEZwE1wyG3DkTJpUNW0lTnYeKEF1wpfFDfVTf1GvGhYKW2FZzDxnfnev2/5?=
 =?us-ascii?Q?Sz7TcCWPg5MpixKDu9El5ivPwtY7kdWlgf//2Z4jq6J9u5b9I/Z52ZPT2umt?=
 =?us-ascii?Q?lUeTlpzCK4gelYqtovTSuE2xHPmbhyJtvmZRYqHKUIGZSTC0sNfxgmrbRb6P?=
 =?us-ascii?Q?6Eku1TGIdTWhssv8+uipCrBrtR09ktpoLKjj1NGTD2AAhsCJvBHYUZY0k0e5?=
 =?us-ascii?Q?g9XSmGe4jBj5yhtrJGksS9DIGwKYAQdUzLa3JGuKso7Rl8/UsV7PhJzD0y2D?=
 =?us-ascii?Q?iFsT/tPGu+haTyejr602Fpr3HV2OXTx1PRNL+6i8nCUmf2qi0pJq8BRSUW9/?=
 =?us-ascii?Q?BkPFjyhjF/obX3bD5joHdUiXYcW1P9G5b4qMMZwuOimnBBeKXcsmwdYSxISg?=
 =?us-ascii?Q?tAzCojxth7VWz8GKeExcIPa7sTEd7DS8sFgq8TEAq2lJpiFB97QN/JXIzunr?=
 =?us-ascii?Q?tBQ97sPGDuThev579j0VIdTqq+g69oA+CZwUlo+t/jkXiA5d92i3pLCwtAqM?=
 =?us-ascii?Q?tbtBFYofsfX+dkgl6nRoVKRGJ6C/M5FCfcECD5lNzbc+U/gVGuxNu2iiY88X?=
 =?us-ascii?Q?1yej2b/FHGiHqKzrV8QgObf5rXIlcZjzFP2VhtQDhhRKBhFXdBolKvfFxz/L?=
 =?us-ascii?Q?AHxpM7FbEhZQhYuIq/sf9kLGhdJADPBVlz+Jnf4cmAbgGQNyamj/iJsEYWJr?=
 =?us-ascii?Q?4I6eF8LjbglZps+QyPwg25MGdKTdprzaP5/0xCiltANlGexKaokpsvjBaubF?=
 =?us-ascii?Q?WGCz2OhqfZ9QhznfwUGWqB50pEbZxcIYPJdWaYsIxFgm5dfbKKPGDWd7Ta/p?=
 =?us-ascii?Q?yhYFJabxPfT+ttflkPJK0JtJW9JsO5vovEnDF5SYCWKA+nFKAOkzWE68GCWd?=
 =?us-ascii?Q?GB9axzGBlCY0wRkY6vAxZylpn9ciR8lWc3l/IDr9le3eGgg7W9Yg5fmuQ9bX?=
 =?us-ascii?Q?UI8+f8V6jfa1VasOrj8665FayDRNHWhx61YVpnIJTvGhEOMjpZI5IYnIEMcz?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: +/oR8swucPp+jjlFRN5MgitA7YrkeATnabYcd9RmSOALGZtDLczDrQcaqCwZgBobDMiasAGvwSmEtKCcj4rcLcqSDVM5TQQBV043e4dp5lkcJ7MCHOQ2jhsgGEb1vP1PLPz2xW8bv5rDBn/wl3U8t7h2ZddqWVYIiwuNksr/lARMFpINJNve7M3hF1IuINlgYrQCe9jZx8pDBDyztNshNOTVjlVfjzJSok+eq2P7Nq6VYev7bSp4aitBUEOn+y6c15/2IkHJYl3kyyCvFe2Xl7+3d0OgqY0GEbIx9Siu8h7G1J9HDnFnqiy9rBcFPxpwIqiraZLet/pdF2qLBxmJIQ8VNMFbbVUuxik4a1cg2XY=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:SQsA4BjaqTMudg1LK4FLaEIYld574guSe/k5nwx6okzD4trDMv9m3onFZiA4hrkoM5R5N0YT0CV1/s4Y4K3Hqmu4BSOwIx9h/btcPKUGrMRuH6CdkMS26X/9jmMIfS5+sXRu7oOYte8ZXwNiSJ7DfdAiDZgVbeRfEJYimvud7g7B+IPLq8F9EKMi7A4EfJi271Sp7uWwYmzUwXcRlGVzCTGyHwBrv6oTLs9ry3P+xtZ7+WqjmBacTPgGwxQvt/5bnH4zIZiU8x4jELfyTUYNcSRxDaO9Fqr0hc0H4Z29IDaFVC/Bs+7kZpQp5B5FALk0Yz1ZgmmyoeDKURGoEvuFsWL7bovkANZQcTWKkL8sFVRAtEg35jhxDSVz72aDytQo9Y5gUQd5FCwRqKgrYZrL+m2Cb5UPGOCB6op4JABXXPRTioGSxW6zIHDCno7dCOuxIYoTzrKiRJMrCPOHI2ULwg==;5:WYLV5HO0Not3jRa+tQpUT/tNQoh5CFqSCJofR8SxFx91Z90mNHWn0CZSj1gNCJJMeEO82RZDbUfnRrBX0xJyuGh/sbDj7gdax9+6bc/HrHVFz+oEr6bWcMCLjOan7PjzDIFlNxGHH+/MBIXtvzYFWUIgJo3kqADUmGBYRq+/aKU=;7:R26iZRlJljtbqoScZspRZfWO0YRkLyX8RWxvS5HK1qjJyMsGTrk+BZJ2JqhqEfc6Pmn65QhZrbvX73aeusHbc4Z8N9Weu01PuoyGMY001NX7J2lb1o2xs/DAeVRtRflVtv+X0DAdUhLZpXJoatPVWyFS/yt7WUBeqe4zj4AzgMndLguM7nP0AGWTkR3GiMwgAvt5qJxnky3fJxEnpyVc67xYkuFf9C1DGN5FtEH9TuM6xH4BNHObuMvmbRlDsGVn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:32:16.3412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a232d2fc-ae4a-46f2-1655-08d60f2d086e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add fspi node property for LX2160A SoC for FlexSPI driver.
Property added for the FlexSPI controller and for the connected
slave device for the LX2160ARDB target.
This is having two SPI-NOR flash device, mt35xu512aba, connected
at CS0 and CS1.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..3646315 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -32,6 +32,27 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+	flash0: mt35xu512aba@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+
+	flash1: mt35xu512aba@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <1>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	pca9547@77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e35e494..031eb26 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -568,5 +568,17 @@
 			timeout-sec = <30>;
 		};
 
+		fspi: flexspi@20c0000 {
+			status = "disabled";
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <0 25 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
+		};
 	};
 };
-- 
2.7.4

