Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9711EC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4E0217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="QCKkVONZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbeLSOhR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:37:17 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:38025 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbeLSOhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:37:17 -0500
Received: by mail-ed1-f41.google.com with SMTP id h50so17160527ede.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+HGyy7sEqCk0Uj5XLEfvCRuMzG/iGo4xggsAVeFTwGg=;
        b=QCKkVONZI63RezzrkRAPJ9QZUSJGc6oUwg41vGaU8OGNW8YeQrgF8FdD5s+7a+ajRs
         TEj80eFXVkL+9UnNo+Py/741kmCJkupuXlFVvunOWrPt5LiWZko+pdNhnpo5o5To0vtb
         7mAcrU3VQaajslxBdqBd8V9/VjzcY6Or/7Ro+fzwk+M3VYsrFsVQgHNENf/jyWgih46Y
         +3/BOh69cO08dayYD1VIX2MuAAfLnoPuODsqtndIb1dC0np93v+HsXKnAlM2mmDzznqB
         W1oQAt5gVvcx+aAj683Ac4yt3udsAyyT1jtD9ed3yNNnpivJoXuaXtse7y7M7SHOSZhi
         e0JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+HGyy7sEqCk0Uj5XLEfvCRuMzG/iGo4xggsAVeFTwGg=;
        b=TP7U79g0QnrY8+uEOUdAyyqhXyHGMi9YXkcObsKrW1npGGuvqlYQ6fDK6XCOzmU3Z1
         l+fiwG2HEwC5oZB0adftWkUAUXrNY++8iam3/0w2w1Do3dxJlAjmge/Lo3WlQ8y9PY3s
         6TRGSX9DZvelpEf+1cMVjYr2444qFjM6Ma6u3PcLqoDVDMPMmOadMjjAIoTuKNZjvGwU
         6Te8Gdw0eVUnGgkhhphsnDc72JFES7ssJybDpDSbpn8Nd4+1ZaMb3rG07QFJ32rMUHVs
         nLqmoY1rEqNPADOKytiSUr4he6FkfX1Ppzl2LZz7xWvh8INhDNN3b9Fv1vZPvxxWM90X
         28dA==
X-Gm-Message-State: AA+aEWYCyKsx9Skiaj79YntnRjiWm4nHQiOgHFzfLsHtan3qJPEXAxzb
        npsq6ytc6JsIdidwGCf2Is1MrQBrR2h38AXpbKNRcQ==
X-Google-Smtp-Source: AFSGD/XFi/1TDORrbTuyvpwzJQyneIn2h2+kjXAJOXxbFCDaoxiRuTgIc/NlO05r9NLSP7WOJP8ZJMjIo0yG4mcChSA=
X-Received: by 2002:aa7:d597:: with SMTP id r23mr20471532edq.51.1545230234378;
 Wed, 19 Dec 2018 06:37:14 -0800 (PST)
MIME-Version: 1.0
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
 <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com> <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
 <d217e5b0-6008-c1f2-38fd-a41a7757e047@gmail.com> <CAB4CAwcr+V+7b2uuaFtkOHNKP3Xep5dNkZQBrVQiEq_eg5PpAw@mail.gmail.com>
 <4d2084e5-abec-b046-a304-8ca7db4c269f@gmail.com>
In-Reply-To: <4d2084e5-abec-b046-a304-8ca7db4c269f@gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 19 Dec 2018 22:37:00 +0800
Message-ID: <CAB4CAwfD2iFN4j8-r_kEgShPxQ98U9gdntWk+3Y3aRCOJhj5mw@mail.gmail.com>
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

