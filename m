Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AG47ELtMek03RLOHcOuWRVT18M9JsaiLM1u8TcU8bJ2SwV+nkLbi2iSdBD+aZAgo6FrmTuxGveUN
ARC-Seal: i=1; a=rsa-sha256; t=1519852452; cv=none;
        d=google.com; s=arc-20160816;
        b=Dghot4e1itMnMk7gR2xxKg264phVkhDzcgcULaoGNKEEHajqHo+4o7zU3vYSmW3l2S
         eRA7wF2FlPksfP36W/pqudOBwSvKfBi0dsxO3e1l+y1b1KUPUk1JWGtLCKaZVuMA3CbS
         RmjdR/sr4BDLLFftsWVwGC/NQE5dP2nHK3bw5GpZb1lAw+0HYUwKDm87FBdmRme+dS+u
         Nc4hrOUbuc+3aBcHBaOHz0DRROdHvtW9jSQsVvnGXXHB0W2k5ptqxOEXG4u+HJWzJpGQ
         JRG4b1/amNi72OQq/voNT19/lEvr8rp+DOjlC4TlVFGEb5piozgdsJ6Z7VYPFG8IFf7j
         fFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=GiZ1PXhkub+3g2eF13X9X8PXPKQlggkdadreOtU3vSw=;
        b=sAJ6BFNu33c2CvWiWhvm/UL07QDDLxnaSbfU7zRS0IgqE/dN4UWIq/qJb/FIwwQ0l9
         1nhDsWxvzc86PKnd52lkGtEv4R1cQEIs/OEhcG/HH8q9nR2KjraMe3rQ18/WtX10QVL/
         5BC8NDGaTDhHM4MRTRvkoYh8/eokA1GHr2Hw6+RVh3d9eZ/oqgDTrh/G6wN8uJXe0Efi
         1PYRsGhJNUSeC+LKT+J+Ammn45zsjGf2htYpPWvFm88TVZTwlmkKoNiMxA17rpvqGMZF
         su1iqTvxOpe4HsKlR3GJgXICTW35f0YOZcJBV1DAHRC9nHJ8Xkhf2PzPdlQ84XDnDhku
         Ye7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XrgLDNEn;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=XrgLDNEn;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 28 Feb 2018 16:07:34 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Maran Wilson <maran.wilson@oracle.com>
Cc: pbonzini@redhat.com, jgross@suse.com, boris.ostrovsky@oracle.com,
        roger.pau@citrix.com, andrew.cooper3@citrix.com, hch@infradead.org,
        JBeulich@suse.com, x86@kernel.org, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        thomas.lendacky@amd.com, dave.hansen@linux.intel.com,
        rkrcmar@redhat.com, gregkh@linuxfoundation.org, mchehab@kernel.org,
        hpa@zytor.com, linus.walleij@linaro.org, mingo@redhat.com,
        rdunlap@infradead.org, luto@kernel.org, jpoimboe@redhat.com,
        tglx@linutronix.de, bp@suse.de, davem@davemloft.net,
        kirill.shutemov@linux.intel.com
Subject: Re: [Xen-devel] [RFC PATCH v4 1/7] xen/pvh: Split CONFIG_XEN_PVH
 into CONFIG_PVH and CONFIG_XEN_PVH
Message-ID: <20180228210734.GJ11576@char.us.oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519842483-8887-2-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280257
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670432609567761?=
X-GMAIL-MSGID: =?utf-8?q?1593680805259340876?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:27:57AM -0800, Maran Wilson wrote:
> In order to pave the way for hypervisors other then Xen to use the PVH
> entry point for VMs, we need to factor the PVH entry code into Xen specific
> and hypervisor agnostic components. The first step in doing that, is to
> create a new config option for PVH entry that can be enabled
> independently from CONFIG_XEN.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> ---
>  arch/x86/Kconfig          | 8 ++++++++
>  arch/x86/kernel/head_64.S | 4 ++--
>  arch/x86/xen/Kconfig      | 3 ++-
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index eb7f43f23521..fa7cd0305125 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -791,6 +791,14 @@ config KVM_GUEST
>  	  underlying device model, the host provides the guest with
>  	  timing infrastructure such as time of day, and system time
>  
> +config PVH
> +	bool "Support for running PVH guests"
> +	depends on KVM_GUEST || XEN
> +	def_bool n
> +	---help---
> +	  This option enables the PVH entry point for guest virtual machines
> +	  as specified in the x86/HVM direct boot ABI.
> +
>  config KVM_DEBUG_FS
>  	bool "Enable debug information for KVM Guests in debugfs"
>  	depends on KVM_GUEST && DEBUG_FS
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 0f545b3cf926..fc9f678c6413 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -41,7 +41,7 @@
>  
>  #define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
>  
> -#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
> +#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
>  PGD_PAGE_OFFSET = pgd_index(__PAGE_OFFSET_BASE)
>  PGD_START_KERNEL = pgd_index(__START_KERNEL_map)
>  #endif
> @@ -387,7 +387,7 @@ NEXT_PAGE(early_dynamic_pgts)
>  
>  	.data
>  
> -#if defined(CONFIG_XEN_PV) || defined(CONFIG_XEN_PVH)
> +#if defined(CONFIG_XEN_PV) || defined(CONFIG_PVH)
>  NEXT_PGD_PAGE(init_top_pgt)
>  	.quad   level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
>  	.org    init_top_pgt + PGD_PAGE_OFFSET*8, 0
> diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
> index f605825a04ab..021c8591c3c0 100644
> --- a/arch/x86/xen/Kconfig
> +++ b/arch/x86/xen/Kconfig
> @@ -77,8 +77,9 @@ config XEN_DEBUG_FS
>  	  Enabling this option may incur a significant performance overhead.
>  
>  config XEN_PVH
> -	bool "Support for running as a PVH guest"
> +	bool "Support for running as a Xen PVH guest"
>  	depends on XEN && XEN_PVHVM && ACPI
>  	# Pre-built page tables are not ready to handle 5-level paging.
>  	depends on !X86_5LEVEL

Not specific to this patch, but why is this there? PVH is not using PV so
there should be no problems with 5 level paging.

Juergen, thoughts?

> +	select PVH
>  	def_bool n
> -- 
> 2.16.1
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
