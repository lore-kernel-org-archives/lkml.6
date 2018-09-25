Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72868C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE415214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 13:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovw5NXKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE415214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbeIYTz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:55:26 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40442 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbeIYTzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 15:55:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id r83-v6so3782666ljr.7;
        Tue, 25 Sep 2018 06:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q10IXhdd5N0851aX4xjzc1KCNBJcJ4Kw83zMfPxrO3c=;
        b=ovw5NXKNiQzYmMpK/IDu+2mgDK1B3+kN+bFOuSgHvOD3rlniM5Fo/JibAY1hUCRP0d
         FayfmAvK/nIZoX+T0TFu2g2VCAuXguj8VvHEsjUQ8y9v2l7CA2zVqOPQ+xbJo5eeOpQw
         Ja41+hSB06IAU+eIfCovMUldL22PpB3EcaI9JJtZjdJLZtUmrDJ88Opx46b3quHVfBVJ
         EsBTipVYg4IN+fqJm3HP5emraAiaW7t+w817EFYxR91CS2NBoIb7sySi67AzLO/bbsS8
         /x4ADWrAoKryPZljk+86vzmNYLsBD2S3QAkFJhOy3nl/67SeQvTKiBODbn2+vJ/Xrjkd
         AnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q10IXhdd5N0851aX4xjzc1KCNBJcJ4Kw83zMfPxrO3c=;
        b=OZfijmI7kV++/7xhrU4rgIZen7Jx8RovcpXC0qHh2M+vPS7WaPZBey7/R0rw4rgerz
         TwIxgQNT7K1Fev0ZM3XWkzQViaq8cfTRFxkUAWlL3C9iVA+RNCSX2DdXIZGSSJI4CApI
         O8ORJ6ognR/7Hhg+C+v7FIOWEnqnokwspZ9F4HSmDWJ8UjalT9WCigWSPz4uQ7hp7Elp
         GrjRvlzWPDd/l7b12lrMJMfhU9NKdjgxzCJpnPEAWTPhlaMt+PxKLpgw9CYC1qmTPDjD
         ikGbIVNqrdsGgPC2zF0nvts7o9Eb+Q6GlI57WXs56fLlxBMS8nLxv0s0kxlidWFhdX2r
         9rBg==
X-Gm-Message-State: ABuFfoi+Simlespq5HDpNBI4cQU5EP5eadAQd6YBSWjLRkO86DHwCGO0
        k/AN2WUUTGyuh6DxOJBE+fc/lR7r
X-Google-Smtp-Source: ACcGV60aqZr8h4U+6aSSWG3OzXCIvSgFxbrcOz0xywc0U7DldJrg+45iDunR8X//AZkQ1tHtA4qHpw==
X-Received: by 2002:a2e:5719:: with SMTP id l25-v6mr967189ljb.125.1537883264424;
        Tue, 25 Sep 2018 06:47:44 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id h71-v6sm110977lfi.11.2018.09.25.06.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 06:47:43 -0700 (PDT)
Subject: Re: [PATCH v4 19/20] iommu/tegra: gart: Simplify clients-tracking
 code
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180924004153.8232-1-digetx@gmail.com>
 <20180924004153.8232-20-digetx@gmail.com> <20180924111047.GP21032@ulmo>
 <aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com> <20180925100909.GH7097@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <492a147b-0f3b-31cb-056d-60ab81f054ff@gmail.com>
