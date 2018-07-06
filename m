Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77C4C6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F57222465
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CWl1vv+3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F57222465
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934070AbeGFT5M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:57:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:34451 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933738AbeGFT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:57:10 -0400
Received: by mail-it0-f68.google.com with SMTP id d191-v6so6091735ite.1;
        Fri, 06 Jul 2018 12:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y88o1GaP+5utsNZBi7FVfFdW0NSYCXwAy77dXU5Ar+M=;
        b=CWl1vv+3PSb58ZTY8CLJdVeD7DgCfUz6dqUA65gSv4i79yDE3dp/dCBmPQF8XI42gW
         rz5snZBdrUY9E5leb0RyF6zzBKYUwR17bvzvt5KWaKuSTwA2Q2IRJxpBoZLwMa2E2ZXb
         CZRbm07/o5z79Ee4C5NyyGQrEWJcftuTX2RMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y88o1GaP+5utsNZBi7FVfFdW0NSYCXwAy77dXU5Ar+M=;
        b=KzcZtbqmZGy21Auye7obUgrmckNc/y9rnKFPuWC/1oN/vfscXRtMek4vXtdFCXaYU/
         V/WLLMJIXa4J2KlGT7fE96x47d5UYJKMXTTmpnnEo391DULqUrE9AQIMJpZpUf8tYZ5+
         x9SRi6qzswHKZ8bytU0QOOZ3Q0jHMf3ZuhUNbXAPvz//LyPm+VLUlG7YXsbK5BEJtn+u
         WbehoCkuK2xV8ZY8kYS2hXy06ijHFwJ5Xg1B3bjpYIDHpsL6R7dchiEya6Ct+68BL37B
         O26z5y1GMtYsJkfBMrQ0mJaLjEy5Y45ycbRgA5sQFaabdsj5dGQEHFEyohU5Zz2BvgLs
         2qJQ==
X-Gm-Message-State: APt69E0nXSdgaGijFyH0T/r7QVhvARio2bGFOm8lHC9BXXGp3PBcoQXF
        TomhO0V7Ahp648bw0tijEoEqncDCy6buIkS43EE=
X-Google-Smtp-Source: AAOMgpceF0uXtksr/oVYrQo8Bw8U/7Ah67mjKkya9gibNxxtGTBEajm07444Y6iFqe9MJ/vHmFd5QPTKCUp3lbzlvJs=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr8916918itg.1.1530907029990;
 Fri, 06 Jul 2018 12:57:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180705180601.18423-1-mathieu.desnoyers@efficios.com>
 <20180705180601.18423-4-mathieu.desnoyers@efficios.com> <1846432971.1245.1530892973439.JavaMail.zimbra@efficios.com>
 <436937568.1359.1530905019620.JavaMail.zimbra@efficios.com>
 <CA+55aFzz1CC6son0T2nD-Yqhy0_yC5nBer2XSH9kqe5x3N26Ug@mail.gmail.com>
 <1913049637.1366.1530905741745.JavaMail.zimbra@efficios.com> <131696830.1369.1530905931822.JavaMail.zimbra@efficios.com>
In-Reply-To: <131696830.1369.1530905931822.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Jul 2018 12:56:58 -0700
Message-ID: <CA+55aFzuxGtPE2NnL9+K4=OQ=-9oAXSqX-mP_QiHpzBz7zrq6A@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 3/5] rseq: uapi: declare rseq_cs field as
 union, update includes
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>,
        Christoph Lameter <cl@linux.com>, Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 6, 2018 at 12:38 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Should I change all 4 bytes __get_user()/__put_user() in kernel/rseq.c
> for get_user()/put_user() to ensure consistency ?

Probably.

*If* this actually turns out to be somethinig that shows up on
profiles, it's almost certainly going to be the STAC/CLAC instructions
("perf report" tends to report them as three one-byte nop's because
that's how they look before instruction replacement).

And then it's not __get/put_user() that will improve things, but doing a

        user_access_begin();

        .. do unsafe_get/put_user() ..

        user_access_end();

that will improve performance.

But it is *very* seldom useful. We have it in a handful of places in
the kernel, and the most noticeable one is
lib/{strnlen,strncpy_from}_user.c

                       Linus
