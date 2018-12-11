Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF4BC67839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412920879
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 20:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Qaa6IhyF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4412920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeLKU37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 15:29:59 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38610 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbeLKU36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 15:29:58 -0500
Received: by mail-oi1-f194.google.com with SMTP id a77so13141455oii.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 12:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8hf0WlpIFQsE8x4J91QlHXac9UkB7DkkRQtdcyA9kI=;
        b=Qaa6IhyFm8GsyolomLNyBzeTGAeBsNt+Ryo8DUmFXMOxvT7nX5yKN4rDyiNLnrJFVZ
         1wiE047CjDWTQnXnVdNJ4OdXYVomNtI3H+F44+1JzJfno1qKBe22UrVhgRXU7FTsERxh
         fiWENHh86xUpQy+16kUCRgpJb1FgwavYGdv9w/JSDLN5MBCZt2UHA3qwAKyVFUxhokbT
         lzub+WBTLuT4UdcXv65dtFEWcOD/zgWd/XdYeb2EHTU1xvS6/yZKzCwsVwvzsvRNkyCW
         s526RTbpFEwXC5f0bLgf1sWmD1yOJXN8nad4SfaPdDtU3bJQvlS6rGsMLW2a/rQwStMM
         y34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8hf0WlpIFQsE8x4J91QlHXac9UkB7DkkRQtdcyA9kI=;
        b=Xs+lpUcIuCKnOPbACkGM3dT8v+mpxdq5j1I6Qnr/lO2yZkSUfY3mmSUQK9gzXRC1X2
         k0F6jNf2xxIjeyFf37qt4zXoJ08zHlQUlztfq0YA6yVAiWvzQsLzQj4xC4WgnmsZ1hQD
         6mBIiGC8ZPu9sSFQjSkf//8IIbSvDvMz6C/qo54gCskYPWvMuptlrmiuEMDqo+xCTM7O
         xB0Wk9hTrJSKuH+3TIPHexecGX3Xzh4d7i27ARXzTOuZcmNenKQ920V2Ap7Sc22UGtju
         Xs464Y6psFL+kOmf28zfcUJTWXInRAL/REdtUUoFBblaU/TRUftC9UmjuTr5FEsxDz2R
         Vpjg==
X-Gm-Message-State: AA+aEWYdr1sNp2QZfXRvEAeP58Qj1YE89w+1CK/4Sjqz4mA11YJBEvGV
        nxT/qlbd3QO++Rj2fpbScloBv/2NUG2CU07kDlKHrZjOeMs=
X-Google-Smtp-Source: AFSGD/WP+H6Bhwbz8g0bcUq680XJI+hoPFz+XlCpUFLZ+gK0C7RZd3Y8oqnGOqMC1WDtTktt5JkPErcDLzpNnrrp9So=
X-Received: by 2002:aca:4307:: with SMTP id q7mr2270628oia.105.1544560197164;
 Tue, 11 Dec 2018 12:29:57 -0800 (PST)
MIME-Version: 1.0
References: <20181211010310.8551-1-keith.busch@intel.com> <20181211010310.8551-3-keith.busch@intel.com>
 <CAPcyv4gEpxigPqc0PgDE0YCL3Ot+wPfvChAZqUTtdYR2WDxaJg@mail.gmail.com> <20181211165518.GB8101@localhost.localdomain>
