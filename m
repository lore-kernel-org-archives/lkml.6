Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653261-2-5480997837077304782
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='jp',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524653260; b=Lk3rLdvCUJisN6b1GStKLpsVl0CAI5893sYslsoT/ZZwuTjTts
    e4pykCYHYzCmz4ZwVBx4ar80NsShbgmE/xiDnf5PKpyCeuELPcBLU1irRcdMeBRd
    CR8BskkhpLAQXB8XdmU/eqmpitpx4XlWbb28uxglw9JTnzNzAizGwck2VsaR7fC3
    F1NU+gBZk+lv+B9P+i4JEcU566VuCM49cqAKxE6QzP1HaTniVay+jKiNO85pFoAM
    GtTepNK2xYyjXGUQosv0AEm2rzP3kIhAdF16P87rb+pJGdNX567+X1fhTLVysmET
    7+FzaD5gPciWrD/h+68CsgOTQHGxAYzvDICw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:subject:from:references:in-reply-to
    :message-id:date:mime-version:content-type:sender:list-id; s=
    fm2; t=1524653260; bh=MX0wzSHwweS9YP+OOM8KzoNPIZ+1iR57A9qmktKVmM
    g=; b=d5jD2IgYsibZpwdhKBBlzfYiHmf72jjyI5nic8m1LaOp9a1DamwZW1I15m
    n5MTPNoarvZueni4qEY7m3NxbbMlhtrJrbu9OS/Ued2bIKPRpD6IvxPJMDRKKm/b
    DmTLg1urD08ZQcqH4LlII+cveSHuYKr8H8cxENdWb5Y4nbDobxXbf1LsYQEN7xb7
    2McorfUk6R7XkqJBvon4Utod3/1LUFNKQk94D/JygzcIXk261SgJXN0xjN25JNBO
    hRZN/N1sDEqkvdHdPdPUfh9StA1sZ6MwDA58EbMNraMFk6goT417HkD9I39l3OMh
    o9XhMCTwEw4drwKdfMdh9sgyOGKg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=i-love.sakura.ne.jp header.result=pass header_org.domain=sakura.ne.jp header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHScLNgNbxgRAiR/7YH/e8Zy+EXPwIrhzCHg3H6c/94+MqqJqPCn5ByZFJHrC/dxTpHmB+0cXfbmsgc7Akge/H753rzeQ1YDp/kfSLG5xkkMdZiU14Li
    KFxg3S+3hE+Lz8Amluv41g0gYiMXTFcl/hjxd6DHqL7G8MYvVwuXeX2u6JzFfY/sc4wiypZaYP19EBiQIAw3SiN5V7eeh+5vkl2JKtiAkkx+YK4cgtWUKCyJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=etHsGdlofrKz3riGEbAA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeDYKr1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:47:27 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55532 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754208AbeDYKrY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:47:24 -0400
To: tytso@mit.edu
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] random: fix possible sleeping allocation from irq context
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <20180424034138.23994-1-tytso@mit.edu>
        <201804250046.w3P0kgkd045841@www262.sakura.ne.jp>
        <20180425060017.GB3412@thunk.org>
In-Reply-To: <20180425060017.GB3412@thunk.org>
Message-Id: <201804251947.IEH51029.FOHOOFFLVtSMJQ@I-love.SAKURA.ne.jp>
X-Mailer: Winbiff [Version 2.51 PL2]
X-Accept-Language: ja,en,zh
Date: Wed, 25 Apr 2018 19:47:17 +0900
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Theodore Y. Ts'o wrote:
> On Wed, Apr 25, 2018 at 09:46:42AM +0900, Tetsuo Handa wrote:
> > Theodore Ts'o wrote:
> > > We can do a sleeping allocation from an irq context when CONFIG_NUMA
> > > is enabled.  Fix this by initializing the NUMA crng instances in a
> > > workqueue.
> > 
> > Offloading to workqueue context itself would be OK,
> > but this patch makes linux.git unbootable because
> > 
> > 	if (crng == &primary_crng && crng_init < 2) {
> > 		invalidate_batched_entropy();
> > 		numa_crng_init(); // <= Deferred to workqueue context.
> > 		crng_init = 2; // <= Not waiting for workqueue context, and oops before console becomes ready. ;-)
> > 		process_random_ready_list();
> > 		wake_up_interruptible(&crng_init_wait);
> > 		pr_notice("random: crng init done\n");
> > 	}
> > 
> > Please don't pretend rng_ready() before workqueue context is processed.
> 
> Where's the oops?

I assumed an oops happened, for the kernel did not start printing messages even
after 1 minute from guest's power on, and CPU usage (seen from host side) says
that 1 CPU is busy-looping; which is a phenomenon that the kernel panic()ed at
very early stage. And reverting only your patch solved the problem.

But I can no longer reproduce it. I should have saved the kernel config...
So, if nobody sees regression, please go with your patch.

-DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
+static DECLARE_WORK(numa_crng_init_work, do_numa_crng_init);
