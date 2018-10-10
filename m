Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 236DC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 22:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fWXtOnz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236DC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeJKFzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 01:55:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38739 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbeJKFzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 01:55:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so7311265wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 15:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X3/ROLmV7cm7Col0elidk/IDl3yKAc1NI12KaZ3V1gY=;
        b=fWXtOnz9oaxxQ8hDCrGSXG0WtdWKuNKJ0WFNixUrwPIbzmN5RJRT3gw+xWlJi45+0Y
         +n5vGJF2X7dreI1nZvJhcYd3iAH2k9sl7bZ70sB/DY566XvDl3j7BjLDeo1hjdwdRjaK
         FKJhQiPKnSiMPHNHPlRkrZ/2ggfdV98ZyiqF545Vt/ZQJcHhZpGSzpIWb+mhzOSvr4oc
         BaEVgsOqNfLeCuJbaj7QxzESWX85FGc/jJcbFQHfWHOmIoVGstOUQstmM7FXGBgIY5Aw
         KGxEtxlGmgSaqZFN4qPWYGnUwKbwE98xs55IRalXtZKuipts7SMBHQdEciVyfh+vPtk3
         mepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X3/ROLmV7cm7Col0elidk/IDl3yKAc1NI12KaZ3V1gY=;
        b=DCVAMsk0kaJ6eOaCfRGSj3U856iTuMSR0PvW6uROc53hUM6Tf80Na43Bui4F1dvd47
         1BMgyyxE/kcE6kiNz4ojJ7F2UqtXZALv4SoEhu/50RQdZ/YCECaM9QduLYtkuaze0QFN
         pn8ZF5sZ8ZHp1VGv44RYsOpmgkPobdkZCCppZkeocOoVQI2fiSXgitI7QD4/IGyxYrIq
         JZ4exsQGlHBrfZOeZ+i02cBQo2QMUrf+oUxG1IZwxcV9ng7jpZLxeRfkGQH+lMR8NSDq
         iG4nmBcC6oSSyLgCMs5I0dVuPgeaXGMYhmzNoyeUXJx+VlhwLVFvOgLfZbTTg5PSmfn/
         9qKg==
X-Gm-Message-State: ABuFfohDxgKwOGDamq0XfXm68nkeWDqa+8TTzFMMEJ2Sy7QeGECOkq32
        tJ+UvcyOx0o/vEqUiKMxdzBeX7VQ
X-Google-Smtp-Source: ACcGV60L/BcSza7g7jB4rOLviWlluaF+5AJCuz4cral9f6gbidFeQBH9pKXXzDIqgDgt4uzrrTzZsw==
X-Received: by 2002:a1c:a9ce:: with SMTP id s197-v6mr2279498wme.82.1539210670883;
        Wed, 10 Oct 2018 15:31:10 -0700 (PDT)
Received: from [192.168.0.20] ([94.1.125.110])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm22493252wmv.6.2018.10.10.15.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 15:31:09 -0700 (PDT)
From:   Chris Clayton <chris2553@googlemail.com>
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
Message-ID: <c1b09d33-f2f0-337e-6e85-0ec035cbf179@googlemail.com>
Date:   Wed, 10 Oct 2018 23:30:55 +0100
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

This might be more interesting. Through combination of viewing the output from pr_notice() and the output from "ethtool
-d", I can see RxConfig with the following values

	During boot:	0x00028700
	Before suspend:	0x0002870e
	During resume:	0x00024000
	Post resume:	0x0002870e

I then removed the call to rtl_init_rxcfg() from rtl_hw_start() and rebuilt, installed and rebooted. Now I see the
following values:

	During boot:	0x00028700
	Before suspend:	0x0002870e
	During resume:	0x00024000
	Post resume:	0x0002870e

> 
> Hope this helps,
> Maciej
> 
