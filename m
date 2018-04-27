Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524826921; cv=none;
        d=google.com; s=arc-20160816;
        b=pXrCnrvAIOlT96/fuYRv4Yjr+y+zgScbVB9wyFH5/ueI06BIKRYZEAJSlfkM+dGymV
         aU1wy/4sSHGeDBZMreSW92tCMD4h4K08fFFOf3vtaTMj8Syu5qk1Cv6jySt0Jkyrfv2X
         bzHnuEF+h4nkSq2EddmjfcQ4lQFk/NdTOAVIXg9KKfrhycMGS9u3NQpy7np63O/PyJfM
         wIpSEptsjQs2bJ5dVESjqL2JfmIwUirpBT5Qpya8h/4l9duZLdCCHc4HSDWtHnCNpSIx
         8zNP8CC3qPc0c5g9KPzWOZCcRUJfDYTuKjF5tEChRG6Onzn0bZZxvBJlWMW99omuSnFl
         IrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5IWXSQqECrIdnnHYoOzlvgdver40YzbTuKYT6WPs8Qc=;
        b=DPeqHn9eyAcJADhnNiJnRO6cgx6+pLjtyT/BPQEqb1NFY8lu6JEOK34u1v9HDkrf+b
         Aa4LgzqUbym5bYdq/loyVLgkBSWWD6j1cVj8q89InqFVklvnSAInW6vPmsrKjXY+7mWp
         w+kcGxvbgPvTGCpdFFNZq2rWy7SI3KZQk915vVy2eGTorwC8TlOIGIvhYZRmuxA2nG3u
         hIE5YQLWHs1OIIp8Lwoja1rk/ZQ+NOoByHhcqZbLP9K1mIFpe1WOXpGa9mEv3U1ZENju
         xB4K1eE/EQw99bUml8CNPG/TXsoF0c1HDlR3A6u5spic2TFfh+bZeJcD+7VvX+LYrWti
         4ycA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S2Nv2JDM;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=S2Nv2JDM;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com
X-Google-Smtp-Source: AB8JxZpZnN4bq2QBM3q62wG3ny7/eA9+mczYQjKTAstECFsMxHDVH0rHhf6iqCFt8YXdI/LKuXnu808GiyozUhjsNic=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180425233121.13270-6-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com> <20180425233121.13270-6-jeremy.linton@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Apr 2018 13:02:00 +0200
X-Google-Sender-Auth: q4s-HptTLEAo68JCKXZdCW0wL4A
Message-ID: <CAJZ5v0jjPnyC0vm-Fb8y2hw1B9Uc2J5sZrtZYzt_ENT2Sini3A@mail.gmail.com>
Subject: Re: [PATCH v8 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766317939933372?=
X-GMAIL-MSGID: =?utf-8?q?1598896914253206429?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 1:31 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
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
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/acpi/pptt.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 518 insertions(+)
>  create mode 100644 drivers/acpi/pptt.c
>
> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> new file mode 100644
> index 000000000000..cced71ef851a
> --- /dev/null
> +++ b/drivers/acpi/pptt.c
> @@ -0,0 +1,518 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * pptt.c - parsing of Processor Properties Topology Table
> + *
> + * Copyright (C) 2018, ARM
> + *
> + * This file implements parsing of Processor Properties Topology Table (PPTT)
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
> +/**
> + * fetch_pptt_subtable() - Find/Verify that the PPTT ref is a valid subtable

The parens above are at least redundant (if not harmful).  Everywhere
else in a similar context too.

Also kerneldoc comments document function arguments too as a rule, so
please do that here and wherever you use kerneldoc comments in the
patchset.

> + *
> + * Given the PPTT table, find and verify that the subtable entry
> + * is located within the table
> + *
> + * Return: acpi_subtable_header* or NULL
> + */
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

Apart from the above I'm not entirely sure why you need the changes in
patch [09/13] to go in a separate patch.  All of them are new code
going into the file created by this patch, so why not to put them
here?
