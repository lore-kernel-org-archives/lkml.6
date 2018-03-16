Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2051848-1521175850-2-8074386737391681608
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521175849; b=izz5HlniaicuRnI8dIfog2PoLr21hEFaihgVQjcB6ZZkRE0
    BiCtWqM+6+5VezdpA1F4C2O8b7QfsCvvyiGkCJuK/IpcNP/7VYH/OaRomVzut322
    1c8krutHxxsxdpkFaxI62Fqhcn/bLnG7PAKc6idyhYc7iSt/0voW/Cp4IF/4VChJ
    s409uFv+FEu91z/Oj2QLmZOyXZd8CI1cYHnR+rPhL10KbcHBOqXra1TEB3uqqcey
    HGaY9EXzGvIZ6z3oFNWZBk/RR3EGWc7Pa94XdP1SjnfuPD2grez3LhMI2tjUE34L
    Qsyv+kaiIs/95tbpsyN4P0xkQivESY5/ubJdPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521175849; bh=mWMQhvylOGTggSqupCLEdr3ZhD
    ff/oLBB8YNP2m7Pmg=; b=S7o6/78EGA9rKPVFQNelHkAdOCoM/WOOws8Mam55JF
    zt7DeVDFutqKyTAfCUnJR2ASOzEginSKHFyaREJD80XxzAi+/hE/Io5pGDlar4CK
    B6exDnKQbWYLIql5YG+BavO/Ljs+6/bUOZHJzeHvtuX2ddI9IsFywP8en4b7tROq
    d5vTzEBsqf/+/TkpPFw5Teb8l21sCymm9kFvFqsKEJXUCxvapGYjL9kQxIo5rS17
    7LH9JwPvw3lQdcHKB5tACedH6GxF000im2kpjV2Sb94stcmD86M+k9nTo28HPf9w
    8RKRhyb1Lj09Z63gbvBSVS/ISg97UeCN29KDgEYqeKiw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iuaRYmtA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WgYnPh/T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=iuaRYmtA x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WgYnPh/T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeCPEug (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 00:50:36 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37477 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeCPEu3 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 00:50:29 -0400
X-Google-Smtp-Source: AG47ELszBUow7lgV6sAHIE9oAlYxOIDc0e6j/J7/lnECCjCcTf7gn494naIk/nRl9KUDIO06gq2Y3Q==
Date: Fri, 16 Mar 2018 10:20:16 +0530
From: afzal mohammed <afzal.mohd.ma@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi <linux-spi@vger.kernel.org>, linux-usb@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 00/16] remove eight obsolete architectures
Message-ID: <20180316045016.GA7697@afzalpc>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a10hBz7QYk5v5MfhVMPOwFnWYTn95WZp1HtHrd7-GQpRg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Mar 15, 2018 at 10:56:48AM +0100, Arnd Bergmann wrote:
> On Thu, Mar 15, 2018 at 10:42 AM, David Howells <dhowells@redhat.com> wrote:

> > Do we have anything left that still implements NOMMU?

Please don't kill !MMU.

> Yes, plenty.

> I've made an overview of the remaining architectures for my own reference[1].
> The remaining NOMMU architectures are:
> 
> - arch/arm has ARMv7-M (Cortex-M microcontroller), which is actually
> gaining traction

ARMv7-R as well, also seems ARM is coming up with more !MMU's - v8-M,
v8-R. In addition, though only of academic interest, ARM MMU capable
platform's can run !MMU Linux.

afzal

> - arch/sh has an open-source J2 core that was added not that long ago,
> it seems to
>   be the only SH compatible core that anyone is working on.
> - arch/microblaze supports both MMU/NOMMU modes (most use an MMU)
> - arch/m68k supports several NOMMU targets, both the coldfire SoCs and the
>   classic processors
> - c6x has no MMU
