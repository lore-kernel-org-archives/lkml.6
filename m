Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526119781; cv=none;
        d=google.com; s=arc-20160816;
        b=0IuEo5KRlZRUYmJCiRTgKWzFpdvcKO5iEPFYqVjtL1BCL2xduWfM7a2ADDmnvwtcIv
         YicrRo8PMdhnD2dW87hoGXBjbti38v3dzBnF4rNMv+e+kHfONOYmh5YpQhJa22Ysg7TX
         kHhXRWsXhBnI+CojsH7bUuJyHF+gCm4z4s4rc2fA3Ak/78/TZr3bfM3rlMzVoVhzz82+
         CDCNxuilH7ExQzbJREfA7lTIeauym8/2f9zX0lSdvCJGVeadelWIQL5uyvX9EuNR2sZ0
         5dD8b/oWmKlbRmwX2RAoM4Ng6cEsw559EbmffntqYaEEJqjYCvNvdFYf5uU1ciGo7H5X
         h6Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=vM5K/YmzG544FjYteYUeXuU2VTsPglRymP6tRkPE5g0=;
        b=fzS/cm12q9Zjc+uaSg4Pn4mI2wIJKUmxXWsibg4eZBeKgnVgN6axneLt10lj7FKa9J
         SqPWCEIA4KHRfP1uZMXC5bY+cIHL7fVqk+h90WAujXJkK+si7nIx48Uprzz6zmPDK870
         G8s2nGNWPCiIsJ8czueat0Kj6GBlAxq+oQrNsZH43sTljstBEduYGRNniJRgmezqCm8q
         UiICCe284ME8JQbDv7XEi/+mWgJ8OFACihv2R8ppholZyYN+PpIZCiYNwnwPY6DA0MWX
         X+rTYrJAOq90lt0YsbVgP6zz/WbO0EgRSh2WDJpK9PDvBlaM3G4jRAEpUEb+FjeSVv7w
         ZyWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VrQyAeMf;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VrQyAeMf;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpr30IauVtBIQ7iSSePVJXkaf5qeW/wwLvdgBZmLm1VHofAVV4v02695iHO42vNCtS9rizZpK9/OrbDsKUscWs=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180511235807.30834-6-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-6-jeremy.linton@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 12 May 2018 12:09:40 +0200
X-Google-Sender-Auth: AsQdpkMVybH9QQdoT5oCdv2FiCw
Message-ID: <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com>
Subject: Re: [PATCH v9 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214162685472859?=
X-GMAIL-MSGID: =?utf-8?q?1600252576175786623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> ACPI 6.2 adds a new table, which describes how processing units
> are related to each other in tree like fashion. Caches are
> also sprinkled throughout the tree and describe the properties
> of the caches in relation to other caches and processing units.
>
> Add the code to parse the cache hierarchy and report the total
> number of levels of cache for a given core using
> acpi_find_last_cache_level() as well as fill out the individual
> cores cache information with cache_setup_acpi() once the
> cpu_cacheinfo structure has been populated by the arch specific
> code.
>
> An additional patch later in the set adds the ability to report
> peers in the topology using find_acpi_cpu_topology()
> to report a unique ID for each processing unit at a given level
> in the tree. These unique id's can then be used to match related
> processing units which exist as threads, within a given
> package, etc.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/acpi/pptt.c  | 655 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h |   4 +
>  2 files changed, 659 insertions(+)
>  create mode 100644 drivers/acpi/pptt.c
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> new file mode 100644
> index 000000000000..e5ea1974d1e3
> --- /dev/null
> +++ b/drivers/acpi/pptt.c
> @@ -0,0 +1,655 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pptt.c - parsing of Processor Properties Topology Table (PPTT)
> + *
> + * Copyright (C) 2018, ARM
> + *
> + * This file implements parsing of the Processor Properties Topology Table
> + * which is optionally used to describe the processor and cache topology.
> + * Due to the relative pointers used throughout the table, this doesn't
> + * leverage the existing subtable parsing in the kernel.
> + *
> + * The PPTT structure is an inverted tree, with each node potentially
> + * holding one or two inverted tree data structures describing
> + * the caches available at that level. Each cache structure optionally
> + * contains properties describing the cache at a given level which can be
> + * used to override hardware probed values.
> + */
> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/cacheinfo.h>
> +#include <acpi/processor.h>
> +
> +static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
> +                                                       u32 pptt_ref)
> +{
> +       struct acpi_subtable_header *entry;
> +
> +       /* there isn't a subtable at reference 0 */
> +       if (pptt_ref < sizeof(struct acpi_subtable_header))
> +               return NULL;
> +
> +       if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
> +               return NULL;
> +
> +       entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
> +
> +       if (entry->length == 0)
> +               return NULL;
> +
> +       if (pptt_ref + entry->length > table_hdr->length)
> +               return NULL;
> +
> +       return entry;
> +}
> +
> +static struct acpi_pptt_processor *fetch_pptt_node(struct acpi_table_header *table_hdr,
> +                                                  u32 pptt_ref)
> +{
> +       return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
> +}
> +
> +static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_hdr,
> +                                               u32 pptt_ref)
> +{
> +       return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);

I don't think you really need the explicit type cast here and above,
but that's very minor.

> +}

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

to the patch and route it through the arch tree as needed.

Thanks,
Rafael
