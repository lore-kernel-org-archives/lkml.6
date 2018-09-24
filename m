Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1E8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23D020C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfqL7xEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B23D020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbeIXXyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:54:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40060 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbeIXXyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:54:02 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so2604687pgm.7;
        Mon, 24 Sep 2018 10:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U2BjFNYHswqbXR/eHRSbKWK04LhiJ6bF0d1SAvIxFZw=;
        b=FfqL7xEZ1Aseo4EQMHVQYU/mGUtOtThP+mG7CL6TB3U1fL68K8+iFzQCePpcE9FyvR
         Lt9vZpdmS65sNuDMcautELpcSpPn2lvhOA9BB2519pjBtHwThdEZSUvIYyRIWZgoN5ig
         n11iIHihIPXmNhoKHyWnTeo/u4puxOvxHKm7E7lekZCI7zs5FyeHWfShslgfsDKiDw4U
         UiRD8lwYSZ9BlkzaNITN4kQ8cXcAHCvkqiukPHjrKPrqGxeM6PSLahXcjTpFqbAmdl6h
         +bkTW2kb4mp5oaJd0yslxyN/b8CmC1EytetcLih7+rHXsoGN9936Qlw32ZE3D6ARLbaT
         yKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U2BjFNYHswqbXR/eHRSbKWK04LhiJ6bF0d1SAvIxFZw=;
        b=HFxy+3dr2kasegA5KTG0tObezDJgUO3KI+bdyrvlqREse26NIU53h3eo3s9d8GlbzQ
         4JRG+2VpqAHbOjUIegka4guNhuOrqpyUvHO7ACWOKPdtVC8JahREgwciJ382Y977P8Yn
         KyxVUsoONVB2GJtxPfUAh/j8dk1oP8nIXB9SyM9FwmtNucTj+Cq5gTCcl9650wU2gqHD
         XunpZ2gGkYrSRrCHMDnUeua/A5GQsoVpYmpqVl0rIyd28FkSUne4gco8MhSOkwlyA5xw
         M1AJfNG07EZ8/dhZLGtQfTK9qtRERD/ac+GQZ6P4ax4YIcUOF7p5Mf5Xp1DmARL12LII
         A5fA==
X-Gm-Message-State: APzg51AbbD8ns697G1Q9C9jUP7oxF5dv0PnMp5Y1feycWM3E69pRzqiy
        RTw9qE2CXWVV6QBNVUnWizzUfKmn
X-Google-Smtp-Source: ANB0VdZ+ccIiEHISqx2JIIHeFe6VnnYokJbL8XJbrPxgy3ubgza74gUsIUxHkZji3yOnyTolxwLf0Q==
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr11390493pfb.29.1537811443675;
        Mon, 24 Sep 2018 10:50:43 -0700 (PDT)
