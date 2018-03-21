Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752871AbeCUPgf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 11:36:35 -0400
Received: from mail-eopbgr30131.outbound.protection.outlook.com ([40.107.3.131]:49091
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752632AbeCUPgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 11:36:11 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: at91: fixes uart pinctrl, set pullup on rx, clear pullup on tx
Date: Wed, 21 Mar 2018 16:35:50 +0100
Message-Id: <20180321153552.29213-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180321153552.29213-1-peda@axentia.se>
References: <20180321153552.29213-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR09CA0053.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::21) To HE1PR0202MB2779.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a83e6f9-0092-4a37-c53a-08d58f4177a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;3:k4B7Xop9RqjrgDVTo5kELFcCesP6S/VW6RdwKOI3l+YuyDgY2s1aVzZKDN+A6qhfVOY9lvxGZ9fF2B64cLhk0PAWZTKGtvg8GTUUlROqSRe4LVA2y19KUhDuZ0qId43pBHgn9ZwFeM4O/9TQ4/lnzO7Md/10cqCVYmfamVbZSF7WuB6V47MC/rDFR7qLHCv/A/2Z8GS44AJnm/pXFBzzOOcfeNVD2mRN8wDaVT7+Fg3iwPgHI4zwXTTYIHHI5Erk;25:8+zhaIiyfntCo4HZHWLdkGvF+5AxYjyavMQ6A2zpLwrf4xouVbXCAC4LtysI4alPH4PTLVp0+TR7iDSC2EPhZ6ZePRRO1fmdWwFmB9A5yoEE6+lj95GRkVb3YhIa9LeBS3j3zZkNxd98X9w/DVjph+B0gZuKgZeudbIgouodm252jsG/3K5VZmcRtNjBFHBh0MgSjO07RcaDPR/s92VITDXkMJca/ahAjXbeO4abbOI8Plb9mktI78gjlC+RX8IJ7VlV7Ix2VBYzUgfIaimR7QNZdEkiTP3wFQU/4pRrgvCa+sQ/7J7AJyRkvExdRDI7pW89NiQrGtp5a1uck4QktA==;31:m6xJQ0Xz5nQ9QISiPJ4oSOlu1SKe1bC19tAZTPQXVd/EQQrnrS+Diu/5Hkas/CLJybOvU1upNyP3KX4ZCL8L3k/ccYGs7CVJwJ++Hn1V8xrkbeHHop5Ir/ngnY2HDSZfkcuQm5eLnEo3gH7bRon7PPMWZxdgYJT2daiMC3vERsiGx4smBHEvGVAGfQPPzUvDElU9pLooC3NwkYDnV8fUxMG+PZh9EGkITTVvrkZiXYc=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2779:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2779516C33CE17D35BF05C2ABCAA0@HE1PR0202MB2779.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231221)(944501324)(52105095)(10201501046)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2779;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2779;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;4:XM/9ReokAwXNE2Mc01nNZtkEwWGMMZdLJhRIeZL8hIe/YhGhc690C82e0Dki0fqHocyuY/KDpvGXqXkpIHPiwZ2r1KsKzolFYoYd/Xx6/Kk1ieXy9A9aZKTp6HvQ31Kih0lldXQM4oVSVlWchiv6GA8XuZrMcA8d1tQpC1xnBI4fEfgv1p6Bpnmn0f/ttiSvJcpeihs84CDmPjCV6IuOv17TFlDYdulhWCcvqD9roJiZ/BhWtYcK1dqnZEAoN0xiYjELQ3F7zVlOEsDkRnlgmQ==
X-Forefront-PRVS: 0618E4E7E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(376002)(366004)(39380400002)(39830400003)(22813001)(189003)(199004)(6916009)(2950100002)(6666003)(16586007)(53936002)(54906003)(36756003)(16526019)(186003)(8676002)(68736007)(6512007)(7736002)(26005)(48376002)(316002)(47776003)(478600001)(52116002)(6486002)(305945005)(50466002)(51416003)(81156014)(76176011)(2361001)(575784001)(86362001)(8936002)(386003)(4326008)(5660300001)(81166006)(6116002)(3846002)(105586002)(66066001)(97736004)(6506007)(1076002)(74482002)(50226002)(2351001)(106356001)(2906002)(25786009)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2779;H:orc.pedanet;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0202MB2779;23:Id108cPM7ytt0PPTlkf1g2vaXGYt+Szl2UZyG3o?=
 =?us-ascii?Q?EVbIM9e2zDUrY2tW0AgEwwq0Rr9YS8o6oKalLCmyrGKhYj8tEaT7xKlXGNVn?=
 =?us-ascii?Q?AcT7TfvNSi+kUbHC8ZnQGUG0tha21g8yoRg9DsTYYGt1DEOIVpaWgLhAtGVR?=
 =?us-ascii?Q?D6YYdoRDAs5OdxaOKWD4wCRoHXIriORCcM2l2mTNUHYGLdULzyxYyawbR0NI?=
 =?us-ascii?Q?SkwwY2/9wMhcF3tClBgK8VYvXq8Xdv9Ci49yHBWo1qfZsYrLsOvmkvpUt8Tc?=
 =?us-ascii?Q?H/X3i/3cstWY/V2fHzOQ9VpMD+j54vlJLGVYBlP4iOtNjpqgOLi36qd6qGwx?=
 =?us-ascii?Q?aUGfi8TiJMapFaVR2HWjBv/d/IgqWszB83mgbYXtcqdNlolX/3Xg1ilAVl74?=
 =?us-ascii?Q?5nXKneKoFqW/EmwnANgrZ3I+THvKzhwKu7FkV5EXovtXRCS0z6Zsfmlr7KO4?=
 =?us-ascii?Q?WAyfokB4FgoNdjhbQR/9AYpJRLIDZ5ERnG/7AytLeuY3iBI6+MZbXb0sB5xH?=
 =?us-ascii?Q?A2DLLadiQhxSwmPZzUOmV4KUrZSD5Hjt0rD3TRzEvDXHsrsqO7bMghA4J+Ce?=
 =?us-ascii?Q?eZ1bsI8wXEjoL7WAx9++kh0ocEQa4ZWtpADX9IVOXcQ8xb4MxpsyX36zmXhx?=
 =?us-ascii?Q?G06AWXdCz8DlZxjT4LoOYF13cGlyR+0j4wgnZjLQrzWGN9o6PAKgib9BSlQx?=
 =?us-ascii?Q?02fKwxure+ggg+Aii5kcHWUUje+7WEcanv9rRGdH+xdyvxWrRhmMEQ2vhYkZ?=
 =?us-ascii?Q?WCJd2ENvdwKkb5jj9l1py9gZ/i2YYh+QzdNrFvx/OfAzwaqwJG0v9pGq54J5?=
 =?us-ascii?Q?VLOq8Zf7t0KvCS/mYiI9vlDll+fLPO8IG2d1Mu9ea1FPa+o1OGHC0xwTiHsG?=
 =?us-ascii?Q?SPeEBy3W59WZoSEYq4cbZhHvMpK/UMa95fakFjITq+u/nZ5n+Og8oKWHXPlH?=
 =?us-ascii?Q?tEOgeedbotEdyTYCVd/3aRLA40URotTUfGQ/FsR1RZBAohH8W1yEexi3mrhx?=
 =?us-ascii?Q?2ZjcwJdIbFBDfgGnatm61OqyklBU2qDqVfuG60l0h2wyZzE75T8L1iakokXa?=
 =?us-ascii?Q?WFzz0cCZ/Vr9e4KAxwU2k1WbEJIlF6eynsVjrsprJZjNBA993aTLAswMeTNY?=
 =?us-ascii?Q?QKr60pYuIBzSeuhYgAkrji0YMolIslTLYNOgOTIO5FM12KqiUbUKeNkLS6fk?=
 =?us-ascii?Q?r8a1ktcd+Oy2wg4+kUm6Qsef010l4kO+g3YOLCynwdqCYzojWiX7gwboPj+V?=
 =?us-ascii?Q?HuxM5VQnFPzBW4GT2usNeqnlVUMVczE6I+z9wuBhy?=
