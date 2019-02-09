Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E481C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26BE20823
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 09:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUQot31b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIJKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 04:10:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38072 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfBIJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 04:10:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id v26so7396153wmh.3;
        Sat, 09 Feb 2019 01:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ctc6blCHPsKyW7yMr7t3QRmGzfxJI5J/OpTnSPXhKTo=;
        b=RUQot31bsn1AzyKZJEP7RKikwkk8Le5WpMkPjpTBylNy7YW3042Yt8Aoi7BU9MRY6H
         GosPsaD+2B1sJNd419x4ebvBRSBaDS39Ac0099s2zmL248kHOwRMOL9n48Y3hx7Zx+nC
         hOZrCqrBehmCKNxuZkvSgHMHg+h5Pbg7j+QugVeDOc9Au925BJf57eHocfZ1pjIOXNs0
         QtPLVvP7vRdoiZ98SEo5JOB8oI6IVp6NVlbto86R/rmFV5HaQMgSv6/wbdfb+l/JFpn3
         1v0UnHWGvp3julGm0TgvfOQOqCaxA6XApXmyYeDDNtt3IuEp4nKQ+u8LOXZ2laJUHWSt
         x+FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ctc6blCHPsKyW7yMr7t3QRmGzfxJI5J/OpTnSPXhKTo=;
        b=qOoHH/iScg/AKnpAgH0J4jaFHlR6yxSvJJeBc3fQZKLY0RPc76cEzaH8Nc+LzI0K+s
         9LqFFaKK26nJX51kwpJwDf020yNfC5w01jui6c0ATIN4qBkheltbW5sqvzcdOTSBAFQK
         fsCUyRRRo57qC/fCSreaTFfd8nWey+OGfGI+Ae8nmwzsgtWPbLnrhNJ3zyizfBQqgB0n
         8POdN7T9qxSqS/wPzofS0BXMH/w95hBiY3bKzmf1EzS7ZqxpoXLRdwEEhIkb3fE4Nc1i
         5V85U5zG+hoDhP1GpfPAXQGuA566T8D3G80gn4T7Ujo/5mly2y4A41xd13GMAvT3cksN
         SODw==
X-Gm-Message-State: AHQUAub41GBWgIaMq+6CxQbLmQajbUJU6VatYq+blmamxjwG7u65kZgh
        4lHFv1+Pnp66v4679c2wQPeQRgAd
X-Google-Smtp-Source: AHgI3IYNT9G5wJn8TTO0TISJRGAkaOWUrZtcftRwHuP5TiT4uT6qzOlifAga92eP1Li/nbJkX4ooSA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr2273797wmf.72.1549703415702;
        Sat, 09 Feb 2019 01:10:15 -0800 (PST)
Received: from ?IPv6:2003:ea:8bf1:e200:aca4:3d:8205:4c97? (p200300EA8BF1E200ACA4003D82054C97.dip0.t-ipconnect.de. [2003:ea:8bf1:e200:aca4:3d:8205:4c97])
        by smtp.googlemail.com with ESMTPSA id v13sm11859567wra.54.2019.02.09.01.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 01:10:14 -0800 (PST)
Subject: Re: Linux 5.0 regression: rtl8169 / kernel BUG at
 lib/dynamic_queue_limits.c:27!
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Sander Eikelenboom <linux@eikelenboom.it>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
References: <6c389fde-4c8d-300b-8c3c-300d6105c30a@eikelenboom.it>
 <0f605e50-56fe-06b5-9b66-6aed89a608ce@gmail.com>
 <471e550b-c227-22e6-19fd-5f9abd450e5f@eikelenboom.it>
 <1265d424-4943-e571-a74b-b1512ebec179@gmail.com>
 <059e59c6-2264-fd5c-068f-3656e39539c1@eikelenboom.it>
 <140d0df7-1775-5457-aa03-b21ece250a72@gmail.com>
 <e6423f51-42cc-e49f-bb48-85ea922f01b6@gmail.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <aa7eb814-ebf7-ffa5-ce61-317b9bbf2394@gmail.com>