Received: from [192.168.2.145] (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id g5-v6sm53885622pfc.77.2018.09.24.10.50.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:50:42 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aefb6b78-4923-0259-0f3a-2ce3b95ca456@gmail.com>
Date:   Mon, 24 Sep 2018 20:50:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180924111047.GP21032@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/18 2:10 PM, Thierry Reding wrote:
> On Mon, Sep 24, 2018 at 03:41:52AM +0300, Dmitry Osipenko wrote:
>> GART is a simple IOMMU provider that has single address space. There is
>> no need to setup global clients list and manage it for tracking of the
>> active domain, hence lot's of code could be safely removed and replaced
>> with a simpler alternative.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/tegra-gart.c | 157 +++++++++----------------------------
>>  1 file changed, 39 insertions(+), 118 deletions(-)
>>
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 306e9644a676..7182445c3b76 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -19,7 +19,6 @@
>>  
>>  #include <linux/io.h>
>>  #include <linux/iommu.h>
>> -#include <linux/list.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/slab.h>
>> @@ -42,30 +41,20 @@
>>  #define GART_PAGE_MASK						\
>>  	(~(GART_PAGE_SIZE - 1) & ~GART_ENTRY_PHYS_ADDR_VALID)
>>  
>> -struct gart_client {
>> -	struct device		*dev;
>> -	struct list_head	list;
>> -};
>> -
>>  struct gart_device {
>>  	void __iomem		*regs;
>>  	u32			*savedata;
>>  	u32			page_count;	/* total remappable size */
>>  	dma_addr_t		iovmm_base;	/* offset to vmm_area */
>>  	spinlock_t		pte_lock;	/* for pagetable */
>> -	struct list_head	client;
>> -	spinlock_t		client_lock;	/* for client list */
>> +	spinlock_t		dom_lock;	/* for active domain */
>> +	unsigned int		active_devices;	/* number of active devices */
>>  	struct iommu_domain	*active_domain;	/* current active domain */
>>  	struct device		*dev;
>>  
>>  	struct iommu_device	iommu;		/* IOMMU Core handle */
>>  };
>>  
>> -struct gart_domain {
>> -	struct iommu_domain domain;		/* generic domain handle */
>> -	struct gart_device *gart;		/* link to gart device   */
>> -};
>> -
>>  static struct gart_device *gart_handle; /* unique for a system */
>>  
>>  static bool gart_debug;
>> @@ -73,11 +62,6 @@ static bool gart_debug;
>>  #define GART_PTE(_pfn)						\
>>  	(GART_ENTRY_PHYS_ADDR_VALID | ((_pfn) << PAGE_SHIFT))
>>  
>> -static struct gart_domain *to_gart_domain(struct iommu_domain *dom)
>> -{
>> -	return container_of(dom, struct gart_domain, domain);
>> -}
>> -
>>  /*
>>   * Any interaction between any block on PPSB and a block on APB or AHB
>>   * must have these read-back to ensure the APB/AHB bus transaction is
>> @@ -166,128 +150,69 @@ static inline bool gart_iova_range_valid(struct gart_device *gart,
>>  static int gart_iommu_attach_dev(struct iommu_domain *domain,
>>  				 struct device *dev)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>>  	struct gart_device *gart = gart_handle;
>> -	struct gart_client *client, *c;
>> -	int err = 0;
>> -
>> -	client = kzalloc(sizeof(*c), GFP_KERNEL);
>> -	if (!client)
>> -		return -ENOMEM;
>> -	client->dev = dev;
>> -
>> -	spin_lock(&gart->client_lock);
>> -	list_for_each_entry(c, &gart->client, list) {
>> -		if (c->dev == dev) {
>> -			dev_err(gart->dev, "GART: %s is already attached\n",
>> -				dev_name(dev));
>> -			err = -EINVAL;
>> -			goto fail;
>> -		}
>> -	}
>> -	if (gart->active_domain && gart->active_domain != domain) {
>> -		dev_err(gart->dev,
>> -			"GART: Only one domain can be active at a time\n");
>> -		err = -EINVAL;
>> -		goto fail;
>> -	}
>> -	gart->active_domain = domain;
>> -	gart_domain->gart = gart;
>> -	list_add(&client->list, &gart->client);
>> -	spin_unlock(&gart->client_lock);
>> -	dev_dbg(gart->dev, "GART: Attached %s\n", dev_name(dev));
>> -	return 0;
>> +	int ret = 0;
>>  
>> -fail:
>> -	kfree(client);
>> -	spin_unlock(&gart->client_lock);
>> -	return err;
>> -}
>> +	spin_lock(&gart->dom_lock);
>>  
>> -static void __gart_iommu_detach_dev(struct iommu_domain *domain,
>> -				    struct device *dev)
>> -{
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> -	struct gart_client *c;
>> -
>> -	list_for_each_entry(c, &gart->client, list) {
>> -		if (c->dev == dev) {
>> -			list_del(&c->list);
>> -			kfree(c);
>> -			if (list_empty(&gart->client)) {
>> -				gart->active_domain = NULL;
>> -				gart_domain->gart = NULL;
>> -			}
>> -			dev_dbg(gart->dev, "GART: Detached %s\n",
>> -				dev_name(dev));
>> -			return;
>> -		}
>> +	if (gart->active_domain && gart->active_domain != domain) {
>> +		ret = -EBUSY;
> 
> This omits the error message and returns -EBUSY instead of -EINVAL. Was
> this intended? For what it's worth, I do agree with the changes, it's
> just that I think you could've made those in the earlier patch that
> introduced them.

The message isn't really needed and EBUSY seems fit better than EINVAL here.

> But this is all one series and the end result looks fine, so no need to
> be that picky.

Good, thanks.

>> +	} else if (dev->archdata.iommu != domain) {
>> +		dev->archdata.iommu = domain;
>> +		gart->active_domain = domain;
>> +		gart->active_devices++;
>>  	}
>>  
>> -	dev_err(gart->dev, "GART: Couldn't find %s to detach\n",
>> -		dev_name(dev));
>> +	spin_unlock(&gart->dom_lock);
>> +
>> +	return ret;
>>  }
>>  
>>  static void gart_iommu_detach_dev(struct iommu_domain *domain,
>>  				  struct device *dev)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> +	struct gart_device *gart = gart_handle;
>> +
>> +	spin_lock(&gart->dom_lock);
>>  
>> -	spin_lock(&gart->client_lock);
>> -	__gart_iommu_detach_dev(domain, dev);
>> -	spin_unlock(&gart->client_lock);
>> +	if (dev->archdata.iommu == domain) {
>> +		dev->archdata.iommu = NULL;
>> +
>> +		if (--gart->active_devices == 0)
>> +			gart->active_domain = NULL;
>> +	}
>> +
>> +	spin_unlock(&gart->dom_lock);
>>  }
>>  
>>  static struct iommu_domain *gart_iommu_domain_alloc(unsigned type)
>>  {
>> -	struct gart_domain *gart_domain;
>> -	struct gart_device *gart;
>> +	struct gart_device *gart = gart_handle;
>> +	struct iommu_domain *domain;
>>  
>>  	if (type != IOMMU_DOMAIN_UNMANAGED)
>>  		return NULL;
>>  
>> -	gart = gart_handle;
>> -	if (!gart)
>> -		return NULL;
>> -
>> -	gart_domain = kzalloc(sizeof(*gart_domain), GFP_KERNEL);
>> -	if (!gart_domain)
>> -		return NULL;
>> -
>> -	gart_domain->domain.geometry.aperture_start = gart->iovmm_base;
>> -	gart_domain->domain.geometry.aperture_end = gart->iovmm_base +
>> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
>> +	if (domain) {
>> +		domain->geometry.aperture_start = gart->iovmm_base;
>> +		domain->geometry.aperture_end = gart->iovmm_base +
>>  					gart->page_count * GART_PAGE_SIZE - 1;
>> -	gart_domain->domain.geometry.force_aperture = true;
>> +		domain->geometry.force_aperture = true;
>> +	}
>>  
>> -	return &gart_domain->domain;
>> +	return domain;
>>  }
>>  
>>  static void gart_iommu_domain_free(struct iommu_domain *domain)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> -
>> -	if (gart) {
>> -		spin_lock(&gart->client_lock);
>> -		if (!list_empty(&gart->client)) {
>> -			struct gart_client *c, *tmp;
>> -
>> -			list_for_each_entry_safe(c, tmp, &gart->client, list)
>> -				__gart_iommu_detach_dev(domain, c->dev);
>> -		}
>> -		spin_unlock(&gart->client_lock);
>> -	}
>> -
>> -	kfree(gart_domain);
>> +	kfree(domain);
>>  }
> 
> Doesn't this now make it possible to free a potentially active domain?

Yes, don't do it. I can add a WARN_ON() here, though I think IOMMU core
should be the one taking care about that.

>>  
>>  static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
>>  			  phys_addr_t pa, size_t bytes, int prot)
>>  {
>> -	struct gart_domain *gart_domain = to_gart_domain(domain);
>> -	struct gart_device *gart = gart_domain->gart;
>> +	struct gart_device *gart = gart_handle;
> 
> Hmm... this now introduces more uses of the gart_handle that I hoped we
> could get rid of. I think we could still keep around struct gart_domain
> and just make sure it is unique. The small amounts of casting here seem
> mostly harmless to me, especially since they will be nops, so we end up
> with just one dereference to get at the struct gart_device. I think the
> benefits of not having this global variable around are worth the one
> dereference here.

What are the benefits? I don't see anything other than the pedantic oddity.

I've removed gart_domain in the end because it is an extra code (and
consumed resources) without any benefit. Let's keep that part as it is
now. I'll be happy to change that code if you'll explain why it is worth
it.
