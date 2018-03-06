Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752795AbeCFJA4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:00:56 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:53296 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbeCFJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:00:54 -0500
X-Google-Smtp-Source: AG47ELvQ4gwSis4ra1DIi2MChg5BwYyyCVD1Qghjto2B/tyIXEIE6dYzF177A8R6woBWdeFoZ2Yx0Q==
Date: Tue, 6 Mar 2018 10:00:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>,
        Benjamin LaHaise <bcrl@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-kernel@vger.kernel.org
Subject: Re: Simplifying our RCU models
Message-ID: <20180306090050.zslv7g37dh6a5kpz@gmail.com>
References: <CA+55aFzQPQw2UqQ2EEGN1Xe7=qDs-2VTvHVi7SSqGNwqNRg0cQ@mail.gmail.com>
 <CAOS58YPzLeiZnwEeN31wWMZhki0t9+3ozdRNv9DgxWKY7OKmGA@mail.gmail.com>
 <CA+55aFx48U4W5tUgqW9ioZOHibPhQoDCUDWF_d-7yNCbqFQ7zg@mail.gmail.com>
 <20180305001600.GO3918@linux.vnet.ibm.com>
 <CA+55aFyOi1XnSqHtg=VfcUiBL+egNL==NRX1Zaeihe8W5OJVgw@mail.gmail.com>
 <20180305030949.GP3918@linux.vnet.ibm.com>
 <20180305082441.4hao2z4dqn2n5on6@gmail.com>
 <87po4izj67.fsf_-_@xmission.com>
 <20180305161446.GQ3918@linux.vnet.ibm.com>
 <20180306084738.tcs4ggbby77phlbh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306084738.tcs4ggbby77phlbh@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

>    I.e. the new RCU namespace would be something like:
> 
>      call_rcu                     => rcu_call_rcu

typo: rcu_call().

>      synchronize_rcu              => rcu_wait_

typo: rcu_wait().

Here's the updated table:

     # RCU APIs:

     rcu_read_lock                => rcu_read_lock        # unchanged
     rcu_read_unlock              => rcu_read_unlock      # unchanged

     call_rcu                     => rcu_call
     call_rcu_bh                  => rcu_call_bh
     call_rcu_sched               => rcu_call_sched

     synchronize_rcu              => rcu_wait
     synchronize_rcu_bh           => rcu_wait_bh
     synchronize_rcu_bh_expedited => rcu_wait_expedited_bh
     synchronize_rcu_expedited    => rcu_wait_expedited
     synchronize_rcu_mult         => rcu_wait_mult
     synchronize_rcu_sched        => rcu_wait_sched
     synchronize_rcu_tasks        => rcu_wait_tasks

     get_state_synchronize_rcu    => rcu_get_state
     cond_synchronize_rcu         => rcu_wait_state


     # SRCU APIs:

     srcu_read_lock               => srcu_read_lock       # unchanged
     srcu_read_unlock             => srcu_read_unlock     # unchanged

     synchronize_srcu             => srcu_wait
     synchronize_srcu_expedited   => srcu_wait_expedited


Thanks,

	Ingo
