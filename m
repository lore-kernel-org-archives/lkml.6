Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 554B8C5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D0120864
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 05:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="AhelvM0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99D0120864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756240AbeFPFW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 01:22:59 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34440 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbeFPFW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 01:22:57 -0400
Received: by mail-oi0-f68.google.com with SMTP id i205-v6so10657378oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 22:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ssHxAHaGBREW6Ld382hsfj+7WLxGBeoGQVafsOULEpw=;
        b=AhelvM0eqkVBAb25NBOr0AlbBUQTNosr1ScL+uC0esoREPfgDAC2khMSY5sc2sFkIC
         A9U53V1sBnuG8QX3HLQBIw4UZJznYx3MTquFUnlTsCaFrKFIjhQfZ6cC+paU8NzI0EYs
         yuMdouVv40kvV6jFWKpRpT2s6tiCZg+YumF/V49y95Agvyya2ZSbwFEUwBUfkGlnMjLP
         K7yItQcd6rJ6nweb8qLn1BTGE4aPGW7h04QzeBmw859kjPElAm5x7biwzFJd3ii3wqc6
         nX7frTjfzLZOU91TaeIYOYa7fddICs3LMj+9G73wIjrCChMCpnyQgHA5fO1JbThGPDWT
         kUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ssHxAHaGBREW6Ld382hsfj+7WLxGBeoGQVafsOULEpw=;
        b=ihGCDEM0zh3RlOlYZVMJifs/RT8KTjaAunDN3XoOo65H2nwJ6GoqDn9sHMntjsBtnI
         krg1iIGVssUN42MQlKqTORtC7YA60HK5h787bh/omgznYob6WzySk7CCvTjasuvSgzlh
         RC9AXZm0B8+FRDLmBUeOKQecwj5E4CRL9nUZKV1cuqji6/gTQefdvHtLqGtVuiJ1U4Lu
         PIS+GkVMnYxxD9I/1pk6mNGu7Pzy6LcfKu7b4pZWulYOjfzrRQaRtWDgS6juENaEnp06
         orl76bkaBnVXZNTuiEwIQfhN8hQmCQVF3hGV1m7OadaQWlk6hqWPb1ApuOvU5wuvlT45
         wS2A==
X-Gm-Message-State: APt69E2Csg3qLoSyHblxVhMXXbJubCS7l4qZwi6dvsrrYLSinry8SIg+
        bqkACSyxweybFWE7T9nAQ7pZoGnLxrznGOlHWZkEPA==
X-Google-Smtp-Source: ADUXVKKSgNJ7JEfy9oDwb5eKbaPKNrD6zTGAhuXZppk+bpcS8Qf5PbEqh3IRDRq9iZxKgngUc4APZVnypIUQ5to7WKU=
X-Received: by 2002:aca:a902:: with SMTP id s2-v6mr2604671oie.72.1529126577161;
 Fri, 15 Jun 2018 22:22:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2ea9:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 22:22:56
 -0700 (PDT)
In-Reply-To: <1970355c-ebca-7f7d-38f7-ceac1ae553fb@nvidia.com>
References: <CAFhSwD9RNcsaTNdT-4DiE_BKK6zrsdBbNbGBEkBoJuwQn1JdQA@mail.gmail.com>
 <CAPcyv4hpjNaUz6qpJ0_Wh1SAz9tS9a5HLsYSgeCh_pNZKfY74A@mail.gmail.com> <1970355c-ebca-7f7d-38f7-ceac1ae553fb@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 15 Jun 2018 22:22:56 -0700
Message-ID: <CAPcyv4j=LFY31zn7yFXUrsrvzQEz=a92VLOa=Tp46JbGHhC7Xw@mail.gmail.com>
Subject: Re: OpenAFS module libafs.ko uses GPL-only symbol '__put_devmap_managed_page'
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Joe Gorse <jhgorse@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:43 PM, John Hubbard <jhubbard@nvidia.com> wrote:
> On 06/13/2018 12:51 PM, Dan Williams wrote:
>> [ adding Andrew, Christoph, and linux-mm ]
>>
>> On Wed, Jun 13, 2018 at 12:33 PM, Joe Gorse <jhgorse@gmail.com> wrote:
>>> Greetings,
>>>
>>> Please CC answers & comments to this email. Thanks! =)
>>>
>>> Our build is breaking as of
>>> commit e7638488434415aa478e78435cac8f0365737638
>>> Author: Dan Williams <dan.j.williams@intel.com>
>>> Date: Wed May 16 11:46:08 2018 -0700
>>>
>>> mm: introduce MEMORY_DEVICE_FS_DAX and CONFIG_DEV_PAGEMAP_OPS
>>> ... snip ...
>>> https://patchwork.kernel.org/patch/10412459/
>>>
>>> We do not directly use the GPL-only symbol '__put_devmap_managed_page'. It
>>> appears to be picked up from static-inlining in put_page(), which we need.
>>>
>>> How shall we proceed? Would it be reasonable to request the change of the
>>> GPL-only exports for this commit?
>>>
>>> Cheers,
>>> Joe Gorse
>>>
>>> P.S. The build failure, for the morbidly curious:
>>>> FATAL: modpost: GPL-incompatible module libafs.ko uses GPL-only symbol
>>>> '__put_devmap_managed_page'
>>>> scripts/Makefile.modpost:92: recipe for target '__modpost' failed
>>>> make[6]: *** [__modpost] Error 1
>>
>> I think the right answer here is to make __put_devmap_managed_page()
>> EXPORT_SYMBOL(), since features like devm_memremap_pages() want to
>> change the behavior of all users of put_page(). It again holds that
>> devm_memremap_pages() needs to become EXPORT_SYMBOL_GPL() because it,
>> not put_page(), is the interface that is leaking control of core
>> kernel state/infrastructure to its users.
>>
>
> Hi Dan and all,
>
> It looks like put_page() also picks up one more GPL symbol:
> devmap_managed_key.
>
> put_page
>     put_devmap_managed_page
>         devmap_managed_key
>
>     __put_devmap_managed_page
>
>
> So if the goal is to restore put_page() to be effectively EXPORT_SYMBOL
> again, then I think there would also need to be either a non-inlined
> wrapper for devmap_managed_key (awkward for a static key), or else make
> it EXPORT_SYMBOL, or maybe something else that's less obvious to me at the
> moment.

Right, certainly flipping the key is a kernel internal detail since it
is giving the dev_pagemap owner purview over all kernel page events,
but put_page() users are silent consumers. And you're right there's
currently no good way I see to export the 'producer' and 'consumer'
side of the key with different export types.
