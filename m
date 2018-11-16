Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520EFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B1D2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 17:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMTx/d8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15B1D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbeKQD5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 22:57:20 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:45084 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729140AbeKQD5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 22:57:20 -0500
Received: by mail-vk1-f194.google.com with SMTP id n126so5424166vke.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1d5YZpaaiU29VzqjlaqygfUagMt9MbEcWEj4MwojAa4=;
        b=mMTx/d8GWJecC48aO1aaGvhtLb9jl2hTLkpvOzSd7jTiUZPTrEleYNETQiQcnavN/a
         aB1o3mOEkn2Uc1D1G1TDA1C+u5OxvxwLgdpFeEAneEOv4o7Z+CCeeEiGhm2zGq4ai19o
         frQsE8vW63s9ukNYVEYfqeYr/MnIawYrGZaX9sPVd9nMMIUmp535HbVy1zj9U6hxLDoN
         OhrvX2ufshqYZj7Py3w+pql+dCw3+5MkEz5UteaQBzHSA+C25YZBfXVLwngvPPYNpwSy
         WBZN+kLU/sYdT0jv6SyTmeDg1as3iVE+c93cAsiCf/Ne+ZQD1/yRj/brkGjxdBJbuJfH
         GjdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1d5YZpaaiU29VzqjlaqygfUagMt9MbEcWEj4MwojAa4=;
        b=KBN68Dqjo+/tvE/DwrlJ3nAyEODrMnzFw2muecI8XgCzvwaa5A565AGe0mK/cundhf
         3b2LP5jUILy6ciBHgsv4ZaUrPZ5X6Rxr2Y919OujL+t/zuMAAW8odLsmfNOPG0Zaw02D
         Wmxeg/p3zvQ6aOywyojxAW36tbtZaka7SSwbyaF+Sf2CPWqsJrL9WcYdzYRr8jid0ihG
         koUMLNlUH10vYTi9cxsZHsfYrSLTzMmfaGqemGyCTi2OsrqGFhG95cJFkG/YYTdXbPsw
         S9VZVAGPOlxC6DvEEL52RyjSCekGXtSktNgPPtRPdxqYUf/KIWLr4dfgWd0NTHP7EKge
         7Gaw==
X-Gm-Message-State: AGRZ1gLtq/8QXQlEi5CzVjM/RphsLT6FhEwY9GFS0U9DT9tjPITZEMOH
        k68EIfKmFiGtGpgVn0rY4+98gUDfk9mJG6y3jHs=
X-Google-Smtp-Source: AJdET5e8M5Lt54roHu4riHu14D6PRjZN3RbpIqbNhtAKclrNM7vYa4rQtn57U7ZjYuQAVzFC+iwhXUKxnCWnLpiKUtQ=
X-Received: by 2002:a1f:6184:: with SMTP id v126mr4849566vkb.69.1542390239546;
 Fri, 16 Nov 2018 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <CAOuPNLiLj9be5iUdpUiLqiTge-xYY_v4_VLs-ah2_PygG7vxdg@mail.gmail.com>
 <28496.1542300549@turing-police.cc.vt.edu> <CAOuPNLj8wj=tPJo8L3oS7o8iTQcyhZ0W-GH6xmP_GsG4r7YdAQ@mail.gmail.com>
 <49219.1542367988@turing-police.cc.vt.edu> <CAOuPNLg4tM6Cw8Yf9rdpkBOU=+Fh654yFQeAhJf1y88Gb3MAew@mail.gmail.com>
 <5997.1542386778@turing-police.cc.vt.edu>
In-Reply-To: <5997.1542386778@turing-police.cc.vt.edu>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 16 Nov 2018 23:13:48 +0530
Message-ID: <CAOuPNLiX0zhxiRAx03YjVU6cocwWbgY9naxeYPRKmT+3PoGhRw@mail.gmail.com>
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

On Fri, Nov 16, 2018 at 10:16 PM <valdis.kletnieks@vt.edu> wrote:
>
> On Fri, 16 Nov 2018 20:10:28 +0530, Pintu Agarwal said:
>
> > > Look at the code controlled by '#ifdef CONFIG_DEBUG_STACK_USAGE'
>
> > For example: is it possible to keep storing the irq_stack_usage (for
> > each cpu in a variable) information from boot time, and then use this
> > variable to dump the irq_stack information, after the system booted,
> > may be from proc entry ?
>
> Congrats. You just re-invented DEBUG_STACK_USAGE, which just keeps a high-water mark
> for stack usage.

So, you mean to say, my implementation is good enough to get the
irq_stack usage, from the interrupt handler ?
But my concern is that if I dump it from irq handler, I will get
information only for the current cpu.
How do I store and get the information for all the cpu from the boot time ?
From where do I call my dump_irq_stack_info() [some where during the
entry/exit part of the irq handler], so that I could dump information
for all the handler at boot time itself ?
Like I would to capture these information:
- What was the name of the handler ?
- Which cpu was executing it ?
- How much irq stack (max value, same like high water mark) were used
at that time ?

Where can I collect these information from the boot time ?


Thanks,
Pintu
