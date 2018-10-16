Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5FAC070C3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D8D2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 10:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=igel-co-jp.20150623.gappssmtp.com header.i=@igel-co-jp.20150623.gappssmtp.com header.b="0jOgB6IE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56D8D2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=igel.co.jp
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeJPSFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 14:05:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44714 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJPSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 14:05:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so10619279pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 03:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IUVCMKvetlwAwJywpB3C8dJqDf0eAgED2WQE8oEFMDs=;
        b=0jOgB6IE3JEkhkB7mo3yKi5tn6d+2GXYYq5xfIbu7HCtIiHsrLhTxP9m55QgCVABbH
         BtdaLC81i92+dJqVOf3IFZNzz6UwSZxCaD4KTY4wuoObi3tkmfvqBsuvte4/U4aplz2P
         HoI/KiQLrdYeZLKCTA5HwL1lt4jFdkO3OTU3NTDRe6EdUp4kzFMYjETQT5x+NYCBRk98
         /qJHv32+AM7Ol0HYgxr+aWXmipWtuWQ9e6/3HAiOPW0fEd3Naje2yGPUa8N9vbumMUke
         lZgZPBRLZ28s1g2rWqEBrMfoAL683TgqBScZulmRvwfgRhZLXLVoTLMVO86si9BOE28o
         +d2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IUVCMKvetlwAwJywpB3C8dJqDf0eAgED2WQE8oEFMDs=;
        b=m/73HGJuIokJDmTJMTOTCwwwjlAY1XfzjFJcv/+8whwfckJQDapxkyHkRoiEnBV8Ml
         bPNAFRWjNX3Jl0qfRzBl3quypy5o41G9ZZBJ3ACNYIjT6nBaQknFEWyR8ICgk4ClI6dV
         DkJnPLW2B3BsXnpebbaS8KWdZHrakfeOyakqTmNH58bOvA2AJ3FNJMugl6XAkobfNDua
         iXPLbCwf2C31Z3gneLWAgu57LIb9Leq1RswgDRU9wdBGAJNANhHXg8UzmVq5hTXYjaaG
         MM8aTegn9rawxLgBk5q3jKsMn8vFDJzvDbTAJjm3D6QJTEqfhyJ3IyN0g5/U6rnPBLh8
         UVow==
X-Gm-Message-State: ABuFfohyuv7u2+3C34pdAONljGySDlyYoo4JLzdNfRcRwKtofIiX71mE
        aWD/hG/8uovEo749YySxdTun7gfXLK9J9g==
X-Google-Smtp-Source: ACcGV60aoMJPUiLu5oQ7RP5QmWMjuBAZfL36/5Brc5baPwB7+PpOZbEgUm6wMYSwpLGAPlHpT1gOKg==
X-Received: by 2002:a63:fd09:: with SMTP id d9-v6mr20062119pgh.164.1539684931822;
        Tue, 16 Oct 2018 03:15:31 -0700 (PDT)
Received: from [10.16.144.1] (napt.igel.co.jp. [219.106.231.132])
        by smtp.gmail.com with ESMTPSA id b3-v6sm21221151pfc.178.2018.10.16.03.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 03:15:31 -0700 (PDT)
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
 <1aff0ad2-9d63-6d38-6b25-5c681eafdfb2@igel.co.jp>
 <e2baaccc-4ead-e61d-fc1e-d79435012e1c@igel.co.jp>
 <024619cc-9b1b-dac2-18cc-5d757a76b1e3@redhat.com>
