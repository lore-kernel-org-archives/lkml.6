Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZqLfMyED8Vd32loJoi0pHkD9Yr7vcn15kMK04qqtk/Vbtlyxn1HVsD0P1626BQzMab+kfQM
ARC-Seal: i=1; a=rsa-sha256; t=1526420555; cv=none;
        d=google.com; s=arc-20160816;
        b=Mp834z2NvFd0364WhdEAX+r+VxM7BW2hm4ss9Sg/q2GYVwJGtMdt2IhbGnldPaHY4v
         Ivy3TTqT1U3E3JUsUL3tCIXbz1DmP3Puwz3aVEKPGLORq7AZUNFhRJMeOpzaqeWkzNVy
         8bkplUMH/c7bsjwQO9O4FqRcWdpfTYtsrUwqoGxYX01vFdvhE11mZtGdKZtp1Bw81UCz
         iOxWiw8C8m1SvLtpbtyM2UZ1VgcQ99BH1AwLlxoYES7tQ0ykHhnfpKnE6QW8FLqBPQ2d
         te5PGEk+z+rUCeoWRO8Kl6u2jGKhvp5Oob8UWdAkLw1K1bwcwF91MM1WizEDU6yiC24e
         Yulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=hDuqQZo8qM5XihaCgOPxsRndDu0eAzVsFoqDt1++Dt0=;
        b=vxX3/CRtvLyImE3zuyJxUekZQvitqsm8WJNhQm9N3h9xcGb4eCNpO1VInxYan5rrcK
         FUiJJnMUD7eRAlDd8OFqUq052d93lX/eSpj26V1rXmuVs66fPEpq5do1k09DtCfN7jPy
         dQOXDSU5PllHqpE+Fr4glTCKrqu9uZ/oVpnSTN5O/8fkjPaFlr4soi5fHrjDOVuLxI7y
         SGTAZQrhmGtPFZfDcaU7pJwc+JFYsk9mPGr/2jiOMvaH3ugRWeHgOPy5XWTdUoS1ATKZ
         yJ0ciSMgL8er61reRiKuZfzKwPo8LQyqx92k6lbYl6u4jd2BfaKBAi9LcSAtkDaV7CyT
         993Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Subject: Re: [PATCH v9 05/12] ACPI/PPTT: Add Processor Properties Topology
 Table parsing
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
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
 austinwc@codeaurora.org, tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-6-jeremy.linton@arm.com>
 <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com>
From: Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <7cefb087-f41a-0a73-ef77-b560d338be4b@arm.com>
Date: Tue, 15 May 2018 16:42:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0h4OeTaG2h0Q1c8zX93tici_nfLftpEyKWSkXoztHuUDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214162685472859?=
X-GMAIL-MSGID: =?utf-8?q?1600567960094487981?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 05/12/2018 05:09 AM, Rafael J. Wysocki wrote:
> On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
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
>> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
>> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
>> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
>> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> ---
>>   drivers/acpi/pptt.c  | 655 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   include/linux/acpi.h |   4 +
>>   2 files changed, 659 insertions(+)
>>   create mode 100644 drivers/acpi/pptt.c
>>
>> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
>> new file mode 100644
>> index 000000000000..e5ea1974d1e3
>> --- /dev/null
>> +++ b/drivers/acpi/pptt.c
>> @@ -0,0 +1,655 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * pptt.c - parsing of Processor Properties Topology Table (PPTT)
>> + *
>> + * Copyright (C) 2018, ARM
>> + *
>> + * This file implements parsing of the Processor Properties Topology Table
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
>> +
>> +static struct acpi_pptt_processor *fetch_pptt_node(struct acpi_table_header *table_hdr,
>> +                                                  u32 pptt_ref)
>> +{
>> +       return (struct acpi_pptt_processor *)fetch_pptt_subtable(table_hdr, pptt_ref);
>> +}
>> +
>> +static struct acpi_pptt_cache *fetch_pptt_cache(struct acpi_table_header *table_hdr,
>> +                                               u32 pptt_ref)
>> +{
>> +       return (struct acpi_pptt_cache *)fetch_pptt_subtable(table_hdr, pptt_ref);
> 
> I don't think you really need the explicit type cast here and above,
> but that's very minor.
> 
>> +}
> 
> Please feel free to add
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch and route it through the arch tree as needed.

Thanks for looking at this (and the ack of course)!

As an FYI, the in my build without the type cast, the 
-Werror=incompatible-pointer-types (sourced from the root Makefile) 
triggers an error.



thanks again.
