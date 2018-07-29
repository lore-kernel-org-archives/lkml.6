Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCD2C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4952220882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 19:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CxCaRLUq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4952220882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeG2V2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:28:34 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50328 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbeG2V2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:28:34 -0400
Received: by mail-it0-f67.google.com with SMTP id g191-v6so3416982ita.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8sfgsSz3YTOMGINWX5xbwvOPbnsWQCfLZ9UYwzEYogs=;
        b=CxCaRLUqNWtWeV3Q8aLyLRgJIheSpL/4YxUPuEGnqONakDpHSqJp1KL400RqXle4H1
         4HjxfRAKPJYCMzqA5qVaFb+W8KFS2pFPygmna1Dk/30mQ62av26/kM+PxtZDD1bzUBhN
         IyQXQqvz4SEGH+IQeHtgdXZuIHA9PGduJSA9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8sfgsSz3YTOMGINWX5xbwvOPbnsWQCfLZ9UYwzEYogs=;
        b=Mxq/WS1rCY3U29Pjic0bZPUR0zEMHwyXJ9eB5HLBi8Kk9QNSkXXSzzyZrHi7TEcgfu
         9bm4CVgh/K9RcbLURTT4uO++oR33gGSTG+L7w/LCHSkwCtpTfC0m4OT5IVslP0HIWVz7
         4GqkCvgS/YcTv1yawl92xlz//SbtGIB02GtmVZB6BN/O9Qi0AJlEdxCQXhOXkks+wjBh
         5bdmrI4Io0OuMb168p36tiPvyJsuWGNOgptfyL6kRsiB7bTl1RYESaiFgIhICwKc3gZL
         XOjfJKcMoocX6Jz+dp8e5pEt+PMs8jMsnErSn+e8f3UN3HZP3pA/aLCQrcCXGHT6i9b0
         5GyQ==
X-Gm-Message-State: AOUpUlFBL6aT1tL9+h0PnAeGADkr1t8RG0/XhcWjPuq5QY58UN7OUpML
        P/QBqRwlNhg/N+O8DmG7idjJVN9XRJyYV3Xjkj0=
X-Google-Smtp-Source: AAOMgpf8iD/riy5s/sU4I//iSZiDIho6b7RFfGkNae4+4Lavw1HtxyGEkjCAadN/5eqC+R7jbYFayod/fnxn3H4uXHA=
X-Received: by 2002:a24:5002:: with SMTP id m2-v6mr11977541itb.16.1532894217159;
 Sun, 29 Jul 2018 12:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180728215357.3249-1-riel@surriel.com> <20180728215357.3249-4-riel@surriel.com>
 <CALCETrUipqat-78++E8fL7d2=77Cbj72jCTZMO=yNF8nX9HhCA@mail.gmail.com>
 <1532865634.28585.2.camel@surriel.com> <E710FBA5-CC5E-4941-ACBF-4AB3424F1F68@amacapital.net>
 <1532886673.28585.24.camel@surriel.com> <8A3221EE-0D94-487E-B53D-885A555634BD@amacapital.net>
In-Reply-To: <8A3221EE-0D94-487E-B53D-885A555634BD@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Jul 2018 12:56:46 -0700
Message-ID: <CA+55aFx4eLxPK+jn639GW8UcdguVvXFdwMsM4Ko33yWMME5tAA@mail.gmail.com>
Subject: Re: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Rik van Riel <riel@surriel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Dave Hansen <dave.hansen@intel.com>, will.daecon@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 29, 2018 at 11:55 AM Andy Lutomirski <luto@amacapital.net> wrote:
> > On Jul 29, 2018, at 10:51 AM, Rik van Riel <riel@surriel.com> wrote:
> >
> > This seems to result in systems with ->has_wbinvd_exit
> > only calling wbinvd_ipi on OTHER CPUs, and not on the
> > CPU where the guest exited with wbinvd?
> >
> > This seems unintended.
> >
> > I guess looking into on_each_cpu_mask might be a little
> > higher priority than waiting until the next Outreachy
> > season :)
>
> The right approach might be a tree wise rename from smp_call_... to on_other_cpus_mask() it similar. The current naming and semantics are extremely confusing.

Ugh.

Renaming might be worth it, but at least one issue is that we are
simply not very consistent.

For example. smp_call_function_many() does indeed explicitly ignore
the current CPU.

But smp_call_function_any() (one "m" less) does _not_ ignore the
current CPU, and in fact prefers it.

So it's not that smp_call_... should *generally* be renamed. Only some
of the cases might be worth renaming.

And just a "rename and forget" isn't really great. As Rik's example
shows, existing users should be checked too..

                    Linus
