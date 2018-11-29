Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C11C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81C9820832
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 01:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/IgGJBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81C9820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeK2MkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 07:40:13 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40646 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbeK2MkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 07:40:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so165736pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 17:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fw993pv5o1TlUVp2ke13U9oKHcqsHYVOQzMpwFye9BM=;
        b=K/IgGJBABepsNsNoUIqm/SldhyiI8uHiZ7HK8WhIqebUikHwqP8FZ5U6E3w8aN3eOv
         ZGHGeNk0kIWHfcG0pVWLTgdqDqxPFGEf9sQ4DQGcmSYgv/gRkOYG3NT4/C8/f7YGU14O
         D9L7zQx5+P6y3C+E2DvkgEUJgXcRsm6hXpR3RK4pDHLwsAZhSlSvuTPfF+OenApiNnqt
         bY40aF3yzMAtSgs2JaO8r13dJFsKZ2YqWxV/BZm9T7QiPHAWHq2dG8pGKdRUTK38T3rn
         eUaclBgn9pabqGxUoM6ZkFyIDQlY22KWaOQzFie/nDUZ2v2Zw9ohZNRXbGpfrNKk/17D
         aGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fw993pv5o1TlUVp2ke13U9oKHcqsHYVOQzMpwFye9BM=;
        b=PrSV9gXnWNOtCXiW0vglAHbLxx4VjQL/rNPKS1WqOUwCf/8rhe33kImTQZ1QX59rbe
         OrwvUzLRmB3cSM/lZDQ42cvulBs7KGw+N6a38vDJWh1UIO3i1exgIMKFKKoNPpNQkOOK
         8EdGlSfJ19XyZmLZxNq09Fm26mcSY336qJRSnARp4pW8jWaNMA2hkTcqrRxD2Ysv+tJJ
         sk2SzPdnCLn0B0b2wzgzPxJI4cUGHdqu/Xk+UN8/fRotb7jr8DGcXCvQfqIRRILDP4j2
         Wd253FSZgKARRjEDZ7v+ccrzTvgFj9lX1NxSjn3GeVE4JSx8R4ywm30jxu796st6FrA/
         1dcw==
X-Gm-Message-State: AA+aEWaCP92DjQ5OaO4PXpCynRJ+eoic3/C+P+O1CCuQAYcs6UqtwGG+
        lhYuEPHsDYrK8jJg5oImAURkJOnvDGE=
X-Google-Smtp-Source: AFSGD/W8O0II5qUScXEFFhCIh6fz+NloszJCu6xv9Zarv40L8ClowEufoCiT48XDylTr1eMKsG5dEQ==
X-Received: by 2002:a63:4745:: with SMTP id w5mr35899618pgk.377.1543455395831;
        Wed, 28 Nov 2018 17:36:35 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id o8sm320751pfa.42.2018.11.28.17.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 17:36:34 -0800 (PST)
Date:   Thu, 29 Nov 2018 10:36:30 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>
Subject: Re: [PATCH v3 5/7] zram: support idle/huge page writeback
Message-ID: <20181129013630.GA77327@google.com>
References: <20181127055429.251614-1-minchan@kernel.org>
 <20181127055429.251614-6-minchan@kernel.org>
 <20181128153559.f6645b98a7033b6f6f6b0fbc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128153559.f6645b98a7033b6f6f6b0fbc@linux-foundation.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Nov 28, 2018 at 03:35:59PM -0800, Andrew Morton wrote:
> On Tue, 27 Nov 2018 14:54:27 +0900 Minchan Kim <minchan@kernel.org> wrote:
> 
> > This patch supports new feature "zram idle/huge page writeback".
> > On zram-swap usecase, zram has usually many idle/huge swap pages.
> > It's pointless to keep in memory(ie, zram).
> > 
> > To solve the problem, this feature introduces idle/huge page
> > writeback to backing device so the goal is to save more memory
> > space on embedded system.
> > 
> > Normal sequence to use idle/huge page writeback feature is as follows,
> > 
> > while (1) {
> >         # mark allocated zram slot to idle
> >         echo all > /sys/block/zram0/idle
> >         # leave system working for several hours
> >         # Unless there is no access for some blocks on zram,
> > 	# they are still IDLE marked pages.
> > 
> >         echo "idle" > /sys/block/zram0/writeback
> > 	or/and
> > 	echo "huge" > /sys/block/zram0/writeback
> >         # write the IDLE or/and huge marked slot into backing device
> > 	# and free the memory.
> > }
> > 
> > By per discussion:
> > https://lore.kernel.org/lkml/20181122065926.GG3441@jagdpanzerIV/T/#u,
> > 
> > This patch removes direct incommpressibe page writeback feature
> > (d2afd25114f4, zram: write incompressible pages to backing device)
> > so we could regard it as regression because incompressible pages
> > doesn't go to backing storage automatically. Instead, usre should
> > do it via "echo huge" > /sys/block/zram/writeback" manually.
> 
> I'm not in any position to determine the regression risk here.
> 
> Why is that feature being removed, anyway?

Below concerns from Sergey:
https://lore.kernel.org/lkml/20181122065926.GG3441@jagdpanzerIV/T/#u

== &< ==
"IDLE writeback" is superior to "incompressible writeback".

"incompressible writeback" is completely unpredictable and
uncontrollable; it depens on data patterns and compression algorithms.
While "IDLE writeback" is predictable.

I even suspect, that, *ideally*, we can remove "incompressible
writeback". "IDLE pages" is a super set which also includes
"incompressible" pages. So, technically, we still can do
"incompressible writeback" from "IDLE writeback" path; but a much
more reasonable one, based on a page idling period.

I understand that you want to keep "direct incompressible writeback"
around. ZRAM is especially popular on devices which do suffer from
flash wearout, so I can see "incompressible writeback" path becoming
a dead code, long term.
== &< ==

My concern is if we enable CONFIG_ZRAM_WRITEBACK in this implementation,
both hugepage/idlepage writeck will turn on. However someuser want
to enable only idlepage writeback so we need to introduce turn on/off
knob for hugepage or new CONFIG_ZRAM_IDLEPAGE_WRITEBACK for those usecase.
I don't want to make it complicated *if possible*.

Long term, I imagine we need to make VM aware of new swap hierarchy
a little bit different with as-is.
For example, first high priority swap can return -EIO or -ENOCOMP,
swap try to fallback to next lower priority swap device. With that,
hugepage writeback will work tranparently.
	
> 
> > If we hear some regression, we could restore the function.
> 
> Why not do that now?
> 

We want to remove it at this moment. 
