Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F23C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7FC2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 13:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="THspEa2l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732829AbeLQN0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 08:26:05 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36012 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbeLQN0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 08:26:04 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so10739484edb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 05:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMQelfAtvnOhdMJ3ii4o8HQXfRZL5EHNmPi5ezsOdII=;
        b=THspEa2lPLKi2TsFdS7ObUBMzE5rPGogCcd/icIfXnWNkTzZUJCyAR0kPLUH7fMmfC
         5yHF/tNz2wobheuI/q+lK0WZAVI0kBri3NqMI3J3wWCsGIQbrYHl7eQ2nZCivpsO2VYy
         UMopzcV80PUHwnYNw55tBTgRonHDH+KGOBPDUnFgxGknLrXbKqSpU9YkbjuqcHl9F+9M
         UQ8ihpBV93TpDR4BbLY8TDdZ+Aq5ffWmgwSdTCblrw2pEEoTPVl2YbV44bqw9bhekJh0
         YtpNo3EHvsvm/+iMJ08v4cE99AIWuZ3/vEaqXCqkCPIyCMrSq6tg8OtVnov/CkpOfsMq
         yoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMQelfAtvnOhdMJ3ii4o8HQXfRZL5EHNmPi5ezsOdII=;
        b=Twz1QnWIt98N8d+wA1Y2Ggd1u4UigldrFnR8WfEzFf/IzZgj3DwSmZAexY/XKBwzDB
         4+ToVteRBfuYGRb473X/HlTKu0Dx29jx/SobTG/xop0P9pKKSBkXKy8b0VL00TotpEcw
         zKO/To8CRF/goXQNaQgCWROEitWVP34XADiAj3gBBs3xcyxlV34ip2UPZgiR3IVoRylM
         iGtLruUtvISDVYWjyNJ2KKrl7ijkrIgTTaKSweAQ4OIys430yDJbrsMU44CBlGLzfBjg
         f2PbKOcSiOt1yt0+6BdBidpXPofPtq3wcBBDtZyGKC7w1d+ZhJUrhBMsaHsmQPby7XZz
         zRWw==
X-Gm-Message-State: AA+aEWaGP0qxhSLuGp8SEn/kWHPWF4rB/UMR4BvG2pLbAwc40AqU/A2V
        Rwt95KwR7MuBLS7al/NYvkUdMdRXrTf+ef8PTyyPIQ==
X-Google-Smtp-Source: AFSGD/VEA3qohi4FEjaDlzC2s4Z+ePl8OKP/1/U8aNaLa53EvWCpS4ZgBJFh3SQRa5um3jw3xNs1exNWFi6A3SEE5Uo=
X-Received: by 2002:aa7:d597:: with SMTP id r23mr13017105edq.51.1545053162787;
 Mon, 17 Dec 2018 05:26:02 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com> <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com>
In-Reply-To: <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 17 Dec 2018 21:25:51 +0800
Message-ID: <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 14.12.2018 04:33, Chris Chiu wrote:
> > On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>
> >> Hi,
> >>     We got an acer laptop which has a problem with ethernet networking after
> >> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
> >> follows.
> >> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> >> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
> >>
> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
>
[   22.362774] r8169 0000:02:00.1 (unnamed net_device)
(uninitialized): mac_version = 0x2b
[   22.365580] libphy: r8169: probed
[   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
XID 5c800800, IRQ 38
[   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
bytes, tx checksumming: ko]

> >>     The problem is the ethernet is not accessible after resume. Pinging via
> >> ethernet always shows the response `Destination Host Unreachable`. However,
> >> the interesting part is, when I run tcpdump to monitor the problematic ethernet
> >> interface, the networking is back to alive. But it's dead again after
> >> I stop tcpdump.
> >> One more thing, if I ping the problematic machine from others, it achieves the
> >> same effect as above tcpdump. Maybe it's about the register setting for RX path?
> >>
> You could compare the register dumps (ethtool -d) before and after S3 sleep
> to find out whether there's a difference.
>

Actually, I just found I lead the wrong direction. The S3 suspend does
help to reproduce,
but it's not necessary. All I need to do is ping around 5 mins and the
network connection
fails.  And I also find one thing interesting, disabling the  MSI-X
interrupt like commit
[d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
Although I don't
understand the root cause. Anything I can do to help?

> >>     I tried the latest 4.20 rc version but the problem still there. I
> >> also tried some
> >> hw_reset or init thing in the resume path but no effect. Any
> >> suggestion for this?
> >> Thanks
> >>
> Did previous kernel versions work? If it's a regression, a bisect would be
> appreciated, because with the chip versions I've got I can't reproduce the issue.
>
> >> Chris
> >
> > Gentle ping. Any additional information required?
> >
> > Chris
> >
> Heiner
