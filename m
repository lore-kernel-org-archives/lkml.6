Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD60B20853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 10:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tme7WzVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD60B20853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbeJVScF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 14:32:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34490 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeJVScF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 14:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1C0NOwfij2YrVl/JqT0FEB6Wd6YnN8jhsAJQwyzSHaA=; b=Tme7WzVBpSarp+jf7HxwpQciJ
        qNlh1v5xI2x7T3Z8GIbd9rVfRCphV654YKzw1KcW+B8Q4RJXllGAM/+7H81nbRuKwBDERpgrRAU4W
        3WV5Aab4FZ6RZAVmg2rf2bnlxetC8Zo59YCLs98OD9Y2SMhNMzFrllUkXF/S+CMwJy5e6q2GZ+/KU
        LnB/S6uhJmruR2W/Ln7M06VSQv18djKcV6KaoVpv3ZAMawN7Hqb6dsyTjdmNEN9zoTHJhKOlwcHSv
        4B1HLaqmuF2CyKd5LJJW/HVj3FQG45i/46Me8TbFQ51ZxS+RnQ7JuJLTNBhA3qKSb/PN9egbl9AiT
        7PMe9DPaw==;
Received: from [167.98.65.38] (helo=worktop)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gEXDi-0003kn-DS; Mon, 22 Oct 2018 10:13:58 +0000
Received: by worktop (Postfix, from userid 1000)
        id 4733D6E082E; Mon, 22 Oct 2018 12:08:30 +0200 (CEST)
Date:   Mon, 22 Oct 2018 12:08:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        tipbuild@zytor.com, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [tip:locking/core 6/10] arch/x86/include/asm/rmwcc.h:23:17:
 error: jump into statement expression
Message-ID: <20181022100830.GK4931@worktop.programming.kicks-ass.net>
References: <201810201105.YsnXEXTU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201810201105.YsnXEXTU%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 20, 2018 at 11:05:11AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> head:   01a14bda11add9dcd4a59200f13834d634559935
> commit: 7aa54be2976550f17c11a1c3e3630002dea39303 [6/10] locking/qspinlock, x86: Provide liveness guarantee
> config: x86_64-randconfig-u0-10201040 (attached as .config)
> compiler: gcc-5 (Debian 5.5.0-3) 5.4.1 20171010
> reproduce:
>         git checkout 7aa54be2976550f17c11a1c3e3630002dea39303
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from arch/x86/include/asm/atomic.h:5:0,
>                     from include/linux/atomic.h:7,
>                     from include/linux/crypto.h:20,
>                     from arch/x86/kernel/asm-offsets.c:9:
>    arch/x86/include/asm/qspinlock.h: In function 'queued_fetch_set_pending_acquire':
> >> arch/x86/include/asm/rmwcc.h:23:17: error: jump into statement expression
>        : clobbers : cc_label);    \
>                     ^
>    include/linux/compiler.h:58:42: note: in definition of macro '__trace_if'
>      if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
>                                              ^

ARGH; so, this:

#define __GEN_RMWcc(fullop, _var, cc, clobbers, ...)			\
({									\
	bool c = false;							\
	asm_volatile_goto (fullop "; j" #cc " %l[cc_label]"		\
			: : [var] "m" (_var), ## __VA_ARGS__		\
			: clobbers : cc_label);				\
	if (0) {							\
cc_label:	c = true;						\
	}								\
	c;								\
})

static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
{
	u32 val = 0;

	if (GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
			     "I", _Q_PENDING_OFFSET))
		val |= _Q_PENDING_VAL;

	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;

	return val;
}

fails to compile when combined with this:

#define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
#define __trace_if(cond) \
	if (__builtin_constant_p(!!(cond)) ? !!(cond) :			\
	({								\
		int ______r;						\
		static struct ftrace_branch_data			\
			__attribute__((__aligned__(4)))			\
			__attribute__((section("_ftrace_branch")))	\
			______f = {					\
				.func = __func__,			\
				.file = __FILE__,			\
				.line = __LINE__,			\
			};						\
		______r = !!(cond);					\
		______f.miss_hit[______r]++;				\
		______r;						\
	}))

Because that moves the __GEN_RMWcc into a statement expression and GCC
apparently doesn't like labels inside statement expressions.

If we avoid if() and rewrite queued_fetch_set_pending_acquire() like so:

static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
{
	bool pending;
	u32 val;

	pending = GEN_BINARY_RMWcc(LOCK_PREFIX "btsl", lock->val.counter, c,
				   "I", _Q_PENDING_OFFSET);

	val = pending * _Q_PENDING_VAL;
	val |= atomic_read(&lock->val) & ~_Q_PENDING_MASK;

	return val;
}

then it compiles again; but urgh.

Anybody see a better solution?
