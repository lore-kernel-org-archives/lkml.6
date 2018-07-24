Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C9AC28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38DC920685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7l4YTi+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DC920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388748AbeGXV3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:29:31 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:40208 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbeGXV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:29:31 -0400
Received: by mail-qk0-f195.google.com with SMTP id c126-v6so3501349qkd.7;
        Tue, 24 Jul 2018 13:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=zxo2LxEoqjCwG9VdlbxYfEgRCdWpAuZA+3yVIVzzjBE=;
        b=d7l4YTi+1tZycJ3jNWoYSEPXSakV33mM3tyY1uwascS7/U/izrdzPngQcp6yg6CwSM
         hf9GYmHaWpulAFMc/ZFRXCct4wJd6lqiECDI3G3cImsaAz59fbCIVbK09NnqZ9SkwRtF
         wpPqX5v6wKJHOvIp4qFI4wjIqM965/JPU+WS/MO00fsvlWF3rZz9CLHWB0PqvzvPnx5G
         4Mhb0noruY6iYE39hQpeAcsBvGsqWzfMSHo+pPY5kRDKnrAc1eMeACvsL6ZeZ6X481M0
         lyWoz0vICwM2v9HodLwsVXI0q+ijiToAwrW35hbH5KxLM2cO1YhinRpfeNqu33+z3/bW
         N5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=zxo2LxEoqjCwG9VdlbxYfEgRCdWpAuZA+3yVIVzzjBE=;
        b=AjvVe1FWjN4nb2DDd6idlsBt5w5Nb1LCCZYECVo1RfVg+ZRQ4+s32oUh2jg4grfgmu
         gArX2eiVV658YUYqDMiqve9++Tf9iK+PtAJAVDMuSbAUHIesiXZRT4UlqQGTB4aJDZlC
         dSHgSZbP3GFR2yfAa017DjvQB61mnzAPynadcjsjKEVe90Z7RYywtngL3/S0zkFv7Ylp
         u1wn74eQ4ZXkmiiDnBug1uI1bqZXRNSJx6Jo/rRQioOusPAQtwTTN+JG4NY+irWl26Qi
         PJdarGf1VPrcUIKKMCy8YwNnJHw9EXibXi4fiM1lNNm6lDXP0umTrZkLxtdYq11z4V0f
         m4Ew==
X-Gm-Message-State: AOUpUlHwP1mcqWBnwaJqMN6H58bm/pOLytv7djzrYWynkwX/VFkR9CY4
        1XF1MUuM5AZVxxj5+MK6Ps0zQ4wpir3+0KgFb9A=
X-Google-Smtp-Source: AAOMgpeKasYvoDsK21vaiSkQ+LZwt0TyqmCglkLknL1dCR4cVtleaMhKatn3D6azZ7PPnLBYtt9Zm0aol08CRVigR+I=
X-Received: by 2002:a37:5e46:: with SMTP id s67-v6mr16656068qkb.202.1532463681681;
 Tue, 24 Jul 2018 13:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:967d:0:0:0:0:0 with HTTP; Tue, 24 Jul 2018 13:21:20
 -0700 (PDT)
In-Reply-To: <20180724185415.6126751e@bbrezillon>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se> <20180720101206.tv7nsoanwo5ftnia@ninjato>
 <CAK8P3a2Pqo5DuYBb09+w4nGWGOw+e_tZPxnA06qjNO_6Hw6NvQ@mail.gmail.com>
 <21b269c5-a3a7-c5de-c81e-c9c9301ae13e@axentia.se> <CAK8P3a1t2fhdw7HwxNkOs9o2pBECZ0ZdOysA=r2SPTWEvx76kw@mail.gmail.com>
 <20180720151751.242d4809@bbrezillon> <CAK8P3a14_6uf9VLYU0YnmFp0Q=DZBKc0cAesBh0opanGDZMFRA@mail.gmail.com>
 <20180724162806.318a92c6@bbrezillon> <CAK8P3a3YQbiiJMTHTVh63fOvtA1sa0J5Eb4z7xbnpBPwUDkqxg@mail.gmail.com>
 <CAMuHMdXif_iufXx0Y+UJjKs9TNLfrTONoFvUSyrpkfaT0=ydRQ@mail.gmail.com>
 <CAK8P3a0jc1k9weTNbqSJXkCSFefus9OPyU5_v5=mTFxiDd0q5Q@mail.gmail.com>
 <CAMuHMdXJ_FGXXwNx8h0ZfskJGRWES1xLuTQpD59Vw1Smp6FTRg@mail.gmail.com>
 <CAK8P3a17t=_o04GsowS2RnTwKKVxt8KuJtT36N=Ea-SOq7fTow@mail.gmail.com>
 <20180724181437.1d1b27a8@bbrezillon> <CAK8P3a0wcmeFKvRf7=FTNvePayc2AxniHoNkLOuzQQCt=MiLjQ@mail.gmail.com>
 <20180724185415.6126751e@bbrezillon>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 24 Jul 2018 22:21:20 +0200
