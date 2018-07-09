Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F29C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6CF20878
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 16:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="cMD9c4v3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6CF20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933537AbeGIQxm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 12:53:42 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33764 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932755AbeGIQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 12:53:41 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so37197189oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 09:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=94MT9Qsi1hWCvG2S//dsBp69EFTRY6sPXCMC8bSQahg=;
        b=cMD9c4v3AiNwnkdyhSJ1mF77RxfrnujIOrS5xDlnMDv5atTzgkrVK91XTFVNRdKO4m
         rh23yLnslYGe/MZL+rotjpYIp/nH5eX4LNSnUUNYhkULen2fZv4wHY7C9Expg/ADsgfC
         sL8PLidkybqLocm+zC6xymNLxt0NyFsV27zaNWVBoc1beybHOHddkrtPtGzfvlYagR6N
         5vQmH+2SS/nHTYGGmXSUIFH3hEZ12FHwXjKJf04OVjJaavIbcXa9CXvSKWXE1nuR7EH7
         xjL3OpBezo8GoxKDEmEa2zWIR33BECYwOvk2XQgTzBQgZXRNOkWagJ7IxUHcTVZrHWGq
         GH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=94MT9Qsi1hWCvG2S//dsBp69EFTRY6sPXCMC8bSQahg=;
        b=m9KawtmauvjTIyHXKoCcHyMKqH2D4FGfZduEkNjyCDE4aMlo4e1XtIhrpBUsGIMDqh
         PMzamkThlHPZGqgEXyjzd08FUNEU7F4pykQydFtVFrWuixmSPbCly7F1UW7NCZCU4UI0
         FWVHGpXZpeRJguBDR2sphOxoRAZgVo/U771b0g11ggDdhULoRotdhf5LSQT04tqBhSCU
         GzuTt8Gup+1xbfr4OOv7gREUArSUM8+aSPDt3GqGMY5+4TftqoyhVLQAw3MFrDUXZ7JC
         /QamNWumQjEOWScujKNCQJ9hE+M5/Q6A3gSeVBcki66zHOE7aQ3zxlr0u1TX+7V1nBAz
         9xLw==
X-Gm-Message-State: APt69E2b6IPKUHHBlk1/YqgEQXKJV2dCATXr1LP8BaQVKCJ4BAjHHi42
        h7oP+SrfesM71hcm6+EAgQSkVg4mwueEdXK8KZPAKg==
X-Google-Smtp-Source: AAOMgpe4N0/w4hBkUmamrPKbrvQfSn2J8V7tGUYcYZ3iHI63adfR1vMH7LxMr++909M0ejDKQinuW+3WjLOrXj/fzC0=
X-Received: by 2002:aca:100f:: with SMTP id 15-v6mr25607452oiq.110.1531155220726;
 Mon, 09 Jul 2018 09:53:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 09:53:40 -0700 (PDT)
In-Reply-To: <20180709125641.xpoq66p4r7dzsgyj@quack2.suse.cz>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180709125641.xpoq66p4r7dzsgyj@quack2.suse.cz>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 9 Jul 2018 09:53:40 -0700
Message-ID: <CAPcyv4j3X7vQb0t3FzN0c6yEicZC6LDCPyJVJud1y+vusMUBbw@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm: Asynchronous + multithreaded memmap init for ZONE_DEVICE
To:     Jan Kara <jack@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michal Hocko <mhocko@suse.com>,
        Paul Mackerras <paulus@samba.org>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        X86 ML <x86@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 5:56 AM, Jan Kara <jack@suse.cz> wrote:
> On Wed 04-07-18 23:49:02, Dan Williams wrote:
>> In order to keep pfn_to_page() a simple offset calculation the 'struct
>> page' memmap needs to be mapped and initialized in advance of any usage
>> of a page. This poses a problem for large memory systems as it delays
>> full availability of memory resources for 10s to 100s of seconds.
>>
>> For typical 'System RAM' the problem is mitigated by the fact that large
>> memory allocations tend to happen after the kernel has fully initialized
>> and userspace services / applications are launched. A small amount, 2GB
>> of memory, is initialized up front. The remainder is initialized in the
>> background and freed to the page allocator over time.
>>
>> Unfortunately, that scheme is not directly reusable for persistent
>> memory and dax because userspace has visibility to the entire resource
>> pool and can choose to access any offset directly at its choosing. In
>> other words there is no allocator indirection where the kernel can
>> satisfy requests with arbitrary pages as they become initialized.
>>
>> That said, we can approximate the optimization by performing the
>> initialization in the background, allow the kernel to fully boot the
>> platform, start up pmem block devices, mount filesystems in dax mode,
>> and only incur the delay at the first userspace dax fault.
>>
>> With this change an 8 socket system was observed to initialize pmem
>> namespaces in ~4 seconds whereas it was previously taking ~4 minutes.
>>
>> These patches apply on top of the HMM + devm_memremap_pages() reworks
>> [1]. Andrew, once the reviews come back, please consider this series for
>> -mm as well.
>>
>> [1]: https://lkml.org/lkml/2018/6/19/108
>
> One question: Why not (in addition to background initialization) have
> ->direct_access() initialize a block of struct pages around the pfn it
> needs if it finds it's not initialized yet? That would make devices usable
> immediately without waiting for init to complete...

Hmm, yes, relatively immediately... it would depend on the granularity
of the tracking where we can reliably steal initialization work from
the background thread. I'll give it a shot, I'm thinking dividing each
thread's work into 64 sub-units and track those units with a bitmap.
The worst case init time then becomes the time to initialize the pages
for a range that is namespace-size / (NR_MEMMAP_THREADS * 64).
