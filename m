Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 343D8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E0A204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="KOlVqN/z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E0A204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeIAAxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:53:34 -0400
Received: from mail-he1eur01on0106.outbound.protection.outlook.com ([104.47.0.106]:30360
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbeIAAxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:53:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdN4Q/029+yyCEDn7g3WBMFSRghTFHmJQai6vuq6bdA=;
 b=KOlVqN/zU2s3tI3VcwpIN6AqDw5/pGMUWPss5Sf4tnMtxGIqYgcLnWV+FL7AmzD9zVvrpeEJ000ArwdId5z3s4p93NBDudtysCY1gsMyU9t5tinyEhr8BrM5kj8NofECP6eJQXBd3HL/07PpAOw7w4HVM0Rz0oJ6HEytOH+8qKA=
Received: from orc.pedanet (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 20:44:19 +0000
From:   Peter Rosin <peda@axentia.se>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: at91: nattis: drop three indentation levels
Date:   Fri, 31 Aug 2018 22:44:02 +0200
Message-Id: <20180831204403.14653-2-peda@axentia.se>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180831204403.14653-1-peda@axentia.se>
References: <20180831204403.14653-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:52::31) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afbac6ab-aea9-48c7-954f-08d60f828700
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:wBK8nNOhU2laqDNXelLs5WjMPQ2nkVexRAH0p/w0lpQQobdlPgdIgm0oTcWp7HRmKj4xKn033X7vhQSLoN1bPER06WXP+u9feOzw/zjnzotZaTdK4PBg3u2Rn6BEoTzZT/jSn/JB7zZ08eYsYh6NM6kjImXUKFYjEDaUTzpmohJQhF+TpliddoZoyNm1UOqR2NyFc3q9whXa8ybnt1p20yXhcYxQo8blIy7QUWaTkKhgdUwBNxXHgrfMoOi8KtaA;25:JPExQflEmvNhAoxRHXAHc0DWbaijTk4wcuHf9Tay33J+1L6Y1+EyO0gW13K16b55FnXT+GxbqlQjStXHJ2QTEqBAo6Ok1UDa0ZSNwsifjvLsJhFGQJ6cTn0NHy90ApByQoOK+nKRZAQBwDDdSd7RB/pZuOsgC4GIDtO8QHnWyJ32dq2DHiduVGwjwlseD0ufSGAJaK0rBQfPdGNe8TGPoUGzTe0oGjF7CuD7upn3frz2rLhZDscSfpMmSgHCGN1tN6xMTVtsJElrRUMf/WHfVtkjA9pnyI6Tb5hL6J83Erj2EU7Uu1Kbuh7dHoq/cQymr5/QHuDHd+7w8fysWq5FXw==;31:Jq7LM/yehNAGy71Sgwj9R4GDYuc1vAb2SHor+xVqMdUVNtYFeZh6M54plkcVbYMPoZDX6k93id0M0Y/3aSX/QY/UUmxT25xafXoQQAJkH4sVb8Mn1XqkZexRwDJ2DiRDwuxR5fL/6L/GynRVE1ZTEKYDFyDtF9bBD+kd/JQzD3G1b2ay6SfHALeKDN1J8VvhKcqi2Ag6e7IDs7r+qMAgprCmDqKKOG1CSh4yME1rx24=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
X-Microsoft-Antispam-PRVS: <AM5PR0201MB2452A51ACA716796BF058A90BC0F0@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:29OAiY3AvSI458C9UlzmQeB6rpPJdHbQyjTJ9ni+k/94ksyG74jG7tkr8YQkV2MQi5rql1pyjf5wZn7xtBiSVyUaTkgZ5ZAWgWap/v2JPygVbOu580ExbF7C9SI32upqoaG7WgR7LdYKRA+DD9TqR8gYvv0wsQfkqm+YEM4w2wW9RXLO6EG5kjAH8zY+BTJry+1oI60vE/zBuhrzerdVkCapYtwS+Ba8BWhgTzgWWnMbmalyPeXrSozYq+JGu+jiJGtBtAI8PHQct0BoIQum0w==
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39830400003)(376002)(366004)(346002)(396003)(199004)(189003)(6346003)(7736002)(2361001)(305945005)(76176011)(48376002)(97736004)(6512007)(74482002)(51416003)(5660300001)(52116002)(53936002)(6666003)(8676002)(68736007)(16526019)(1076002)(8936002)(50226002)(86362001)(6506007)(6916009)(386003)(186003)(26005)(6116002)(3846002)(956004)(2616005)(446003)(476003)(4326008)(54906003)(11346002)(47776003)(25786009)(486006)(66066001)(16586007)(106356001)(105586002)(2351001)(50466002)(478600001)(2906002)(316002)(36756003)(6486002)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:orc.pedanet;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR0201MB2452;23:qcxK1AEBo8EfZ+OAZZv7I+Wq6ipI9vgZ6TXZ+Ln?=
 =?us-ascii?Q?5ZtgLMWA/2LMVB10Y8D+EoqnX4EykiNzaL8xZoscjLifknD+iE97WUVpHkGe?=
 =?us-ascii?Q?R5FLwAWWtFcYpQtIjisshr8GFl7tnKkk6HGUZH36Y651WVQAeBID5oGsd93Y?=
 =?us-ascii?Q?blXOxhqLxF2OUjWMIRDoqq70Ta8F1PtvpFNU+r6oucPLFT/P+GKa23fpyGci?=
 =?us-ascii?Q?zxrLIam9f/3mRoYmpWumwXBkDMpzYQ+g0GaeZ1VoQNLr/wglaY8eINSZ6I1p?=
 =?us-ascii?Q?b+uGqcXwhpFSM2Cn/lI2fEVchE831Oj+fuTFGSbZoHte19uOp8KmFE5EXQRl?=
 =?us-ascii?Q?PmalS0fhUtpBkfwxjxO8TWbFr71Qds6w5B7SiBKIwnPlrBdED4jCtkDIqJVx?=
 =?us-ascii?Q?LIdz3wzd6o8g9ScbFuHA5n3JhHzX7SR3oP4pv2GLkgWD5YbFelkvKM0vH038?=
 =?us-ascii?Q?JulKH5OWp4kSNNveUkyaL48c0pmxD+GyRhKiI1zKcKskNimJimV+bNm/Ffro?=
 =?us-ascii?Q?8NTSmiZ/fGO01x4ntKltASEkRhrwuPBVnE7y17jpqvzVM9eXKn47DFeAeE48?=
 =?us-ascii?Q?i6KYxXnrWCebiJC3XsytLawbx19fyBUY577sFtpmTDm1yZOkKYygwcQdXaj7?=
 =?us-ascii?Q?GTNxe+UZV3k36D2fpSVNolCpoQKWVo7Be0WAW4jUKiFZYWMZnZG/8p1bqMSg?=
 =?us-ascii?Q?UkEmwcq0kF+aYWPlJA6kwgFuHj0h/q7jVuNLmn78uflWZ/60ycT/WDA8TsBQ?=
 =?us-ascii?Q?Vu4Skvl4Elll0awFLfdIenNuh491RTi8JNhth4vmnNFETI/2uXA398wVlhPW?=
 =?us-ascii?Q?h65Y7EOWgiGBN1Llct4FPMlDZY2ADvUTxvNQqbzwrs21mRGqciIWCoNFJGjl?=
 =?us-ascii?Q?9cV9DWM0U7DjJAxCExMKPy1d1mZNSufr/czmYk8ezxK/w+xvtqUELlkakUw3?=
 =?us-ascii?Q?x+hRAC8MteB3JaRFHV7PzIrzlMREFZERg4Ryczk+Ec/ShrCB4xaSv/Qjtm7R?=
 =?us-ascii?Q?g4LstcYSYDNBTGd9AYiFLrGOhElwn2YtT36pn6yvhyyFuyoacHudacczGDsq?=
 =?us-ascii?Q?IhTY5rOQ38fDBRnJHaxshVjItC+bRfgob2irTjp4YfDi1U2BWekldqg6WkSH?=
 =?us-ascii?Q?gHN2KK7+XIyGOFok1mwKl/qerU1driQUn84jiYrDQGSvCG0Y9Xalhqk28iSM?=
 =?us-ascii?Q?j0jDyFqE8o9fFYKWbU9h81hK6m86f66EhR/4ybWBsT2oj7wIXIkZ9SJxXdYY?=
 =?us-ascii?Q?QLOX6SFk25bY1iuenhSvtmQHXQQjBJINAPisjCJYc6PzT5UE3me323S2cHid?=
 =?us-ascii?Q?sAyqLdTjNIEPDZveXbyqhhhs=3D?=
