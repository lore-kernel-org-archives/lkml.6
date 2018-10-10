Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9BBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1922085B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="YhFq4m2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E1922085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbeJKGNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:13:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44780 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbeJKGNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 02:13:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id 63-v6so7472041wra.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H7pC+vF20Ylvcv87BYvPgcsBlcLEpwOgfKi7W2PydvU=;
        b=YhFq4m2yIpEQ0JOWFKezyMwho+2cQFUKNZXMZp7oBySDmy38UtINHXbfMh1Cpio2H1
         sxLo9b2hEbj1O3xr1qizGpuinG7RiXbyV5FpmG74EHv8yfN43gRtnWNgeDv2oeS9gdFL
         60aM8CGuvdR8Y7/UP+RzpKK4zIMuZYjvL6iGjwtqKmZPnvdWxNFv8aFAnAKa/9OTlmSP
         3Gt9EjReQ5WbIBDjc4C4x6OqvrC2wfaBSWCs5YsT9Rab/iqoimqJ8Tansu+BnymfzGr0
         ekm2nA4HKGIs3eJ4viDGzTY2icmRBYBrok+dU50KwhTFuql2ypedU+f/GrOCVdL62/7A
         4b6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H7pC+vF20Ylvcv87BYvPgcsBlcLEpwOgfKi7W2PydvU=;
        b=c7GYnFe8MCNerA0Axz4XXFnFzf3GdVX8RXQfOHWgHs2Q2lyS+4wPwyxSnyVH+rs0AF
         EFC+ed+183Ql+p1+Ok7uqSnfuIVO2KS0lDuAbB3ZjOnBJPoVsIRUbsXN1FXZBkH1fQ/r
         IZno1RiMOf+u50dLVtdfPJX8U6gv5PFCJ/4OwU/dIUkTecQzeedC3AL5xhfkHVszQ+fx
         F0FWDM6FkCq2gFldQNukFxoAl1IVE+HU2rmbe84msdABj5j9JoRLMYC6oNsrYCuWLcsd
         RRPaSzbDZ1NczyjkqQVokV5otMaBAPT7brsZ19N3C7KMzhi+wwrMIdlcvilE3n2JUX3Y
         lcIQ==
X-Gm-Message-State: ABuFfogSoTMH5JMSbtO1Xxbb4NQ6JfNwRSkDKf49KiihZYGwmnPpUbc+
        tNEeu5CO3kp8vsQ44OLQl7nvYDSC
X-Google-Smtp-Source: ACcGV630XVW/eP33l8+OPx53H0nt0Q4T+0JJYAIk+wBI33vQSfSQI0YzV4t0c6g9lqd3ML/ZgGNh4Q==
X-Received: by 2002:adf:e70f:: with SMTP id c15-v6mr7151438wrm.165.1539211777268;
        Wed, 10 Oct 2018 15:49:37 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id b8-v6sm15852861wme.1.2018.10.10.15.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:49:36 -0700 (PDT)
Subject: Re: R8169: Network lockups in 4.18.{8,9,10} (and 4.19 dev)
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
From:   Chris Clayton <chris2553@googlemail.com>
Message-ID: <0b490a74-c8b3-7206-33ba-d99be73c18fd@googlemail.com>
Date:   Wed, 10 Oct 2018 23:49:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <9d99060a-db1d-7177-3041-e407b131548e@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK, right kernel/module used this time. Please see findings below.

