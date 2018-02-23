Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519414103-2-4848418965868961502
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414102; b=qWMC+ORHh8zQ0vMgDfvjDetXt8QIMRkmwSoMouzJH0x+A9W
    WTNugm1yXkvRUIawJWQyPeein8FmeuXt0AEHfGKldw2KR7PrhRGuO4lQYUUqquLL
    29vos92AOem5MgNSLiirJYfbGbgElOn2GHiR3xsQ9rUKZqMXY2B0F0co6mbupKyC
    mj0RTpp53seghYA08VZ/5a2quojdpDygAdN5OrMFMz5nFyEYEgI7AHVVx1ZKPZYq
    0+lSHJRaOmFrSX2z3a+yAAbq6sxzPWjfmI7DSeR8f/ukbSqxTQUYbhoG3g2T6/Uo
    SlEAU4iVdAjSuNwc1rvQbZM+JcbxOi8kn37fgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414102; bh=rwWu4s2sm2J+10jV+AkYtB5LIl
    YA14gRivMLW6bCdTY=; b=UZD025gkyeIt27W5VQUXWQx1QvAsHBOMrMFMiF8OU+
    aJpNiLlnwMBJZBVu+JYvNJQA5uT0n7vIfeVmbvfgX0p51t+d+zhK4Q2UfSzQ/T0o
    X9Or+X6/9GnzOz9y6iGkT87Y9dzomAeDoFj2ON08o0OO2OFg7RtHSQ5YEWtadagL
    4vgsZdaUv0n1oBm8tXYr/MfxHNNDE28VC45d+7BJK5WCy8kO6QmqX0ld+r1l/EyG
    aQpxi9Jpd6C8vyE1BZ/YDhi+dk7nXtS3IE0YEKHhJPj5BWP+fbAERWOSqKDIX/HQ
    r4ftMWftYf0g0M/jSx0IO5mIR/HZ3P3rq1Sm/vWBLPSQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935048AbeBWT2H (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 14:28:07 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46802 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935100AbeBWSwM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 065/159] ARM: dts: logicpd-somlv: Fix wl127x pinmux
Date: Fri, 23 Feb 2018 19:26:13 +0100
Message-Id: <20180223170751.436340815@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>


[ Upstream commit cd7594ac3281722cb8f10d6f6c7e4287747c7a9d ]

The pin assignment for the wl127x interrupt was incorrect.  I am
not sure how this every worked.  This also eliminates a conflict with
the SMC911x ethernet driver and properly moves pinmuxes for the
related gpio to omap3_pmx_wkup from omap3_pmx_core.

Fixes: ab8dd3aed011 ("ARM: DTS: Add minimal Support for Logic PD
DM3730 SOM-LV")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/logicpd-som-lv.dtsi |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/arch/arm/boot/dts/logicpd-som-lv.dtsi
+++ b/arch/arm/boot/dts/logicpd-som-lv.dtsi
@@ -121,7 +121,7 @@
 
 &mmc3 {
 	interrupts-extended = <&intc 94 &omap3_pmx_core2 0x46>;
-	pinctrl-0 = <&mmc3_pins>;
+	pinctrl-0 = <&mmc3_pins &wl127x_gpio>;
 	pinctrl-names = "default";
 	vmmc-supply = <&wl12xx_vmmc>;
 	non-removable;
@@ -132,8 +132,8 @@
 	wlcore: wlcore@2 {
 		compatible = "ti,wl1273";
 		reg = <2>;
-		interrupt-parent = <&gpio5>;
-		interrupts = <24 IRQ_TYPE_LEVEL_HIGH>; /* gpio 152 */
+		interrupt-parent = <&gpio1>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>; /* gpio 2 */
 		ref-clock-frequency = <26000000>;
 	};
 };
@@ -157,8 +157,6 @@
 			OMAP3_CORE1_IOPAD(0x2166, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat5.sdmmc3_dat1 */
 			OMAP3_CORE1_IOPAD(0x2168, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat2 */
 			OMAP3_CORE1_IOPAD(0x216a, PIN_INPUT_PULLUP | MUX_MODE3)	/* sdmmc2_dat6.sdmmc3_dat3 */
-			OMAP3_CORE1_IOPAD(0x2184, PIN_INPUT_PULLUP | MUX_MODE4)	/* mcbsp4_clkx.gpio_152 */
-			OMAP3_CORE1_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
 			OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3) /* mcspi1_cs1.sdmmc3_cmd */
 			OMAP3_CORE1_IOPAD(0x21d2, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs2.sdmmc_clk */
 		>;
@@ -228,6 +226,12 @@
 			OMAP3_WKUP_IOPAD(0x2a0e, PIN_OUTPUT | MUX_MODE4)	/* sys_boot2.gpio_4 */
 		>;
 	};
+	wl127x_gpio: pinmux_wl127x_gpio_pin {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a0c, PIN_INPUT | MUX_MODE4)		/* sys_boot0.gpio_2 */
+			OMAP3_WKUP_IOPAD(0x2a0c, PIN_OUTPUT | MUX_MODE4)	/* sys_boot1.gpio_3 */
+		>;
+	};
 };
 
 &omap3_pmx_core2 {
