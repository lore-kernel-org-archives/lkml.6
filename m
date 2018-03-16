Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4183316-1521242701-2-10405453393302390069
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521242700; b=OHcfAmn5zBGp5cdxzUcjdNj1TNgKdSspHVNeYpWJ0t844Fi
    43ViRjTrY4RBDrkFqHMbsnjnZPQxNP8R7kOzJmcN33CWpxAja9OVzjtrBvOsaz9C
    e5WAs0hWltmYPkySqqTtuNtShR3Z7thzPjlmDaQzD4xpjoZP7EyaoYnQDW9Eddnw
    MmAosQXA6SVPKmvM6KtG+XL6glUggqFMEAEa1pBhr+1PGaWf2A/fvgutzBcDnWZY
    q56rZ4ZVktq8tonKAWapFGnL/eH0xooYMj1YsmGW3y4y1ksrA3eE/YGWLE4nGp5D
    PSXTHYeJLyiFu+6lgDbPCY2BxnATGQ+tqAsxsTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521242700; bh=V8JLcHq3hVwEKRV5u3bTqBUCyZ
    jg5kiOqjqUPF5NcDI=; b=sZ4VodpV5rinUrUPxfvB1NRQWpmQCg7n9iEoUmWNFj
    Cu3bbnsQx2J2znHLgHLXAQbDby7SzxEwUQk2AXuhIrI6bGhSgEABYBMqNIWbj6Pa
    P0y0DY9ecBj9cp6tVjkIcF/jQlfCK6sIGYMo1q/NbkDTj3T1JgRHYmoLDMkrIpph
    KX5G2i9lLa7nTGsVM9lqXkobCstwJacL/V9wPlQlwI5fY0jscg1A7XRnckEac6hY
    VEdGBnXloDY1IwSuNICrXrarY+I5OfIZnCd6lx4q0KKwF9o9r0Aog7cBECRxPHMg
    hojKv8eYxFOrQ339px3IbWiHp4ad4N54G+QlPj+XUHBw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=libc.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=libc.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=libc.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCPXY5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 19:24:57 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:60786 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbeCPXY4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 19:24:56 -0400
Date: Fri, 16 Mar 2018 19:13:59 -0400
From: Rich Felker <dalias@libc.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Huacai Chen <chenhc@lemote.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>, linux-mips@linux-mips.org,
        Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180316231359.GU1436@brightrain.aerifal.cx>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316151337.f277e3a734326672d41cec61@linux-foundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 03:13:37PM -0700, Andrew Morton wrote:
> On Fri, 16 Mar 2018 15:55:16 +0800 Huacai Chen <chenhc@lemote.com> wrote:
> 
> > Call __stack_chk_guard_setup() in decompress_kernel() is too late that
> > stack checking always fails for decompress_kernel() itself. So remove
> > __stack_chk_guard_setup() and initialize __stack_chk_guard before we
> > call decompress_kernel().
> > 
> > Original code comes from ARM but also used for MIPS and SH, so fix them
> > together. If without this fix, compressed booting of these archs will
> > fail because stack checking is enabled by default (>=4.16).
> > 
> > ...
> >
> >  arch/arm/boot/compressed/head.S        | 4 ++++
> >  arch/arm/boot/compressed/misc.c        | 7 -------
> >  arch/mips/boot/compressed/decompress.c | 7 -------
> >  arch/mips/boot/compressed/head.S       | 4 ++++
> >  arch/sh/boot/compressed/head_32.S      | 8 ++++++++
> >  arch/sh/boot/compressed/head_64.S      | 4 ++++
> >  arch/sh/boot/compressed/misc.c         | 7 -------
> >  7 files changed, 20 insertions(+), 21 deletions(-)
> 
> Perhaps this should be split into three patches and each one routed via
> the appropriate arch tree maintainer (for sh, that might be me).

Apologies for that. I'm trying to pick back up on things now, now that
I've got both some downtime from other things and funding for core sh
maintenance stuff. If you know any issues you'd especially like me to
put my attention on now, please let me know. I have a few patches
queued up from myself and others, but I believe there's a lot more I
haven't been able to get to for quite a while. I should have new SH
hardware to test on soon and in the meantime I've improved my qemu
setup.

One question I have about this specific patch is why any code is
needed at all. Why can't __stack_chk_guard just be moved to
initialized data, or left uninitialized, for the compressed kernel
image loader? Assuming it is needed, the code looks ok, but I question
the premise.

Rich
