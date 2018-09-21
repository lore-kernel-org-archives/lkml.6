Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB16ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B95821533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nnFQxrXW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B95821533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbeIUJT6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:19:58 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36311 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388944AbeIUJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:19:58 -0400
Received: by mail-qk1-f194.google.com with SMTP id n186-v6so7035701qke.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgIgCc/2dQPs4jWIV9FZ6VhZHEZWNMeOw3JNWYbORWM=;
        b=nnFQxrXW5uC5uPQoKI0AC6WGLJ0rxdfejUE7jLw+t1R+hQhdPCckpM4DM+OCtr+Ahd
         4cS5jZ62Uy6QR7s04MKRaekhVheOcQmF4nJ2JR+sDafcEH9ygsvUUjeR7K5jdrXXKcHv
         rQFpPiMOFX5h0RpLss1S4Z91PPJFsOMFTSJL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgIgCc/2dQPs4jWIV9FZ6VhZHEZWNMeOw3JNWYbORWM=;
        b=py6XeflXF5AecGmzdb+McjRlX0QN1VgGw81pIi+hfCeC40CRsrgTxpdtsRsHSwP3IC
         xnjbclwnvUqjbMGnXqj5eFpsvQ4IMgV7ws1wYiQ93aKOMY9Xz2pcBqYT7HYJZUr7hoyb
         HSxhOYBEoY5ygUp3HVT4boPX6RseqDm9h5njp5Ad704sYoluiu+nZB4VpeVso0jpHuRK
         sB/cElnjTSy1fYjLCJUX/6E5UWxofKoWpXEepxJrCYEfm7ab2Py9dNROzWdXkGVwUN4o
         7YTo3KlReUu7oF0+JQrUJRDOniaUqOA4Hiyfq9hVjkPVKgKpmFa0ok+V4j0MVrlqAouy
         CCaQ==
X-Gm-Message-State: APzg51AIIUVmnOGT7L4o/a75BdgOMRpWwCGxtCjocBuxJ7jYSEOs6OnD
        ggBjPiDihV9BdLD0omv5PPvhejbFOcdw3xPPOP0=
X-Google-Smtp-Source: ANB0VdYAj451FtZUYPeUe6b20rYC6Y/Q9JupLRxPZgWotjMFkEHHeka3asMBFaRLB3r4oCzrpakccJbfbyeUzu0kEEE=
X-Received: by 2002:a37:642:: with SMTP id 63-v6mr28907182qkg.11.1537500788234;
 Thu, 20 Sep 2018 20:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180919221331.2511558-1-taoren@fb.com> <CACRpkdZGjvLZY7snev5W2rRGgO7bQsSqn5u2v5Nw0tH9sa4yBw@mail.gmail.com>
 <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
In-Reply-To: <84F9ED20-0964-462E-B389-39B107A232D3@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 21 Sep 2018 13:02:56 +0930
Message-ID: <CACPK8XeEZeMskkxNChhNSO+brpoPJ5FqweWNXe22BpyytwCwFw@mail.gmail.com>
Subject: Re: [PATCH] clocksource/drivers/fttmr010: fix set_next_event handler
To:     Tao Ren <taoren@fb.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>, cov@fb.com,
        Tian Fang <tfang@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2018 at 06:39, Tao Ren <taoren@fb.com> wrote:
>
> On 9/20/18, 8:46 AM, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>
> > Actually this is much more intuitive too, it is the typical way to handle
> > a down-counting timer. Good catch!
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thank you Linus for the quick review!
>
> > Sorry for any cargo-cult programming on my part :/
> > Would be nice to get a nod from the AST2400 users that this works
> > for them too, so included them in the To: field.
>
> Make sense. I actually booted up kernel on qemu-palmetto (ast2400) but I'm doubting if test is valid because it depends on how qemu emulates the hardware. It would be great if someone can help to verify the patch on physical ast2400.

I gave this a spin on the ast2400. It looked okay, but I was wondering
if you could share you test case so I can run the same test?

Cheers,

Joel
