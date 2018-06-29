Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DAC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D442502B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CLsa1vGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D442502B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755095AbeF2PyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:54:18 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40438 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbeF2PyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:54:16 -0400
Received: by mail-it0-f68.google.com with SMTP id 188-v6so3501301ita.5;
        Fri, 29 Jun 2018 08:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGwnDXlLbeRmIec1NSGl+vqHliYHgpn/3YZHQja5QPc=;
        b=CLsa1vGcPtp85OZzzd+cSEf1FQQA8EeI3oTA8lfVzMXO2Z0jSuJf8PPfEnWHKokd4s
         vtRdxX20pqkAR5JyAfTvUwVs7czhdzLQAVhjfcenAHpYpGuwSU49VFcLKy74xngfnOQb
         5dBVAVpvSppze+wexxJh5CPUMdDe/agWjoDx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGwnDXlLbeRmIec1NSGl+vqHliYHgpn/3YZHQja5QPc=;
        b=Are0tnoEWCnDkVWxAX4IaQ3Hz9AyrSukaVHbNBEgmG8MlcjcofzI2ZN5BkFHHBCQXv
         eo0rN64Oud/6pizVxA3emU8x24IHAsER/OPt2NPi2Vm0dqLMz8D7wB157Qbb9776pJIi
         u8jvgA0euveu5fxnbvAtWxH7iZnGuZQIhtWjALVfmWYdFG3Rrpvo6lUNzI1xqk+qUzdY
         YxzQTpN9OD7DZLMlTKGkJ7wghxEOkkPya9Jc2lI+K0zrBBPcTyM2Dxytaw8wK5uEAMve
         whd0PPLe43UzUZWbQWFovELL3i+WYjzC22Xxkoh84RBrjJVQ7JKtuugEWEuzFtj6lPzT
         fXVg==
X-Gm-Message-State: APt69E2UJBhismFxCC9UbLPg/fVI2ul1GTyfrguNsehGSKgeo+R1vGTl
        QrFK9i7UdiLfDHtSU2UByly+2/1iqUwSPOSKYXY=
X-Google-Smtp-Source: AAOMgpfP7Mw7BhnGXCJLFmsn54ypsc990Hby4DFD4NhIkvRnqsHbtztYJj51Umit3iA0T4wMdINyk1hQx3v+gxwFVDw=
X-Received: by 2002:a02:1bdc:: with SMTP id 89-v6mr12517409jas.72.1530287655988;
 Fri, 29 Jun 2018 08:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180628162359.9054-1-mathieu.desnoyers@efficios.com>
 <CA+55aFxZrv9koOGKNzpBjcpzwaKQBg9ybqcvQ9u=5d94y1F+mQ@mail.gmail.com>
 <CALCETrUrXk3wRg8SKhWf98v8jK=HwX9XLvP+Ypi+TktZoNx_Jg@mail.gmail.com>
 <CA+55aFzxCjkSbfRUeX3W_oXSJ6LMUdRVYB=DR2b3rUNkiixM1A@mail.gmail.com>
 <9200ED2A-AE4B-4094-81C9-E92240B4840F@amacapital.net> <CA+55aFzpD5xF80iiFNd+EMkJnRQdKPumM5p24Sr+LeBt8Gg=wg@mail.gmail.com>
 <1706339668.9644.1530281144560.JavaMail.zimbra@efficios.com>
 <CA+55aFxRJWjbgLeSQ_swi3F5nF1SYgZnC-R7QsOvZdcuSaWeaw@mail.gmail.com>
 <729451355.9702.1530284622326.JavaMail.zimbra@efficios.com> <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com>
In-Reply-To: <CA+55aFw==YnFJn7iGnKMW=RbPT74YHNa0QDF96mEdMPA2oX9SA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jun 2018 08:54:05 -0700
Message-ID: <CA+55aFwJWxsE_LL=-8WgB7uH_mYeMSu=boWF4N5KdOW673g4hA@mail.gmail.com>
Subject: Re: [RFC PATCH for 4.18 1/2] rseq: validate rseq_cs fields are < TASK_SIZE
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
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

On Fri, Jun 29, 2018 at 8:27 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> You simply can't have it both ways.

Put another way.

This is ok in the native path:

        if ((unsigned long) rseq_cs->abort_ip != rseq_cs->abort_ip)
                return -EINVAL;

because it's checking that the value fits in the native register size
(and it also ends up being a no-op if the native size is the same size
as abort_ip).

And this is very much ok in a compat syscall:

        if (rseq_cs->abort_ip & ~(unsigned long)-1u)
                return -EINVAL;

because it's checking that the pointer doesn't have (invalid in
compat) high bits set.

But it is NOT OK to say "the rseq system call doesn't have any compat
syscall, but we'll do that compat check in the native case, because we
worry about compat issues".

See what I'm saying? Either you worry about compat issues (and have a
compat syscall), or you don't.

The whole "let's not do a compat syscall, but then check compat issues
at run-time in the native system call because compat processes will
use it" is braindamage.

                   Linus
