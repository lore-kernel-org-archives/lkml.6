Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A38C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC4AF20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBshMBr5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4AF20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeFUO2k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:28:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51922 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeFUO2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:28:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so5545011wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7pLq4YCB723nXOgP3EG8B6BlOw8MbOm0WJzEHg8sL2s=;
        b=fBshMBr5fHVAWVSMQA3/nozTieZlrs9NVYet5QrS9YH8kcIcHpSnBudFyNL06YmP7p
         DS6NCwzfiS0GBfDUzasbjRWsN9R68GF0jQFm6gs27celQSHwxgRNcLqzYiDe16xP3Hvi
         NE1GWvzqtQzHAQjF65yJpDqGuLnjRTENRksdKm5GWJHN7m+Rrg6sKrzIi2t0QotT78CI
         RMxuyOlf3hGzPv8bTUHvvBYllKUdTq/M+VX0EQ+eMtLhajdzrIoUg/RBFrfZEo/3xnkz
         T8V1n3cQH6sQUcDDJCPPT3gPzOwxgjewe3v9BSGUGvYO7gmAFjcZ3fyx6Z9ZIH7zyi/m
         V4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=7pLq4YCB723nXOgP3EG8B6BlOw8MbOm0WJzEHg8sL2s=;
        b=N2WHU6IXfaDuIrcwSPmcXR2XMLbfXzt3j2+nHPcKA5DehqMi0nqF+h/F8IAtjrmh+w
         Cwkh1ncUQeX2VQiba8cBIcVkFOXaAvQqyoPc8KeAjiJx5KgVgtje/TvN5ERSI4yO8G9F
         RZqm46SKOZ1rd8kTwDeZlgkCzf+lZiKG3QC1JHjsqX90Rm5zLJrsg6OKptT7YauVFkQZ
         Y2pDWczuPi5zRVT9U9HU9lUIkJJ7kKvhH8O9+dPDZiVIHdrQT/jeX35Sn1UhBv+CcYQ1
         ZrLYTbP89/mD8znG9FO5iChbosB/40K4rosYmD+AEXHfTan3CHsvsNNP7DFJdsJzIQgv
         5kNQ==
X-Gm-Message-State: APt69E32pz5TsL1jZik1j6xP28VpWqvGY02VGi83bWf8SO1aCvBfJNQ6
        ogoQsEr0+KSc7MlyBbtUsaSv+Q==
X-Google-Smtp-Source: ADUXVKLW21e52XoZc/hZlZ3ktQIJapMQ+oapgeSZKGHItfszW9FnbzDGOwzSrURgE3IJ7VkZcfS0/g==
X-Received: by 2002:a1c:9514:: with SMTP id x20-v6mr5739017wmd.76.1529591317748;
        Thu, 21 Jun 2018 07:28:37 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x11-v6sm2095571wrl.80.2018.06.21.07.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 07:28:36 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:28:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] semaphore: use raw_spin_lock_irq instead of
 raw_spin_lock_irqsave
Message-ID: <20180621142834.GA13940@gmail.com>
References: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
 <20180621135014.GA31371@gmail.com>
 <20180621140259.GA8492@gmail.com>
 <dd98938f-7ddc-f4c5-ad88-8562f3d001d5@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd98938f-7ddc-f4c5-ad88-8562f3d001d5@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> On 21/06/18 16:02, Ingo Molnar wrote:
> > 
> > * Ingo Molnar <mingo@kernel.org> wrote:
> > 
> >>
> >> * Mikulas Patocka <mpatocka@redhat.com> wrote:
> >>
> >>> The sleeping functions down, down_interruptible, down_killable and
> >>> down_timeout can't be called with interrupts disabled, so we don't have to
> >>> save and restore interrupt flag.
> >>>
> >>> This patch avoids the costly pushf and popf instructions on the semaphore
> >>> path.
> >>>
> >>> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> >>>
> >>> ---
> >>>  kernel/locking/semaphore.c |   21 ++++++++-------------
> >>>  1 file changed, 8 insertions(+), 13 deletions(-)
> >>
> >> I've applied this to the locking tree, I suspect we can do this on the condition 
> >> that it doesn't explode in early boot code (which has irqs disabled) and doesn't 
> >> generate early boot lockdep splats either.
> > 
> > Hm, this blew up pretty quick on a pretty regular x86-64 PC white-box, during 
> > early bootup:
> > 
> >   PANIC: early exception 0x08 IP 246:10 error ffffffff811537b2 cr2 0xffff88000240cff8
> > 
> > and I think it's due to your patch - verifying that now.
> 
> I guess local_irq_enable() being called by raw_spin_unlock_irq() makes
> its usage in early boot code undesirable.
> 
> Maybe it would be possible to use alternatives for that case? They are
> applied after enabling interrupts, so pushf and popf instructions could
> be patched away.

Or we could just leave the code as-is: the performance difference between CLI/STI 
and PUSHF/POPF shouldn't be significant, plus the semaphore APIs are obsolete and 
should not be used.

Thanks,

	Ingo
