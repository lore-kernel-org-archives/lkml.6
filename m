Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F1C31D64
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8523A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdW6yClj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfAUHR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:17:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52713 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbfAUHR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:17:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so9693464wml.2;
        Sun, 20 Jan 2019 23:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mjucR6CjAKB/oZPowyqDWMqmkQFXb/O28LP7fy8eQto=;
        b=qdW6yClj17Y2yLEVt6gROToTyccasjHt2D3dLjNr2R8RGnXusFOMUO7fbZWl/hcrOy
         lenBIsKbsPGJ1osbfkfXGrxJm/8IRzrBwjxEo2ivqCHbOOF0z3/3t4eZ1H7EAgACGmOV
         5GVqrRVTYLa/6qbZrUXryRmcohB09que06AShydcUOlu4xkOOJLjzCXtfIDNyjBLgi66
         GPNqpEVe4RC52f/SvH0JYMZUk/83dgWFDBpLSqRj8Rr3nugVddoutpaluwj7vH6YeWsD
         XQm6kgHYJUsG+XEwBwI3eVCBhi2lYCNNwVxanwN/TgFJlUEtrHFGWZ+gj966lTY+jDHR
         k3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mjucR6CjAKB/oZPowyqDWMqmkQFXb/O28LP7fy8eQto=;
        b=PaBe4h/2pMxUpyFY1grhNVhUfacrgtuzphTpyqJ55FusvHUwsISp9C3ozRXr56e/i8
         60El80SoLe4S/o+jgQQRq4WDL5XoFFTvfUs857JpiAju65JOHsB55oTBDV0NngT+ECZ7
         fRwalZYmLDw0XJm2gBZR2CIxZ9/Iapl0M4xdQNXH5ExrkjkKM64XRJXlzz+tCZaLbOn9
         fezYodCb2vT0R6Knhwteg3X+aXdEbHSegXgL9YBdVkXYJApLz0+MuXc0HMAAn1N+r/8C
         wYj9xLWSgPanJB7IR1iHDdLqX8LT2qPQKxUKA/YLkl/5TsdM3kzrMG+G54zOv4UHCTKN
         TABw==
X-Gm-Message-State: AJcUukfp5eIr+5oA43/6G26MdMrKJHH7V6Hl5y3Ct/Nb/daizn5gvYb6
        4RA9rpmctk5pONbopYQ9ms7LD36/NTQOMhk1uVPCZw==
X-Google-Smtp-Source: ALg8bN7BP7+s3xdf8diWvoxK2GWFipb2aadX2E4QPZ99KIkA4uyCVlSiwjU3ZN4xjbH3fCk4Y42zEMQtYYsbHdasI5A=
X-Received: by 2002:a1c:bb04:: with SMTP id l4mr23437754wmf.142.1548051078579;
 Sun, 20 Jan 2019 22:11:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1502103715.git.michal.simek@xilinx.com> <72d3cd83bed792a23ab60cf9b6d51b618f5aa084.1502103715.git.michal.simek@xilinx.com>
 <CACRpkdZE-Edr7fWZY5VQM1_65iw7MYGP-iDa2ExZsPxpM0rurQ@mail.gmail.com>
 <6da5fd79-fbc8-b613-954f-dcbe2ef8d6c5@xilinx.com> <20190107164210.3ecf37e8@windsurf>
 <CACRpkdafBpC14TxBNVN2AemkBz-yKkXkKfNpdgkYKQX3qFemag@mail.gmail.com>
 <20190111135413.73dad0b2@windsurf> <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
In-Reply-To: <CACRpkdZVfH_LYQov5mkMvp6BWjkVsisawWuE1PMp0b8dW5Qc=g@mail.gmail.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Mon, 21 Jan 2019 11:41:07 +0530
Message-ID: <CAKfKVtHrh8r7kp=2br6OCKgWgsNmd5sVG2C96QnhYSFDj7B_+Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] gpio: zynq: Wakeup gpio controller when it is used as
 IRQ controller
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Nava kishore Manne <navam@xilinx.com>,
        Josh Cartwright <josh.cartwright@ni.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        Peter Crosthwaite <peter.crosthwaite@xilinx.com>,
        Borsodi Petr <Petr.Borsodi@i.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 8:26 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 11, 2019 at 1:54 PM Thomas Petazzoni
> <thomas.petazzoni@bootlin.com> wrote:
> > On Fri, 11 Jan 2019 10:54:20 +0100, Linus Walleij wrote:
> >
> > > My stance is that the driver is responsible of enabling and managing
> > > runtime PM for its hardware block(s).
> > >
> > > Runtime PM in the core should only be added if the core needs to
> > > be aware about it, such as is the case when e.g. a block device
> > > needs to drain its write buffer before going to runtime sleep.
> > >
> > > I fail so see why the GPIO core need to be aware about this.
> >
> > In this very same thread at
> > https://www.spinics.net/lists/arm-kernel/msg600515.html,  you kind of

I was not abloe to open the link could you please let me  know if I am
missing something?
