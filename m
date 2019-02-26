Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D48C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6480A20C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfBZSUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:20:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:50242 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728793AbfBZSUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:20:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 827E8ACD3;
        Tue, 26 Feb 2019 18:20:21 +0000 (UTC)
Date:   Tue, 26 Feb 2019 10:20:13 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [PATCH-tip v2 00/10] locking/rwsem: Rwsem rearchitecture part 1
Message-ID: <20190226182013.iynflounqufjtnli@linux-r8p5>
References: <1550263810-31947-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1550263810-31947-1-git-send-email-longman@redhat.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019, Waiman Long wrote:

> v2:
>  - Sync up to v4 of the part 0 patch.
>  - Remove the rwsem.h->rwsem-xadd.h renaming patch & change patches
>    to modify rwsem.h instead of rwsem-xadd.h.
>  - Add a new patch to micro-optimize rwsem_try_read_lock_unqueued().
>
>This is part 1 of a 3-part (0/1/2) series to rearchitect the internal
>operation of rwsem. This depends on the v4 part 0 patches sent out
>previously
>
>https://lore.kernel.org/lkml/1550095217-12047-1-git-send-email-longman@redhat.com
>
>This part lays the foundation for part 2 without making any functional
>changes. This part includes the following changes:
>
> 1) Move code around and micro-optimize rwsem_try_read_lock_unqueued()
>    (patches 1-4).
> 2) Enhance the DEBUG_RWSEMS_WARN_ON() macro to provide more information
>    and add additional checks (patches 5 & 6).
> 3) Make the core qspinlock_stat.h code generic (lock event counting)
>    so that it can be used by all the architectures as well as other
>    locking subsystems such as rwsem (patches 7-10). Lock event
>    counting help us visualize how frequently a code path is being
>    used as well as spotting abnormal behavior due to bugs in the code
>    without noticeably affecting kernel performance and hence behavior.
>
>Both (2) and (3) are useful debugging aids.

Yes, this will come in handy in the future. Feel free to add my:

Acked-by: Davidlohr Bueso <dbueso@suse.de>

Thanks.
