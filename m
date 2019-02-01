Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DEBC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520952086C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 09:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfBAJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 04:28:56 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbfBAJ2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 04:28:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C77515BE;
        Fri,  1 Feb 2019 01:28:54 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7B33F71E;
        Fri,  1 Feb 2019 01:28:53 -0800 (PST)
Subject: Re: [PATCH] irqchip/gic-v3-its: Lock its device list during find and
 create its device
To:     Zheng Xiang <zhengxiang9@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
References: <20190126061624.5260-1-zhengxiang9@huawei.com>
 <86bm438x8n.wl-marc.zyngier@arm.com>
 <27e0b952-111f-f221-bcd7-1a7ceb2840b5@huawei.com>
 <0dc03914-4c8a-4fa1-fb67-f51936c54836@arm.com>
 <505e3257-3ef6-69d4-b996-5a1e200e1246@huawei.com>
 <32354a2a-b1b3-e03b-c486-c17aee1bed8d@huawei.com>
 <6c44c2d4-d507-e01a-eef5-894ae71209ef@arm.com>
 <f19624cb-b55d-ae30-f479-3079d818887e@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <23664397-eb28-4362-b292-091ba190be5e@arm.com>
Date:   Fri, 1 Feb 2019 09:28:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <f19624cb-b55d-ae30-f479-3079d818887e@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2019 06:41, Zheng Xiang wrote:
> 
> On 2019/1/31 23:12, Marc Zyngier wrote:
>> Hi Zeng,
>>
>> On 31/01/2019 14:47, Zheng Xiang wrote:
>>> Hi Marc,
>>>
>>> On 2019/1/29 13:42, Zheng Xiang wrote:
>>>> On 2019/1/28 21:51, Marc Zyngier wrote:
>>>>> On 28/01/2019 07:13, Zheng Xiang wrote:
>>>>>> Hi Marc,
>>>>>>
>>>>>> Thanks for your review.
>>>>>>
>>>>>> On 2019/1/26 19:38, Marc Zyngier wrote:
>>>>>>> Hi Zheng,
>>>>>>>
>>>>>>> On Sat, 26 Jan 2019 06:16:24 +0000,
>>>>>>> Zheng Xiang <zhengxiang9@huawei.com> wrote:
>>>>>>>>
>>>>>>>> Currently each PCI device under a PCI Bridge shares the same device id
>>>>>>>> and ITS device. Assume there are two PCI devices call its_msi_prepare
>>>>>>>> concurrently and they are both going to find and create their ITS
>>>>>>>> device. There is a chance that the later one couldn't find ITS device
>>>>>>>> before the other one creating the ITS device. It will cause the later
>>>>>>>> one to create a different ITS device even if they have the same
>>>>>>>> device_id.
>>>>>>>
>>>>>>> Interesting finding. Is this something you've actually seen in practice
>>>>>>> with two devices being probed in parallel? Or something that you found
>>>>>>> by inspection?
>>>>>>
>>>>>> Yes, I find this problem after analyzing the reason of VM hung. At last, I
>>>>>> find that the virtio-gpu cannot receive the MSI interrupts due to sharing
>>>>>> a same event_id as virtio-serial.
>>>>>>
>>>>>> See https://lkml.org/lkml/2019/1/10/299 for the bug report.
>>>>>>
>>>>>> This problem can be reproducted with high probability by booting a Qemu/KVM
>>>>>> VM with a virtio-serial controller and a virtio-gpu adding to a PCI Bridge
>>>>>> and also adding some delay before creating ITS device.
>>>>>
>>>>> Fair enough. Do you mind sharing your QEMU command line? It'd be useful
>>>>> if I could reproduce it here (and would give me a way to check that it
>>>>> doesn't regress).
>>>>
>>>
>>> Have you reproduced it with my QEMU command line?
>>>
>>> If so, should I send a V2 patch with your suggestion?
>>
>> I've queued the following, much more complete patch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=9791ec7df0e7b4d80706ccea8f24b6542f6059e9
>>
>> Can you check that it works for you? I didn't manage to get the right
>> timing conditions, but I also had issues getting virtio-gpu running on
>> my TX2, so one might explain the other.
>>
> 
> It works for my case, but I worried about the below lines which may
> cause memory leak.
> 
> @@ -2627,8 +2640,14 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  		irq_domain_reset_irq_data(data);
>  	}
> 
> -	/* If all interrupts have been freed, start mopping the floor */
> -	if (bitmap_empty(its_dev->event_map.lpi_map,
> +	mutex_lock(&its->dev_alloc_lock);
> +
> +	/*
> +	 * If all interrupts have been freed, start mopping the
> +	 * floor. This is conditionned on the device not being shared.
> +	 */
> +	if (!its_dev->shared &&
> +	    bitmap_empty(its_dev->event_map.lpi_map,
>  			 its_dev->event_map.nr_lpis)) {
>  		its_lpi_free(its_dev->event_map.lpi_map,
>  			     its_dev->event_map.lpi_base,
> 
> It seems that the shared its_dev would never be freed since the value of
> its_dev->shared is always *true*.

Yes, and that is on purpose. As we don't refcount the number of
interrupts that have been requested in the prepare phase, there is a
race between free and alloc. We can have the following situation:

CPU0:               CPU1:

msi_prepare:
mutex_lock()
find device()
  -> found
store its_dev
mutex_unlock()

                    its_irq_domain_free:
                    mutex_lock()
                    free_device()
                    mutex_unlock()

its_irq_domain_alloc:
use its_dev -> boom.


So the trick is not to free the its_dev structure if it shares a devid.
It is not really a leak, as the next device sharing the same devid will
pick up the same structure.

Does it make sense?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