On Wed, Dec 19, 2018 at 2:22 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 18.12.2018 14:25, Chris Chiu wrote:
> > On Tue, Dec 18, 2018 at 3:08 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 17.12.2018 14:25, Chris Chiu wrote:
> >>> On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>>>
> >>>> On 14.12.2018 04:33, Chris Chiu wrote:
> >>>>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
> >>>>>>
> >>>>>> Hi,
> >>>>>>     We got an acer laptop which has a problem with ethernet networking after
> >>>>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
> >>>>>> follows.
> >>>>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
> >>>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
> >>>>>>
> >>>> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
> >>>>
> >>> [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
> >>> (uninitialized): mac_version = 0x2b
> >>> [   22.365580] libphy: r8169: probed
> >>> [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
> >>> XID 5c800800, IRQ 38
> >>> [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
> >>> bytes, tx checksumming: ko]
> >>>
> >> Thanks for the info.
> >>
> >>>>>>     The problem is the ethernet is not accessible after resume. Pinging via
> >>>>>> ethernet always shows the response `Destination Host Unreachable`. However,
> >>>>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
> >>>>>> interface, the networking is back to alive. But it's dead again after
> >>>>>> I stop tcpdump.
> >>>>>> One more thing, if I ping the problematic machine from others, it achieves the
> >>>>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
> >>>>>>
> >>>> You could compare the register dumps (ethtool -d) before and after S3 sleep
> >>>> to find out whether there's a difference.
> >>>>
> >>>
> >>> Actually, I just found I lead the wrong direction. The S3 suspend does
> >>> help to reproduce,
> >>> but it's not necessary. All I need to do is ping around 5 mins and the
> >>> network connection
> >>> fails.  And I also find one thing interesting, disabling the  MSI-X
> >>> interrupt like commit
> >>> [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
> >>> Although I don't
> >>> understand the root cause. Anything I can do to help?
> >>>
> >> This is indeed very, very weird. You say switching from MSI-X to MSI fixes
> >> the issue, but also pinging the machine from outside brings back the network.
> >> Both actions affect totally different corners.
> >>
> >> The commit and related issue you mention was a workaround in the driver,
> >> the root cause was a MSI-X-related  issue with certain Intel chipsets deep
> >> in the PCI core. After this was fixed we removed the workaround again.
> >> This shouldn't be related to your issue.
> >>
> >> Hard to say for now is whether the issue is:
> >> - a driver issue
> >> - a hardware issue in the RTL8411
> >> - an issue with the chipset on your mainboard
> >>
> >> According to your description it doesn't take a special scenario to trigger
> >> the issue, so most likely also other users of Acer notebooks with RTL8411
> >> should be affected (after briefly checking this should be at least Aspire
> >> F15, V15, V7). Therefore I wonder why there aren't more reports.
> >>
> >> This commit added MSI-X support: 6c6aa15fdea5 ("r8169: improve interrupt handling")
> >> So you could test this revision and the one before.
> >>
> >> Eventually, if the issue really should be caused by a side effect of using
> >> MSI-X, then the question is whether we need to disable MSI-X for RTL8411
> >> in general or just for RTL8411 and a certain subsystem id.
> >>
> >
> > I tried the kernel with the head on 6c6aa15fdea5 ("r8169: improve
> > interrupt handling"),
> > the problem still there. Then I revert to the previous revision, the
> > problem goes away.
> > So I think it's pretty much the side effect of MSI-X. However, as you
> > mentioned that
> > you didn't hit this problem, I'll ask the vendor to verify if this
> > problem also happens on
> > other machines with the same chip. Then we can determine to disable for specific
> > mac version or just a certain subsystem id.
> >
> Thanks a lot for testing. OK, I have one more idea.
> AFAICS RTL8411 also has an integrated card reader controller which is driven
> by module rtsx_pci. Maybe if both components (card reader controller + ethernet)
> use different interrupt types, RTL8411 can't properly handle this.
> In case module rtsx_pci is loaded on your system, can you check whether not
> loading it (e.g. by blacklisting) or removing it makes a difference?
>

I boot my kernel with rtsx_pci_ms/rtsx_pci on blacklist, but it
doesn't change anything.

> Can you provide the "lspci -v" output for the card reader part of RTL8411?

02:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd.
RTL8411B PCI Express Card Reader (rev 01)
        Subsystem: Acer Incorporated [ALI] RTL8411B PCI Express Card Reader
        Flags: bus master, fast devsel, latency 0, IRQ 34
        Memory at f0b05000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at f0b10000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
        Capabilities: [d0] Vital Product Data
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Virtual Channel
        Capabilities: [160] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [170] Latency Tolerance Reporting
        Capabilities: [178] L1 PM Substates
        Kernel driver in use: rtsx_pci
        Kernel modules: rtsx_pci

>
> >>>>>>     I tried the latest 4.20 rc version but the problem still there. I
> >>>>>> also tried some
> >>>>>> hw_reset or init thing in the resume path but no effect. Any
> >>>>>> suggestion for this?
> >>>>>> Thanks
> >>>>>>
> >>>> Did previous kernel versions work? If it's a regression, a bisect would be
> >>>> appreciated, because with the chip versions I've got I can't reproduce the issue.
> >>>>
> >>>>>> Chris
> >>>>>
> >>>>> Gentle ping. Any additional information required?
> >>>>>
> >>>>> Chris
> >>>>>
> >>>> Heiner
> >>>
> >>
> >
>
