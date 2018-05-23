Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-353908-1527090480-2-18363833722212990049
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527090480; b=TUNFl8PsU4MK6+bHEhgGFPIybBatanqfflVMBcbsifditeRZe7
    1mEIKa/FeLs79TAwYxqi2ZccQQCo3DrUPPRrMGODXgh/zRHX24yjAOUeRuF+0+rl
    9oGbyWDnSAkhjYMpRwf9OEFkN/PwwE3r4ue9JQKw02ySCLDF8qetMxphHUQuZ4na
    0HgRRZDWnYULTCVMpQtk6pjnJnqCsRbGn2GLR2nWKXn7QpiOCEVAiQRRPa9K1IRX
    rEwUmdf2Up3LtJPh/+vLXrv67Ih7XqaGpXpRrXHqRDp5gIxr/FSbuqJUpdrSAGgz
    vyJNg6jc1hiOqybnLvr5c0YRh6uTkXx4PmGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=to:cc:references:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1527090480; bh=JBlS8/d+6eEsi2m
    rSdxLaqGzhLccLRWFx6N5y/RReUo=; b=c5LieMha+YuuHLMNQsxy5aVrgnDs4la
    COm7Vw+xoEB3nlExCFxwEqGjbnieGdS6ssq+OmH+N8HmFiORUWfZiepK6tS2hEnS
    zUxA5L6of5Av6KsHxYHxWmQflaB3Fa07kwXyhhRynQkuguNTiCa0lRpORVxDY18C
    Lf8HgOYYazZ5lgMYvOXlIu+mEauPN44V45djjCogjHTMQuWbjulWjrbRMVZ9UOlj
    AXWcSC2fAAojElFUUNaFBU4POHg1qqzLJ/mcM+QUA5wLGRt38urIi2ya/k0BHIti
    m1fjb05AS0Vbqp+Yfd/Pk8PpzGMMeWWnHa7v391bQz16vrTrK1YpvPA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=deltatee.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=deltatee.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=deltatee.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOyKFgpicbdy1syJHswhIvMp0w0xCTujJsp9fSq+ITCnvwlSvtZdqf+bfgI7TbjPhezU3FECJsngmm9KYU6U7wS7hLIR078S3MNGxDXu8GdubcW7Kdic
    L84joKKvcb7d+dQTkLQBmxf9A/wegsGKSI1pIrElLnfBw+cjyQgpL0xM8wkoXBnpioNsXfZJbP84HHCJXNL86S65i+WIgmACf9lU5cXKePttMEgRmvp5rCBl
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=GNNyLltzuY_lN1S3OHgA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751668AbeEWPr5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 11:47:57 -0400
Received: from ale.deltatee.com ([207.54.116.67]:55920 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751597AbeEWPr4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 11:47:56 -0400
To: Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc: stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <152705221686.21414.771870778478134768.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152705223396.21414.13388289577013917472.stgit@dwillia2-desk3.amr.corp.intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8f0cae82-130f-8a64-cfbd-fda5fd76bb79@deltatee.com>
Date: Wed, 23 May 2018 09:47:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <152705223396.21414.13388289577013917472.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, jglisse@redhat.com, hch@lst.de, stable@vger.kernel.org, akpm@linux-foundation.org, dan.j.williams@intel.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on ale.deltatee.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-7.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,SARE_FWDLOOK autolearn=ham autolearn_force=no
        version=3.4.1
Subject: Re: [PATCH v2 3/7] mm, devm_memremap_pages: Fix shutdown handling
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 22/05/18 11:10 PM, Dan Williams wrote:
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 7b4899c06f49..b5e894133cf6 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -106,6 +106,7 @@ typedef void (*dev_page_free_t)(struct page *page, void *data);
>   * @altmap: pre-allocated/reserved memory for vmemmap allocations
>   * @res: physical address range covered by @ref
>   * @ref: reference count that pins the devm_memremap_pages() mapping
> + * @kill: callback to transition @ref to the dead state
>   * @dev: host device of the mapping for debug
>   * @data: private data pointer for page_free()
>   * @type: memory type: see MEMORY_* in memory_hotplug.h
> @@ -117,13 +118,15 @@ struct dev_pagemap {
>  	bool altmap_valid;
>  	struct resource res;
>  	struct percpu_ref *ref;
> +	void (*kill)(struct percpu_ref *ref);
>  	struct device *dev;
>  	void *data;
>  	enum memory_type type;
>  };
>  
>  #ifdef CONFIG_ZONE_DEVICE
> -void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
> +void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap,
> +		void (*kill)(struct percpu_ref *));


It seems redundant to me to have the kill pointer both passed in as an
argument and passed in as part of pgmap... Why not just expect the user
to set it in the *pgmap that's passed in just like we expect ref to be
set ahead of time?

Another thought (that may be too forward looking) is to pass the
dev_pagemap struct to the kill function instead of the reference. That
way, if some future user wants to do something extra on kill they can
use container_of() to get extra context to work with.

Thanks,

Logan
