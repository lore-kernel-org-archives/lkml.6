Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6212C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A67A2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PsNPg9QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A67A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbeJKF5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:57:21 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36934 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKF5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:57:21 -0400
Received: by mail-wm1-f67.google.com with SMTP id 185-v6so7369416wmt.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nJG0iX1hPQUlfU5Jg5JjZZ2uhcnSoykQS8Hddurhy5s=;
        b=PsNPg9QALkYXiO3NqIQtgAHZg107h6yi8sg6NtUzEZzUdiRNBicgNT1mPO6TAY5izr
         X4BUVqmhFLHxdowysMz8Z3+nf3jNP7Z+i2vaneHpFDjA6/YckVoPwPMU6VHXs4H0LnrB
         9L1RDPME+eTsKMgVagNtEstJdZL+2B8SKUDoINJfxyEuxiY1eLpMDrT+3Fl8vCZ7V6xg
         dju5FPg4tvFa9KWwgjkkrBgUO065Ewankw36pyc9Hxw3b/Ri24di0XL0PMAU3gBdlSqE
         HhXZRHSaFMC9h49zDGrTPkq58mCttlKQ9zTWKzC7ujJq0F6+FPdcfOaJH79mS7b6vf44
         w7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nJG0iX1hPQUlfU5Jg5JjZZ2uhcnSoykQS8Hddurhy5s=;
        b=pnCsbvyy8pLx3ixSrwy3OXQ7nANCUf4H/ZGnmkWxN68Sr/Gnm1qVjKw0lUcZ4oAGcQ
         UsYDKmUODG3okRk/F3yZbcBGvoi8kO1OdvaF/UkkhLS/y1RP0S1e50QGvU03yP+pH4pH
         Lzd8uyjHhG5SJTYSvdqdHTzOHJ745DmjqMHqguAaa5kijvrIgqFW2bq49GhhG6wQ9qrW
         /lKbQxiXFG2xGEi1WJDm6Fw50BksiqW2BstehZUMfqZUazw2HOviCfKdb8KGiyIMlk/0
         JJBmvtheASTMNw25Sl5vTI1e7yub8MIMykDoCDduKilUJQLkdJJkf1TMLIrAsHZDYNaz
         K1UQ==
X-Gm-Message-State: ABuFfoi9zQaI42oSAdUyGAajQieaFddib+37UawQ4ZPbzpbVXh/vvuph
        NAgm2Mr2ZwhScz9sbwNtiHOCCfR1
X-Google-Smtp-Source: ACcGV60QO4uXUiHNKwTwKrOEs2P6h4v1JHlidd4OBKjqRVd+uBAKoZzw/lJs4G4uQUrQboO6+emT+Q==
X-Received: by 2002:a1c:1b84:: with SMTP id b126-v6mr2396095wmb.121.1539210785865;
        Wed, 10 Oct 2018 15:33:05 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id t82-v6sm17422698wme.30.2018.10.10.15.33.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:33:05 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
From:   Chris Clayton <chris2553@googlemail.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
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
 <0e206e6b-3d0c-de27-dedb-48c30e02649c@gmail.com>
 <9d99060a-db1d-7177-3041-e407b131548e@maciej.szmigiero.name>
 <c1b09d33-f2f0-337e-6e85-0ec035cbf179@googlemail.com>
Message-ID: <557cc747-d4b3-b38f-3bb8-8c83b8bac139@googlemail.com>
Date:   Wed, 10 Oct 2018 23:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <c1b09d33-f2f0-337e-6e85-0ec035cbf179@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Too late at night to be doing this stuff. Clicked send instead of saving a draft. Sorry, please ignore.

On 10/10/2018 23:30, Chris Clayton wrote:
> OK, right kernel/module used this time. Please see findings below.
> 
> On 10/10/2018 01:24, Maciej S. Szmigiero wrote:
>> On 09.10.2018 22:36, Heiner Kallweit wrote:
>>> On 09.10.2018 16:40, Chris Clayton wrote:
>>>> Thanks to Maciej and Heiner for their replies.
>>>>
>>>> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>>>>> On 07.10.2018 21:36, Chris Clayton wrote:
>>>>>> Hi again,
>>>>>>
>>>>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>>>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>>>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>>>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>>>>> 14-15ms to more than 1000ms.
>>>>>
>>>>> You can try comparing chip registers (ethtool -d eth0) in the working
>>>>> state (before a suspend) and in the broken state (after a resume).
>>>>> Maybe there will be some obvious in the difference.
>>>>>
>>>>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>>>>
>>>> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
>>>>
>>>> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
>>>> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
>>>>
>>> Hmm, this is very weird, especially taking into account that in your original
>>> report you state that removing the call to rtl_init_rxcfg() from rtl_hw_start()
>>> fixes the issue. rtl_init_rxcfg() deals with the RxConfig register only and
>>> register values seem to be the same before and after resume. So how can the
>>> chip behave differently?
>>> So far my best guess is that some chip quirk causes it to accept writes to
>>> register RxConfig, but to misinterpret or ignore the written value.
>>> So far your report is the only one (affecting RTL8411), but we don't know
>>> whether other chip versions are affected too.
>>
>> Also, it is interesting that even if one removes a call to
>> rtl_init_rxcfg() from rtl_hw_start() the RxConfig register will still get
>> written to moments later by rtl_set_rx_mode().
>>
>> The only chip accesses in the meantime seems to be a write to TxConfig by
>> rtl_set_tx_config_registers() and then a read of RxConfig plus two writes
>> to MAR0 earlier in rtl_set_rx_mode().
>>
>> My proposals are:
>> 1) Try swapping "rtl_init_rxcfg(tp);" and "rtl_set_tx_config_registers(tp);"
>> in rtl_hw_start().
>> Maybe the chip does not like sometimes that RxConfig is written before
>> TxConfig.
>>
> 
> This change made no difference. Networking still dies if I open a browser or leave ping running long enough.
> 
>> 2) Check the original value of RxConfig (after a resume) before
>> rtl_init_rxcfg() overwrites it (compile tested only):
>> --- r8169.c.ori
>> +++ r8169.c
>> @@ -5155,6 +5155,9 @@
>>  	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
>>  	RTL_R8(tp, IntrMask);
>>  	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
>> +
>> +	pr_notice("RxConfig before init was %.8x\n",
>> +		(unsigned int)RTL_R32(tp, RxConfig));
>>  	rtl_init_rxcfg(tp);
>>  	rtl_set_tx_config_registers(tp);
>>  
>>
>> This should be the value that you got when you removed the call to
>> rtl_init_rxcfg() for testing.
>> Now, knowing the "right" value you can experiment with what rtl_init_rxcfg()
>> writes (under the "default:" label for your NIC model).
> 
> This might be more interesting. Through combination of viewing the output from pr_notice() and the output from "ethtool
> -d", I can see RxConfig with the following values
> 
> 	During boot:	0x00028700
> 	Before suspend:	0x0002870e
> 	During resume:	0x00024000
> 	Post resume:	0x0002870e
> 
> I then removed the call to rtl_init_rxcfg() from rtl_hw_start() and rebuilt, installed and rebooted. Now I see the
> following values:
> 
> 	During boot:	0x00028700
> 	Before suspend:	0x0002870e
> 	During resume:	0x00024000
> 	Post resume:	0x0002870e
> 
>>
>> Hope this helps,
>> Maciej
>>
