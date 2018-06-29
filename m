Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46A94C6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED47727872
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 17:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="nyJabcgM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED47727872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937158AbeF2RNe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 13:13:34 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45198 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932446AbeF2RNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 13:13:32 -0400
Received: by mail-oi0-f67.google.com with SMTP id m2-v6so1137371oim.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0yT17GOXOywaror1F2q520EU5ppeiSbTv27JWN5bXpc=;
        b=nyJabcgMrL9/k/Y1SC7uKN8+tzraCKW/TT4W1iQCVD2jbH41UPne9L7oF3OrZT2pcm
         m4GPyaYznyFkYy5wM7TRC8VDRBEDwp0mpJNLW2qZxVEcJjY1UJ/Hi5gWXlIzB4U4nTrK
         vCyABKBmxik5VWSJ5JBOJx4B+Kp99KPcXkJE2ZEnVXTDFChYwMjBYOUVU8R3pCcsKMSl
         596MgOuUPm3MxlPoG7ge3D/HSS850+hXaRkSW/aNcTs+3L2kdKnh/6/PnkzSD9Mhe74F
         QKKvgNZCM8IVYboTNCt1+4shqN0ykYdq0Qj4sCnlaK+oEDliiyISdZuHXnNIdERIxyle
         B+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0yT17GOXOywaror1F2q520EU5ppeiSbTv27JWN5bXpc=;
        b=PduTqyKpj56rdOm0BBk0mn+iE4aUnWnfMX4PL8EVT3R6be7JWP/TjyYzk5kUPH8Z3+
         kaZtMv1M9+FjecNXXWT1X1ZgZsh6o3jHaVIN2GEmWZ0hUWHkwfyznpC/AuYiDPpPY7X+
         rNO2ZOeG/avox22FGWYnYDCUF6QNUwogvesuNGkgLh+6Iyj15rXkE3tCBqe7hTmnN20I
         ZWeK4Do/PM1HgXCOukCeii2jUSsyPUADumTh6zVUTiroy1pYhmP4GpG/JbOa0tbOIxxj
         9FrYM0H3c+ZYa/Pjt78Ms3ZyeVb/O34RYFiZzRCQUim5R9YPwZOqV3176hp1/I7J72mZ
         ud3Q==
X-Gm-Message-State: APt69E2SlETJ1iPNikpTWCt81Zypr2LuliVS15n3jne7edSe+g20T1KB
        wu3QTVzicttIkpGAuRXbHLyrwGRvfWVbJwLQZQ1J0Q==
X-Google-Smtp-Source: AAOMgpfXznH7h33Bxy09jaoFZoNttVbEdr34M+Z+VBm8xqEbCN0jQlcRDrtbzgWZR0/o4Da3zO/PHqCMUNd+IJiu/Ts=
X-Received: by 2002:aca:3d43:: with SMTP id k64-v6mr8279591oia.166.1530292412238;
 Fri, 29 Jun 2018 10:13:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:57c9:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 10:13:31
 -0700 (PDT)
In-Reply-To: <20180629164932.740-1-aryabinin@virtuozzo.com>
References: <20180625170259.30393-1-aryabinin@virtuozzo.com> <20180629164932.740-1-aryabinin@virtuozzo.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Jun 2018 10:13:31 -0700
Message-ID: <CAPcyv4hwgLS+=UWyORqs_dHFu2LSX6pheWVt=zyrby2wneixBA@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/memremap, kasan: Make ZONE_DEVICE with work
 with KASAN
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, Jun 29, 2018 at 9:49 AM, Andrey Ryabinin
<aryabinin@virtuozzo.com> wrote:
> KASAN learns about hot added memory via the memory hotplug notifier.
> The devm_memremap_pages() intentionally skips calling memory hotplug
> notifiers. So KASAN doesn't know anything about new memory added
> by devm_memremap_pages(). This causes to crash when KASAN tries to
> access non-existent shadow memory:
>
>  BUG: unable to handle kernel paging request at ffffed0078000000
>  RIP: 0010:check_memory_region+0x82/0x1e0
>  Call Trace:
>   memcpy+0x1f/0x50
>   pmem_do_bvec+0x163/0x720
>   pmem_make_request+0x305/0xac0
>   generic_make_request+0x54f/0xcf0
>   submit_bio+0x9c/0x370
>   submit_bh_wbc+0x4c7/0x700
>   block_read_full_page+0x5ef/0x870
>   do_read_cache_page+0x2b8/0xb30
>   read_dev_sector+0xbd/0x3f0
>   read_lba.isra.0+0x277/0x670
>   efi_partition+0x41a/0x18f0
>   check_partition+0x30d/0x5e9
>   rescan_partitions+0x18c/0x840
>   __blkdev_get+0x859/0x1060
>   blkdev_get+0x23f/0x810
>   __device_add_disk+0x9c8/0xde0
>   pmem_attach_disk+0x9a8/0xf50
>   nvdimm_bus_probe+0xf3/0x3c0
>   driver_probe_device+0x493/0xbd0
>   bus_for_each_drv+0x118/0x1b0
>   __device_attach+0x1cd/0x2b0
>   bus_probe_device+0x1ac/0x260
>   device_add+0x90d/0x1380
>   nd_async_device_register+0xe/0x50
>   async_run_entry_fn+0xc3/0x5d0
>   process_one_work+0xa0a/0x1810
>   worker_thread+0x87/0xe80
>   kthread+0x2d7/0x390
>   ret_from_fork+0x3a/0x50
>
> Add kasan_add_zero_shadow()/kasan_remove_zero_shadow() - post mm_init()
> interface to map/unmap kasan_zero_page at requested virtual addresses.
> And use it to add/remove the shadow memory for hotpluged/unpluged
> device memory.
>
> Reported-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Alexander Potapenko <glider@google.com>

Reviewed-and-tested-by: Dan Williams <dan.j.williams@intel.com>
