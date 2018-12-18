Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07612C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4C39218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 18:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLNoMbdu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbeLRSWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:22:05 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:45726 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeLRSWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 13:22:05 -0500
Received: by mail-wr1-f46.google.com with SMTP id t6so16738756wrr.12;
        Tue, 18 Dec 2018 10:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XFQymmCw/0/rX0YrmIklPAL/zoSlc6+xI1HNZ9J8VIg=;
        b=MLNoMbduRWRpK8Q3ByKm2BbG0r5PZAkv4iJIpJhaqliuVUin599AlmNkrQReK5Ak6W
         rMvnx69AHjY0eQA5sfi+WvO0h/tBb2kscoToNMuQWKRKEBp6Qi9z17Nc2Xa1d+NO7mrh
         EV/DG07zXytTN2briKCb74obBL+NESXpbYWRdhe0adnsDI+CHGuXErmLUzFx+/tDvJCP
         Ix/jjJR9uMVc2dRx8KSZAfTkyLbMeIgbmj0n6p6eszWtVOGOvlukuyDG1CBLD7TPyTuV
         K4ACnQiwD2PInDTK064AAM5Q8bB4eV0pGwGr0tMOOdu8CSlmYKIEUfzexzuYT8Lq2/We
         e9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XFQymmCw/0/rX0YrmIklPAL/zoSlc6+xI1HNZ9J8VIg=;
        b=RtOiVjIJ7jm+yaesDmDvq3w7sDXf1hHT8c2OIpQzokU9q4JFkcRfMPlIST7mFc7SfS
         1eDnZNR/khA1h49NGgmM6Djw8s1Ioqc7iojw/GuEse0Jo2qr/Qm/XLIMu7l1h5u1Pg4d
         LYSQc78DMissTGEyuBRVpcXqg/qYVN+u+u8aSwIcc0RIZo7rLRf0uxiu2CzEiXDVK1yU
         4w95XNdYX7Yr8lZyDag35vdnyx4CikMMIckO0tnLg2uSstG28QssnA8tGpv3SLltjhRo
         BDfHutOgnFb0DSlPemyI8DtXaz735nicB4RMKm0VZf4lNB+L8lreU/bEj+27NbJvwYY2
         MqRA==
X-Gm-Message-State: AA+aEWbwY9GlMjAU2zNqJN1e6GFL0lJzN1hwUSzsEAKPrbDa31ky2Yqd
        DMdFSPiJOPHmQMmFUxmy1SM=
X-Google-Smtp-Source: AFSGD/WBZ59oAVSvyr61ljPzF3/LV8jo/IGPClFj9+HIfrsglcE5PdET7Jsz+M3PY50pyhCTQATiOg==
X-Received: by 2002:a5d:568c:: with SMTP id f12mr14563826wrv.101.1545157322816;
        Tue, 18 Dec 2018 10:22:02 -0800 (PST)
Received: from ?IPv6:2003:ea:8bcf:e300:d6b:eddb:42b0:da51? (p200300EA8BCFE3000D6BEDDB42B0DA51.dip0.t-ipconnect.de. [2003:ea:8bcf:e300:d6b:eddb:42b0:da51])
        by smtp.googlemail.com with ESMTPSA id n82sm2995204wma.42.2018.12.18.10.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:22:02 -0800 (PST)
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
 <d217e5b0-6008-c1f2-38fd-a41a7757e047@gmail.com>
 <CAB4CAwcr+V+7b2uuaFtkOHNKP3Xep5dNkZQBrVQiEq_eg5PpAw@mail.gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <4d2084e5-abec-b046-a304-8ca7db4c269f@gmail.com>
Date:   Tue, 18 Dec 2018 19:21:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CAB4CAwcr+V+7b2uuaFtkOHNKP3Xep5dNkZQBrVQiEq_eg5PpAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.12.2018 14:25, Chris Chiu wrote:
> On Tue, Dec 18, 2018 at 3:08 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 17.12.2018 14:25, Chris Chiu wrote:
>>> On Fri, Dec 14, 2018 at 3:37 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 14.12.2018 04:33, Chris Chiu wrote:
>>>>> On Thu, Dec 13, 2018 at 10:20 AM Chris Chiu <chiu@endlessm.com> wrote:
>>>>>>
>>>>>> Hi,
>>>>>>     We got an acer laptop which has a problem with ethernet networking after
>>>>>> resuming from S3. The ethernet is popular realtek r8168. The lspci shows as
>>>>>> follows.
>>>>>> 02:00.1 Ethernet controller [0200]: Realtek Semiconductor Co., Ltd.
>>>>>> RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller [10ec:8168] (rev 12)
>>>>>>
>>>> Helpful would be a "dmesg | grep r8169", especially chip name + XID.
>>>>
>>> [   22.362774] r8169 0000:02:00.1 (unnamed net_device)
>>> (uninitialized): mac_version = 0x2b
>>> [   22.365580] libphy: r8169: probed
>>> [   22.365958] r8169 0000:02:00.1 eth0: RTL8411, 00:e0:b8:1f:cb:83,
>>> XID 5c800800, IRQ 38
>>> [   22.365961] r8169 0000:02:00.1 eth0: jumbo features [frames: 9200
>>> bytes, tx checksumming: ko]
>>>
>> Thanks for the info.
>>
>>>>>>     The problem is the ethernet is not accessible after resume. Pinging via
>>>>>> ethernet always shows the response `Destination Host Unreachable`. However,
>>>>>> the interesting part is, when I run tcpdump to monitor the problematic ethernet
>>>>>> interface, the networking is back to alive. But it's dead again after
>>>>>> I stop tcpdump.
>>>>>> One more thing, if I ping the problematic machine from others, it achieves the
>>>>>> same effect as above tcpdump. Maybe it's about the register setting for RX path?
>>>>>>
>>>> You could compare the register dumps (ethtool -d) before and after S3 sleep
>>>> to find out whether there's a difference.
>>>>
>>>
>>> Actually, I just found I lead the wrong direction. The S3 suspend does
>>> help to reproduce,
>>> but it's not necessary. All I need to do is ping around 5 mins and the
>>> network connection
>>> fails.  And I also find one thing interesting, disabling the  MSI-X
>>> interrupt like commit
>>> [d49c88d7677ba737e9d2759a87db0402d5ab2607] can fix this problem.
>>> Although I don't
>>> understand the root cause. Anything I can do to help?
>>>
>> This is indeed very, very weird. You say switching from MSI-X to MSI fixes
>> the issue, but also pinging the machine from outside brings back the network.
>> Both actions affect totally different corners.
>>
>> The commit and related issue you mention was a workaround in the driver,
>> the root cause was a MSI-X-related  issue with certain Intel chipsets deep
>> in the PCI core. After this was fixed we removed the workaround again.
>> This shouldn't be related to your issue.
>>
>> Hard to say for now is whether the issue is:
>> - a driver issue
>> - a hardware issue in the RTL8411
>> - an issue with the chipset on your mainboard
>>
>> According to your description it doesn't take a special scenario to trigger
>> the issue, so most likely also other users of Acer notebooks with RTL8411
>> should be affected (after briefly checking this should be at least Aspire
>> F15, V15, V7). Therefore I wonder why there aren't more reports.
>>
>> This commit added MSI-X support: 6c6aa15fdea5 ("r8169: improve interrupt handling")
>> So you could test this revision and the one before.
>>
>> Eventually, if the issue really should be caused by a side effect of using
>> MSI-X, then the question is whether we need to disable MSI-X for RTL8411
>> in general or just for RTL8411 and a certain subsystem id.
>>
> 
> I tried the kernel with the head on 6c6aa15fdea5 ("r8169: improve
> interrupt handling"),
> the problem still there. Then I revert to the previous revision, the
> problem goes away.
> So I think it's pretty much the side effect of MSI-X. However, as you
> mentioned that
> you didn't hit this problem, I'll ask the vendor to verify if this
> problem also happens on
> other machines with the same chip. Then we can determine to disable for specific
> mac version or just a certain subsystem id.
> 
Thanks a lot for testing. OK, I have one more idea.
AFAICS RTL8411 also has an integrated card reader controller which is driven
by module rtsx_pci. Maybe if both components (card reader controller + ethernet)
use different interrupt types, RTL8411 can't properly handle this.
In case module rtsx_pci is loaded on your system, can you check whether not
loading it (e.g. by blacklisting) or removing it makes a difference?

Can you provide the "lspci -v" output for the card reader part of RTL8411?

>>>>>>     I tried the latest 4.20 rc version but the problem still there. I
>>>>>> also tried some
>>>>>> hw_reset or init thing in the resume path but no effect. Any
>>>>>> suggestion for this?
>>>>>> Thanks
>>>>>>
>>>> Did previous kernel versions work? If it's a regression, a bisect would be
>>>> appreciated, because with the chip versions I've got I can't reproduce the issue.
>>>>
>>>>>> Chris
>>>>>
>>>>> Gentle ping. Any additional information required?
>>>>>
>>>>> Chris
>>>>>
>>>> Heiner
>>>
>>
> 

