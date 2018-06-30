Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783EC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3767208FC
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 03:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="07TY8jpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3767208FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936080AbeF3DTJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 23:19:09 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39896 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932822AbeF3DTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 23:19:08 -0400
Received: by mail-oi0-f66.google.com with SMTP id d189-v6so1452055oib.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 20:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=21VYb3A17E0UHzSWXuxJrJ5W/2DJqMdGwuMllqSk5sU=;
        b=07TY8jpEjmjUibfWADoFyI1voRzGwNICH3o+trj1WlKPMW8IDpQvH3rPlo6I4evj2b
         OioDtVmFZ9gxBmQLen+nQQsjkywWbPTumNfNkGpDp//a7vqtDVEaxAEYzYmjXVMlzo8G
         cdPBhaDhe3xQpo0Uar1xUS9IsH00lKHOT6A3vfcw67LBWMfu+jcL1dlN0qpA0gyzgtrD
         0/Ih48z3BFrOmiFgnVecagjvefwdlPv+3Jw3vpoG0sUqyabvyFqW8E4jcjeaUF/70Bqf
         FXCEwr20Rt5hwLTvdwTQHdgwATqISv83jPmfLjivZr6iOo4P8avkGWUw/wvF669ggTby
         rjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=21VYb3A17E0UHzSWXuxJrJ5W/2DJqMdGwuMllqSk5sU=;
        b=cZNXRDzh/4N++hlFrzqkEhLXrXkb2e+71jySQ/ikdDZfxHYdcPOTjbZpuN3EQNkDB1
         dSQoYaxRy1UPAuRmf1VI5IvhH2UXKvjuaAVmhd+oJXyO/s/4T9J3NfLh4eO/wJ/AdGtW
         tgWO0/fo5vrXVSRGtgoGTBuHSHQ5PZXv+sr5HsO0p5m/G3wvQnhVsmw4hU5rJ4nWHPRq
         E70B6aF5WpmbAcw4VR0n+3ihTZbLlWrD9/dVmvMkVY+xHDo3I798awAfOgm4FZ10W8Fc
         VOtmQA1jGUWLyb7OUxRxACSqow3hkyg12np8oYVoksNCl3KUsTaN22g2jg5XXAtM15PK
         Zlnw==
X-Gm-Message-State: APt69E1dU/Qaw6lq5ZAG6ZFUL9rAdg9GtDxdPo8TQqcyiOxVNDE//AA5
        uID2WqsZlQDg2w6bZNBr3gZqbHzRldzBaZQEdAMn/w==
X-Google-Smtp-Source: AAOMgpcWpSfQKEMSPOFcgGwdNWP4aCrkkze7OuQHTtdkaK2vLjz6xcODV1YZzKL1REqhpotaWbwb0fVPWu2z2ZyzvUw=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr9161348oih.295.1530328747981;
 Fri, 29 Jun 2018 20:19:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 20:19:07
 -0700 (PDT)
In-Reply-To: <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
References: <20180625170259.30393-1-aryabinin@virtuozzo.com>
 <20180629164932.740-1-aryabinin@virtuozzo.com> <20180629193300.0ae0f25880a800bd27952b15@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Jun 2018 20:19:07 -0700
Message-ID: <CAPcyv4hiwTsSdptKFtBYfsbd9L12RfjGdY1PDckkCY980vxXLQ@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work
 with KASAN
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        david <david@fromorbit.com>, kasan-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 7:33 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 29 Jun 2018 19:49:32 +0300 Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>
>> KASAN learns about hot added memory via the memory hotplug notifier.
>> The devm_memremap_pages() intentionally skips calling memory hotplug
>> notifiers.
>
> Why does it do that?

devm_memremap_pages() deliberately does only half of memory hotplug.
Namely it only adds to the linear map and allocates / initializes
'struct page', but it never onlines the pages, so
devm_memremap_pages() generates none of the events that the hotplug
notifiers would publish.

>> So KASAN doesn't know anything about new memory added
>> by devm_memremap_pages(). This causes to crash when KASAN tries to
>> access non-existent shadow memory:
>>
>>  BUG: unable to handle kernel paging request at ffffed0078000000
>>  RIP: 0010:check_memory_region+0x82/0x1e0
>>  Call Trace:
>>   memcpy+0x1f/0x50
>>   pmem_do_bvec+0x163/0x720
>>   pmem_make_request+0x305/0xac0
>>   generic_make_request+0x54f/0xcf0
>>   submit_bio+0x9c/0x370
>>   submit_bh_wbc+0x4c7/0x700
>>   block_read_full_page+0x5ef/0x870
>>   do_read_cache_page+0x2b8/0xb30
>>   read_dev_sector+0xbd/0x3f0
>>   read_lba.isra.0+0x277/0x670
>>   efi_partition+0x41a/0x18f0
>>   check_partition+0x30d/0x5e9
>>   rescan_partitions+0x18c/0x840
>>   __blkdev_get+0x859/0x1060
>>   blkdev_get+0x23f/0x810
>>   __device_add_disk+0x9c8/0xde0
>>   pmem_attach_disk+0x9a8/0xf50
>>   nvdimm_bus_probe+0xf3/0x3c0
>>   driver_probe_device+0x493/0xbd0
>>   bus_for_each_drv+0x118/0x1b0
>>   __device_attach+0x1cd/0x2b0
>>   bus_probe_device+0x1ac/0x260
>>   device_add+0x90d/0x1380
>>   nd_async_device_register+0xe/0x50
>>   async_run_entry_fn+0xc3/0x5d0
>>   process_one_work+0xa0a/0x1810
>>   worker_thread+0x87/0xe80
>>   kthread+0x2d7/0x390
>>   ret_from_fork+0x3a/0x50
>>
>> Add kasan_add_zero_shadow()/kasan_remove_zero_shadow() - post mm_init()
>> interface to map/unmap kasan_zero_page at requested virtual addresses.
>> And use it to add/remove the shadow memory for hotpluged/unpluged
>> device memory.
>>
>> Reported-by: Dave Chinner <david@fromorbit.com>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dmitry Vyukov <dvyukov@google.com>
>> Cc: Alexander Potapenko <glider@google.com>
>
> No cc:stable? Which kernel version(s) do you believe need the fix?

I think devm_memremap_pages() was incompatible with KASAN from the
outset, so I would say:

Fixes: 41e94a851304 ("add devm_memremap_pages")

>
>>  include/linux/kasan.h |  13 ++-
>>  kernel/memremap.c     |  10 ++
>>  mm/kasan/kasan_init.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++---
>
> It's a surprisingly large amount of ode to do something which KASAN
> already does for hotplugged memory.  How come?
