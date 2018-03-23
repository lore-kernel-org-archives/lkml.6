Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803923-2-5986733839203968448
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
    t=1521803922; b=Gh/0SosCb0IHq0ERo70316L9fb6bRW7cLuz0s2qQLIB1GMm
    5K1WFxIdWOqj0HDoLeH49rVo2XyaucRkFYkLehV9NGXSpCHKQzaDxFuqoqMuoYtX
    zdXnUgASRZ5TwG+i1ZGHEhd7e4BqMy9gYSH2If1Fd8IqDuQgI4syzbYYMeNg/mJP
    oZk9lcL+g9Jm9PX9HA4v7GBXaZkErqDYFm0e3C5hkAzyzmPs9mMlUfin3R3fzas5
    CapOSlBeZMyDogUEc42zvjeqD8ci7zzjD2+3lK1sqcPRIoaLRWad3LB5Kc7h6pjM
    gNbBrvQ/ZMc5V4vzIr6DlF2zq8re4mfCbDEiJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803922; bh=6Ilz9R+3oircKHOGAbwNTI/5PD
    VWZvNwC4o81WN1aFk=; b=FUbz9Rov7I/zB9ucyTwk2akL77EYfPomsJhAugMk/X
    kN78FzRGxPKr38g8UdFcYcdaKsX8/1l7vqOWyTyuE7iK96iVq1eI/cA052SxvycX
    w7ZT2lymHqaBUl79tdS4yg0zj1drSXXvN2CadXazPdqe3S3+3cL+PrBq4gHWAzJ6
    m/mg/YjP9Rf+yD3zAXZwsPo8Tt4kD/HITPNsdihIKvuPxxWx4w0UfreRdna7OTNE
    5r8gGmKO4Hma/EsZOLvsKfIQFQfWWW6bI2gXbYHOuPHBzz8Ql9P+unJ74Mr7Cs6d
    vzl5oWuhgr4zEp+/M3kGdaHSl1xFZm7qhdpSbNlKN0Lw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755701AbeCWKJI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41932 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755691AbeCWKJD (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 094/177] ARM: DRA7: clockdomain: Change the CLKTRCTRL of CM_PCIE_CLKSTCTRL to SW_WKUP
Date: Fri, 23 Mar 2018 10:53:42 +0100
Message-Id: <20180323094209.436754145@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kishon Vijay Abraham I <kishon@ti.com>


[ Upstream commit 2c949ce38f4e81d7487f165fa3b8f77d74a2a6c4 ]

The PCIe programming sequence in TRM suggests CLKSTCTRL of PCIe should be
set to SW_WKUP. There are no issues when CLKSTCTRL is set to HW_AUTO in RC
mode. However in EP mode, the host system is not able to access the
MEMSPACE and setting the CLKSTCTRL to SW_WKUP fixes it.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-omap2/clockdomains7xx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/mach-omap2/clockdomains7xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains7xx_data.c
@@ -524,7 +524,7 @@ static struct clockdomain pcie_7xx_clkdm
 	.dep_bit	  = DRA7XX_PCIE_STATDEP_SHIFT,
 	.wkdep_srcs	  = pcie_wkup_sleep_deps,
 	.sleepdep_srcs	  = pcie_wkup_sleep_deps,
-	.flags		  = CLKDM_CAN_HWSUP_SWSUP,
+	.flags		  = CLKDM_CAN_SWSUP,
 };
 
 static struct clockdomain atl_7xx_clkdm = {
