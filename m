Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FFDC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D1A2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 12:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="nKKDbMH5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeLRMbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 07:31:34 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33712 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRMbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 07:31:34 -0500
Received: by mail-ed1-f45.google.com with SMTP id p6so13752515eds.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KwDKLfSYiQfxQBrr3oFDktECKDeuAT4X/w+KqM8BJy4=;
        b=nKKDbMH5rsprg7IUtRBsqLmm1mBFi6SL5qJHvRDz6NeH/bRmcculFP0WFipvo1RSnS
         uWYjP76WJehwo/lZb3srPLZJxC1b0LHiMB54zbmIaohUfoisuRufFc/hRjJ3xm4syT6P
         52jbohJH3S4j0WvTsoAo795YnHjvc2uHPCZIDJBTI8wMeIvZbFjvueppNgTHTu6Zo+E/
         QqQ2yilNI2/KrJnSRfVxbKA8DDrQtcfTaqYMDGyHzha5uFr7/eEeUtrYtx98sdq5cN2b
         ZbrTFapXyX1RHXAVvyeIIJQ/2GKrE+vuDUZLD64NbbWVCPKJvcnZFyTXX/1/1pGlLbkc
         jQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KwDKLfSYiQfxQBrr3oFDktECKDeuAT4X/w+KqM8BJy4=;
        b=Q3svjNtONPcdY1Z6x1Glav/xBIVBN5OdnHRn5b/Lyap+6mQRGTxd6+6gN1y3WMmr0o
         5b3ZXsWh0bWwjlZxsf0RTdpV8kFfy5rhpUFjuCibFm5mpYudI9DZx03FV/OIwHFM3LFj
         EykXKGs1E4R3qTTFtQcUxODCRLpWMrdCZ7ytTJNLITi5JFWXD61AubTttLDKx822+QET
         WauYmfzm8x1Vch7+9eYNqSoKkZLt2HlP5y+gGlc3p7LMm6kWTL1I9EfdKVDrGWIN7+uN
         92Tci0evYoJ+bYXtoAMr197oZ1crLFm4fY47SX8B3gcTu8cWZn4/q7wBOGfaniPiZDfS
         0V4Q==
X-Gm-Message-State: AA+aEWa+H0ZWqal6E1Wq3WS90ThSs+nWuGuN06MwYQk+zj/1fdl4LiDI
        nqUheZ8vHSHlvg63SXmum4WlhZ0f9xV2NvA+tnpkOg==
X-Google-Smtp-Source: AFSGD/Xco1MTb4bEg31HwBOiAwdZpyD3P8V/IJWi5SdpHYShaAqpqooVTM2Y/ptgDBhrux/UJcMZDm2hThPOOhCcLEA=
X-Received: by 2002:aa7:d597:: with SMTP id r23mr16547429edq.51.1545136291800;
 Tue, 18 Dec 2018 04:31:31 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
 <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com> <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
 <3c0837d1-0e9f-0a4c-ce50-db766c02aa8b@gmail.com>
In-Reply-To: <3c0837d1-0e9f-0a4c-ce50-db766c02aa8b@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 18 Dec 2018 20:31:20 +0800
Message-ID: <CAB4CAwf5QnCRFRT-=XAdCAKQv8rshnzVVpedCDyOag+nzuFOQA@mail.gmail.com>
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

On Tue, Dec 18, 2018 at 5:45 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 17.12.2018 14:25, Chris Chiu wrote:
> > On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 14.12.2018 04:33, Chris Chiu wrote:
> >>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>>>
> >>>> Hi,
> >>>>     We got an acer laptop which has a problem with ethernet networking after
> >>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
> >>>> follows.
> >>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> >>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
> >>>>
> >> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
> >>
> > [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
> > (uninitialized): mac_version = 0x2b
> > [   22.365580] libphy: r8169: probed
> > [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
> > XID 5c800800, IRQ 38
> > [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
> > bytes, tx checksumming: ko]
> >
> >>>>     The problem is the ethernet is not accessible after resume. Pinging via
> >>>> ethernet always shows the response `Destination Host Unreachable`. However,
> >>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
> >>>> interface, the networking is back to alive. But it's dead again after
> >>>> I stop tcpdump.
> >>>> One more thing, if I ping the problematic machine from others, it achieves the
> >>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
> >>>>
> >> You could compare the register dumps (ethtool -d) before and after S3 sleep
> >> to find out whether there's a difference.
> >>
> >
> > Actually, I just found I lead the wrong direction. The S3 suspend does
> > help to reproduce,
> > but it's not necessary. All I need to do is ping around 5 mins and the
> > network connection
> > fails.  And I also find one thing interesting, disabling the  MSI-X
> > interrupt like commit
> > [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
> > Although I don't
> > understand the root cause. Anything I can do to help?
> >
> One  more thing: I checked the vendor driver and it uses a different sequence
> to initialize the ePHY. Could you please check whether the following patch
> makes a difference? I don't have much hope but it's worth a try.
>
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 8462553e3..7cfb22e05 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -5097,11 +5097,16 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>  static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>  {
>         static const struct ephy_info e_info_8411_2[] = {
> -               { 0x00, 0x0000, 0x0008 },
> -               { 0x0c, 0x3df0, 0x0200 },
> -               { 0x0f, 0xffff, 0x5200 },
> -               { 0x19, 0x0020, 0x0000 },
> -               { 0x1e, 0x0000, 0x2000 }
> +               { 0x00, 0x0008, 0x0000 },
> +               { 0x0c, 0x37d0, 0x0820 },
> +               { 0x1e, 0x0000, 0x0001 },
> +               { 0x19, 0x8021, 0x0000 },
> +               { 0x1e, 0x0000, 0x2000 },
> +               { 0x0d, 0x0100, 0x0200 },
> +               { 0x00, 0x0000, 0x0080 },
> +               { 0x06, 0x0000, 0x0010 },
> +               { 0x04, 0x0000, 0x0010 },
> +               { 0x1d, 0x0000, 0x4000 },
>         };
>
>         rtl_hw_start_8168g(tp);
> --
> 2.20.0
>
As you expected, I applied the phy init change for this specific MAC_VER_43,
it makes no difference.

>
> >>>>     I tried the latest 4.20 rc version but the problem still there. I
> >>>> also tried some
> >>>> hw_reset or init thing in the resume path but no effect. Any
> >>>> suggestion for this?
> >>>> Thanks
> >>>>
> >> Did previous kernel versions work? If it's a regression, a bisect would be
> >> appreciated, because with the chip versions I've got I can't reproduce the issue.
> >>
> >>>> Chris
> >>>
> >>> Gentle ping. Any additional information required?
> >>>
> >>> Chris
> >>>
> >> Heiner
> >
>
