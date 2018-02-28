Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AG47ELtHQoX9l97pQvPZ7LnnlJ8j7HRPRTrJFUK/G20QlnsvxuPmOmz58Q93tvSaLJeHy3eaQvEV
ARC-Seal: i=1; a=rsa-sha256; t=1519852442; cv=none;
        d=google.com; s=arc-20160816;
        b=wzRfI8wyXQrofTAE2pyxIO6fTU+YYR+EFNgPok1/aUSXobhUzqBHhycTPTyuv+yfb0
         ifLNCwlMykNjWUw6qJF/cZ2nall8FpnFnQ1z5HKRxby7GViEBdlWW4SA4Wnm9YzLhqW6
         UO7CNqFXQge7xxlzSNcdWPBmnSTUJs/WNQnh6nvHedy1KjZKFx6LLVvIQvom9Zn1NnjE
         InghD9JVwQUGXSfJ2Yi53FNeQTRac995EO1lE/B4+gYUEiZD1w1Al0RzW/gLDsG1Zlts
         kP6ur9ldey9zgeLtGe+/KGd1HWDHMsdBISw1VVsCGTpRTkbwJfA/u6+S8kVxKcPQOEvO
         GRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=wvDD1PXe+Icvn8ECu3gSfD/p/X88Rkmt9GXamBYlThI=;
        b=dVHBmEGsXC16+dMqdkbk7XTdZr4VBt1D6MopfaCnZfEi+DwJOH7cRe/TdVEOSJLYcL
         iXC2f0p/46QZ7oUy7JkvzMl+jVyeWf4AwunCf8EG/m7AJhwqNUMeuDTvlDIG6yP6FApw
         eep7LxsBW8DWj36OJG9M1T8S6zAC0qqtwUyEqhkUNJmTLAEEnrWlg43rECiHtovnEBws
         7GEHXF6EG1ljdCJpV9ajAwQ0bwR2M8rzjDRMX1zXHXzf3EYL3UCHyTZtG+U2XBdpOo1K
         ygyqBr4rxWL+F3XST4/Mud75eIGxQfy5MWbTmA3Yo4A4KGS/dVw/ArztqoPGkeQ+OcQM
         rOVg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=E16lkVmo;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=E16lkVmo;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 28 Feb 2018 16:08:14 -0500
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
Subject: Re: [Xen-devel] [RFC PATCH v4 2/7] xen/pvh: Move PVH entry code out
 of Xen specific tree
Message-ID: <20180228210814.GK11576@char.us.oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519842483-8887-3-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280257
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670476619272001?=
X-GMAIL-MSGID: =?utf-8?q?1593680793885758807?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:27:58AM -0800, Maran Wilson wrote:
> Once hypervisors other than Xen start using the PVH entry point for
> starting VMs, we would like the option of being able to compile PVH entry
> capable kernels without enabling CONFIG_XEN and all the code that comes
> along with that. To allow that, we are moving the PVH code out of Xen and
> into files sitting at a higher level in the tree.
> 
> This patch is not introducing any code or functional changes, just moving
> files from one location to another.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> ---
>  MAINTAINERS                             | 1 +
>  arch/x86/Kbuild                         | 3 +++
>  arch/x86/{xen/xen-pvh.S => pvh-head.S}  | 0
>  arch/x86/{xen/enlighten_pvh.c => pvh.c} | 0
>  arch/x86/xen/Makefile                   | 2 --
>  5 files changed, 4 insertions(+), 2 deletions(-)
>  rename arch/x86/{xen/xen-pvh.S => pvh-head.S} (100%)
>  rename arch/x86/{xen/enlighten_pvh.c => pvh.c} (100%)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93a12af4f180..dc89f3a279bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15210,6 +15210,7 @@ L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
>  S:	Supported
>  F:	arch/x86/xen/
> +F:	arch/x86/*pvh*
>  F:	drivers/*/xen-*front.c
>  F:	drivers/xen/
>  F:	arch/x86/include/asm/xen/
> diff --git a/arch/x86/Kbuild b/arch/x86/Kbuild
> index 0038a2d10a7a..a4e5e3d348dc 100644
> --- a/arch/x86/Kbuild
> +++ b/arch/x86/Kbuild
> @@ -7,6 +7,9 @@ obj-$(CONFIG_KVM) += kvm/
>  # Xen paravirtualization support
>  obj-$(CONFIG_XEN) += xen/
>  
> +obj-$(CONFIG_XEN_PVH) += pvh.o
> +obj-$(CONFIG_XEN_PVH) += pvh-head.o
> +
>  # Hyper-V paravirtualization support
>  obj-$(subst m,y,$(CONFIG_HYPERV)) += hyperv/
>  
> diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/pvh-head.S
> similarity index 100%
> rename from arch/x86/xen/xen-pvh.S
> rename to arch/x86/pvh-head.S
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/pvh.c
> similarity index 100%
> rename from arch/x86/xen/enlighten_pvh.c
> rename to arch/x86/pvh.c
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index d83cb5478f54..7e8145b33997 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -21,7 +21,6 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
>  obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
>  obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
>  						p2m.o enlighten_pv.o mmu_pv.o
> -obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
>  
>  obj-$(CONFIG_EVENT_TRACING) += trace.o
>  
> @@ -33,4 +32,3 @@ obj-$(CONFIG_XEN_DEBUG_FS)	+= debugfs.o
>  obj-$(CONFIG_XEN_DOM0)		+= vga.o
>  obj-$(CONFIG_SWIOTLB_XEN)	+= pci-swiotlb-xen.o
>  obj-$(CONFIG_XEN_EFI)		+= efi.o
> -obj-$(CONFIG_XEN_PVH)	 	+= xen-pvh.o
> -- 
> 2.16.1
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
