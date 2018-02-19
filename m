Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeBSK1U (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:27:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:13279 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752309AbeBSK1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:27:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="176413070"
Subject: Re: [PATCH v3 0/3] xen: re-enable booting as Xen PVH guest
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org,
        x86@kernel.org
Cc: lenb@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com
References: <20180219100906.14265-1-jgross@suse.com>
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Organization: Intel Technology Poland Sp. z o. o., KRS 101882, ul. Slowackiego
 173, 80-298 Gdansk
Message-ID: <209b38ec-aab4-ea5f-70a2-3f9bdb1f52a1@intel.com>
Date: Mon, 19 Feb 2018 11:27:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180219100906.14265-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/2018 11:09 AM, Juergen Gross wrote:
> The Xen PVH boot protocol passes vital information to the kernel via
> a start_info block. One of the data transferred is the physical address
> of the RSDP table.
>
> Unfortunately PVH support in the kernel didn't use that passed address
> for RSDP, but relied on the legacy mechanism searching for the RSDP in
> low memory. After a recent change in Xen putting the RSDP to a higher
> address booting as PVH guest is now failing.
>
> This small series repairs that by passing the RSDP address from the
> start_info block to ACPI handling.
>
> Changes in V3:
> - instead of using a weak function add a function pointer to x86_init
>    for obtaining the RSDP address
>
> Juergen Gross (3):
>    acpi: introduce acpi_arch_get_root_pointer() for getting rsdp address
>    x86/acpi: add a new x86_init_acpi structure to x86_init_ops
>    x86/xen: add pvh specific rsdp address retrieval function
>
>   arch/x86/include/asm/acpi.h     |  7 +++++++
>   arch/x86/include/asm/x86_init.h |  9 +++++++++
>   arch/x86/kernel/x86_init.c      |  5 +++++
>   arch/x86/xen/enlighten_pvh.c    | 14 +++++++++++---
>   drivers/acpi/osl.c              |  5 ++++-
>   include/linux/acpi.h            |  7 +++++++
>   6 files changed, 43 insertions(+), 4 deletions(-)
>
The series is fine by me:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
