Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E91FC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8DF21767
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XD+/ldJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8DF21767
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHHQaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:30:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33152 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbeHHQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:30:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so1630558ywa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8pkWMBqJTcNIUxPxTYVwZRhv6bvcVMIt3FN+d6l1SwM=;
        b=XD+/ldJ5v/Qz4zRzGCSIb1e7dnf1X6SvbHUjTwhvg550uePa2Ek5kGmpZyMBCIjjRx
         EazgVacg6wZTHIYxMsvYbo9yTFxLvKwKeIQu/yhv5G9ycAWv/JF+ptGgUbVKCBktGsvH
         SeMiL23wm/+yg+k8/zi0ePPIMXec+tbA46oZx9AtqA0sRPc4BhZtEhiQb5gGfz+ZM/3g
         Jqjfy0KRTSVm9xVP0OyNUDUEDO/fRic8/px1ESoNwIkOvV9PDRBfhL/1c4p1B80lqz9C
         dNO51Q2kE/qag15Pa3oZu6Isf2UG1UbFuBUiDZDa0UQOOI8zrHU99NdV/w3/XV1BUn24
         K6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8pkWMBqJTcNIUxPxTYVwZRhv6bvcVMIt3FN+d6l1SwM=;
        b=Lf9r+ekV8BX18A92bsmY/fBdzap6aRQ+2JqI2283QFCHbewVtHoEKLgWBpJS45oH00
         vvkcvCQrK8SHgEDU7dYBAQJvndR1eEWysPCC+JHrWBIMu07x5lVDrwhxD69WTs2fBiEC
         YHkusSFXMq4d9gJb+v4z1A983ZaloQRK94Y8MMsjWblgmdZKOKrzpUTRxiGcbRnDgMbO
         BSzMtQ9ISgAXlpKIvS3ca6sF7XUf1IQPLHvBqTF3ZzwLxQV3hG6iyYyMmM+7HTjfAcvf
         LN+T2pFL48S+/Y+VI4e+mA9IRGxNEzTHGmh1e7bNIYH3T0jLWlmGaEcC09gsWMIhmQkg
         pwDQ==
X-Gm-Message-State: AOUpUlGUitVATJ5hZgZdMYCRS+QAeVTA7Mn+7WO2z+COUVK0xstzLMCu
        Esw0Biuuz1M4T+YUvK2M6j3wceijja8o303cwy71LQ==
X-Google-Smtp-Source: AA+uWPzuEJtkk98Cpx/FhfZfC57tH1JyCHLzX+T6ZPJ1f0sGAJ2T2Vl3j8b8ny7XvNDm9qgFf/9WsV8wzCTwvpoh2Qw=
X-Received: by 2002:a81:5c8b:: with SMTP id q133-v6mr1576987ywb.2.1533737454028;
 Wed, 08 Aug 2018 07:10:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 07:10:53 -0700 (PDT)
In-Reply-To: <20180808130041.GI24813@linux.vnet.ibm.com>
References: <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home> <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home> <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home> <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home> <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
 <CAJWu+oqPUuF4rFOQ8=G3+ZxXJxiiNRBYE8C=zZ93A8qA+muHEg@mail.gmail.com> <20180808130041.GI24813@linux.vnet.ibm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 8 Aug 2018 07:10:53 -0700
Message-ID: <CAJWu+oopkDMe9AtuiRqAubuPk_H=NSifTDpWLdgCTEvR6zZiMw@mail.gmail.com>
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

On Wed, Aug 8, 2018 at 6:00 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
> On Tue, Aug 07, 2018 at 08:53:54PM -0700, Joel Fernandes wrote:
>> On Tue, Aug 7, 2018 at 8:44 PM, Joel Fernandes <joelaf@google.com> wrote:
>> > Hi Steve,
>> >
>> > On Tue, Aug 7, 2018 at 7:28 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>> [...]
>> >>> @@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
>> >>>                       } while ((++it_func_ptr)->func);                \
>> >>>               }                                                       \
>> >>>                                                                       \
>> >>> -             if (rcuidle)                                            \
>> >>> -                     srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
>> >>> +             srcu_read_unlock_notrace(ss, idx);                      \
>> >>
>> >> Hmm, why do we have the two different srcu handles?
>> >
>> > Because if the memory operations happening on the normal SRCU handle
>> > (during srcu_read_lock) is interrupted by NMI, then the other handle
>> > (devoted to NMI) could be used instead and not bother the interrupted
>> > handle. Does that makes sense?
>> >
>> > When I talked to Paul few months ago about SRCU from NMI context, he
>> > mentioned the per-cpu memory operations during srcu_read_lock can be
>> > NMI interrupted, that's why we added that warning.
>>
>> So I looked more closely, __srcu_read_lock on 2 different handles may
>> still be doing a this_cpu_inc on the same location..
>> (sp->sda->srcu_lock_count). :-(
>>
>> Paul any ideas on how to solve this?
>
> You lost me on this one.  When you said "2 different handles", I assumed
> that you meant two different values of "sp", which would have two
> different addresses for &sp->sda->srcu_lock_count.  What am I missing?

Thanks a lot for the reply.
I thought "sda" is the same for different srcu_struct(s). May be it
was too late for me in the night, that's why I thought so? Which makes
no sense now that I think of it.

In that case based on what you're saying, the patch I sent to using
different srcu_struct for NMI is still good I guess...

>> It does start to seem like a show stopper :-(
>
> I suppose that an srcu_read_lock_nmi() and srcu_read_unlock_nmi() could
> be added, which would do atomic ops on sp->sda->srcu_lock_count.  Not sure
> whether this would be fast enough to be useful, but easy to provide:
>
> int __srcu_read_lock_nmi(struct srcu_struct *sp)  /* UNTESTED. */
> {
>         int idx;
>
>         idx = READ_ONCE(sp->srcu_idx) & 0x1;
>         atomic_inc(&sp->sda->srcu_lock_count[idx]);
>         smp_mb__after_atomic(); /* B */  /* Avoid leaking critical section. */
>         return idx;
> }
>
> void __srcu_read_unlock_nmi(struct srcu_struct *sp, int idx)
> {
>         smp_mb__before_atomic(); /* C */  /* Avoid leaking critical section. */
>         atomic_inc(&sp->sda->srcu_unlock_count[idx]);
> }
>
> With appropriate adjustments to also allow Tiny RCU to also work.
>
> Note that you have to use _nmi() everywhere, not just in NMI handlers.
> In fact, the NMI handlers are the one place you -don't- need to use
> _nmi(), strangely enough.
>
> Might be worth a try -- smp_mb__{before,after}_atomic() is a no-op on
> some architectures, for example.

Continuing Steve's question on regular interrupts, do we need to use
this atomic_inc API for regular interrupts as well?

Thanks!
