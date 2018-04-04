Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeDDQi7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 12:38:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:8394 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbeDDQi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 12:38:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,407,1517904000";
   d="scan'208";a="31519571"
Date: Wed, 4 Apr 2018 09:38:56 -0700
From: "Luck, Tony" <tony.luck@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Norbert Manthey <nmanthey@amazon.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: v4.16+ seeing many unaligned access in dequeue_task_fair() on
 IA64
Message-ID: <20180404163855.3obxjshmrlppzhdp@agluck-desk>
References: <20180402232448.fbop7k5xicblski5@agluck-desk>
 <20180403073706.GV4082@hirez.programming.kicks-ass.net>
 <20180403185829.yteixqsb5zazmav6@agluck-desk>
 <3908561D78D1C84285E8C5FCA982C28F7B3C2F5D@ORSMSX110.amr.corp.intel.com>
 <20180404072513.GF4082@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404072513.GF4082@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 09:25:13AM +0200, Peter Zijlstra wrote:
> Right, I remember being careful with that. Which again brings me to the
> RANDSTRUCT thing, which will mess that up.

No RANDSTRUCT config options set for my build.

> Does the below cure things? It makes absolutely no difference for my
> x86_64-defconfig build, but it puts more explicit alignment constraints
> on things.

Yes. That fixes it. No unaligned traps with this patch applied.

Tested-by: Tony Luck <tony.luck@intel.com>

Thanks

-Tony
