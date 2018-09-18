Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24D0ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 733F720652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 06:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BuSeQTQp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 733F720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbeIRL4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:56:10 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:3250
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726433AbeIRL4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wleMOc+4TlOyTh23tAsxynUfRqYTjp1lwYonkBlXMCs=;
 b=BuSeQTQp9wYZHRFPD1VFYvZ4APt5lF34VI+sUk9O0zhxefkpx5mRhb1aQDdVYe580itBD31UOlfCZjZTg7i27Eue317hIOlnWwvsGitXuV1HeKqVrHBwZBxFPR90s8ZnzMMnTxsmMdOvcC4UogsswW0wFuBGG7MuHZlLxnim1uQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
Received: from anson-OptiPlex-790.ap.freescale.net (119.31.174.66) by
 DB3PR0402MB3915.eurprd04.prod.outlook.com (2603:10a6:8:f::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 18 Sep 2018 06:24:04 +0000
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        mturquette@baylibre.com, sboyd@kernel.org, ping.bai@nxp.com,
        Aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/4] ARM: dts: imx: add i.mx6ulz and i.mx6ulz 14x14 evk support
Date:   Tue, 18 Sep 2018 14:19:05 +0800
Message-Id: <1537251548-27845-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [119.31.174.66]
X-ClientProxiedBy: HK0PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::27) To DB3PR0402MB3915.eurprd04.prod.outlook.com
 (2603:10a6:8:f::30)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82acce2f-36ab-41a1-b2b7-08d61d2f57de
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3915;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;3:7FOxWf/IH3TUx8j97GBcl67/1YnzFQ6VRCNpSgMkfjtoCulmg/uX35EbYsWmGBAkZehb+Df38mJ0xlyjiVTGsxJKX18ST8BBkpbQAiAa/hpW75sbaYmHYmAUDtJRD28tdraRzeuNY1YUcm+Ze0eTQmxKPpascIpUOC90HzmdQXV1DakOmfqpn31kH3FlEkWacDT/0ZVeR+uyPcyAuw+34VhDrI5taFIGp9lH5aYqU+W7Lughd0R4oQSXiN5wT2H7;25:4epRIsFDQzE3ejYxi3pOlfveINYYHitQ7Gv7QSac4u5tKWx7LyNlsEUDAcIXtRyR7hWFsRKUPyyerA26ebKhoMo4h74bNRHQeFwxswFnUaWsBxW0FpjgdqxEYxDSAhCO6VwJ0EhiJVfQgpH1P0+EJy8nhjzFwFY2jPupyEjgCQuS1KPvegosM2V0tyb10fUCYGOEkdtkjF/BUzUO7FZQ90xLfzeCOszTsONEKjviI3oPuI2gHkHhMVxjr6twoa47Y5xGLDjglm0lt0PIt5K17WS8I8HL6cbu+ghnWM82+0X7a50EPUGYMRbqGwoNJYSVsVI+VUc1ZJWMrxjjTW/8Lg==;31:sbFRoji3v2C/59tBRWSiqgsBr/XBsrCQ6HUjerCIYBbDVvVAhcUT/vQVC16WyHSK3no7oZC7BAoM2JJpq8z+pamWeYUoImcAw3BB36QtMrzFzhXDjyk2ozVwPc4m5NL7g9Qz9rIOL8kUuvE4aYUSTw1XBfXcXa9+C3277C/+rEqRlkrq7YdqQ+09kY7n/qhl+qJsTmw+To3r5SkerFdZw3rkAOzxNavNB/nF7YOiRZ0=
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3915:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;20:YPOl6y5nqgF8+JONPtpyowfm8ziK4eySSWrk/jdAEYHijJHtTaJR05uWW2XBFjYN1GBN3FpZ0DbUquplwOEDDPKHuvl3e1K59025juInSl1Vk6ctRn9AlxVRV7qXsqFP6rVbEsysDrYZnDM+E+uQ1I0onyumRvr5WTFBBwen/FvidZJ8wCH7y1tvcQ4qgE9GMcb66oJCoZc5d1/je6bsnf56tcP8CV7qcIQi85JYIAxwb2n4E0q2WcLlin3cwOTwxZopLZmrU4E5WUc39X7tY6cxilXKi+AIcqJ7LUW2nMsgrjoCys+wCs+mkLhuJO0fX/JkKEFMJMY8egvjtvFXmWEm03yiRiBBwhO+gxsVUrtlMviVcuqH3tudJmNw7/R5SL0hTFBtVv7W3XnMt0Q+mx19tWsNfYkCBn//vE9DSYUOfhH/lxDhLVMmnDfucsbQDwDlHV0P8G9bxGzzu/ZsP0At1ekg2+pf8jBIGUmmec2lhCVI8T19QghtmAKLqWiz;4:WG2nt+O3SJ9B4JfcNRcZjw87BMX/zxg8328lakDeq6/0BRjeh7rwuuT8jXB3ipSx7yoQKnYm2urgNtP7dGgAul4wN+TfBZYBYFdhxB+J9nY5EFW0phmvPlujR+cK28qkxhjDeombgxst4P8uUqdb4fzD14WEmBnSKxC8XncZ1+4249VN5MsFMyeUNjiGDZGuHMhTGWjQFixhRNoTOVZ5b0x2np4pNHSEml1dhPMTPKaiOGWJD2zH93kjF116spRoswOihlNFPBl1s48lPcS0DY9dbsiaXAayy3DvMK0pqkDLS6iWleYTs4oXoCQRAYPp
X-Microsoft-Antispam-PRVS: <DB3PR0402MB391501F53237C233D5CBE078F51D0@DB3PR0402MB3915.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(201708071742011)(7699050);SRVR:DB3PR0402MB3915;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0402MB3915;
X-Forefront-PRVS: 0799B1B2D7
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(186003)(50466002)(50226002)(8936002)(47776003)(105586002)(106356001)(478600001)(68736007)(52116002)(2906002)(76176011)(66066001)(5660300001)(97736004)(25786009)(305945005)(4326008)(7736002)(51416003)(26005)(316002)(16526019)(14444005)(6486002)(3846002)(6116002)(476003)(2616005)(956004)(8676002)(7416002)(6512007)(53936002)(6506007)(386003)(486006)(86362001)(48376002)(16586007)(36756003)(81156014)(11346002)(81166006)(446003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3915;H:anson-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB3PR0402MB3915;23:3dnAkDgKtDLZFtnEo+0wBnw6XZrgw45KQcjDH+4?=
 =?us-ascii?Q?V0ONtDFUDEs6/4pbfkmvgwji8ZqeUZ/vOJanBxCEJYixSMxyW6DYnPs+k0w0?=
 =?us-ascii?Q?Z7bH1XNVSzEIXpGi56/SzoiWbDOjM6qsRyKLSqenQ3ZCwLqgc1yPpS0Y8qAO?=
 =?us-ascii?Q?eTGeOcpLnRotbe5QPLVGAtK/W6EntkllZBxpO17je0nfO+fGfZhcmwxA8v3+?=
 =?us-ascii?Q?RLjaCrR87zoGTi9NmcgLYRREZkx8kvlkrh+HeckaiLxR/B1P1mTyrqTGmxuP?=
 =?us-ascii?Q?sKrdsfFPvNoGt6KtypDWTyG82+CSGzgpoMNiSDSGNNTK0ZwChBauq5O8MaZy?=
 =?us-ascii?Q?PaFLP9ZyjexwMeveU0Co/rTeHgkkyOZIGYgc3gvBft0Uf1/O8ft2s2mS+Kix?=
 =?us-ascii?Q?qN6Ft6RxwIxLaVq5YeezzBKO+X7b04i84qxiTe6XHgtADv8DAZYQOf2fiSxM?=
 =?us-ascii?Q?Qj3HD8v0CDeDoM3akZ61UkDh2jYuP0U+J9a6AVo6QOkCX3a/U4L3eoQ7Yz38?=
 =?us-ascii?Q?OuznbERlgqADKjA58R2kHX40KGZsvdflzZXe4ukYp9lEHwqBmEO982Q8rI+4?=
 =?us-ascii?Q?fIhTAjf/5bjzr2yKQGCQzrwhHWgetbmRrNV8GDp0AA1w3sb0rQcfhh0ZpP0A?=
 =?us-ascii?Q?0iMDcAMd3Ouvdbe+IM4vJbmstE0FKDiqNiPi3selIQVYyWWpNiFUIgacdFyi?=
 =?us-ascii?Q?mWN1g/GlZ/jV/mYE80q14aH44E4yKhzDdfRVcNhBqHZc9o+1cpLIPAuNWDXA?=
 =?us-ascii?Q?1Yw7vwapvyBgtLJxznFCdRWfXr1fvbYGYn5SaJKJmFBRVXvUDNqfSafZyd/l?=
 =?us-ascii?Q?nR+uAI5lU5+QbrdcNUCUg6/1+G1oAH+uT4RreF69YbXf7Yw6O1HPNfZ7dNQL?=
 =?us-ascii?Q?F5pprESwnRXuq1N+ntBgRC3oMlXGb9GK7T1adSWKR3XD+0nrdZASzb0jbVdG?=
 =?us-ascii?Q?+q0nRKl5Gvd0vE6GfAU1eCaxjRx/iiRv/0xyiefwIu38zxpgZEnnu6Kb5xyE?=
 =?us-ascii?Q?xPuvdHcil5N+nSBpRFAvJEukCLzWuN9K79/JoBIFFFkJvFqyHufqT5svb0+5?=
 =?us-ascii?Q?3wsUo0UMQNXJpxK+02867g/yASkHRCnkzNEAkZxFqSmoKlTPWuEIQ6PjdKfb?=
 =?us-ascii?Q?j/LsRo9yfw8qaVnkNU9ZxJX4AyDErxC0NTnb5VfTEI3XDc0NLXrfLra8XjPt?=
 =?us-ascii?Q?B2pACxSMmLVmiIO/OxAZentXXyuruMMzgirvE?=
X-Microsoft-Antispam-Message-Info: yGk6Nwh88zU0IDR0csSw4oDYc+Kz85rMWYQDwuB1e66XD6oq4TMDHhNmA40qWMBaXo9nsMC+NgnHnTv5QrIQeM9NRIsD1Hhgoi8baErGZXiqeOvUfvfx+1Yqjt3N5LHSLYtBoRiLgC03mbE8RmCO01zY8btr2WnpHat2eICr4bQAGtiagSU18F9Ah3KuOF0FXfhIRl5FKhHtMMecqUBBZewKuIB3RgRAR3Tn6Onea20dnsQXpF4ilp8qO26zoYf3Kc35C3j8wr79KV0hRYiQZaGSKKS44dBPzrv07T2WJXFAv2Ic0Khuz30w27c6IJ7Sb55EFIm6magNTcCfOy2HPVK8YcPIejnl1jkFBvvgQoQ=
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0402MB3915;6:MDwhzDdr+nYGYXqtjhiZhTSIM39FewpUTcP8bPpggy5dGXi9gd7h+vU2ikd3OK1fYdEEv/p35t6YrJfg8CtlxGEOYB0m92tmKjreVu8IcnLOkSYACB9h9u/tzeZrY7BhALG8wtrZG0O37z5jA70aP7rv0Bf0yayuZ3l8Nt47jIfvSzx4osoPrBNdcKWd+2Yrs3FSfmEPbmARuL/S31c7eIBxId98b695UmQOa3/D2vJhzjOhsCRLv63KVb9Lym9MNumYrbS2vAEU+1cgKCIhnz8VTc4mHncuHwsAEChY/46oVtGvWVu6ZqJR09CvhO3klffMxTbIZ8GKkA+B/Wnq6hwvEkX3R9q+MqtbRlXExCbeqhO6tLCoH13WwZVBacjzU67E5yZAfeE/FrQZYkRifwVypHNYUK3tXKZu5s5Oo1TpWUI7KwqbvnXd7gCDDf+/MKqtDqvFjeFZwpK/d1ciPw==;5:+iLoRCOJ+PaKX5ItsU/K6L5SzDDKDh4IxLhgx21e6NJiVkTmeIg/BkApYSQxN4X0SJ8cAsOg27ao/E/ypReDeiSJixawoQfYJosjvsmuJ3yBAFt0QYHLh8d2DNEi8ehO3zixXby5dnqKBZJ3dNu9qLzFevWry0LFg9jSzN6AOgg=;7:pbVm5NWnK6+Doqt6aCn14KLDKhdoNLcmng/6O9lIN0TNid7vvG4uhNNWtpg5DrsRE4Dy8TxmS8rz1szGwNM9REv892sWYp6TMqVaWg69xqfW4H1JQ/6p/cVmLWrQ6CnmNQidaKCg3n1zWimDUwiNngAARqUcuowvLAS8Vq1utsXko4Stazw3T5pt1VsTUKHNl7yS9gDAN1LzfNBZIjVcmN39Akxi2LA5vOhEqHyqXpA5eMbMj4gye1wEl3164CV+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2018 06:24:04.0936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82acce2f-36ab-41a1-b2b7-08d61d2f57de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULZ is new SoC of i.MX6 family, compared to i.MX6ULL,
it removes below modules:

- UART5/UART6/UART7/UART8;
- PWM5/PWM6/PWM7/PWM8;
- eCSPI3/eCSPI4;
- CAN1/CAN2;
- FEC1/FEC2;
- I2C3/I2C4;
- EPIT2;
- LCDIF;
- GPT2;
- ADC1;
- TSC;

This patch adds support for i.MX6ULZ and i.MX6ULZ 14x14 EVK
board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 arch/arm/boot/dts/Makefile              |  3 ++-
 arch/arm/boot/dts/imx6ulz-14x14-evk.dts | 20 +++++++++++++++++
 arch/arm/boot/dts/imx6ulz.dtsi          | 38 +++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/imx6ulz-14x14-evk.dts
 create mode 100644 arch/arm/boot/dts/imx6ulz.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b3ec70d..d7268ae 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -560,7 +560,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-eval-v3.dtb \
-	imx6ull-colibri-wifi-eval-v3.dtb
+	imx6ull-colibri-wifi-eval-v3.dtb \
+	imx6ulz-14x14-evk.dtb
 dtb-$(CONFIG_SOC_IMX7D) += \
 	imx7d-cl-som-imx7.dtb \
 	imx7d-colibri-emmc-eval-v3.dtb \
diff --git a/arch/arm/boot/dts/imx6ulz-14x14-evk.dts b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
new file mode 100644
index 0000000..e2d67a3
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz-14x14-evk.dts
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+/dts-v1/;
+
+#include "imx6ulz.dtsi"
+#include "imx6ul-14x14-evk.dtsi"
+
+/delete-node/ &fec1;
+/delete-node/ &fec2;
+/delete-node/ &lcdif;
+/delete-node/ &tsc;
+
+/ {
+	model = "Freescale i.MX6 ULZ 14x14 EVK Board";
+	compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ulz";
+
+	/delete-node/ panel;
+};
diff --git a/arch/arm/boot/dts/imx6ulz.dtsi b/arch/arm/boot/dts/imx6ulz.dtsi
new file mode 100644
index 0000000..ae6d7e5
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ulz.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2018 NXP.
+
+#include "imx6ull.dtsi"
+
+/ {
+	aliases {
+		/delete-property/ ethernet0;
+		/delete-property/ ethernet1;
+		/delete-property/ i2c2;
+		/delete-property/ i2c3;
+		/delete-property/ serial4;
+		/delete-property/ serial5;
+		/delete-property/ serial6;
+		/delete-property/ serial7;
+		/delete-property/ spi2;
+		/delete-property/ spi3;
+	};
+};
+
+/delete-node/ &adc1;
+/delete-node/ &can1;
+/delete-node/ &can2;
+/delete-node/ &ecspi3;
+/delete-node/ &ecspi4;
+/delete-node/ &epit2;
+/delete-node/ &gpt2;
+/delete-node/ &i2c3;
+/delete-node/ &i2c4;
+/delete-node/ &pwm5;
+/delete-node/ &pwm6;
+/delete-node/ &pwm7;
+/delete-node/ &pwm8;
+/delete-node/ &uart5;
+/delete-node/ &uart6;
+/delete-node/ &uart7;
+/delete-node/ &uart8;
-- 
2.7.4

