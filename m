Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeBZUjy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 15:39:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:37494 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752212AbeBZUjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 15:39:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,397,1515484800";
   d="scan'208";a="178244350"
Date: Mon, 26 Feb 2018 12:39:37 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
        "Liang, Kan" <kan.liang@intel.com>, jolsa@redhat.com,
        bigeasy@linutronix.de, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
Message-ID: <20180226203937.GA21543@tassilo.jf.intel.com>
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
 <20180223121456.GZ25201@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223121456.GZ25201@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Given the HSD143 errata and its possible relevance, have you tried
> changing the magic number to 32, does it then still fix things?
> 
> No real objection to the patch as such, it just needs a coherent comment
> and a tested-by tag I think.

128 min period will affect a lot of valid use cases with slower ticking
events.  I often use smaller periods there.

It would be better to debug this properly.

Or at a minimum only do the limitation for the events that tick really
fast (like cycles, uops retired etc.)

-Andi
