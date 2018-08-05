Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219FC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD62218C1
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 16:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNxcAmjf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD62218C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeHESwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 14:52:09 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33071 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbeHESwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 14:52:08 -0400
Received: by mail-yb0-f195.google.com with SMTP id e84-v6so4454208ybb.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 09:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=u3iVRCFyREpwW2IHPJJkBgF1mv8wHrF1ekhvh7JE7uk=;
        b=lNxcAmjfaqvVBXqwHxUQYm2O3wa3JHZua+SaxmkZVwWk73xIlHTpi6SETOLXN7qnef
         0VGp/vya1tm+IvDgbwPEaL42YKkq5FBObDEiduW69I8qvCGviQdcS3teZP2ENqOpH/Lm
         27/aLuP2zjmZejLzEZ8BpxeLCCzOHpQtCtbhClmXsOtf9KRYzMbdV+zr6FSV+Nfy/26z
         XiWAOpb380WUTHaL+FXIUh6HF4o9mTuXSNJRf38uQl6MlGErwvQHrgq4D9qGyYDnN9ot
         k/Oo+zVHx5xoQxJP6BcmBkGCzCKN5efp5FtAivJwlOuABNUiCICGOVe3M6WAV3UmgeWG
         rIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=u3iVRCFyREpwW2IHPJJkBgF1mv8wHrF1ekhvh7JE7uk=;
        b=hmixulmDYGMuyUSJuVZzLYpXUjooRKBxrzDDMkFmknC8hU6tE6i3YIx2dS8AfewBM4
         4hIkIr6HF6d00Sk4wocOSIMQWN+c0KM2A3CevR3cWd0slf+UTPZNI2dDw9RpJUcT+6eN
         SsgN0c41JAtLxyhIxeIwqu4i6bTm1fVNVb7NfeINw/IpP5l14wCZCerBY9Z/mD/ycHiW
         hyh11qLzPZN3tBorzsc/nkLFzMnJ0Q9c0WmXsaVYME1kqPMBFlCdz5hmGcpun2jLIKoZ
         4AuA6rZsuIgVxNudAv3sIeNrsp7w6vbkYqq/tZOVlHyJfUZ9S0dszQevVTGWHvEu6H2o
         U9YQ==
X-Gm-Message-State: AOUpUlFhiGVMVmMyNZnPyyIjwO091ojnpz69Zkt/hKOd2Dr5cRPFC96H
        /GmUNWVHkn7e6UYLGYHV5ulT6RB+qJHJ/Vf7qV0f5g==
X-Google-Smtp-Source: AAOMgpd1XZt2FjKwjvJRXWniwkDJ4CSmt3tH/r/kzzACDhx1N5rBBxq1iIF44x2Syzt3++4VGKF3liDEMw4opkbRewQ=
X-Received: by 2002:a5b:607:: with SMTP id d7-v6mr6208501ybq.281.1533487616905;
 Sun, 05 Aug 2018 09:46:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Sun, 5 Aug 2018 09:46:56 -0700 (PDT)
In-Reply-To: <CAJWu+opO9-bb5RWorbQ54vq0rU1U6NFSnH9BDwGTvXhSaPmPTg@mail.gmail.com>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org> <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
 <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org> <CAJWu+opO9-bb5RWorbQ54vq0rU1U6NFSnH9BDwGTvXhSaPmPTg@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Sun, 5 Aug 2018 09:46:56 -0700
Message-ID: <CAJWu+oq3HD3VhYzvRJA-8HQksdrX5zYr4kz7EUpDYvCNQRUGXw@mail.gmail.com>
Subject: Re: [PATCH v12 0/3] tracing: Centralize preemptirq tracepoints and
 unify their usage
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Fri, Aug 3, 2018 at 9:51 PM, Joel Fernandes <joelaf@google.com> wrote:
[...]
>> On Thu, 2 Aug 2018 19:57:09 -0700
>> Joel Fernandes <joelaf@google.com> wrote:
>>
>>> Hi Masami,
>>>
>>> On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> > Hi Joel,
>>> >
>>> > I found this caused several issues when testing ftrace.
>>> >
>>> > #1) ftrace boottest (FTRACE_STARTUP_TEST) fails
>>>
>>> This sadly appears to be a real issue. The startup test for
>>> "preemptirqsoff" tracer fails, however it passes for only preemptoff
>>> or only irqsoff. I tested only the last 2 tracers, not the first one,
>>> that's why I didn't catch it. I need to debug this more.

I figured out this one too. Its because I need to account for
preempt_count() in tracer_hardirqs_off since the tracer probe is now
called with an additional level of preempt disabled from the
tracepoint code. Without that accounting, stop_critical_timings may
not be called causing an empty trace buffer. That should be easy to
fix, I'm on vacation though and back on 13th so can most likely look
at it only then (the week after the next).

>>> > #2) mmiotrace reports "IRQs not enabled as expected" error
>>> > #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)

The only thing left to figure out is #3 ("lock subsystem event
boottest"). Could you let me know how to run this test?

Thanks for the reporting these,

- Joel
