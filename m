Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1392BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E302082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNuCVMm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E302082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeJZDhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:37:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40888 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeJZDhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:37:12 -0400
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so9243367lji.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UtEoRuWOicMBG3+1eTko7UpBvNBI2OAcvIVV51lt7Rk=;
        b=XNuCVMm/dKVtUCdv7qqiifRuaOg2Y64hfSoDOhY9pGVyRiJy/oZYQwVC75Lo47jBky
         cjcCXq8yvc1AUMHkUahUHQK7/33QQhoYE0nXXxab2gZoiZuz6kxPadkG/ewexI4LFsVT
         SFwIeWtTeZVxi5E44wenuigreLdAJaVcAeVyHJm/HamCjNq4QEgBa8FbUPSUEylVYLq3
         al17ACmbdpFi3U1nHSNHVDCFkoYgLraGJ7acLIVEHBk5e+h660r8E0EnRFV5vqTsLt5l
         KOP8Qnn2Ew69LbhOKVt+XT/LV4R76yDDa/sGQTvOMQT5nR7+am06v0FIqtnIZYdzxgGW
         Yz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtEoRuWOicMBG3+1eTko7UpBvNBI2OAcvIVV51lt7Rk=;
        b=nRJ9CgoicGmZTUvguB25RnMfHaGABUKrDg3bU7FbxuE2egPgTlGXr7FnooHlIMJbNA
         en1VXKM1qPLe5bM/6Zy4CWUXx8anUqp7074H3Jra5aAvwDOlt1pTsZKc6BG5JjYu6fi0
         wANMuIwAvXCdgjeztDk3ac1PHvKzCa1xa6HhC8OlBILTiaeLEKM3uHAKC0nFAWuCx3tC
         IYXBrcjFJFZISVY9b0jrTZgxRFAKBAnIgHGKR/rVRz/kUDOGC5B8MwzGXGidFMUrM8j4
         dgRLkdCKlwnZNI+pEMbQ5lsl2tH4OS78Vq+F/0vaMd9VwgSokVFUTKAZag7qRcFshKvp
         ywxw==
X-Gm-Message-State: AGRZ1gIEWBvDd6/85JfENYavT5A+fBjHHChHeTWPXNCGNjAMMWYQtrCN
        cruop2JWQM7yqWwpuST+T002kw7ieIw7vT2A8bw=
X-Google-Smtp-Source: AJdET5dvHH8KwVQ042TP0Gr1uS2aGiqZ7M1uUfSm4WD+eOjJDTT2bqr2tdXcjgNTFXkk+eUFoLsXt72KsvYvIWqIJrw=
X-Received: by 2002:a2e:5586:: with SMTP id g6-v6mr269835lje.75.1540494190253;
 Thu, 25 Oct 2018 12:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20181025180957.7900-1-f.fainelli@gmail.com> <CAFqt6zYxY+ocQPwNnV3CE7pTrUFniQETcxsq4Dsof41E91L6BQ@mail.gmail.com>
 <9090f6e8-c9c7-800e-707e-07b0033ce166@gmail.com>
In-Reply-To: <9090f6e8-c9c7-800e-707e-07b0033ce166@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Fri, 26 Oct 2018 00:36:27 +0530
Message-ID: <CAFqt6zbFPgiDBV8CEk7sOyb3j_wYYGHZOUYwfK59LHskNa7VjA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mm: Facilitate debugging CONFIG_KUSER_HELPERS disabled
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        ebiederm@xmission.com, Tony Lindgren <tony@atomide.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 12:18 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 10/25/18 11:30 AM, Souptick Joarder wrote:
> > On Thu, Oct 25, 2018 at 11:40 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >> Some software such as perf makes unconditional use of the special
> >> [vectors] page which is only provided when CONFIG_KUSER_HELPERS is
> >> enabled in the kernel.
> >>
> >> Facilitate the debugging of such situations by printing a debug message
> >> to the kernel log showing the task name and the faulting address.
> >>
> >> Suggested-by: Russell King <rmk+kernel@armlinux.org.uk>
> >> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> >> ---
> >>  arch/arm/mm/fault.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
> >> index f4ea4c62c613..f17471fbc1c4 100644
> >> --- a/arch/arm/mm/fault.c
> >> +++ b/arch/arm/mm/fault.c
> >> @@ -173,6 +173,11 @@ __do_user_fault(struct task_struct *tsk, unsigned long addr,
> >>                 show_regs(regs);
> >>         }
> >>  #endif
> >> +#ifndef CONFIG_KUSER_HELPERS
> >
> > Just have one doubt, if the condition is "#ifdef CONFIG_KUSER_HELPER"
> > as commit message suggests the scenario is valid when CONFIG_KUSER_HELPER
> > is enabled ? No ?
>
> #ifndef CONFIG_KUSER_HELPERS is what is intended here, when that option
> is not enabled, there is no [vectors] page provided in a program's
> virtual address space, so accesses to that virtual address will cause a
> fault which we are catching here.
>
> When CONFIG_KUSER_HELPERS is enabled, every program gets a valid vectors
> page in its virtual address space, and accessing that address would not
> cause a fault, since the page is there.
>
> Does this clarify the intent of this commit?

Yes, It's clear. It might be good to add little more description on
commit message here.
But it's your choice on taking this input :-)
>
> >
> >> +       if ((sig == SIGSEGV) && ((addr & PAGE_MASK) == 0xffff0000))
> >> +               printk(KERN_DEBUG "%s: CONFIG_KUSER_HELPERS disabled at 0x%08lx\n",
> >> +                      tsk->comm, addr);
> >> +#endif
> >>
> >>         tsk->thread.address = addr;
> >>         tsk->thread.error_code = fsr;
> >> --
> >> 2.17.1
> >>
>
>
> --
> Florian
