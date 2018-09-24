Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BB2C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B422208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B422208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeIXNWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:22:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38389 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbeIXNWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:22:33 -0400
Received: by mail-vs1-f67.google.com with SMTP id y11-v6so7720734vso.5;
        Mon, 24 Sep 2018 00:21:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BsD9qTRoZMidZCdTdCD62M01JVbmy0mzaVBi7D7eFzA=;
        b=N3x+akrZfI98TFhtCyiZ4GHCW+uFWAVhVSqpjc8VD14FcCmNQp9wnvjUIzFvfa8nn6
         ZoySVior5ls9CdJI8ms3Ka74+rPGwjgKZ4nUctY+vnC7RkakR8W5rqOoFc6rlFOt+XC1
         v1cVq2tp0udQR1RAnIqTBTekfO6pho+0JJDtpWLrR+6z7UwaPLkG+qjN4/i+txaXYeWl
         ENbpvdP0Z6JhS5x3ocQC6GVYW6K/4xw5zYX16ztMcnc/tPgvLChRUazusryvhIonodyZ
         Vitx8CNVv/FXeHza4kX66ye9IeyO85zRvI3vUrtv1lYfLeEDE97tOBC23bB7/79BE1qC
         /yNQ==
X-Gm-Message-State: APzg51BxDGP7gkQ/KHCXeexz3AKBGb6LUIZ9WA7yiTmPUrOW+h6I0gQB
        EW8sWmm4AZ9L9B/uP2RIOt2z0CgMC8bTfUpXgAI=
X-Google-Smtp-Source: ANB0VdZ4ixQ94M/nPkaL/pwbPq8dKLtN9d6Owmyv3BYsxEKFnfvJteZ9Wp76b0NtdYeW1R1dqTEGU1DVp9E5v+5CyZU=
X-Received: by 2002:a67:f785:: with SMTP id j5-v6mr1706129vso.96.1537773710034;
 Mon, 24 Sep 2018 00:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180914143719.GA27689@guoren-Inspiron-7460> <mhng-9d591179-01d4-4a84-a490-8a09d4f3a3d1@palmer-si-x1c4>
 <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com>
In-Reply-To: <CAK8P3a3v0K6G47dAVFtn+XjM3iM7vx6L_RB0mmONBDB9gBNgag@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:21:36 +0200
Message-ID: <CAMuHMdVV0QWXCkkL8dq4UMLaANGMHu7ePhQ83FiFDtynpJzbLA@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@sifive.com>, Guo Ren <ren_guo@c-sky.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com,
        Peter Zijlstra <peterz@infradead.org>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Sep 21, 2018 at 7:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Thu, Sep 20, 2018 at 10:52 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> > On Fri, 14 Sep 2018 07:37:20 PDT (-0700), ren_guo@c-sky.com wrote:
> > > On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> > >> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> My plan was to get that all into 4.20, and then have a conversation about the
> actual syscall table changes in 4.21. If we need it for both csky and rv32,
> we might just change the generic syscall table that way in 4.21 without
> changing all the other ones along with them. I don't want to drag things out
> over too many merge windows though, and my plan was to do all architectures
> together to simplify the version checks in the libc code to only have to check
> for a single version.

What happens with the version checks if it is backported to stable?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
