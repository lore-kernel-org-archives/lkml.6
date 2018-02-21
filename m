Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217245-2-1348551896581741939
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519217244; b=JI1Y0mmjwEJAqy042Wnahk1BaQWbQPPkOgLulKAACfKoPuj
    UNCJVP2i6jTA03lntifBJfonNsJ8kft0dEFKnoiX+fgMHjqGLPwyOb3Sxmbc7SEE
    X/N5JP+vaTW48Dkri/sbYwQpfl71iZcG2NtI05nxGJoJm0lurdH5iXll1Fghnque
    Dq5zbzPT6Yt/BpH2vjTH7/HVFuwwpdKmJSb6SqFcvgPtt41oHGMmy/0Mhb7eNdLQ
    +o2AUybxXZVjhV5MGfVzyzUXqXgbM4j7gKGjgmCLhEiPEFPgfBWvOD8b5wWlkDc8
    qN0vGLpVDGlRRZ593Jlq3YghUPBm3RQrzH1mRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217244; bh=vn0WR/ZSN0+yiQxLn1gwI6W8jO
    l+FqXJ7BmJDAdaEmE=; b=NDutOollH6vg7unGn05vrhe4X9rx4sISm2qfROReTo
    JYnz4Yb6Ug7KRiktk2mcbBLMxuM8ND8grJL+bpVyBm6xWmYxDMPsI1dNdMIELcA8
    xDhIuY/bz312xDoTELAmtUfXtkbcbvl0kxU4aKQXGwQpK4FvRJC1eK9WajzfJv8l
    9/8hPF2hgoWzILXpI2kIESflOldjgfFK+7XxdnXVTi8//EOn8xcw5YXkqu7+7CfI
    fljyA1kk+Ng7AKVYfslKDZrfhdQdKZj8jUX2c9lWLKJUX3MR3G0QHtCQwQ3cTTFV
    RYvx45d7Ua7yC8oihIPlcBr6hy5mc5/6P5fkdVE8LwMg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933959AbeBUMqn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:46:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933905AbeBUMqm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:46:42 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 32/33] ARM: dts: s5pv210: add interrupt-parent for ohci
Date: Wed, 21 Feb 2018 13:45:15 +0100
Message-Id: <20180221124411.206905353@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit 5c1037196b9ee75897c211972de370ed1336ec8f upstream.

The ohci-hcd node has an interrupt number but no interrupt-parent,
leading to a warning with current dtc versions:

arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000
arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property): Missing interrupt-parent for /soc/ohci@ec300000

As seen from the related exynos dts files, the ohci and ehci controllers
always share one interrupt number, and the number is the same here as
well, so setting the same interrupt-parent is the reasonable solution
here.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/s5pv210.dtsi |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/boot/dts/s5pv210.dtsi
+++ b/arch/arm/boot/dts/s5pv210.dtsi
@@ -461,6 +461,7 @@
 			compatible = "samsung,exynos4210-ohci";
 			reg = <0xec300000 0x100>;
 			interrupts = <23>;
+			interrupt-parent = <&vic1>;
 			clocks = <&clocks CLK_USB_HOST>;
 			clock-names = "usbhost";
 			#address-cells = <1>;
