Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A75C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD5320883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdDt2tH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD5320883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754065AbeFUODE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:03:04 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46744 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:03:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id v13-v6so3314162wrp.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 07:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JbM7+aw3ZoSJU8jvG81mg3+zZsYPsmeNPizBP0wFNUU=;
        b=QdDt2tH72Neu4OE9gpUIEiRRL2NsRimDnzUHN4tCKVAv+IOwjPDmdiP6bz466HbU6J
         fDUWNvqYS7sxN63KVEPwb18/dw+6ygpiyB1osaU3d7tAI/fsxZY2RA9eNqoQFfZ+oN43
         2OhhTQmSWcj3SBr/I9wf/0QQh/bV1AHZOiyudu2FhlXBhpSlzJBYR7WUn8J+Vhd/2ue2
         YZsn+rek3vAdCT02m6HVCJMnOCA6zzgQB9+sNbDHysiUWGyxxGIirgPRGkjGw+0Pj9tS
         DRf9KYEm4BFQZOY8kXZXV1m219+Ojq79HqcYga8DMUvBrrG914nLQ8LcEFMuDk0FNknT
         HbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=JbM7+aw3ZoSJU8jvG81mg3+zZsYPsmeNPizBP0wFNUU=;
        b=Ggim9/jtdqeZ1nII23gN1Y5vGpKIIx62ebB10YAnCQxxW/ochUXhn49qohN/4N4UAp
         l4WqX+2W/OszEVHksI4mW11ymRCawMWXcCmFqAHJJfWwV7WWm7XVKUZ68XgcGG0I5oyp
         rAMiNqDlq7FlwlYAgmeR4mNLmTSYE675oZhFRLzy/DCwKhiUCGJ3ANbO8Z+RJlB+Erfn
         bF4DmGSQM+IPhxHj6cQaBeYunM9lfLJ4Zql0T4Y+NMzNfGoun3tumFpO93/rMXniynzt
         61tKEBuguWXqMpfA1YcMA68ZJX8c6j1GvjXoCWup+WdSY/I9Q4mGL1ypJtYDRDVanFcx
         advQ==
X-Gm-Message-State: APt69E0NXyYmZdyx4zPU/kI7jLvJ3W2MxuHZ30yx247C/0YVWeSMNbXY
        etADPbsSRKsRMtpIAo9C4No=
X-Google-Smtp-Source: ADUXVKIAVhiAMR8i/Ltpm3MWxF+64kKGUyoXdMMded1B04vujqsaFfnagdLfYdC/UZrzSAoLin+QfQ==
X-Received: by 2002:adf:eb0c:: with SMTP id s12-v6mr23226480wrn.174.1529589781829;
        Thu, 21 Jun 2018 07:03:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h12-v6sm1900250wmb.3.2018.06.21.07.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 07:03:01 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:02:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] semaphore: use raw_spin_lock_irq instead of
 raw_spin_lock_irqsave
Message-ID: <20180621140259.GA8492@gmail.com>
References: <alpine.LRH.2.02.1805301120180.3104@file01.intranet.prod.int.rdu2.redhat.com>
 <20180621135014.GA31371@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621135014.GA31371@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > The sleeping functions down, down_interruptible, down_killable and
> > down_timeout can't be called with interrupts disabled, so we don't have to
> > save and restore interrupt flag.
> > 
> > This patch avoids the costly pushf and popf instructions on the semaphore
> > path.
> > 
> > Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
> > 
> > ---
> >  kernel/locking/semaphore.c |   21 ++++++++-------------
> >  1 file changed, 8 insertions(+), 13 deletions(-)
> 
> I've applied this to the locking tree, I suspect we can do this on the condition 
> that it doesn't explode in early boot code (which has irqs disabled) and doesn't 
> generate early boot lockdep splats either.

Hm, this blew up pretty quick on a pretty regular x86-64 PC white-box, during 
early bootup:

  PANIC: early exception 0x08 IP 246:10 error ffffffff811537b2 cr2 0xffff88000240cff8

and I think it's due to your patch - verifying that now.

Thanks,

	Ingo
