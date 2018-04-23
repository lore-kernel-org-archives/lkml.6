Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932398AbeDWThm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 15:37:42 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57322 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932175AbeDWThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 15:37:41 -0400
Date: Mon, 23 Apr 2018 21:37:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Peng Hao <peng.hao2@zte.com.cn>
Cc: tglx@linutronix.de, pbonzini@redhat.com, mingo@redhat.com,
        x86@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: tsc: fix L2 guest always in tsc_early clocksource
Message-ID: <20180423193723.GO4082@hirez.programming.kicks-ass.net>
References: <1524532134-31408-1-git-send-email-peng.hao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524532134-31408-1-git-send-email-peng.hao2@zte.com.cn>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 09:08:54AM +0800, Peng Hao wrote:
> In L2 guest tsc_read_refs always return ULLONG_MAX, and that will
> call tsc_refine_calibration_work periodly. So L2 guest will read
> acpi timer port 0x608 periodly.
> The patch will let it out of "if(tsc_start == -1){}" infinite loop.

Help me out a little. What's an L2 guest?

And I'm assuming you don't have HPET and then end up wanting to use
PM-timer? Which is also busted and resturns crap results?

So if the whole TSC sync has no way of ever working; what is your patch
doing? How is the actual TSC calibrated?

Should you instead be using fast_calibrate() and passing in a known
value from the host? Thereby avoiding all this calibration nonsense
entirely.
