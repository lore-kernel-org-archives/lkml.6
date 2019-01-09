Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E47C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3786E206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 22:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUV07l1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfAIWVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 17:21:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35221 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 17:21:00 -0500
Received: by mail-wr1-f66.google.com with SMTP id 96so9296846wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XsoWdDkzT0sjnxj6ApB92bBmiRVQ8Jt4mee9E/08j3Y=;
        b=mUV07l1/9lHF6tfSk/j/ylUsNo5bBDWP1aP0oshDjfduT3bWkd/5qTJVinwFqgdVZo
         MqJed3xiw63vkkIufmfLXjhGk5lR6L2L1n0/QlV/GDxuPX972Qs6uWzTtfKjwcgonYay
         W1uzcFotESLZx+tzRJpzXtYAwDHXpQAkiPJ/CUkz1P6CBTDylQf5U2zqz/C6b4Jx0u2B
         m3wn/nBsSaildvpLB1WgK0nP965e99uIybqhUUrgF1rtaYZfeD8Rx1/g5rbpEQNpQhUy
         t92LEHtEdZd06/Mfqpj/lzhU6uJvze0B+PgkNIYgFSvjwrv/6FuzO77vqZ5pnRm5ibJF
         jwLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XsoWdDkzT0sjnxj6ApB92bBmiRVQ8Jt4mee9E/08j3Y=;
        b=Tz2wae6XhPrIInzaQUzBWucMC1P4m+Z9+3fv1Tr+punYcTY+lsUW+pGkC6l1K0gHI5
         R5PqJKRqQjphZkqy8LstVfBAWi4/kLU4AUSO1VQJsqdXFiY0naMVlMTdvPaFXrMksL/o
         6B4JCGimurZ/poWWzwJhb4mm7cXZjhRPXEZjx5rOdm9zWRSJQ5zxGdumExvI1q+bszyO
         UwGB8030tY41nPngj+hVSl33T1M/ABIsKeAvTnmQwwCWNSBDDCoPzzSlbjO9hkUL/WTA
         IW7f0SBdMXs8WgxaMIiDKajNGzfxea51B3X7dubOgyyoNc8zZaYXUl5tcygePH6pKkhG
         +nfA==
X-Gm-Message-State: AJcUukdHohOpWfUpX7J+zEopvuL0kliD8091/Vz9kzTR5PVSVlbWzsFy
        MqiG9ssqz3f9WMptbBkYItZ0rXwH
X-Google-Smtp-Source: ALg8bN7QZNHBJsMItKGDXxOb/V1SofZhboM2PTmEtaFifoPgHQntER4JjBzkk2QltqM9vizIm3BymA==
X-Received: by 2002:a5d:49cd:: with SMTP id t13mr6768994wrs.144.1547072458211;
        Wed, 09 Jan 2019 14:20:58 -0800 (PST)
Received: from ?IPv6:2003:ea:8be2:e400:30af:bb11:dc41:cedc? (p200300EA8BE2E40030AFBB11DC41CEDC.dip0.t-ipconnect.de. [2003:ea:8be2:e400:30af:bb11:dc41:cedc])
        by smtp.googlemail.com with ESMTPSA id k135sm17018292wmd.42.2019.01.09.14.20.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 14:20:57 -0800 (PST)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
 <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
 <20181227065321.GA3749@lerouge>
 <e838fa7f-f43f-7b3c-aae6-edb4f6734964@gmail.com>
 <20181228013109.GB3749@lerouge>
 <d9647487-28db-d138-ae3e-3fd0d2fbe589@gmail.com>
 <5aa51fc1-5a5c-0c61-5c28-0d9ca98e4514@gmail.com>
Message-ID: <596c9dc3-5cf4-73e8-b3ea-40fcb8c5f711@gmail.com>
Date:   Wed, 9 Jan 2019 23:20:50 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5aa51fc1-5a5c-0c61-5c28-0d9ca98e4514@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.12.2018 07:39, Heiner Kallweit wrote:
> On 28.12.2018 07:34, Heiner Kallweit wrote:
>> On 28.12.2018 02:31, Frederic Weisbecker wrote:
>>> On Fri, Dec 28, 2018 at 12:11:12AM +0100, Heiner Kallweit wrote:
>>>>
>> [...]
>>>
>>> Interesting, the softirq is raised from hardirq but it's not handled in the end of
>>> the IRQ. Are you running threaded IRQS by any chance? If so I would expect ksoftirqd
>>> to handle the pending work before we go idle. However I can imagine a small window
>>> where such an expectation may not be met: if the softirq is raised after the ksoftirqd
>>> thread is parked (CPUHP_AP_SMPBOOT_THREADS), which is right before we disable the CPU
>>> (CPUHP_TEARDOWN_CPU).
>>>
>> I have a network driver (r8169) using NAPI which runs in softirq context AFAIK.
>> For testing purposes I sometimes trigger system suspend via network, so there is
>> network adapter activity when system suspends. Apart from that nothing really
>> exciting:
>>             CPU0       CPU1       CPU2       CPU3
>>    0:         43          0          0          0   IO-APIC    2-edge      timer
>>    1:          4          0          0          0   IO-APIC    1-edge      i8042
>>    8:          0          1          0          0   IO-APIC    8-fasteoi   rtc0
>>    9:          0          0          0          0   IO-APIC    9-fasteoi   acpi
>>   12:          0          0          0          5   IO-APIC   12-edge      i8042
>>  120:          0          0          0          0   PCI-MSI 311296-edge      PCIe PME
>>  121:          0          0          0          0   PCI-MSI 315392-edge      PCIe PME
>>  122:          0          0          0          0   PCI-MSI 327680-edge      PCIe PME
>>  123:          0          0       3328          0   PCI-MSI 294912-edge      ahci[0000:00:12.0]
>>  124:          0        133          0          0   PCI-MSI 344064-edge      xhci_hcd
>>  125:          0          0         32          0   PCI-MSI 245760-edge      mei_me
>>  127:        381          0          0          0   PCI-MSI 1572864-edge      enp3s0
>>  128:          0          0          0        236   PCI-MSI 32768-edge      i915
>>  129:          0        374          0          0   PCI-MSI 229376-edge      snd_hda_intel:card0
>>
>>> I don't know if we can afford to ignore a softirq even at this late stage. We should
>>> probably avoid leaking any. So here is a possible fix, if you don't mind trying:
>>>
>> I tested your patch and at least in the first minutes of testing couldn't reproduce
>> the issue any longer. I tested manual system suspend and the following script you
>> sent when we started to analyze the issue.
>>
> 
> Also after some more time the issue didn't occur again. So it seems your analysis
> was right and also the approach to fix it. Thanks!
> Will let you know in case the issue should pop up again under special
> circumstances.
> 
Frederic, so far this fix didn't appear in linux-next, are you going to submit it?

> 
>> Heiner
>>
>> --------------------------------------------------------------------------
>>
>> #!/bin/bash
>>
>> do_hotplug()
>> {
>> 	for i in $(seq 1 $2)
>> 	do
>> 		echo $1 > /sys/devices/system/cpu/cpu$i/online
>> 	done
>> }
>>
>> LAST_CPU=$(($(nproc)-1))
>>
>> while true
>> do
>> 	do_hotplug 0 $LAST_CPU
>> 	do_hotplug 1 $LAST_CPU
>> done
>>
> 

