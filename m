Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752205AbeBEBGk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 20:06:40 -0500
Received: from ozlabs.org ([103.22.144.67]:59917 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751916AbeBEBGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 20:06:32 -0500
Date: Mon, 5 Feb 2018 12:06:30 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM <kvm@vger.kernel.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Woodhouse <dwmw@amazon.co.uk>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: linux-next: manual merge of the kvm tree with Linus' tree
Message-ID: <20180205120630.4c924d00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the kvm tree got a conflict in:

  arch/x86/kvm/svm.c

between commit:

  15d45071523d ("KVM/x86: Add IBPB support")

from Linus' tree and commit:

  70cd94e60c73 ("KVM: SVM: VMRUN should use associated ASID when SEV is enabled")

from the kvm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/x86/kvm/svm.c
index 4e3c79530526,1bf20e9160bd..000000000000
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@@ -533,7 -573,9 +577,10 @@@ struct svm_cpu_data 
  	struct kvm_ldttss_desc *tss_desc;
  
  	struct page *save_area;
 +	struct vmcb *current_vmcb;
+ 
+ 	/* index = sev_asid, value = vmcb pointer */
+ 	struct vmcb **sev_vmcbs;
  };
  
  static DEFINE_PER_CPU(struct svm_cpu_data *, svm_data);
