Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA48C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25836216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 03:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mAQ21sIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25836216F3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeHHGCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 02:02:01 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33029 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeHHGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 02:02:01 -0400
Received: by mail-yw1-f67.google.com with SMTP id c135-v6so599484ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 20:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1miEK9VyNsyiEOPKVtVBALQKqmJNRgdXUjAWRd8FRQY=;
        b=mAQ21sIf7snvvMhdJw3AY37NLxhHxHr9UeeVzyGG0GUhBNuSOD8sQGqoo3Aqg5GTre
         krm4+36Nf+sWmpz5xcjrXSA5YyKRzs0SrwsEn4dIIRV0yZC9wa7mxIqwDnQl/IVfET+n
         sgRpikAqRCFlXGSfosXJMx32xGqmaKZQ/s12iec2krd2yKQSfjPT5SF8WB4y58f+P17Z
         94w9JL+mH3qcvYvEibayh+1Mudd0JLHfPZ8M6kuq4tM+VnAOm1/knhyixBMqHjx0o+GQ
         pM54SBNFD0wM9K8D2odZMADOXdGJmxtKkgbfq+aP1tzmQQo0boJoF95wlHhLKrN+/ZjD
         oeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1miEK9VyNsyiEOPKVtVBALQKqmJNRgdXUjAWRd8FRQY=;
        b=L1Yzg0z5q/j20tR2ek5EPOWhl7+EL3/Vqodu7FJ0QjvhTmV27pDk9jg0rjGz1+/Z7U
         wjW/jCgotQZ98Fi+4CJlVklEt9lzkL/TlnF0jd1uSYpvgynRVWKBOa6jgyHs7DLTl1j7
         U5rhHiX3r+tAx9OjVYJ0NQJlha/rqCur9MngvT38jaW7uaQjGco0CFEsSdIQt6p8506U
         aepl/kk2lPF1NDRhRPfMUMt4DzzDvhDPo9Kj3VJqcBE26+lNR9XHx2LhkgiCS33fIsGl
         pvPPXC3o2QeQgicR1O5HI/+Rrig2hvi7ApLiLZadBLRe0jLEiXso1uh8UbZJiu2YnQCX
         MdkQ==
X-Gm-Message-State: AOUpUlHOhT6rtdZQA14XdRvVVFWwJUawnIqK6pXJC9Io4YZXMtmYX4vt
        Z9KgUxce6N0LcroE3N4EELDtvnLDHKZjNuxJv+icPnqn
X-Google-Smtp-Source: AA+uWPwDrHl+0U6fnKd+CYtJQOUjRny5HgP+N7Hl667CmtIuav/QuhD/Nw39esSYlZ4jeGpA3BoGVsRwedlBacl5n6Y=
X-Received: by 2002:a25:aa2f:: with SMTP id s44-v6mr547843ybi.298.1533699865969;
 Tue, 07 Aug 2018 20:44:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 20:44:25 -0700 (PDT)
In-Reply-To: <20180807222856.3ede96e7@vmware.local.home>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180730222423.196630-4-joel@joelfernandes.org> <20180806155058.5ee875f4@gandalf.local.home>
 <CAJWu+oqvpev_EZC38_mi+UNRCxS8GqNVagHyGM4dUjruzKgwgQ@mail.gmail.com>
 <20180806214300.13e63523@gandalf.local.home> <CAJWu+oqZi2W9OYAn2xu17fdrBitQs4Gti4LxWmtx5B-EYtNMmA@mail.gmail.com>
 <20180807094954.5137972d@gandalf.local.home> <446AE5F2-39E0-46B6-8E0B-207E003DBF20@google.com>
 <20180807103410.4fe203cb@gandalf.local.home> <C1CB990F-8232-4168-89A8-E8C13B660B0B@google.com>
 <20180807110906.3a1b0ac4@gandalf.local.home> <6B9E5DC9-0859-41B4-9B72-A7D85E9EA2AD@google.com>
 <20180807194515.4e549c1a@gandalf.local.home> <6D0A3FD6-2190-4CC0-A3C0-7B3759E73243@google.com>
 <20180807204820.50b83c6d@vmware.local.home> <CAJWu+oqBOEJicepLaUG=JpmtDTgxjRdMyJAgOEUkdk4NzX0esw@mail.gmail.com>
 <20180807215522.04114097@vmware.local.home> <CAJWu+opjqKgZj30PYpyvip=EtP8CuqaEy65++nuvj37QMT6GCw@mail.gmail.com>
 <20180807222856.3ede96e7@vmware.local.home>
