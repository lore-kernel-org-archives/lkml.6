Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752493AbeBAPkz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 10:40:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752318AbeBAPky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 10:40:54 -0500
Date: Thu, 1 Feb 2018 09:40:52 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, mingo@kernel.org,
        hpa@zytor.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Wieczorkiewicz, Pawel" <wipawel@amazon.de>
Subject: Re: [tip:x86/pti] x86/speculation: Use Indirect Branch Prediction
 Barrier in context switch
Message-ID: <20180201154052.qomk5rjdipufaxa7@treble>
References: <1517263487-3708-1-git-send-email-dwmw@amazon.co.uk>
 <tip-18bf3c3ea8ece8f03b6fc58508f2dfd23c7711c7@git.kernel.org>
 <20180131070300.GA28206@light.dominikbrodowski.net>
 <1517473913.18619.281.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517473913.18619.281.camel@infradead.org>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 01, 2018 at 08:31:53AM +0000, David Woodhouse wrote:
> On Wed, 2018-01-31 at 08:03 +0100, Dominik Brodowski wrote:
> > Whether a process needs protection by IBPB on context switches is a
> > different question to whether a process should be allowed to be dumped,
> > though the former may be a superset of the latter. Enable IBPB on all
> > context switches to a different userspace process, until we have a clear
> > mitigation strategy for userspace against Spectre-v2 designed and
> > implemented.
> >
> > ...
> >                 if (tsk && tsk->mm &&
> > -                   tsk->mm->context.ctx_id != last_ctx_id &&
> > -                   get_dumpable(tsk->mm) != SUID_DUMP_USER)
> > +                   tsk->mm->context.ctx_id != last_ctx_id)
> >                         indirect_branch_prediction_barrier();
> 
> 
> I understand your argument and I sympathise.
> 
> But that's going to hurt a *lot*, and we don't even have a viable
> proof-of-concept for a user←→user Spectre v2 attack, do we? It's only
> theoretical?
> 
> Show a working PoC and it makes the argument somewhat more
> convincing...

Fair point.  From what I can gather, user space ASLR seems to be the
only layer of protection before a POC would be feasible.  So, unless I'm
mistaken, which is very possible, it seems to be a question of how much
we trust ASLR.

-- 
Josh
