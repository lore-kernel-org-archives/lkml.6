Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D269ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB012150F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="YKE3Fzm9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB012150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732264AbeITWED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 18:04:03 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33425 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbeITWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 18:04:02 -0400
Received: by mail-io1-f65.google.com with SMTP id r196-v6so8016425iod.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kR8AxUlsmMq1U3xqfbo1SQiC65mgudSaCsQg4gaXPDw=;
        b=YKE3Fzm9H96zD0uPGFZ6aryY5aQU2vHDfMgMBNvA4VszDSe19hniC/jKvyJQyZ5dgL
         dXGsnRiKl5xlDvLe0hIUyBcenKKIcTD+UhkvfrgJKB7n0cTvV16e62SwMs7KWdzwRw+o
         8OCeV6CDZZBgAwdhw7AELYR1VdrrMYp0KhbNjD+kHKAIiCFGwAu2/RY2YCSLYsVfI1QY
         lNczzFok5o/M0s2KzdXFVEsUEUJ5QE+x1ytR4hNze5Dc2+n5FZibIuXAYtUcnwwAAAbY
         8Zp6/8BXOuhBub5MRBXcWhn1+C+YLY92OgfweCD1dg7hJ6S5ySy3CHguBXfoJA71MIx+
         Ed8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kR8AxUlsmMq1U3xqfbo1SQiC65mgudSaCsQg4gaXPDw=;
        b=DOIOb9QVMqlFQ3v1fBiLwem9MGvNfQj5KVDqmfua4CDRl+74lNx9lQlZ/P1dXv7/rT
         X7vk5Rekapa3zlbx+JtL0ob6uX2pwcsbol39CdsrnLgZvmxRfJE4zTz7eS7NaahJsFyx
         ExhM/MRSJGYlBdr+OhAKheQwLqa7AYt8XRfn6AH+81qyZ1NeSUOoo1/Xp6hQi50rDJuQ
         4AeVt4YGwDQPPCNt20xa4ohFLayNaX1DHh36WWhDZurQXvav2hgxgAh9xhXbkwVEsv6t
         p56lHRW8cs35shHTuWou94xd6eRRxS4ZPAOMxDe7nWL3vUIr1lMLDqSfGD+puxmHlPEC
         PkPQ==
X-Gm-Message-State: ABuFfogLrOA1NuWrP6gwhN1wcdCUETvkjz3I8W1/eqjkV8iD6NKR+33v
        tQgB30yZfsjQnpsXzpQyWT5B0XvHj+0N1DY3aps4Yg==
X-Google-Smtp-Source: ACcGV614sFYK2tnOjJoqav83bVAZXV1aVpi5JvNoMxxGCYSSZU3wQjQX3vMYv10SpeGGwYwP86404sDEXKSpRmFqiVs=
X-Received: by 2002:a6b:6401:: with SMTP id t1-v6mr1761496iog.111.1537460387869;
 Thu, 20 Sep 2018 09:19:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1905:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 09:19:47
 -0700 (PDT)
In-Reply-To: <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org>
References: <20180827090651.25062-1-brgl@bgdev.pl> <CAMRc=McWre+5PRuozF69YKONvzy4X31=MzZim-QjhaAZ9iAVTw@mail.gmail.com>
 <9963d3f3-ba14-0d18-d669-53fc79b783c2@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 20 Sep 2018 18:19:47 +0200
Message-ID: <CAMRc=MeC8gwEpjNf5AEX4oocHYv8c_CJXkCDMM9CQvaqxrbdXQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 0/3] sh: make early_platform code SuperH-specific
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Peter Rosin <peda@axentia.se>, Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-09-20 18:09 GMT+02:00 Daniel Lezcano <daniel.lezcano@linaro.org>:
> On 20/09/2018 15:00, Bartosz Golaszewski wrote:
>
> [ ... ]
>
>> Ping for 4.20. This is the third release cycle I'm trying to get this
>> merged and there never were any objections.
>
> Thanks for the heads up, it is in the pipe.
>

I guess you mean only the clocksource patch?

Bart
