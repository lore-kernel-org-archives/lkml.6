Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3FC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3157208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 20:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="opSESFP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3157208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJPEqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 00:46:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36954 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbeJPEqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 00:46:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id 185-v6so21099478wmt.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S3mLassXnNqMjp19nNnv8IAz6M7fmdQYaUqvzMzyKKQ=;
        b=opSESFP2KlEqgCIgQHkYj/JEGroJi1R5k8S2JfwUJvpttqQmBKhf/wLuK0U6SVm2GA
         7M1WwThnLnasgmJw+gaZ8+59TVpJKIpM8wvLHbelfomSQIDLx5UHiLKVtb4V+ZY/KVhQ
         flyFTHmo8TDZovQiCCLvwcYRtf01Js6V2GJv1BaU3gqTBqa7UAHTkUAtZFikTCgYe97s
         KkOIM6UvDu028baVwnbuV2r1Dk55NkxGu9oddXPhxfncLM1RdPzQ4t9hQioDLff0S4Ap
         4flTWTkFn2XGTu8v/L6L11O3lmBIUHOge4ya4gzCSspIqsL9GIUzPmGCz5dBbT805nFH
         p1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S3mLassXnNqMjp19nNnv8IAz6M7fmdQYaUqvzMzyKKQ=;
        b=c7zzbT8hSwH8kJeYWzRTT6BfqSi4IBdaMGhgUehPVuBwYscH9meRZYARDKzcQ6y6tx
         oindhlBOk4DdPjdAjHIQYBgm251s5Ihi0Ar2wbocAnj3GBI6BBtU2Gh1y3OOzXm/lZYz
         L8+wRvDeCF58zl3RDnxlURSwmX/keINyttJMTILGMzzfqK15b8EcuB8d1j5GFWvs73PS
         /LidDPF5JG7o8evPH79463k3NNbkj+sJzsaVOgsuSj759dXIFnkF8V9rC1pkp3btTn1v
         BbTJPOy1oGkqxP7eR8+kpPQ2qY6+M51p2VWU1o9piZS4jn6Gv2q2GxGAiJ8Qjg35kuHq
         ddyA==
X-Gm-Message-State: ABuFfogIK19tz5W7QAO1DTjxbZmzV1lDhBdZhxQ1OymTBshvxF3G4cyd
        +mjWHJ7co9uMsBBghH58YaU=
X-Google-Smtp-Source: ACcGV611ul3V8rxbHNT8ovs9mvFaF9gOMsSj0E/umM6muWcZEpuWh8DxqxaZ/aAhDCOhKu5g+dve+A==
X-Received: by 2002:a1c:3584:: with SMTP id c126-v6mr15061583wma.120.1539637143404;
        Mon, 15 Oct 2018 13:59:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:bcc7:2952:331d:d482? (p200300EA8BD43F00BCC72952331DD482.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:bcc7:2952:331d:d482])
        by smtp.googlemail.com with ESMTPSA id b8-v6sm8212640wme.1.2018.10.15.13.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 13:59:02 -0700 (PDT)
Subject: Re: Fix 80d20d35af1e ("nohz: Fix local_timer_softirq_pending()") may
 have revealed another problem
To:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <8b93f213-fe67-f132-f3f5-5b17995ec63d@gmail.com>
 <20180824041245.GA2730@lerouge>
 <67ce38dc-1f00-55c6-f9ae-2dec00172cf6@gmail.com>
 <alpine.DEB.2.21.1808241000340.1668@nanos.tec.linutronix.de>
 <20180824143056.GC2730@lerouge>
 <d8fd3322-e982-2c9c-85e3-9b1770357520@gmail.com>
 <20180828022545.GA25943@lerouge>
 <alpine.DEB.2.21.1809271805190.8118@nanos.tec.linutronix.de>
 <20180928131855.GB8795@lerouge>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <c472b6bf-e4af-d807-e63f-75211ce295bd@gmail.com>
Date:   Mon, 15 Oct 2018 22:58:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928131855.GB8795@lerouge>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.09.2018 15:18, Frederic Weisbecker wrote:
> On Thu, Sep 27, 2018 at 06:05:46PM +0200, Thomas Gleixner wrote:
>> On Tue, 28 Aug 2018, Frederic Weisbecker wrote:
>>> On Fri, Aug 24, 2018 at 07:06:32PM +0200, Heiner Kallweit wrote:
>>>> I tested it and Frederic is right, it doesn't help. Can it be somehow related to
>>>> the cpu being brought down during suspend? Because I get the warning only during
>>>> suspend when the cpu is inactive already (but still online).
>>>
>>> It's hard to tell, I haven't been able to reproduce on suspend to disk/mem.
>>>
>>> Does this script eventually trigger it after some time?
>>
>> Any update to this?
> 
> Heiner? Can you please test the script I sent to you?
> 
> Thanks.
> 
Sorry, took some time .. And yes, running your script triggers the message too.

[   25.646015] x86: Booting SMP configuration:
[   25.646044] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.664491] smpboot: CPU 1 is now offline
[   25.679299] x86: Booting SMP configuration:
[   25.679329] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.698449] smpboot: CPU 1 is now offline
[   25.711698] x86: Booting SMP configuration:
[   25.711727] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.729185] NOHZ: local_softirq_pending 202
[   25.729229] NOHZ: local_softirq_pending 202
[   25.730759] smpboot: CPU 1 is now offline
[   25.744053] x86: Booting SMP configuration:
[   25.744083] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.762520] smpboot: CPU 1 is now offline
[   25.776834] x86: Booting SMP configuration:
[   25.776863] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.794189] NOHZ: local_softirq_pending 202
[   25.796672] smpboot: CPU 1 is now offline
[   25.805970] x86: Booting SMP configuration:
[   25.805999] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.827360] smpboot: CPU 1 is now offline
[   25.839043] x86: Booting SMP configuration:
[   25.839073] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.858184] NOHZ: local_softirq_pending 202
[   25.862182] smpboot: CPU 1 is now offline
[   25.873759] x86: Booting SMP configuration:
[   25.873789] smpboot: Booting Node 0 Processor 1 APIC 0x2
[   25.893385] smpboot: CPU 1 is now offline

