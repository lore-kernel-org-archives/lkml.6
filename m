Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C1CC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3282084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVmrXdDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3282084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeLKWYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:24:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43965 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbeLKWYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:24:18 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so13903162eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 14:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OR6Fb70sZOx4vYBcafTaWTBkWVsCfghWXyih0D4Vv/E=;
        b=rVmrXdDi8l0fVzqNrH5qYmFrxjQlHECEIZMhfQLEhk5E9UaE7Qa13jjE8hLWQCvwC7
         vW4U0ZANC4Xug6M5twBefeBqbixAA7yL85ibANc5f+Dp+QBVubnN0cPglDcYe8Y1ru44
         8zl7KS7PvWoAZE1WDcRdSkITvNrHogGhaVXZMRsPyC7zV/pNnUkbiZlUVDF8SBR3Atfo
         ns6EsdjJw+QC/BbFnY7Wwfq63EoNz/fIq4bDpWPUwT5EbtMDE/6sIzhhXujmjhRPQ2dI
         klvIIxFPv1e+SztqfAiDtU0pyy934yI04rCN7R28xcRCM9p5pXqePAVZDigJ6eE1gZP9
         VWYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OR6Fb70sZOx4vYBcafTaWTBkWVsCfghWXyih0D4Vv/E=;
        b=duAEv78vW3fKEbmmGwdt136LUYNuWP6G8p2k3TmTozJoQhTS4wlGiCHGlpw6bAVN1C
         HZfjBopuN4OVpMs6IDcs8cnAhLaPTfgpvYQNPI8Te6neyHA5aKiPMRuOv3GBVJ8P11ea
         lIJBWrPE+zDHmy0HVVCWHwmZwCyzH2KARYPrKOJbF0bExrg/fi9Z9wppcXNC05/r5jZ3
         TQX8c8BYwZvZH989ECg0V8I6//YQl3uILxdIIxPvWZXq3a9iFYSnikqHhbMIy+EQShee
         QK061EaghR4hBNl4TnjdHM+RbbzBccspzlI0QyvwBYiJyzMsct6lFJrda7HQAJUzoaJ8
         qXaw==
X-Gm-Message-State: AA+aEWY2TaIJ0UT2zrjiOoPJQFdmk8eG4/lLPRisi4nYZZr52JHTc6nq
        lgd5Q8yvdPlUzI119ElZG5M=
X-Google-Smtp-Source: AFSGD/WQ227qcZdLUkVz2t5qGzUtD9ex8FtZ/6/+G6I4XMaMncgfxb7LeOe4cWL0vgiADc+Gl9WE+w==
X-Received: by 2002:a17:906:6898:: with SMTP id n24-v6mr13466107ejr.189.1544567056751;
        Tue, 11 Dec 2018 14:24:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id m13sm4544735edd.2.2018.12.11.14.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:24:16 -0800 (PST)
Date:   Tue, 11 Dec 2018 22:24:15 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Zaslonko Mikhail <zaslonko@linux.bm.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel.Tatashin@microsoft.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        gerald.schaefer@de.ibm.com
Subject: Re: [PATCH 1/1] mm, memory_hotplug: Initialize struct pages for the
 full memory section
Message-ID: <20181211222415.yfco6l2dmywxgid7@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20181210130712.30148-1-zaslonko@linux.ibm.com>
 <20181210130712.30148-2-zaslonko@linux.ibm.com>
 <20181210132451.GO1286@dhcp22.suse.cz>
 <20181211094938.3mykr3n3tp6rfz4p@master>
 <e23ad186-31d4-176d-7330-8c22378891ee@linux.bm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e23ad186-31d4-176d-7330-8c22378891ee@linux.bm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 04:17:34PM +0100, Zaslonko Mikhail wrote:
>
>
>On 11.12.2018 10:49, Wei Yang wrote:
>> On Mon, Dec 10, 2018 at 02:24:51PM +0100, Michal Hocko wrote:
>>> On Mon 10-12-18 14:07:12, Mikhail Zaslonko wrote:
>>>> If memory end is not aligned with the sparse memory section boundary, the
>>>> mapping of such a section is only partly initialized.
>>>
>>> It would be great to mention how you can end up in the situation like
>>> this(a user provided memmap or a strange HW). 
>>>
>>>> This may lead to
>>>> VM_BUG_ON due to uninitialized struct page access from
>>>> is_mem_section_removable() or test_pages_in_a_zone() function triggered by
>>>> memory_hotplug sysfs handlers:
>>>>
>>>>  page:000003d082008000 is uninitialized and poisoned
>>>>  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
>>>>  Call Trace:
>>>>  ([<0000000000385b26>] test_pages_in_a_zone+0xde/0x160)
>>>>   [<00000000008f15c4>] show_valid_zones+0x5c/0x190
>>>>   [<00000000008cf9c4>] dev_attr_show+0x34/0x70
>>>>   [<0000000000463ad0>] sysfs_kf_seq_show+0xc8/0x148
>>>>   [<00000000003e4194>] seq_read+0x204/0x480
>>>>   [<00000000003b53ea>] __vfs_read+0x32/0x178
>>>>   [<00000000003b55b2>] vfs_read+0x82/0x138
>>>>   [<00000000003b5be2>] ksys_read+0x5a/0xb0
>>>>   [<0000000000b86ba0>] system_call+0xdc/0x2d8
>>>>  Last Breaking-Event-Address:
>>>>   [<0000000000385b26>] test_pages_in_a_zone+0xde/0x160
>>>>  Kernel panic - not syncing: Fatal exception: panic_on_oops
>>>>
>>>> Fix the problem by initializing the last memory section of the highest zone
>>>> in memmap_init_zone() till the very end, even if it goes beyond the zone
>>>> end.
>>>
>>> Why do we need to restrict this to the highest zone? In other words, why
>>> cannot we do what I was suggesting earlier [1]. What does prevent other
>>> zones to have an incomplete section boundary?
>>>
>>> [1] http://lkml.kernel.org/r/20181105183533.GQ4361@dhcp22.suse.cz
>>>
>> 
>> I tried to go through the original list and make myself familiar with
>> the bug.
>> 
>> Confused why initialize the *last* end_pfn could fix this, since
>> is_mem_section_removable() will iterate on each page of a section. This
>> means we need to initialize all the pages left in the section.
>That's exactly what the fix does. We initialize all the pages left in 
>the section.
>

You are right, I misunderstand your code.

>> 
>> One way to fix this in my mind is to record the last pfn in mem_section.
>Do you mean last initialized pfn? I guess we have agreed upon that the 
>entire section should be initialized.  

Well, that would be great.

>
>> This could be done in memory_preset(), since after that we may assume
>> the section is full. Not sure whether you would like it.
>> 

-- 
Wei Yang
Help you, Help me
