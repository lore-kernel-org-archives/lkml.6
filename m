Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9E3ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9937214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 09:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9937214C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbeJQR2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 13:28:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38546 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 13:28:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so1389119wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 02:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8NWKvPBEgnJ+ukZLy12IRpoW4u88DekVuBxWeZE7qN8=;
        b=gthxv2mZZZYL8wpzArKJwKrPgJ0ygn3ZruasVSpLX1SVAIeg+95PNsNA6aEQRu7f4/
         AO7m7EzcByIxhKGSlPYUx07rreLKNfX/h7zCUzBKUGsTwTPSywLdp+OXxJlU/4GU+7ih
         H+xFq2ELjHodY3THywqOl9Vm6D4KBnjByJMplIkFLaZbLnxFhuLwFJfXqVXcq6+RDET9
         n/k8gtJiRiJjFJ4EhvpXt7vC3rvoV8vFSyo3ZDRSPNmamyxOjeH8b9Zb6zh/WXfzMPiX
         PJ7sHCdJyQ8qPBhT3gvl1HAPfQsVSc+VPgtJ8AKT3QJKwaS/GYYDynuYRMINWPmKZuz4
         EHMQ==
X-Gm-Message-State: ABuFfoioegfAM3RAbDd8bGBbiSz1XMyWrDB0RTATOAtvbaEJi+3GSs/B
        CLdEo8Y6Yb73dqRP4onZLM8=
X-Google-Smtp-Source: ACcGV60isc1E9rhUebSPx0vMTgO9ZLDQh56yfVc+o43osZfM60cu+C+DVTJW0TdgG8ARNexwVjIIdw==
X-Received: by 2002:a1c:ee8d:: with SMTP id j13-v6mr2013558wmi.125.1539768812834;
        Wed, 17 Oct 2018 02:33:32 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id g10-v6sm13814446wrv.49.2018.10.17.02.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 02:33:32 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 7AEFB1259B4; Wed, 17 Oct 2018 11:33:31 +0200 (CEST)
Date:   Wed, 17 Oct 2018 11:33:31 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com,
        dan.j.williams@intel.com, yasu.isimatu@gmail.com,
        rppt@linux.vnet.ibm.com, malat@debian.org,
        linux-kernel@vger.kernel.org, pavel.tatashin@microsoft.com,
        jglisse@redhat.com, Jonathan.Cameron@huawei.com, rafael@kernel.org,
        dave.jiang@intel.com, linux-mm@kvack.org,
        alexander.h.duyck@linux.intel.com,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/5] mm/memory_hotplug: Create add/del_device_memory
 functions
Message-ID: <20181017093331.GA25724@techadventures.net>
References: <20181015153034.32203-1-osalvador@techadventures.net>
 <20181015153034.32203-3-osalvador@techadventures.net>
 <d0a12eb5-3824-8d25-75f8-3e62f1e81994@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0a12eb5-3824-8d25-75f8-3e62f1e81994@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	/*
> >  	 * For device private memory we call add_pages() as we only need to
> >  	 * allocate and initialize struct page for the device memory. More-
> > @@ -1096,20 +1100,17 @@ static int hmm_devmem_pages_create(struct hmm_devmem *devmem)
> >  	 * want the linear mapping and thus use arch_add_memory().
> >  	 */
> 
> Some parts of this comment should be moved into add_device_memory now.
> (e.g. we call add_pages() ...)

I agree.

> > +#ifdef CONFIG_ZONE_DEVICE
> > +int del_device_memory(int nid, unsigned long start, unsigned long size,
> > +				struct vmem_altmap *altmap, bool mapping)
> > +{
> > +	int ret;
> 
> nit: personally I prefer short parameters last in the list.

I do not have a strong opinion here.
If people think that long parameters should be placed at the end because
it improves readability, I am ok with moving them there.
 
> Can you document for both functions that they should be called with the
> memory hotplug lock in write?

Sure, I will do that in the next version, once I get some more feedback.

> Apart from that looks good to me.

Thanks for reviewing it David ;-)!
May I assume your Reviewed-by here (if the above comments are addressed)?

Thanks
-- 
Oscar Salvador
SUSE L3
