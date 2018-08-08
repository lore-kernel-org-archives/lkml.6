Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B427C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4ACC21798
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J30EaJxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ACC21798
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeHHVp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:45:29 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35332 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:45:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id s68-v6so2417366ywg.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MOPlefY8BPTdz7pSeX12AWm3e7jwz7gDDdSoI4SDW8I=;
        b=J30EaJxFj71gi+Btey1tf14eKqRYroRXsJj+FxMZ+jEsoit+PFiIWI2k4hE3G7jZRm
         fm0w3aqZlcbMrCfeUm9jwymUuMEyvuza+/H8vVsc3JsWv+tm4T9Ku4d/VtA7wh09Lbdw
         tnuje1hdIK99G2U9K+RHXSU8nIgcs0OmbY2J5Uz//PDHhmLtczLCrbGGyasxg6pVm93O
         lO7Zi6PJjEoXNdf8FKlNf+8kkE4gQPl4jnaKjC1OgSSoo8wBIrmmPsmX/iwb9n+iiJYk
         feqpvOvqm8C0DJduIcfIYtIp2qjC3DojfzIR5WLjFRyxZZ/4swdp6v/XmCVdPRLnqLEW
         pH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MOPlefY8BPTdz7pSeX12AWm3e7jwz7gDDdSoI4SDW8I=;
        b=Bqh23MTy58/V+Bk3q5yL5tgrTJ7/wK4L8X1uaDhnwdzvKR6hADZokrI8Lyz1Ehfd0E
         RjV+LtBfBAF1Y+YWBxAbrk9A8fGx24u6WgWzV8fPaHJaelxKUj296thuh09z55ApMbsr
         Fd/AaxjWCcgG9hIrLnwSZtiZgFxCnGLd0BY8TQQ7i1i6zFazlf6d9EoaYCyYzD77mzz8
         T4vhP7qNEto+w4sF/seeSXSVoYIBgJM61oQfLFmR0aRIH9uqdg6k8JYi3SrIKZ66AKBI
         pa9Emabdah9ehXYRYblBtdvCPwdt2+/Y57PzV+TQMs7NNWYth2bQT1hkn+jVTVX0p28n
         gA5g==
X-Gm-Message-State: AOUpUlERcPC0Si55D/1ttzuF/z414ngcVlx4P1t1tsZdU3N/w9+pP9wx
        ZLoRavoPoCDXEQlvYtFtoHHDczmRpVya1bqC53vOILHw+T0=
X-Google-Smtp-Source: AA+uWPzXcW449dMjfCEpES2I0EixQPCufWnhvcizpsl+IScx+O423xR/yC0DQWHzrFAqlkD33virjLA/FQbkXgUOtwU=
X-Received: by 2002:a0d:d981:: with SMTP id b123-v6mr2184991ywe.64.1533756261094;
 Wed, 08 Aug 2018 12:24:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 12:24:20 -0700 (PDT)
In-Reply-To: <20180808144922.GN24813@linux.vnet.ibm.com>
References: <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home> <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home> <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home> <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com> <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com>
 <20180808144922.GN24813@linux.vnet.ibm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 8 Aug 2018 12:24:20 -0700
Message-ID: <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 7:49 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
[...]
>
>> In that case based on what you're saying, the patch I sent to using
>> different srcu_struct for NMI is still good I guess...
>
> As long as you wait for both SRCU grace periods.  Hmmm...  Maybe that means
> that there is still a use for synchronize_rcu_mult():
>
>         void call_srcu_nmi(struct rcu_head *rhp, rcu_callback_t func)
>         {
>                 call_srcu(&trace_srcu_struct_nmi, rhp, func);
>         }
>
>         void call_srcu_nonmi(struct rcu_head *rhp, rcu_callback_t func)
>         {
>                 call_srcu(&trace_srcu_struct_nonmi, rhp, func);
>         }
>
>         ...
>
>         /* Wait concurrently on the two grace periods. */
>         synchronize_rcu_mult(call_srcu_nmi, call_srcu_nonmi);
>
> On the other hand, I bet that doing this is just fine in your use case:
>
>         synchronize_srcu(&trace_srcu_struct_nmi);
>         synchronize_srcu(&trace_srcu_struct_nonmi);
>
> But please note that synchronize_rcu_mult() is no more in my -rcu tree,
> so if you do want it please let me know (and please let me know why it
> is important).

I did the chaining thing (one callback calling another), that should
work too right? I believe that is needed so that the tracepoint
callbacks are freed at one point and only when both NMI and non-NMI
read sections have completed.

>> >> It does start to seem like a show stopper :-(
>> >
>> > I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
>> > be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
>> > whether this would be fast enough to be useful, but easy to provide:
>> >
>> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
>> > {
>> >         int idx;
>> >
>> >         idx = READ_ONCE(sp->srcu_idx) & 0x1;
>> >         atomic_inc(&sp->sda->srcu_lock_count[idx]);
>> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
>> >         return idx;
>> > }
>> >
>> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
>> > {
>> >         smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
>> >         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
>> > }
>> >
>> > With appropriate adjustments to also allow Tiny RCU to also work.
>> >
>> > Note that you have to use _nmi() everywhere, not just in NMI handlers.
>> > In fact, the NMI handlers are the one place you -don't- need to use
>> > _nmi(), strangely enough.
>> >
>> > Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
>> > some architectures, for example.
>>
>> Continuing Steve's question on regular interrupts, do we need to use
>> this atomic_inc API for regular interrupts as well? So I guess
>
> If NMIs use one srcu_struct and non-NMI uses another, the current
> srcu_read_lock() and srcu_read_unlock() will work just fine.  If any given
> srcu_struct needs both NMI and non-NMI readers, then we really do need
> __srcu_read_lock_nmi() and __srcu_read_unlock_nmi() for that srcu_struct.

Yes, I believe as long as in_nmi() works reliably, we can use the
right srcu_struct (NMI vs non-NMI) and it would be fine.

Going through this thread, it sounds though that this_cpu_inc may not
be reliable on all architectures even for non-NMI interrupts and
local_inc may be the way to go.

For next merge window (not this one), lets do that then? Paul, if you
could provide me an SRCU API that uses local_inc, then I believe that
coupled with this patch should be all that's needed:
https://lore.kernel.org/patchwork/patch/972657/

Steve did express concern though if in_nmi() works reliably (i.e.
tracepoint doesn't fire from "thunk" code before in_nmi() is
available). Any thoughts on that Steve?

thanks!

- Joel
