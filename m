Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZrlcbLVFyWXRmb/KB1ZZj/mrC1ZFExE939QvMtCJ1Co9QOLnSwAO3qM5UJvPtsA0ilapIjg
ARC-Seal: i=1; a=rsa-sha256; t=1524846047; cv=none;
        d=google.com; s=arc-20160816;
        b=jLm0E/4kKl3Fm4JHKqZXagzGfhpiyKKX+V7P62VftjpZuOs+GtzAfv3zEAzP5Ka7rb
         gX1Aa0ShNlpfqrKi7npQhVPpCbTsqNcK/2Kv+Xt7G14Gga70vRWrhkS3uogjfjxXFVUS
         aBjAl8KMYh0Y03zuldXKi0d1RHaQZLG+yWO44AInThnRnGuGLyL7757N82mFNblsn2bn
         42AUuH0cS53c8J+8cWVhhqJUb6eXjnMyZv+YhmYA3PhKdApnbr2tQLvq2jnqflTHdbUs
         6lx9zhi9BaAlUaU4GnaHL5iIyW2OaCL9I5I+NF9yenrM6xziOAr0hpJX2v+Z9JRZU/GV
         fSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=zq/zg8nXLxpaa4APYi2plD38R/n15Lgjh6ZRiyS9fLg=;
        b=D5KD4OQmWlgB5ogZT6FxMgFZU/K1nLM97LklhrMbrcczDVfP10FAJoc69g56pZhurA
         AXwb8j2hlZu51YPPhqp8fQwtigKX/NWLXj7ogXdozf6ANyqzVz38uh3tdR/mQQnIUqNh
         Zy7KlPVXyelEENXNfDS0Erk5aLLRuIVU2mRQzbzEvLprhrlqkea7QbiId9P8LRFuqofv
         gFXZqdl1JrVoNljTuEvhTG0t1xtJzB9MhfY611GTyLkmLBWIUSwFZdejhAn0uRAf55C8
         XFbI89ODu16YOP0OC/Sk7B86OmsmG0oYxeE+eshN3RLiJUhmWN2Bm4B5MnWVNdahi7FB
         Jh9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v8 05/13] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>, linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Will Deacon <Will.Deacon@arm.com>, Catalin Marinas
 <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <Mark.Rutland@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
 vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
 Dietmar Eggemann <Dietmar.Eggemann@arm.com>,
 Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
 Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>,
 austinwc@codeaurora.org, tnowicki@caviumnetworks.com,
 jhugo@qti.qualcomm.com, timur@qti.qualcomm.com,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
 <20180425233121.13270-6-jeremy.linton@arm.com>
 <CAJZ5v0jjPnyC0vm-Fb8y2hw1B9Uc2J5sZrtZYzt_ENT2Sini3A@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <b750e86b-bc51-0440-b48d-0e8d3177fa8d@arm.com>
Date: Fri, 27 Apr 2018 11:20:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0jjPnyC0vm-Fb8y2hw1B9Uc2J5sZrtZYzt_ENT2Sini3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766317939933372?=
X-GMAIL-MSGID: =?utf-8?q?1598916968483935160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Thanks for taking a look at this.

On 04/27/2018 06:02 AM, Rafael J. Wysocki wrote:
> On Thu, Apr 26, 2018 at 1:31 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
>> ACPI 6.2 adds a new table, which describes how processing units
>> are related to each other in tree like fashion. Caches are
>> also sprinkled throughout the tree and describe the properties
>> of the caches in relation to other caches and processing units.
>>
>> Add the code to parse the cache hierarchy and report the total
>> number of levels of cache for a given core using
>> acpi_find_last_cache_level() as well as fill out the individual
>> cores cache information with cache_setup_acpi() once the
>> cpu_cacheinfo structure has been populated by the arch specific
>> code.
>>
>> An additional patch later in the set adds the ability to report
>> peers in the topology using find_acpi_cpu_topology()
>> to report a unique ID for each processing unit at a given level
>> in the tree. These unique id's can then be used to match related
>> processing units which exist as threads, within a given
>> package, etc.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>   drivers/acpi/pptt.c | 518 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 518 insertions(+)
>>   create mode 100644 drivers/acpi/pptt.c
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> new file mode 100644
>> index 000000000000..cced71ef851a
>> --- /dev/null
>> +++ b/drivers/acpi/pptt.c
>> @@ -0,0 +1,518 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pptt.c - parsing of Processor Properties Topology Table
>> + *
>> + * Copyright (C) 2018, ARM
>> + *
>> + * This file implements parsing of Processor Properties Topology Table (PPTT)
>> + * which is optionally used to describe the processor and cache topology.
>> + * Due to the relative pointers used throughout the table, this doesn't
>> + * leverage the existing subtable parsing in the kernel.
>> + *
>> + * The PPTT structure is an inverted tree, with each node potentially
>> + * holding one or two inverted tree data structures describing
>> + * the caches available at that level. Each cache structure optionally
>> + * contains properties describing the cache at a given level which can be
>> + * used to override hardware probed values.
>> + */
>> +#define pr_fmt(fmt) "ACPI PPTT: " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cacheinfo.h>
>> +#include <acpi/processor.h>
>> +
>> +/**
>> + * fetch_pptt_subtable() - Find/Verify that the PPTT ref is a valid subtable
> 
> The parens above are at least redundant (if not harmful).  Everywhere
> else in a similar context too.

The kerneldoc ones? I guess i'm confused the kernel doc example in 
doc-guide/kernel-doc has

* function_name() - Brief description of function.


> 
> Also kerneldoc comments document function arguments too as a rule, so
> please do that here and wherever you use kerneldoc comments in the
> patchset.

Ok, sure.

> 
>> + *
>> + * Given the PPTT table, find and verify that the subtable entry
>> + * is located within the table
>> + *
>> + * Return: acpi_subtable_header* or NULL
>> + */
>> +static struct acpi_subtable_header *fetch_pptt_subtable(struct acpi_table_header *table_hdr,
>> +                                                       u32 pptt_ref)
>> +{
>> +       struct acpi_subtable_header *entry;
>> +
>> +       /* there isn't a subtable at reference 0 */
>> +       if (pptt_ref < sizeof(struct acpi_subtable_header))
>> +               return NULL;
>> +
>> +       if (pptt_ref + sizeof(struct acpi_subtable_header) > table_hdr->length)
>> +               return NULL;
>> +
>> +       entry = ACPI_ADD_PTR(struct acpi_subtable_header, table_hdr, pptt_ref);
>> +
>> +       if (entry->length == 0)
>> +               return NULL;
>> +
>> +       if (pptt_ref + entry->length > table_hdr->length)
>> +               return NULL;
>> +
>> +       return entry;
>> +}
> 
> Apart from the above I'm not entirely sure why you need the changes in
> patch [09/13] to go in a separate patch.  All of them are new code
> going into the file created by this patch, so why not to put them
> here?


Ok, I was doing that because Lorenzo asked for it, but he hasn't said 
much so I will collapse it back together. That makes me happy, as 
splitting chunks between patches is a pain anyway.
