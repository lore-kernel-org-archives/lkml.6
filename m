Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E59C4151A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ECD2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549368745;
	bh=TKAFWyALSYrJtQq3RTQXZT4fFm2/f8UX+QE6SI0ty+s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VDDkk33Q1x6IjFJcBBWMV1RdYpXQKuh6njrooA930MAWQZkl8S+I0QzTdpHiwARns
	 aT0adA+iX5Ey6vordNuf20cGhzGMuJoF6qYepXmkkcrXuAuyY1WsrYpuhxgHnD7w1V
	 fiSWzSS3JJBdex/IJZxlOpEwFa2gEyuG9aNrwqs8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbfBEMMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:12:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38035 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbfBEMMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:12:22 -0500
Received: by mail-ot1-f66.google.com with SMTP id e12so5267025otl.5;
        Tue, 05 Feb 2019 04:12:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TqwDRd3S+vQTQKMSBao5/XjRBpR/yrOFiU9e8EKfsRU=;
        b=qJw2vU8CJKzZzdFsVN0a95DKXoE29XPa+X9ahwJk67k34FRgeoHY+eqeiUK5higuR7
         /ApMEP8C5WAj5xO6U7e2gnbmVYRbjueMSKSqnm97BfnEwc3sczmGXoMVHIylZGXlES4G
         LEjr4fMW3+7OnUvc35FXhnyc9vO80WO4fWtEU0clq4/aE4vEGiWBlhXDgB/ebWao6SI2
         la8upo9rUb7x0HIwUmR2mroryaGs/f+31bKyiLa7n9PV/DXKkcwHskjtPjGtLkLRS0Ft
         goQEOlCP9xNRXxbkRnJavIkHYjajZqfEiWfLrq+sjDQRa4ZxYN2UxrVRkiedriGfN4K8
         IR7A==
X-Gm-Message-State: AHQUAuYcFQKHv+phko8OqIK174Q1obmRJ2xX4kcQ2re6SpgSXOoQYWvu
        FJMDYaSWTrpQ3Ijc4mPwO2lie+cLJHP0yGymAnd0vQ==
X-Google-Smtp-Source: AHgI3Iaq6TfcWn6v8MYhvMCHHXi+TfZu0sx4kGro/cmBTrZhFpl8fBz9XcCWHaGxmVd6BUXxq2ufjsP+qVIUdLKGH0w=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr2502594otg.139.1549368741499;
 Tue, 05 Feb 2019 04:12:21 -0800 (PST)
