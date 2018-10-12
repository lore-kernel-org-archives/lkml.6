Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C33FC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D732086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="XfAaxtD9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D732086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbeJLQtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:49:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbeJLQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:49:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id p24-v6so5878184pff.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 02:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v4FSUVXu1SzpnXhAuPjq3tST2Iu7ZzQotn2pM6oeOA4=;
        b=XfAaxtD9Rn6s4nphRsNKKVcsvRiuVKlgi1ixvkCJ5IUtnE1Nbi6lp30zD9oFVLSN39
         PbhdPNWp6JbNpkeAtz0FpnsQYA19w/1Yeoyb7bOcZlClZ7q3hwoB5GTcgduZsSDT3FVX
         PaGN+7s75Xv8b6wcasOqwxngSVDJXKMZXA8QMhgRz2rcxcKYCN+8yTTZOPI0ljAF+kDO
         iFSHoaVO7jRt7cviVpWbcC5+vpfGO+ChtTW755JeJYR4esNFuRTHu5hAW9iv4UrAJh5e
         lW/XSI1zKz2ooTPvGb6146VeMcyy3iKpGONF95NLEQPH5yR6wWB6Ftd9KFjHp7XD/NYW
         w8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v4FSUVXu1SzpnXhAuPjq3tST2Iu7ZzQotn2pM6oeOA4=;
        b=T1eQDPRdRgcqpij0wJr381b5u4Go9iq/yGQTuEbWeEh9sLlQnPKpNUdS6hPn5YD0HS
         ljJ+FXkryTD66+xJhlEOn6w0aS1sLXcMJrJZS3jdmpWim6ynGjml9PHmcCwhq8wXU+5b
         om7wS2pmuBpULpwH7+cV2pziKYIqV9OUlr2nhcW6eqlAG3je7FgLYEueoj/qz3MeE8x3
         SZ82+KOpz41qLdmtYD7PQlBQX6M5u9R6+v7GZxrfUaZve07OWJC/o+Ns4ICFoYbrGE3P
         rD79BL5Vo8Yn8JdgFAc+1X3qDvBhNeWjASuPpq7l34moVAjmi8v8u6DJyzpG03XPwGTj
         bnHw==
X-Gm-Message-State: ABuFfoip1uD0DdoCPmR6UG+zbCcFFZeoHLUltWKmjQM3p4lmeVwtuLO/
        bSz2JT1hqp3/8TjK3fITEjucaIap+4C/0w==
X-Google-Smtp-Source: ACcGV63ThGFDXE4pXKD40eNM40ladSalgNXYeUOi5eEw0L2wj2dQ/Ybg4PoYpKQXOjfJ1rjLp9zd5g==
X-Received: by 2002:a63:7e1c:: with SMTP id z28-v6mr4821454pgc.190.1539335884854;
        Fri, 12 Oct 2018 02:18:04 -0700 (PDT)
Received: from [10.16.144.1] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id h14-v6sm1173278pfn.80.2018.10.12.02.18.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 02:18:04 -0700 (PDT)
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
 <b294cbba-24a0-939d-98e8-d1483e3688a1@igel.co.jp>
 <4918ed7c-4c63-6f19-530b-8e16b0c496d4@redhat.com>
