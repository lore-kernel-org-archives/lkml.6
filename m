Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0C422190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ASf2CcNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbfBORSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 12:18:22 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34242 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfBORSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 12:18:22 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so8615393ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKRUq4h/ue0wDp79fBlnuukqhRIoARGpcxTy9wm7Zis=;
        b=ASf2CcNOJTffmlwufsEVtqnURgoZhUWsIDpV1Wt0PApsRlxlsyrrNTCLmzQopxBv35
         1GSzieZUR6nIwIwljPzoxD8BaDcMyejsmefnAwYzC7nEJUP9MQfDUeZ7IuvyWu0S93oR
         doynVHl4EX/rPKARWof6UYQncthF6eCgN8fN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKRUq4h/ue0wDp79fBlnuukqhRIoARGpcxTy9wm7Zis=;
        b=dLE6dFEgGkqOP34qBdJZW+bnVHxvFjsN+UKw1I05Cjjkdlm8bMpnnSSW6i7tn4qJ3w
         dxgZz51L073byrzFtWJBr7n+eunGSN/HtJzLNNJRIXdDmb30/AVfeB/nDn+nSny6RNYc
         XgTHyUxeziCLB0ExpAXbwAJk8JqQ9hNrSST6OOEiI22pyorsE4gV7OdIVqoRK6/mo1oi
         HpoBzmCY/soWb2VkwCrFfk8sJ9EZyTS8uxdHJfEz49eEecoBhYhNFgmr1uuvjMwB4+Uz
         MjYmHstc7RFbTErwyChg7gdfKS0geSOjYONS/JqyNLlCYpOnFIBvxKLXrQbNMdD4+ZVA
         +MuA==
X-Gm-Message-State: AHQUAuYY0HAaJy/VGPsB5SZFrAw9WpLdTwdERGIQBHJidlfH7b0dpQlh
        waWqW1ROoifXXj31xAqqS57cjPTL3Xs=
X-Google-Smtp-Source: AHgI3IYopWWKXXV4WWJFpusT/5CvyTtEGe6+C1VJlsX3UtbXKx6rPD/U+Cwp32O6xOcQ0vRWv7Pfnw==
X-Received: by 2002:a50:b744:: with SMTP id g62mr8558320ede.14.1550251099588;
        Fri, 15 Feb 2019 09:18:19 -0800 (PST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id c5sm1715090edm.36.2019.02.15.09.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 09:18:17 -0800 (PST)
Received: by mail-wm1-f46.google.com with SMTP id t200so10357525wmt.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 09:18:17 -0800 (PST)
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr6921394wmj.138.1550251096655;
 Fri, 15 Feb 2019 09:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20190213140025.GB6346@brain-police> <20190213142524.GW32494@hirez.programming.kicks-ass.net>
 <dd33cc20-f335-0e4c-e3f4-02497ecc3710@arm.com> <20190213144145.GY32494@hirez.programming.kicks-ass.net>
 <20190213154532.GQ32534@hirez.programming.kicks-ass.net> <D61C430D-4321-4114-AB85-671A3C7B8EAE@amacapital.net>
 <20190213222146.GC32494@hirez.programming.kicks-ass.net> <D3E1B64D-3E91-4A82-9C3B-92D9EB7326CE@amacapital.net>
 <20190214101429.GD32494@hirez.programming.kicks-ass.net> <CAMzpN2hg+CY+AuF=BtetS2HrMQYdxhBZL9QMvJX4LjAs7vwwAw@mail.gmail.com>
 <20190214193432.GR32477@hirez.programming.kicks-ass.net>
In-Reply-To: <20190214193432.GR32477@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 09:18:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
Message-ID: <CAHk-=wgj9yUAhTz8n__s-gHnHJw4fznBbLAfne4EO4n6RukgcA@mail.gmail.com>
Subject: Re: [PATCH] sched/x86: Save [ER]FLAGS on context switch
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Julien Thierry <julien.thierry@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, valentin.schneider@arm.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 11:34 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like the below, right?
>
> +       frame->flags = 0;
> +       frame->flags = 0;

Those are not valid flag values.

Can you popf them? Yes.

Do they make sense? No.

It has the IF flag clear, for example. Is that intentional? If it is,
it should likely be documented. Because IF clear means "interrupts
disabled". Are the places that load flags in irq disabled regions?
Maybe they are, maybe they aren't, but shouldn't this be something
that is made explicit, rather than "oh, let's initialize to zero like
all the other registers we don't care about".

Because a zero initializer for eflags really is odd.

             Linus
