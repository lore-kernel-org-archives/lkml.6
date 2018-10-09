Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32783C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCF44213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 20:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+EmKW1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF44213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeJJDzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 23:55:48 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:36630 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbeJJDzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 23:55:48 -0400
Received: by mail-wr1-f41.google.com with SMTP id y16so3267514wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 13:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VqOwJW831xjJ5Unqznvj6I4iVs9hYgV2jnbslHchdsc=;
        b=X+EmKW1uSpvZPRGSCl5BOvGpLLbMtJVsBfOQSzd7DLrjTvck96JXXJrT1M9h1/rtZK
         DD2N2e3qgtMVh9yqOyMaZmoDmvO6Q1vq/HbKMCWWvbEqM+VdFouuba71HQ9sIPxX/at9
         mbf8DvLJj1EP1TRfEN4pOcHC5M88Nuqs2Jd9zwEidBTRsH2tKbcwGvLYx3UTvaxVxr6M
         vIIcg+QnXjkqzdUe1+OLxBB/USwTBB1o+Jnr7pJEGTENgq1BoZ+nXpt/cW0XH+18JXbI
         52raC88lRGzr2u0HNAXpAddFN+Q++K8FWe1uzZTDCOakwfx7QGyztwdTHkOxbcSlhK8J
         eS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VqOwJW831xjJ5Unqznvj6I4iVs9hYgV2jnbslHchdsc=;
        b=RqXrdPWbgjdJfbkpk5ApUlCt+9QCbNPIFN/0rkWMcL+jhpeFhyesbpVaq2yvXGuYNF
         KwVW/Bf0uq/ZGAQKAs5fOEcKmz8B/CIN6T3CQ+B5OjtIi4MjH751tzim5J3oAK/+NwN8
         nHC2eIcQVk5e++CdrVN4y6UNis93Q9MJqE1eSUoR3Xnh2LIaGQe1Qw18wcf0Rw3fRQG7
         qm7T0UQtKibsdsaCBKQRfbu4tUWJKLRgjqhk/FkPKZCvZIIVG+XNZrpQrL85fUFYfNVo
         1M12CQOW7/KuvJQPcUMUI2CZLeS5igRaS8J/j/KFXIzn2hj5joOQvELNDyRILk4gzLIR
         YZUw==
X-Gm-Message-State: ABuFfoitn/C6cJg5MG5NZ1V4srU6+mS/DPtoMuInRsOcHtWAbz2Oa/j2
        4L3Y/MKa9daRZ0fZXzgsfSt5z9ImCDY=
X-Google-Smtp-Source: ACcGV609tJkXkfcIsg8qWtFAdLr1EIFAO51/SaTq4m7JbC0ut+lAo39uVjkhX2Qb3yrjrZ4Sdz9DKw==
X-Received: by 2002:a5d:4dd2:: with SMTP id f18-v6mr22914628wru.80.1539117423154;
        Tue, 09 Oct 2018 13:37:03 -0700 (PDT)
Received: from ?IPv6:2003:ea:8bd4:3f00:fd29:c80b:4f28:4b3d? (p200300EA8BD43F00FD29C80B4F284B3D.dip0.t-ipconnect.de. [2003:ea:8bd4:3f00:fd29:c80b:4f28:4b3d])
        by smtp.googlemail.com with ESMTPSA id o201-v6sm18279359wmg.16.2018.10.09.13.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 13:37:02 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
To:     Chris Clayton <chris2553@googlemail.com>,
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
 <6b1685ce-22ac-2c71-e1d4-b05748a7d977@googlemail.com>
 <bed5c327-6a2a-99da-8b86-16f897b32548@maciej.szmigiero.name>
 <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <0e206e6b-3d0c-de27-dedb-48c30e02649c@gmail.com>
Date:   Tue, 9 Oct 2018 22:36:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <7199b1e4-ce40-60ae-2a6a-ef7e95e563ea@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.10.2018 16:40, Chris Clayton wrote:
> Thanks to Maciej and Heiner for their replies.
> 
> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>> On 07.10.2018 21:36, Chris Clayton wrote:
>>> Hi again,
>>>
>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>> 14-15ms to more than 1000ms.
>>
>> You can try comparing chip registers (ethtool -d eth0) in the working
>> state (before a suspend) and in the broken state (after a resume).
>> Maybe there will be some obvious in the difference.
>>
>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>
> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
> 
> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
> 
Hmm, this is very weird, especially taking into account that in your original
report you state that removing the call to rtl_init_rxcfg() from rtl_hw_start()
fixes the issue. rtl_init_rxcfg() deals with the RxConfig register only and
register values seem to be the same before and after resume. So how can the
chip behave differently?
So far my best guess is that some chip quirk causes it to accept writes to
register RxConfig, but to misinterpret or ignore the written value.
So far your report is the only one (affecting RTL8411), but we don't know
whether other chip versions are affected too.
One option could be to call rtl_init_rxcfg() for chip versions <= 06 only
because for them we know that they need this call.


> I've attached files I redirected the outputs to.
> 
> Please don't hesitate to ask for any other information needed to solve this problem. In the meantime, I've now got
> scripts that stop the network during suspend and restart it during resume. (Those scripts were removed whilst I gathered
> the diagnostics shown in the attachments.)
> 
> Chris
> 
>>> Chris
>>
>> Maciej
>>