From:   Joel Fernandes <joelaf@google.com>
Date:   Tue, 7 Aug 2018 20:44:25 -0700
Message-ID: <CAJWu+oqcM_-rtuUe7hhMHyZ2UKZ5J4rBZO7UoHxxd2DAs=aHdA@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Tue, Aug 7, 2018 at 7:28 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Tue, 7 Aug 2018 19:13:32 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>> >
>> >> From 6986af946ceb04fc9ddc6d5b45fc559b6807e465 Mon Sep 17 00:00:00 2001
>> >> From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
>> >> Date: Sun, 5 Aug 2018 20:17:41 -0700
>> >> Subject: [PATCH] tracepoint: Run tracepoints even after CPU is offline
>> >>
>> >> Commit f37755490fe9 ("tracepoints: Do not trace when cpu is offline")
>> >> causes a problem for lockdep using tracepoint code. Once a CPU is
>> >> offline, tracepoints donot get called, however this causes a big problem
>> >> for lockdep probes that need to run so that IRQ annotations are marked
>> >> correctly.
>> >>
>> >> A race is possible where while the CPU is going offline, an interrupt
>> >> can come in and then a lockdep assert causes an annotation warning:
>> >>
>> >> [  106.551354] IRQs not enabled as expected
>> >> [  106.551785] WARNING: CPU: 1 PID: 0 at kernel/time/tick-sched.c:982
>> >>                                          tick_nohz_idle_enter+0x99/0xb0
>> >> [  106.552964] Modules linked in:
>> >> [  106.553299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W
>> >>
>> >> We need tracepoints to run as late as possible. This commit fixes the
>> >> issue by removing the cpu_online check in tracepoint code that was
>> >> introduced in the mentioned commit, however we now switch to using SRCU
>> >> for all tracepoints and special handle calling tracepoints from NMI so
>> >> that we don't run into issues that result from using sched-RCU when the
>> >> CPUs are marked to be offline.
>> >>
>> >> Fixes: c3bc8fd637a9 ("tracing: Centralize preemptirq tracepoints and
>> >>                       unify their usage")
>> >> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
>> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>> >
>> >
>> > The above change log doesn't look like it matches the NMI patch.
>> >
>> > Can you resend with just the NMI changes? I already handled the cpu
>> > offline ones.
>>
>> Ok, sent with "cpu offline" changes dropped, here it is:
>> https://lore.kernel.org/patchwork/patch/972657/
>>
>> If you could add your Reported-by to it, that would be great as well.
>>
>> >
>> > But I may still have concerns with this patch.
>>
>> Ok let me know what you think.
>>
>
> Not sure you saw this part of my reply:

I missed the part on the srcu handles, sorry.

>
>> @@ -171,8 +174,7 @@ extern void syscall_unregfunc(void);
>>                       } while ((++it_func_ptr)->func);                \
>>               }                                                       \
>>                                                                       \
>> -             if (rcuidle)                                            \
>> -                     srcu_read_unlock_notrace(&tracepoint_srcu, idx);\
>> +             srcu_read_unlock_notrace(ss, idx);                      \
>
> Hmm, why do we have the two different srcu handles?

Because if the memory operations happening on the normal SRCU handle
(during srcu_read_lock) is interrupted by NMI, then the other handle
(devoted to NMI) could be used instead and not bother the interrupted
handle. Does that makes sense?

When I talked to Paul few months ago about SRCU from NMI context, he
mentioned the per-cpu memory operations during srcu_read_lock can be
NMI interrupted, that's why we added that warning.

> Thinking about this, if this can be called by the "thunk" code, then
> there might be an issue. I think the "thunk" code can be called before
> in_nmi() is set, so we don't know if we are in an NMI or not. I need to
> look at that code to make sure. If in_nmi() still works, then we should
> use the _nmi srcu handle (if that's required).
>
> But I'm not sure using SRCU for all tracepoints is needed at this
> moment. I'll have to look deeper into this tomorrow. But it's getting
> close to the merge window, and this needs to be settled quick. Another
> "partial revert" may be needed until this gets settled.

I did read this part, yes I'm not sure either. You mentioned you would
confirm that in the morning, I look forward to it. I hope the in_nmi()
function is reliable to use from here.
