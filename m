Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F530C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E655A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 19:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsIyoYi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbeLQTIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 14:08:22 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50363 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeLQTIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 14:08:22 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so331800wmd.0;
        Mon, 17 Dec 2018 11:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrBxUaOzEsCLDxJBcDrF2I/MEmtIm1oVClLGixYZ4bs=;
        b=gsIyoYi0hPzL5imKjcf05ySNbLKmaeq/WyRBnpGlt+s3q8wuhBVQiAE5Efl8tusYXY
         IPNZLNv3coG+TlC+mSkJX6zula34GQAddPSe0EAqSwn/cetmPXWlsyBPEDYSL0n6k5Th
         1Kz0w1JizoKkVbCl9w7cewocOGpbkXP8BTuqWjg+iR0BDjJdyXgGyXlmmdUHaC+VZBtv
         mpNFDjGNozSy/V6Ygl0WDNE4Y382QUo5Id//7dpV2lLozPaZe7Ky9ym/sJ7HIs3gKl0h
         y4BhjFETT91JylGJvorRqLCq1f4oune/MdheOwW/Xh5u/cs8BePEjcoVgArw77YPNjMb
         xkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrBxUaOzEsCLDxJBcDrF2I/MEmtIm1oVClLGixYZ4bs=;
        b=DZc3PcFm5PQdc5p7DVwZZTynvFvu4rvvHTTFOhq30QCossKlPUPY/WIV5x9FfldyEk
         knzbUGQ+RKxVzxehMRoQl3566753x0nr+0vB58pzwueI/94xo4sSnUjkQuEghvAFW8fC
         Y/uPnzo4MEof/YNKdNlAFew/lY12ZsTcbW9yNcUH8SSH+IcHbZoBAEpbnPStQaa8yoe3
         rd8q1OulFBdvlSibfhcsNKWLtdaZetIlI49wRy8J0b0BxSA54cE9k08crVZmRR2ClALV
         86xfFVUX7PnyT6Sk3J6GLx+szN+Uv9ngu96Gf9I6LD2FbehJLtDAAtxs9ppZYJTflcbW
         0Kkg==
X-Gm-Message-State: AA+aEWahkHpXFUkX/NhxX0IaoxRAJ6s8h8P7Nf+R3Mqat6CICWLM5eBL
        Hy+UVnhfIufHZ9lUVZroVzSeFYZz
X-Google-Smtp-Source: AFSGD/V8F3GVb6YeJzySD23wSuZqMu7mHWv+FJBvtPYkAlloihIIzinuB+OBFIWHIAad8hVtBNGzNw==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr330748wme.4.1545073698953;
        Mon, 17 Dec 2018 11:08:18 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:9098:392c:b017:10bc? (p200300EA8BCFE3009098392CB01710BC.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:9098:392c:b017:10bc])
        by smtp.googlemail.com with ESMTPSA id g16sm1230227wru.41.2018.12.17.11.08.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 11:08:18 -0800 (PST)
Subject: Re: A weird problem of Realtek r8168 after resume from S3
To:     Chris Chiu <chiu@endlessm.com>
Cc:     nic_swsd <nic_swsd@realtek.com>, davem@davemloft.net,
        netdev@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
References: <CAB4CAwfH156yEd-XAkt==u+S8bO0U2=sg8nVr4o57C1q3K97Kw@mail.gmail.com>
 <CAB4CAwc4ubdXn7kzPeu2L--ciATgZWYkO350fvFF43-jj180xw@mail.gmail.com>
 <59069da6-befc-2ebe-f2e2-e95a6a714013@gmail.com>
 <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <d217e5b0-6008-c1f2-38fd-a41a7757e047@gmail.com>
Date:   Mon, 17 Dec 2018 20:08:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAB4CAweArBEDWBvJwcnME6TBRUHYmOboKDf_4dDMvs81yZU3hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.2018 14:25, Chris Chiu wrote:
> On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 14.12.2018 04:33, Chris Chiu wrote:
>>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
>>>>
>>>> Hi,
>>>>     We got an acer laptop which has a problem with ethernet networking after
>>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
>>>> follows.
>>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
>>>>
>> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
>>
> [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
> (uninitialized): mac_version = 0x2b
> [   22.365580] libphy: r8169: probed
> [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
> XID 5c800800, IRQ 38
> [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
> bytes, tx checksumming: ko]
> 
Thanks for the info.

>>>>     The problem is the ethernet is not accessible after resume. Pinging via
>>>> ethernet always shows the response `Destination Host Unreachable`. However,
>>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
>>>> interface, the networking is back to alive. But it's dead again after
>>>> I stop tcpdump.
>>>> One more thing, if I ping the problematic machine from others, it achieves the
>>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
>>>>
>> You could compare the register dumps (ethtool -d) before and after S3 sleep
>> to find out whether there's a difference.
>>
> 
> Actually, I just found I lead the wrong direction. The S3 suspend does
> help to reproduce,
> but it's not necessary. All I need to do is ping around 5 mins and the
> network connection
> fails.  And I also find one thing interesting, disabling the  MSI-X
> interrupt like commit
> [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
> Although I don't
> understand the root cause. Anything I can do to help?
> 
This is indeed very, very weird. You say switching from MSI-X to MSI fixes
the issue, but also pinging the machine from outside brings back the network.
Both actions affect totally different corners.

The commit and related issue you mention was a workaround in the driver,
the root cause was a MSI-X-related  issue with certain Intel chipsets deep
in the PCI core. After this was fixed we removed the workaround again.
This shouldn't be related to your issue.

Hard to say for now is whether the issue is:
- a driver issue
- a hardware issue in the RTL8411
- an issue with the chipset on your mainboard

According to your description it doesn't take a special scenario to trigger
the issue, so most likely also other users of Acer notebooks with RTL8411
should be affected (after briefly checking this should be at least Aspire
F15, V15, V7). Therefore I wonder why there aren't more reports.

This commit added MSI-X support: 6c6aa15fdea5 ("r8169: improve interrupt handling")
So you could test this revision and the one before.

Eventually, if the issue really should be caused by a side effect of using
MSI-X, then the question is whether we need to disable MSI-X for RTL8411
in general or just for RTL8411 and a certain subsystem id.

>>>>     I tried the latest 4.20 rc version but the problem still there. I
>>>> also tried some
>>>> hw_reset or init thing in the resume path but no effect. Any
>>>> suggestion for this?
>>>> Thanks
>>>>
>> Did previous kernel versions work? If it's a regression, a bisect would be
>> appreciated, because with the chip versions I've got I can't reproduce the issue.
>>
>>>> Chris
>>>
>>> Gentle ping. Any additional information required?
>>>
>>> Chris
>>>
>> Heiner
> 

