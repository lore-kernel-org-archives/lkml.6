Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D696ECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2B62150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:24:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="xVcAfuWc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE2B62150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389981AbeIUQMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:12:23 -0400
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:60704
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389815AbeIUQMW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plsqGgYHIwXr90wtAnQFylXbH19Cd69qcaDm1L3q2dk=;
 b=xVcAfuWcBTl08Wm3W5iOIa8wOzg6pVmVLgCzrtYa8JRAuAqjK9ryExj9q5kg7lLypWZdN7FaA4vo06W4kIDyMwTk0AVEf4et8vIUmec/5IUZkTGubs1lJjsTh70ycdBF45Mvm8uxa2B28hKfQWQRy/RmMLuM6rQzDf+6hIS0PoI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 AM2PR04MB1028.eurprd04.prod.outlook.com (2a01:111:e400:8443::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Fri, 21 Sep
 2018 10:24:00 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v3 3/5] arm64: dts: lx2160a: add FlexSPI node property
Date:   Fri, 21 Sep 2018 15:52:01 +0530
Message-Id: <1537525323-20730-4-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537525323-20730-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To AM2PR04MB1028.eurprd04.prod.outlook.com
 (2a01:111:e400:8443::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 507b52bd-c6f4-4e23-de37-08d61fac5b9d
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM2PR04MB1028;
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;3:f2GvDRlD4Jq3ugsQOcByCDNaZvtDItnK5LpIf2oSdHtKPgPNvQrA0cIt26/eM6JYTuwcsqDwnExvsN7HopPuweDoI0XAuDcW4UaPz2py5oGVjCXv8mln9aVi0ZEpZqA1uel+GMSMjvsHNRBRF4ybHXnheFcdePrn9Qrsv1vF0064IrZjnxHmtjQLm+vUbTWrCQzRBzXUk7q2huOP0cdQZHfQFHR/DP4GhM+iXKoJ1P+4LY+ob70ZIcgAqCAW+5i2;25:3mJct8lJWgi3Q/Tw5zu7jRQGVoWR+pvJOvyPNlyWgy/XfKAr+S+92/EO08pxHYEHU/3spfirDYr6X50eBRIrhe/DfNKkCqrRD/i/Q7jKn8MKolTMG7Ht7Gg3qulYcaemQwjBik9mhFht5IHTX1/sHx4l+9KuV7JEGlnKlV19r3/TUX/tnP3gtovYppmZOTUipv7lecw4tBG2mGfIRE116crFyJZbK+ybVF0R+vBkxlMH+ZSH0AcTUkpV0oFVWR7i8lk09rnu7Y8jJ5kIhBWJ8ORf6YKVhKfEgZzbYaCMuQDLf/YlQiaXcfbQ7dQgdZKKvU46pAUsd8LXn3zWU3FU0A==;31:UVsJWqXieK0NoDs2017j/Z8ZdFpjOkLvOGnFBRO7r42/AQke5gJAYjNWfmsvqu63OTnfX8KTUvSOHKaa+PUaCkIuUU9Cu5D69ZZKw/oCmYyT0ObygW7bpvA3RIh9qTYs9TP888V3pTXZXDwrqGY+339R9Y8sEgLsPKz+fDerL4WcUMxY6hlMsn0xgT3fqS87iwdJGtytzFDbPV5mZVuUU0EeZaQiYksJ4jtiPU9HMgo=
X-MS-TrafficTypeDiagnostic: AM2PR04MB1028:
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;20:E/JBYutmaRKkoSn2LpL7k4Hnxfthlh46czKl89Fgff2X8P7kh5QiU14P2W8b8zwwGuiJSm7YyIJ8Ho12PwdUImDpKIdXDhaCllkcakWg7WqVjhBmPdW4LNb5GRstbR7RZQ4DXSIUcRq+izV/AZ1JeLeWktsKAtsfrHdlxd+ajvF8YHszsbPiFXST8LYz5lOTCvEjg89wCEsc4iPVTMfrL4qC0FIEjG7tnDvFsLjNlgNk81tCiJLgT/vlCirBQoGw4FfWlaR4gOUKRuIsAs+cdXXuTW5NZ3ETfPGKPqLyQP0axuxDlkwU8wWdjzjHbxnk86BcwuK/4MwAY5kaYMML1HKhmwvWtr9uVNFycrP1wTIa0J0+38WrCSwsriqChoXCewf5JdtCuN8KGJrUqdG+DcQFKqLMB/uuJI77LqMIIZpCeXI0EUf/6g3RNYf1j5GCSHZmCiz+9cneuFkWnlfchNTHsrkgppNBGNdJYh9srNunafimH5E90W/N+3ZngbWn;4:E4YI7txgaWsAQqRT4l3LAj1VGsmf0uB8V9VBAPN82XsYSpByqyU8ybOhfXRCMF+zbLuF4pANh5rX/lea3RW5QhASBfNR35LqA6+oDNJIMcUMBbPMH0IkmxQ4pfvLu+AKTINdUe94Cj+HFafBatRUdxbKzi6t21XpDq0nW6OJOB6U7/qt0lmlnR+w+4PDzhyF0j3yKvskWnqdNUUoKtsxo4P0LkdSgEAiQYUw3yVnvEmXu+Jq2Lwa0FhBAHAJvVZjLp357Ej8yW4StEcyG3A7eSi26AIZPmo2AYhKZaHhfjN9Wm9iAU1HdALjiYLE1CAI
X-Microsoft-Antispam-PRVS: <AM2PR04MB102888E0F177B3D9F5C8557F99120@AM2PR04MB1028.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051);SRVR:AM2PR04MB1028;BCL:0;PCL:0;RULEID:;SRVR:AM2PR04MB1028;
X-Forefront-PRVS: 0802ADD973
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(48376002)(105586002)(305945005)(2906002)(6506007)(25786009)(16526019)(14444005)(186003)(81166006)(66066001)(81156014)(8676002)(316002)(2616005)(39060400002)(956004)(86362001)(476003)(50226002)(26005)(16586007)(11346002)(486006)(6486002)(386003)(5660300001)(52116002)(5009440100003)(47776003)(51416003)(4326008)(76176011)(68736007)(97736004)(478600001)(6512007)(50466002)(7736002)(8936002)(36756003)(446003)(53936002)(106356001)(6116002)(3846002)(7416002)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM2PR04MB1028;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM2PR04MB1028;23:9FUAIqvzTAxu+scZl1SbC2ONL3t0SQYyJlOj+F3LS?=
 =?us-ascii?Q?KFj56CEkHoQpIvYY5+hmmhE2N1bI4YIUGR1L3H8/YE4kBPhET80dXKyOEKX0?=
 =?us-ascii?Q?PKH730dc6w7GNaAx8+17i4i0iTpRzMjHhetl7+tl9y1gdtXrh2Nfdcp0SgSB?=
 =?us-ascii?Q?DZvejR7n+G1RJRRFpyl0nZSVkKGC5O/M5QHBWyFkpEhBi4R0+llQGPDaViPv?=
 =?us-ascii?Q?RXeRqV8uhH+gNDCXcV7FedQ+SRfA2AdTLRlqSE9QiD0fDiyzK3lqmbMj7ysi?=
 =?us-ascii?Q?ApXMNlkWuv6zIt+wL8Qhqf6vHaniFHEoO3NrV99w/YRIa2MQWS0DlCbQ5WQZ?=
 =?us-ascii?Q?DBZyCZAWrglbJzWXneP8UJZrl4lnl8IcgAaP5MYHSoVuVifMyecRhPzX6vgS?=
 =?us-ascii?Q?cYvI8bPwiTkCghLtAE7Uv2T3IRIaJvLrxYG2oc8oaL8uLscCLiJYCP5xbuEz?=
 =?us-ascii?Q?AGXVspCM82QrRsbglhTqCjb7Ow2Q5v6toJ2sOkeHxzk6eKlmdwMxPu1u/itu?=
 =?us-ascii?Q?gaKaH9o8jCs3wo4tUfUX2hGgXslsxVo8Y7Fc92PLxqWd7C+CXJt/Onv9VwcE?=
 =?us-ascii?Q?K2yoMVXh60lN8YfXy0KYbCLUTf7y7upC6jTMqDlZesodbe/jsIPfC/DxYGPW?=
 =?us-ascii?Q?Y30eWa8O2yrS02wdAv6QlGjbS5bwGwXpGlDUV4pqSwwaYdOVSlQzUaiHbIJ5?=
 =?us-ascii?Q?0DXUEbp3vyC7M5ni9ug253PEBO5wZMfkCWtrj2ZPfk/PV6C5DWbYe8RHNi3a?=
 =?us-ascii?Q?LYSKgq3a6nHxuKfnFQQzmPuf2hCMGmIUe855HMxtVRGi/FVVe8phni49cTFZ?=
 =?us-ascii?Q?mgZUcgzEVZg9zwz2s+g7IGZZ45j4q9BN3iW3W6MHfu9+Kxm6XMAfRpky79AM?=
 =?us-ascii?Q?Wog9hhT+7BYUzPK8ipFcWHVWwEfRa2fUhwSYXEI6D1xUPM3EuLUtbkiNE8Yq?=
 =?us-ascii?Q?nEj0yV01fo8+UjSjhTNBWj0Dxj+Koukk5Ua6rI1ivGKCn7jaKsXWyIk62kaC?=
 =?us-ascii?Q?O1zETfEl+HgAPTtbTco3FaNLCjabD9Kfpqvk9YLvZTcN5QHDdu/NlnzRjfsu?=
 =?us-ascii?Q?pqzE4VO8DdtStK01HMEjKUczfDB1N1KO6J6S7vyxd9ki8v65jwqCSK80VTYR?=
 =?us-ascii?Q?I0SI4ZqwvimUZogfpfQidzUrJirV0G/M6DLvxE8WvmFXQ5wFg7TEIjk4p4xM?=
 =?us-ascii?Q?gag9eF7FPmeAxvbhiu/L2yZ7Qt7PjilJDf/BaUC5AeLsxEaS1Vn+IdWNjUOs?=
 =?us-ascii?Q?UtiLmCsJs/0J8uT1FY/PdCe4cub7JHKGI3AE2cBHxijO+nW2YMC5BJ8odw50?=
 =?us-ascii?Q?ksrA4K6cZvqOmwFcaHnJ1S0WPniyoqMoeKtsdEimSMovHpocppY//u8R9AKf?=
 =?us-ascii?Q?1wLjQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: dzj0R5XVqKfGhT+9f5Wte380MafImjQIsZL/gQXvDShLN3BF/mDT0wfDEq+oadAgdhf7l+Oe/Bkdno5dfzrSZhwMhA95try/SUWpGJ0IDwIwX03ctVzOXM6CL60VeZM62UJVlnE3SOS1+dM9iPd5CByy9UKwDgzigN5T4CWXPsGqx5tiFhXZYKWNZXIfJJ6nF0WRB0uBiMHHfTDsq2VQ0VHlRM6XP3hBsokAjQDzocm4uRGoSTjs+50jcr6XULVpN4T4Q2To093PrRrUB/Ur/Ed5z8RjMbCAMRtzWjKIgQVnRaskkoUc4wMQpM/FX6pe8+CdOyapy52r6CPqQASUaelHvfFEFXX0vUAGuIIoD+w=
