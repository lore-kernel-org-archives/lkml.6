Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED80C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AA020846
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 07:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AA020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbeGKH0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 03:26:05 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38978 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbeGKH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 03:26:05 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fd9Sx-0006c1-N2; Wed, 11 Jul 2018 09:23:11 +0200
Date:   Wed, 11 Jul 2018 09:23:11 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Why the mce reverts in 4.16-rt?
Message-ID: <20180711072311.cprdgb2xqwag2iem@linutronix.de>
References: <20180710205624.19ff9ef0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180710205624.19ff9ef0@gandalf.local.home>
User-Agent: NeoMutt/20180622
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-10 20:56:24 [-0400], Steven Rostedt wrote:
> Hi Sebastian,
Hi Steven,

> I'm looking at backporting patches from 4.16-rt and noticed that you
> have:
> 
> Revert "x86: Convert mce timer to hrtimer"
> Revert "x86/mce: use swait queue for mce wakeups"
> 
> With no explanation to why they were reverted. When did things change?
> Should this be 4.14-rt material?

from the announce email:
|    Changes since v4.16.8-rt2:
|    
|      - Drop two MCE related patches. They are no longer required since the
|        timer wheel rework.

The timer wheel rework made it possible to have a raw_spin_lock_t in the
timer_list timer. The problem with MCE was that it enqueued a timer from
hardirq context which is now possible. So the patches are no longer
required. This revert does not fix a bug in v4.14 nor does it break
anything.

> Thanks,
> 
> -- Steve

Sebastian