From:   ake <ake@igel.co.jp>
Message-ID: <0e8b0747-cc9f-8863-2ee1-2b032d6c0fae@igel.co.jp>
Date:   Tue, 16 Oct 2018 19:15:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <024619cc-9b1b-dac2-18cc-5d757a76b1e3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年10月16日 17:53, Jason Wang wrote:
> 
> On 2018/10/15 下午6:08, ake wrote:
>>
>> On 2018年10月12日 18:18, ake wrote:
>>>
>>> On 2018年10月12日 17:23, Jason Wang wrote:
>>>>
>>>> On 2018年10月12日 12:30, ake wrote:
>>>>> On 2018年10月11日 22:06, Jason Wang wrote:
>>>>>> On 2018年10月11日 18:22, ake wrote:
>>>>>>> On 2018年10月11日 18:44, Jason Wang wrote:
>>>>>>>> On 2018年10月11日 15:51, Ake Koomsin wrote:
>>>>>>>>> commit 713a98d90c5e ("virtio-net: serialize tx routine during
>>>>>>>>> reset")
>>>>>>>>> disabled the virtio tx before going to suspend to avoid a use
>>>>>>>>> after
>>>>>>>>> free.
>>>>>>>>> However, after resuming, it causes the virtio_net device to
>>>>>>>>> lose its
>>>>>>>>> network connectivity.
>>>>>>>>>
>>>>>>>>> To solve the issue, we need to enable tx after resuming.
>>>>>>>>>
>>>>>>>>> Fixes commit 713a98d90c5e ("virtio-net: serialize tx routine
>>>>>>>>> during
>>>>>>>>> reset")
>>>>>>>>> Signed-off-by: Ake Koomsin <ake@igel.co.jp>
>>>>>>>>> ---
>>>>>>>>>      drivers/net/virtio_net.c | 1 +
>>>>>>>>>      1 file changed, 1 insertion(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>>>>> index dab504ec5e50..3453d80f5f81 100644
>>>>>>>>> --- a/drivers/net/virtio_net.c
>>>>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>>>>> @@ -2256,6 +2256,7 @@ static int virtnet_restore_up(struct
>>>>>>>>> virtio_device *vdev)
>>>>>>>>>          }
>>>>>>>>>            netif_device_attach(vi->dev);
>>>>>>>>> +    netif_start_queue(vi->dev);
>>>>>>>> I believe this is duplicated with netif_tx_wake_all_queues() in
>>>>>>>> netif_device_attach() above?
>>>>>>> Thank you for your review.
>>>>>>>
>>>>>>> If both netif_tx_wake_all_queues() and netif_start_queue() result in
>>>>>>> clearing __QUEUE_STATE_DRV_XOFF, then is it possible that some
>>>>>>> conditions in netif_device_attach() is not satisfied?
>>>>>> Yes, maybe. One case I can see now is when the device is down, in
>>>>>> this
>>>>>> case netif_device_attach() won't try to wakeup the queue.
>>>>>>
>>>>>>>     Without
>>>>>>> netif_start_queue(), the virtio_net device does not resume properly
>>>>>>> after waking up.
>>>>>> How do you trigger the issue? Just do suspend/resume?
>>>>> Yes, simply suspend and resume.
>>>>>
>>>>> Here is how I trigger the issue:
>>>>>
>>>>> 1) Start the Virtual Machine Manager GUI program.
>>>>> 2) Create a guest Linux OS. Make sure that the guest OS kernel is
>>>>>      >= 4.12. Make sure that it uses virtio_net as its network device.
>>>>>      In addition, make sure that the video adapter is VGA. Otherwise,
>>>>>      waking up with the virtual power button does not work.
>>>>> 3) After installing the guest OS, log in, and test the network
>>>>>      connectivity by ping the host machine.
>>>>> 4) Suspend. After this, the screen is blank.
>>>>> 5) Resume by hitting the virtual power button. The login screen
>>>>>      appears again.
>>>>> 6) Log in again. The guest loses its network connection.
>>>>>
>>>>> In my test:
>>>>> Guest: Ubuntu 16.04/18.04 with kernel 4.15.0-36-generic
>>>>> Host: Ubuntu 16.04 with kernel 4.15.0-36-generic/4.4.0-137-generic
>>>> I can not reproduce this issue if virtio-net interface is up in guest
>>>> before the suspend. I'm using net-next.git and qemu master. But I do
>>>> reproduce when virtio-net interface is down in guest before suspend,
>>>> after resume, even if I make it up, the network is still lost.
>>>>
>>>> I think the interface is up in your case, but please confirm this.
>>> If you mean the interface state before I hit the suspend button,
>>> the answer is yes. The interface is up before I suspend the guest
>>> machine.
>>>
>>> Note that my current QEMU version is QEMU emulator version 2.5.0
>>> (Debian 1:2.5+dfsg-5ubuntu10.32).
>>>
>>> I will try with net-next.git and qemu master later and see if I can
>>> reproduce the issue.
>> Update. I tried with net-next and qemu master. Interestingly, the result
>> is different from yours. The network is lost even if the virtio_net
>> interface is up before suspending.
>>
>> Host: Ubuntu 16.04 with net-next kernel (default configuration)
>> Guest: Ubuntu 18.04 with net-next kernel (default configuration)
>> Qemu: master
>> Qemu command:
>> qemu-system-x86_64 -cpu host -m 2048 -enable-kvm \
>> -bios /usr/share/OVMF/OVMF_CODE.fd \
>> -drive file=/var/lib/libvirt/images/virtio_test.qcow2,if=virtio \
>> -netdev user,id=hostnet0 \
>> -device virtio-net-pci,netdev=hostnet0 \
>> -device VGA,id=video0,vgamem_mb=16 \
>> -global PIIX4_PM.disable_s3=1 \
>> -global PIIX4_PM.disable_s4=1 -monitor stdio
> 
> 
> Interesting, just notice you're using userspace network. To isolate the
> issue, can you retry with e.g tap or e1000 to make sure it's not a fault
> of slirp or virito-net?

I will try.

> Thanks
> 

There is another thing that I want to discuss. I notice that
netif_device_detach() should result in setting __QUEUE_STATE_DRV_XOFF if
the network interface is running. By calling netif_tx_disable() after
netif_device_detach(), isn't it redundant in case of the network
interface is running? If the goal is to serialize tx routine, would
netif_tx_lock() and net_tx_unlock() are more appropriate? Like this:

netif_tx_lock(vi->dev);
netif_device_detach(vi->dev);
netif_tx_unlock(vi->dev);

Currently, netif_tx_disable() seems to disturb the symmetry of
netif_device_detach() and netif_device_attach(). That is the reason
why you can reproduce the problem when the interface is down before
suspending.