Date:   Tue, 25 Sep 2018 16:47:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925100909.GH7097@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 1:09 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 08:50:35PM +0300, Dmitry Osipenko wrote:
>> On 9/24/18 2:10 PM, Thierry Reding wrote:
>>> On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
>>>> GART is a simple IOMMU provider that has single address space. There is
>>>> no need to setup global clients list and manage it for tracking of the
>>>> active domain, hence lot's of code could be safely removed and replaced
>>>> with a simpler alternative.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
>>>>  1 file changed, 39 insertions(+), 118 deletions(-)
>>>>
>>>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>>>> index 306e9644a676..7182445c3b76 100644
>>>> --- a/drivers/iommu/tegra-gart.c
>>>> +++ b/drivers/iommu/tegra-gart.c
>>>> @@ -19,7 +19,6 @@
>>>>  
>>>>  #include <linux/io.h>
>>>>  #include <linux/iommu.h>
>>>> -#include <linux/list.h>
>>>>  #include <linux/module.h>
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/slab.h>
>>>> @@ -42,30 +41,20 @@
>>>>  #define GART_PAGE_MASK						\
>>>>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>>>>  
>>>> -struct gart_client {
>>>> -	struct device		*dev;
>>>> -	struct list_head	list;
>>>> -};
>>>> -
>>>>  struct gart_device {
>>>>  	void __iomem		*regs;
>>>>  	u32			*savedata;
>>>>  	u32			page_count;	/* total remappable size */
>>>>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>>>>  	spinlock_t		pte_lock;	/* for pagetable */
>>>> -	struct list_head	client;
>>>> -	spinlock_t		client_lock;	/* for client list */
>>>> +	spinlock_t		dom_lock;	/* for active domain */
>>>> +	unsigned int		active_devices;	/* number of active devices */
>>>>  	struct iommu_domain	*active_domain;	/* current active domain */
>>>>  	struct device		*dev;
>>>>  
>>>>  	struct iommu_device	iommu;		/* IOMMU Core handle */
>>>>  };
>>>>  
>>>> -struct gart_domain {
>>>> -	struct iommu_domain domain;		/* generic domain handle */
>>>> -	struct gart_device *gart;		/* link to gart device   */
>>>> -};
>>>> -
>>>>  static struct gart_device *gart_handle; /* unique for a system */
>>>>  
>>>>  static bool gart_debug;
>>>> @@ -73,11 +62,6 @@ static bool gart_debug;
>>>>  #define GART_PTE(_pfn)						\
>>>>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
>>>>  
>>>> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
>>>> -{
>>>> -	return container_of(dom, struct gart_domain, domain);
>>>> -}
>>>> -
>>>>  /*
>>>>   * Any interaction between any block on PPSB and a block on APB or AHB
>>>>   * must have these read-back to ensure the APB/AHB bus transaction is
>>>> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
>>>>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>>>>  				 struct device *dev)
>>>>  {
>>>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>>>  	struct gart_device *gart = gart_handle;
>>>> -	struct gart_client *client, *c;
>>>> -	int err = 0;
>>>> -
>>>> -	client = kzalloc(sizeof(*c), GFP_KERNEL);
>>>> -	if (!client)
>>>> -		return -ENOMEM;
>>>> -	client->dev = dev;
>>>> -
>>>> -	spin_lock(&gart->client_lock);
>>>> -	list_for_each_entry(c, &gart->client, list) {
>>>> -		if (c->dev == dev) {
>>>> -			dev_err(gart->dev, "GART: %s is already attached\n",
>>>> -				dev_name(dev));
>>>> -			err = -EINVAL;
>>>> -			goto fail;
>>>> -		}
>>>> -	}
>>>> -	if (gart->active_domain && gart->active_domain != domain) {
>>>> -		dev_err(gart->dev,
>>>> -			"GART: Only one domain can be active at a time\n");
>>>> -		err = -EINVAL;
>>>> -		goto fail;
>>>> -	}
>>>> -	gart->active_domain = domain;
>>>> -	gart_domain->gart = gart;
>>>> -	list_add(&client->list, &gart->client);
>>>> -	spin_unlock(&gart->client_lock);
>>>> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
>>>> -	return 0;
>>>> +	int ret = 0;
>>>>  
>>>> -fail:
>>>> -	kfree(client);
>>>> -	spin_unlock(&gart->client_lock);
>>>> -	return err;
>>>> -}
>>>> +	spin_lock(&gart->dom_lock);
>>>>  
>>>> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
>>>> -				    struct device *dev)
>>>> -{
>>>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -	struct gart_device *gart = gart_domain->gart;
>>>> -	struct gart_client *c;
>>>> -
>>>> -	list_for_each_entry(c, &gart->client, list) {
>>>> -		if (c->dev == dev) {
>>>> -			list_del(&c->list);
>>>> -			kfree(c);
>>>> -			if (list_empty(&gart->client)) {
>>>> -				gart->active_domain = NULL;
>>>> -				gart_domain->gart = NULL;
>>>> -			}
>>>> -			dev_dbg(gart->dev, "GART: Detached %s\n",
>>>> -				dev_name(dev));
>>>> -			return;
>>>> -		}
>>>> +	if (gart->active_domain && gart->active_domain != domain) {
>>>> +		ret = -EBUSY;
>>>
>>> This omits the error message and returns -EBUSY instead of -EINVAL. Was
>>> this intended? For what it's worth, I do agree with the changes, it's
>>> just that I think you could've made those in the earlier patch that
>>> introduced them.
>>
>> The message isn't really needed and EBUSY seems fit better than EINVAL here.
>>
>>> But this is all one series and the end result looks fine, so no need to
>>> be that picky.
>>
>> Good, thanks.
>>
>>>> +	} else if (dev->archdata.iommu != domain) {
>>>> +		dev->archdata.iommu = domain;
>>>> +		gart->active_domain = domain;
>>>> +		gart->active_devices++;
>>>>  	}
>>>>  
>>>> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
>>>> -		dev_name(dev));
>>>> +	spin_unlock(&gart->dom_lock);
>>>> +
>>>> +	return ret;
>>>>  }
>>>>  
>>>>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>>>  				  struct device *dev)
>>>>  {
>>>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -	struct gart_device *gart = gart_domain->gart;
>>>> +	struct gart_device *gart = gart_handle;
>>>> +
>>>> +	spin_lock(&gart->dom_lock);
>>>>  
>>>> -	spin_lock(&gart->client_lock);
>>>> -	__gart_iommu_detach_dev(domain, dev);
>>>> -	spin_unlock(&gart->client_lock);
>>>> +	if (dev->archdata.iommu == domain) {
>>>> +		dev->archdata.iommu = NULL;
>>>> +
>>>> +		if (--gart->active_devices == 0)
>>>> +			gart->active_domain = NULL;
>>>> +	}
>>>> +
>>>> +	spin_unlock(&gart->dom_lock);
>>>>  }
>>>>  
>>>>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>>>  {
>>>> -	struct gart_domain *gart_domain;
>>>> -	struct gart_device *gart;
>>>> +	struct gart_device *gart = gart_handle;
>>>> +	struct iommu_domain *domain;
>>>>  
>>>>  	if (type != IOMMU_DOMAIN_UNMANAGED)
>>>>  		return NULL;
>>>>  
>>>> -	gart = gart_handle;
>>>> -	if (!gart)
>>>> -		return NULL;
>>>> -
>>>> -	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
>>>> -	if (!gart_domain)
>>>> -		return NULL;
>>>> -
>>>> -	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
>>>> -	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
>>>> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>>>> +	if (domain) {
>>>> +		domain->geometry.aperture_start = gart->iovmm_base;
>>>> +		domain->geometry.aperture_end = gart->iovmm_base +
>>>>  					gart->page_count * GART_PAGE_SIZE - 1;
>>>> -	gart_domain->domain.geometry.force_aperture = true;
>>>> +		domain->geometry.force_aperture = true;
>>>> +	}
>>>>  
>>>> -	return &gart_domain->domain;
>>>> +	return domain;
>>>>  }
>>>>  
>>>>  static void gart_iommu_domain_free(struct iommu_domain *domain)
>>>>  {
>>>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -	struct gart_device *gart = gart_domain->gart;
>>>> -
>>>> -	if (gart) {
>>>> -		spin_lock(&gart->client_lock);
>>>> -		if (!list_empty(&gart->client)) {
>>>> -			struct gart_client *c, *tmp;
>>>> -
>>>> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
>>>> -				__gart_iommu_detach_dev(domain, c->dev);
>>>> -		}
>>>> -		spin_unlock(&gart->client_lock);
>>>> -	}
>>>> -
>>>> -	kfree(gart_domain);
>>>> +	kfree(domain);
>>>>  }
>>>
>>> Doesn't this now make it possible to free a potentially active domain?
>>
>> Yes, don't do it. I can add a WARN_ON() here, though I think IOMMU core
>> should be the one taking care about that.
> 
> Yeah, might be good to have the WARN_ON() either here or in the IOMMU
> core. Force-detaching is probably a good idea, too, otherwise the users
> of the freed domain are just going to crash anyway, right? Maybe
> something to discuss more generally with Joerg.
> 
> I think in the meantime just having the WARN_ON() here is probably good
> enough. It should point out the cases where we do free the domain with
> devices still attached, which hopefully don't exist, and we can fix
> them.

Ok.

>>>>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>>>  			  phys_addr_t pa, size_t bytes, int prot)
>>>>  {
>>>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>>> -	struct gart_device *gart = gart_domain->gart;
>>>> +	struct gart_device *gart = gart_handle;
>>>
>>> Hmm... this now introduces more uses of the gart_handle that I hoped we
>>> could get rid of. I think we could still keep around struct gart_domain
>>> and just make sure it is unique. The small amounts of casting here seem
>>> mostly harmless to me, especially since they will be nops, so we end up
>>> with just one dereference to get at the struct gart_device. I think the
>>> benefits of not having this global variable around are worth the one
>>> dereference here.
>>
>> What are the benefits? I don't see anything other than the pedantic oddity.
>>
>> I've removed gart_domain in the end because it is an extra code (and
>> consumed resources) without any benefit. Let's keep that part as it is
>> now. I'll be happy to change that code if you'll explain why it is worth
>> it.
> 
> I thought I did explain. Anyway, it's always been like this, so no need
> to change it as part of this series.

Thanks.

You're saying that you want to get rid of the global variable, but
you're not saying why. Usage of global variable is more appealing with
the current driver structure.
