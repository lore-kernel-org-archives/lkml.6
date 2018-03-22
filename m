Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753648AbeCVJiE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 05:38:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753573AbeCVJh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 05:37:59 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1E620838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Thu, 22 Mar 2018 06:37:45 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Daniel Bristot de Oliveira <daniel@bristot.me>,
        Luis Claudio =?iso-8859-1?Q?R=2E_Gon=E7alves?=
        <lclaudio@redhat.com>,
        Clark Williams <williams@redhat.com>,
        target-devel <target-devel@vger.kernel.org>
Subject: Re: [PATCH] target: Use WARNON_NON_RT(!irqs_disabled())
Message-ID: <20180322093745.GC4229@kernel.org>
References: <20180321153854.GB24312@kernel.org>
 <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 21, 2018 at 11:43:58AM -0700, Linus Torvalds escreveu:
> [ Adding PeterZ to participants due to query about lockdep_assert() ]
> 
> On Wed, Mar 21, 2018 at 8:38 AM, Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> >         assert_spin_locked(&cmd->t_state_lock);
> > -       WARN_ON_ONCE(!irqs_disabled());
> > +       WARN_ON_ONCE_NONRT(!irqs_disabled());
> 
> Ugh.
> 
> Can't we just replace both of those with a lockdep annotation?

Huh, even better, when that feature gets finished (tglx said it was
being developed, not there yet tho) it'll allow further reduction of the
PREEMPT_RT_FULL patchkit.

- Arnaldo
