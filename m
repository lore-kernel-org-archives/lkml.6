Return-Path: <SRS0=Mzg6=LC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0C4C4321D
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D125820B6F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Aug 2018 12:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWX+LFEQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D125820B6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbeHSPpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Aug 2018 11:45:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44084 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Aug 2018 11:45:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so5434645pff.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Aug 2018 05:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQwO97kSF1EDfwMtlNT2yypCcbNrXj/uBNADdxUvl8c=;
        b=rWX+LFEQXmBscpESUp+egun9vwTO/tZ+wToJrcNvuSay/a7RcS7lBWiNNvTs50QZuN
         /ifZ0b6YE0zzf12PFhIH9oGQOET7sPTTbJ9/czRBt4A3pRdn2cvQ6oe5jF1735z4OdUP
         CWvIHgzOkKZ3Bektq/RCf8t4ikkc4lDAWPA2NhCZfstAlW6nGZsdXDZKy7Z/31N5Ij41
         L2Xc4RaTIiFvzFkCHvLYYbnZwz/Pbx8fjzKDohXuO0CAiJ0BJGWElShpA+t6taICobc5
         9TsxVAFhC/W6B+vuAUlIup7EFTZo6zEavOK4RtLwP2YuLz1OI1RmuYDaDo9lOvTEe+JT
         4NRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQwO97kSF1EDfwMtlNT2yypCcbNrXj/uBNADdxUvl8c=;
        b=pHGyQ0R2qgQH3MTUAfIu038udN6omH6idEy5nrwBI/ZFHTqT57iOl4bIvlcTIos2wB
         jeSHElIPz5TKxsmKvctQYtHRlzdUldD45vUqEdq2SPyoDI7uaQzREFvWs3H2iT9Lknin
         FdMnEpCUQu74YRinU1cd6x5cYQHBc/ElR5Mg9a47gKMCXHVq+O3oUSx/jqITMW3OcppS
         r3d+95gGCSboeLrjbUSq7e4EGqDHPv+r6C3R37G7eabV5O0+l7eL7slQd6K3kyz5R9VN
         qWqXWJUQpMzW+j06CtGQDCg3kSquCZ4GJJEzCzSe3NXbBkYIhgidtWvXp5ZH7kskn354
         mbcA==
X-Gm-Message-State: AOUpUlHnXayCAYJthlqLGcOyzaIs2t9AZqOoEFwy3nh0+1p8GxXoHlpT
        zs8D3sdRwtgimdpAESXQAE4=
X-Google-Smtp-Source: AA+uWPw7fQkrhFKdDC2A0QhLivWkOMTE5nchnOoqttIF10l+q41WZ4/eqBOXVSEb6z8Y3nnbgjHJmw==
X-Received: by 2002:a65:5286:: with SMTP id y6-v6mr39364655pgp.65.1534682051138;
        Sun, 19 Aug 2018 05:34:11 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v22-v6sm15046690pfi.60.2018.08.19.05.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Aug 2018 05:34:10 -0700 (PDT)
Date:   Sun, 19 Aug 2018 20:34:03 +0800
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Oscar Salvador <osalvador@techadventures.net>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
Message-ID: <20180819123403.GA22352@WeideMacBook-Pro.local>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20180816100628.26428-1-david@redhat.com>
 <20180816100628.26428-6-david@redhat.com>
 <20180817081853.GB17638@techadventures.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817081853.GB17638@techadventures.net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:18:53AM +0200, Oscar Salvador wrote:
>>  failed_addition:
>> +#ifdef CONFIG_DEBUG_VM
>>  	pr_debug("online_pages [mem %#010llx-%#010llx] failed\n",
>>  		 (unsigned long long) pfn << PAGE_SHIFT,
>>  		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
>> +#endif
>
>I have never been sure about this.
>IMO, if I fail to online pages, I want to know I failed.
>I think that pr_err would be better than pr_debug and without CONFIG_DEBUG_VM.
>
>But at least, if not, envolve it with a CONFIG_DEBUG_VM, but change pr_debug to pr_info.
>

I don't have a clear rule about these debug macro neither.

While when you look at the page related logs in calculate_node_totalpages(),
it is KERNEL_DEBUG level and without any config macro.

Maybe we should leave them at the same state?

>> +#ifdef CONFIG_DEBUG_VM
>>  	pr_debug("memory offlining [mem %#010llx-%#010llx] failed\n",
>>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1);
>> +#endif
>
>Same goes here.
>
>Thanks
>-- 
>Oscar Salvador
>SUSE L3

-- 
Wei Yang
Help you, Help me
