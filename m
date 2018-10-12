Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A20F7C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6B720645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 04:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="hfl6Yu75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E6B720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeJLMBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 08:01:06 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43767 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeJLMBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 08:01:05 -0400
Received: by mail-pl1-f196.google.com with SMTP id 30-v6so5260922plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 21:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=23rfPD2OIGJcvI4IJwZ6xc8GNGqaZZG0MvxBm+pBoF4=;
        b=hfl6Yu75zIbMZYm6vxS/YMBqXNkVxZVyoJGY7UNme4vkTfhcTSXJr/WsC8d5WN570z
         ebNhiJh6g2WXOmLRIzJKopkYx6IeB6I7nAJJlRW/3hSjsIDdJzHl15K2ozbbje1F3b0O
         7L5csOwRALFIbJ639TJDtLGv1EJk/zWrXCW9BXCv3O0s6X6n+ZKrTNnV/RN6Bzb/p31p
         uJVhnCkjbF7upGSgsrjC6WaXfUDbGjyw2HwY6YuHWa907pt5yJ6Fwk9Zz7QVMdxcN+bv
         BoJpq4yhG4h2r388kk4DsW7AFVqCpykmem4cSu9hVR7ydukp+NlDDNHhFxP4m52Xzr+e
         s/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=23rfPD2OIGJcvI4IJwZ6xc8GNGqaZZG0MvxBm+pBoF4=;
        b=EHaXAnsFE07v2FmK1tZtn5vwQiap3GMne0XtKdfvRlsFlIPUQzoAGPobGVrNuvxykM
         Vbamoy51/iQFZTrvPUNmXT6v5N4QLFq2yvfBondlkxO94Y9mWNKnt+IdCrrrSDOEOKfj
         lgfVkkoafjR3OJtuenvU3ZB4/A6kcb6i+u1wxCve6WvgmtI3WB2UVWHA2acTXZwm/wr4
         NYQYri7X6NE2o6sjFihwLGHm+LMMcYV9O3EWou5sRNIKHy3W7JP6MZvpIJcXCUDNGQTt
         6DKAU5oqIX3yf8iOvElzoageLG4in+WLYOePBddmpePvbRCsAvtyBEcFzbnKBT9DXOCy
         SrpQ==
X-Gm-Message-State: ABuFfoh28rwQUvhutzSL1IIdcLWaGJP6rjdZnYgvilHj8MPJ1tTTXrgM
        5akMN+Df5/u9a51H8A0dwSxXSMV5Opv3Zw==
X-Google-Smtp-Source: ACcGV63jSLH6iYq4CzvD/k73yZPgUZ535qnwrXavyVwpUzndPUNjJ84QlWUaZf6Qfo3UyphX9s4CZQ==
X-Received: by 2002:a17:902:f096:: with SMTP id go22mr4358738plb.235.1539318635634;
        Thu, 11 Oct 2018 21:30:35 -0700 (PDT)
Received: from [10.16.144.1] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id n79-v6sm46844pfk.19.2018.10.11.21.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 21:30:34 -0700 (PDT)
Subject: Re: [PATCH] virtio_net: enable tx after resuming from suspend
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181011075127.2608-1-ake@igel.co.jp>
 <dd530053-efab-b661-3423-1faaab8fb12f@redhat.com>
 <7e87b140-79ae-c79e-40ed-dc76b38eeae4@igel.co.jp>
 <a156fd7e-e36e-e4e9-c240-3117ecc5b1b4@redhat.com>
From:   ake <ake@igel.co.jp>
Message-ID: <b294cbba-24a0-939d-98e8-d1483e3688a1@igel.co.jp>
Date:   Fri, 12 Oct 2018 13:30:32 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a156fd7e-e36e-e4e9-c240-3117ecc5b1b4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月11日 22:06, Jason Wang wrote:
> 
> 
> On 2018年10月11日 18:22, ake wrote:
>>
>> On 2018年10月11日 18:44, Jason Wang wrote:
>>>
>>> On 2018年10月11日 15:51, Ake Koomsin wrote:
>>>> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>>>> disabled the virtio tx before going to suspend to avoid a use after
>>>> free.
>>>> However, after resuming, it causes the virtio_net device to lose its
>>>> network connectivity.
>>>>
>>>> To solve the issue, we need to enable tx after resuming.
>>>>
>>>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during
>>>> reset")
>>>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>>>> ---
>>>>    drivers/net/virtio_net.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index dab504ec5e50..3453d80f5f81 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>>>> virtio_device *vdev)
>>>>        }
>>>>          netif_device_attach(vi->dev);
>>>> +    netif_start_queue(vi->dev);
>>> I believe this is duplicated with netif_tx_wake_all_queues() in
>>> netif_device_attach() above?
>> Thank you for your review.
>>
>> If both netif_tx_wake_all_queues() and netif_start_queue() result in
>> clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
>> conditions in netif_device_attach() is not satisfied?
> 
> Yes, maybe. One case I can see now is when the device is down, in this
> case netif_device_attach() won't try to wakeup the queue.
> 
>>   Without
>> netif_start_queue(), the virtio_net device does not resume properly
>> after waking up.
> 
> How do you trigger the issue? Just do suspend/resume?

Yes, simply suspend and resume.

Here is how I trigger the issue:

1) Start the Virtual Machine Manager GUI program.
2) Create a guest Linux OS. Make sure that the guest OS kernel is
   >= 4.12. Make sure that it uses virtio_net as its network device.
   In addition, make sure that the video adapter is VGA. Otherwise,
   waking up with the virtual power button does not work.
3) After installing the guest OS, log in, and test the network
   connectivity by ping the host machine.
4) Suspend. After this, the screen is blank.
5) Resume by hitting the virtual power button. The login screen
   appears again.
6) Log in again. The guest loses its network connection.

In my test:
Guest: Ubuntu 16.04/18.04 with kernel 4.15.0-36-generic
Host: Ubuntu 16.04 with kernel 4.15.0-36-generic/4.4.0-137-generic

>>
>> Is it better to report this as a bug first?
> 
> Nope, you're very welcome to post patch directly.
> 
>> If I am to do more
>> investigation, what areas should I look into?
> 
> As you've figured out, you can start with why netif_tx_wake_all_queues()
> were not executed?
> 
> (Btw, does the issue disappear if you move netif_tx_disable() under the
> check of netif_running() in virtnet_freeze_down()?)

The issue disappears if I move netif_tx_disable() under the check of
netif_running() in virtnet_freeze_down(). Moving netif_tx_disable()
is probably better as its logic is consistent with
netif_device_attach() implementation. If you are OK with this idea,
I will submit another patch.

> Thanks
> 
>>
>> Best Regards
>> Ake Koomsin
>>
> 

Best Regards
