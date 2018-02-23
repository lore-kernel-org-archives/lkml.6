Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbeBWMPL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:15:11 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34050 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbeBWMPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:15:09 -0500
Date: Fri, 23 Feb 2018 13:14:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>, "Liang, Kan" <kan.liang@intel.com>,
        jolsa@redhat.com, bigeasy@linutronix.de,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Long standing kernel warning: perfevents: irq loop stuck!
Message-ID: <20180223121456.GZ25201@hirez.programming.kicks-ass.net>
References: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXvuYKn94WjJ9nSjzhk8DzYAvDmdgxsi6cc9CdBfkdTnw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 08:59:47PM -0800, Cong Wang wrote:
> Hello,
> 
> We keep seeing the following kernel warning from 3.10 kernel to 4.9
> kernel, it exists for a rather long time.
> 
> Google search shows there was a patch from Ingo:
> https://patchwork.kernel.org/patch/6308681/
> 
> but it doesn't look like ever merged into mainline...
> 
> I don't know how it is triggered. Please let me know if any other
> information I can provide.

What exact workload are you using to reproduce?

And I'm taking that the patch 'works' for you?

Given the HSD143 errata and its possible relevance, have you tried
changing the magic number to 32, does it then still fix things?

No real objection to the patch as such, it just needs a coherent comment
and a tested-by tag I think.
