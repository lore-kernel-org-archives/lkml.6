Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D940DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B54812084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfAKVla (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:41:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfAKVla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:41:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9A8ADA8C1A;
        Fri, 11 Jan 2019 21:41:29 +0000 (UTC)
Received: from treble (ovpn-122-231.rdu2.redhat.com [10.10.122.231])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AC4160851;
        Fri, 11 Jan 2019 21:41:24 +0000 (UTC)
Date:   Fri, 11 Jan 2019 15:41:22 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jason Baron <jbaron@akamai.com>, Jiri Kosina <jkosina@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Borislav Petkov <bp@alien8.de>,
        Julia Cartwright <julia@ni.com>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Edward Cree <ecree@solarflare.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3 0/6] Static calls
Message-ID: <20190111214122.dzye2mg32aksuyo3@treble>
References: <CALCETrWBwTVHWXahVXMMBL4QA1f+YdKgv1XANXPsk86FjFFH2Q@mail.gmail.com>
 <B374297A-8298-4CED-8EC0-6A39BDBA5F05@vmware.com>
 <20190111151525.tf7lhuycyyvjjxez@treble>
 <CAHk-=wjJm8DpCsw=Wno01q4VFqUeiLKE8QmbAtUJurYhn3jRqA@mail.gmail.com>
 <20190111200420.qtyffayxceysoarf@treble>
 <CAHk-=whLu9kG3dqgXUkCrNrTp0NVtdOOWxvonXTfhtq-krXo+Q@mail.gmail.com>
 <20190111203135.5clurevf34bkiy3o@treble>
 <CAHk-=whKabsg3N4uHHFkHXXf_mi6=T2OvkC-OUNG8Lt-bsCjFg@mail.gmail.com>
 <20190111212210.veyfn5vvjswcwacm@treble>
 <6B0B7437-0577-4FE7-A0BC-EFB5D94B8C21@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6B0B7437-0577-4FE7-A0BC-EFB5D94B8C21@vmware.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 11 Jan 2019 21:41:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 09:36:59PM +0000, Nadav Amit wrote:
> > On Jan 11, 2019, at 1:22 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > On Fri, Jan 11, 2019 at 12:46:39PM -0800, Linus Torvalds wrote:
> >> On Fri, Jan 11, 2019 at 12:31 PM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >>> I was referring to the fact that a single static call key update will
> >>> usually result in patching multiple call sites.  But you're right, it's
> >>> only 1-2 trampolines per text_poke_bp() invocation.  Though eventually
> >>> we may want to batch all the writes like what Daniel has proposed for
> >>> jump labels, to reduce IPIs.
> >> 
> >> Yeah, my suggestion doesn't allow for batching, since it would
> >> basically generate one trampoline for every rewritten instruction.
> > 
> > As Andy said, I think batching would still be possible, it's just that
> > we'd have to create multiple trampolines at a time.
> > 
> > Or... we could do a hybrid approach: create a single custom trampoline
> > which has the call destination patched in, but put the return address in
> > %rax -- which is always clobbered, even for callee-saved PV ops.  Like:
> > 
> > trampoline:
> > 	push %rax
> > 	call patched-dest
> > 
> > That way the batching could be done with a single trampoline
> > (particularly if using rcu-sched to avoid the sti hack).
> 
> I don’t see RCU-sched solves the problem if you don’t disable preemption. On
> a fully preemptable kernel, you can get preempted between the push and the
> call (jmp) or before the push. RCU-sched can then finish, and the preempted
> task may later jump to a wrong patched-dest.

Argh, I misspoke about RCU-sched.  Words are hard.

I meant synchronize_rcu_tasks(), which is a completely different animal.
My understanding is that it waits until all runnable tasks (including
preempted tasks) have gotten a chance to run.

-- 
Josh
