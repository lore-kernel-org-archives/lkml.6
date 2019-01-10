Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CABC43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1E4206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547134980;
	bh=FXJ1iz5WNG0QSy1AsNfGXNwrMpOWSySM4sx4zxKTb7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WA9rOL1KWIADIvwtgPp+ZkqSL6XX+w3UgtfgO03cO45RfR3BIJ72lWXdj/M2flYyx
	 HU9koG+HkqiX8cplA+taJEqMoLvMg+EmsxfUtd0R3dYfworCM2pDHWsaY7LtdLXOM8
	 lgHsafn0XC6fbTWRAjkSpcFDOKDbaJZNA6PzNRSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbfAJPm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 10:42:59 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:32995 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbfAJPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 10:42:59 -0500
Received: by mail-oi1-f169.google.com with SMTP id c206so9645153oib.0;
        Thu, 10 Jan 2019 07:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIo17yS5foLiDNl25sS9lgnD+T4jl/8vOevtYNc+rHg=;
        b=SJn9gLTR/G2deuQU4MmtQyxsJSrjFlMdfLmgC7+DzuXAlaC+dM2+Om8B2YrKgIMiCo
         ey/8NvULG+miD/z5IjfHtyq4guQWAmfOJ5mHS7pNEo12JgIxeL4CAOuq+g1STYrhC0Ef
         jDEIfpd/unP3TfyiHCMhFNzqyWeimdZC7bJ+prv66gHdWPSNHMHfRU2aqRg4TCfN9WND
         lF8DNy2XF2fcUj9pmle13rnjDWN2/mYt4UQcgzEZVu1BpdOh0jM2egl4I8Pp1gLf4Qz1
         hMyvsrImNEYFZP+BkiCTWJSJQcRxTBn3njBL4oVS5J9pzwSSUIjj0g1e1dPW7z7jM2Z0
         UZRA==
X-Gm-Message-State: AJcUukfEIiPCUryVAFU1P13CG9Hc9w2/S2ZoXhcUSbPGcwrRjlHURtZN
        9tVHlUOTcC7pF09ad3RozRDwEN1Um7WJRolB2rI=
X-Google-Smtp-Source: ALg8bN45YzZ84yRuu2JFJW2+KLgiak9oXM78BJ+vuQKTjJfCiae4e7/XKMlIuHwjb2QJ9i0rgQ4HDbWdNMN4ZlzWykw=
X-Received: by 2002:aca:b642:: with SMTP id g63mr6418177oif.195.1547134977996;
 Thu, 10 Jan 2019 07:42:57 -0800 (PST)
MIME-Version: 1.0
References: <20190109174341.19818-1-keith.busch@intel.com> <20190109174341.19818-4-keith.busch@intel.com>
In-Reply-To: <20190109174341.19818-4-keith.busch@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Jan 2019 16:42:46 +0100
Message-ID: <CAJZ5v0jk7ML21zxGwf9GaGNK8tP1LAs6Rd9NTK5O9HbzYeyPLA@mail.gmail.com>
Subject: Re: [PATCHv3 03/13] acpi/hmat: Parse and report heterogeneous memory
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

On Wed, Jan 9, 2019 at 6:47 PM Keith Busch <keith.busch@intel.com> wrote:
>
> Systems may provide different memory types and export this information
> in the ACPI Heterogeneous Memory Attribute Table (HMAT). Parse these
> tables provided by the platform and report the memory access and caching
> attributes.
>
> Signed-off-by: Keith Busch <keith.busch@intel.com>

While this is generally fine by me, it's another piece of code going
under drivers/acpi/ just because it happens to use ACPI to extract
some information from the platform firmware.

Isn't there any better place for it?

