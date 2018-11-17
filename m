Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183FC04EBF
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459D820825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 13:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgP25Hxo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459D820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeKQXXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 18:23:03 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36625 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbeKQXXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 18:23:03 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so15328151vsc.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 05:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ATNYsZQD9kqFrtWh2QrnOAbT12lJv2SDV+L9L+hhtQc=;
        b=ZgP25HxouxcGTqR7fmuyzHOcFg2a6Gtc9rKQFwcTkg9iMGlf7cX4vGyjto+P2HKWrO
         qQA79g4vyfT6hDTAjxeOCm1Q24Rlmu83sLuCzNts59WUIU0hH4WxG1K2lCIETYeXGhz5
         dNGMR6RCCcKS6Z8FO5XVZGB8pd8rrjUJ7q08nrwC8Ad3RBRGwHhobKHRJ84nPMgIufII
         Ia66Kx+aQHkIMmwuq68OD/0VQPIT+tiakFdstnqRHmGFrNLMtzFWukLSzHg3w6MllSpF
         mBTTE4L+k1z+dRFypL7/7tMgQ05s+49np87qy8B8kHmEmwmhmIYGdPk5bsUjLPNmyc+p
         HOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ATNYsZQD9kqFrtWh2QrnOAbT12lJv2SDV+L9L+hhtQc=;
        b=XfMITd9nQRWY5F6kDNjo5/D9ir6t7PTK00CIi7PhDDMx3UG/Qf8+CnnF0XyxcU/ZSu
         50yEiqxzrMblmxxN9yIW6LjJmCsEvlVfy3f8d0KUkpBpFtFOMeSDwMZKTZH3DwnvOhtY
         ODmQ3cTvE9HjGrGp0SdDE8W7eX3YPzuiqD3c/lvLapZQsoei4tT/ogeDUDvCJgLFScd3
         O1s9c3cTKs2UB2yzvTqWT3BcVeY2/6kWZ0GGjQhBtMKClZHSd18rqKW/WUIVPQk+DV4P
         sg0n3gJSuyucImV/g/CdGan8afFSD+xYZFPzPNexCGLoHLzWqOMnFE/UGuu8XKHlhEE2
         mS9w==
X-Gm-Message-State: AGRZ1gJLVuo+vh/DgY9wNlU0JouTelMrfVkwhEMWCZqP6CTJ12xPXVEU
        02jj3WzDRLPhHutE1u02KI3Z+zwZWYwLZ9ipKXqVICVn
X-Google-Smtp-Source: AJdET5dhARAiXxq81FmYpMl/02AhOFGzBFoiiUNPTvxHfSC56CZhC+LLxasSnumLC3BdYXP1Mvcm/e+uEYqyJENa8mM=
X-Received: by 2002:a67:f756:: with SMTP id w22mr6276718vso.30.1542459984106;
 Sat, 17 Nov 2018 05:06:24 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu> <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu> <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
 <15703.1542393111@turing-police.cc.vt.edu>
In-Reply-To: <15703.1542393111@turing-police.cc.vt.edu>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Sat, 17 Nov 2018 18:36:12 +0530
Message-ID: <CAOuPNLiJmtXft6g63oATMrrrcd3jQGCfxsAzXLx8Kz=_zsR4Kg@mail.gmail.com>
Subject: Re: [ARM64] Printing IRQ stack usage information
To:     Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        kernelnewbies@kernelnewbies.org,
        Jungseok Lee <jungseoklee85@gmail.com>,
        catalin.marinas@arm.com, will.deacon@arm.com,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        mark.rutland@arm.com, Sungjinn Chung <barami97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 17, 2018 at 12:02 AM <valdis.kletnieks@vt.edu> wrote:
>
> On Fri, 16 Nov 2018 23:13:48 +0530, Pintu Agarwal said:
> > On Fri, Nov 16, 2018 at 10:16 PM <valdis.kletnieks@vt.edu> wrote:
>
> > > Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
> > > for stack usage.
> >
> > So, you mean to say, my implementation is good enough to get the
> > irq_stack usage, from the interrupt handler ?
>
> No - your code doesn't keep a high-water mark (which should probably be
> hooked into the IRQ exit code.
>
> > But my concern is that if I dump it from irq handler, I will get
> > information only for the current cpu.
> > How do I store and get the information for all the cpu from the boot time ?
>
> Make the high-water mark a per-cpu variable.
>
> > From where do I call my dump_irq_stack_info() [some where during the
> > entry/exit part of the irq handler], so that I could dump information
> > for all the handler at boot time itself ?
>
> No, you don't do a dump-stack during entry/exit.  You just maintain a high-water
> value in the exit,

Which is the right place to keep track of this
high-water-irq-stack-usage (per_cpu)
in arch/arm64/* ?

> and then you create a /proc/something or similar that when
> read does a 'foreach CPU do print_high_water_irq'.
>
Ok got it.

> > Like I would to capture these information:
> > - What was the name of the handler ?
> > - Which cpu was executing it ?
> > - How much irq stack (max value, same like high water mark) were used
> > at that time ?
>
> First, do the easy part and find out if you even *care* once you see actual
> numbers.  If your IRQ stack is 8K but you never use more than 2500 bytes,
> do you *really* care about the name of the handler anymore?
>

Hmm, yes, getting the name of the handler is not so important in the first run.

> Also, see the code for /proc/interrupts to see how it keeps track of the
> interrupts per CPU - maybe all you need to do is change each entry from
> a 'count' to 'count, highwater'.

Ok thanks, thats a good pointer.
