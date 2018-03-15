Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-679016-1521133727-2-16856667215157091481
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521133727; b=j5EEHS7kTKIcg9RUW3oFT9mPJid7cdA8nkBlvIuBGABsUBz
    nJ/bWuntVHLAJDBKq7cY6VIswdY4Zx1CYMuGz+HPjC7a7hjZs+Z64GuHI46E0aSW
    QFOLtZ9CKNWA5LiFOjzExuR0SXSqy3BGtniopgTu5E2zAGDBqzoyoVrqJLOV9mAh
    qtCiLOtjyBjrlNLuweVfQNb8GRd7Q/9X51fwTs6R7T0PdAVkQWFz1pp6ydyWhKdf
    8YX5odIBVdA7WcTPMTdOGVOZWC06ayFoFc/FeA31ZA+q2lj7zEn5oTAX1UHvDD0e
    G0yXzUM0grx1RHDaxxyoHDw4wZ2KzFlFGrXU1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521133727; bh=WA/qBYF9h1gqPK5r/Yu04WOoTd
    zurXVouxK5DQKkrPo=; b=V7vRPBeI2mluuoub7VH/QylQcYjaWV1I6buFtPVbH/
    FYXWfONPiH13yR1KKmH7xikoHhgZnCqEMhcnaVqI9WXuHjgyNH45Akk8fj+C8ZXx
    vo+N2QtICytRxu3a5CEk9NACPEJELSqGOxGTupRW6xNe+iUHFG39v8PasG2umuKC
    seMmbs9ePUd8PHXDKv81fqeO5oh2yq6KH6IAL+MAE2tOH49QpSnyHC9NvTSFNEEC
    aF0+ZbI0sKfuI/BDampHMRPToQZNyWPwNqiZITwxgLdJyUC2iUX2vg+jj8lVBZ0h
    MOsmAJ9gJHXtp3uolN82CDZW0PO3HybKUdUKwaUwWVgA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=R4+n64fc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=R4+n64fc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeCORIo (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 13:08:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53500 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeCORIg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 13:08:36 -0400
Date: Thu, 15 Mar 2018 10:08:30 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Joe Perches <joe@perches.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-input@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        linux-rtc@vger.kernel.org, linux-spi <linux-spi@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: rfc: remove print_vma_addr ? (was Re: [PATCH 00/16] remove eight
 obsolete architectures)
Message-ID: <20180315170830.GA17574@bombadil.infradead.org>
References: <20180314143529.1456168-1-arnd@arndb.de>
 <2929.1521106970@warthog.procyon.org.uk>
 <CAMuHMdXcxuzCOnFCNm4NXDv-wfYJDO5GQpB_ECu7j=2BjMhNpA@mail.gmail.com>
 <1521133006.22221.35.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521133006.22221.35.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 09:56:46AM -0700, Joe Perches wrote:
> I have a patchset that creates a vsprintf extension for
> print_vma_addr and removes all the uses similar to the
> print_symbol() removal.
> 
> This now avoids any possible printk interleaving.
> 
> Unfortunately, without some #ifdef in vsprintf, which
> I would like to avoid, it increases the nommu kernel
> size by ~500 bytes.
> 
> Anyone think this is acceptable?
> 
> Here's the overall patch, but I have it as a series
> ---
>  Documentation/core-api/printk-formats.rst |  9 +++++
>  arch/arm64/kernel/traps.c                 | 13 +++----
>  arch/mips/mm/fault.c                      | 16 ++++-----
>  arch/parisc/mm/fault.c                    | 15 ++++----
>  arch/riscv/kernel/traps.c                 | 11 +++---
>  arch/s390/mm/fault.c                      |  7 ++--
>  arch/sparc/mm/fault_32.c                  |  8 ++---
>  arch/sparc/mm/fault_64.c                  |  8 ++---
>  arch/tile/kernel/signal.c                 |  9 ++---
>  arch/um/kernel/trap.c                     | 13 +++----
>  arch/x86/kernel/signal.c                  | 10 ++----
>  arch/x86/kernel/traps.c                   | 18 ++++------
>  arch/x86/mm/fault.c                       | 12 +++----
>  include/linux/mm.h                        |  1 -
>  lib/vsprintf.c                            | 58 ++++++++++++++++++++++++++-----
>  mm/memory.c                               | 33 ------------------
>  16 files changed, 112 insertions(+), 129 deletions(-)

This doesn't feel like a huge win since it's only called ~once per
architecture.  I'd be more excited if it made the printing of the whole
thing standardised; eg we have a print_fault() function in mm/memory.c
which takes a suitable set of arguments.