X-Microsoft-Antispam-Message-Info: B4Ej8j8idJbulHNnCUb5sOmrv9nW9THGonuLG4zQmjxbAh05y5BoTt0IwMAz1OmYWEd7kORmdrNnBN33KuqOPwIE02lY7dMXrkGZEnCPGOGWUb2Mef+bVcGYEtln8cj14J/6U7qedGZ8A1XTqFjziNgG4fetaxZY15pzEVQnos6N51poQ7K8w5Ig27Bxhdx44wTWiYCAmdXUEnqMRNQCHw==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2779;6:cWPkg+KTjrowmTJ5fG0FNtrqq6H3C3ivkgtMS7VSIIFNOMQO5vox858zTJwkgArprf5bV3cY5dMxa+fRYO5J8RSzdKc3ibZ7vr1pVUP2MGKOk+ZUNXyiK2DjqVPJ4EteALj0ioV1+GgmseKV6d9RYh2xX9J44x3ZEoEyBDLGM+KhGesPE/OcbUUjP8DhMVjA+doIJAl2Q1Eys8sXvS/sFeJhXsfNrW51WglErbuml5NfjAmiM1gyAhLRmUhHHmRzWPrpV8FAeP5AQ020DGbqrwitmzygSAnUX3WlZx92BmH3FyB8C++oajc6kbIqaue3UhwGgRU2tfXuKjJ0MBAzSh5E2mNV7gpzk5vBQDAd3i0=;5:TzxO1dhOsPGp0gHLlorrJZVFta2HxwPbEUJJdNdl1GEAd26CD2uBZBxBkdnsu4kpldQrWkMJjJzPv2zTG49FySpZE1T+U+adeMtP4Z0g/Ds2LcC/uTibZiY82yZmLiOU/A6XqI73axYCDi3kKvGV78vaZwY3qbTGBFMJA0HhH24=;24:HXb0p6jSl0HyRPKCJPCtNiuPp6qXSA39BNuy+HgjWQTUjNUe4x6XojF3JM3yYAtw4QOWo8IgYTB6z9hT1lP7uqjin7U13gYzM9F9bXVTD5w=;7:52WVvOOfFbWMbcANsca99mMlNSyPPY+yu48qiTenojcDGXF7h4r0z1E0k19sWhBkbq71PmRN/DKJ2PDTXnJ3+mM9hafBnQo7R0dGd1MXuM60wVGyEc304gFpivXTCj37q/3UTcPhOEsu0C21sX1Ho/+NqvRYPghYHf+Ctk5DoWxykLPXnY2ggX4MHlaAdRKD0ElHyY9o0yMC+b9nvZhShRsRVAKOymgqMehxajZqihZRUw6pEkSzVRpjbMlpNDam
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2018 15:36:08.3095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a83e6f9-0092-4a37-c53a-08d58f4177a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2779
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove pullup on uart TX signals, they are push-pull outputs thus
pullups are pointless.

