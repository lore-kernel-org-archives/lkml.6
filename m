Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E2CC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA2E23F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 15:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rbuTm6po"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DA2E23F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932908AbeGFPdA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 11:33:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35716 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeGFPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 11:32:59 -0400
Received: by mail-it0-f65.google.com with SMTP id l16-v6so17689922ita.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 08:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/yTcA3+9pmgZnLasSeVQKdOzYE37cexTf6jRxVy3/Q=;
        b=rbuTm6poSllFs8ODNIYuw4fRvVbiiCabErGusqMThe60CuU6mlf5smw4noxDaZ02gy
         iktuFlFCHE+FZH9QT2epLCWp1H+jXySJcYl0oDpUM6Q4YzHI6WHpb5KPW5qPA3Ki7JKY
         ugF95tihkYfp5ZeQzDwT1D7kbsoTagF4k3o1V+W5me/Skagx/0jztNY2bZ4dVQh2mi0d
         fAiv5wU2etizuTnlT9IGJbVc+FC91IM7OiqfhOw/HZdQw5NNxn8OTS2HGlnjc3Bt8Epk
         ErSQgO+pupfylkQ72SXS6ZtQD6lf07njZ6EdpoZ3OdqEoH/C7ufnOBj51/qOvwclduHP
         x14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/yTcA3+9pmgZnLasSeVQKdOzYE37cexTf6jRxVy3/Q=;
        b=cxTHfgl9NRtmvzHzAOgQx7YjoIZrIAcgO6b2jI03mLqApKo27pId0w+zDO6eDudp2u
         pdKP30JDvjpkjJO+5C4rr3/DqcssOON6AseP8CQC2Z2zq4He3tY6D/+pt6romq88zGzM
         KO+74qz65SciWqJ6eGMNlDadEHwAuyNxVsz8+/AOXYkzfaeU8vuAes3qjCqqWC1lx0f1
         /PxR4P/tLbZIhFO9LYF0XSBPWrIGD9j6KIMs1LbserodzEV1Cl1Hp7SiuP//Ux5Z/rwt
         uXdlOAFnvgwFk7k4UvhLOJnmjGpmMLWqe7WTkILYoyLumMl7QbznnWATPxaLA4o4Yb1F
         6z4Q==
X-Gm-Message-State: APt69E0EmU2LINZsyaUxjrunW0f3vYSxbj0fcJ+LKFqX8x444mEKAHPI
        6fYDsImlaDg3J0TgmBg/uozKTwcC8W50/aHlzEg=
X-Google-Smtp-Source: AAOMgpeu+8UJDXomC4PkQ42kspr7129F94XqJSMOz5A5vgCV+VPoNniK/vivjLl66+DiT0HurYTn2bgKgzSCw25aANM=
X-Received: by 2002:a02:a0c7:: with SMTP id i7-v6mr9003016jah.105.1530891178410;
 Fri, 06 Jul 2018 08:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180526193523.3896-1-mattst88@gmail.com> <20180705221731.fsrkt5zu453zs3b7@debian>
In-Reply-To: <20180705221731.fsrkt5zu453zs3b7@debian>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 6 Jul 2018 08:32:46 -0700
Message-ID: <CAEdQ38EcNTgfFaGVzVS9nFbBorVCKsCSuZvWDFakn6PfMCLDWA@mail.gmail.com>
Subject: Re: [PATCH] parport: Add support for the WCH384 4S multi-IO card
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sergej Pupykin <ml@sergej.pp.ru>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 3:17 PM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> Hi Matt,
>
> On Sat, May 26, 2018 at 12:35:23PM -0700, Matt Turner wrote:
> > This Multi-IO card has one serial 16550-like serial connectors. Here's
> > the lspci output, after this commit is applied:
> >
> > 01:00.0 Serial controller [0700]: Device [1c00:3470] (rev 10) (prog-if 05 [16850])
> >         Subsystem: Device [1c00:3470]
> >         Flags: fast devsel, IRQ 16
> >         I/O ports at e000 [size=256]
> >         Memory at f0100000 (32-bit, prefetchable) [size=32K]
> >         I/O ports at e100 [size=4]
> >         Expansion ROM at f7d00000 [disabled] [size=32K]
> >         Capabilities: [60] Power Management version 3
> >         Capabilities: [68] MSI: Enable- Count=1/32 Maskable+ 64bit+
> >         Capabilities: [80] Express Legacy Endpoint, MSI 00
> >         Capabilities: [100] Advanced Error Reporting
> >         Kernel driver in use: parport_serial
> >
> > This card was already added to the blacklist of 8250_pci.c in commit
> > 72a3c0e4e662 ("tty: Add support for the WCH384 4S multi-IO card").
> >
> > Cc: Sergej Pupykin <ml@sergej.pp.ru>
> > Signed-off-by: Matt Turner <mattst88@gmail.com>
> > ---
> > It looks like CH355_4S is similarly missing, but I don't have hardware
> > to test.
> >
> > This commit makes me wonder if I'm missing something -- how could
> > anything have worked after commit 72a3c0e4e662 without support in
> > parport_serial?
> >
>
> Is the patch still needed to be applied? After Andy's patch to tty tree,
> the device (0x1c00, 0x3470) will be probed by 8250_pci.c.

Yes, Andy's patch replaces this one. It can be discarded.

Thanks!
Matt
