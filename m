Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EECECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49291214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzUC516K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49291214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeIQPSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 11:18:04 -0400
Received: from mail-he1eur01on0064.outbound.protection.outlook.com ([104.47.0.64]:36864
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725757AbeIQPSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 11:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7LEBYYERyl8uAN1XZ2vuufzbdRNxTStgPhAECOFjXc=;
 b=UzUC516KlOmos++dxVYkLLFmnOMBTsC8opQRqip0AtuwwCrfeY0jKLOpJEokPKoAXSvYhG2RnNmfbcGvdDkVD8gC1NQk/ZG6iFiR0hA+Pc3V1pCHKDjLffLVvhTXEfq90MJLb1vK+Ik4z/jcfIjXDW6FdoUhVhXn88bZSprBy6Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.19; Mon, 17 Sep
 2018 09:50:31 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH v2 2/5] dt-bindings: spi: add binding file for NXP FlexSPI controller
Date:   Mon, 17 Sep 2018 15:18:27 +0530
Message-Id: <1537177710-9379-3-git-send-email-yogeshnarayan.gaur@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1537177710-9379-1-git-send-email-yogeshnarayan.gaur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: SG2PR06CA0201.apcprd06.prod.outlook.com (2603:1096:4:1::33)
 To DB5PR04MB1030.eurprd04.prod.outlook.com (2a01:111:e400:510c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20152c99-b117-49aa-7513-08d61c83050b
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB5PR04MB1030;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;3:3l+qIqnQOzUmIKwG6lude8xDLUAFL53t8IwedLTaGOy2TxJ5c71I907SFVUIGa+k0GMTnKBcxKCT4yBRlxAsD8nM/LzseDoQwWDEQjG3YJSR4zzsZtp4iOlSFFTB92B8a9eitWAKxRcG7ut0x3NP3T2ffhmFADL8qXuKfZlXaJf3Xng8N/KaA+5vJiY+J7HV/d0kaVBn1+CEarxJ1/dl93yCLHdOpU+RWah1UoaquHe84sBlrPt55nAt5lzlUV1U;25:vYvCRIkMSeNIsrRpswo3EQP/fB6+68H70a8MxwQHB9t/q0I+Gez13RDENTjm6ayCnA+kwpqXXjLEaerXWAy905Qa22KhmRTLcoyzxkVqMQ4hZGITZ5PVDw0OvPNTSFvvdCYhJfDWrRapd2pMMmIStdVi6yIFO8q3PUYMN/7EcavDztp5NCIWkAkFe4kmFe4S+o9WlIPlzBIG9iC592iXD7KuJdxjMmA120F++XLYwPar0FKi2Wt4masIr9s6qhRpg60L/OQyMYiROe2uwaZaZSX0NwXPcao8p8GenAeiCX4/5g6xMjj3ZHySZK7wulA7oX/nNZVtfLCSJ3/Td8mdXg==;31:tnW6gHO66DJpmruiy7r6gbbCcPJglEWQ+ynxZTJixPsPOlvNbPjcz4Yiro4WQD15t2p+yAgdUPhbH++ngVEu2jDzDeUq4nJxrxPwbLL/vA5t+RR0rG330T5ZSMRb4E088MSFWX/b+8iXodOiYmtnjYxHkp5ttzUUXlkTt7XKduYZ9fQ6cVfjn1QF9ZdNyuWfX25Reb9b/HEkVwW+Q7gvf3Vru1DW9m6TnG/YWWC5xPw=
X-MS-TrafficTypeDiagnostic: DB5PR04MB1030:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;20:jmhswYeWF2wBFPT33fa1Ef4L9FgumKldlZDdZuRn6aZH0WOTfIYP+9OPIXH8NG6t7K9nbXjWURN1Owblai86fh1R5R6liD23kAzWPIgymRYmAWzN6lbCDR3k5x80U1Hod8MqUNlEwrs082YxxH9o+anReWPhl/6P17jGtmvrGYGJ9kBwzvzHSEQ6JONrrn1syTEzyx2GSpVAHYKDbQC+ejvjEPRWYsV9sFLS+bogXNC9QSYPx9J2EDJ0pLEfn4MdVeAIlflwhCcGMWzi+FSKbNGuiZYj0+9bj5q0zZ7TKPmhSnN0t6JjUoj3WzF6pZKXuzZeZr937Df21jOO4MD98sLEQ/9PtK/LJ9hyUI3ZFePL3EiBbiSCY9BrLrVb6yA1IYuFoNSOnEwhqUiD8s012VLNPB3zXrNLm1OWNuHCtH+Jbk7D9Z+gw24uwFk3w3CP/7Z4FfYCIBiOG67fjFz+ScYcytFBYEl2Mlg4Ztj8cyq+7lkzl9cskrWwLvjBjgPj;4:2YE/hsvG/4FQaTIgql8xaJvzTSHffadlKPn16kaEODlZM5/RW2IID9ppO3iW23GaepO9EelVjTEHVePA1y1DMOrUxQj+rWiithpgOBX/s8ka/FBVTc8V7YWIdbZ+C0U6KSn0KUVu9aDwC/Tt3qx0OWJ2Vovv8xdQFWzO8J/oREXRm32OxwPzHEp9x4tfRRKyik9I4m3Oj+XW5UQRYzuGNGeBiYhJPMc0KFjHAEbsLye0FmcO3XD7qbCZyrWkgGQH+/gZwmVV27sb3nRHvydgShISu1jp+8p9zdrR1Rfp4K0MFAp2ur1UoR9Zr3Anm/MA
X-Microsoft-Antispam-PRVS: <DB5PR04MB10300AF7C6D5D1D17950F9DA991E0@DB5PR04MB1030.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050);SRVR:DB5PR04MB1030;BCL:0;PCL:0;RULEID:;SRVR:DB5PR04MB1030;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(189003)(199004)(106356001)(7416002)(26005)(66066001)(386003)(47776003)(316002)(305945005)(6506007)(55236004)(6512007)(6666003)(86362001)(81156014)(186003)(68736007)(6486002)(50226002)(16526019)(105586002)(8936002)(16586007)(51416003)(478600001)(76176011)(52116002)(53936002)(97736004)(8676002)(81166006)(36756003)(5660300001)(7736002)(48376002)(3846002)(39060400002)(476003)(25786009)(4326008)(956004)(446003)(11346002)(2906002)(2616005)(486006)(6116002)(5009440100003)(50466002)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB5PR04MB1030;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR04MB1030;23:3P3xbeMYRS20KLC0jSvPmDVc9AGij4g60X3k7JQVA?=
 =?us-ascii?Q?OE+C/rOMD9ur2huazQd/Mcs2329vGByLMoPutrNO+zXG0ARC1xBKSMtVlzwu?=
 =?us-ascii?Q?4TWP3aIlfW6f7myeeKYJBl6NJexOFn6HUc+z3/zYuJ2qoiRwBzEB4yroDbAT?=
 =?us-ascii?Q?YoPw0WhGyP4EdYT5xDrrDCov2mgKP26szUvKV9GEfMv+D0JLVSJMOh9c70Cr?=
 =?us-ascii?Q?wRAncQVwyXqAWfXMbFBfgbBMbKq6iPbdqGRtLZGqsTcm+x8s6wlD2s8auwO+?=
 =?us-ascii?Q?foa/AJd8vxtH2Ytj1msCPko1+4ZphD1vbSLwRuUk1DEusqJACJqxDWIToxVx?=
 =?us-ascii?Q?l6FTHl0cFwl4TgEAUtE6cDNsK/m0LO0nB8GWp7WpbR30q/5Y4+Tm9butBH3S?=
 =?us-ascii?Q?AOZzXUQNHa7rA1yGiZqXHWVrRdjIC4R+DS7FwCJdBy8mUHsS7vUKQKuGUpti?=
 =?us-ascii?Q?wbWKSsGHzatZMtW5nJTBCUuxGAOhVGEGeF0DC3vsJfnjeqSgyMk5haolDzUj?=
 =?us-ascii?Q?DXvtPNmbx2i4dFdJdfq6ez6Xr08/qtW9vDi5IxZR3dn/8ODxE74IjGu8NJKz?=
 =?us-ascii?Q?AVNFxIZVwYzoaMZm1W68yeDWsHvLp/pC4y4vU97+CXl3GVl5ZpDK2sYAv766?=
 =?us-ascii?Q?LscRKr160/UVcRJc0TcFoWLlbtGuNLWAQSwQW3yRIgBahjMEFoS3LX2eSi2e?=
 =?us-ascii?Q?dGpfdBnZVW2rAh8g/+cP3bpl+gQEeD1V8ej1K0QxIoNi2c2oeAIjFWjN0ppY?=
 =?us-ascii?Q?Z9Z34AjGCpf3OAm/1SvYTvNOplOuA+kUB2I1els0snzGXreBiuBGZxsC/9I6?=
 =?us-ascii?Q?yrNZAA2FXHBcSQYFAsSFqbAVm2LTtgK8CL8Kpyqid9Q8vQrP+96rqMneYmGg?=
 =?us-ascii?Q?QSA0YGW9ikD0clOiN6+4ncasyxP0lye7UE1RBBYscfHHOYGAlC5ICKoV44r7?=
 =?us-ascii?Q?Jc/M2a6L5jN+0FsonoUjYdYc8dW5e6Hl7qf1a8V8CcOQNci315bxg7SP9OJH?=
 =?us-ascii?Q?ImyH3TnGNvp7j+GJ7bJKhDKQbOsL08EGmpl59WqvTsLZpgxVcuUW77rrUG53?=
 =?us-ascii?Q?LHDnheoP5CWTrOzcBsQnbq906B2RUx9Ct+NOA0+rdbF4wlmZNS0DoxPe/kqu?=
 =?us-ascii?Q?EqLJEyyPVzYOB8xFCEe140wGn1P8ish1u30FuZicN/GKDx6yXdie24VUrfWv?=
 =?us-ascii?Q?CllX4BVYsuST/zdRjszUD1O0+N9DlbBAkj9KvOQslEVW2/sSwYAoL0qO1WXp?=
 =?us-ascii?Q?Nb13tyNxTTCS1y/2LEVbARDkzIPD7VPrcNrIe6/?=