From:   ake <ake@igel.co.jp>
Message-ID: <1aff0ad2-9d63-6d38-6b25-5c681eafdfb2@igel.co.jp>
Date:   Fri, 12 Oct 2018 18:18:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <4918ed7c-4c63-6f19-530b-8e16b0c496d4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月12日 17:23, Jason Wang wrote:
> 
> 
> On 2018年10月12日 12:30, ake wrote:
>>
>> On 2018年10月11日 22:06, Jason Wang wrote:
>>>
>>> On 2018年10月11日 18:22, ake wrote:
>>>> On 2018年10月11日 18:44, Jason Wang wrote:
>>>>> On 2018年10月11日 15:51, Ake Koomsin wrote:
>>>>>> commit 713a98d90c5e ("virtio-net: serialize tx routine during reset")
>>>>>> disabled the virtio tx before going to suspend to avoid a use after
>>>>>> free.
>>>>>> However, after resuming, it causes the virtio_net device to lose its
>>>>>> network connectivity.
>>>>>>
>>>>>> To solve the issue, we need to enable tx after resuming.
>>>>>>
>>>>>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine during
>>>>>> reset")
>>>>>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>>>>>> ---
>>>>>>     drivers/net/virtio_net.c | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index dab504ec5e50..3453d80f5f81 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>>>>>> virtio_device *vdev)
>>>>>>         }
>>>>>>           netif_device_attach(vi->dev);
>>>>>> +    netif_start_queue(vi->dev);
>>>>> I believe this is duplicated with netif_tx_wake_all_queues() in
>>>>> netif_device_attach() above?
>>>> Thank you for your review.
>>>>
>>>> If both netif_tx_wake_all_queues() and netif_start_queue() result in
>>>> clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
>>>> conditions in netif_device_attach() is not satisfied?
>>> Yes, maybe. One case I can see now is when the device is down, in this
>>> case netif_device_attach() won't try to wakeup the queue.
>>>
>>>>    Without
>>>> netif_start_queue(), the virtio_net device does not resume properly
>>>> after waking up.
>>> How do you trigger the issue? Just do suspend/resume?
>> Yes, simply suspend and resume.
>>
>> Here is how I trigger the issue:
>>
>> 1) Start the Virtual Machine Manager GUI program.
>> 2) Create a guest Linux OS. Make sure that the guest OS kernel is
>>     >= 4.12. Make sure that it uses virtio_net as its network device.
>>     In addition, make sure that the video adapter is VGA. Otherwise,
>>     waking up with the virtual power button does not work.
>> 3) After installing the guest OS, log in, and test the network
>>     connectivity by ping the host machine.
>> 4) Suspend. After this, the screen is blank.
>> 5) Resume by hitting the virtual power button. The login screen
>>     appears again.
>> 6) Log in again. The guest loses its network connection.
>>
>> In my test:
>> Guest: Ubuntu 16.04/18.04 with kernel 4.15.0-36-generic
>> Host: Ubuntu 16.04 with kernel 4.15.0-36-generic/4.4.0-137-generic
> 
> I can not reproduce this issue if virtio-net interface is up in guest
> before the suspend. I'm using net-next.git and qemu master. But I do
> reproduce when virtio-net interface is down in guest before suspend,
> after resume, even if I make it up, the network is still lost.
> 
> I think the interface is up in your case, but please confirm this.

If you mean the interface state before I hit the suspend button,
the answer is yes. The interface is up before I suspend the guest
machine.

Note that my current QEMU version is QEMU emulator version 2.5.0
(Debian 1:2.5+dfsg-5ubuntu10.32).

I will try with net-next.git and qemu master later and see if I can
reproduce the issue.

>>
>>>> Is it better to report this as a bug first?
>>> Nope, you're very welcome to post patch directly.
>>>
>>>> If I am to do more
>>>> investigation, what areas should I look into?
>>> As you've figured out, you can start with why netif_tx_wake_all_queues()
>>> were not executed?
>>>
>>> (Btw, does the issue disappear if you move netif_tx_disable() under the
>>> check of netif_running() in virtnet_freeze_down()?)
>> The issue disappears if I move netif_tx_disable() under the check of
>> netif_running() in virtnet_freeze_down(). Moving netif_tx_disable()
>> is probably better as its logic is consistent with
>> netif_device_attach() implementation. If you are OK with this idea,
>> I will submit another patch.
> 
> I think the it helps for the case when interface is down before suspend.
> But it's still unclear why it help even if the interface is up
> (netif_running() is true).
> 
> Please submit a patch but we should figure out why it help for a up
> interface as well.
> 
> Thanks
> 
>>
>>> Thanks
>>>
>>>> Best Regards
>>>> Ake Koomsin
>>>>
>> Best Regards
> 