X-Google-Sender-Auth: WsZLMh0RFFB05yKD4NEQS6C1uus
Message-ID: <CAK8P3a1NWo11JzR6wEk_fcQFoJBmJwA1ynjHdCnEK8PF4Q2-=Q@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Tue, Jul 24, 2018 at 6:54 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> On Tue, 24 Jul 2018 18:25:22 +0200
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Tue, Jul 24, 2018 at 6:14 PM, Boris Brezillon
>> <boris.brezillon@bootlin.com> wrote:
>> > On Tue, 24 Jul 2018 17:58:29 +0200
>> > Arnd Bergmann <arnd@arndb.de> wrote:
>> >> or what specific scenario would require it.
>> >
>> > I think I described a scenario (masters having different
>> > capabilities all connected to the same bus), though I don't know how
>> > likely this use case is :-/.
>>
>> I was looking for something more specific here. What (lack of)
>> capabilities could two i3c controllers have that require you to
>> use both of them for the same device, rather than picking
>> a master for each slave with the right feature set?
>
> Hehe, if I had a clear answer to this question we wouldn't have this
> discussion :-). I gave you an example:
>
> - master A supporting IBIs but not HDR transactions
> - master B supporting HDR modes but not IBIs
>
> but as I said, I'm not sure how likely this example is...

I'd say for a specific example like that, the person that did the
SoC integration should find a new job outside of hardware
design ;-)

I suppose the point is really that this is only preparation for something
completely unexpected, and any specific example one could come
up with is very unlikely to occur in real hardware.

> The question is more, should we design things so that we can at some
> point implement a solution to support those funky setups, or should we
> just ignore it and risk breaking sysfs/DT ABI when/if we have to support
> that?
>
> This is really an open question. I initially went for the former, but
> have no objection switching to the latter.

For me it's mainly a feeling that the risk of something going wrong
with the current design is bigger than it actually solving problems
we will encounter later. I hope that when you do a v7 version for
comparison, I'll be able to pinpoint specific aspects that are better
rather than being that unspecific. (note: I'll be on vacation next
week and won't be able to review it until I'm back).

Let me try to summarize the points made so far:

1. If we need a way for dynamic handover between two of our
    own masters and are not prepared for it now, some hardware
    designs may end up being unusable junk. Hopefully those
    cases are rare and found early during design when the hardware
    can still be changed to something that works.

2. If we design a system that does allow that handover and we don't
    need it, the biggest risk is introducing complexity in the system
    that makes it harder to use and debug for everyone.

3. The case where we have two masters on a bus, but each
    slave is only ever driven by one master can easily be added
    later, by adding some DT description for that machine as I
    described, but no extra code or DT bindings, or reprobing
    of devices during handover.

4. Handing over between an i2c master and an i3c master cannot
    be done with the current design either way, and could only ever
    work in very limited scenarios. The same is true for i3c masters
    that can be connected to the same bus, but not at the same
    time (like the case with multiplexed i2c masters today).

5. The debug scenario that Wolfram described might be handled
    with a separate bus structure and handing over behind the
    curtains, but does not require it to be done without a reprobe.
    I can imagine several other (simpler) designs that would allow
    doing this.

        Arnd