Date:   Sat, 9 Feb 2019 10:02:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <e6423f51-42cc-e49f-bb48-85ea922f01b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.02.2019 00:09, Eric Dumazet wrote:
> 
> 
> On 02/08/2019 01:50 PM, Heiner Kallweit wrote:
>> On 08.02.2019 22:45, Sander Eikelenboom wrote:
>>> On 08/02/2019 22:22, Heiner Kallweit wrote:
>>>> On 08.02.2019 21:55, Sander Eikelenboom wrote:
>>>>> On 08/02/2019 19:52, Heiner Kallweit wrote:
>>>>>> On 08.02.2019 19:29, Sander Eikelenboom wrote:
>>>>>>> L.S.,
>>>>>>>
>>>>>>> While testing a linux 5.0-rc5 kernel (with some patches on top but they don't seem related) under Xen i the nasty splat below, 
>>>>>>> that I haven encountered with Linux 4.20.x.
>>>>>>>
>>>>>>> Unfortunately I haven't got a clear reproducer for this and bisecting could be nasty due to another (networking related) kernel bug.
>>>>>>>
>>>>>>> If you need more info, want me to run a debug patch etc., please feel free to ask.
>>>>>>>
>>>>>> Thanks for the report. However I see no change in the r8169 driver between
>>>>>> 4.20 and 5.0 with regard to BQL code. Having said that the root cause could
>>>>>> be somewhere else. Therefore I'm afraid a bisect will be needed.
>>>>>
>>>>> Hmm i did some diging and i think:
>>>>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>>>>> 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
>>>>> 620344c43edfa020bbadfd81a144ebe5181fc94f net: core: add __netdev_sent_queue as variant of __netdev_tx_sent_queue
>>>>>
>>>> You're right. Thought this was added in 4.20 already.
>>>> The BQL code pattern I copied from the mlx4 driver and so far I haven't heard about
>>>> this issue from any user of physical hw. And due to the fact that a lot of mainboards
>>>> have onboard Realtek network I have quite a few testers out there.
>>>> Does the issue occur under specific circumstances like very high load?
>>>
>>> Yep, the box is already quite contented with the Xen VM's and if I remember correctly it occurred while kernel compiling
>>> on the host.
>>>
>>>> If indeed the xmit_more patch causes the issue, I think we have to involve Eric Dumazet
>>>> as author of the underlying changes.
>>>
>>> It could also be the barriers weren't that unneeded as assumed.
>>
>> The barriers were removed after adding xmit_more handling. Therefore it would be good to
>> test also with only 
>> bd7153bd83b806bfcc2e79b7a6f43aa653d06ef3 r8169: remove unneeded mmiowb barriers
>> removed.
>>
>>> Since we are almost at RC6 i took the liberty to CC Eric now.
>>>
>> Sure, thanks.
>>
>>> BTW am i correct these patches are merely optimizations ?
>>
>> Yes
>>
>>> If so and concluding they revert cleanly, perhaps it should be considered at this point in the RC's
>>> to revert them for 5.0 and try again for 5.1 ?
>>>
>> Before removing both it would be good to test with only the barrier-removal removed.
>>
> 
> Commit 2e6eedb4813e34d8d84ac0eb3afb668966f3f356 r8169: make use of xmit_more and __netdev_sent_queue
> looks buggy to me, since the skb might have been freed already on another cpu when you call
> 
> You could try :
> 
> diff --git a/drivers/net/ethernet/realtek/r8169.c b/drivers/net/ethernet/realtek/r8169.c
> index 3624e67aef72c92ed6e908e2c99ac2d381210126..f907d484165d9fd775e81bf2bfb9aa4ddedb1c93 100644
> --- a/drivers/net/ethernet/realtek/r8169.c
> +++ b/drivers/net/ethernet/realtek/r8169.c
> @@ -6070,6 +6070,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>         dma_addr_t mapping;
>         u32 opts[2], len;
>         bool stop_queue;
> +       bool door_bell;
>         int frags;
>  
>         if (unlikely(!rtl_tx_slots_avail(tp, skb_shinfo(skb)->nr_frags))) {
> @@ -6116,6 +6117,8 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>         /* Force memory writes to complete before releasing descriptor */
>         dma_wmb();
>  
> +       door_bell = __netdev_sent_queue(dev, skb->len, skb->xmit_more);
> +
>         txd->opts1 = rtl8169_get_txd_opts1(opts[0], len, entry);
>  
>         /* Force all memory writes to complete before notifying device */
> @@ -6127,7 +6130,7 @@ static netdev_tx_t rtl8169_start_xmit(struct sk_buff *skb,
>         if (unlikely(stop_queue))
>                 netif_stop_queue(dev);
>  
> -       if (__netdev_sent_queue(dev, skb->len, skb->xmit_more)) {
> +       if (door_bell) {
>                 RTL_W8(tp, TxPoll, NPQ);
>                 mmiowb();
>         }
> 
Thanks a lot for checking and for the proposed fix.
Sander, can you try with this patch on top of 5.0-rc5 w/o removing two two commits?

> 
> .
> 
Heiner
