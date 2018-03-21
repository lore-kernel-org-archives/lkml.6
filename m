Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-193552-1521649447-2-12042344945599229202
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521649447; b=X9gZtyvlyjhPQjBlN2QgHBmABqrzCuW/pAg4SrsxlaUbl02
    s8nC2JZWzy1+X7XqEUZoLR3S/fhiqYMxEXlxf/DuqREVr0xZjIlhSk48omHZQPGc
    ogfKgYBo3ZNpYbFR/R31DNXVisI00LdVFUY1DgAbvvnCmjheYjoBH+FDQ3JFb272
    VKzcK+Ef/fyY+G8O6X6QpjBKUHpEGRrLU7x6/09vcaKbjKjnQ47T1088TnszcIXU
    fcUCfVWRCo5bOuMWCZRhiU7Vc/rNJimq+xBQb+R0Gxecyj2rs9nbpQI1YoCLgABE
    65mMr2jz630AM9XzG8bDFs5gH6e22/IvUeFvN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521649447; bh=IklNFdbJH9x0M4SiBiiUbnsY0H
    0WngyLuLKGKCZ9Nlc=; b=K8fWO0vngvyuKyBgb8qmdFsTAyv2/QRwT9oSxbi8Ji
    /b2mynIi0ToOo8QHtfYqEmH1qMxjaVj4blNigGdXMmx7MzkRkSznxPUJbQ1HFRbG
    LgFr2n65rwsLQqhardAiaMEGunzvnId60h07PT6S4eBBPcYHaJLT3+7HDOJnUNGM
    C6Qj3Pwrp3+tYbqxh4WcYDm7QdYvoson9BiEWfnll9pvh9L35BH/SddQvG1wMWTO
    tIxq1lKvvIu23SSX8Ftje+VmHh4y8SA3zntcPNvHDsKbAFWFRWIZztyvmcDx6DdC
    Jra5lJjDcIsHEHRdnXKUwO8tFbu/3fg4eiF8arRbywHg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=bootlin.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=bootlin.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbeCUQXN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 12:23:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:49390 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751739AbeCUQXL (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 12:23:11 -0400
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on mail.bootlin.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,SHORTCIRCUIT,
        URIBL_BLOCKED shortcircuit=ham autolearn=disabled version=3.4.0
Date: Wed, 21 Mar 2018 17:23:09 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Marek.Sieranski@microchip.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: at91: at91sam9g25: fix mux-mask pinctrl
 property
Message-ID: <20180321162309.GI3417@piout.net>
References: <20180313152005.21132-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313152005.21132-1-nicolas.ferre@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13/03/2018 at 16:20:05 +0100, Nicolas Ferre wrote:
> There are only 19 PIOB pins having primary names PB0-PB18. Not all of them
> have a 'C' function. So the pinctrl property mask ends up being the same as the
> other SoC of the at91sam9x5 series.
> 
> Reported-by: Marek Sieranski <marek.sieranski@microchip.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: <stable@vger.kernel.org> # v3.8+
> ---
>  arch/arm/boot/dts/at91sam9g25.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
