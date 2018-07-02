Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A33C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A682515D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 23:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Onp1mEjH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A682515D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeGBXGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 19:06:24 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38235 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbeGBXGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 19:06:22 -0400
Received: by mail-io0-f193.google.com with SMTP id v26-v6so49610iog.5;
        Mon, 02 Jul 2018 16:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dlupA3AzweWiJR1maj1D0qN/TWnz74EeMjLp2yQOPQ=;
        b=Onp1mEjH4pQqeZhJ4xIVKM9A8L1iK9ycXIZ7XrfTVqqbbuNAVnRXxvQ8by+f458dqQ
         OUjrNkZZyjBhFNmoaVxwm7ujHN5cL4Z6Ogq0fzs4omR0WKCd6wsUqOF6dCmGo4qrv0LQ
         JsfcXvN5EYTBlaaPqJXfS0GoIFFK57d54YR4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dlupA3AzweWiJR1maj1D0qN/TWnz74EeMjLp2yQOPQ=;
        b=P7WTjEw/09Fr25dFuG8f2FCCOrHRLvwhLd/12qmG7qkLyZGTZYfwZyreINCJlQlvLl
         zBPOycqGpbxWjP8GzPdiZTzvy5qNjvnYRMVoyARQbd0o6rHu4Q8kec7ygTjNk6wfFCeG
         IHs6KUG/1AxR0BPm38x5U+5mABS5jQ7WuYWXkfZUPWppyyD/dRJ6bS2fGnDDUXCJDkKo
         OGVgyCO/D5mBXs9fuDy1kxLpYWtDow0lFioQnmLO2uEGv2FrUGHgMxgE1HmbTPjdG0Xh
         kEEzEUmSf0FDdelHmJlMlKKWJyU6W4l7rJPI5ifAjvHy3ltdnhCtxl4isiBgtkO30JFL
         NbQw==
X-Gm-Message-State: APt69E2sN3OgmMvv9GfgBGiAsCcD2rVgkf/T5CdgG1wQC633rFP40elE
        6bmfFlffQdTM/lBdvapoFuGGV2BIwO7NlW+/IPY=
X-Google-Smtp-Source: AAOMgpeNSHWJZMuXkEiMgdaGwHO+VRbmvxDK+JaILOW4b+7Ya8BZyHn6jfls6lh6QNBQF9n1iUFy5MwJZAMD6C3vJ5M=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr23944919iov.203.1530572780926;
 Mon, 02 Jul 2018 16:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180702223143.4663-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxrX+wRoe+5HDaTrRXg1K-Qpks4jJ9Buc_OevoG8hoGFw@mail.gmail.com> <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com>
In-Reply-To: <415287289.10831.1530572418907.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 16:06:09 -0700
Message-ID: <CA+55aFzZYOatOtjrm7fD7878_SzCAmEoEu74n0+pgd7faH-sTQ@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18] rseq: use __u64 for rseq_cs fields, validate
 user inputs
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

On Mon, Jul 2, 2018 at 4:00 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Unfortunately, that rseq->rseq_cs field needs to be updated by user-space
> with single-copy atomicity. Therefore, we want 32-bit user-space to initialize
> the padding with 0, and only update the low bits with single-copy atomicity.

Well... It's actually still single-copy atomicity as a 64-bit value.

Why? Because it doesn't matter how you write the upper bits. You'll be
writing the same value to them (zero) anyway.

So who cares if the write ends up being two instructions, because the
write to the upper bits doesn't actually *do* anything.

Hmm?

                Linus
