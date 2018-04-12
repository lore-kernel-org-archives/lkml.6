Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeDLPAA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 11:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752746AbeDLO76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:59:58 -0400
Subject: Re: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a
 struct page
To: KarimAllah Ahmed <karahmed@amazon.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        rkrcmar@redhat.com, tglx@linutronix.de
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cedf2ad3-43ef-c2ec-0455-4dc27842f71a@redhat.com>
Date: Thu, 12 Apr 2018 16:59:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2018 18:47, KarimAllah Ahmed wrote:
> For the most part, KVM can handle guest memory that does not have a struct
> page (i.e. not directly managed by the kernel). However, There are a few places
> in the code, specially in the nested code, that does not support that.
> 
> Patch 1, 2, and 3 avoid the mapping and unmapping all together and just
> directly use kvm_guest_read and kvm_guest_write.
> 
> Patch 4 introduces a new guest mapping interface that encapsulate all the
> bioler plate code that is needed to map and unmap guest memory. It also
> supports guest memory without "struct page".
> 
> Patch 5, 6, 7, 8, 9, and 10 switch most of the offending code in VMX and hyperv
> to use the new guest mapping API.
> 
> This patch series is the first set of fixes. Handling SVM and APIC-access page
> will be handled in a different patch series.

I like the patches and the new API.  However, I'm a bit less convinced
about the caching aspect; keeping a page pinned is not the nicest thing
with respect (for example) to memory hot-unplug.

Since you're basically reinventing kmap_high, or alternatively
(depending on your background) xc_map_foreign_pages, it's not surprising
that memremap is slow.  How slow is it really (as seen e.g. with
vmexit.flat running in L1, on EC2 compared to vanilla KVM)?

Perhaps you can keep some kind of per-CPU cache of the last N remapped
pfns?  This cache would sit between memremap and __kvm_map_gfn and it
would be completely transparent to the layer below since it takes raw
pfns.  This removes the need to store the memslots generation etc.  (If
you go this way please place it in virt/kvm/pfncache.[ch], since
kvm_main.c is already way too big).

Thanks,

Paolo

> KarimAllah Ahmed (10):
>   X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of
>     map->read->unmap sequence
>   X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
>     instead of map->copy->unmap sequence.
>   X86/nVMX: Update the PML table without mapping and unmapping the page
>   KVM: Introduce a new guest mapping API
>   KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
>   KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
>   KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
>     descriptor table
>   KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
>   KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
> 
>  arch/x86/kvm/hyperv.c    |  28 ++++-----
>  arch/x86/kvm/vmx.c       | 144 +++++++++++++++--------------------------------
>  arch/x86/kvm/x86.c       |  13 ++---
>  include/linux/kvm_host.h |  15 +++++
>  virt/kvm/kvm_main.c      |  50 ++++++++++++++++
>  5 files changed, 129 insertions(+), 121 deletions(-)
> 