In-Reply-To: <20181211165518.GB8101@localhost.localdomain>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Dec 2018 12:29:45 -0800
Message-ID: <CAPcyv4id0mgjdBPPw8Y26rodOEQ=EHfaTrgasU5g4X7u=dS2xw@mail.gmail.com>
Subject: Re: [PATCHv2 02/12] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 8:58 AM Keith Busch <keith.busch@intel.com> wrote:
>
> On Mon, Dec 10, 2018 at 10:03:40PM -0800, Dan Williams wrote:
> > I have a use case to detect the presence of a memory-side-cache early
> > at init time [1]. To me this means that hmat_init() needs to happen as
> > a part of acpi_numa_init(). Subsequently I think that also means that
> > the sysfs portion needs to be broken out to its own init path that can
> > probably run at module_init() priority.
> >
> > Perhaps we should split this patch set into two? The table parsing
> > with an in-kernel user is a bit easier to reason about and can go in
> > first. Towards that end can I steal / refllow patches 1 & 2 into the
> > memory randomization series? Other ideas how to handle this?
> >
> > [1]: https://lkml.org/lkml/2018/10/12/309
>
> To that end, will something like the following work for you? This just
> needs to happen after patch 1.
>
> ---
> diff --git a/drivers/acpi/numa.c b/drivers/acpi/numa.c
> index f5e09c39ff22..03ef3c8ba4ea 100644
> --- a/drivers/acpi/numa.c
> +++ b/drivers/acpi/numa.c
> @@ -40,6 +40,8 @@ static int pxm_to_node_map[MAX_PXM_DOMAINS]
>  static int node_to_pxm_map[MAX_NUMNODES]
>                         = { [0 ... MAX_NUMNODES - 1] = PXM_INVAL };
>
> +static unsigned long node_side_cached[BITS_TO_LONGS(MAX_PXM_DOMAINS)];
> +
>  unsigned char acpi_srat_revision __initdata;
>  int acpi_numa __initdata;
>
> @@ -262,6 +264,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>         u64 start, end;
>         u32 hotpluggable;
>         int node, pxm;
> +       bool side_cached;
>
>         if (srat_disabled())
>                 goto out_err;
> @@ -308,6 +311,11 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
>                 pr_warn("SRAT: Failed to mark hotplug range [mem %#010Lx-%#010Lx] in memblock\n",
>                         (unsigned long long)start, (unsigned long long)end - 1);
>
> +       side_cached = test_bit(pxm, node_side_cached);
> +       if (side_cached && memblock_mark_sidecached(start, ma->length))
> +               pr_warn("SRAT: Failed to mark side cached range [mem %#010Lx-%#010Lx] in memblock\n",
> +                       (unsigned long long)start, (unsigned long long)end - 1);
> +
>         max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
>
>         return 0;
> @@ -411,6 +419,19 @@ acpi_parse_memory_affinity(union acpi_subtable_headers * header,
>         return 0;
>  }
>
> +static int __init
> +acpi_parse_cache(union acpi_subtable_headers *header, const unsigned long end)
> +{
> +       struct acpi_hmat_cache *cache = (void *)header;
> +       u32 attrs;
> +
> +       attrs = cache->cache_attributes;
> +       if (((attrs & ACPI_HMAT_CACHE_ASSOCIATIVITY) >> 8) ==
> +                                               ACPI_HMAT_CA_DIRECT_MAPPED)
> +               set_bit(cache->memory_PD, node_side_cached);

I'm not sure I see a use case for 'node_side_cached'. Instead I need
to know if a cache intercepts a "System RAM" resource, because a cache
in front of a reserved address range would not be impacted by page
allocator randomization. Or, are you saying have memblock generically
describes this capability and move the responsibility of acting on
that data to a higher level?

The other detail to consider is the cache ratio size, but that would
be a follow on feature. The use case is to automatically determine the
ratio to pass to numa_emulation:

    cc9aec03e58f x86/numa_emulation: Introduce uniform split capability

> +       return 0;
> +}
> +
>  static int __init acpi_parse_srat(struct acpi_table_header *table)
>  {
>         struct acpi_table_srat *srat = (struct acpi_table_srat *)table;
> @@ -422,6 +443,11 @@ static int __init acpi_parse_srat(struct acpi_table_header *table)
>         return 0;
>  }
>
> +static __init int acpi_parse_hmat(struct acpi_table_header *table)
> +{
> +       return 0;
> +}

What's this acpi_parse_hmat() stub for?

> +
>  static int __init
>  acpi_table_parse_srat(enum acpi_srat_type id,
>                       acpi_tbl_entry_handler handler, unsigned int max_entries)
> @@ -460,6 +486,16 @@ int __init acpi_numa_init(void)
>                                         sizeof(struct acpi_table_srat),
>                                         srat_proc, ARRAY_SIZE(srat_proc), 0);
>
> +               if (!acpi_table_parse(ACPI_SIG_HMAT, acpi_parse_hmat)) {
> +                       struct acpi_subtable_proc hmat_proc;
> +
> +                       memset(&hmat_proc, 0, sizeof(hmat_proc));
> +                       hmat_proc.handler = acpi_parse_cache;
> +                       hmat_proc.id = ACPI_HMAT_TYPE_CACHE;
> +                       acpi_table_parse_entries_array(ACPI_SIG_HMAT,
> +                                               sizeof(struct acpi_table_hmat),
> +                                               &hmat_proc, 1, 0);
> +               }
>                 cnt = acpi_table_parse_srat(ACPI_SRAT_TYPE_MEMORY_AFFINITY,
>                                             acpi_parse_memory_affinity, 0);
>         }
> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> index aee299a6aa76..a24c918a4496 100644
> --- a/include/linux/memblock.h
> +++ b/include/linux/memblock.h
> @@ -44,6 +44,7 @@ enum memblock_flags {
>         MEMBLOCK_HOTPLUG        = 0x1,  /* hotpluggable region */
>         MEMBLOCK_MIRROR         = 0x2,  /* mirrored region */
>         MEMBLOCK_NOMAP          = 0x4,  /* don't add to kernel direct mapping */
> +       MEMBLOCK_SIDECACHED     = 0x8,  /* System side caches memory access */

I'm concerned that we may be stretching memblock past its intended use
case especially for just this randomization case. For example, I think
memblock_find_in_range() gets confused in the presence of
MEMBLOCK_SIDECACHED memblocks.
