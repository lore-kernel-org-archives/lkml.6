Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ky3eMIZeHltcNAAAmS7hNA
	; Mon, 11 Jun 2018 11:35:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B661D607BB; Mon, 11 Jun 2018 11:35:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 010DC6074D;
	Mon, 11 Jun 2018 11:35:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 010DC6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932936AbeFKLfc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:35:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932765AbeFKLf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:35:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F992400225D;
        Mon, 11 Jun 2018 11:35:29 +0000 (UTC)
Received: from hmswarspite.think-freely.org (ovpn-121-28.rdu2.redhat.com [10.10.121.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D34D111AF1F;
        Mon, 11 Jun 2018 11:35:22 +0000 (UTC)
Date: Mon, 11 Jun 2018 07:35:21 -0400
From: Neil Horman <nhorman@redhat.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: x86@kernel.org, platform-driver-x86@vger.kernel.org,
        dave.hansen@intel.com, sean.j.christopherson@intel.com,
        npmccallum@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Vikas Shivappa <vikas.shivappa@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
Subject: Re: [PATCH v11 07/13] x86, sgx: detect Intel SGX
Message-ID: <20180611113521.GB22164@hmswarspite.think-freely.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608171216.26521-8-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 11 Jun 2018 11:35:29 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Mon, 11 Jun 2018 11:35:29 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'nhorman@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 07:09:42PM +0200, Jarkko Sakkinen wrote:
> From: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> Intel(R) SGX is a set of CPU instructions that can be used by applications
> to set aside private regions of code and data. The code outside the enclave
> is disallowed to access the memory inside the enclave by the CPU access
> control.
> 
> This commit adds the check for SGX to arch/x86 and a new config option,
> INTEL_SGX_CORE. Exposes a boolean variable 'sgx_enabled' to query whether
> or not the SGX support is available.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  arch/x86/Kconfig                | 19 ++++++++++++
>  arch/x86/include/asm/sgx.h      | 25 ++++++++++++++++
>  arch/x86/include/asm/sgx_pr.h   | 20 +++++++++++++
>  arch/x86/kernel/cpu/Makefile    |  1 +
>  arch/x86/kernel/cpu/intel_sgx.c | 53 +++++++++++++++++++++++++++++++++
>  5 files changed, 118 insertions(+)
>  create mode 100644 arch/x86/include/asm/sgx.h
>  create mode 100644 arch/x86/include/asm/sgx_pr.h
>  create mode 100644 arch/x86/kernel/cpu/intel_sgx.c
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c07f492b871a..42015d5366ef 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1925,6 +1925,25 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
>  
>  	  If unsure, say y.
>  
> +config INTEL_SGX_CORE
> +	prompt "Intel SGX core functionality"
> +	def_bool n
> +	depends on X86_64 && CPU_SUP_INTEL
> +	help
> +	Intel Software Guard eXtensions (SGX) is a set of CPU instructions
> +	that allows ring 3 applications to create enclaves; private regions
> +	of memory that are protected, by hardware, from unauthorized access
> +	and/or modification.
> +
> +	This option enables kernel recognition of SGX, high-level management
> +	of the Enclave Page Cache (EPC), tracking and writing of SGX Launch
> +	Enclave Hash MSRs, and allows for virtualization of SGX via KVM. By
> +	iteslf, this option does not provide SGX support to userspace.
> +
> +	For details, see Documentation/x86/intel_sgx.rst
> +
> +	If unsure, say N.
> +
>  config EFI
>  	bool "EFI runtime service support"
>  	depends on ACPI
> diff --git a/arch/x86/include/asm/sgx.h b/arch/x86/include/asm/sgx.h
> new file mode 100644
> index 000000000000..fa3e6e0eb8af
> --- /dev/null
> +++ b/arch/x86/include/asm/sgx.h
> @@ -0,0 +1,25 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +// Copyright(c) 2016-18 Intel Corporation.
> +//
> +// Authors:
> +//
> +// Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> +// Suresh Siddha <suresh.b.siddha@intel.com>
> +// Sean Christopherson <sean.j.christopherson@intel.com>
> +
> +#ifndef _ASM_X86_SGX_H
> +#define _ASM_X86_SGX_H
> +
> +#include <linux/types.h>
> +
> +#define SGX_CPUID 0x12
> +
Agree with Dave, this can just be remoed and you can use the feature macro from
cpuid.h instead

Neil
