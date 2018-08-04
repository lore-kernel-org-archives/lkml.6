Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BF5C4646D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7A42178D
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 04:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juOA+La2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7A42178D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeHDGu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 02:50:56 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:38490 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbeHDGu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 02:50:56 -0400
Received: by mail-yb0-f193.google.com with SMTP id i9-v6so3443153ybo.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 21:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ysw2c+fpcoURBxliFg4KI831RITh1ed64QxJrExTDcE=;
        b=juOA+La2FZfYDL+fwUafekX2cmsl0GhddQVDL8O2V2JvqfU2cwP4WzKNHTfgqUP52M
         spqmVnAGUUKp7WjRj+cocx19kIHcHfKoLBXUkMahIl7r/k8nJ2PwbwzvEyOsCV3ai6nJ
         3rjcNjERzIUadnsKGjULX6AbEyR8mf/mXi+xvawuNxvgyDoXIxCctXGUo+UI3Zp3kqx8
         S3OtSn3rQbZlDvExiR8FecorNjZb+LHQ3CRe3b7gtydDgiu0xkG3VD+2GDz497eix/Xp
         YfXdsmeH+NeVrnBjV+t2ytGjj1BMz8S825nrzVHnSCSjaYenqMXRGMuFBDNMEocv51A5
         gtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ysw2c+fpcoURBxliFg4KI831RITh1ed64QxJrExTDcE=;
        b=hlnTNbuAM7ZXPXWBjLUCayp+MRnJNcU567qrKU3sJ4tUN2SkhfWVYBhFUzTlUhkV9x
         jJIao7XTP3t2A0q2W0FENweoLzbRV7rarxNbZcC5MTZDphS1BTrkHxZyrrRDAeGjw7pa
         96iKTLgXbOh+6Zr0AZytxLm/7p5IWecf2KMagYhfN92Esgq7uF3M1xBcis4yC9EXjZA1
         jaT0ggtUz+X7Ca8VrT6a7pI3F52Hl14zKoGrCwpH5C7I43x8kBzHXeWMEVn42E4pG7IK
         zgkF0j9Zvd5Ofehj+uDPq5jHs1gk4cTFd0kYyiwxv0NUmxoofRWdl39oNZT+UBvPStfH
         1hOg==
X-Gm-Message-State: AOUpUlFix8ZuqXW6L4xzLdZxzRPInHQJaGPqtR10456/yoVQGoIuSW/0
        qwxKxwzEnPWNZLcBnpBkGgXQ66MzyWtjQAnswDY5Zg==
X-Google-Smtp-Source: AAOMgpch5Uh/kKRp1xoNleDhh63S/MnECB7vdM0r7hhSKyj3j76zzfb9qE+0IueEbWF/5+ViEq9YPTp+MxeN9gpvTSg=
X-Received: by 2002:a25:5702:: with SMTP id l2-v6mr3645504ybb.24.1533358299824;
 Fri, 03 Aug 2018 21:51:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:bfce:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 21:51:38 -0700 (PDT)
In-Reply-To: <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org>
References: <20180730222423.196630-1-joel@joelfernandes.org>
 <20180802235527.ddb0d1837154e3f98571b3b0@kernel.org> <CAJWu+opoT6Ky-pwAwBbjDkyt0Y_UF1QUnDshu-_vLTU5K87_HQ@mail.gmail.com>
 <20180803162340.32b4b3fde55a4f5a5c28b425@kernel.org>
From:   Joel Fernandes <joelaf@google.com>
Date:   Fri, 3 Aug 2018 21:51:38 -0700
Message-ID: <CAJWu+opO9-bb5RWorbQ54vq0rU1U6NFSnH9BDwGTvXhSaPmPTg@mail.gmail.com>
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

On Fri, Aug 3, 2018 at 12:23 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
> Hi Joel,
>
> Thank you for trying to fix that.
>
> On Thu, 2 Aug 2018 19:57:09 -0700
> Joel Fernandes <joelaf@google.com> wrote:
>
>> Hi Masami,
>>
>> On Thu, Aug 2, 2018 at 7:55 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>> > Hi Joel,
>> >
>> > I found this caused several issues when testing ftrace.
>> >
>> > #1) ftrace boottest (FTRACE_STARTUP_TEST) fails
>>
>> This sadly appears to be a real issue. The startup test for
>> "preemptirqsoff" tracer fails, however it passes for only preemptoff
>> or only irqsoff. I tested only the last 2 tracers, not the first one,
>> that's why I didn't catch it. I need to debug this more.
>>
>> > #2) mmiotrace reports "IRQs not enabled as expected" error
>> > #3) lock subsystem event boottest causes "IRQs not disabled as expected" error (sometimes)
>>
>> Could you try the below patch and let me know if you still see the
>> issue? In the v11 I removed the lockdep_recursing() check since it
>> seemed unnecessary. But I'd like to rule out that there's still some
>> issue lurking there. Thanks and I appreciate your help, diff is
>> attached to this email.
>
> I tried the attached patch. But unfortunately I still see #1 and #2.
> (#3 does not always occurred, I'll continue to test)
>

I found that #2 is because of CPU hotplug and tracepoint interaction.
I can reproduce the same issue if I manually offline a CPU by:
echo 0 > /sys/devices/system/cpu/cpuX/online

mmiotrace also does the same thing.

Its because the tracepoints become inactive when we hotplug. This
prevents the lockdep probes that were registered from getting called.

Basically the cond parameter in DECLARE_TRACE is whether the cpu is online:
#define DECLARE_TRACE(name, proto, args)                                \
        __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),              \
                        cpu_online(raw_smp_processor_id()),             \
                        PARAMS(void *__data, proto),                    \
                        PARAMS(__data, args))

which prevents the probes from getting called.

Steve, any ideas on how we can fix this? Basically we need the
tracepoints to work until the CPU is really offline... Could you also
let me know why we need to check if CPU is online or not before
calling the tracepoint probes?

I'll try to look into #1 and #2 tomorrow as well (I'm on vacation +
weekend, so time is a bit short, but this is quite important so I'll
make time). Thanks!

- Joel
