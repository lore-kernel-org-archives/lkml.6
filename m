Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C778C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BD2720868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvq8fz1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BD2720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK3Aua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:50:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42470 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeK3Aua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:50:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so1937764qtq.9;
        Thu, 29 Nov 2018 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPE++abUIPinLyz3aCs7KBoJdm0F6D8C2hEgtvtJAp0=;
        b=Wvq8fz1kZYX/E6oey2g6bYxANsas6kfe6geZ+++CjfglXwGXXopPOa6ObRqQf/ORVM
         /mOlGK2w7kJFswwpsBtgB/1ss3GBepV62wrLAl1Fn6c3m0w/GaB8Z0AbLyrT54ILKmNd
         YvZocInX/nzFYQvrS9s5zx7aKSXZgb4gOzlnokUvcfTs7yiNyG6WLM7k4h5ZZgBlKdLv
         XjZ3v4hWCIZxfWhGtwUaaLnbG7Bk8aP2LKsQQXjYUCXLCk1VK/CC3jhIq8trbZvRx3a/
         kCqxVeXNDNZRHpb2Hoa3uK6jjwUqFCfDZMWTYGkqi/SBonGZcRlRBIrP5KEdSnM3Xzd6
         NXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPE++abUIPinLyz3aCs7KBoJdm0F6D8C2hEgtvtJAp0=;
        b=oqEtTOGu7OlZrWP6dw+wlaKbsyI71iwtCWyMtWiaeWdkY5lkW0I0uxEqr1bFThfNTp
         okxGnb6Q2AUVT1U2LlEj5DZSzURd6CEohOqRjnx9nQ4JA5dOvgcpL1yEC14uMZ7RGmMK
         3pqdf172uNs9JNXDw+puoY3fAVxCzhUSX9ete+ln1dgekxCksrVIKBZ6FXmnIsc5YCGG
         PF7v6y8yVsvqDECz79cKHr+HjZeLZVO0NjQS5st3Z3m6khyKUre/bwTJVW5qVY/zPj9M
         t913oRYu+w7CWUakWGHvyTXgmosBYLlpZXcaWC/lsyaZmksxXF5TBYZc+niRWSt/l642
         paxg==
X-Gm-Message-State: AA+aEWZpeYJ9Mb808rcfMXASYSHLbiuWWCUHWAtadxDrxOvlb0+ST68I
        MWEVE8JYpYB1vi3I7Viw1UpgJrx7/9pacM0JdiTTU1qD
X-Google-Smtp-Source: AFSGD/Wlucbkcbr7j05D0M9AuaVWfRj5NUWk+R2ykYkua+SRqHx2nJal7KlgkMIkPSkV9KwNkBCWsq6OsW4LB3t6gic=
X-Received: by 2002:a0c:c2ce:: with SMTP id c14mr1454068qvi.7.1543499104678;
 Thu, 29 Nov 2018 05:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de> <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
 <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de>
In-Reply-To: <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 29 Nov 2018 15:44:52 +0200
Message-ID: <CAHp75VcKu4fhP8=NH7fgfSFCh6xdCLWrNLcsHSuWvMcW+irfmA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:15 PM Florian Eckert <fe@dev.tdt.de> wrote:
>
> Hello Andy,
>
> Thank you very very much for your code review "again" I will update my
> patch set with your hints.
> Should I send v6 or should i wait till I get feedback from you about
> ACPI?
>
> >>
> >> Until now it was not possible to get more information to detect the
> >> MMIO_BASE address from the ACPI subsystem.
> >
> > I'm sorry if I already asked, please, remind me where dump of ACPI
> > tables can be found?
>
> https://www.spinics.net/lists/kernel/msg2887290.html

Unfortunately the file had been removed.

Btw, is the statement in above email still actual? "...I can fix
required things."

> > Also would be nice to have the output of `lspci -nk -vv -xxx` on such
> > platform.

> 00:14.3 0601: 1022:780e (rev 11)
>         Subsystem: 1022:780e
>         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
> Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
> 00: 22 10 0e 78 0f 00 20 02 11 00 01 06 00 00 80 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 22 10 0e 78
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 04 00 00 00 d5 ff 03 ff 07 ff 20 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 0e 10 00 0e 00 0f 00 00 ff ff ff
> 70: 67 45 23 00 00 00 00 00 90 00 00 00 05 0a 00 00
> 80: 08 00 03 a8 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 02 00 c1 fe 2f 01 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 04 00 e9 3d 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 80 47 10 82 ff
> d0: 86 ff ff 08 42 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Thanks.

--
With Best Regards,
Andy Shevchenko
