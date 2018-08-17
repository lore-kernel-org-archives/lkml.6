Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C7AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A1221473
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A1221473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbeHQLVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:21:23 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:41432 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeHQLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:21:23 -0400
Received: by mail-wr1-f52.google.com with SMTP id j5-v6so6344120wrr.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2/EyHCBjvSgoAA8rSu4LMziSKWtsd85lo6X3gAjej4=;
        b=KJLqIoZwEpnyF1SkE06hsi/eEIXALRzn4mSMhvjSFPP7Wnq6FusVgOgwj7MJzG7EF7
         j0BpfNltA5pQ6QBGN8ArnuZW/9Caw3rLMdKP7Vw+DUyTm97f4wO1A+A6al/jDJjcrIIw
         78tvUtWuSqJNmwsrJfZQ5iBPt9KoIJom2sUCa59uOmMMD/OWLhiQkWHzyfxfLrkL68bs
         Nc2T+ETWFf9Vsc1makslH1pGHJPOlhce2grAjhYRG2NZYzUPhSRO/seIMoPBzEfgAJ5Q
         ZtPHMTpx0BwfDpbg/7Thq7/FMUvuucZj7l/OmLoNr/7t1TWraEGGcYn4jw391swBDSS6
         mINg==
X-Gm-Message-State: AOUpUlFltvJ8Kg5xbI99/ZpFHbakfeSE2wZk0pOQD4mu1vFAYRimYvH4
        QtGZOoT5aPA3Z4X9QPRZ70I=
X-Google-Smtp-Source: AA+uWPxZEAsWMN4RMCuLeLd9j6+5WUR9jpIuvtHadXHY3mjWx2hxdeJanSjSvWyT7eBZTQm+D4ZOPw==
X-Received: by 2002:adf:f906:: with SMTP id b6-v6mr18213012wrr.28.1534493935451;
        Fri, 17 Aug 2018 01:18:55 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id y5-v6sm4012014wrd.5.2018.08.17.01.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 01:18:54 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id E0F1012492E; Fri, 17 Aug 2018 10:18:53 +0200 (CEST)
Date:   Fri, 17 Aug 2018 10:18:53 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Kemi Wang <kemi.wang@intel.com>,
        David Rientjes <rientjes@google.com>,
        Jia He <jia.he@hxt-semitech.com>,
        Oscar Salvador <osalvador@suse.de>,
        Petr Tesarik <ptesarik@suse.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mathieu Malaterre <malat@debian.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ross Zwisler <zwisler@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v1 5/5] mm/memory_hotplug: print only with DEBUG_VM in
 online/offline_pages()
Message-ID: <20180817081853.GB17638@techadventures.net>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180816100628.26428-6-david@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  failed_addition:
> +#ifdef CONFIG_DEBUG_VM
>  	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
>  		 (unsigned long long) pfn << PAGE_SHIFT,
>  		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
> +#endif

I have never been sure about this.
IMO, if I fail to online pages, I want to know I failed.
I think that pr_err would be better than pr_debug and without CONFIG_DEBUG_VM.

But at least, if not, envolve it with a CONFIG_DEBUG_VM, but change pr_debug to pr_info.

> +#ifdef CONFIG_DEBUG_VM
>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed\n",
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
> +#endif

Same goes here.

Thanks
-- 
Oscar Salvador
SUSE L3
