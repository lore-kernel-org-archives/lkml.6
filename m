Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1715849-1520641191-2-10114556080642218692
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520641190; b=i2z+RANBk0urQa7h+EGD6u//Edsl1b5bUhnwRvMDDlXbeZt
    33g9dDbwYRZCYQ1RTWxNejSEpzu+Ih/2BFA8tkCY9ghKtnBNBPiIwz+uArV8qcvb
    HMLcubJ3wJBm4LNFdY6I+CEYkAD278NuBEuAQIpSD4a8RSaO2mqZe7rOVKSyhpDG
    LsquYh/4OFHIpdLqfKpKayRgGGd1s0NlUKX/dnIxupBYQ/2HjwKVzv7MSLBZRCJz
    iBmscoAAQkCS1gZL7K0OiD+rGGRTtmknkvxca9yUS5ZLsu53GqJ31Cw8SH9H37zI
    XKeRxkQlAy/mACOTTjkzMHvoLJgiAMxIf8eNSBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520641190; bh=5VE5CQTw9MNKJUof2x9nm342z0
    sN/CRAsdUrtzmdJVk=; b=Swe1B6rJ0yi+DI1BzW4myTJ2j6J1XiTvkzEVnVS5mu
    3yCZF/UDO5LZgZKWetRHhhTJB7slLPFgFWOnTGUzp2iq0jfq0scHHzdRZVIpDuno
    5rxKqVlTZu4FiYU5BEOFx+zIQTWw3GDpaFpD7jOxZ78uxUZ3rCnFgNR6GePdGZX2
    lAs366RrbZOmxm41S34u4e+P+9x0sWInCXUve2bwj8EZ2Su+xUJOayFupZfWL7eA
    CA1Nc9m9lmT4XTWgRl5Wgqjn1eraN7V000fE2g+l763eFL8aJVuwGRkYxiAUeero
    ZRHwD1y3eSD9Hduvn9bOVUYsh1jrakJjoY9L6xtuzBrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeCJATq (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 19:19:46 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751696AbeCJATp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Mar 2018 19:19:45 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4.4 13/36] ARM: dts: LogicPD Torpedo: Fix I2C1 pinmux
Date: Fri,  9 Mar 2018 16:18:29 -0800
Message-Id: <20180310001807.970379538@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

commit 74402055a2d3ec998a1ded599e86185a27d9bbf4 upstream.

The pinmuxing was missing for I2C1 which was causing intermittent issues
with the PMIC which is connected to I2C1.  The bootloader did not quite
configure the I2C1 either, so when running at 2.6MHz, it was generating
errors at time.

This correctly sets the I2C1 pinmuxing so it can operate at 2.6MHz

Fixes: 687c27676151 ("ARM: dts: Add minimal support for LogicPD Torpedo
DM3730 devkit")

Signed-off-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
+++ b/arch/arm/boot/dts/logicpd-torpedo-som.dtsi
@@ -90,6 +90,8 @@
 };
 
 &i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
 	clock-frequency = <2600000>;
 
 	twl: twl@48 {
@@ -146,6 +148,12 @@
 			OMAP3630_CORE2_IOPAD(0x25da, PIN_INPUT_PULLUP | MUX_MODE2)   /* etk_ctl.sdmmc3_cmd */
 		>;
 	};
+	i2c1_pins: pinmux_i2c1_pins {
+		pinctrl-single,pins = <
+			OMAP3_CORE1_IOPAD(0x21ba, PIN_INPUT | MUX_MODE0)        /* i2c1_scl.i2c1_scl */
+			OMAP3_CORE1_IOPAD(0x21bc, PIN_INPUT | MUX_MODE0)        /* i2c1_sda.i2c1_sda */
+		>;
+	};
 };
 
 #include "twl4030.dtsi"