MIME-Version: 1.0
References: <20190124230724.10022-1-keith.busch@intel.com> <20190124230724.10022-4-keith.busch@intel.com>
In-Reply-To: <20190124230724.10022-4-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Feb 2019 13:12:09 +0100
Message-ID: <CAJZ5v0iOESR+51j03FkqANKiNujQu-en8+D2L1F5LTJD0Owjuw@mail.gmail.com>
Subject: Re: [PATCHv5 03/10] acpi/hmat: Parse and report heterogeneous memory
To:     Keith Busch <keith.busch@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 12:08 AM Keith Busch <keith.busch@intel.com> wrote:
>
> Systems may provide different memory types and export this information
> in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> tables provided by the platform and report the memory access and caching
> attributes to the kernel messages.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/Kconfig       |   1 +
>  drivers/acpi/Makefile      |   1 +
>  drivers/acpi/hmat/Kconfig  |   8 ++
>  drivers/acpi/hmat/Makefile |   1 +
>  drivers/acpi/hmat/hmat.c   | 181 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 192 insertions(+)
>  create mode 100644 drivers/acpi/hmat/Kconfig
>  create mode 100644 drivers/acpi/hmat/Makefile
>  create mode 100644 drivers/acpi/hmat/hmat.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 90ff0a47c12e..b377f970adfd 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -465,6 +465,7 @@ config ACPI_REDUCED_HARDWARE_ONLY
>           If you are unsure what to do, do not enable this option.
>
>  source "drivers/acpi/nfit/Kconfig"
> +source "drivers/acpi/hmat/Kconfig"
>
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index bb857421c2e8..5d361e4e3405 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_ACPI_PROCESSOR)  += processor.o
>  obj-$(CONFIG_ACPI)             += container.o
>  obj-$(CONFIG_ACPI_THERMAL)     += thermal.o
>  obj-$(CONFIG_ACPI_NFIT)                += nfit/
> +obj-$(CONFIG_ACPI_HMAT)                += hmat/
>  obj-$(CONFIG_ACPI)             += acpi_memhotplug.o
>  obj-$(CONFIG_ACPI_HOTPLUG_IOAPIC) += ioapic.o
>  obj-$(CONFIG_ACPI_BATTERY)     += battery.o
> diff --git a/drivers/acpi/hmat/Kconfig b/drivers/acpi/hmat/Kconfig
> new file mode 100644
> index 000000000000..c9637e2e7514
> --- /dev/null
> +++ b/drivers/acpi/hmat/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ACPI_HMAT
> +       bool "ACPI Heterogeneous Memory Attribute Table Support"
> +       depends on ACPI_NUMA
> +       help
> +        If set, this option causes the kernel to set the memory NUMA node
> +        relationships and access attributes in accordance with ACPI HMAT
> +        (Heterogeneous Memory Attributes Table).
> diff --git a/drivers/acpi/hmat/Makefile b/drivers/acpi/hmat/Makefile
> new file mode 100644
> index 000000000000..e909051d3d00
> --- /dev/null
> +++ b/drivers/acpi/hmat/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_ACPI_HMAT) := hmat.o
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> new file mode 100644
> index 000000000000..1741bf30d87f
> --- /dev/null
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019, Intel Corporation.
> + *
> + * Heterogeneous Memory Attributes Table (HMAT) representation
> + *
> + * This program parses and reports the platform's HMAT tables, and registers
> + * the applicable attributes with the node's interfaces.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/node.h>
> +#include <linux/sysfs.h>
> +
> +static __init const char *hmat_data_type(u8 type)
> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +               return "Access Latency";
> +       case ACPI_HMAT_READ_LATENCY:
> +               return "Read Latency";
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               return "Write Latency";
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +               return "Access Bandwidth";
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +               return "Read Bandwidth";
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               return "Write Bandwidth";
> +       default:
> +               return "Reserved";
> +       };
> +}
> +
> +static __init const char *hmat_data_type_suffix(u8 type)
> +{
> +       switch (type) {
> +       case ACPI_HMAT_ACCESS_LATENCY:
> +       case ACPI_HMAT_READ_LATENCY:
> +       case ACPI_HMAT_WRITE_LATENCY:
> +               return " nsec";
> +       case ACPI_HMAT_ACCESS_BANDWIDTH:
> +       case ACPI_HMAT_READ_BANDWIDTH:
> +       case ACPI_HMAT_WRITE_BANDWIDTH:
> +               return " MB/s";
> +       default:
> +               return "";
> +       };
> +}
> +
> +static __init int hmat_parse_locality(union acpi_subtable_headers *header,
> +                                     const unsigned long end)
> +{
> +       struct acpi_hmat_locality *hmat_loc = (void *)header;
> +       unsigned int init, targ, total_size, ipds, tpds;
> +       u32 *inits, *targs, value;
> +       u16 *entries;
> +       u8 type;
> +
> +       if (hmat_loc->header.length < sizeof(*hmat_loc)) {
> +               pr_debug("HMAT: Unexpected locality header length: %d\n",
> +                        hmat_loc->header.length);
> +               return -EINVAL;
> +       }
> +
> +       type = hmat_loc->data_type;
> +       ipds = hmat_loc->number_of_initiator_Pds;
> +       tpds = hmat_loc->number_of_target_Pds;
> +       total_size = sizeof(*hmat_loc) + sizeof(*entries) * ipds * tpds +
> +                    sizeof(*inits) * ipds + sizeof(*targs) * tpds;
> +       if (hmat_loc->header.length < total_size) {
> +               pr_debug("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
> +                        hmat_loc->header.length, total_size);
> +               return -EINVAL;
> +       }
> +
> +       pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> +               hmat_loc->flags, hmat_data_type(type), ipds, tpds,
> +               hmat_loc->entry_base_unit);
> +
> +       inits = (u32 *)(hmat_loc + 1);
> +       targs = &inits[ipds];
> +       entries = (u16 *)(&targs[tpds]);
> +       for (init = 0; init < ipds; init++) {
> +               for (targ = 0; targ < tpds; targ++) {
> +                       value = entries[init * tpds + targ];
> +                       value = (value * hmat_loc->entry_base_unit) / 10;
> +                       pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> +                               inits[init], targs[targ], value,
> +                               hmat_data_type_suffix(type));
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static __init int hmat_parse_cache(union acpi_subtable_headers *header,
> +                                  const unsigned long end)
> +{
> +       struct acpi_hmat_cache *cache = (void *)header;
> +       u32 attrs;
> +
> +       if (cache->header.length < sizeof(*cache)) {
> +               pr_debug("HMAT: Unexpected cache header length: %d\n",
> +                        cache->header.length);
> +               return -EINVAL;
> +       }
> +
> +       attrs = cache->cache_attributes;
> +       pr_info("HMAT: Cache: Domain:%d Size:%llu Attrs:%08x SMBIOS Handles:%d\n",
> +               cache->memory_PD, cache->cache_size, attrs,
> +               cache->number_of_SMBIOShandles);
> +
> +       return 0;
> +}
> +
> +static int __init hmat_parse_address_range(union acpi_subtable_headers *header,
> +                                          const unsigned long end)
> +{
> +       struct acpi_hmat_address_range *spa = (void *)header;
> +
> +       if (spa->header.length != sizeof(*spa)) {
> +               pr_debug("HMAT: Unexpected address range header length: %d\n",
> +                        spa->header.length);
> +               return -EINVAL;
> +       }
> +       pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
> +               spa->physical_address_base, spa->physical_address_length,
> +               spa->flags, spa->processor_PD, spa->memory_PD);
> +
> +       return 0;
> +}
> +
> +static int __init hmat_parse_subtable(union acpi_subtable_headers *header,
> +                                     const unsigned long end)
> +{
> +       struct acpi_hmat_structure *hdr = (void *)header;
> +
> +       if (!hdr)
> +               return -EINVAL;
> +
> +       switch (hdr->type) {
> +       case ACPI_HMAT_TYPE_ADDRESS_RANGE:
> +               return hmat_parse_address_range(header, end);
> +       case ACPI_HMAT_TYPE_LOCALITY:
> +               return hmat_parse_locality(header, end);
> +       case ACPI_HMAT_TYPE_CACHE:
> +               return hmat_parse_cache(header, end);
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +static __init int hmat_init(void)
> +{
> +       struct acpi_table_header *tbl;
> +       enum acpi_hmat_type i;
> +       acpi_status status;
> +
> +       if (srat_disabled())
> +               return 0;
> +
> +       status = acpi_get_table(ACPI_SIG_HMAT, 0, &tbl);
> +       if (ACPI_FAILURE(status))
> +               return 0;
> +
> +       for (i = ACPI_HMAT_TYPE_ADDRESS_RANGE; i < ACPI_HMAT_TYPE_RESERVED; i++) {
> +               if (acpi_table_parse_entries(ACPI_SIG_HMAT,
> +                                            sizeof(struct acpi_table_hmat), i,
> +                                            hmat_parse_subtable, 0) < 0)
> +                       goto out_put;
> +       }
> +out_put:
> +       acpi_put_table(tbl);
> +       return 0;
> +}
> +subsys_initcall(hmat_init);
> --
> 2.14.4
>
