Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934669AbeCHCQY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:16:24 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32933 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:16:23 -0500
X-Google-Smtp-Source: AG47ELtRz5QXm+zdAJV3PXuevLvyEOGgs/98t59SxBfL1UPjjedZOSS7MlmxK7iSH7bWicWIxaDvzQ==
Subject: Re: [PATCH v4 0/4] x86/devicetree: Re-enable x86-specific
 implementation
To: Ivan Gorinov <ivan.gorinov@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.1520450752.git.ivan.gorinov@intel.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <c744b8a1-a5c1-e267-6b71-fcef4a675d31@gmail.com>
Date: Wed, 7 Mar 2018 18:16:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cover.1520450752.git.ivan.gorinov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Frank

Please include me on future versions.


On 03/07/18 11:45, Ivan Gorinov wrote:
> Fixing x86-specific DT implementation in the kernel allows reusing most of
> firmware code for SoC that have ARM core replaced with x86, e.g. SC9853i.
> 
> Changes since v3:
> 
>  * Using fdt_totalsize() to get DTB size before remapping
>    instead of setting initial_boot_params and calling
>    of_get_flat_dt_size() before early_init_dt_verify();
> 
>  * Adding new intel,apic-id property to the documentation.
> 
> Changes since v2:
> 
>  * WARN_ON_ONCE instead of WARN_ON to aviod multiple warnings
>    when APIC ID is missing in CPU device tree nodes
> 
>  * Switched to Mutt because of white space issues:
>    "Preformatted" paragraph style does not work in Evolution 3.18.5.2
> 
> Changes since first version:
> 
>  * Splitting a single patch into three parts
> 
> Ivan Gorinov (4):
>   x86/devicetree: Initialize device tree before using it
>   x86/devicetree: Fix device IRQ settings in DT
>   of: Documentation: Add x86 local APIC ID property
>   x86/devicetree: Enable multiprocessing in DT
> 
>  Documentation/devicetree/bindings/x86/ce4100.txt |  6 +++
>  arch/x86/kernel/devicetree.c                     | 48 +++++++++++++++++++-----
>  2 files changed, 44 insertions(+), 10 deletions(-)
> 
