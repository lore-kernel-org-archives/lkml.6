Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50EC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531B320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:39:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531B320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731781AbeGZQ4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:56:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:49937 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730298AbeGZQ4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:56:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <sebastian.siewior@linutronix.de>)
        id 1fiiLy-0001Re-20; Thu, 26 Jul 2018 17:38:58 +0200
Date:   Thu, 26 Jul 2018 17:38:58 +0200
From:   Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
To:     Pintu Kumar <pintu.ping@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PREEMPT_RT]: Using printk-rt-aware.patch in non-rt kernel
Message-ID: <20180726153857.abxfebvxjcp4jqgx@linutronix.de>
References: <CAOuPNLiK9tdHF6k+mNSqEQG92hA9oo4C+obhiwpjVOi_zaBZXw@mail.gmail.com>
 <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOuPNLhTBdzj8B_u9f7FLXHwaA5KYVwPoy87LaZNhzLxbuifaQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-18 20:19:15 [+0530], Pintu Kumar wrote:
> Hi All,
Hi,

> I have a question about PREEMPT_RT patch for 3.10 kernel.
> I am trying to port this rt patch: 0224-printk-rt-aware.patch.patch
> (see the patch below), in non-rt kernel.
> I could able to successfully apply this patch after replacing:
> migrate_enable/disable with preempt_enable/disable.
> Things were working fine so far.

Why? 

> Then, I noticed that "printk" from interrupt context is not appearing
> on console (minicom), if console shell is active.
> However, it appears on the dmesg output.
> 
> So, I am wondering, what could be the cause of this patch for this
> behavior in non-rt kernel?
> Is this the expected behavior, even on PREEMPT_RT kernel?

I *think* it is but there are hardly any prints from atomic context for
anyone to notice. And the next print from non-atomic context should
flush it out.

> Is there a way we can fix this issue on non-rt kernel?
I would guess that a wakeup to klogd would fix it.

> Please help us with your suggestions.
> 
> Thanks,
> Pintu

Sebastian
