Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752649AbeCWRud (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 13:50:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:41960 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeCWRub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 13:50:31 -0400
Date: Fri, 23 Mar 2018 18:50:13 +0100
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "nab@linux-iscsi.org" <nab@linux-iscsi.org>,
        "daniel@bristot.me" <daniel@bristot.me>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "acme@kernel.org" <acme@kernel.org>,
        "williams@redhat.com" <williams@redhat.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "lclaudio@redhat.com" <lclaudio@redhat.com>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 2/2] target: remove spin_lock_assert() in
 __target_(attach|detach)_tg_pt_gp()
Message-ID: <20180323175013.6uucllg5ogyzfovt@linutronix.de>
References: <20180321153854.GB24312@kernel.org>
 <CA+55aFwKN_JijmCt=0S4jF8KzGPmoKNbuYF59va7U4ziJLLryA@mail.gmail.com>
 <20180322093745.GC4229@kernel.org>
 <20180323155513.dwbgvblenlji33as@linutronix.de>
 <1521822325.2535.5.camel@wdc.com>
 <CA+55aFxVkuntSektVmwXktzvfEezdDTAM_zj4DJdp3qJxWf8aA@mail.gmail.com>
 <20180323171736.bcyi2oiolge4l6hl@linutronix.de>
 <20180323171959.7ac6klrqg4fdk3ey@linutronix.de>
 <1521827085.2535.12.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521827085.2535.12.camel@wdc.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-23 17:44:46 [+0000], Bart Van Assche wrote:
> On Fri, 2018-03-23 at 18:19 +0100, bigeasy@linutronix.de wrote:
> > __target_attach_tg_pt_gp() and __target_detach_tg_pt_gp() check if the caller
> > holds lun_tg_pt_gp_lock(). Both functions are static, the callers are
> > acquiring the lock before the invocation of the function so the check
> > looks superfluous.
> > Remove it.
> 
> Does this check cause trouble to anyone or to a specific kernel configuration?
Those two do not.

> In other words, do we really need to remove these checks? I think that these
> checks are useful as documentation to people who read the SCSI target code.
> The target code is already hard to follow so I think any documentation,
> especially documentation in the form of code that is checked at runtime, is
> welcome.

so if I remove those two and add a kernel doc comment instead, saying
that the caller needs to ensure that "lun->lun_tg_pt_gp_lock" is held
then we would remove the obvious runtime check and add a piece of
documentation. Would that work?

> Thanks,
> 
> Bart.

Sebastian
