Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEDC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B8621486
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="o8Pn7s1H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B8621486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeFVGNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:13:52 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44834 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeFVGNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:13:50 -0400
Received: by mail-ot0-f194.google.com with SMTP id w13-v6so6273796ote.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TUbtu6YJ8fX1GSBaupayHm2xoT7KdNFJqVQ5yHk0R84=;
        b=o8Pn7s1HMUt/4l8mSXd5Ff+qMRS8SJQlODsTjUiYTdptVk2XHrvYfU623aQxhS100u
         bg9TOkPRBdWiQY5fJbdkvfua3SV/RsvcS9BD99COD7w+/w7QJKIv8wpgb3y6xGTyI/yR
         x2k8XSV4Brk4mEUQQhYC7LuWw7eaD145jO+Q1zJbo4StGtqk6wpHiiNVeNgm2eDTB8cl
         JBM4+cGcV2AZUjUUxFKqAHi/did4EB6sEsdHRg9K2R3YiyAplt3/0TIT5A6ek4Qloql0
         hd8SwaolmYe6hf9XIBcqgJgNn+mUYIJ3S6VuMFOE4/F+RpGCOmnBJ4njyjPaHED1Jm23
         TniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TUbtu6YJ8fX1GSBaupayHm2xoT7KdNFJqVQ5yHk0R84=;
        b=gynifNIXc77Un5Hrv2oh4TAyeIqzBLxmPQqLCkeKxVVTZclhfrcM9xsh/7GV7zuP8s
         r7nCu8l/9Evp+I9i7U/x3jQSASXstMTjtObjWMw1EiRh7HdlEVlPvj4n4SJZuEofwhpb
         mjRlIRLu6dNCOk/PezKFJSZ8FEc99SgPzbZMZxmusjKjXaL2rDi7GkiHD2ZpITkApzeR
         HrMjsPljnDrPNG2ZWr6pGqGbg7bNM0kEc4Z477iRDEihVLFjqnfuhgNgfabUQiW7Aypj
         Te3H9H149B/QXs+wMlXGTaXwRFQB/7PRx5h5QNg8A+nu75Ald8jAl6l6oWHnR8o01fN1
         IcPA==
X-Gm-Message-State: APt69E0B9dV1cXXj6HFsNnATZ04AmJiXJSTgwLll1JLV4DcrNoiYDg5U
        7l+N3GH8n2wSCtKJB3fp8fkzM3gchhWZ/a0FU3n/7w==
X-Google-Smtp-Source: ADUXVKJGXPEnrlSEkfAEXb9C3dBcweg26JOTF7JUrVYNhCFxO55JA39wtfg2vNzCr6C24tFKnrndE0CYEUeShY1QpUQ=
X-Received: by 2002:a9d:64c3:: with SMTP id n3-v6mr175455otl.210.1529648030337;
 Thu, 21 Jun 2018 23:13:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 23:13:49
 -0700 (PDT)
In-Reply-To: <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com>
References: <1529647683-14531-1-git-send-email-n-horiguchi@ah.jp.nec.com> <CAPcyv4hpdvGRi+=psT47ePB6QigJW2JEq-zhbVXsTHb14pWfUQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 21 Jun 2018 23:13:49 -0700
Message-ID: <CAPcyv4ism+Sy7=h982R3b3ftpp0jzT04-uvSrgwz=7ad6tZ1fQ@mail.gmail.com>
Subject: Re: [PATCH v1] mm: initialize struct page for reserved pages in ZONE_DEVICE
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 11:12 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Thu, Jun 21, 2018 at 11:08 PM, Naoya Horiguchi
> <n-horiguchi@ah.jp.nec.com> wrote:
>> Reading /proc/kpageflags for pfns allocated by pmem namespace triggers
>> kernel panic with a message like "BUG: unable to handle kernel paging
>> request at fffffffffffffffe".
>>
>> The first few pages (controlled by altmap passed to memmap_init_zone())
>> in the ZONE_DEVICE can skip struct page initialization, which causes
>> the reported issue.
>>
>> This patch simply adds some initialization code for them.
>>
>> Fixes: 4b94ffdc4163 ("x86, mm: introduce vmem_altmap to augment vmemmap_populate()")
>> Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>> ---
>>  mm/page_alloc.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
>> index 1772513..0b36afe 100644
>> --- v4.17-mmotm-2018-06-07-16-59/mm/page_alloc.c
>> +++ v4.17-mmotm-2018-06-07-16-59_patched/mm/page_alloc.c
>> @@ -5574,8 +5574,16 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>>          * Honor reservation requested by the driver for this ZONE_DEVICE
>>          * memory
>>          */
>> -       if (altmap && start_pfn == altmap->base_pfn)
>> +       if (altmap && start_pfn == altmap->base_pfn) {
>> +               unsigned long i;
>> +
>> +               for (i = 0; i < altmap->reserve; i++) {
>> +                       page = pfn_to_page(start_pfn + i);
>> +                       __init_single_page(page, start_pfn + i, zone, nid);
>> +                       SetPageReserved(page);
>> +               }
>>                 start_pfn += altmap->reserve;
>> +       }
>
> No, unfortunately this will clobber metadata that lives in that
> reserved area, see __nvdimm_setup_pfn().

I think the kpageflags code needs to lookup the dev_pagemap in the
ZONE_DEVICE case and honor the altmap.
