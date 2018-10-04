Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CDCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBFD21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LN0Tfg5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDBFD21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeJDPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:33:19 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46345 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeJDPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:33:18 -0400
Received: by mail-wr1-f65.google.com with SMTP id a2-v6so1866824wrc.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wGiBsdVR9ir72HDwMTG44K1+AGubGWeDyhJfRF9GBd4=;
        b=LN0Tfg5QZOhqhn7r7i97PcptKUYutzhFYFEPBmj4HubgveMK7a25r0AoIQbBLas7Sc
         KBSFhC3NKvBynaxWqwUUN4NET2DdaDw/Wartzkna+8A5piiq764lAYxClzMU+r11Y6ec
         UkDKaO8xk9xvWGL1tHGQSoU5CerTso/xMAVPSqMtnmBD3cfkKXE8cwB1zmNe+/ZLaQFp
         AwLK3mkCEn+0ad7bcObVVY3zdpBvaF1TWnDZQfSZdB/G8jA8WBNSgYerFAvJoEHDgbP4
         QhnGrr4hIrn8keWwFBjF65m1xMBzwf4wyD+IYjwTyY7bimx/7IQYY3fK7gM468+YsJ8O
         Sh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wGiBsdVR9ir72HDwMTG44K1+AGubGWeDyhJfRF9GBd4=;
        b=JlKlXMV1yyfIMXF/+rTRCjxWOcW2RZqFPQ7C6NCMjsdcPxjNCCQ7PD3Uq+EuPtO9v2
         ErLe0uRT44rFDJksaa+2AcbpxtOtSEwIxqOclRNO+O9wJawJhS/2jYjOtWAiOlJUvUtw
         ND3HXZFWccc9IFNNwpCMB7cBtU32mDygaMTSJG25eWowjHpHsU+0mTjnumkcNr//Ykjs
         SYFv2pkQaqjffgAPb587YpqYh6OrR3aafZZ5ckVFnGS4lpxzbmq2SS9liI/fr3D9+Sj3
         EZqIOEuMTNQ8NiSoswwN5lUoh8m2Tn7DxGOrroMQ0fPXfenoUXa0qvvJS6z92t+6amoT
         IuMw==
X-Gm-Message-State: ABuFfogAaESMbrWHjk3X6U48700cw8S4j5ZFSbvMHpzglKpykh6KLeP/
        MYNbDckvnuZuHKGnJyQ3W3HzRZCU
X-Google-Smtp-Source: ACcGV601M2E9cp9qgj57r4JY3z19qgC2UHWRON6WO4+0ghsvgKlODTVqcJUsW8ybSQG7agjhzKrBdg==
X-Received: by 2002:a5d:5342:: with SMTP id t2-v6mr3868363wrv.257.1538642466740;
        Thu, 04 Oct 2018 01:41:06 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.124.175])
        by smtp.googlemail.com with ESMTPSA id g8-v6sm2611679wmf.45.2018.10.04.01.41.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:41:06 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
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
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
Date:   Thu, 4 Oct 2018 09:41:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <98680351-5123-761f-982a-726098da9716@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiner,

Here's the reply to your questions. Sorry for the delay.

On 28/09/2018 23:13, Heiner Kallweit wrote:
> On 29.09.2018 00:00, Chris Clayton wrote:
>> Thanks Maciej.
>>
>> On 28/09/2018 16:54, Maciej S. Szmigiero wrote:
>>> Hi,
>>>
>>>> Hi,
>>>>
>>>> I upgraded my kernel to 4.18.10 recently and have since been experiencing network problems after resuming from a
>>>> suspend to RAM or disk. I previously had 4.18.6 and that was OK.
>>>>
>>>> The pattern of the problem is that when I first boot, the network is fine. But, after resume from suspend I find that
>>>> the time taken for a ping of one of my ISP's nameservers increases from 14-15ms to more than 1000ms. Moreover, when I
>>>> open a browser (chromium or firefox), it fails to retrieve my home page (https://www.google.co.uk) and pings of the
>>>> nameserver fail with the message "Destination Host Unreachable". Often, I can revive the network by stopping it with
>>>> /sbin/if(down,up} but sometimes it is necessary to also remove the r8169 module and load it again.
>>>
>>> Please have a look at the following thread:
>>> https://lkml.org/lkml/2018/9/25/1118
>>>
>>
>> I applied your patch for the 4.18 stable kernels to 4.18.10, but the problem is not solved by it. Similarly, I applied
>> Heiner's patch to the 4.19, but again the problem is not solved.
>>
> I think we talk about two different issues here. The one the fix is for has no link to suspend/resume.
> 
> Chris, the lspci output doesn't provide enough detail to determine the exact chip version.
> Can you provide the dmesg part with the XID?

$ dmesg | grep r8169
[    5.274938] libphy: r8169: probed
[    5.276563] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 29
[    5.278158] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[    9.275275] RTL8211E Gigabit Ethernet r8169-502:00: attached PHY driver [RTL8211E Gigabit Ethernet]
(mii_bus:phy_addr=r8169-502:00, irq=IGNORE)
[    9.460876] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
[   11.005336] r8169 0000:05:00.2 eth0: Link is Up - 100Mbps/Full - flow control rx/tx

> According to your lspci output neither MSI nor MSI-X is active.
> Do you have to use nomsi for whatever reason?
> 

No, I do not use nomsi, but MSI wasn't enabled in my kernel config. I'm 99% sure that it used to be - I've no idea how
it got dropped. If I'm not sure about an option, I start by taking the recommendation in the kconfig help. Help on MSI
has a very clear "say Y". I've re-enabled it now.

Chris

> Heiner
> 
>>> Maciej
>>>
>> Chris
>>
> 
> 
