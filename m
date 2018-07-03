Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E55C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95E423CB9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IyfPfSbu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A95E423CB9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934135AbeGCRKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:10:51 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36702 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeGCRKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:10:49 -0400
Received: by mail-it0-f66.google.com with SMTP id j185-v6so3908502ite.1;
        Tue, 03 Jul 2018 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p+slRbcnqGd4/KZcc2S7pJQLk2sJu2KDzj8lIgFLp5s=;
        b=IyfPfSbuFM+3UaUpxKuuEB19/w88CdKvUzRSg1tLkK8X1Ci540zadZEPbmxNYYy3s3
         q59g/4q8JY93iaW7cvACb1vWXjaz5WBQw7R2yxmPm1cIHyiZfb2rms/G0ibgqu+RZX2n
         /yxrsjTBS7LNuX3DZHjert8DovRKO5S1yawSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p+slRbcnqGd4/KZcc2S7pJQLk2sJu2KDzj8lIgFLp5s=;
        b=p2mTE0+KArV1wkjjhPyvwrfKb4P3td1+XUvityaO/n47M4D0Kvnj7tX+ZWxgcZ+LlQ
         ZmU99YloO4hUxbQrT9jSDGLf8Oej2OsaSEXmq7iGkzbRy6bTbq4xO71vblzzOKt+VNdd
         uWEK9z3FoJNMRwWuk4ARa3qumnN1/Rh3S2qwmL7bCPPINkQMrR7P2bmvw8aJlXTvFjs+
         xvih8U3/MFrVLiPjPdPvRMFxcn/RpQjmRzB0qL/6naPwUBmGp/2LLUihPodijmQYkc9N
         mmtu/4LYTDHK+dcTWa2iX6oow9blDJ1HdinpEwucQ8aQ2Ftx90O5cuMElkml+Wck41uG
         0PPw==
X-Gm-Message-State: APt69E35WkqftNdDJ5J4TdOHpuuBVmwFfQF2S0uVc32UIM8XvV+J3x1a
        QbdvTL8FYQpV2ZNSrhdMwqIORiUivj7EAf6SwVg=
X-Google-Smtp-Source: AAOMgpc8sx/qrOsmWNZvFPISVaXHm1K1Yno7Z3uR7ew3mXa7ks6Cj20/Bu7ugI5aUC5NN/Dn36/srif2TzpJsRGYRmA=
X-Received: by 2002:a02:89a3:: with SMTP id p32-v6mr25317034jaj.10.1530637848289;
 Tue, 03 Jul 2018 10:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <8B2E4CEB-3080-4602-8B62-774E400892EB@amacapital.net>
 <459661281.10865.1530580742205.JavaMail.zimbra@efficios.com>
 <858886246.10882.1530583291379.JavaMail.zimbra@efficios.com>
 <CA+55aFxWMjwx-4TGBHt0H6bh6FXC3NKMsjp=eKGw5cgA4wMBUA@mail.gmail.com>
 <1776351430.10902.1530585009519.JavaMail.zimbra@efficios.com>
 <20180703081449.GT2494@hirez.programming.kicks-ass.net> <20180703082955.GH3704@osiris>
 <20180703084312.GU2494@hirez.programming.kicks-ass.net> <20180703085546.GJ3704@osiris>
 <20180703092113.GV2494@hirez.programming.kicks-ass.net> <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
In-Reply-To: <20180703164048.i2te5gjemcafqzwf@two.firstfloor.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jul 2018 10:10:37 -0700
Message-ID: <CA+55aFzYEQgEhCnrwtbGuCy36Wh+aiw0_9rgMcjUgbn1JtZAPQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>, gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 9:40 AM Andi Kleen <andi@firstfloor.org> wrote:
>
> So it sounds like architectures that don't have an instruction atomic u64
> *_user need to disable interrupts during the access, and somehow handle that
> case when a page fault happens?

No. It's actually the store by *user* space that is the critical one.
Not the whole 64-bit value, just the low pointer part.

The kernel could do it as a byte-by-byte load, really. It's
per-thread, and once the kernel is running, it's not going to change.
The kernel never changes the value, it just loads it from user space.

So all the atomicity worries for the kernel are a red herring. They'd
arguably be nice to have - but only for an insane case that makes
absolutely no sense (a different thread trying to change the value).

Can we please stop the idiocy already? The kernel could read the rseq
pointer one bit at a time, and do a little dance with "yield()" in
between, and take interrupts and page faults, and it wouldn't matter
AT ALL.

It's not even that we read the value from an interrupt context, it's
that as we return to user space (which can be the result of an
interrupt) we can read the value.

This whole thread has been filled with crazy "what if" things that don't matter.

                    Linus
