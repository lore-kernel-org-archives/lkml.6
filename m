Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F13C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71B520851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MuYhMyV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71B520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeKTSik (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:38:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41875 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbeKTSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:38:40 -0500
Received: by mail-lf1-f68.google.com with SMTP id c16so673650lfj.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y8nfLChzKnGj3dmxM0axPkYOOwmnJ0y4626FmiTrPo0=;
        b=MuYhMyV9UU1QfmOzGer0nZp6DvyI6atmdcXESs9wq7xg1bqYTiV1m5l9x3Pu6XEb+a
         IRQO1/flovSGIYwOs38IeFs33yN4XAhYxMp52M447y3olWG6empT30Rsr1+sEfF4bLlF
         7Hsrnb3rUUcydkjESRV+N1lngw4f85W34ctog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y8nfLChzKnGj3dmxM0axPkYOOwmnJ0y4626FmiTrPo0=;
        b=kounGSlGL7q0Tcl1QAiu7PxEuGdUekeWCYIuxnwBT55pbN/8Z1yj3cu5o+izo7EsQs
         twefpIn1ttDJD83I8okYj0yV1pZsEVGkmgzLC2TwwKgIuJYvQ4Mv2i0QYkwgzuJ4Vkbw
         jwM4mreGmbw9YN/5DA67Nk4N8noxg3x0Wl5cxFxqpL9YUVI/Lul0PC57rkgYVlQIGua2
         FpdC+5q3iiEuQW+bSE5+P86g6aHiY0XaDrhdJQALNYGcP+OzSrKbM/dS8YEqH3IudgM0
         TecaR3rXyS7koHyFZGx7cDGNPUDPbOBbWNHPaZhzGGYR3swLqSQpHHa/QvbNPXGxaZd+
         9aUQ==
X-Gm-Message-State: AGRZ1gJYcs3Sd+tJx8/SrWMbZq6BrqJE/CBMiyUCjE96+S6XX6+Vj1Ex
        7CcmEpbSGuHhBLcBPEd/YfqlDKrcAIeIr9UkLxA8Wg==
X-Google-Smtp-Source: AJdET5eH7SolhSvjVYPUDayQJx7GnxntHRdYzmhwrwd4BzZ02zlM7XcZd0LIdRX4NxZZZ2sjpHfm91dzdEAU0IkGIOg=
X-Received: by 2002:a19:f813:: with SMTP id a19mr533532lff.67.1542701448664;
 Tue, 20 Nov 2018 00:10:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au> <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <b94b3aed32c0ae0f5de786ffc746ffb20fbe2d1e.1542589838.git.fthain@telegraphics.com.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:10:36 +0100
Message-ID: <CACRpkdZOoA8y7nAmE2JAQT8QgfNSpzXPVdjZfDBrnsy2jmgW7w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/14] m68k: atari: Convert to clocksource API
To:     fthain@telegraphics.com.au
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, schwab@linux-m68k.org,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:22 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> Add a platform clocksource by adapting the existing arch_gettimeoffset
> implementation.
>
> Normally the MFP timer C interrupt flag would be used to check for
> timer counter wrap-around. Unfortunately, that flag gets cleared by the
> MFP itself (due to automatic EOI mode). This means that
> mfp_timer_c_handler() and atari_read_clk() must race when accounting
> for counter wrap-around.
>
> That problem is avoided here by effectively stopping the clock when it
> might otherwise jump backwards. This harms clock accuracy; the result
> is not much better than the jiffies clocksource. Also, clock error is
> no longer uniformly distributed.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> TODO: find a spare counter for the clocksource, rather than hanging
> it off the HZ timer.

Yes you already see the same as I see: this chip MK68901 has
no less than four timers. I bet the kernel is just using one of them,
out of habit.

By just setting another timer as free-running we get a classic
and clean Linux clocksource for the Atari.

This is however a very good start in untangling the mess
(as is the whole patch series).

As with the Amiga, this chip also has an RTC clock that should
go to the RTC subsystem, naturally.

Yours,
Linus Walleij
