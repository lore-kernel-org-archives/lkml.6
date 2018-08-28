Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0810CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E00208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="oTnUfdPB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E00208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeH1Nka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:40:30 -0400
Received: from mail-db5eur01on0095.outbound.protection.outlook.com ([104.47.2.95]:24984
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727592AbeH1Nka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n1e9uDBfP71Ua34bbvbsSTf8WI6GJLC1by0UeBm/mA=;
 b=oTnUfdPB6mFHa3kHqNLOITw9QyLep1s+vXEwMcLVtoz8GxZhzgV1GrF5aXKD00mF7lTDDZCLJiKoFMgk6SUuiDnTPAqb1qhWhhWQvpHUCRj3qexv9bVsiTlZjOk+E9o5alhLwDmvegQ3cVbq5UN3sc4pGiomXYRicylqSzVlZ0Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2449.eurprd02.prod.outlook.com (2603:10a6:203:34::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Tue, 28 Aug
 2018 09:49:35 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 5/5] ARM: dts: at91: nattis: describe the lvds panel
Date:   Tue, 28 Aug 2018 11:48:44 +0200
Message-Id: <20180828094844.10018-6-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180828094844.10018-1-peda@axentia.se>
References: <20180828094844.10018-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: LO2P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::22) To AM5PR0201MB2449.eurprd02.prod.outlook.com
 (2603:10a6:203:34::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3ab0db3-9d83-4dd6-eac3-08d60ccb90b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;3:QfX2O6EXuFuOl4xZ5Ogt/7/1yewRnwdc0rCovN7hyijriUZAVFpPuAN+86jpWL4qURk0DM+yVfUUCUAKTTsKXHpoy8ybf0CHQocGoxCUDXNJV/acR6STlkDiQUCzupGfewhq9f0JvIMJ9NRyldiL5EcfUH6qWUmlWrtwpzXcJ8J7iZZ5yGUgrRhPkHfcqoKwMjQFhmX7OyUyDSUni6hS0dfYgjU3oRVDiDbI2/pU4Mj7gYuM2lxdMCwgl4l6UQ6x;25:CpWHVyJRIz9k3dYr6jup2Co+88vyZ6AdNC6ifbDQOTsOxmM1ZrxlfFIZsrtgSPJ9yZC5WM4gxtnzmuWQmrWtQbZFWfLHMzd6YhsLaxauKEDVKCpFQQU+UmxLGAGZj0ogBdmuQwFFB/iczTTIrym97vh3ONgVfJhcODjWctzjCgjgLt8NwqcTUVpBQTi0rg3wIPPPdlvmvq8pPE74x3EomsEqRnwpPaW/rhEH1uDernz8lrlxnFszVsKMIaIZlKi3tubNGZyO7KfS/Ufz8YhD22g0KCp0b5ODT5u2KIAxg7pL493N8r4kvCH0jwYL0wioMTl6EH5iLffw1+qj65Ogiw==;31:ulZNAkXsSFi371wYHtzfDjeXrTpVPI4GVYZUcj5l0hy3R7NmIrAZPsXesGk7yeYjM+8X14dvNAFZFsTHN7g4wsIzTNaXRDULT5Bbz94TOPw3pon+3wM4JAdTpapyXiSD23VXP5xukcN4occwtd/nzJcSuJZ5kBNZsKnYadWBdEKKsHuTQfvRv5DZrDbmOeWWG4U5JaJJx5Iaxb5Z+l6ktNYBtN7afMRcHBc84F9FUYg=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2449:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB244981D6B8A7F9E7016C13B4BC0A0@AM5PR0201MB2449.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2449;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2449;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;4:MIajSQGlx5BTpmlztu1uz8Tc8eIR4qG7V4U2PJ9CbLkdMFtc7N1cjf3cUz45Q0ny7sLEf8j/hr4T/Q3UAQSCpV2S5jraPt+WSV6yOWEQUintxHXtysxm0BBm5aIDcVbkykHOLRATa2knX5DaIWMwy0wScWkqiF6FaOr5UB1gspglD778cri/22XK3jvmwBbn90/wjbLNSVp4EecJs4zDnna4FsUuxuulGqvOvO2/VbPNBKyfMEHcoSUZbDV03h/zTeemSM05QHjj4C/3IQopGw==
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(366004)(396003)(39830400003)(199004)(189003)(74482002)(16586007)(54906003)(26005)(4326008)(2351001)(6506007)(478600001)(316002)(386003)(16526019)(186003)(2361001)(36756003)(2616005)(476003)(50226002)(11346002)(956004)(446003)(6116002)(97736004)(8936002)(3846002)(1076002)(52116002)(25786009)(86362001)(575784001)(14444005)(51416003)(76176011)(6916009)(5660300001)(6666003)(486006)(50466002)(48376002)(81166006)(53936002)(6486002)(6512007)(105586002)(81156014)(66066001)(106356001)(305945005)(8676002)(7736002)(47776003)(68736007)(2906002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2449;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2449;23:sRsvjdOACrHbs8lGPuZY2NvFeZT9WZ+ca5xIuj+?=
 =?us-ascii?Q?FkSXCRk6rp1omOG5idHOCitHvoPWKrP2P+hFlvgEEE3Jsd6x0jWaVord2VSB?=
 =?us-ascii?Q?dL92FG5SY9NNZi+5xnB8cWpK+mvAUxXszSOH+p7LH7rISyYRPAiUVzGaPDrc?=
 =?us-ascii?Q?m6dMhyvI8UJxMb0vRuzMz3BpGcUcU6Y1wwu+GvNJRo0CCjkgU8sf/7nHxcXU?=
 =?us-ascii?Q?UTzp2FSs/w9PcLtgVMNh+vu1yYc6woS/OnRu/2H/zdtRJ5PlKCz0NN9tLJEJ?=
 =?us-ascii?Q?elYKQai2L0bCptiDTQj8SCOykYRzSpJA6Bkv+fNnT6KFsIXT/IrBsB5ifEux?=
 =?us-ascii?Q?zOi0X0sfYEjlmxBSslDmwu+oTMAnyPmyZMs5OnvO0tdr9E1j8rcRUUtE1Uha?=
 =?us-ascii?Q?bOss6tC/+UJ2TyEqBj9wJgtBdJgZunxCru2SykVx3G/Ro+wXRfMwfpLiHW3G?=
 =?us-ascii?Q?JW1Y45x/xseS/hUYo8wavhpivl95TEWv/HilUzN553qv+qaBwm7mBFZleltm?=
 =?us-ascii?Q?i1Uua2xCJPduQenGx7cRaD+SHifkWvGiHSR/rV4pKt+lQ6hXg/ZOIRXFNDBI?=
 =?us-ascii?Q?yztvwqmYr683AXlmVUm7L4mAB4O5SsK58cCfz5aF85ctlzt6TK1gtmo+eUvw?=
 =?us-ascii?Q?u8DSqhU/MAdxbHvPM7diTcdYZHTS4wYyzpkvZ8WTQ7UafPwQ0ex/MDFvp5hR?=
 =?us-ascii?Q?chZoqr6ancMXuW0h/ej+Cfsrxb4mLF7n/j64XZXwh90c1HSTfKaUiIym/Bps?=
 =?us-ascii?Q?AxXnKOn/IoKIComiCwm4R/r/ToY51bK2cdZSP+UfifadBRu+3YG1Lme4zDUR?=
 =?us-ascii?Q?e/t6BJST/N9x+WDDTQA9HiWwcIW/FASBzaPzDOShYgER0WcDV6M9CAUXAPAb?=
 =?us-ascii?Q?7383PCRU7jhQKLO9wlDAN8gQ+9p0mklOkbeRGP3km8HRPMmr0noD/aw49hrh?=
 =?us-ascii?Q?Y2ybM1iMIB0J31AJljVRfYGPijCZJCBhUdV9sNysmFO95c9xTcyWOWV5CtCo?=
 =?us-ascii?Q?SHtTO1s9mePDtRSN5p3hGeUfBBTA+JNxxTEQZjNbG56ug026nSu2SM2IksGI?=
 =?us-ascii?Q?siQcPENNKX9QIRg/AwZEs8ywerhAi0MaaaUHrTwaqYQNjPAAhWyWoescKXcu?=
 =?us-ascii?Q?LKdQbVqlqyWXUYZ1AR3W9wH7mhfKyi2ct3QRox/qnAjeBnzf3K0BJSK3tiw1?=
 =?us-ascii?Q?YS2+aWY5xU+yga39qW45jTTeTMtaZEU/fdqv+sa5OM+hkiRdhy/VJEs27J0L?=
 =?us-ascii?Q?UdD36OLHdXBa2SQY+MFAz9dV0QhWL/emMIF6l+xwzY9H6yadRn2M7W8kcRDV?=
 =?us-ascii?Q?Ck/aGCWQDC7NLAPZTrDaFb9lxz+2Jy99I0dQtKbKB4N2F?=
X-Microsoft-Antispam-Message-Info: 0MbqjoUOQL3+k6PaNzhsd/FdL8JQaXnJoUGxuw8uvwuvc5rMEbiQXEbYXXxwkhdFLfjg6nRICYsOkfzYGRC3V8t3ne88Wz7KwVHrVJX743shf5JamLh84hvcRWWl4XzpMo6XzPALxInkzf+duDO1ARIhUhs7cGcjuEBdyfU1pwvP4YPYozkoWbn+4tnjSvk1T85sIAwYviUn7HGfuBlQMYCmdmS9hz2rMJetRvSdRFxmCgV1zQgIIYg2nUwRpginI8uROBo2+Ajdczfh9WFp4XUf9WZYqWxllatRtgg8dnJVfx0LTJNAf2Xe996Mqo928m/iycZWPfGQpexyYdf5+IKCtTXyG2JX8MxWhC0D7Gw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2449;6:NHgqkLSCsn0tv4fxl+fLn7TTEzKKXZRgcxy0+9c7J+YP+kkFi/KG1yGdsmn2RunnCcyQjdapQHnel0qLIOLGC53usfca5IBjDtjYdrNSweiwfqwhQVRgM/n9Bnij6xPGuJEdSycoGiF1BUeLlGaKpAFUfeKEekzZDap4zwSCYvirzMYd2Yo5TLfTXwiVsc4sKuJTJKaSnMfY8uZyGIRztvrbs5Nx+BcnTMImcXX7dlBhQ8Hklm6MKGmyLDg1NYLNDs0Mq4yF+h/HjS2zgy7v1bce7e0+/1kfjB9iMKay4gjzjVUKIDpPqe+WYGJ9YBYL8Fap4c3JDur9TgZcseUnNunHC9GdR2eGBfTDgVJGnRZ04ZBHVXxM3tGiytkm8WVyul7kobNgPaT6K8j7djXGfnHaCGbuztZHrfYoARPFY9zoDMf7MW4WpQ9WKGNodV5Raljd6LI12HVGxIVswGa9cw==;5:NTqy7UAfQYpm9KwUTVRMJupbEQrDw6oqSRQyVVN4vWtekC57ivu0slZ34eRb2ogCEPfbBWCzgfku83X3MY/Ykn+sUUaUv3IL4PSnRfTIkqBvJByQ+ZEkx33gI99IEgpOmRgM7SunaPemkRdTNd2aiIz/5muNW6PeuyqBN6TdJFE=;7:/cOZRqBAjmf4dUiSHeBVoHPU0VZdSJt1xn5iuWvA8ubGVIxjEskyznlgMgT9zx63hPPIas7F0nlJALYKgsylrn0+TjWu7ehrwqT9x2LwBb39wa2nNVfto1SGTt2o0KzgDpPP4gFNv+eZBYtYnfTIVqkNkjMfEciRE/QWan9/i+oJ07CLg4/CLz9yJIcbplnQUzpQ5Up2c2mJV62wW1apQwXJ9+RKo3+01NnP0pTMGyY3d2wqn8zU7EAvonlRrU9a
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 09:49:35.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ab0db3-9d83-4dd6-eac3-08d60ccb90b0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2449
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the DT usable with the panel-lvds driver.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 2eb0f947ab86..97e972aefac2 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -105,10 +105,29 @@
 	};
 
 	panel: panel {
-		compatible = "sharp,lq150x1lg11";
+		compatible = "sharp,lq150x1lg11", "panel-lvds";
+
 		backlight = <&panel_bl>;
 		power-supply = <&panel_reg>;
 
+		width-mm = <304>;
+		height-mm = <228>;
+
+		data-mapping = "jeida-18";
+
+		panel-timing {
+			// 1024x768 @ 60Hz (typical)
+			clock-frequency = <50000000 65000000 80000000>;
+			hactive = <1024>;
+			vactive = <768>;
+			hfront-porch = <48 88 88>;
+			hback-porch = <96 168 168>;
+			hsync-len = <32 64 64>;
+			vsync-len = <3 13 74>;
+			vfront-porch = <3 13 74>;
+			vback-porch = <3 12 74>;
+		};
+
 		port {
 			panel_input: endpoint {
 				remote-endpoint = <&lvds_encoder_output>;
@@ -205,6 +224,7 @@
 		port@0 {
 			hlcdc_output: endpoint {
 				remote-endpoint = <&lvds_encoder_input>;
+				bus-width = <16>;
 			};
 		};
 	};
-- 
2.11.0

