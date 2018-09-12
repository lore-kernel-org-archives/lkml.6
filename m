Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46814C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8EBC20890
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 16:50:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="X31X476t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8EBC20890
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbeILVz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 17:55:58 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:39105 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbeILVz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 17:55:58 -0400
Received: by mail-oi0-f67.google.com with SMTP id c190-v6so5084391oig.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 09:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DIYxv93rRAzXjcu5CZZeSxm9Bznzoy5ezbvq9mlSvLE=;
        b=X31X476ttYUAQ5o+3jegptzO4RAij1oC48x1E8rKa7BVK2TeQNgdS+I3HuCMlxNzWQ
         XXm4dL8ISc561rJqUhsG0EpVhHyAmtmRK/YzS+711e+4IT4ND6t2E+o0JUFqOV8nU5O2
         dEo/6itT8GIPjfgm9KGjCT5GhGFiAZ+ndLvObRZHOMmG63pkKx2qHlFsk9HJ1uLW4Sbs
         xPIJmn8+8R6kZZNVYxa+V7BPczKG6IRmsvDB06PjORv7jDYI1d5UXmH9vFPASkfTW7H0
         r0ISFUgsgPWfAg2uC7usVChkNQQYL7tnrOINvAFQXpfddsDR2iL2oH7Ux6VjWQERu6dk
         SYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DIYxv93rRAzXjcu5CZZeSxm9Bznzoy5ezbvq9mlSvLE=;
        b=ToZn3ivQGYE5ZdnJNURUc1FVN2H3s7k91xFnIgPoWGzNAQUNpZj3860uK2haSwY4rX
         ypZtOolZ7wTCctkw2tRl77eoFVfLdo1yEHlNb5rLkT/jZyK5bW+3OIKygTsKZlMbpkcV
         8T9J4sU9ObeUDmvyjwNOc9JU+7/1tdZ02HPJvMsytb0b4BjCjqAR0pXrfgAoLqKVGnST
         fAEQL7/i63PmbyyWvmAYatXCFPho5FLNxFUKt8BZMFlw1bpvqCn9XpmiQdWe4UWajK/4
         u0eLo5xRmet8tU8vhQK+lzM8cPJrJmSLyfKNN8fY+IgTfuvZ9vhnfiATnTrY7u/dsI+U
         1lyQ==
X-Gm-Message-State: APzg51DckZT3r6pSXCyyewrCDtpvqFtLbwQgnnHuAUrUqBCsRNP7RL5H
        1ZwQ1oUWmvxLkIvQmZEKYP8I++FRDgEUpe1DEQMoYw==
X-Google-Smtp-Source: ANB0VdZDx+GU2QZxFyPHNVQM35KywDDT51hGVu/hYj2it1okxIe2hHhH5WF52jKvk2rDPalAFDqATkFiaMbRB0RZJA4=
X-Received: by 2002:aca:ec0d:: with SMTP id k13-v6mr3073695oih.236.1536771034706;
 Wed, 12 Sep 2018 09:50:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 09:50:34
 -0700 (PDT)
In-Reply-To: <CAKgT0UdKZVUPBk=rg5kfUuFBpuZQEKPuGw31x5O2nMyuULgi0g@mail.gmail.com>
References: <20180910232615.4068.29155.stgit@localhost.localdomain>
 <20180910234354.4068.65260.stgit@localhost.localdomain> <7b96298e-9590-befd-0670-ed0c9fcf53d5@microsoft.com>
 <CAKgT0UdKZVUPBk=rg5kfUuFBpuZQEKPuGw31x5O2nMyuULgi0g@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Sep 2018 09:50:34 -0700
Message-ID: <CAPcyv4gEDwp8Xh4_E8RNBC_OqstwhqxkZOpvYjWd_siB4C=BEQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] mm: Defer ZONE_DEVICE page initialization to the
 point where we init pgmap
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Pavel.Tatashin@microsoft.com, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 8:48 AM, Alexander Duyck
<alexander.duyck@gmail.com> wrote:
> On Wed, Sep 12, 2018 at 6:59 AM Pasha Tatashin
> <Pavel.Tatashin@microsoft.com> wrote:
>>
>> Hi Alex,
>
> Hi Pavel,
>
>> Please re-base on linux-next,  memmap_init_zone() has been updated there
>> compared to mainline. You might even find a way to unify some parts of
>> memmap_init_zone and memmap_init_zone_device as memmap_init_zone() is a
>> lot simpler now.
>
> This patch applied to the linux-next tree with only a little bit of
> fuzz. It looks like it is mostly due to some code you had added above
> the function as well. I have updated this patch so that it will apply
> to both linux and linux-next by just moving the new function to
> underneath memmap_init_zone instead of above it.
>
>> I think __init_single_page() should stay local to page_alloc.c to keep
>> the inlining optimization.
>
> I agree. In addition it will make pulling common init together into
> one space easier. I would rather not have us create an opportunity for
> things to further diverge by making it available for anybody to use.

I'll buy the inline argument for keeping the new routine in
page_alloc.c, but I otherwise do not see the divergence danger or
"making __init_single_page() available for anybody" given the the
declaration is limited in scope to a mm/ local header file.
