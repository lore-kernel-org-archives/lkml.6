Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20FBC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF65D2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfA1Nvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:51:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45628 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbfA1Nvk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:51:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB73D80D;
        Mon, 28 Jan 2019 05:51:39 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 925413F59C;
        Mon, 28 Jan 2019 05:51:38 -0800 (PST)
Subject: Re: [PATCH] irqchip/gic-v3-its: Lock its device list during find and
 create its device
To:     Zheng Xiang <zhengxiang9@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
References: <20190126061624.5260-1-zhengxiang9@huawei.com>
 <86bm438x8n.wl-marc.zyngier@arm.com>
 <27e0b952-111f-f221-bcd7-1a7ceb2840b5@huawei.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <0dc03914-4c8a-4fa1-fb67-f51936c54836@arm.com>
Date:   Mon, 28 Jan 2019 13:51:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <27e0b952-111f-f221-bcd7-1a7ceb2840b5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2019 07:13, Zheng Xiang wrote:
> Hi Marc,
> 
> Thanks for your review.
> 
> On 2019/1/26 19:38, Marc Zyngier wrote:
>> Hi Zheng,
>>
>> On Sat, 26 Jan 2019 06:16:24 +0000,
>> Zheng Xiang <zhengxiang9@huawei.com> wrote:
>>>
>>> Currently each PCI device under a PCI Bridge shares the same device id
>>> and ITS device. Assume there are two PCI devices call its_msi_prepare
>>> concurrently and they are both going to find and create their ITS
>>> device. There is a chance that the later one couldn't find ITS device
>>> before the other one creating the ITS device. It will cause the later
>>> one to create a different ITS device even if they have the same
>>> device_id.
>>
>> Interesting finding. Is this something you've actually seen in practice
>> with two devices being probed in parallel? Or something that you found
>> by inspection?
> 
> Yes, I find this problem after analyzing the reason of VM hung. At last, I
> find that the virtio-gpu cannot receive the MSI interrupts due to sharing
> a same event_id as virtio-serial.
> 
> See https://lkml.org/lkml/2019/1/10/299 for the bug report.
> 
> This problem can be reproducted with high probability by booting a Qemu/KVM
> VM with a virtio-serial controller and a virtio-gpu adding to a PCI Bridge
> and also adding some delay before creating ITS device.

Fair enough. Do you mind sharing your QEMU command line? It'd be useful
if I could reproduce it here (and would give me a way to check that it
doesn't regress).

> 
>>
>> The whole RID aliasing is such a mess, I wish we never supported
>> it. Anyway, comments below.
>>
>>>
>>> Signed-off-by: Zheng Xiang <zhengxiang9@huawei.com>
>>> ---
>>>  drivers/irqchip/irq-gic-v3-its.c | 52 +++++++++++++++-------------------------
>>>  1 file changed, 19 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>>> index db20e99..397edc8 100644
>>> --- a/drivers/irqchip/irq-gic-v3-its.c
>>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>>> @@ -2205,25 +2205,6 @@ static void its_cpu_init_collections(void)
>>>  	raw_spin_unlock(&its_lock);
>>>  }
>>>  
>>> -static struct its_device *its_find_device(struct its_node *its, u32 dev_id)
>>> -{
>>> -	struct its_device *its_dev = NULL, *tmp;
>>> -	unsigned long flags;
>>> -
>>> -	raw_spin_lock_irqsave(&its->lock, flags);
>>> -
>>> -	list_for_each_entry(tmp, &its->its_device_list, entry) {
>>> -		if (tmp->device_id == dev_id) {
>>> -			its_dev = tmp;
>>> -			break;
>>> -		}
>>> -	}
>>> -
>>> -	raw_spin_unlock_irqrestore(&its->lock, flags);
>>> -
>>> -	return its_dev;
>>> -}
>>> -
>>>  static struct its_baser *its_get_baser(struct its_node *its, u32 type)
>>>  {
>>>  	int i;
>>> @@ -2321,7 +2302,7 @@ static bool its_alloc_vpe_table(u32 vpe_id)
>>>  static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>  					    int nvecs, bool alloc_lpis)
>>>  {
>>> -	struct its_device *dev;
>>> +	struct its_device *dev = NULL, *tmp;
>>>  	unsigned long *lpi_map = NULL;
>>>  	unsigned long flags;
>>>  	u16 *col_map = NULL;
>>> @@ -2331,6 +2312,24 @@ static struct its_device *its_create_device(struct its_node *its, u32 dev_id,
>>>  	int nr_ites;
>>>  	int sz;
>>>  
>>> +	raw_spin_lock_irqsave(&its->lock, flags);
>>> +	list_for_each_entry(tmp, &its->its_device_list, entry) {
>>> +		if (tmp->device_id == dev_id) {
>>> +			dev = tmp;
>>> +			break;
>>> +		}
>>> +	}
>>> +	if (dev) {
>>> +		/*
>>> +		 * We already have seen this ID, probably through
>>> +		 * another alias (PCI bridge of some sort). No need to
>>> +		 * create the device.
>>> +		 */
>>> +		pr_debug("Reusing ITT for devID %x\n", dev_id);
>>> +		raw_spin_unlock_irqrestore(&its->lock, flags);
>>> +		return dev;
>>> +	}
>>> +
>>>  	if (!its_alloc_device_table(its, dev_id))
>>
>> You're now performing all sort of allocations in an atomic context,
>> which is pretty horrible (and the kernel will shout at you for doing
>> so).
>>
>> We could probably keep the current logic and wrap it around a mutex
>> instead, which would give us the appropriate guarantees WRT allocations.
>> Something along those lines (untested):>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index db20e992a40f..99feb62e63ba 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -97,9 +97,14 @@ struct its_device;
>>   * The ITS structure - contains most of the infrastructure, with the
>>   * top-level MSI domain, the command queue, the collections, and the
>>   * list of devices writing to it.
>> + *
>> + * alloc_lock has to be taken for any allocation that can happen at
>> + * run time, while the spinlock must be taken to parse data structures
>> + * such as the device list.
>>   */
>>  struct its_node {
>>  	raw_spinlock_t		lock;
>> +	struct mutex		alloc_lock;
>>  	struct list_head	entry;
>>  	void __iomem		*base;
>>  	phys_addr_t		phys_base;
>> @@ -2421,6 +2426,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>  	struct its_device *its_dev;
>>  	struct msi_domain_info *msi_info;
>>  	u32 dev_id;
>> +	int err = 0;
>>  
>>  	/*
>>  	 * We ignore "dev" entierely, and rely on the dev_id that has
>> @@ -2443,6 +2449,7 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>  		return -EINVAL;
>>  	}
>>  
>> +	mutex_lock(&its->alloc_lock);
>>  	its_dev = its_find_device(its, dev_id);
>>  	if (its_dev) {
>>  		/*
>> @@ -2455,11 +2462,14 @@ static int its_msi_prepare(struct irq_domain *domain, struct device *dev,
>>  	}
>>  
>>  	its_dev = its_create_device(its, dev_id, nvec, true);
>> -	if (!its_dev)
>> -		return -ENOMEM;
>> +	if (!its_dev) {
>> +		err = -ENOMEM;
>> +		goto out;
>> +	}
>>  
>>  	pr_debug("ITT %d entries, %d bits\n", nvec, ilog2(nvec));
>>  out:
>> +	mutex_unlock(&its->alloc_lock);
>>  	info->scratchpad[0].ptr = its_dev;
>>  	return 0;
> 
> Should it return *err* here?

Absolutely. Does it fix the problem for you?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
