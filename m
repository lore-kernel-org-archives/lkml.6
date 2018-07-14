Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC655ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B853208A4
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 00:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="fw/v9rpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B853208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbeGNAvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 20:51:47 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34351 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729658AbeGNAvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 20:51:47 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so65374487ois.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 17:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bcYAEPAfhwjwqoLmOxUJoo6JBA4MU9s1oePpKYOiXts=;
        b=fw/v9rpV9ehGI1zbCyRXL8YB33GqKMBXhM99/in45IIXsfx9s4vePx/he10iSbiMIi
         nT0VeqfLfnek3r43bc3A0sAyf3zYF6Y8eCZsLrqHgaZRWnzPvwYSijOsxr1pVDD1bfHq
         oGuWYfS01YK1L14ZekAITUm8OGz4FlMHNesu41LNBKL9AhjeIVWZ4+ZEJZm/Mo29lGV1
         zZklqtgx1dpqClslI0YGdY+KEaWzYhZKcEIEg+gcVJ4ADOMPrcMz3fIx48mOtR/kWw9s
         B3ZZDjJ8X7fZOJJy9Q7oXyV7GimBZiU6Uu5nDLP/DLhgupWMZJBxLK3+shPi81RfGfwk
         J/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bcYAEPAfhwjwqoLmOxUJoo6JBA4MU9s1oePpKYOiXts=;
        b=lnHRYDpO8zfrzNEd4BXnBVnKpyEg4pw4r+z+jqpn0FiSWxjKHD3YyRFN34vN9NU/tO
         Ta/zW0d/guAwhoLMF7McniVDBpVuMDKzxrYy8dfswgl341RUANm2UImHgq2sySAEMAu+
         oaJRk4d9cVexXf5/YHcYGX6z+4RFyqOKBxyq4zRpTUJRlcrkifBaA/CzNyko/1CjtJ9i
         NHP3Unk/MW9YIFtW8DFWwE0FE7TGwkO5+xGYd3oT7xcrkDaP3U6Tmj3iL7O6zcTtPkDw
         k7rVjCgdpMWqVAJ1tsapCEPOXkPClIPzTyH0wBcwh7EcIR7YU/vS08hLHyOFD90SRfaI
         6PzQ==
X-Gm-Message-State: AOUpUlH3MTNtTp3uMwKF7hiacHswAKeg9nVQPdJ4hQFhJwZUMKN0KRZr
        R6H6g6uOQwPyelXQMnRef3Gctv8hCz4uXKFczBBDHA==
X-Google-Smtp-Source: AAOMgpdTxIt0UAb99WH6vgmAjAqNTfQBNv3WHKmdjgLSUeSQSfYx1K/ulSB+6ovNDx7Gnw4st5iZ/utn8+M851QEGGw=
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr8602664oia.118.1531528488457;
 Fri, 13 Jul 2018 17:34:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 17:34:48
 -0700 (PDT)
In-Reply-To: <20180713063125.GA10034@hori1.linux.bs1.fc.nec.co.jp>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153074044986.27838.16910122305490506387.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180713063125.GA10034@hori1.linux.bs1.fc.nec.co.jp>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 13 Jul 2018 17:34:48 -0700
Message-ID: <CAPcyv4j2M4tSKk-mXPaj1sLGCN6qHNh2iaauKwgciRpmqU8cSw@mail.gmail.com>
Subject: Re: [PATCH v5 05/11] mm, madvise_inject_error: Let memory_failure()
 optionally take a page reference
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 11:31 PM, Naoya Horiguchi
<n-horiguchi@ah.jp.nec.com> wrote:
> Hello Dan,
>
> On Wed, Jul 04, 2018 at 02:40:49PM -0700, Dan Williams wrote:
>> The madvise_inject_error() routine uses get_user_pages() to lookup the
>> pfn and other information for injected error, but it does not release
>> that pin. The assumption is that failed pages should be taken out of
>> circulation.
>>
>> However, for dax mappings it is not possible to take pages out of
>> circulation since they are 1:1 physically mapped as filesystem blocks,
>> or device-dax capacity. They also typically represent persistent memory
>> which has an error clearing capability.
>>
>> In preparation for adding a special handler for dax mappings, shift the
>> responsibility of taking the page reference to memory_failure(). I.e.
>> drop the page reference and do not specify MF_COUNT_INCREASED to
>> memory_failure().
>>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>  mm/madvise.c |   18 +++++++++++++++---
>>  1 file changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index 4d3c922ea1a1..b731933dddae 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -631,11 +631,13 @@ static int madvise_inject_error(int behavior,
>>
>>
>>       for (; start < end; start += PAGE_SIZE << order) {
>> +             unsigned long pfn;
>>               int ret;
>>
>>               ret = get_user_pages_fast(start, 1, 0, &page);
>>               if (ret != 1)
>>                       return ret;
>> +             pfn = page_to_pfn(page);
>>
>>               /*
>>                * When soft offlining hugepages, after migrating the page
>> @@ -651,17 +653,27 @@ static int madvise_inject_error(int behavior,
>>
>>               if (behavior == MADV_SOFT_OFFLINE) {
>>                       pr_info("Soft offlining pfn %#lx at process virtual address %#lx\n",
>> -                                             page_to_pfn(page), start);
>> +                                     pfn, start);
>>
>>                       ret = soft_offline_page(page, MF_COUNT_INCREASED);
>>                       if (ret)
>>                               return ret;
>>                       continue;
>>               }
>> +
>>               pr_info("Injecting memory failure for pfn %#lx at process virtual address %#lx\n",
>> -                                             page_to_pfn(page), start);
>> +                             pfn, start);
>> +
>> +             ret = memory_failure(pfn, 0);
>> +
>> +             /*
>> +              * Drop the page reference taken by get_user_pages_fast(). In
>> +              * the absence of MF_COUNT_INCREASED the memory_failure()
>> +              * routine is responsible for pinning the page to prevent it
>> +              * from being released back to the page allocator.
>> +              */
>> +             put_page(page);
>>
>> -             ret = memory_failure(page_to_pfn(page), MF_COUNT_INCREASED);
>
> MF_COUNT_INCREASED means that the page refcount for memory error handling
> is taken by the caller so you don't have to take one inside memory_failure().
> So this code don't keep with the definition, then another refcount can be
> taken in memory_failure() in normal LRU page's case for example.
> As a result the error message "Memory failure: %#lx: %s still referenced by
> %d users\n" will be dumped in page_action().
>
> So if you want to put put_page() in madvise_inject_error(), I think that
>
>                 put_page(page);
>                 ret = memory_failure(pfn, 0);
>
> can be acceptable because the purpose of get_user_pages_fast() here is
> just getting pfn, and the refcount itself is not so important.
> IOW, memory_failure() is called only with pfn which never changes depending
> on the page's status.

Ok, I'll resend with the put_page() moved before memory_failure() to
make it more clear that memory_failure() is responsible for taking its
own reference and that there is no dependency to hold the reference in
madvise_inject_error().

> In production system memory_failure() is called via machine check code
> without taking any pagecount, so I don't think the this injection interface
> is properly mocking the real thing. So I'm feeling that this flag will be
> wiped out at some point.

Ok, makes sense.
