Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58787C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F20D221AA9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 22:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKN/asCo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20D221AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbeHIAhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:37:13 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42129 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeHIAhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:37:13 -0400
Received: by mail-yw1-f65.google.com with SMTP id y203-v6so2777566ywd.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 15:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1Y08YcgCU1CkiCivfXt9qdM6+mAALhysPS/llQsiqe4=;
        b=ZKN/asCobZnhvhQLSFC5HbnqAq6cEL/SnG3stAxo/D0m7q6yH8G+zJ75OfiTjF6zm2
         LvpfAYp/am1Aw2ErqLQ5HM9yYNx9WUwm9iZtbSZCrf7+T0JMuUl7qdOTn4NQXf8LNvRk
         QotH2UziaHPRu2Rza8ISxpEkb95m3BER0fkS00hQmIu+7EvytSGd53Tcl0vhVGzAHoUx
         pCCJxGV9HGZdqkyaSF58Zc5XyMAaSpzoEgdGJnOfowOT5mf79a/1cGLp930hmCmqxdke
         J2fssHuZcA5a6vF8FDVVdehnE5Wy8boKiwKlhuFyD5sA0zf0ClyYveRJP8bu0nBpvxwu
         Nc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1Y08YcgCU1CkiCivfXt9qdM6+mAALhysPS/llQsiqe4=;
        b=cTiTSW/OygII4VIoUk8iGNOVLHcYwRmM2Htn2IL3M7YvWEBdzYuIVLuur78GK3pYJp
         VuOkql2Cz1rThECMxcW4+97bVqdfocsdqdBGeh6UfiV7XFKc8xglUmkSl+2VysrDSHG5
         BuTOQHDFTNUjgC75nJHDJzbl4EtDcbI9M+hrS4uEb18sukt1RzKisDyILD5eiva8a/RG
         TrxOh1C39LYbw7D3kEBBljP8zmQbTVyuNQ7Sm8o8z14UyISgMi8IllM+3Jt2+XlVp3Y5
         OpTpYLgjyZOs24EzTQ20M3zIZnlJcfxm4NzPOBFlfux42wcLYRWPFl8J/HrUGM/E3vBC
         JQZQ==
X-Gm-Message-State: AOUpUlHIZSxm+TpkJeZLIc4Sy1J3T9OJ9qi/282irYRhVILNAJgyXbEx
        YwXC+QZpXAz0tjcxw/LnNsGwc3pgg/eU9mTdg2sGM6WKQCU=
X-Google-Smtp-Source: AA+uWPwAVG1gDYt8nNWDjPmekKtxZlq3lngt7PcwHm339xd5dCQWHGnHJYzyXO/mBU8ruqmQWf1O8NrFMv4GSEZk7ng=
X-Received: by 2002:a0d:c9c2:: with SMTP id l185-v6mr2564156ywd.164.1533766532376;
 Wed, 08 Aug 2018 15:15:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 15:15:31 -0700 (PDT)
In-Reply-To: <20180808201852.GZ24813@linux.vnet.ibm.com>
References: <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home> <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home> <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com>
 <20180808130041.GI24813@linux.vnet.ibm.com> <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com>
 <20180808144922.GN24813@linux.vnet.ibm.com> <CAJWu+orf_LipWwo30OX+gZwHS1v5QWub4BHgrA6zQ7d4K+i6ew@mail.gmail.com>
 <20180808201852.GZ24813@linux.vnet.ibm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 8 Aug 2018 15:15:31 -0700
Message-ID: <CAJWu+op0H9vry70YXx6x3e37Sxsgb45go7B9MmE-y2O5wdLOYg@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 1:18 PM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
[...]
>> >> >> It does start to seem like a show stopper :-(
>> >> >
>> >> > I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
>> >> > be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
>> >> > whether this would be fast enough to be useful, but easy to provide:
>> >> >
>> >> > int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
>> >> > {
>> >> >         int idx;
>> >> >
>> >> >         idx = READ_ONCE(sp->srcu_idx) & 0x1;
>> >> >         atomic_inc(&sp->sda->srcu_lock_count[idx]);
>> >> >         smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
>> >> >         return idx;
>> >> > }
>> >> >
>> >> > void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
>> >> > {
>> >> >         smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
>> >> >         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
>> >> > }
>> >> >
>> >> > With appropriate adjustments to also allow Tiny RCU to also work.
>> >> >
>> >> > Note that you have to use _nmi() everywhere, not just in NMI handlers.
>> >> > In fact, the NMI handlers are the one place you -don't- need to use
>> >> > _nmi(), strangely enough.
>> >> >
>> >> > Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
>> >> > some architectures, for example.
>> >>
>> >> Continuing Steve's question on regular interrupts, do we need to use
>> >> this atomic_inc API for regular interrupts as well? So I guess
>> >
>> > If NMIs use one srcu_struct and non-NMI uses another, the current
>> > srcu_read_lock() and srcu_read_unlock() will work just fine.  If any given
>> > srcu_struct needs both NMI and non-NMI readers, then we really do need
>> > __srcu_read_lock_nmi() and __srcu_read_unlock_nmi() for that srcu_struct.
>>
>> Yes, I believe as long as in_nmi() works reliably, we can use the
>> right srcu_struct (NMI vs non-NMI) and it would be fine.
>>
>> Going through this thread, it sounds though that this_cpu_inc may not
>> be reliable on all architectures even for non-NMI interrupts and
>> local_inc may be the way to go.
>
> My understanding is that this_cpu_inc() is defined to handle interrupts,
> so any architecture on which it is unreliable needs to fix its bug.  ;-)

Yes that's my understanding as well.

Then may be I'm missing something about yours/Steve's conversations in
the morning, about why we need bother with the local_inc then. So the
current SRCU code with the separate NMI handle should work fine (for
future merge windows) as long as we're using a separate srcu_struct
for NMI. :-)

>
>> For next merge window (not this one), lets do that then? Paul, if you
>> could provide me an SRCU API that uses local_inc, then I believe that
>> coupled with this patch should be all that's needed:
>> https://lore.kernel.org/patchwork/patch/972657/
>>
>> Steve did express concern though if in_nmi() works reliably (i.e.
>> tracepoint doesn't fire from "thunk" code before in_nmi() is
>> available). Any thoughts on that Steve?
>
> Agreed, not the upcoming merge window.  But we do need to work out
> exactly what is the right way to do this.

Agreed, thanks!

 - Joel
