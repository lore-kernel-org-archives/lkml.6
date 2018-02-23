Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3586829-1519410988-2-1691626997994385100
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
    t=1519410987; b=UeD0Eu73EIdEFqSBfo2wfggmM1SuqGTb2YhzLMOTp6y7UzU
    OZYKAy3iQ2AeygWTICg8kJD40kgnZebFIcL7hnZaxWOneTQxx5zfxCUFmye6/Jmc
    KEbSBcV4CjG46JE1RzZ2egIfRFWWNsFeHTnEgUKe6Ve9p9n0zuMezMHBWIdfR232
    +RP0tBAr2w/ZhthM8cq6DJW8TTv1fluvNuZjsDCtlRt8UwKNNAyLTP6B/3bT4brG
    zbDG//IoAmuiWngCKEnoUgCZvdnoNM6HM7QC4JsX3JWNcN2Z7VPZ/0YN4cnQrW0Q
    LBJwXnTpfjec4WSlmdiUKSxN4VIgNuEcI0LL4BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519410987; bh=nm9RKoc6a/k2/bshqegDiZDuSW
    G0nMaxSC/YtbgchTQ=; b=W9xenLAylE4niWKCKUNAwbxb8bk3BcDVHZpgCAiGME
    FA8bbgRG9jSJQZyMLsYO5SCB8zdbtPF+YJfv1Pcxz1DtvqDiIVw1gg196oIZmaxF
    y1qgVo7vcTCtxNYqDclWeaR5lDSWlMcsFGrqYNUJn0m+zyAJ17leVBhxLPyLl1c7
    3KvX+RLsDEQRzRD0qANYpr+WJs31weXKIMTzWClZAawiMhBXuiS6mhdp8wG7xWt6
    dgbIho1rCEWqD3QY1TBy4mtcB7dfHJvHyEpEm8ZrkTWBHiRgrwiLlItGRTDQE+bF
    2fwKGqZ6F4qNM09ql8ufIFj+yBw9Dk4wcTe/rjKpFajw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754023AbeBWSgW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:36:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37650 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754007AbeBWSgU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:36:20 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 033/193] ARM: dts: Fix omap4 hang with GPS connected to USB by using wakeupgen
Date: Fri, 23 Feb 2018 19:24:26 +0100
Message-Id: <20180223170331.289904566@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
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

From: Tony Lindgren <tony@atomide.com>


[ Upstream commit cf87634c8b24e24bf379b8c6807c8b0fb5f23567 ]

There's been a reproducable USB OHCI/EHCI cpuidle related hang on omap4
for a while that happens after about 20 - 40 minutes on an idle system
with some data feeding device being connected, like a USB GPS device or
a cellular modem.

This issue happens in cpuidle states C2 and C3 and does not happen if
cpuidle is limited to C1 state only. The symptoms are that the whole
system hangs and never wakes up from idle, and if a watchdog is
configured the system reboots after a while.

Turns out that OHCI/EHCI devices on omap4 are trying to use the GIC
interrupt controller directly as a parent instead of the WUGEN. We
need to pass the interrupts through WUGEN to GIC to provide the wakeup
events for the processor.

Let's fix the issue by removing the gic interrupt-parent and use the
default interrupt-parent wakeupgen instead. Note that omap5.dtsi had
this already fixes earlier by commit 7136d457f365 ("ARM: omap: convert
wakeupgen to stacked domains") but we somehow missed omap4 at that
point.

Fixes: 7136d457f365 ("ARM: omap: convert wakeupgen to stacked domains")
Cc: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Reviewed-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/omap4.dtsi |    2 --
 1 file changed, 2 deletions(-)

--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -844,14 +844,12 @@
 			usbhsohci: ohci@4a064800 {
 				compatible = "ti,ohci-omap3";
 				reg = <0x4a064800 0x400>;
-				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			usbhsehci: ehci@4a064c00 {
 				compatible = "ti,ehci-omap";
 				reg = <0x4a064c00 0x400>;
-				interrupt-parent = <&gic>;
 				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