On 10/10/2018 01:24, Maciej S. Szmigiero wrote:
> On 09.10.2018 22:36, Heiner Kallweit wrote:
>> On 09.10.2018 16:40, Chris Clayton wrote:
>>> Thanks to Maciej and Heiner for their replies.
>>>
>>> On 09/10/2018 13:32, Maciej S. Szmigiero wrote:
>>>> On 07.10.2018 21:36, Chris Clayton wrote:
>>>>> Hi again,
>>>>>
>>>>> I didn't think there was anything in 4.19-rc7 to fix this regression, but tried it anyway. I can confirm that the
>>>>> regression is still present and my network still fails when, after a resume from suspend (to ram or disk), I open my
>>>>> browser or my mail client. In both those cases the failure is almost immediate - e.g. my home page doesn't get displayed
>>>>> in the browser. Pinging one of my ISPs name servers doesn't fail quite so quickly but the reported time increases from
>>>>> 14-15ms to more than 1000ms.
>>>>
>>>> You can try comparing chip registers (ethtool -d eth0) in the working
>>>> state (before a suspend) and in the broken state (after a resume).
>>>> Maybe there will be some obvious in the difference.
>>>>
>>>> The same goes for the PCI configuration (lspci -d :8168 -vv).
>>>>
>>> Maciej suggested comparing the output from lspci -vv for the ethernet device. They are identical.
>>>
>>> Both Maciej and Heiner suggested comparing the output from "ethtool -d" pre and post suspend. Again, they are identical.
>>> Heiner specifically suggested looking at the RxConfig. The value of that is 0x0002870e both pre and post suspend.
>>>
>> Hmm, this is very weird, especially taking into account that in your original
>> report you state that removing the call to rtl_init_rxcfg() from rtl_hw_start()
>> fixes the issue. rtl_init_rxcfg() deals with the RxConfig register only and
>> register values seem to be the same before and after resume. So how can the
>> chip behave differently?
>> So far my best guess is that some chip quirk causes it to accept writes to
>> register RxConfig, but to misinterpret or ignore the written value.
>> So far your report is the only one (affecting RTL8411), but we don't know
>> whether other chip versions are affected too.
> 
> Also, it is interesting that even if one removes a call to
> rtl_init_rxcfg() from rtl_hw_start() the RxConfig register will still get
> written to moments later by rtl_set_rx_mode().
> 
> The only chip accesses in the meantime seems to be a write to TxConfig by
> rtl_set_tx_config_registers() and then a read of RxConfig plus two writes
> to MAR0 earlier in rtl_set_rx_mode().
> 
> My proposals are:
> 1) Try swapping "rtl_init_rxcfg(tp);" and "rtl_set_tx_config_registers(tp);"
> in rtl_hw_start().
> Maybe the chip does not like sometimes that RxConfig is written before
> TxConfig.
> 

This change made no difference. Networking still dies if I open a browser or leave ping running long enough.

> 2) Check the original value of RxConfig (after a resume) before
> rtl_init_rxcfg() overwrites it (compile tested only):
> --- r8169.c.ori
> +++ r8169.c
> @@ -5155,6 +5155,9 @@
>  	/* Initially a 10 us delay. Turned it into a PCI commit. - FR */
>  	RTL_R8(tp, IntrMask);
>  	RTL_W8(tp, ChipCmd, CmdTxEnb | CmdRxEnb);
> +
> +	pr_notice("RxConfig before init was %.8x\n",
> +		(unsigned int)RTL_R32(tp, RxConfig));
>  	rtl_init_rxcfg(tp);
>  	rtl_set_tx_config_registers(tp);
>  
> 
> This should be the value that you got when you removed the call to
> rtl_init_rxcfg() for testing.
> Now, knowing the "right" value you can experiment with what rtl_init_rxcfg()
> writes (under the "default:" label for your NIC model).
> 

This might be more interesting. Through a combination of viewing the output from pr_notice() and the output from
"ethtool -d", I can see RxConfig with the following values

	During boot:	0x00028700
	Before suspend:	0x0002870e
	During resume:	0x00024000
	Post resume:	0x0002870e

As I did with 4.18.10 early on in the process, I removed the call to rtl_init_rxcfg() from rtl_hw_start() and rebuilt,
installed and rebooted. Now I see the following values:

	During boot:	0x00028700
	Before suspend:	0x0002870e
	During resume:	0x00024000
	Post resume:	0x0002400e

As with 4.18.10, networking now appears to be stable after the resume. Starting a browser results in my homepage being
displayed and I've spent a few minutes surfing with no interruptions. Similarly, ping runs without stopping. I simply
don't know enough to know what might now be enabled or disabled by this change in value, but hopefully it will provide a
clue to someone as to what is going on.

Chris

> Hope this helps,
> Maciej
> 
