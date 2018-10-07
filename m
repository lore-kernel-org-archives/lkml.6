Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3877C65C1B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6622086D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 19:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rrrErFin"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6622086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbeJHCor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 22:44:47 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36058 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbeJHCor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 22:44:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id y16so18541249wrw.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=czesGM3pUaccv7+x7PdDpX7wdZpFyZZLGL16ByM9eao=;
        b=rrrErFin0Ir+7ZfowGfrEjrxnsEnBYtTDULn1E3C4Gn6soXzaHX4LfwHzGQZHLRlC/
         Rs1Mp1TlskO9NqQRZVCsGx53h9FuQ73oixbFQDHwl8hiATHj6aJsGQBXKJTZYKfj1704
         dK8qpGnbWNyOhkIf4+cbj+A7jZh+cDooo+IQqXzcmrnBBymCOiJgYNqDic+jpHEilNNG
         gxUn+GdLayvrr10GQfOzydgfgNuWXyD+mWgn64UaFDQzMuCGrO3kQ2QDpVNljR9E8bYV
         4ukug3mHAgEzeJm2ZJMfqQpWdyyf+1lc9AFiCU65Aaof5LNlKzE5s8yYB0TcMkdc6iRj
         1Btw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=czesGM3pUaccv7+x7PdDpX7wdZpFyZZLGL16ByM9eao=;
        b=UWRbUdXt4zZ2qPkh4PVq+dhJjhQ4A9HmH5bAgZ9OjLCzHSFGZKpG6xR0+n5bWZcMn4
         h61yX46jtuHubqX8GAwfIhIKeJAE1JVjBH+7PQomkRc5gf5M2JHxgYkT4UhKcl50EIfk
         np9G8u+EFlJ4y9FnhKGp/cCnCqpPjZVJ9zXY4SAE24Ju+mShdLJHbp38Qksz17lA0VRt
         ddq1kJ9dafeT5nk5Ys7Z0J6q0dGgL178AlWRuTYdk4ZK1dCiI2e3nfcYOoNRjepGXE+Z
         tIwEBdjZ1+HJicPPDeKBXaB3AbKy7luT6XIFSfKy2/rhFpvfK5g9fJq5tLFeuSEjRYBs
         zRFA==
X-Gm-Message-State: ABuFfojajViX04ISMtHGl5BEw2gbxpmF8E3o3wBgEi7C5p+d0Sf/5hvn
        TwR5EzkBIcHySepRgE+4lLkdd0Qy
X-Google-Smtp-Source: ACcGV62soz2yGIdAdlTUd4sDdg5Eu8J6Vpx6qOdFoHuV1Ekqcr3wZD2nSYNe2rjZmlRZMkXarYUuyw==
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr14405340wrm.94.1538940985679;
        Sun, 07 Oct 2018 12:36:25 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id x186-v6sm17859781wmx.24.2018.10.07.12.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 12:36:24 -0700 (PDT)
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
 <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
Message-ID: <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
Date:   Sun, 7 Oct 2018 20:36:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9980dcc1-f7fe-5de7-75be-99b1592c9206@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
14-15ms to more than 1000ms.

Chris

On 04/10/2018 09:41, Chris Clayton wrote:
> Hi Heiner,
> 
> Here's the reply to your questions. Sorry for the delay.
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
> 
> $ dmesg | grep r8169
> [    5.274938] libphy: r8169: probed
> [    5.276563] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 29
> [    5.278158] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
> [    9.275275] RTL8211E Gigabit Ethernet r8169-502:00: attached PHY driver [RTL8211E Gigabit Ethernet]
> (mii_bus:phy_addr=r8169-502:00, irq=IGNORE)
> [    9.460876] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
> [   11.005336] r8169 0000:05:00.2 eth0: Link is Up - 100Mbps/Full - flow control rx/tx
> 
>> According to your lspci output neither MSI nor MSI-X is active.
>> Do you have to use nomsi for whatever reason?
>>
> 
> No, I do not use nomsi, but MSI wasn't enabled in my kernel config. I'm 99% sure that it used to be - I've no idea how
> it got dropped. If I'm not sure about an option, I start by taking the recommendation in the kconfig help. Help on MSI
> has a very clear "say Y". I've re-enabled it now.
> 
> Chris
> 
>> Heiner
>>
>>>> Maciej
>>>>
>>> Chris
>>>
>>
>>
