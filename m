Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E871EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98031214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bSmW/ddO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98031214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbeIQPSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:07 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:36864
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727444AbeIQPSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PJSwVRpLRLfnV/rSncU2/z18aKpidicxCVR/4Cmsu0=;
 b=bSmW/ddOCC6kLRUyZOQapYEFBcRhEu0xQRiEQWb4g9nSqFDFYFUZI1vPc1RqLOCsr9hZS/zoFBlZMLYUWuaDrTTJHHLwtXox7TsPFDk0XNrwnRxRhOTkxFzkQWJvoEn5MdSPDzg83fN8/es7qN6R5qdM91/vktI88i9pr61fujk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Mon, 17 Sep
 2018 09:50:37 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date:   Mon, 17 Sep 2018 15:18:28 +0530
Message-Id: <1537177710-9379-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b478c1a8-af34-4be2-813a-08d61c8308a8
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1030;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;3:qn4nloV5zHqRhK3nY4LNjB9ijAWCywaOkG3vd+/BGrJzbo67n2cI6ATNa77dc/nheXDXM1fYD+FKyPQvzoSnUDZOMunN2RdTkvH2CFR9Dn1HlcIRNlP+GTZjWuSiktsQ3xSF2QGbxnuM5Jn6pphAKlSKPAWkhRGfMKIYoIluvePsHv15lruIJy0Pd0PWPV5kTF7iQ2sPqpH0u0Alae3QlMnfAVzJJR1wo3LG3LEyEsMtl3zJxNHrd5ldyIInD7CV;25:i16+PjKwhTLyxKRxf/BRvPvGoFO93jpahfSV6MQkgp7Sa6vO2bPVaed1aV7SzgcqI8bFxY6P5irZA4PanV5ev+HgSnY/Bw/J4MqqG55Hnjdu5mBPqwx/7UC1Cq/6eExcBqI3Yt2c7B8C4gn8cV9oTNQ6eRwGgTJt+LdbIfihOkXNSDGYnqQVnAwr0kF0oURYnvbpdbjJ6xLeEQflZrojZSLuhPfQJyzmdHwcS5GnsV0A7ZuGUzrc9aUgWbxyCwBGwvZQJaWqhKbx9mgsJpkKsoAaJ2eqwo1QlV3W827Yt68VX9g9m2spg+KzeRgzkTtmlF08Q/cafXCPmL4sSK0ABQ==;31:c7jH0T75v2SpF0Tamf4Xwxe76hMZrcDMzkuMRojY9I5aSUs/iuPGQnk8Eto+YNcCe/x+aZ12afGtYrvm/5dW7DnDRDJMYrMK+i7IHP3i/tZuLZuQBMElRgVc406dn+7TqKNEd/BVoTR/FsdfTBfYdj/o/1Rex9ybDAt4BNIhJ0KX5BbcGd5wy3Yoe6HVDiVZOXyJ/fpreaEK21c92CIEA3mJtrxYJzW9+q4Yt8cu6ok=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1030:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;20:uU4F35sf9Kj2mXAdMe4h8g8h3zId9FOrM2rQi2pNo5o9yrX24EnWVeoUuHF+GFC/4CXkHweUF9kKeRqdvTgZ9S/KoHRTkvZpoDGZuCUmfDZ3g/I7YHJydp+O04De68oxemWZ8wqPlDT/QHbxRipnSOMmWc5VPXnA+/lPHSB8Cvvmr32Iru/xcQMk/zvfE9irY5Z3YzZiJS7CRFKkYAEBJ74MkR5H9xzkGMyBEXlW6Uynoxg+VuRrG7ZOMz8C06Am30PDvJBkN/bL+WZyR/Hau2Y3aJJ6b3ag31o7KflMZa7WNnmGcx97bD4DFCAoH0TGSgVmG9ZaAkQl4bt80tFU2SQ3en2fV4Q8/sZy7StOB8z68tjSy1CTNKcAYGCP3Y3wMHi33bHCXGzXXdTrCTVKUChz2SB48paDaykTX0dKHpml6hSfLCbK22Ph2XewNeSB1dBPvxAM/n4D7xno/qRX89T53LO55KtVvcZiZ58E3Y4XpU6k3Aj+7YV5u9qw0znP;4:7ivCC/Pt4tmeG0KrD/qkUv0I0Ucd6xBBTMYhvhBu1y6PJFbKebe0xpmEhBw5iBf4il8c4esL5GhrJJoDmQ9EzXCwmJEKfKjxzbcragqXLXjPuhJONEwaNdMrUvh38R5qcXGLOrplh6mhLhtHLqhEfnKSuyb3ReYu2zwH6hFiF1Oz5a41BTej4BhcYUGVd5cDX7yiNLVsHnxz/moakLISddjf0x00XUkyEIboROB30Ivl5mOOxQFa0KvN1RqgiyukbjnabWoAWe7VUG5jeQOiLXJANyzR+ioGFAXQH1XwBVzDX/j/BbsJePkHsslLgUsb
X-Microsoft-Antispam-PRVS: <DB5PR04MB1030CE5401A2B70B2C11B604991E0@DB5PR04MB1030.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:DB5PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1030;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(7416002)(26005)(66066001)(386003)(47776003)(316002)(305945005)(6506007)(55236004)(6512007)(6666003)(86362001)(81156014)(186003)(68736007)(6486002)(50226002)(16526019)(105586002)(8936002)(16586007)(51416003)(478600001)(76176011)(52116002)(53936002)(97736004)(8676002)(81166006)(36756003)(5660300001)(7736002)(48376002)(3846002)(39060400002)(476003)(25786009)(4326008)(956004)(446003)(11346002)(14444005)(2906002)(2616005)(486006)(6116002)(5009440100003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1030;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1030;23:NcV07NytYluLcHiLZ2SGN3kInVKwefeOOw6NFCPJA?=
 =?us-ascii?Q?itn5dUruI0TrYFzyMglIrBFUXyz7wR4klyRbTT93Sv9a+L3ymzHbl5DpUthM?=
 =?us-ascii?Q?sMxpJ8N+ergmgiJGdv929hTyRcYdr3jtRl1jrpJ4M4D5Bzw1P5AgEWdCabtU?=
 =?us-ascii?Q?5TaFBc/PUbCM/PxmfuUvcCm0jjH9kFKmkHezRP0tmZ47YTdB5KQC7UD9lYaV?=
 =?us-ascii?Q?3W0ymM+265oy6zWNQ3avx/D0zZRceEtePEuR5IG2ufplgLjy5271nEWeQQUM?=
 =?us-ascii?Q?K2yDZC0uEJk4SONpqEEomo09fnopLgC5mq2cy/8KY0R8J9mWbIdVpkeUVrJD?=
 =?us-ascii?Q?v7Ths20j1ZDYVsCYtHX2z53XanXNYOfIp98iaaKSn0s/sLMUlvh1JA3hZ5IE?=
 =?us-ascii?Q?4TgKHZ2zgGiSiRNbswrtgB61cBqHqV60ZQHq2wci9/FhV5uLi7ZFG2DzeR/E?=
 =?us-ascii?Q?H2W2nUjHSfsFe06lbMTr4RyAtHi/XnooXBKhRenn+m4QnFiCi/miuDRXlUat?=
 =?us-ascii?Q?KDzqVZMI8aor7RepzrbkHJ/tqzRXZVY9mRtuJcEzE10Y6/PQOceBSuMDp7xX?=
 =?us-ascii?Q?GSnGE0KgB8aMlgD1BCM6oBZNNvYmvhUbUz4OP4Rj0TvjDd6a93aHVQte4MD5?=
 =?us-ascii?Q?YryB0z6B9J7Xeh2VlvuAxaWxOXGSMY7VSOLeJM21SIx7IGcNLxW+QDi5psNx?=
 =?us-ascii?Q?0GBf/Kn9CQdNA4hsAtzcWthNRV32C8ps9VGuD9eimyIXRJdbqN3SdSXlbyp5?=
 =?us-ascii?Q?gK+//4a7g+vZkvpih+ubBRzv/ynsA9f7bPehQvoBBO2b8WbIMZxWRlI5Aoe7?=
 =?us-ascii?Q?IEQqw2nuQmtfSvtGgYbzHX5OfEkgYmX9nxgHraNFx+B8nZGDoYKo0TKCufx8?=
 =?us-ascii?Q?tFH9805p39W404QViBDmNFEDnRBtd5s/qH24d7aR6EczhKaO6AYrNb++6Ves?=
 =?us-ascii?Q?bOVYEl12TsxhyFhwgcv+Do+C/Y1c/8SVF/XQt3va9oxICbFJxy80W+CozslJ?=
 =?us-ascii?Q?r9Wz0jPNWvFbjw29MSClQnEok7qvlOgLFDNG2jaGxnJZ7kCQGSpCV19mVPMa?=
 =?us-ascii?Q?i4T5czISjcsdzkCQpHHEDfiDtIFbDxsYI/j3jiPOK/1PaQE2tCnnty5pVE1N?=
 =?us-ascii?Q?j0iSgpVPAzZIevOGY/82GnaD24k92i6oL7FjvFUAX/kfhcNkvkGyyliFaUCp?=
 =?us-ascii?Q?K/HFxkvfnhOvBBQB+0B1A+Xpziya6hQvQ3dn7XH1mzim+CSCEooj/g/zRe9K?=
 =?us-ascii?Q?kMn4vjXdL5wiwy42UdA7KPClzBQyQq0O6XufoZ6qBqc0WX18zWGeI296QRRh?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: SRTVHzEEEtAG7jqQQJfStyCgHezJmV5wsh8GZqZoK7uY9bNd9ViKxEYNovsYULZh4DqifAN+EvKwuzakNZLArhWbKLmii5XxORmrImtwD4BOfuNwrHzRHjx39rWVgoSkFmVzAa+zWl6C2AHjYIqWm4zFl0CJSaGXni6gyMp7e1QS6vjA49OEl4lbvpW7m48O2XiXXizQf9eM+upP6Iu0fDDg5kP8HUbHegGmh7LuTvY2VApUk0RIM9yOdmXc+KrKsWAQQdCqoprwUCU1tKKG1QI75uixmYNdMMsr0SuOD1fpclgsDl1B1ilVWNU3DgE4eWNxiBBX9dkGhQbRjjrWvYsmUQJSsyAkK+jVyrgC9FA=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;6:C8U9aA5vcwAuE879Z+I0ar9P6IIi8GJnurbKspsDqo2JWCAbmjPGMsj9AGtMTujHdcUIu80vFjSWVmb3JVETg1Azr4FU0kCBpe9NCbaOaE0CUubN2m9ZqZmyUftL2K65V1wDDESDSUu5xyek0mopRfOeAHWPvK4PkygqRwd7VkGgADNiZvJdlyEHxJKUx2KoBF7KQ2RjPWD73D56EAxUKST5Qt4yp9X/fAeHHqblE/lUN8avCSkIRYIa3fhQx+nWFcUUye9+32lGqfCnho0YM+pnerz5enSeVUPx7gHhpCHdzmQIiRnzjv79UCylHtvgNibwo9QslagYTJFfUxC6P9G36bpdSQ84L9w8tYbV7pFdooJFVHQJhmqaPlbxR4lncEDPPZhcCI9RE+bH/V/xnWPIXLGv7D/jfTohmQsbrTeiPG5e/etyGk61ypVIXN4NxajGiAGUY5S6DcaA+UTTDg==;5:avSlOvMjeBlcfrPKBti4be4Y3ZYNZzPXDPNUnaD/aQT4NQmspCDf4CNCg1lHPd+ajyg+1HvnWpkHWf6570uSGDfzI691E14Roa2/wuUPt66R8GRohXq/0XrtaB21Vs1XW68NeeBqHqGvFrtFSzzIpgmlVPFIINENjose+gt6E5E=;7:sHJOFjJdDUFd98371Mjkx8dCO7mLqWGYpGStLvoZDkCxa5h5glQ0AtMM2Kdv5AhJMexZLOuyg3fLrbDSL2ITQIFI85mN8/q6/Nae8fHgtB+qDWm4D9gU10fpk6+fiEWHxjDbIxMVC2P3QIUkSPgr42rLImgoA6unH6UT/1znS23zEc6SBGENoF25G38ugcoZTprqKE2NOxNE8GeOGpYdAMmNUdPN3xGJJUj+MMfveMzsEeZyYXmWnIknhwhqcY9t
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:50:37.8559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b478c1a8-af34-4be2-813a-08d61c8308a8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1030
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
Changes for v2:
- Incorporated Shawn review comments.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..a320b37 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
@@ -32,6 +32,28 @@
 	status = "okay";
 };
 
+&fspi {
+	status = "okay";
+
+	mt35xu512aba0: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
+		m25p,fast-read;
+		spi-max-frequency = <20000000>;
+		reg = <0>;
+	};
+
+	mt35xu512aba1: flash@1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spansion,m25p80";
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
index e35e494..bd2d606 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -568,5 +568,17 @@
 			timeout-sec = <30>;
 		};
 
+		fspi: flexspi@20c0000 {
+			compatible = "nxp,lx2160a-fspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x20c0000 0x0 0x10000>,
+				<0x0 0x20000000 0x0 0x10000000>;
+			reg-names = "fspi_base", "fspi_mmap";
+			interrupts = <0 25 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+			clock-names = "fspi_en", "fspi";
+			status = "disabled";
+		};
 	};
 };
-- 
2.7.4

