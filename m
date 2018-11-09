Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98284C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6445020818
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 21:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6445020818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbeKJHE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:04:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34189 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbeKJHE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:04:57 -0500
Received: by mail-qk1-f193.google.com with SMTP id a132so4181619qkg.1;
        Fri, 09 Nov 2018 13:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P7EYrgAhfU7VoNrFE4eM8mc+nzSLXu7MmBs4UK7oDdA=;
        b=pGTD249IQJ/WiCn92Zea7H57MkNXp6wEgXZCKLburZ1X3mXnHUJ5jXFpfq6Uffy7eI
         4WVj9WU7MZqHcwSIqTaCM+0Umt1QIvOXkBxfmpi5//TngKGCP8n70S6mSX00cZ2mbQ2E
         CVxyOw0hKackkUsAKBJR67u8LzmllCRU7S8qUKxkR1oF9rdmM6iu6NDsN2C+U8JcpDy3
         eyYt0dH/xTIimDlaawY4MzUARGfDrThBr+4kA9530PdUID00C+/uauCIWAWPxi9HcK1j
         50V3tdjyU9KyyBUNXpH2Um5H99OgCo5oyJTzcu9SUYi3qN7UIGJ7dcI3M4zSx0vYSkMt
         5sYA==
X-Gm-Message-State: AGRZ1gJysdC0ClXgUjGXjtopgcWpQBqVrKycxsdcEh82YjC8RboFwjTz
        jKUNovdhSpCgpE5wCxAmOLpmno4+ulLx2tjP7Vg=
X-Google-Smtp-Source: AJdET5ckI6k0hEi4v2QwXSQUm3y3hfOTVfCUEd243u5XREIjrYEtp6guWMQLXnjr5UkDNBiDik0OCPgrN9CD5MmTIF0=
X-Received: by 2002:ac8:1d11:: with SMTP id d17-v6mr10079301qtl.343.1541798554695;
 Fri, 09 Nov 2018 13:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com> <CAGngYiU+8k4ZHYhFVQGKXW8mATEDi64Mi9PsVkX-5vn2PCY3ew@mail.gmail.com>
In-Reply-To: <CAGngYiU+8k4ZHYhFVQGKXW8mATEDi64Mi9PsVkX-5vn2PCY3ew@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Nov 2018 22:22:04 +0100
Message-ID: <CAK8P3a1STE+vN_yF0Zyu8gGX_KCWZEV=muPxVE6M1EUqdhO4Pg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 0/6] Support HMS Profinet Card over Anybus
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     svendev@arcx.com, Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 5:02 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Arnd, Rob, Linus,
>
> Many thanks for your constructive feedback so far !
>
> Is there anything in general about this set that would prevent it from being
> mainlined? Perhaps I am trying to do too much at once, dropping a patchset
> that is too complex to be properly reviewed?

As usual, it comes down to the user space interfaces I think. Designing
a user interface is hard, most importantly because you cannot change it
once anyone starts relying on it, as opposed to implementation details
that you are free to change at any point.

It's also hard to find reviewers for it, the best you can hope for
is that you find people that have both knowledge about the type of
hardware you work with and Linux user interface design, and
get them to review the code.

> I've been thinking about reworking the host to its simplest, yet feature-
> complete form. Just serialize all card accesses with a single lock.
> Then the kernel thread, kqueue, kcache, kref etc would all disappear.
> The price we pay is a reduction in performance/parallelism.
> We could then increase parallelism at a later stage.
> Would that be of any help?

I don't think that's a major issue. If you are happy with the
implementation there, and you use the interfaces correctly, that
won't stop the driver from getting merged, even if you could
rework it to use something else later.

      Arnd
