Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA508ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F87620874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PK2MUEXD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87620874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388596AbeGXRFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:05:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45734 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388413AbeGXRFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:05:39 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so2920954qkg.12;
        Tue, 24 Jul 2018 08:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GtLQonh5oAhrsGLmxsPB2O83fHGjOHRocxp7InBgTIw=;
        b=PK2MUEXDg5kuO18A5oT88Ztz3ApEZjqKiNL+/VSps8CaX0/Eh+VmywDi3t102DNNjg
         5kBPA2/wlmX7sJey5N/2P4L6RfjzaR5zb4ae1f2l1E0okwXmCSPC4kUOCl0B+E/KvkeE
         pqfH9lHODHLq65MUEaHUDAPGlQHm2IauiAJCMywZmh/OKdv9gl8lQaFhcFoDsVpNBYa/
         FFtpSxfvJxuym6ENs/nKulcyewfr3fpL5GIYX9/kgc3SP1RA5T+WP37+ELDdQwepyU7Q
         p9lZ3/Wp+l4TZebkNs1JgSjiKLE2Z31oSALsfGDwsGF9sYNSq7hJeCD9kTpMImxZqkHN
         IcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GtLQonh5oAhrsGLmxsPB2O83fHGjOHRocxp7InBgTIw=;
        b=VpkseIU6ukoiDgdn7WAqaoHu0rlWXE7pVScetL2YpcsyOV4JXanMsmWT9Kk/vWgjcM
         hp5xnOTlA2YlSdiFXO0KfkdyK3dgmcgHsyU50L+xUk5A/14gSkhfumh72yb/ujqhJzO8
         z3TdKrkAKUfMO9PreRTUVoofwsdydjWwb5eVTiOhu/Wb/bKxtVHqdqvwJxzlTXy1rBbs
         LNbLQEDx+/MSHzAIMJtuYnmAzNGcEHkX0/9B+OfwPGF6zwQbdd5qKfsAHqY5RVB1tZ+z
         Dk1EmsJjjGazJ7M8Fh1lpW7sWk2zauyFia4NniDOJ0QejvigNabvR8nj2jIpcnmgKEMF
         UR8A==
X-Gm-Message-State: AOUpUlEw34gMjNUJbLtXqDuhsN/dG7vc3fUOnCZrHYBjC/rYJPCDpUI+
        zUYyeUo1ATrYXA5uZF72fm4eMA2ryDOzuTbQsDgnQA==
X-Google-Smtp-Source: AAOMgpehtOFd63COEi1/fzQR5/mHDMOUM71834TxiKw5xvzIjIoNWTwhnaX3m47Y8edxbo0juvUG7tArlhx5ny3AZ1w=
X-Received: by 2002:a37:5e46:: with SMTP id s67-v6mr15740319qkb.202.1532447910297;
 Tue, 24 Jul 2018 08:58:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 08:58:29
 -0700 (PDT)
In-Reply-To: <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
 <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com> <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 17:58:29 +0200
X-Google-Sender-Auth: 3SWtESwSQAAhXbPkWhHtBzk4s-Y
Message-ID: <CAK8P3a17t=_o04GsowS2RnTwKKVxt8KuJtT36N=Ea-SOq7fTow@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Przemyslaw Gaj <pgaj@cadence.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 5:46 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Arnd,
>
> On Tue, Jul 24, 2018 at 5:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tue, Jul 24, 2018 at 5:15 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Tue, Jul 24, 2018 at 5:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> >> That's not the case I was describing here, I was thinking of what
>> >> Wolfram described with the Renesas SoC that has two i2c masters
>> >> multiplexed through the pinmux layer. I would assume that we
>> >> can still do the same thing in i3c by shutting down the current
>> >> master without a handover, and reprobing everything from scratch.
>> >
>> > The major disadvantage of reprobing is that it may cause visual disturbances
>> > when i2c slaves are involved with e.g. the display pipeline (think HDMI encoders
>> > etc.).
>>
>> Do you mean we should reuse the device pointer and association with
>> the driver even when we switch out the i3c master using the pinmux?
>>
>> Or do you mean we need to be prepared for driving a single
>> slave through multiple masters over the lifetime of that device,
>> but using the i3c master handover protocol?
>> In the second case, how do we decide which master to use
>> for accessing a device for a given request?
>
> I'll have to defer to Wolfram. He's the i2c and muxing expert.

On i2c, we only have the first case, and Wolfram said that it
intentionally does the reprobe to avoid the problems we discussed.
The question is what to do about this if it happens again on i3c.
Peter seemed to think that it was possibly something we might
have to handle, while Boris said that it wouldn't be because it's
not coverered by the i3c spec.

The second case is the one that started the discussion, and
this is where I said I'd prefer to associate each slave with at
most one master at boot time, while the current v6 patch
is prepared for having one slave be accessed alternatingly
by multiple masters using the master handover, though so
far nobody has been able to describe exactly how we'd pick
which master is active at what point, or what specific scenario
would require it.

       Arnd
