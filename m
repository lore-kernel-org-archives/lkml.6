Return-Path: <konrad.wilk@oracle.com>
X-Google-Smtp-Source: AG47ELsg0H+FS58mxSSrrIVwjKJ9+z3DUQC36khF1qeGa23WQqOE41olqlfoMXxtRbiMYpCRAK4o
ARC-Seal: i=1; a=rsa-sha256; t=1519852339; cv=none;
        d=google.com; s=arc-20160816;
        b=E26/OHU6x33E9ONu6itOgTEGVp2hGkzib69BdmrRrtqsympjZLiQ09HcsBxgd0jcYG
         UnpHI0uuEMV0x1YbSaEreR8BRmXvCVKwPErKOHtJNXnDi7jxTVYVRf+WMGN1e3EbJLX/
         3R7oxwKi+Im9qr9YC7DorrX65LkrVDWeZQiqrB17NB4NSstM38PjwhUaXPqIYJWfwWV2
         tDCfcbdVZThoreH5VWgOSVU63i5Vu0QQn2vi7Yi8XUPb+cDXLXYnnjdzu+diMqqqYOz7
         fvdguKs3v7hpWEUZWzhrKYbrLdEpjVVnVDfbigoJ2+Qhlax42b5J0/AGPEaQBo6KcLRp
         wFKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KOfMGJ3LGy6kKia9W4LE/PIdVJ5AooObxxosqBLuTTk=;
        b=RqCQD+ra64EOyDT5LX1y0HVzmETTMztruMTYA1Arao0FUTZ+RDIzezQ0cncdUpJJM3
         vVfDle/wJh/Cb1QL1TSSsDcjSa/GcgJyMZMNbWimEJ6I047KTYWavsiB3h5IGGJHiZrX
         l26rPMrZ4Zkec+6YJTuNqV9K5BShOyEy5dwOhDEfq5ktOpT2iC6LmJfYbuEfQjwY5cEb
         YyJ1zsrTGTj1EXpgVPeYNxCbzHlnJQJUDm5BoNqO/bkjUofr/FpL1ktwjKUkWJYp0C2U
         pkChnPXtPuTxE1yMdD4SwIXXB7CIn9O6W2WBho/Nyh3wwFY30xLzl7UGpsZ4ZJjFI0bR
         pjaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P8OAcYkj;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=P8OAcYkj;
       spf=pass (google.com: domain of konrad.wilk@oracle.com designates 156.151.31.85 as permitted sender) smtp.mailfrom=konrad.wilk@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 28 Feb 2018 16:09:37 -0500
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
Subject: Re: [Xen-devel] [RFC PATCH v4 3/7] xen/pvh: Create a new file for
 Xen specific PVH code
Message-ID: <20180228210937.GL11576@char.us.oracle.com>
References: <1519842483-8887-1-git-send-email-maran.wilson@oracle.com>
 <1519842483-8887-4-git-send-email-maran.wilson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519842483-8887-4-git-send-email-maran.wilson@oracle.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8818 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802280256
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593670431890911197?=
X-GMAIL-MSGID: =?utf-8?q?1593680687036570009?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:27:59AM -0800, Maran Wilson wrote:
> We need to refactor PVH entry code so that support for other hypervisors
> like Qemu/KVM can be added more easily.
> 
> The first step in that direction is to create a new file that will
> eventually hold the Xen specific routines.
> 
> Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
> ---
>  arch/x86/pvh.c               |  1 -
>  arch/x86/xen/Makefile        |  1 +
>  arch/x86/xen/enlighten_pvh.c | 11 +++++++++++
>  3 files changed, 12 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/xen/enlighten_pvh.c
> 
> diff --git a/arch/x86/pvh.c b/arch/x86/pvh.c
> index 436c4f003e17..b56cb5e7d6ac 100644
> --- a/arch/x86/pvh.c
> +++ b/arch/x86/pvh.c
> @@ -19,7 +19,6 @@
>   * xen_pvh and pvh_bootparams need to live in data segment since they

Perhaps remove 'xen_pvh' from there..
>   * are used after startup_{32|64}, which clear .bss, are invoked.
>   */
> -bool xen_pvh __attribute__((section(".data"))) = 0;
>  struct boot_params pvh_bootparams __attribute__((section(".data")));
>  
>  struct hvm_start_info pvh_start_info;
> diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
> index 7e8145b33997..ef6481a83768 100644
> --- a/arch/x86/xen/Makefile
> +++ b/arch/x86/xen/Makefile
> @@ -21,6 +21,7 @@ obj-y		:= enlighten.o multicalls.o mmu.o irq.o \
>  obj-$(CONFIG_XEN_PVHVM)		+= enlighten_hvm.o mmu_hvm.o suspend_hvm.o
>  obj-$(CONFIG_XEN_PV)			+= setup.o apic.o pmu.o suspend_pv.o \
>  						p2m.o enlighten_pv.o mmu_pv.o
> +obj-$(CONFIG_XEN_PVH)			+= enlighten_pvh.o
>  
>  obj-$(CONFIG_EVENT_TRACING) += trace.o
>  
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> new file mode 100644
> index 000000000000..4b4e9cc78b8a
> --- /dev/null
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -0,0 +1,11 @@
> +#include <linux/types.h>
> +
> +/*
> + * PVH variables.
> + *
> + * The variables xen_pvh and pvh_bootparams need to live in the data segment

And remove 'and pvh_bootparams' here as well?

> + * since they are used after startup_{32|64} is invoked, which will clear the
> + * .bss segment.
> + */
> +bool xen_pvh __attribute__((section(".data"))) = 0;
> +
> -- 
> 2.16.1
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel
