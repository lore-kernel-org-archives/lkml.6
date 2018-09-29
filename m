Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F04C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DBB2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Ek+MtaCw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DBB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeI2OGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:06:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32833 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbeI2OGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:06:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id f10-v6so8581155wrs.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4J0hSGdFSZbM3G5uIsoDHLZOfSClS71ktF2TfH0W6yM=;
        b=Ek+MtaCwnX8w4DF2CiWXAeEQqP0rQQxLYnrpvn/wdMctVLKxjl2pxD9VoutJvc8Uz3
         Ff8vgU3zPVjlbFhmwpTeMfF8hfD4cva5SYFgMoQlbZJ/f8Ov2w9gHIWOebNiAq4986DN
         cjjh8QtILghoOUqlyMVbJxAihQXS8Nu9JEuhbqhoBVbs92nBC9qWyp4q53w/FoiaKHO9
         2pzBOrWaHSCMbJwgA+NiyTIntjociJRN3vrKg6VVpXoouu4uh4SelOc30fnyZBpK7ubE
         Pzcrbf2epfNjWWiCysmXY7zUhk2i472QP6H1ez2nS2a6mDc806aeX49RQkipYGUKNaEz
         +yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4J0hSGdFSZbM3G5uIsoDHLZOfSClS71ktF2TfH0W6yM=;
        b=W7d9ubgvX/r6K7Oi8mOBM5hdencrrJjn8w4HRvKEf1J1Pd+j4RfNWUG1SSTtil0uTn
         asf5jQRJrlT23YGGkx07lBoGS9sA6ABQWyJG33l79Fg0V5qEffreHlvt9hchL8eiJeD6
         ky3D8T+6Ggt6eB3Z1UkzSpop+KiTciNhhCgmaHJFB/Q6xpUSOzU70yASafBVEp7cveE9
         4mfgRPM5JJKn6IdZ2yrXjAZJOwS1z1R9o1sQzKNEnipceUF7GYhE3SzdwH3rygAkpMQs
         oiVvJS8/8QYSyASoNWY4Xc988n+Qb0BFZpyeY1SZePEzM+NBYLEQLmiN3SovRwGrxk5a
         jiFA==
X-Gm-Message-State: ABuFfogXKhqc1X3cy0bguV9kA0d6QOHyyUnWj3EstdJPJ4w/wYGFmOIa
        4bByeRU1C5VubNtG0PzJpOOjOxo8
X-Google-Smtp-Source: ACcGV60cVWjbwYULL4HIHn1X37FldRcjm9EGv2qec502rF92TwrmWaNkS84fNobsu8OKHY4fWZDWUw==
X-Received: by 2002:a5d:61ca:: with SMTP id q10-v6mr1142834wrv.33.1538206739178;
        Sat, 29 Sep 2018 00:38:59 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.124.175])
        by smtp.googlemail.com with ESMTPSA id g10-v6sm3189619wrv.49.2018.09.29.00.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:38:58 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
From:   Chris Clayton <chris2553@googlemail.com>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Azat Khuzhin <a3at.mail@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <54d8d7e9-a80d-dc2b-5628-22f9dc14e2ee@maciej.szmigiero.name>
 <535f42c7-6c3b-8e5a-49de-5dc975879b21@googlemail.com>
 <98680351-5123-761f-982a-726098da9716@gmail.com>
 <600d279d-357b-50c6-37f8-a4e96c7436a4@googlemail.com>
Message-ID: <fc21aefe-aef9-50e0-af02-a9150de0b9c0@googlemail.com>
Date:   Sat, 29 Sep 2018 08:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <600d279d-357b-50c6-37f8-a4e96c7436a4@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, sent by accident. Note to self - don't attempt email until after second cup of coffee.

On 29/09/2018 08:25, Chris Clayton wrote:
> 
> 
> On 28/09/2018 23:13, Heiner Kallweit wrote:
>> On 29.09.2018 00:00, Chris Clayton wrote:
>>> Thanks Maciej.
>>>
>>> On 28/09/2018 16:54, Maciej S. Szmigiero wrote:
>>>> Hi,
>>>>
>>>>> Hi,
>>>>>
>>>>> I upgraded my kernel to 4.18.10 recently and have since been experiencing network problems after resuming from a
>>>>> suspend to RAM or disk. I previously had 4.18.6 and that was OK.
>>>>>
>>>>> The pattern of the problem is that when I first boot, the network is fine. But, after resume from suspend I find that
>>>>> the time taken for a ping of one of my ISP's nameservers increases from 14-15ms to more than 1000ms. Moreover, when I
>>>>> open a browser (chromium or firefox), it fails to retrieve my home page (https://www.google.co.uk) and pings of the
>>>>> nameserver fail with the message "Destination Host Unreachable". Often, I can revive the network by stopping it with
>>>>> /sbin/if(down,up} but sometimes it is necessary to also remove the r8169 module and load it again.
>>>>
>>>> Please have a look at the following thread:
>>>> https://lkml.org/lkml/2018/9/25/1118
>>>>
>>>
>>> I applied your patch for the 4.18 stable kernels to 4.18.10, but the problem is not solved by it. Similarly, I applied
>>> Heiner's patch to the 4.19, but again the problem is not solved.
>>>
>> I think we talk about two different issues here. The one the fix is for has no link to suspend/resume.
>>
>> Chris, the lspci output doesn't provide enough detail to determine the exact chip version.
>> Can you provide the dmesg part with the XID?

I meant to say that I have now re-enabled MSI in 4.18.7 - the latest stable series kernel in which eth0 continues to
function reliably after a suspend/resume cycle. The second dmesg output below is taken from that kernel. The first one
was from an up-to-date 4.19 kernel
> 
> $ dmesg | grep -i r8169
> [    5.320679] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    5.321432] r8169 0000:05:00.2: can't disable ASPM; OS doesn't have ASPM control
> [    5.322892] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 19
> [    5.323786] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [   10.232077] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
> [   10.235218] r8169 0000:05:00.2 eth0: link down
> [   11.717460] r8169 0000:05:00.2 eth0: link up
> 
> $ dmesg | grep -i r8169
> [    5.208040] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> [    5.208677] r8169 0000:05:00.2: can't disable ASPM; OS doesn't have ASPM control
> [    5.210066] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 29
> [    5.210676] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [   10.456081] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
> [   10.459217] r8169 0000:05:00.2 eth0: link down
> [   10.459880] r8169 0000:05:00.2 eth0: link down
> [   12.015158] r8169 0000:05:00.2 eth0: link up
> 
> 
>> According to your lspci output neither MSI nor MSI-X is active.
>> Do you have to use nomsi for whatever reason?
> 
> No, I do not use nomsi, but MSI wasn't enabled in my kernel config. I'm 99% sure that it used to be - I've no idea how
> it got dropped. If I'm not sure about an option, I start by taking the recommendation in the kconfig help. Help on MSI
> has a very clear "say Y".

As I said above I have re-enabled MSI.
> 
>>
>> Heiner
>>
>>>> Maciej
>>>>
>>> Chris
>>>
>>
