Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA4C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93182086B
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 04:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKMf66MH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93182086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbeKZPuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 10:50:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41040 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKZPuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 10:50:07 -0500
Received: by mail-pl1-f194.google.com with SMTP id u6so13263182plm.8
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 20:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ImIdEz/mSkGGs8h9Uvsojw5yvuiE8ggzgSltd/tEqUQ=;
        b=RKMf66MHq2soXopaTKq+9jn6oh07zSvirDzhx43yXZYeWZ1E/gtYgFrzNJCVYF/ixR
         kvA3DADurE/GMX/gYtN7FVN1YWxZ8bWKwB8AHay+BV1I2AS40X+22A2/H4nobvFEUN9U
         b0+zm5CwotWCfo4m6ajhrVyrtNGwh5HShmLsjxkqLiVjYzwwPP7po8U4UocP0K01zamL
         FV7t9Yujl8Y64BHFKz4iA741GET62XHhoZtXv1+hVA9oKiCWeyhHZ8SL+9T889Tbcncq
         1+hUIqS53hlGWDA2xwIvxo5mhnVix/4pIBNF/gTNuD2xTfnqa27A93nmdX6MVGS8dblL
         xRPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ImIdEz/mSkGGs8h9Uvsojw5yvuiE8ggzgSltd/tEqUQ=;
        b=OLu8oH1s1WfT7ZasjXjMZSOvwh+4Y9+etjGhpmGpeI1axwmnf6tRXGzLNKZ2mHxJGg
         NLcCwhqKYJnquMsyqPjhiMasbIpb6dN3uUpfDoTlL2axn6jcB+Z6h3SFDBk/XxvXm3Qp
         86FnAfY0gjG/ZaHNg0cuVRHyvhiZ/7KGHZnAcVxJRc1IwvMi++k+0DfISJ5JgtlbPxRw
         R44L9qlacjHHdXnGO7g4RDn4WxHxhfLqRaoDlpFHDi/PDa/f/9hJPmexAH2WZN933YLb
         HoQSK3CWsOOACXb2V0n4WTv5whLjQG6Qa9x+S93DiczpEF80/V2JaD9NlTUEJ35acsL3
         xX2A==
X-Gm-Message-State: AA+aEWYh8HitF85VuxGAx18/t3Hnok4oUnwDHZsWgY7Wng05nLqXGcY1
        jrBxLPW7kdK3JjTJ4zDJXDfgKKa2
X-Google-Smtp-Source: AFSGD/U+ovqUhxfxsfpWL/sCejJc1X61NQxzstox6Lo8gMdY/VAFH9wnRWMurhjCmVEMGzSKg3Oz8Q==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32mr26226364plj.318.1543208232966;
        Sun, 25 Nov 2018 20:57:12 -0800 (PST)
Received: from localhost ([175.223.33.236])
        by smtp.gmail.com with ESMTPSA id d25sm3949276pfe.40.2018.11.25.20.57.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Nov 2018 20:57:11 -0800 (PST)
Date:   Mon, 26 Nov 2018 13:57:09 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 07/17] debugobjects: Move printk out of db lock
 critical sections
Message-ID: <20181126045709.GD540@jagdpanzerIV>
References: <1542653726-5655-1-git-send-email-longman@redhat.com>
 <1542653726-5655-8-git-send-email-longman@redhat.com>
 <2ddd9e3d-951e-1892-c941-54be80f7e6aa@redhat.com>
 <20181122020422.GA3441@jagdpanzerIV>
 <20181122101606.GP2131@hirez.programming.kicks-ass.net>
 <20181123024048.GD1582@jagdpanzerIV>
 <20181123114826.h27t7qiwfp7grrqx@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123114826.h27t7qiwfp7grrqx@pathway.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/23/18 12:48), Petr Mladek wrote:
[..]
> > This should make serial consoles re-entrant.
> > So printk->console_driver_write() hopefully will not deadlock.
> 
> Is the re-entrance safe? Some risk might be acceptable in Oops/panic
> situations. It is much less acceptable for random warnings.

Good question.

But what's the alternative? A deadlock in a serial console driver; such
that even panic() is not guaranteed to make through it (at least of now).
debug objects are used from the code which cannot re-entrant console
drivers.

bust_spinlock is called from various paths, not only panic.
git grep bust_spinlocks | wc -l
62

So we already switch to re-entrant consoles (and accept the risks) in
mm/fault.c, kernel/traps.c and so on. Which, I guess, makes us a little
more confident, faults/traps happen often enough.

It seems, that, more or less, serial consoles are ready to handle it.
UART consoles in ->write() callbacks just do a bunch of writel() [for
every char + \r\n].

	-ss
