Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752934AbeCMSIQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:08:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751549AbeCMSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:08:12 -0400
Date: Tue, 13 Mar 2018 19:08:06 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, linux-sparse@vger.kernel.org,
        Christopher Li <sparse@chrisli.org>,
        kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        LKML <linux-kernel@vger.kernel.org>, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Message-ID: <20180313180806.GO4043@hirez.programming.kicks-ass.net>
References: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
 <CACT4Y+Yscqe6M1jXSkcuvw+5-27YzZn4AXwKzU1oJCNhUrj1Ng@mail.gmail.com>
 <CACT4Y+ayA+maaG3uddxpy3w24Jyppsxmyu5R_rEsvm3JjtZkRQ@mail.gmail.com>
 <20180313104652.GK4043@hirez.programming.kicks-ass.net>
 <CACT4Y+b+ECV+6hky_cq1tg2BbYbsv1c_xGYrgzjiLfSbx21rVA@mail.gmail.com>
 <20180313180016.5axdobx6a624snpp@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313180016.5axdobx6a624snpp@ltop.local>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 07:00:17PM +0100, Luc Van Oostenryck wrote:
> The issue here is that sparse has a whole class of warnings that are
> given very early (here at expansion of constant expressions), before
> eliminating code from branches that are never taken (which, surprise,
> need itself to have constant expressions already expanded).
> 
> It's often annoying like the case here.
> OTOH, I don't think it's always a bad thing. Sometimes we want to
> have warnings even from code we know will not be executed (in this
> config but maybe it will in another one).

Is that really a valid concern with all the automated randconfig
building going on today?