Add pullup on uart RX signals, they prevent the RX signals to be left
floating and so consuming a useless extra amount of power in crowbarred
state if nothing is connected to RX.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91rm9200.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9260.dtsi       | 20 ++++++++++----------
 arch/arm/boot/dts/at91sam9261.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9263.dtsi       | 12 ++++++------
 arch/arm/boot/dts/at91sam9g45.dtsi       | 16 ++++++++--------
 arch/arm/boot/dts/at91sam9n12.dtsi       |  4 ++--
 arch/arm/boot/dts/at91sam9rl.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5.dtsi        | 12 ++++++------
 arch/arm/boot/dts/at91sam9x5_usart3.dtsi |  4 ++--
 arch/arm/boot/dts/sama5d3.dtsi           | 24 ++++++++++++------------
 arch/arm/boot/dts/sama5d3_uart.dtsi      |  8 ++++----
 arch/arm/boot/dts/sama5d4.dtsi           | 28 ++++++++++++++--------------
 12 files changed, 82 insertions(+), 82 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index ba61893a02a0..3f3149c156a8 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -511,8 +511,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB20 periph A with pullup */
-							 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB21 periph A */
+							<AT91_PIOB 20 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 21 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart1_rts: uart1_rts-0 {
@@ -545,8 +545,8 @@
 				uart2 {
 					pinctrl_uart2: uart2-0 {
 						atmel,pins =
-							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PA22 periph A */
-							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PA23 periph A with pullup */
+							<AT91_PIOA 22 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOA 23 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_uart2_rts: uart2_rts-0 {
@@ -563,8 +563,8 @@
 				uart3 {
 					pinctrl_uart3: uart3-0 {
 						atmel,pins =
-							<AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PA5 periph B with pullup */
-							 AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA6 periph B */
+							<AT91_PIOA 5 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOA 6 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_uart3_rts: uart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
index 655f06cd716a..3ae7e6c55fe4 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91sam9260.dtsi
@@ -468,8 +468,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB6 periph A with pullup */
-							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB7 periph A */
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -486,8 +486,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB8 periph A with pullup */
-							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB9 periph A */
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -504,8 +504,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB10 periph A with pullup */
-							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB11 periph A */
+							<AT91_PIOB 10 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
@@ -522,16 +522,16 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PA31 periph B with pullup */
-							 AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PA30 periph B */
+							<AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB12 periph A with pullup */
-							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB13 periph A */
+							<AT91_PIOB 12 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index ddfc63b8fd4e..53c63d0a418a 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -328,8 +328,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 8 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -346,8 +346,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 12 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -364,8 +364,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOC 14 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOC 15 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index f2405671e3bd..87fb0660ab5d 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -437,8 +437,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA26 periph A with pullup */
-							 AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA27 periph A */
+							<AT91_PIOA 26 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 27 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -455,8 +455,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD0 periph A with pullup */
-							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD1 periph A */
+							<AT91_PIOD 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -473,8 +473,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PD2 periph A with pullup */
-							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PD3 periph A */
+							<AT91_PIOD 2 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOD 3 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 3a30eec7f508..1ee25a475be8 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -555,8 +555,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB19 periph A with pullup */
-							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB18 periph A */
+							<AT91_PIOB 19 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -573,8 +573,8 @@
 				uart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB4 periph A with pullup */
-							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB5 periph A */
+							<AT91_PIOB 4 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -591,8 +591,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB6 periph A with pullup */
-							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB7 periph A */
+							<AT91_PIOB 6 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -609,8 +609,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PB9 periph A with pullup */
-							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PB8 periph A */
+							<AT91_PIOB 8 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOB 9 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 4b62f4f963f6..37cb81f457b5 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -641,8 +641,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOC 16 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* PC17 periph C with pullup */
-							 AT91_PIOC 17 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC16 periph C */
+							<AT91_PIOC 16 AT91_PERIPH_C AT91_PINCTRL_NONE
+							 AT91_PIOC 17 AT91_PERIPH_C AT91_PINCTRL_PULL_UP>;
 					};
 				};
 
diff --git a/arch/arm/boot/dts/at91sam9rl.dtsi b/arch/arm/boot/dts/at91sam9rl.dtsi
index 3cae687dccbd..512337e46f91 100644
--- a/arch/arm/boot/dts/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/at91sam9rl.dtsi
@@ -719,8 +719,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOA 11 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -742,8 +742,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOA 13 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOA 14 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -765,8 +765,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>,
-							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;
+							<AT91_PIOB 0 AT91_PERIPH_A AT91_PINCTRL_NONE>,
+							<AT91_PIOB 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index fee4fe51a97e..a3c3c3128148 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -520,8 +520,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA0 periph A with pullup */
-							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA1 periph A */
+							<AT91_PIOA 0 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 1 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -543,8 +543,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOA 5 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA5 periph A with pullup */
-							 AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA6 periph A */
+							<AT91_PIOA 5 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 6 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -566,8 +566,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOA 7 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* PA7 periph A with pullup */
-							 AT91_PIOA 8 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA8 periph A */
+							<AT91_PIOA 7 AT91_PERIPH_A AT91_PINCTRL_NONE
+							 AT91_PIOA 8 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart2_rts: usart2_rts-0 {
diff --git a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
index 43bb5b51caa6..a32d12b406a3 100644
--- a/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5_usart3.dtsi
@@ -21,8 +21,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* PC22 periph B with pullup */
-							 AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_NONE>;		/* PC23 periph B */
+							<AT91_PIOC 22 AT91_PERIPH_B AT91_PINCTRL_NONE
+							 AT91_PIOC 23 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;
 					};
 
 					pinctrl_usart3_rts: usart3_rts-0 {
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index b9c05b57735e..eae5e1ee9cd8 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -861,24 +861,24 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* conflicts with PWMFI2, ISI_D8 */
-							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* conflicts with ISI_PCK */
+							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* conflicts with PWMFI2, ISI_D8 */
+							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with ISI_PCK */
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE	/* conflicts with TWD0, ISI_VSYNC */
-							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* conflicts with TWCK0, ISI_HSYNC */
+							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with TWD0, ISI_VSYNC */
+							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with TWCK0, ISI_HSYNC */
 					};
 				};
 
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PD17 periph A */
-							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PD18 periph A with pullup */
+							<AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOD 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_usart0_rts_cts: usart0_rts_cts-0 {
@@ -891,8 +891,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PB28 periph A */
-							 AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PB29 periph A with pullup */
+							<AT91_PIOB 28 AT91_PERIPH_A AT91_PINCTRL_PULL_UP
+							 AT91_PIOB 29 AT91_PERIPH_A AT91_PINCTRL_NONE>;
 					};
 
 					pinctrl_usart1_rts_cts: usart1_rts_cts-0 {
@@ -905,8 +905,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOE 25 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PE25 periph B, conflicts with A25 */
-							 AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PE26 periph B with pullup, conflicts NCS0 */
+							<AT91_PIOE 25 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with A25 */
+							 AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts NCS0 */
 					};
 
 					pinctrl_usart2_rts_cts: usart2_rts_cts-0 {
@@ -919,8 +919,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOE 18 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PE18 periph B, conflicts with A18 */
-							 AT91_PIOE 19 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PE19 periph B with pullup, conflicts with A19 */
+							<AT91_PIOE 18 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with A18 */
+							 AT91_PIOE 19 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with A19 */
 					};
 
 					pinctrl_usart3_rts_cts: usart3_rts_cts-0 {
diff --git a/arch/arm/boot/dts/sama5d3_uart.dtsi b/arch/arm/boot/dts/sama5d3_uart.dtsi
index 186377d41c91..f599f8a5f664 100644
--- a/arch/arm/boot/dts/sama5d3_uart.dtsi
+++ b/arch/arm/boot/dts/sama5d3_uart.dtsi
@@ -23,16 +23,16 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_NONE	/* PC29 periph A, conflicts with PWMFI2, ISI_D8 */
-							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_PULL_UP>;	/* PC30 periph A with pullup, conflicts with ISI_PCK */
+							<AT91_PIOC 29 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* conflicts with PWMFI2, ISI_D8 */
+							 AT91_PIOC 30 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* conflicts with ISI_PCK */
 					};
 				};
 
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_NONE	/* PA30 periph B, conflicts with TWD0, ISI_VSYNC */
-							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_PULL_UP>;	/* PA31 periph B with pullup, conflicts with TWCK0, ISI_HSYNC */
+							<AT91_PIOA 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* conflicts with TWD0, ISI_VSYNC */
+							 AT91_PIOA 31 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* conflicts with TWCK0, ISI_HSYNC */
 					};
 				};
 			};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 373b3621b536..dfeeaa6e611d 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1926,8 +1926,8 @@
 				uart0 {
 					pinctrl_uart0: uart0-0 {
 						atmel,pins =
-							<AT91_PIOE 29 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 30 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 29 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 30 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1935,8 +1935,8 @@
 				uart1 {
 					pinctrl_uart1: uart1-0 {
 						atmel,pins =
-							<AT91_PIOC 25 AT91_PERIPH_C AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOC 25 AT91_PERIPH_C AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOC 26 AT91_PERIPH_C AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1944,8 +1944,8 @@
 				usart0 {
 					pinctrl_usart0: usart0-0 {
 						atmel,pins =
-							<AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOD 12 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOD 13 AT91_PERIPH_A AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart0_rts: usart0_rts-0 {
@@ -1959,8 +1959,8 @@
 				usart1 {
 					pinctrl_usart1: usart1-0 {
 						atmel,pins =
-							<AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOD 16 AT91_PERIPH_A AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOD 17 AT91_PERIPH_A AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart1_rts: usart1_rts-0 {
@@ -1974,8 +1974,8 @@
 				usart2 {
 					pinctrl_usart2: usart2-0 {
 						atmel,pins =
-							<AT91_PIOB 4 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD - conflicts with G0_CRS, ISI_HSYNC */
-							 AT91_PIOB 5 AT91_PERIPH_B AT91_PINCTRL_PULL_UP		/* TXD - conflicts with G0_COL, PCK2 */
+							<AT91_PIOB 4 AT91_PERIPH_B AT91_PINCTRL_PULL_UP		/* RXD - conflicts with G0_CRS, ISI_HSYNC */
+							 AT91_PIOB 5 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD - conflicts with G0_COL, PCK2 */
 							>;
 					};
 					pinctrl_usart2_rts: usart2_rts-0 {
@@ -1989,8 +1989,8 @@
 				usart3 {
 					pinctrl_usart3: usart3-0 {
 						atmel,pins =
-							<AT91_PIOE 16 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 16 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 17 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 				};
@@ -1998,8 +1998,8 @@
 				usart4 {
 					pinctrl_usart4: usart4-0 {
 						atmel,pins =
-							<AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_NONE		/* RXD */
-							 AT91_PIOE 27 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* TXD */
+							<AT91_PIOE 26 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* RXD */
+							 AT91_PIOE 27 AT91_PERIPH_B AT91_PINCTRL_NONE		/* TXD */
 							>;
 					};
 					pinctrl_usart4_rts: usart4_rts-0 {
-- 
2.11.0
