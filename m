Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C681C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD612070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfBDKdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:33:54 -0500
Received: from foss.arm.com ([217.140.101.70]:53052 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfBDKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:33:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CACBDA78;
        Mon,  4 Feb 2019 02:33:52 -0800 (PST)
Received: from [10.1.196.62] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E47613F675;
        Mon,  4 Feb 2019 02:33:49 -0800 (PST)
Subject: Re: [RFC PATCH v4 08/13] genirq/msi: Add support for allocating
 single MSI for a device
To:     Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>
Cc:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-8-lokeshvutla@ti.com>
 <5be38277-3348-a6d9-4b67-3ead308c009a@arm.com>
 <faad8e90-2f97-1dbb-fb98-e0f1462e29c5@ti.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=marc.zyngier@arm.com; prefer-encrypt=mutual; keydata=
 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
Organization: ARM Ltd
Message-ID: <523c4a23-b5b9-ff10-051d-c90e6e8341d4@arm.com>
Date:   Mon, 4 Feb 2019 10:33:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <faad8e90-2f97-1dbb-fb98-e0f1462e29c5@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2019 10:19, Lokesh Vutla wrote:
> Hi Marc,
> 	Sorry for the delayed response. Just back from vacation.
> 
> On 17/01/19 12:00 AM, Marc Zyngier wrote:
>> On 27/12/2018 06:13, Lokesh Vutla wrote:
>>> Previously all msi for a device are allocated in one go
>>> by calling msi_domain_alloc_irq() from a bus layer. This might
>>> not be the case when a device is trying to allocate interrupts
>>> dynamically based on a request to it.
>>>
>>> So introduce msi_domain_alloc/free_irq() apis to allocate a single
>>> msi. prepare and activate operations to be handled by bus layer
>>> calling msi_domain_alloc/free_irq() apis.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> ---
>>>  include/linux/msi.h |  3 +++
>>>  kernel/irq/msi.c    | 62 +++++++++++++++++++++++++++++----------------
>>>  2 files changed, 43 insertions(+), 22 deletions(-)
>>>
>>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>>> index 784fb52b9900..474490826f8c 100644
>>> --- a/include/linux/msi.h
>>> +++ b/include/linux/msi.h
>>> @@ -301,8 +301,11 @@ int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>>>  struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
>>>   struct msi_domain_info *info,
>>>   struct irq_domain *parent);
>>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>>> + struct msi_desc *desc,  msi_alloc_info_t *arg);
>>>  int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>    int nvec);
>>> +void msi_domain_free_irq(struct msi_desc *desc);
>>>  void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
>>>  struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
>>>
>>> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
>>> index ad26fbcfbfc8..eb7459324113 100644
>>> --- a/kernel/irq/msi.c
>>> +++ b/kernel/irq/msi.c
>>> @@ -387,6 +387,35 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
>>>  return desc->msi_attrib.is_msix || desc->msi_attrib.maskbit;
>>>  }
>>>
>>> +int msi_domain_alloc_irq(struct irq_domain *domain, struct device *dev,
>>> + struct msi_desc *desc,  msi_alloc_info_t *arg)
>>> +{
>>> +struct msi_domain_info *info = domain->host_data;
>>> +struct msi_domain_ops *ops = info->ops;
>>> +int i, ret, virq;
>>> +
>>> +ops->set_desc(arg, desc);
>>> +
>>> +virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>>> +       dev_to_node(dev), arg, false,
>>> +       desc->affinity);
>>> +if (virq < 0) {
>>> +ret = -ENOSPC;
>>> +if (ops->handle_error)
>>> +ret = ops->handle_error(domain, desc, ret);
>>> +if (ops->msi_finish)
>>> +ops->msi_finish(arg, ret);
>>> +return ret;
>>> +}
>>> +
>>> +for (i = 0; i < desc->nvec_used; i++) {
>>> +irq_set_msi_desc_off(virq, i, desc);
>>> +irq_debugfs_copy_devname(virq + i, dev);
>>> +}
>>> +
>>> +return 0;
>>> +}
>>> +
>>>  /**
>>>   * msi_domain_alloc_irqs - Allocate interrupts from a MSI interrupt domain
>>>   * @domain:The domain to allocate from
>>> @@ -404,7 +433,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>  struct irq_data *irq_data;
>>>  struct msi_desc *desc;
>>>  msi_alloc_info_t arg;
>>> -int i, ret, virq;
>>> +int ret, virq;
>>>  bool can_reserve;
>>>
>>>  ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
>>> @@ -412,24 +441,9 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>  return ret;
>>>
>>>  for_each_msi_entry(desc, dev) {
>>> -ops->set_desc(&arg, desc);
>>> -
>>> -virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
>>> -       dev_to_node(dev), &arg, false,
>>> -       desc->affinity);
>>> -if (virq < 0) {
>>> -ret = -ENOSPC;
>>> -if (ops->handle_error)
>>> -ret = ops->handle_error(domain, desc, ret);
>>> -if (ops->msi_finish)
>>> -ops->msi_finish(&arg, ret);
>>> +ret = msi_domain_alloc_irq(domain, dev, desc, &arg);
>>> +if (ret)
>>>  return ret;
>>> -}
>>> -
>>> -for (i = 0; i < desc->nvec_used; i++) {
>>> -irq_set_msi_desc_off(virq, i, desc);
>>> -irq_debugfs_copy_devname(virq + i, dev);
>>> -}
>>>  }
>>>
>>>  if (ops->msi_finish)
>>> @@ -487,6 +501,12 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
>>>  return ret;
>>>  }
>>>
>>> +void msi_domain_free_irq(struct msi_desc *desc)
>>> +{
>>> +irq_domain_free_irqs(desc->irq, desc->nvec_used);
>>> +desc->irq = 0;
>>> +}
>>> +
>>>  /**
>>>   * msi_domain_free_irqs - Free interrupts from a MSI interrupt @domain associated tp @dev
>>>   * @domain:The domain to managing the interrupts
>>> @@ -503,10 +523,8 @@ void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
>>>   * enough that there is no IRQ associated to this
>>>   * entry. If that's the case, don't do anything.
>>>   */
>>> -if (desc->irq) {
>>> -irq_domain_free_irqs(desc->irq, desc->nvec_used);
>>> -desc->irq = 0;
>>> -}
>>> +if (desc->irq)
>>> +msi_domain_free_irq(desc);
>>>  }
>>>  }
>>>
>>>
>>
>> I can see some interesting issues with this API.
>>
>> At the moment, MSIs are allocated upfront, and that's usually done
>> before the driver can do anything else. With what you're suggesting
>> here, MSIs can now be allocated at any time, which sounds great. But how
>> does it work when MSIs get added/freed in parallel? I can't see any
>> locking here...
>>
>> It is also pretty nasty that the user of this API has to know about the
>> MSI descriptor. Really, nobody should have to deal with this outside of
>> the MSI layer.
>>
>> The real question is why you need to need to allocate MSIs on demand for
>> a given device. Usually, you allocate them because this is a per-CPU
>> resource, or something similar. What makes it so variable that you need
>> to resort to fine grained MSI allocation?
> 
> I added this after the discussion we had in the previous version[1] of this
> series. Let me provide the details again:
> 
> As you must be aware INTR is interrupt re-director and INTA is the interrupt
> multiplexer is the SoC. Here we are trying to address the interrupt connection
> route as below:
> Device(Global event) --> INTA --> INTR --> GIC
> 
> For the above case you suggested to have the following sw IRQ domain hierarchy:
> INTA multi MSI --> INTA  -->  INTR  --> GIC
> 
> The problem here with the INTA MSI is that all the interrupts for a device
> should be pre-allocated during the device probe time. But this is not what we
> wanted especially for the DMA case.
> 
> An example DMA ring connection would look like below[2]:
> 
>                       +---------------------+
>                        |         IA                |
> +--------+        |            +------+   |        +--------+         +------+
> | ring 1 +----->evtA+->VintX+-------->+   IR   +-- --->  GIC +-->
> +--------+       |             +------+   |        +--------+         +------+
> Linux IRQ Y
>    evtA            |                             |
>                        |                             |
>                       +----------------------+
> 
> So when a DMA client driver requests a dma channel during probe, the DMA driver
> gets a free ring in its allocated range. Then DMA driver requests MSI layer for
> an IRQ. This is why I had to introduce on demand allocation of MSIs for a device.
> 
> The reason why we avoided DMA driver to allocate interrupts during its probe as
> it is not aware of the exact no of channels that are going to be used. Also max
> allocation of interrupts will overrun the gic IRQs available to this INTA and
> the IPs that are connected to INTR directly will not get any interrupts.

But surely there is an upper bound that does exist for a given system,
right?  DMA rings are not allocated out of nowhere. Or are you saying
that when a DMA client requests DMA rings, it doesn't know how many it
wants? Or does it? I don't think this is new in any of TI's design (the
crossbar already had such limitation).

That being said, I'm open to revisiting this, but you must then
introduce the right level of mutual exclusion in core code, as the
msi_desc list now becomes much more dynamic and things would otherwise
break badly. This has implications all over the place, and probably
requires quite a bit of work (things like for_each_msi_desc_entry will
break).

Between the two solutions outlined above, the first one is much easier
to achieve than the second one.

Another avenue to explore would be to let the clients allocate as many
MSIs as they want upfront, and use the "activate" callback to actually
perform the assignment when such interrupt gets requested. In a way,
this is not that different from what x86 does with the "early
reservation, late assignment" type mechanism.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