X-Microsoft-Antispam-Message-Info: v2SDXL5BZ98Cf/7MdUK5ZaTqvPbbd2orLfUirYc9gcfr4UnIXgTy1lB1uDkelfkd8x/OohMUU+/EscSh+aGOe+Pfp6WNzE2edMgZg4cQCx9HEJtBF7kRyDUDzKBnz9oJ3TjdAihspSHuHM29rf8lUJxk0oTDvwO0eNOtWR903K0VIxNkBDdAo4nPS+XYvqNxk+hZwLgdfGdpWbwXEVxtyWxJsrpjRDfYngKSxLSS9vpEzk9lTdpJAUA8H7+Txocnhw3U2bnN7m4qPwG7QQ9UsT+Thetu5KU8nIInH2kbyBW0s7i4tXPCOKoJj7dxElV//66mrH3edeWIoVPZ23FwwdLbILW7SdQcVFAT1TgGfxw=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:zem3quHUYMHZe+/++ZrJpQ2TXDDybhk2RzH5uTco0e2IX2DbyxmV2lbxdDFlh+uwKonOJ/JQSwmwM2v7/SxLV1pExV9G2tNzzL5eHB4i0eLNAvnRux4WFKXgoq0E5oR211QeogYsC8CJvfeULiegp2iNw/WahhmmnKG9Vx90EFJrAj9yRxvTxmDE84qzUZP4nZB+aQ1j2hHBpUX57zjvDCjledkrRuv2w51lLlxXHBisVVN7FdC57BibL3AohJlJKijdCJ/ndmXklrw6tuYBMO+exsDuQPCky7BByTu5oovk1gP5m9Ly+lMtNjJubHNCqQi5xqCcMOCzhFL+MI4t1CLpCkvAikd2Bqs6+uIJHUS3NtJ6O7xKzb888rOkeJbEnuGoPqePn61dXTOqdq6S8UhgJpuezVbDqiiR9dXhEXpGt+CGkYhrth4pdxIFr6Aoq4DTxcy9IS6mAfs2BRdGcQ==;5:BGxInrphTd7cyAs2pEKy9+PfQbMrckAEAGOkbgyox8bGHRWfFkd5R4YAX03krMEaXopyjS+ZqZwBW/iHu59+eghaZcsZaO8ec/TZgxLamRhJaR3XuUDjolV0ljWUG38DXL6QDcpALexBpYHhRdgMxK67Roo1VufSiadFciJKBHY=;7:lWLYfgrO8xrWizD8xptMRIg5Iz7GWpiBlKb8Ni46Kg0Ilmv78aBvLGOe/EN0w/LtwJHx7Lq7ySnx0QF7iN+ZIsZdJhSLDn+feavekQnzYHhqJQMA3dJ4tAXZmbHq3pvSp+BZOBLg+Vokaplnt2s08SEKujz3NUTSPqdPOx8ghZAgBvHtvJiIXV9R1uYePE7MsjCF9xCO5bRycL9QmzE65OwFAiW+a01kq+7RhH1AH8r1hUQFmf+0IJkT13IBW46k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 20:44:19.9737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbac6ab-aea9-48c7-954f-08d60f828700
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make use of the recently added &pinctrl and &watchdog labels. This
makes the whole file consistent and knowledge of the ahb/apb structure
is hidden.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 72 ++++++++++++-----------------
 1 file changed, 30 insertions(+), 42 deletions(-)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index 97e972aefac2..911d2c7c1500 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -16,48 +16,6 @@
 	compatible = "axentia,nattis-2", "axentia,natte-2", "axentia,linea",
 		     "atmel,sama5d31", "atmel,sama5d3", "atmel,sama5";
 
