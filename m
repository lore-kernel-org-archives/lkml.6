Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D8BC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F5920658
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 10:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aw9q9TiH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F5920658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbeHaOjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 10:39:13 -0400
Received: from mail-eopbgr30073.outbound.protection.outlook.com ([40.107.3.73]:60160
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728370AbeHaOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 10:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4kUtPczqq2ArRXHgp9TXPrxHOz33HfNwbLq0uZ1AI8=;
 b=aw9q9TiHHxAn1dPLAJYlGTzqLo93r0ukYhXTVE3lXsygcAijk+yisoXi6Rz1j5iftFo/TNYPLo6H992UCAWibfsy4qfxXWM1J1EOlnavCdmvG5O/WhaMNx6yF+bW8RJ9Ie6fpL5TO6/SQORhgmnjKibIjo/KygNfW1ZT67ym/Lc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=yogeshnarayan.gaur@nxp.com; 
Received: from idcbfarm.ap.freescale.net (14.143.30.134) by
 HE1PR04MB1034.eurprd04.prod.outlook.com (2a01:111:e400:581a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 10:32:10 +0000
From:   Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
To:     linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, computersforpeace@gmail.com,
        frieder.schrempf@exceet.de, linux-kernel@vger.kernel.org,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Subject: [PATCH 4/7] dt-bindings: spi: add binding file for NXP FlexSPI driver
Date:   Fri, 31 Aug 2018 16:00:01 +0530
Message-Id: <1535711404-29528-5-git-send-email-yogeshnarayan.gaur@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 993dc838-ea78-44e6-8c60-08d60f2d0537
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:HE1PR04MB1034;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;3:rNG/KLjwSKI4PEVRxsu6Zf3ZYYwYiOkuAv0pDgBlConr6KoksdCX35SPe/CJojl10jcWyZ4YjaWkPZt6GyWEu/KHjh2RJoOVezju7DRAxegYzF1RiiRYJCu/NrJmJIgHp2qlXr24orN2DimDYjiQYVpdXfNHihAt4wDPIya3OlSjX6WQtC/Qh7W88eDDm7Gz0ioLCuGdMfQtJqwa+xPqYwb4Yu4RBoX11JrUTCVirqqkeTxYgGlhg2qr++Zcpo0r;25:Qubxju0pBS2LUIr+Fp0s92v1CE5nwo45oHTGTPq4+hwlNpAbwLtvwwy5zs2chof/M9WRBOvl9vOZEea6frPqDEYIOLj5zNGP1O+ezUVecOnkgWuZe0Y/sZPdZbH1hBPQAk9E57UbEjz0k4yNsUvhjGU82tE5lEkFg8729GOVOIIxt0rdVMcUkv1sLUanqSZbiiCBaoNDUKy5iE46ZG8MoIkIG+nSlOO8aWx4k4ejXMFWdvKyAajxf9IHApdeWX/y3pnIwbYi985aBEZLay8TSyooYD1u7nQuGDWqYRzWbZwWLxL0U1H3BPMHqr4Gm1vtnuoZXQo+SA1MlGm9XMaNSw==;31:bmlNOcubUbgjdqjdVBSEG7BrVbgQDVlvWzf1G6f/6MtOzw2VYzt3Duy3wySS0jpN33j/s5sBBNvHW6yPDl/Vs9m9ES/hgf4hSuELD3vdq4xhysWrsXIgIfARWEIP6NAfPt/H9s1gYIuNO4yUlpKk7eXlu+dyPbyHoQ44P7ID8edxKrDo5ugV5aTFPbVuX0jDrpnlA7fkiIHp26ozXlNRMJ6lrVagvzr7KEYVuM/2F8o=
X-MS-TrafficTypeDiagnostic: HE1PR04MB1034:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;20:DXjSAkRBSvaOpriM7hzmU/sM0BZu7KXbNCozY9BFBNyhqk+YunNMm3b+/y+E/heUtN2CEUdP3dbL0QqLDx6MRG6yLwmxR6xPHC3Y8RvjjG9Hcmjsmy114gNWNtYvWjiVeIQ0ALNVw9eAtbtfwqW2blwNVKmnbtWvrMmyaSZ18ouefLYjZJisUqk/QPt/a+1whacoJprqiApxkj8BptmSCRtFr4VPV3MFgmXtLRglF0CtTvDaSc9PN6t0E2djgyBqwqUgA9pwnqGcn8eg0tP31PjDJSrVhdxakb/N7LejwRFlBsq5b43i6yip9OkWdeyutSKwNl8aGvk9eavMjB1HRO1299eeosBPQmfUyBia3gk3oJVpDwbvDr+cSa365WB0gVbmSMk+8r2T9virjm4ezV06Eg4anwxtv4iEybBGM2WW6o43xvS5zzFJDFwoHc3F/VvavT6UNMrY+6IcXwHul+8NIHQ0os0LOsoiJ8sVTQI+bhO+CJSe/mf++kHySF9r;4:Qj1yj6B7xW1TMRw7pjPqBbDOzH//QCGsYXhVAEjZvIDOC0AE6WAOr3V+grHh/kLiMV/EbsSlI83jmS4USWbMytsaA5/QuAW/+zX4C8/jqSHA0f4+7E2bk72jSdlnsKAP4q5pHPalhmx+gcIVUpNmJgCRdwI+813GSd20ig0G4rskUP1Mu48AHSChJYmj8Ot/FiIk4yEmvB2+6G/LfhScTEOyuMBZYuYqOKYrvvDN5xjlNKI2zbIng4y8CwpIjEZkfMO2AjMqLejhRVeRFbBSiFq/O/SZ/0Yhp7hXeOHPG3iIoGv69KCEl8//7zH6MWT5
X-Microsoft-Antispam-PRVS: <HE1PR04MB10344AF37D381B762A59BC03990F0@HE1PR04MB1034.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:HE1PR04MB1034;BCL:0;PCL:0;RULEID:;SRVR:HE1PR04MB1034;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(39850400004)(376002)(346002)(366004)(136003)(199004)(189003)(48376002)(7736002)(7416002)(8936002)(105586002)(5009440100003)(52116002)(106356001)(51416003)(55236004)(386003)(6506007)(81156014)(81166006)(76176011)(2906002)(86362001)(3846002)(186003)(50466002)(16526019)(6116002)(305945005)(26005)(6486002)(66066001)(47776003)(25786009)(36756003)(5660300001)(97736004)(8676002)(53936002)(6512007)(50226002)(316002)(6666003)(39060400002)(68736007)(486006)(4326008)(16586007)(11346002)(478600001)(446003)(2616005)(476003)(956004)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR04MB1034;H:idcbfarm.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR04MB1034;23:eXz8Rpaw3LOhL4rIE93ROFtnPYuL9gbTYiOsUfG2x?=
 =?us-ascii?Q?7woemzf3XquGURsCgYeN1/PlbhjOaAay3AgQ4vOIc4w9fZaDGeN3G35KDRK+?=
 =?us-ascii?Q?jhRU2R1adGl1ZPVlrvY/vXYo94LlF2jFxdp/f2G9BYzXjpVSIM6COjHLveh8?=
 =?us-ascii?Q?NymssIoytXS56uuRyk4WmxSVffPGsIsaEhNpOY0F2/RJGx6nUX5UKtn9yDxM?=
 =?us-ascii?Q?06KIcW3S8e6eLicIP4JOWpzt9dv0ReqAtZ4FYqdE89C+LfPJxcJizxkq+3Xk?=
 =?us-ascii?Q?bJONCV1+3yDXEmAKeQKb1kFIgYq6jZYFMjkR+j/mJm3Ik4flpQ8GCItNmIbz?=
 =?us-ascii?Q?iGLZkxhlnTR0HLP+7nIWhdwR2TLKy+b98Slb3sBS5sZCWbI3mlsQLadKo5qe?=
 =?us-ascii?Q?t07hzV8xOH+PX9S1hnQP0JhwcJUdKayRKEVxhBMHwGTxWWURylPRp3mdOei/?=
 =?us-ascii?Q?pCGu8DC9Fnye/T2/oT68i24JDZlbHVUUU2B8gTII8vNncx42XuXbwA///23a?=
 =?us-ascii?Q?aPKooxNYmHPEt9DRhYZocCe+jQyOMlmxgnMOpaoFfrjHr2afjGctfQ4fe7L4?=
 =?us-ascii?Q?DAUZI7UeWVQKQONS/MPfT97uhtgHE3uc51B9B7MEcJ1Kktz5zP+GkM/hQk4Z?=
 =?us-ascii?Q?ssm5U3uVaA23bZdFKBPIy2wIVhs5UhijuVh6NkK0YW4Rw0vSRkkKG8uAECP5?=
 =?us-ascii?Q?w4dUXcZ0OCYnZgAPkJiKlxUhad6P40NHunAPyek06jTGtvlWqYqBxlDKGTla?=
 =?us-ascii?Q?ZtmiDSsSQ2pWvUchaqfANcPw+AlcgFjV0eAr8NA8cwfiGROdNGQmzPUlXOOt?=
 =?us-ascii?Q?M130bkVn2GFWJLX5RlmwAWIOFV9nEiwA8EpK1SyGQ0BfIXsMDVHiIkHjiH9Q?=
 =?us-ascii?Q?3j5ZTQCuzHuzh6RwkG87FRXUBg7pbsXADLK05xWQBCTqtl9QWhBRVGv6s330?=
 =?us-ascii?Q?/RKdrXsF7XCHLQDJuY6J9kEVJ8bXuPcFTj6LRFOEpeNh4WiJRTYSn1YIuWmB?=
 =?us-ascii?Q?UEmrG8ypPrF2n2hErI5FUlEzAsyElLBHmXnmvw1IyxoWP5nHub1jkutKpfKn?=
 =?us-ascii?Q?J9XXZ/k1swNiPLEIPZVh3+56WByjgCaejc3CEC1gLNqhfRmzFDTtmJZlj9XV?=
 =?us-ascii?Q?4i0nyDsZdfI9TnAlLjaMUn3LULfIIBzj0fB+1bzo7O8fVt2+jjyiF4GCOAQ+?=
 =?us-ascii?Q?O+2Fkc1O/C7APsAGbeZkAN2ACAiZapeINaX1rKxX5jgMTQCvWAHmJ1IrJRTj?=
 =?us-ascii?Q?p+J2XFhqREWHdBm4p/pu1IP6XwpZ2NMRR5nj8SivPudpp+7Y64L88x65/uiv?=
 =?us-ascii?Q?KfGtwwa9A/xAxNSW2ak1hhSPVEdu86tZwdm2tCIR4UxSJstM/ChUIynPmmDz?=
 =?us-ascii?Q?9X/sUsyjlAoF+buU6h5ZeTZJmA=3D?=
X-Microsoft-Antispam-Message-Info: iWUWam7gA+Y+f7UQrpCsxrsMfJKAyoKLgyp5/ui+KC/r2q67dEQTkUSlZxOb8Nf8A3+bXwE7mTi3B4PsNeU4xHGN/eh0+S22RTjhl13m/myVwdJ96VWar3II95YUO4+m6flDGgf6TjCHTYUmJ8duastaeioQXec96Rv+a92Xw0ixvjFcNlg4puuMY1ZQOxKxrPqZq7+RECtVdozi79Nl/nmxagrvA0HVQn5piTBaRWk9qHgvumjKMlmPb10ukL+SvclWFpD1u1dIa/TjG/rysJYGzrtn7EB7ugPU36Urfii1wo973FNBDxFKcFVOXPH4yqjT/cUraFRf/1hvXPWx8dZ3w/Eg4BT9+3h/3ohLtCM=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR04MB1034;6:cXbiVwq/ckX2FCZ62W8Qp6t2zoUsD3VIhhyigedwNiQ1z6a8RiyrXw9Y7ycCcdo/nxrwfXT04taCx7X8d7YJDUgEmSMfOlwEF6qQDDsEGPK/KTHGxMVABnmrTTpKpSN2a9BZWJ8w861Kp8lh/WqG2T/47N3J2jcHX1R4qUsCGZ5cKkIBURVJQKRC9/4DYfygFaRP2s64SqvBF5hvAi8UiLHydJeYGMQ1gQE2oUs03ghr+djjnB0J4Kk5EZGwlwfsBIOnb8Y9iTULEJPz0qJdo7IWsSp6UaWuQZlpbJEadePPx0ps6gjzoCNwisPhnVtBGmFs0LJjVvfbZtwlgVn8q/F8oHfOrKQKnCkIfot8sYfGRTNz1b17jOd5ADNYcE3zZ8Ll70tSXr0RRIQWwcGjTCZUKhYrmG9fKVz3WJBS06IJXcpEK+Q8zain7P9CJcub7bLhrkYCZevbzHI4BW6J7Q==;5:c0MLmXnqy4TG2LUengyJ4TE0xHMq8wBmoERTTGb4IT5lm22VJW2mbSvPjy9AN69Rq9hn3tuxT54CpBzLW/cxPyGS9m/+2iICW+EnpGD5tvQDLy5odpeX63K5tzd+oILTKIymFHMNFkBXDyRFEHcZy9OnFZwijDhacW8jkiNE3fY=;7:jXkmCqOdEhDG7lcxvwFxBL5z44RheY87+3halvjJ8Zh1bMlVxfDcqM3IKFD/rIoGaZqLF3aLvQqF/JMpbr7tkP6JRmUhT0xM7gDi2DO6wpvnMcne4X/W84U9Bcc8zsWJUrZTvreX6GX3ek0fRJ4Nuzaf+Qel++SIIXm8Aly1lDtvJCoNCakG3TQW6wgeliUwZ17XvDImr/hcM94SSNmMT5w/+ClqRnimhtLr+XedCU1bgcIFC9ffUgaNDlmTJaMm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 10:32:10.9350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 993dc838-ea78-44e6-8c60-08d60f2d0537
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB1034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding file for NXP FlexSPI driver.

Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
---
 .../devicetree/bindings/spi/spi-nxp-fspi.txt       | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt
new file mode 100644
index 0000000..9f07116
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
+                 - fspi_base: iconfiguration register address space
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
+fspi0: flexspi@20c0000 {
+	compatible = "nxp,lx2160a-fspi";
+	reg = <0x0 0x20c0000 0x0 0x10000>, <0x0 0x20000000 0x0 0x10000000>;
+	reg-names = "fspi_base", "fspi_mmap";
+	interrupts = <0 25 0x4>; /* Level high type */
+	clocks = <&clockgen 4 3>, <&clockgen 4 3>;
+	clock-names = "fspi_en", "fspi";
+
+	flash0: mt35xu512aba@0 {
+		reg = <0>;
+		....
+	};
+
+	flash1: mt35xu512aba@1 {
+		reg = <1>;
+		....
+	};
+};
-- 
2.7.4