> ---
>  drivers/acpi/Kconfig  |   8 +++
>  drivers/acpi/Makefile |   1 +
>  drivers/acpi/hmat.c   | 180 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 189 insertions(+)
>  create mode 100644 drivers/acpi/hmat.c
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 7b65a807b3dd..b102d9f544ee 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -326,6 +326,14 @@ config ACPI_NUMA
>         depends on (X86 || IA64 || ARM64)
>         default y if IA64_GENERIC || IA64_SGI_SN2 || ARM64
>
> +config ACPI_HMAT
> +       bool "ACPI Heterogeneous Memory Attribute Table Support"
> +       depends on ACPI_NUMA
> +       help
> +        Parses representation of the ACPI Heterogeneous Memory Attributes
> +        Table (HMAT) and set the memory node relationships and access
> +        attributes.
> +
>  config ACPI_CUSTOM_DSDT_FILE
>         string "Custom DSDT Table file to include"
>         default ""
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 7c6afc111d76..2a435dcfaa9c 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -55,6 +55,7 @@ acpi-$(CONFIG_X86)            += x86/apple.o
>  acpi-$(CONFIG_X86)             += x86/utils.o
>  acpi-$(CONFIG_DEBUG_FS)                += debugfs.o
>  acpi-$(CONFIG_ACPI_NUMA)       += numa.o
> +acpi-$(CONFIG_ACPI_HMAT)       += hmat.o
>  acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
>  acpi-y                         += acpi_lpat.o
>  acpi-$(CONFIG_ACPI_LPIT)       += acpi_lpit.o
> diff --git a/drivers/acpi/hmat.c b/drivers/acpi/hmat.c
> new file mode 100644
> index 000000000000..833a783868d5
> --- /dev/null
> +++ b/drivers/acpi/hmat.c
> @@ -0,0 +1,180 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Heterogeneous Memory Attributes Table (HMAT) representation
> + *
> + * Copyright (c) 2018, Intel Corporation.
> + */
> +
> +#include <acpi/acpi_numa.h>
> +#include <linux/acpi.h>
> +#include <linux/bitops.h>
> +#include <linux/cpu.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/node.h>
> +#include <linux/slab.h>
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
> +       struct acpi_hmat_locality *loc = (void *)header;
> +       unsigned int init, targ, total_size, ipds, tpds;
> +       u32 *inits, *targs, value;
> +       u16 *entries;
> +       u8 type;
> +
> +       if (loc->header.length < sizeof(*loc)) {
> +               pr_err("HMAT: Unexpected locality header length: %d\n",
> +                       loc->header.length);
> +               return -EINVAL;
> +       }
> +
> +       type = loc->data_type;
> +       ipds = loc->number_of_initiator_Pds;
> +       tpds = loc->number_of_target_Pds;
> +       total_size = sizeof(*loc) + sizeof(*entries) * ipds * tpds +
> +                    sizeof(*inits) * ipds + sizeof(*targs) * tpds;
> +       if (loc->header.length < total_size) {
> +               pr_err("HMAT: Unexpected locality header length:%d, minimum required:%d\n",
> +                       loc->header.length, total_size);
> +               return -EINVAL;
> +       }
> +
> +       pr_info("HMAT: Locality: Flags:%02x Type:%s Initiator Domains:%d Target Domains:%d Base:%lld\n",
> +               loc->flags, hmat_data_type(type), ipds, tpds,
> +               loc->entry_base_unit);
> +
> +       inits = (u32 *)(loc + 1);
> +       targs = &inits[ipds];
> +       entries = (u16 *)(&targs[tpds]);
> +       for (targ = 0; targ < tpds; targ++) {
> +               for (init = 0; init < ipds; init++) {
> +                       value = entries[init * tpds + targ];
> +                       value = (value * loc->entry_base_unit) / 10;
> +                       pr_info("  Initiator-Target[%d-%d]:%d%s\n",
> +                               inits[init], targs[targ], value,
> +                               hmat_data_type_suffix(type));
> +               }
> +       }
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
> +               pr_err("HMAT: Unexpected cache header length: %d\n",
> +                       cache->header.length);
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
> +               pr_err("HMAT: Unexpected address range header length: %d\n",
> +                       spa->header.length);
> +               return -EINVAL;
> +       }
> +       pr_info("HMAT: Memory (%#llx length %#llx) Flags:%04x Processor Domain:%d Memory Domain:%d\n",
> +               spa->physical_address_base, spa->physical_address_length,
> +               spa->flags, spa->processor_PD, spa->memory_PD);
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
