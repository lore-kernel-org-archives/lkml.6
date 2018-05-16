Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752059AbeEPHIU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 03:08:20 -0400
Received: from ozlabs.org ([203.11.71.1]:60205 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeEPHIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 03:08:19 -0400
Date: Wed, 16 May 2018 17:08:14 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: Souptick Joarder <jrdr.linux@gmail.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au,
        Matthew Wilcox <willy@infradead.org>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] powerpc: kvm: Change return type to vm_fault_t
Message-ID: <20180516070814.GA20588@fergus.ozlabs.ibm.com>
References: <20180510182719.GA22217@jordon-HP-15-Notebook-PC>
 <CAFqt6zbxWkOQXtKZXyDae=ZEQR+d0xf42fvnvUoBSHQZcHRCBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbxWkOQXtKZXyDae=ZEQR+d0xf42fvnvUoBSHQZcHRCBg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 10:11:11AM +0530, Souptick Joarder wrote:
> On Thu, May 10, 2018 at 11:57 PM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > Use new return type vm_fault_t for fault handler
> > in struct vm_operations_struct. For now, this is
> > just documenting that the function returns a
> > VM_FAULT value rather than an errno.  Once all
> > instances are converted, vm_fault_t will become
> > a distinct type.
> >
> > commit 1c8f422059ae ("mm: change return type to
> > vm_fault_t")
> >
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> > v2: Updated the change log
> >
> >  arch/powerpc/kvm/book3s_64_vio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> > index 4dffa61..346ac0d 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio.c
> > @@ -237,7 +237,7 @@ static void release_spapr_tce_table(struct rcu_head *head)
> >         kfree(stt);
> >  }
> >
> > -static int kvm_spapr_tce_fault(struct vm_fault *vmf)
> > +static vm_fault_t kvm_spapr_tce_fault(struct vm_fault *vmf)
> >  {
> >         struct kvmppc_spapr_tce_table *stt = vmf->vma->vm_file->private_data;
> >         struct page *page;
> > --
> > 1.9.1
> >
> 
> If no comment, we would like to get this patch in queue
> for 4.18.

It looks fine - I'll queue it up.

Paul.
