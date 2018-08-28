Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC7CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4025220852
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Q5boRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4025220852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeH1QVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:21:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39937 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1QVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:21:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n2-v6so1406053wrw.7;
        Tue, 28 Aug 2018 05:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9MVLl9QPlzFcIzhOf5KGkGxqZQ9OwmNB+AbR1kltMw=;
        b=o8Q5boRcHiR8IQxyxn+de7uytXc8M8Mp3oqBSPDbPhJR+yMaV2xFghLrrbyeMfaKkg
         HSEsRDlWu9dt8vjkuaTmS7tMliQbs3Q5/f7fgQT07KUyPTUHxS0xZHXhJ8IK4Xl8+T5R
         lA21q+SRWgH6aE7PMaQ0g1N05NUq6LjXMvRbkx9etZVOq3WWo5VxIDBegR/ceJIcuEzr
         +DdkurRvwyb+RIU0ADS7L1wHY5jFXvSdclLoViaBsH/JaoVaFHGmMXromks5+6ev9ku/
         gxyHomAzyNHUqNaAwtX8YMf5vkMvxgC2J8EOSWQlSDkelym8YGAvIlBKUKqsDc+yuhf0
         zgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9MVLl9QPlzFcIzhOf5KGkGxqZQ9OwmNB+AbR1kltMw=;
        b=JStU7iKfD7dRRktawqpDCJthdbnFxmZa0m2pGPi8a83cngou1N7I8HXcFuYknopLC8
         iEJkIqcJg0Ksx90EkYucHGOkeDJbcOYt8Pl3inJAJPWweQmOI520tnmNxAdwpLKj9GWM
         isJb15Yxtm9EBvrRh02kewvI//RG8BHoGA9awl+7+ZyMAh/i8ijAL5A9fibaqygkTcrS
         vYpeLUopqFx/LXeUummKetmVXskmpJNbRoE8BPJMtjiuylyat2i8L5LYRBqJVAzESRpb
         rtBCrYkB6TVblf7QvPvQs702hFz46AAuv6ianw7J4XK3K3gibfUgKkr3ufBLIby/S+5T
         uUoA==
X-Gm-Message-State: APzg51DPpApEAwMwlpdeRRwAA+VVSkgWylPcLMA2lxNjDQusWFs4miNz
        IdaEyScyjFNrVo33R/sYRDZlvpLStM9Ret+GGTw=
X-Google-Smtp-Source: ANB0VdYOOJN9pwuGj/mpOFdUZ/GtfQHEEu3JvuJQg/cm1TZWYH4iQNTOoYw+KhsaHcsYhKb5EhHsNBXHRuySVaY66Xw=
X-Received: by 2002:adf:b1db:: with SMTP id r27-v6mr1031799wra.95.1535459416267;
 Tue, 28 Aug 2018 05:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <1535453838-12154-12-git-send-email-sunil.kovvuri@gmail.com> <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
In-Reply-To: <CAK8P3a0q0P-FuG6cTgMNkeZbtXE4pMk1iJq36_x20WRddtwaDg@mail.gmail.com>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Tue, 28 Aug 2018 18:00:04 +0530
Message-ID: <CA+sq2Cc1CSKmuEjKt8psR7Zyv9PzLkN10hzy8mrai136SF4-qA@mail.gmail.com>
Subject: Re: [PATCH 11/15] soc: octeontx2: Add Marvell OcteonTX2 CGX driver
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, olof@lixom.net,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Aug 28, 2018 at 12:58 PM <sunil.kovvuri@gmail.com> wrote:
> >
> > From: Sunil Goutham <sgoutham@marvell.com>
> >
> > This patch adds basic template for Marvell OcteonTX2's
> > CGX ethernet interface driver. Just the probe.
> > RVU AF driver will use APIs exported by this driver
> > for various things like PF to physical interface mapping,
> > loopback mode, interface stats etc.
> >
> > Signed-off-by: Sunil Goutham <sgoutham@marvell.com>
> > ---
> >  drivers/soc/marvell/Kconfig            |  10 +++
> >  drivers/soc/marvell/octeontx2/Makefile |   2 +
> >  drivers/soc/marvell/octeontx2/cgx.c    | 117 +++++++++++++++++++++++++++++++++
> >  drivers/soc/marvell/octeontx2/cgx.h    |  20 ++++++
>
> If this is a regular PCI ethernet driver, why do you put it into driver/soc
> rather than drivers/net/ethernet/ ?

No, this is not a ethernet driver, as mentioned in the cover letter
this driver and AF driver doesn't
handle any IO. There will be a separate ethernet driver (will submit
that as well in future) which will
communicate with these drivers for configuring hardware.

The driver in question here is for a serdes controller which handles
physical ethernet interfaces.
Admin function driver gathers info w.r.t current state of physical
ethernet interfaces from this driver
and notifies actual ethernet driver about changes, if any.

Thanks,
Sunil.

>
>       Arnd
