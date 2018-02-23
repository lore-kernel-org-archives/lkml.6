Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752224AbeBWVJk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:09:40 -0500
Received: from mail-eopbgr40102.outbound.protection.outlook.com ([40.107.4.102]:10720
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751843AbeBWVJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:09:22 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rasmus.Villemoes@prevas.se;
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc: Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 2/2] dt/bindings: Add bindings for Layerscape external irqs
Date: Fri, 23 Feb 2018 22:09:00 +0100
Message-Id: <20180223210901.23480-3-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
References: <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180223210901.23480-1-rasmus.villemoes@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM5P190CA0019.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::32) To DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:4:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40d1ba17-baa3-4d5c-4ca6-08d57b01b3ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;3:rUvQfen9qjInLvOTtK/dkfjILfnfyjjPbB6pEV/P3vB7r0T/uNUhI/DvEYgGZyVuG4Iv30VhGy00kc6Hp+EKo9vLfxINptteJwdRXnWUkHCvopFLGxH1JfrXD3LGsmoYEak61DienPMk/nD6AQyPnH+NGTAfrT+RlMLHzPkmTOD5yIdVzf85XhYXX1auKHnAmERsHtzHsq0D9sR2+84g7hAP2MUvikWQuQHpl4T2BHhkHnWpX0UJy5uHQ9Mt+Nfk;25:ztQYMAHCTE0qs6GJnJ57F7lyIc5qrq2OGLR92mwnhg85OlBsQcdXI+6KXndi5MwqtUyzSAsKwDhCikMKCJQWhMbd0AklAwtgSLW+naC3MC55TN0nt0b9clw5Q8ky/LjNgGNZGEoFq+0frfG/ih3QQQLnhqQVgcIJHuUzGH1OW2Pq+PLUNjcCkHKCzh21qcpK4wKyNd727BEV3jO2NPDfcP7u7ZDmJMh6FTTzfHKteIXSDfk0wfF6GfA/cfSPwvCEXR3XrYsj/DdIOt4ww0w9yGeHqvwPbniChApSIUe+YiGepk8PacR23V00myncGn6wWLuO0kv0Gu9+WdWw3m1Jow==;31:PLYJDJIvtdbc1aZOHkebYKc7hWEoO3uUqm01bXPGS+xPZZaYqOR0mdh1gs9gsR5AUNOs4O7bYov1lFRQ3LBrDaoBCHj6Q1EkH0c9qUv6Ms0uAaDKL0qY3rkNanb42t6nrwjj9cIdPJ9a5cmthAqzFdmdpnH8cs86pBo1MpHke0hUt7kFKmpEy8BFbR+80gqrce+Sh+FvelU2vW/wIbaSoP1dmhwJWJKD/DjH9Hc7CI4=
X-MS-TrafficTypeDiagnostic: DB6PR10MB0439:
X-Microsoft-Antispam-PRVS: <DB6PR10MB0439B50BF83641DA70E558228ACC0@DB6PR10MB0439.EURPRD10.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231197)(944501161)(52105095)(93006095)(3002001)(6041288)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:DB6PR10MB0439;BCL:0;PCL:0;RULEID:;SRVR:DB6PR10MB0439;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;4:Gve37QonKiFh+x6Mp642HIMUfuqt2D/PbO2h+MzemxUjNfHK5f8C8Zwuiv0QsQir6dEK9VSoNXP8zlYjLYE8iwLsjXmGzdna22LoxuVEvwPa46Mkrb1qhXGb0cFVLDmDz/LXpUHZyj82XAK/zQJRy079BiTQrTAxYVK9j2H6kOOCDLecshBm4uELInN4vKttSD114aFsa4fcvGkJPRwPdaf5HBt8GRZ+3KJzSRkwqD5SN6WLh1xyeW72n+htgLTxQVklFV9gJuZIHiO8g3lrgw==
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39850400004)(376002)(346002)(189003)(199004)(16586007)(76176011)(8656006)(386003)(110136005)(54906003)(6506007)(51416003)(81156014)(53416004)(316002)(2906002)(8676002)(8936002)(81166006)(72206003)(53936002)(74482002)(8976002)(305945005)(478600001)(6512007)(50466002)(6116002)(7736002)(186003)(1076002)(3846002)(16526019)(50226002)(5660300001)(25786009)(66066001)(26005)(6486002)(97736004)(47776003)(106356001)(68736007)(7416002)(48376002)(6666003)(42882006)(2950100002)(52116002)(36756003)(4326008)(105586002)(69596002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR10MB0439;H:prevas-ravi.prevas.se;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR10MB0439;23:cY+3R7CpmtcDSlVoAWWyaXJVPvXy42yLodJMaEvFd?=
 =?us-ascii?Q?9xkJKMPnhQvEP2LPvF7yor0wfh1PIF1F1Y5ijkgD93xFheq6iGA4IaEOWXGg?=
 =?us-ascii?Q?WrTey89j0hOR/hnL3ZScRy1C9aMsGj+kne18/txD0wUWxLoYZrI90JtJgg8L?=
 =?us-ascii?Q?3khgXk1bD31fXPtWm7A5IES0A4fGX0wyYCEvm168h+USdktQ32oyLK4jSSAB?=
 =?us-ascii?Q?lc/O45kqeouIbVUgyqgysmQl+KHw+MWW9I6Fe/v8r/DgWXH/EEMljqiiy1HF?=
 =?us-ascii?Q?MJ67UpQ6e5LHrAsQvMSBk9Tiz4LcnJ13zYa2fQma90pS6mlvDvuPcxh98ZaW?=
 =?us-ascii?Q?3kTE1IeGsh4gwGWPetccLV/uj/r4VQrNCEbOZU8SbNXphPRheZWZK5sXgaI9?=
 =?us-ascii?Q?ydkaH0cvjkSeHAbvfNLROWTMJZDUbJXLQplPndNKNnG0sZNj2hZExLgX+Zku?=
 =?us-ascii?Q?O34x7PvfI1u3TJe3jhOsD/Mh1sjOD+XX+5ZTTbftinjpDg3onklMT2UewJ5p?=
 =?us-ascii?Q?YlwZYBNyGod+bBRSNVOe/Hh6wo5oQtWHj0YOe+1jdVRSrjOBCvQ4gyQnxSrj?=
 =?us-ascii?Q?+eGPF0hQgQH8nFGcQFd2mIENTUG9m6orDVQovB51+A5HRV3x3JuV8WUZqJ3Z?=
 =?us-ascii?Q?2HmhOz2JUcorZ4cjO8jMoe28NI+lg7PuzYC/EX5NJzy/9mv/oxyoaYbhjHK+?=
 =?us-ascii?Q?5k1PQH2LekFYwd1CNEzD8XQem9CiFbjFGd3MpuPRjCEdM16B0uzPzZtvnYP+?=
 =?us-ascii?Q?yrFukbATJkrt3H2cnNwAychGNUCtNhN/eY7m07Pbm985vB1yZDgiYEQ9AcRm?=
 =?us-ascii?Q?YCGDDFNpnrQ2Fy4Nc+wKjAuhfV+x4GidyYV0B42L2DifrC1Q6sbkY9mLxfJE?=
 =?us-ascii?Q?YqrQ8F1NlF+6eqaHTDZNgINeadGP2CaBr2qtKsZGfZMMqNDtIHiiOiNXkHM4?=
 =?us-ascii?Q?xQ95+y83IkeOI/3iV6tDAyr/cP6BBP9B0e1drxnLOUZ3B/sXHcNpCqK+RW/n?=
 =?us-ascii?Q?avdHUFJwu8I7kslCtQd224Sb+MmMw1YS2DrQr4xGgwDt8Io16YObUiHgGaQo?=
 =?us-ascii?Q?dXTR12MI3pgtxGbtJ8anDhkyaUai7WHAbu/X/c0mdGyJhYmSnl+pDHSQjeus?=
 =?us-ascii?Q?n7YfBsa83PPLinIGWWOADdZdiMQovyiYxrcsuB7ay8FTDTXAXa0kmzEpoHMR?=
 =?us-ascii?Q?QuD9RwRCSu3IV6hHFS+3EOWMxqx4V38zelloPVba/+3v8IN3HOIFHOAEbqcA?=
 =?us-ascii?Q?dG3ddNfm9bW8DIntsT0UE/1EnRqB5dOwZh4yAatsxpBlWbcCkH5s5DfBj1xI?=
 =?us-ascii?B?QT09?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR10MB0439;6:P5hNlNd0R28PBbwieF3uxoxNNSQcH+NKaJy4ze7rMITnzl3SsOT3kngPAHqOqmKjrH5l4wye/s/4p/iS3ibgKw/VTiPgsRJR3aIC6euGEgik0u10XP/OeIJyLKyRwJif0txXauzGZJtzrVQWKScXAauro815EcuZtpX7Xzjc32Kv64KFDsmaOhlMMpjfXhodDwCqypBSLyRt1Cb/tJNA95EdMYcWnVADXmYgOizDFeYioLmSXzu+iDeZF/pT1IK1OK564OsyN1mAXQRrNi10uJq1ndYZBGd8AImKzNrC+helqvNs7qnDl7z5Dizcbcshi9SRcdAxvcnN8rXGAWJYxuIuDQ1Yu8P4I3FIqgq5Df0=;5:uC6RL7hLdFrrXyawKNtFlD8/gF2uydM5wy+hE9HVn5nXKpuW6nriaWsYpABf/96drT4hMLv5R392U0uZaAtZPtX5b/UKbq8JMQKwbAuQEN6Ns+WBCC+jyiGScQGFEOd11no/J7S7VBn5pSMABpJHImZx+NNAum6TO9/zT0DH/Nw=;24:sffr6ilCNCNa9Z5Tj7iZuRPU/3NF8so+Y+lDlgf1pOjjthPyqo5W4v7PKluIpiRRzdCGzeSVCoIb4HGlBtIcfETCm1xGejN4AgCCUpX5WhM=;7:KJvOgOE0AA4M+T3V+OSn6vaYOPM1wVi5YHLelPe/8qVYnSRFAX0WJF808A6mCz17ElgGmt0L3THnjp39mvNKVtELsHqj2I2Ru979HP7R8db4ywKvBAFm+0xFg2Uq+mabahwfB80uXPT2JJLR0gTzsTZaMpU4GuDWq4m76Up4vuIWBTlPNqp+UJIS8vEqLJkDHrCjEFeimBfpY/kfpkbDSpwgK8pgbJ9fY31zFwIZQGyhXY9R10UH3N5FUsy1N2RL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 21:09:17.8953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d1ba17-baa3-4d5c-4ca6-08d57b01b3ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB0439
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds Device Tree binding documentation for the external interrupt
lines with configurable polarity present on some Layerscape SOCs.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 .../interrupt-controller/fsl,ls-extirq.txt         | 44 ++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
new file mode 100644
index 000000000000..e510c715e8f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt
@@ -0,0 +1,44 @@
+* Freescale Layerscape external IRQs
+
+Some Layerscape SOCs (LS1021A, LS1043A, LS1046A) support inverting
+the polarity of certain external interrupt lines.
+
+The device node must be a child of the node representing the
+Supplemental Configuration Unit (SCFG).
+
+Required properties:
+- compatible: should be "fsl,<soc-name>-extirq", e.g. "fsl,ls1021a-extirq".
+- interrupt-controller: Identifies the node as an interrupt controller
+- #interrupt-cells: Must be 2. The first element is the index of the
+  external interrupt line. The second element is the trigger type.
+- interrupt-parent: phandle of GIC.
+- reg: Specifies the Interrupt Polarity Control Register (INTPCR) in the SCFG.
+- fsl,extirq-map: Specifies the mapping to interrupt numbers in the parent
+  interrupt controller. Interrupts are mapped one-to-one to parent
+  interrupts.
+
+Optional properties:
+- fsl,bit-reverse: This boolean property should be set on the LS1021A
+  if the SCFGREVCR register has been set to all-ones (which is usually
+  the case), meaning that all reads and writes of SCFG registers are
+  implicitly bit-reversed. Other compatible platforms do not have such
+  a register.
+
+Example:
+	scfg: scfg@1570000 {
+		compatible = "fsl,ls1021a-scfg", "syscon";
+		...
+		extirq: interrupt-controller {
+			compatible = "fsl,ls1021a-extirq";
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			reg = <0x1ac>;
+			fsl,extirq-map = <163 164 165 167 168 169>;
+			fsl,bit-reverse;
+		};
+	};
+
+
+	interrupts-extended = <&gic GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>,
+			      <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
-- 
2.15.1
