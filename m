Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3AEC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F33C259AF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 00:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkShh/J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F33C259AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeF1ABF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 20:01:05 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:35228 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeF1ABB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 20:01:01 -0400
Received: by mail-ua0-f196.google.com with SMTP id g6-v6so2410914uam.2;
        Wed, 27 Jun 2018 17:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=exljcUJDBqIXCaPTpAqCskaGWFmcbsRKkSM4gW5W5mw=;
        b=jkShh/J89VNuaGv6CC7onDea3y/ZI5V4RAOlNxZ4B9VxhI8JIX1H+LQGUikm40i3vL
         sFGsH4lXUaf46aEUqbUTLhxaI0Fwyw5XIR7tt7XebmrV/ERzpSAMnzx+6LvM3CelRtCY
         O8iE7TMWxOzwPVMBVVwnBWz0dfZdAePFSUpzl7NSj95dCpY1fUoyKu2GEh2A7CSSxwNy
         xtr1Frn6b33bmJtLpB+DV6nYB5jotVTisHPcGqv7GhQjeS77FRtkA4a6G5NWIC80gmrD
         s6knEcgb1lUMItleWD/u/AKIk8gPMBN2gZ9Ex4GrGMvLV+gO92xtYEytClVAtEDQRyHY
         vw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=exljcUJDBqIXCaPTpAqCskaGWFmcbsRKkSM4gW5W5mw=;
        b=uUj9BymCe/emxptMG6ILqKML5u4AJZXivfMCpiZG3abIRk0EsI2JRebki+ogObSQvr
         xg/zf+dnDun2JltKXip0NNHHGX7ISsXzwtWEe8iyo+URwSue9NB804pBaVBAxqYTRF5l
         nr3PskqAVz5DtnVLPvJBb1x5Ey1Z577ul8DPkcnBnevu3IzFSqWM/FaXL0S0+q3AY8u5
         kWAH4iZTKZAX6qqYEHeY2I+KwRJDV1McG2LeL5/M8j7gl7SuThVWwyt1RCxvezix/vlw
         HQZequR8VI+aTxiXu+6K1o+hQh026PNtSLhzycHD8ZtHSK+BSPP27j5LvKNQg6H8KAzq
         er9A==
X-Gm-Message-State: APt69E0tx9vTnTN+ZPrli/5/DJDzc5rO0ZXbI6s7rSUGgKp3mhMVODaX
        0s1+FJhMzGjvKa6+cjfKwgcNdKProFcjlZMe8NdzC9Vg
X-Google-Smtp-Source: AAOMgpeGTDkkNYzj5n39ZFGdPoJIH/f4PBXmL9e4tLiRBeIKl6ZQdbHacp4aub3R9eFWDjF+j0a+Dr7ZTrUm37mcAyk=
X-Received: by 2002:ab0:1446:: with SMTP id c6-v6mr5189175uae.12.1530144060655;
 Wed, 27 Jun 2018 17:01:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 17:00:58
 -0700 (PDT)
In-Reply-To: <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
References: <20180622104930.32050-1-boris.brezillon@bootlin.com>
 <20180622104930.32050-10-boris.brezillon@bootlin.com> <CAHp75Vdxg49q6aQj0dDpzM4q2WnQbGoCECWR1roda7aMR+u4gg@mail.gmail.com>
 <20180626215648.1472b96e@bbrezillon> <CAHp75VcVvOzgOM87rSrwsCxh+WAK-z+zVCJifnY+Xeeu=cPFiA@mail.gmail.com>
 <20180626234638.076fb816@bbrezillon> <CAHp75VdBXj66Yd6sQHOWz19R9MUtYMSeq4j-+UidLedpfkB6mA@mail.gmail.com>
 <20180627213617.51e10712@bbrezillon> <8bf36e4025b6ec5198a668edda6bcbef3b06e97b.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Jun 2018 03:00:58 +0300
Message-ID: <CAHp75Vd5ucaeOD4S76ANcOVUA=QrCpGNAmun6+ihnsOTsgtcKg@mail.gmail.com>
Subject: Re: [PATCH v5 09/10] gpio: Add a driver for Cadence I3C GPIO expander
To:     Joe Perches <joe@perches.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 1:54 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-06-27 at 21:36 +0200, Boris Brezillon wrote:
>> I mean, kzalloc() is not deprecated AFAIK and I don't really see the
>> benefit of using kmalloc_array(), but if that makes you happy, let's go
>> for kmalloc_array().
>
> kcalloc

IIRC in the original code kmalloc(x*y) is used.

>> I do run checkpatch --strict and fix most of the thing reported except
>> those hurting readability. I don't remember seeing checkpatch complain
>> about kzalloc() usage, and I guess it's not smart enough to detect that
>> for_each_bit_set() can be used to replace the "for() if (BIT(x) & val)"
>> pattern.
>
> That would not an appropriate conversion suggestion in any case.
> coccinelle could at least look at whether or not x is allocated
> as a bitmap via DECLARE_BITMAP or bitmap_alloc

Huh?!

bitmap operations are working against unsigned long *. one long is
also a bitmap.
So, that coccinelle scripts must be fixed accordingly.

-- 
With Best Regards,
Andy Shevchenko
