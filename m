Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4F5C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 249FC20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDo/s9Ak"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 249FC20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732133AbeHAWZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 18:25:03 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35540 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHAWZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 18:25:03 -0400
Received: by mail-ua0-f193.google.com with SMTP id q12-v6so13623643ual.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MgdX0FT6uYAR1WgFR/pnyFpaYJCXYuADUuHeDkVez0M=;
        b=QDo/s9AkZMGDVf+ZzjSU9GDjJBMj6rcfyhOJb/swTv8GngI3IU/zeDOrDSXpb36ScA
         UAAysEDE7kj/sZw8yGUl0WnhNyS/kOI9+zt3G6BNtNu5iN2hjDalTf2tJ2yUYfPC931Z
         a+NQwx8t9k/USod9H+kWEthiNadS+bB49xT/veMFczOdZ9azAPX+h9QDUUTL8NVTm//a
         mMmb3F4RNLCcunAwRei2iHiAUyKCBWh0nAF1cCF2NMnZUF/sQJr6i9KjMZXoUE6brj8O
         4UejLu9JVxfxFt83SkKyE/+UamPfR5Pp48gJ3U5La24KA0F1jR3T6ztYcu+RgfDzCg0L
         VWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MgdX0FT6uYAR1WgFR/pnyFpaYJCXYuADUuHeDkVez0M=;
        b=q13qHPWw+6W/WujpCZIQ9U6HwrQIu4/yzfpdEkLHcWrps6yjE460yGpEUTZP+Q/95R
         EcwKAde5mz9XSaMNqB9bdOCQBWoKnDP+MQxc5I9v7tUAqfuRQm45WnV5xJucjTh30aY4
         5K/wI0Ft9Usv+aEMPJ2xo7qA4lN6/kWd6sNF8/KU8Vh294gvmK1lDO1gtOvLkakUm3Wu
         YRzbk3tqLU248ZXoQOM0Y7/277C7Tf7mnZF3WbPa0HjenTnh86/spWtMC0U2nXu3VjTY
         VfsJm5XEROFbVL9KmMx1a+5KDeZ0lQ/6noPqns4f6gfSoOPaAZlT2+j0HUVV5GNkmPPi
         jeEQ==
X-Gm-Message-State: AOUpUlEcX3pz+eID/7U+5o0ZDRmN1yok3w2KnFG2KJmfomtFZXZPmWJv
        3xAlTtzW/rWfuhWuc5igMJAWxGuDy6p2enQ9NjU=
X-Google-Smtp-Source: AAOMgpdlrt7xD53G9tFksBe+3OYi8ERAG5rxYiy63+P7lxpeHYfOneoN/4hGgFqEiGOnwiPNkEuxYXReleKRKXS6gKI=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr19585554ual.28.1533155848990;
 Wed, 01 Aug 2018 13:37:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 13:37:28 -0700 (PDT)
In-Reply-To: <9d935c253796909c5d005dd9416f33cb5bbd8537.camel@intel.com>
References: <9d935c253796909c5d005dd9416f33cb5bbd8537.camel@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 23:37:28 +0300
Message-ID: <CAHp75VcMyefYBD3AKGFC_tg4BFTPOaRU2N9xKAnzcJP32A3YCA@mail.gmail.com>
Subject: Re: Interrupt flags mismatch check in __setup_irq()
To:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "Zijlstra, Peter" <peter.zijlstra@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 11:05 PM, Shevchenko, Andriy
<andriy.shevchenko@intel.com> wrote:
> Hi!

>
> Recently I have experienced some nasty issue
>
> genirq: Flags mismatch irq 18. 00002000 (intel_mrfld_pwrbtn) vs.
> 00002000 (bcove_irq_chip_pwrbtn)
>
> but it is not a merit of my message here.
>
> While trying to understand the logic behind real code and what is wished
> (based on a comment) I have got differences.

Okay, nevermind, I miscalculate the parens in my code.

But still good to have a script to check :-)

>
> Thus, I wrote small python script [1] to understand better.
> I assume it has few false-positives, but I also believe that logic and
> comment are not in alignment and we might need to fix logic, comment, or
> both.
>
> Can you check that script and tell me if there is (in __setup_irq()
> check) an issue or not?
>
> [1]: https://gist.github.com/andy-shev/b85c5129fcfe63cb88849805e5a7e3a4
>
> P.S. Small explanation, the functions are mapped to the following logic:
>
> codebase() - repeats what we have in kernel
> comment() - my understanding how it's supposed to work
> algo() - abstraction of algorithm, so, can be extended thru the RULES
> set
>
> It prints out in case when codebase() != comment() for the same pair of
> flags.
>
> --
> Andy Shevchenko <andriy.shevchenko@intel.com>
> Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo



-- 
With Best Regards,
Andy Shevchenko
