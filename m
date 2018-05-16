Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeEPElP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:41:15 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38257 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeEPElN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:41:13 -0400
X-Google-Smtp-Source: AB8JxZpWO01542qHBHh7cvJKBohWGuZUkW83C4Ws5g+Fzc8oSJDR3q9El92I9aiVE5bO0S/t4c0zjH5A2o9McWNc8io=
MIME-Version: 1.0
In-Reply-To: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
References: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Wed, 16 May 2018 10:11:11 +0530
Message-ID: <CAFqt6zbxWkOQXtKZXyDae=ZEQR+d0xf42fvnvUoBSHQZcHRCBg@mail.gmail.com>
Subject: Re: [PATCH v2] powerpc: kvm: Change return type to vm_fault_t
To: paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
        Matthew Wilcox <willy@infradead.org>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 11:57 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> Use new return type vm_fault_t for fault handler
> in struct vm_operations_struct. For now, this is
> just documenting that the function returns a
> VM_FAULT value rather than an errno.  Once all
> instances are converted, vm_fault_t will become
> a distinct type.
>
> commit 1c8f422059ae ("mm: change return type to
> vm_fault_t")
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
> v2: Updated the change log
>
>  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index 4dffa61..346ac0d 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -237,7 +237,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
>         kfree(stt);
>  }
>
> -static int kvm_spapr_tce_fault(struct vm_fault *vmf)
> +static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
>  {
>         struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
>         struct page *page;
> --
> 1.9.1
>

If no comment, we would like to get this patch in queue
for 4.18.