-	ahb {
-		apb {
-			pinctrl@fffff200 {
-				nattis {
-					pinctrl_usba_vbus: usba_vbus {
-						atmel,pins =
-							<AT91_PIOD 28
-							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_DEGLITCH>;
-					};
-
-					pinctrl_mmc0_cd: mmc0_cd {
-						atmel,pins =
-							<AT91_PIOD 5
-							 AT91_PERIPH_GPIO
-							 AT91_PINCTRL_PULL_UP_DEGLITCH>;
-					};
-
-					pinctrl_lvds_prlud0: lvds_prlud0 {
-						atmel,pins =
-							<AT91_PIOA 21
-							 AT91_PERIPH_GPIO
-							 (AT91_PINCTRL_OUTPUT |
-							  AT91_PINCTRL_OUTPUT_VAL(0))>;
-					};
-
-					pinctrl_lvds_hipow0: lvds_hipow0 {
-						atmel,pins =
-							<AT91_PIOA 23
-							 AT91_PERIPH_GPIO
-							 (AT91_PINCTRL_OUTPUT |
-							  AT91_PINCTRL_OUTPUT_VAL(0))>;
-					};
-				};
-			};
-
-			watchdog@fffffe40 {
-				status = "okay";
-			};
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -183,6 +141,36 @@
 	};
 };
 
+&pinctrl {
+	nattis {
+		pinctrl_usba_vbus: usba_vbus {
+			atmel,pins = <AT91_PIOD 28 AT91_PERIPH_GPIO
+				      AT91_PINCTRL_DEGLITCH>;
+		};
+
+		pinctrl_mmc0_cd: mmc0_cd {
+			atmel,pins = <AT91_PIOD  5 AT91_PERIPH_GPIO
+				      AT91_PINCTRL_PULL_UP_DEGLITCH>;
+		};
+
+		pinctrl_lvds_prlud0: lvds_prlud0 {
+			atmel,pins = <AT91_PIOA 21 AT91_PERIPH_GPIO
+				      (AT91_PINCTRL_OUTPUT |
+				       AT91_PINCTRL_OUTPUT_VAL(0))>;
+		};
+
+		pinctrl_lvds_hipow0: lvds_hipow0 {
+			atmel,pins = <AT91_PIOA 23 AT91_PERIPH_GPIO
+				      (AT91_PINCTRL_OUTPUT |
+				       AT91_PINCTRL_OUTPUT_VAL(0))>;
+		};
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 
-- 
2.11.0

