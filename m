Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289F0C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA437218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 21:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRDDhEn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfAYVDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 16:03:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37433 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAYVDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 16:03:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so11737971wrt.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 13:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlFA8LtVMqJOfnjC7UmYvTFlMlqdaOETYFtC07gL8c8=;
        b=JRDDhEn8/pBLDYMXq+rCIIkS2PvE/vCc8+Vgigg/VxRv1eyxQObLuf9Ql56fZebign
         hZZqX3LZTlxh4qtYJaHRX2ZnZzRI7SNdQMloqP3An+Di6jaSMBjtcI/JkdMlqzFC7BEj
         tkjLMRL0VYIJA0AfWf3mSFlXN8mfnFRs1vQPOThm+lQyqR7/DIeHKPd2b+iEhtmP8cNq
         4SJIynT+/KmTQu69nps1hVdBtXq267EqcDrobJaMrTFCskCvhU1WRvRJrO1Hf8U8jAuH
         0OQeoiMxMDs+Md0Ca0wNaQmVQZ/n7I0rK2cPmMM6IwHp4d2nC7eHBJYVhXFM8VCGru71
         w3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlFA8LtVMqJOfnjC7UmYvTFlMlqdaOETYFtC07gL8c8=;
        b=lJiLxiR6hoAKUkpAZPs223Ebc2k2nw6LNuULEswFF+8uay7nRvUhHQgpitW1OD9oNh
         4PDHFxMYUpIXthvu9v9zr+w421IRVY7Ef3feSjTD6B82I8YT3yO7QsehzPAtpSIY9fkH
         2m53ZaNrd6bVEFt74vUU30z99G4nqM87VBd2VMg46t1KdUKX8pFODCD8sRTgHmR9Fj7k
         txlMKPvrt1jqLGGRmmEbmlf/hbIlQgAzLBOBtTRRVZnOHFWkinnHBmhI18DW5gzikhGh
         lTQxaxeHFG/AH6qgoUyUFt8nlEacyS86MOZOiv6+4Q+g5aSucMQSFVynrNU0Lp2v83+w
         kyfA==
X-Gm-Message-State: AJcUukelZ0i/DNDvq7czSHuK9dw51zDrQGRW5/M9s72G3/Huj1FHN/1M
        00AHfep3oIojVHbla7lxzJFfzlv9sRpGGot64keb
X-Google-Smtp-Source: ALg8bN4YSnU8ocVyHeD54PjkgUNpLaNRE+Av0um87TRh1jxbNHujScXrZ+6dCqJZAqSI4YIMKMgZIpl7xkOcH+hyQDg=
X-Received: by 2002:adf:9b11:: with SMTP id b17mr13033849wrc.168.1548450186690;
 Fri, 25 Jan 2019 13:03:06 -0800 (PST)
MIME-Version: 1.0
References: <20190124231441.37A4A305@viggo.jf.intel.com> <20190124231442.EFD29EE0@viggo.jf.intel.com>
In-Reply-To: <20190124231442.EFD29EE0@viggo.jf.intel.com>
From:   Bjorn Helgaas <bhelgaas@google.com>
Date:   Fri, 25 Jan 2019 15:02:55 -0600
Message-ID: <CAErSpo7kMjfi-1r8ZyGbheWzo+JCFkDZ1zpVhyNV7VVy8NOV7g@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/resource: return real error codes from walk failures
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        vishal.l.verma@intel.com, thomas.lendacky@amd.com,
        Andrew Morton <akpm@linux-foundation.org>, mhocko@suse.com,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org,
        Huang Ying <ying.huang@intel.com>,
        Wu Fengguang <fengguang.wu@intel.com>,
        Borislav Petkov <bp@suse.de>, baiyaowei@cmss.chinamobile.com,
        Takashi Iwai <tiwai@suse.de>,
        Jerome Glisse <jglisse@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 5:21 PM Dave Hansen <dave.hansen@linux.intel.com> wrote:
>
>
> From: Dave Hansen <dave.hansen@linux.intel.com>
>
> walk_system_ram_range() can return an error code either becuase *it*
> failed, or because the 'func' that it calls returned an error.  The
> memory hotplug does the following:
>
>         ret = walk_system_ram_range(..., func);
>         if (ret)
>                 return ret;
>
> and 'ret' makes it out to userspace, eventually.  The problem is,
> walk_system_ram_range() failues that result from *it* failing (as
> opposed to 'func') return -1.  That leads to a very odd -EPERM (-1)
> return code out to userspace.
>
> Make walk_system_ram_range() return -EINVAL for internal failures to
> keep userspace less confused.
>
> This return code is compatible with all the callers that I audited.
>
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ross Zwisler <zwisler@kernel.org>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: linux-nvdimm@lists.01.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Fengguang Wu <fengguang.wu@intel.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Yaowei Bai <baiyaowei@cmss.chinamobile.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Jerome Glisse <jglisse@redhat.com>
> ---
>
>  b/kernel/resource.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff -puN kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1 kernel/resource.c
> --- a/kernel/resource.c~memory-hotplug-walk_system_ram_range-returns-neg-1      2019-01-24 15:13:13.950199540 -0800
> +++ b/kernel/resource.c 2019-01-24 15:13:13.954199540 -0800
> @@ -375,7 +375,7 @@ static int __walk_iomem_res_desc(resourc
>                                  int (*func)(struct resource *, void *))
>  {
>         struct resource res;
> -       int ret = -1;
> +       int ret = -EINVAL;
>
>         while (start < end &&
>                !find_next_iomem_res(start, end, flags, desc, first_lvl, &res)) {
> @@ -453,7 +453,7 @@ int walk_system_ram_range(unsigned long
>         unsigned long flags;
>         struct resource res;
>         unsigned long pfn, end_pfn;
> -       int ret = -1;
> +       int ret = -EINVAL;

Can you either make a similar change to the powerpc version of
walk_system_ram_range() in arch/powerpc/mm/mem.c or explain why it's
not needed?  It *seems* like we'd want both versions of
walk_system_ram_range() to behave similarly in this respect.

>         start = (u64) start_pfn << PAGE_SHIFT;
>         end = ((u64)(start_pfn + nr_pages) << PAGE_SHIFT) - 1;
> _
