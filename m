Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeBSNnn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:43:43 -0500
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43245 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752772AbeBSNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:43:41 -0500
X-Google-Smtp-Source: AH8x225Qo6UK8iq4IzAdJD1qHrDvdDKDr2Bt/GXb4i7JO6hQGemUdd0DIQy8lYJEGZ4rBkolGaYe3/7wf03eFEatF8s=
MIME-Version: 1.0
In-Reply-To: <209b38ec-aab4-ea5f-70a2-3f9bdb1f52a1@intel.com>
References: <20180219100906.14265-1-jgross@suse.com> <209b38ec-aab4-ea5f-70a2-3f9bdb1f52a1@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 19 Feb 2018 15:43:40 +0200
Message-ID: <CAHp75VfWRtTXQ02PuYG9xceEb8sQ0UhiixcW4nzxCV+cqW-6tQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] xen: re-enable booting as Xen PVH guest
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>, x86@kernel.org,
        Len Brown <lenb@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 12:27 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 2/19/2018 11:09 AM, Juergen Gross wrote:
>>
>> The Xen PVH boot protocol passes vital information to the kernel via
>> a start_info block. One of the data transferred is the physical address
>> of the RSDP table.
>>
>> Unfortunately PVH support in the kernel didn't use that passed address
>> for RSDP, but relied on the legacy mechanism searching for the RSDP in
>> low memory. After a recent change in Xen putting the RSDP to a higher
>> address booting as PVH guest is now failing.
>>
>> This small series repairs that by passing the RSDP address from the
>> start_info block to ACPI handling.
>>
>> Changes in V3:
>> - instead of using a weak function add a function pointer to x86_init
>>    for obtaining the RSDP address
>>
>> Juergen Gross (3):
>>    acpi: introduce acpi_arch_get_root_pointer() for getting rsdp address
>>    x86/acpi: add a new x86_init_acpi structure to x86_init_ops
>>    x86/xen: add pvh specific rsdp address retrieval function
>>
>>   arch/x86/include/asm/acpi.h     |  7 +++++++
>>   arch/x86/include/asm/x86_init.h |  9 +++++++++
>>   arch/x86/kernel/x86_init.c      |  5 +++++
>>   arch/x86/xen/enlighten_pvh.c    | 14 +++++++++++---
>>   drivers/acpi/osl.c              |  5 ++++-
>>   include/linux/acpi.h            |  7 +++++++
>>   6 files changed, 43 insertions(+), 4 deletions(-)
>>
> The series is fine by me:
>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Don't know much about Xen, though the ACPI / x86 stubs are exactly
what I'm wanting!
Thanks.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
