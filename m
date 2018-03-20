Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751541AbeCTTYM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 15:24:12 -0400
Received: from merlin.infradead.org ([205.233.59.134]:39444 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbeCTTYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 15:24:10 -0400
Subject: Re: [PATCH v5 1/7] xen/pvh: Split CONFIG_XEN_PVH into CONFIG_PVH and
 CONFIG_XEN_PVH
To: Maran Wilson <maran.wilson@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        kvm@vger.kernel.org, pbonzini@redhat.com, jgross@suse.com
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        boris.ostrovsky@oracle.com, jpoimboe@redhat.com,
        kirill.shutemov@linux.intel.com, bp@suse.de, thomas.lendacky@amd.com,
        luto@kernel.org, dave.hansen@linux.intel.com, roger.pau@citrix.com,
        rkrcmar@redhat.com
References: <1521573369-17216-1-git-send-email-maran.wilson@oracle.com>
 <1521573486-17304-1-git-send-email-maran.wilson@oracle.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cb065150-0035-abf0-1d38-99011e4b4605@infradead.org>
Date: Tue, 20 Mar 2018 12:23:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521573486-17304-1-git-send-email-maran.wilson@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/20/2018 12:18 PM, Maran Wilson wrote:
> In order to pave the way for hypervisors other then Xen to use the PVH

                                                 than

> entry point for VMs, we need to factor the PVH entry code into Xen specific
> and hypervisor agnostic components. The first step in doing that, is to
> create a new config option for PVH entry that can be enabled
> independently from CONFIG_XEN.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> ---
>  arch/x86/Kconfig          | 7 +++++++
>  arch/x86/kernel/head_64.S | 4 ++--
>  arch/x86/xen/Kconfig      | 3 ++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..58831320b5d2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -791,6 +791,13 @@ config KVM_GUEST
>  	  underlying device model, the host provides the guest with
>  	  timing infrastructure such as time of day, and system time
>  
> +config PVH
> +	bool "Support for running PVH guests"
> +	def_bool n

You don't need two (2) "bool"s here. And 'n' is already the default, so just
drop the second line.

> +	---help---
> +	  This option enables the PVH entry point for guest virtual machines
> +	  as specified in the x86/HVM direct boot ABI.
> +
>  config KVM_DEBUG_FS
>  	bool "Enable debug information for KVM Guests in debugfs"
>  	depends on KVM_GUEST && DEBUG_FS


-- 
~Randy
