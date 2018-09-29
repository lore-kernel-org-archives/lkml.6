Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89682C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199242073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 07:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="QOVsyF9y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 199242073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeI2NxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 09:53:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39141 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeI2NxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 09:53:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so8527120wrw.6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 00:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMzztcdstCScAkC4A+l3Ho0JeBbEDX3ATwqQRttMrj4=;
        b=QOVsyF9yg0fS8ptscnHNzV1Wi5ozKs1O3vR3kdLhlqf/5hH731wILiQBuimPsF12Nw
         nsGgm9NVTaUbATfJJovYqNmKfdaVXz7nIojcojARmldDJ9CPFvCyUXkaykms8B2qv/XU
         TMw8bNJztHGHAhunlnYGlxoUsw8RNO7777yxdb9055aau3z+g4EeQuC8XhBWxqo4FS4a
         3RFfL87y9iOvWeq5X/rs/Bk+ZHrQ5prA4pGNKdSS8D3u+RQJyc62At0QdKBysP50PxMS
         oHCvNeBAbICEkFs5eswh3/rODKDidmyyMm/Tra6BMXtiG/YjXKyuvV0MlqV8j6Qrs38b
         bAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMzztcdstCScAkC4A+l3Ho0JeBbEDX3ATwqQRttMrj4=;
        b=HFxgoR6zUw6ODnWO5y5TLv/MMvTQHJzg256LBPMXa+g88sGF4nCvc46AKV3Xc8VPtM
         9x8hTLL+Zi5VDDggu/3E6yV+qlmpOQSwn7yZidpFrobalbsk2nem9yTz6/eBzudSGdwK
         xJ/1mai5jm4zpAoa9AmffY93YJeJDMDY9zt4OhXkltUSAzUngPoGuAbwcRNfSbcTMrtw
         8jaLVfq2UDq/TK8kAr4NBT8af/Xdo4Zcvk7RYWBjC7heZbozsA/Tq/sF/6ZUn3EOKbTv
         et7a40PU7KEa4obTdanH8d96/Oo+dlc+CMgdA52/AoMfT5C0oSkeZJL4d9Pvk/x3P8fT
         8cMw==
X-Gm-Message-State: ABuFfojaYWZuMWuTy4bDD6oz4qO33fHSWHQfrX+ln9BzBINSnDf7kjBH
        CaHfH7zDka6eOaafROEgPJVq7141
X-Google-Smtp-Source: ACcGV63VVxcxBTmOVsmrRnSr9iTvKswJtIOx+5drAjqWe1z0ICHEQzTWI/krMZNE3TwgeR3t9jxrxQ==
X-Received: by 2002:a5d:4c90:: with SMTP id z16-v6mr1143654wrs.239.1538205939116;
        Sat, 29 Sep 2018 00:25:39 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.124.175])
        by smtp.googlemail.com with ESMTPSA id y25-v6sm4106392wmi.46.2018.09.29.00.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 00:25:38 -0700 (PDT)
From:   Chris Clayton <chris2553@googlemail.com>
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
Message-ID: <600d279d-357b-50c6-37f8-a4e96c7436a4@googlemail.com>
Date:   Sat, 29 Sep 2018 08:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <98680351-5123-761f-982a-726098da9716@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



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

$ dmesg | grep -i r8169
[    5.320679] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    5.321432] r8169 0000:05:00.2: can't disable ASPM; OS doesn't have ASPM control
[    5.322892] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 19
[    5.323786] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   10.232077] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
[   10.235218] r8169 0000:05:00.2 eth0: link down
[   11.717460] r8169 0000:05:00.2 eth0: link up

$ dmesg | grep -i r8169
[    5.208040] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    5.208677] r8169 0000:05:00.2: can't disable ASPM; OS doesn't have ASPM control
[    5.210066] r8169 0000:05:00.2 eth0: RTL8411, 80:fa:5b:08:d0:3d, XID 48800800, IRQ 29
[    5.210676] r8169 0000:05:00.2 eth0: jumbo features [frames: 9200 bytes, tx checksumming: ko]
[   10.456081] r8169 0000:05:00.2 eth0: No native access to PCI extended config space, falling back to CSI
[   10.459217] r8169 0000:05:00.2 eth0: link down
[   10.459880] r8169 0000:05:00.2 eth0: link down
[   12.015158] r8169 0000:05:00.2 eth0: link up


> According to your lspci output neither MSI nor MSI-X is active.
> Do you have to use nomsi for whatever reason?

No, I do not use nomsi, but MSI wasn't enabled in my kernel config. I'm 99% sure that it used to be - I've no idea how
it got dropped. If I'm not sure about an option, I start by taking the recommendation in the kconfig help. Help on MSI
has a very clear "say Y".

> 
> Heiner
> 
>>> Maciej
>>>
>> Chris
>>
> 