X-Microsoft-Antispam-Message-Info: /nH4Hxho+k1kkWc5iJkdzdBtCOsOE/FpyQbV0LyxcA6UKAeFuVThLAcNOK6zZ0feNs+rh8x/i8C6l0807QcAIq2djId2pz3KAMVOewiHeoX41W+USlqB919W0Zq/2EPO/rksferefn5ChRAK6BEsurQ6HlUoE99sRDJE31I/sFi5YR18dGjf6gXnzuROCaN8Xu9bS71VPWIBUDc6Wh4bZW0myrahNUiMFuSRy/EdhA+9+2MF2Zb+W1fJwD4Xq61/h9EsYy3DhpvZmAGhJ9f11XFEzC9T2ULgZhI2bTEU1wM7oV4VWLk6dTEFo0XzT036faQFtJXct7kGNfDTF85qWd9QUS2VhZTxlQkTJflh2mE=
X-Microsoft-Exchange-Diagnostics: 1;DB5PR04MB1030;6:YZ11aqiv6U1oRYy0Ayn50E6KRVdUkzL8LC2+gbARbP7MbMHA6ZFRAN8nttSZX75uJMNQ95uEOJDfpYRFPwvNt9/enTxrx3KT1GU7jlkQLDr2xXajHf/p/Yq2KL2UWPKUmHKMssrLnI0xYDy6sEjtPkuMGXlikZgWqKIH9apj3aNr30VT8nsXBCDIvtbPY3isxsa1rBiYjPF+BPA/pGXDVgc3pM0NNjIC6MfwSSa4LVqlr4h1B5rOlWHHDI3Egmncz3p3/EEuyWE57RFztfZQPK6omcg6hzAuDCNtnqspRunPZSmsD5mbZpUBEGFiPID4ebQ7oREErKOPI6B9ZdB4eVnrQ5j9ZbuW84Hn6fQ5GiuZxoEbmpJjGYiSX4ID7Rc5SWz8EZRdqbk5mjIy/T/7jx56TurlNdAZNh8EsOEsXI0Y4OvctGjg7HeBKtP7w1d37XB+b1QTBlaibHag3I9Y8w==;5:niAu8N6Is23hpjYIuMbcwMMiNbUw/zBSIkHVhMaNwTEgrLtc9TrEewvbHwvpaaZDJOpYYPmyGa8TbOM8bSFM7iEEcrsm/49EZansnTVHJpoRvpwn5QsHsSOGBbI5cvJ5JtRgGGvuTp5tLjQxULyRdhNG47/X2yDszmkwivi/DKg=;7:wnyjE1489OrGKG3BZUNZQyXECoJ1m7OeFKfAa81am25CMw/DGDMsNupjkq1ntIr9eRUq+mPS/A84oSfG/eEIZGl6sfs67suxc48T6EH96KOJA/NL+bWivnNRLkaiUXKL7nh8JtMuBMDQgTevzdvbJqP68Qgto/UgaoL6ig6HN9WtFAJq/vsfcqbEMSz8BjQMolldaLOjm9bWxvN/+QGFF73TtoxKV7/uGOGp1nCMgE9RYygbPxUZv0hBWuL+l82m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 09:50:31.7935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20152c99-b117-49aa-7513-08d61c83050b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR04MB1030
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI controller

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
Changes for v2:
- Incorporated Rob review comments.

 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..94b5203
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
@@ -0,0 +1,42 @@
+* NXP Flex Serial Peripheral Interface (FSPI)
+
+Required properties:
+  - compatible : Should be "nxp,lx2160a-fspi"
+  - reg :        First contains the register location and length,
+                 Second contains the memory mapping address and length
+  - reg-names :  Should contain the resource reg names:
+                 - fspi_base: configuration register address space
+                 - fspi_mmap: memory mapped address space
+  - interrupts : Should contain the interrupt for the device
+
+Optional properties:
+  - big-endian : See common-properties.txt.
+
+Required SPI slave node properties:
+  - reg :        There are two buses (A and B) with two chip selects each.
+                 This encodes to which bus and CS the flash is connected:
+                 - <0>: Bus A, CS 0
+                 - <1>: Bus A, CS 1
+                 - <2>: Bus B, CS 0
+                 - <3>: Bus B, CS 1
+
+Example showing the usage of two SPI NOR slave devices on bus A:
+
+fspi@0: flexspi@20c0000 {
+	compatible = "nxp,lx2160a-fspi";
+	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "fspi_base", "fspi_mmap";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "fspi_en", "fspi";
+
+	flash@0: mt35xu512aba@0 {
+		reg = <0>;
+		....
+	};
+
+	flash@1: mt35xu512aba@1 {
+		reg = <1>;
+		....
+	};
+};
-- 
2.7.4