X-Microsoft-Exchange-Diagnostics: 1;AM2PR04MB1028;6:gzh+SfZaA9VPS8d7bq7L63K4u+L6xuIH2uRdAVGNf8yVguMttK5Fx1YdebFJpRy4wnp0uiUeCT13Bb4ywMarHdlB4gEmCuIAmVrNOPArLR7ZhKIiWlaEzoUhH5tJCi6vfG0PKUCyfT4ILiJx8QuIUl1KC+nxWiZRiqmDyEAaNf3jHr5hX5fhXf07SuwBWOVx4XW96LiuE+Crdw1ClHu9q5pitESX5yguUhHUSyzFfvW4mKiGPUAhTAD4jpx3HyOpb1IjICX0qD4Q5l5+qxlUOMmm+cFi6nMUAu1aPqR5Z9yYkI95I3yNHk4P7WTKNmIMALLTeTKmxlkIVodtKB4nLG0/FNtLsi5MQR9IN7/t/1dfvSctDnIb8V2xREQA0iDmWpQtC25EU0iWocXuXpozQMgOcTa5Rzj5D9Px9IlmNaIfo7NsB1BTzQXkV2PxGEpVQk4o4NxTIR72+rF88mEosQ==;5:A9+iD6jXugz7PiS4JTUD5Bb82wi9MyjbjHH9OthH0PK8iCwQcLSpf5skNcz5eQvm/qIKoY7ImpNZmmiIogvnLdUEj3pNq9UWTcrLQ9STZLjDgLjIpWTtmccFtYaYQ3dxizCiBehUhSJpyTTe1j3VbqwyOUWPDfGdkAzN4NjqWdc=;7:k2QLYrcS8CVhinM0GMI1oFS5RGKwcuUHmKFXBJnDXKE9njNcHAeFmjLMsPYAanoKFNKNPbfKPdJuUp/YWWCyxkQUyNI21tLFmjvCJBD/caGrhIbCJ3xwJdRn8T66KJA/ftkgKI4qPDulgEx8yjibLMyTFg6EYRs6K1u5LHIUZoGNf6a5lgmUCR1FT7eWJw3KKdBQKnMkA0HqSE32KoBakXxfUjFscJKjvOFZDggaX3l1szDkp8mABd6oKm21Wn0k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2018 10:24:00.9340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507b52bd-c6f4-4e23-de37-08d61fac5b9d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM2PR04MB1028
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
Changes for v3:
- None
Changes for v2:
- Incorporated Shawn review comments.

 arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
index 70fad20..901ca346 100644
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

