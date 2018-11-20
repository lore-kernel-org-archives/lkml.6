Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86290C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AF902146D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 19:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="jcwyVjbt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF902146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kylehuey.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbeKUGVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 01:21:40 -0500
Received: from mail-vk1-f178.google.com ([209.85.221.178]:46829 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeKUGVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 01:21:40 -0500
Received: by mail-vk1-f178.google.com with SMTP id j23so682119vke.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 11:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEn3i1uP4tJa6vP5eIWtYU8rt+lYiVOO+KFwOrhPUqg=;
        b=jcwyVjbt53OYfBSllpv1PQF3SrIMCYDH8pYe0Tlxd6+uGOG4nfMBuHAenO171g0KTY
         5z/3zWInY5OvHJmdPKysMoxqOlTPEGG8bPUO5Yu76+j30TiiL6J9+H7F42U1u+hdGOpc
         x+qORy1jGnS1bB2bhxETIb42KdH+wIoNJROGoVOPcJNaKggU7zxs31csck7nRD2zonzX
         GAzGrSvMmx/o7knAx4TwS4vrLwzB8UteSVymV9otkTp7aJwhaXOzhU7wdnX1V81Omwcp
         L5ZlfN7aEwwrJfzcOXrR+HiCCv8vCFmL8UNVI6L9aK4qwVfu3SiF69IDMyaZjx/6vbkF
         TTPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEn3i1uP4tJa6vP5eIWtYU8rt+lYiVOO+KFwOrhPUqg=;
        b=TWgmQ7FOhJrCWzSQNMd3nT9McZCw1il+2TPK6kmwskQEYc8YhQKGd70rSNH3dEOUx9
         DcIY4ylmK/KPIrIsJdCSAddv2KeGoaBKSVMjVFmFCLXQrsRS2InzH8FzXUyQ1eFLYsTD
         7ymJ0qGtiHf7eWXoj6xVyM28EvWaYylLjBarFebg16UTpZCFTKyHItM3GA63bKhybJ+b
         TEGXut92VRP1SQE8aPZt8wkQY2QjFJ6hnPYkzb5QG+DQ4MZwYNbHoM5BPdNfKCi+HIyj
         jhjFVbI9YTFGNdxY/CPppviq7q/zZ/2FtQjjp7OPZg3ixQxPlVnY8GedkqboznZUgsx0
         Txnw==
X-Gm-Message-State: AA+aEWZWsdHzcq+8svwO3xnqiT4RE/FaJuFuJrIzbPQ2aVukan3nFZrJ
        HoU97fE6OPMDvUY5M1+eSJyf1GsTRyY2eJuGqqLsdA==
X-Google-Smtp-Source: AFSGD/XQC9cO3VLo+Sa0m+5rj+2lxhQS9672Y7vjWaAgoXKLYb+SyAQa1p/aD7r9lO+sWUTf1lu3vPy9P7E2p+ACwwI=
X-Received: by 2002:a1f:f8cf:: with SMTP id w198mr1414447vkh.82.1542743449774;
 Tue, 20 Nov 2018 11:50:49 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Ap6Mm+r_44YmxNbz6HWtYArg3SAFgzk4Cm_K5HRJaRG7w@mail.gmail.com>
 <20181120170842.GZ2131@hirez.programming.kicks-ass.net> <CABPqkBQyvbM0AAJRRQQeBUZOuPHr2qjD+qWe53zJg84kzR3=Ng@mail.gmail.com>
In-Reply-To: <CABPqkBQyvbM0AAJRRQQeBUZOuPHr2qjD+qWe53zJg84kzR3=Ng@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Tue, 20 Nov 2018 11:50:18 -0800
Message-ID: <CAP045ArbBzW+MWv+uKoAr6gswRWp6vKWoPV2bMrG8ZSnO-zHoA@mail.gmail.com>
Subject: Re: [REGRESSION] x86, perf: counter freezing breaks rr
To:     Stephane Eranian <eranian@google.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, acme@kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:16 AM Stephane Eranian <eranian@google.com> wrote:
> I would like to understand better the PMU behavior you are relying upon and
> why the V4 freeze approach is breaking it. Could you elaborate?

I investigated a bit more to write this response and discovered that
my initial characterization of the problem as an overcount during
replay is incorrect; what we are actually seeing is an undercount
during recording.

rr relies on the userspace retired-conditional-branches counter being
exactly the same between recording and replay. The primary reason we
do this is to establish a program "timeline", allowing us to find the
correct place to inject asynchronous signals during replay (the
program counter plus the retired-conditional-branches counter value
uniquely identifies a point in most programs). Because we run the rcb
counter during recording, we piggy back on it by programming it to
interrupt the program every few hundred thousand branches to give us a
chance to context switch to a different program thread.

We've found that with counter freezing enabled, when the PMI fires,
the reported value of the retired conditional branches counter is low
by something on the order of 10 branches. In a single threaded
program, although the PMI fires, we don't actually record a context
switch or the counter value at this point. We continue on to the next
tracee event (e.g. a syscall) and record the counter value at that
point. Then, during replay, we replay to the syscall and check that
the replay counter value matches the recorded value and find that it
is too high. (NB: during a single threaded replay the PMI is not used
here because there is no asynchronous event.) Repeatedly recording the
same program produces traces that have different recorded
retired-conditional-branch counter values after the first PMI fired
during recording, but during replay we always count off the same
number of branches, further suggesting that the replay value is
correct. And finally, recordings made on a kernel with counter
freezing active still fail to replay on a kernel without counter
freezing active.

I don't know what the underlying mechanism for the loss of counter
events is (e.g. whether it's incorrect code in the interrupt handler,
a silicon bug, or what) but it's clear that the counter freezing
implementation is causing events to be lost.

- Kyle

- Kyle
