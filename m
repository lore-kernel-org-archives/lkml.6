Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B02C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667542447B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GL8Rrzo5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 667542447B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754362AbeFVPQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:16:23 -0400
Received: from mail-db5eur01on0055.outbound.protection.outlook.com ([104.47.2.55]:28256
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754318AbeFVPQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwm/tENwYmyRy7uHKURsBdfnNa0bsTsPrunCsakYpuY=;
 b=GL8Rrzo50cMF4MOnH/IifxJQgGVQGqwJ33u6lTa/vgQ45XkOjKooimLoo5ISGQL+bjEKfI5FGl/3cnzxqihix8QA56O4sVun//GpMldAh79cHWiSUZb4nVkXIaRaf1O7skRczx0WrRbfDK7XWSv6SI5XQiMWL5pXUruciFso8wM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
Received: from fsr-ub1664-175.ea.freescale.net (95.76.156.53) by
 VI1PR04MB1613.eurprd04.prod.outlook.com (2a01:111:e400:596b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Fri, 22 Jun
 2018 15:16:14 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-gpio@vger.kernel.org, linux-imx@nxp.com,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 1/2] dt-bindings: add binding for i.MX8MQ IOMUXC
Date:   Fri, 22 Jun 2018 18:15:48 +0300
Message-Id: <1529680549-22079-2-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
References: <1529680549-22079-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [95.76.156.53]
X-ClientProxiedBy: AM6PR0402CA0036.eurprd04.prod.outlook.com
 (2603:10a6:209::49) To VI1PR04MB1613.eurprd04.prod.outlook.com
 (2a01:111:e400:596b::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dad8a5a2-32f2-4e09-e5cc-08d5d8531894
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB1613;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;3:KgdwL2kAoYHBVraiV5XU9ghQQJSX6cRKzaEwO3KVgmbT3mSiWFEFEPL0guhJkiIOR2rMZESC9izlfumjN+jyn51bkvZLx2L7b0NajpADX/JSg7t7P4A7Z9DCOpUn4LfyuDR0N8A3IOw3tEpLOjG1Ji6cra1swSrjQlgrYVyxcT2RWjoWOzY2hB04yT1L64C1n3L9GfqWm4ZLXeLByGgqw74uNv/sZ127uCjRYAWcTXm+OlmEiGauB7po7NyR5g0T;25:y1wHaW/PQoPF/EwQLNH53r8VnzW7/+rhoWvFDiyVPA1dWMeT1Vnw3S+WWwK/t7mEEdBWOfsZ191PGEkV4RCnQbYXBSkDcA3ucdOpXGbZe+nSzMhBUWBEexi6zh3ppDyvy5xPMNgRaTuWXMoE3lM/ALB6oLgt3f2E/b/0mi/3fptOM4gQavbdjof5TbLI69ygnmBAeJWvEDxX8HyP/kwS+Ul9hATo5q8GeRKJC4gyLr7XhkKEeYLqnNSLUnYvok8oMfE2W9Ly4c/G9k5xpu0g5Ral1TQTjS4EVJX+JFXoEN1L9wb2ArC5EEA85WBDzR6SVgzN+9C3RvKHslQlK4y8xA==;31:SgYA7v8fGjkenuv1XAucpOfrpWKv3LJ8dQ/PV7PXWIhfAILNaRdtXUsCgtOS0f5CxwIJqfMZYaUysUMOrnG3Jj3LqeXpvPTf+0yU1Y/wuUC7bksSEMuVIbP/LfQxtw5rNXvDCHJPnDgS1eac3214exoHRFTcsY6kj7+VzkMzagOdTlREBkpkvPn+gynLTYv6CR1TmciLVSYiPhO6JlqZAYBUxlF6PqV1T1qN/fkTzbc=
X-MS-TrafficTypeDiagnostic: VI1PR04MB1613:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;20:lbXdaZ/dYxVQi5zL5ZU8/M77kC87RRGAOrqGnBoESwqHUIPFQqxHB+9Ov7W2tcUaVa95VFhNmihNkf7CLGJsyGRvwSdNBpjqzCelakEYL0pENOjxbHaO3wVOWfltusrPpzkmWDKB4XnubVseuJ6+qBzDK4c5nU8GQ+4+8T8ds5aZpEHSBQtx6OJIN1xQeBlYwMjaBLZFH7RJpMWK8GdBLObSRcsSu/d9dsRw+rS5O2GcA7UaR4V3OBOLl/Fz2ZuoCcnVo5wgPEd4HlaJXD/Q4+LqpikETPXrHwXklINIcOqexP7Gz617gWrYeZ4EIhJh+qIi6bb0L1buPh6JjkcqOANqCqb8ubGvobk7cyWPlv1mudQHEmxtEhEtWXSv9889RZtPaEnL6CoSBfL8C1c/VXnS86yR336CzF6tctBgoB099uAnrB3b6EzfxFBUTXTpeXlyXHkw2UAXhvZ9ltvDfC+VCBKr+AzzEjjb6LLDq1YXxtinycywdI47utdaqE3k;4:P2tsdDF/HN7RIWGUciHV//e0noBW4PaT1SAi5RuIIfLQO7uceRoOphGFBN4d3J9F+KFCQCcl5Lgkibax6R83kTgEVhQZgi9T6HMYCFKbP1hH205+3/OMWqf3cfmSH+Xfrct/8vpKoLpl2ifznY2pTjKYM1mshXnAbbr2GauP1g7SWzZdQLbofEzFJx08B7qIV3PF68aADbTYXCPyZmJEqzf6XNy1vaT0aUbxl5jhNB/BItvWDrFGzflr7RjqQGwWezgX2Y/xuT9x1HTWk4OYuDXiTrGSPC+nlha+0wlA6aVdlYPFAAeUjQP5BMVaFOjP
X-Microsoft-Antispam-PRVS: <VI1PR04MB16130290A1D338232E08D605F6750@VI1PR04MB1613.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB1613;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB1613;
X-Forefront-PRVS: 071156160B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39380400002)(396003)(39860400002)(376002)(189003)(199004)(105586002)(47776003)(54906003)(478600001)(50466002)(48376002)(5660300001)(81156014)(6506007)(53936002)(3846002)(6486002)(110136005)(8676002)(6116002)(186003)(26005)(81166006)(106356001)(386003)(6512007)(16526019)(956004)(51416003)(36756003)(86362001)(50226002)(66066001)(7736002)(6636002)(4326008)(6666003)(76176011)(52116002)(8936002)(316002)(44832011)(68736007)(97736004)(486006)(25786009)(2906002)(7416002)(476003)(16586007)(11346002)(446003)(2616005)(305945005)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB1613;H:fsr-ub1664-175.ea.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR04MB1613;23:oNyqt6xG2hKbG6vad67cpwhRbakVmNdLgkUBOZwqH?=
 =?us-ascii?Q?JrsAk8jMeK66DIOuc+maeFsjJ4YwsyoWBPK8zvCJmMlhAdiIQ/WsWUQ7VYtF?=
 =?us-ascii?Q?3oGLO6qFtd8cucMBETLcDTfBX16lzjGri9+vuhiEGq3wu2nAp2w697EWnKPX?=
 =?us-ascii?Q?a0emTy/VjK5UmGqGonognqU5wQ9B9zgEde6mCohV6Ph5zbB6EnMjBt7UwvwN?=
 =?us-ascii?Q?kMHqvf8b2TEtKLiN9zupaXJsODWcZ0cniqnIrEYmYS0wM0SIQbm+pmie4EhK?=
 =?us-ascii?Q?+n6q1nH1dGzh3dD2hAP8iXcV7omwuT5HOVETlsOLHeNptFMBNcBr1DhyVP75?=
 =?us-ascii?Q?OnR9vRnsReUbbxqMC9YPNGldU7G+mV4aCFsu7kFgfLPvOBQo66XJhKTDXGT+?=
 =?us-ascii?Q?8WMWvv+drNtfxEzhhQRcz+CADAmRV6IkcjEfdpzv7Z+clX6v5KrdifniC5uv?=
 =?us-ascii?Q?OZmiwd62F3fqD1WI0DbPGyC+Gi6ImcloYaTIPTcyEE3V09fJmMa9Av4NK5O3?=
 =?us-ascii?Q?JIL5qDvqTUP9b9OepvtEH1XF6AEIHo6xYDuEFN9RoLSf66u6QxQzRyPy3POg?=
 =?us-ascii?Q?ERwTqf7MFf+6tQIAQkrNnS+Gzvg6VbN+uw0AaB2wGM+5tXU4GLWNHsNH93v7?=
 =?us-ascii?Q?ALaZtjquB5sLJfoq0TD8T/dD7p5MGWEagTb3VulTscfzIpARripYlViZjDsL?=
 =?us-ascii?Q?QSMofiZtrYZSoF2qOAhu9SXi7tezVdwQKe9teDCgMXb7PP1GOj5rEZ7eTyz0?=
 =?us-ascii?Q?mqDnF4T3/jyFMIM4uJyksRWI8LPse4LNvvNh8qUuMSrouHEVlCM6oIsE91cM?=
 =?us-ascii?Q?C7gVaN3s8cPb/0ezrastwgsLa3CXTWO+X46rXG4LhX/p7IcNbXlKg/b7yIoh?=
 =?us-ascii?Q?/tLiu7m32uHWUXa4N3z0lFO6x7r7aaAYNKipkb5jrudJqYBoWNvMrrGSYRMa?=
 =?us-ascii?Q?DLvZHCbrKvLEddNi44tSfNQHRF8D4MB6s9VmYtQFRU9tOHqalAlxztNQYtZ3?=
 =?us-ascii?Q?aJUU9aCWaRdWcthTbIOdic8Z6+NKUPhAIx35JzOe8KRmoS0Mf9KpA1CqmY7k?=
 =?us-ascii?Q?Ey9UsKeB0YFXJv7i5e+48iVdee4nTbjcb4WoceAJGnBsQh2ygTVk4uWf1tre?=
 =?us-ascii?Q?9rnXoYFP9i8ugFfWO8BIl5ND6QnSYykuAqVgyB/3Ltba+dQQsiq2xSc0gFJw?=
 =?us-ascii?Q?d3wp2P8T8IxQuHIVJXNfgiK+LDbOUM42XiQVQbGGK/JYnSahmiCyxvX5etYL?=
 =?us-ascii?Q?JvbBJe+ZQv4PjUgSUKT/Xm9gDRyN3g4zLsulXDWRDZ2ZZ+F7Gsb+Rv0Xt4Z6?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: y8buwyHZeCwEEgRsdGxa7/bi4elEln9rhChg2IQbbirY3li5VnCN6UIiYj3QS83zMqVIf7CaY8380UBraLi2K5E7b/XvGXuk74g64JEwkrBPrFeuJIy1w3azo6/6VyCFgIV1x1VuWs+2X9p7KI7ZDFSsanc9boWm2uhdlGZAce/Xq8XqhxOLO+G6SLH5lTamqG5wQ90f5aPMsgvuM/3/ts1Ma+xKl3MYc4gl8eVOJ+oG/eeGIkcbxMI8v95beMV4zl8NzJY9yLqTi/AAkBp4lALND9/Nfl0YdcqSAeyThqgrjpmGNEVI6Z3d4/6mudd/
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;6:hUj0NwsWsULtq5VbdztMCqSy/0CxQp4/w218sJA6Xlrs4fKupbKlT1dDBHPHl2zybzVNeJ7yJnQK9AviLOV7rLAt5/RvK1ibHvsIHzQ3CauAa9JePdTS/lINpbimUqZFg6oXtwWKh0iIXDj0vlvFPQlfHw+7V50ox0JQL41pvpNOU1ZllCnlR/zpoQzObVmNV2P7a3VUGkn4VIe4xqsXVJRnZWleX3IMs27N3xCf1zj94H3NcArNm1IvKgKeexv0AclQR3JcJgZQDSVpl9UK3BzQ2W46+d8f6CBA1goFw3mvFcGPMpa9RK6RxgklMkXtDGvjrd/8Xhc/1fOX5lkEDGiTQO2zIZFujurwF08MpWMY2AImu1rXWiBRK5iBQCrbnjH0P4aVqqm8PL7NZRp7nD11YyvkqPAAVaz+hgeRrs7ACyQWQz+uWveAUI7Vj/JXCNQtUsBvhR5o5a8vZhU+4w==;5:jT4CIz3eFJHjeZnUNSDrI7sxhP8tQiMqpto8jf1XzXlFLf0oCpy+r6sXMXtNhHDTsDRNk437gSbXsePY+EbVDsw4i1jA7X6+xJdhalkE2+2Od/O2hzW2u8pmm9WmKOTsnxbcUiSVvdTwBLIE6SBiQf24nAK9lgh6SjCU0s0xngY=;24:pPxABozB3tlVFqhZx9DLPZx9hAlhH8+GQMV5H5/rKQUgU9snW8ZBJ9SHTUAEINfL56wY6DfY/54EeljaJnkpSCHUdRL88OQEhzXfDFwtuMY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB1613;7:XDySpC+PcchuJQvDHM49XQfVozaaPiJpMY37m1A48bpVeb56fW+RCuCiypoERI2kQvW2v/afbBtsW9GqXaiT/fyPev2RUGTM38FB81hpop+kAz7GUSCqAzjt8R+bSNJCifBLrSqmhcK3S0o7ZqfnpQj19O+fbdBKEg0lUAgUVsxRnK8KcULCSzOCMHl9XD3PD74ZjLUjT7+rRNQDx/6TEfNZ8sAv3e4QO9s4ZPqbAASeCmGq9PKt7yQ81DMUS63v
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2018 15:16:14.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dad8a5a2-32f2-4e09-e5cc-08d5d8531894
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB1613
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the binding for the i.MX8MQ pin controller, in the same
fashion as earlier i.MX SoCs.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 .../bindings/pinctrl/fsl,imx8mq-pinctrl.txt        | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
new file mode 100644
index 0000000..e1c405d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.txt
@@ -0,0 +1,32 @@
+* Freescale IMX8MQ IOMUX Controller
+
+Please refer to fsl,imx-pinctrl.txt and pinctrl-bindings.txt in this directory
+for common binding part and usage.
+
+Required properties:
+- compatible: "fsl,imx8mq-iomuxc"
+- fsl,pins: each entry consists of 6 integers and represents the mux and config
+  setting for one pin.  The first 5 integers <mux_reg conf_reg input_reg mux_val
+  input_val> are specified using a PIN_FUNC_ID macro, which can be found in
+  imx8mq-pinfunc.h under device tree source folder.  The last integer CONFIG is
+  the pad setting value like pull-up on this pin.  Please refer to i.MX8M Quad
+  Reference Manual for detailed CONFIG settings.
+
+Examples:
+
+&uart1 {
+       pinctrl-names = "default";
+       pinctrl-0 = <&pinctrl_uart1>;
+};
+
+iomuxc: iomuxc@30330000 {
+        compatible = "fsl,imx8mq-iomuxc";
+        reg = <0x0 0x30330000 0x0 0x10000>;
+
+        pinctrl_uart1: uart1grp {
+                fsl,pins = <
+                        MX8MQ_IOMUXC_UART1_RXD_UART1_DCE_RX             0x49
+                        MX8MQ_IOMUXC_UART1_TXD_UART1_DCE_TX             0x49
+                >;
+        };
+};
-- 
2.7.4

