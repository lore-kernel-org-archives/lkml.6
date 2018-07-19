Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8D9ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8533B20693
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 08:57:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8533B20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbeGSJj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:39:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726640AbeGSJj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:39:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8C0ED406E968;
        Thu, 19 Jul 2018 08:57:46 +0000 (UTC)
Received: from [10.36.117.183] (ovpn-117-183.ams2.redhat.com [10.36.117.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B2FC52156897;
        Thu, 19 Jul 2018 08:57:43 +0000 (UTC)
Subject: Re: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
To:     Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <70536ba6-fe2e-04ae-7055-e1eef4e87c64@redhat.com>
Date:   Thu, 19 Jul 2018 10:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 08:57:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Thu, 19 Jul 2018 08:57:46 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2018 10:39, Tianyu Lan wrote:
> Hyper-V provides a para-virtualization hypercall HvFlushGuestPhysicalAddressSpace
> to flush nested VM address space mapping in l1 hypervisor and it's to reduce overhead
> of flushing ept tlb among vcpus. The tradition way is to send IPIs to all affected
> vcpus and executes INVEPT on each vcpus. It will trigger several vmexits for IPI and
> INVEPT emulation. The pv hypercall can help to flush specified ept table on all vcpus
> via one single hypercall.

Thanks, this looks good apart from a global replace of EFAULT with
ENOTSUP (which can be done when applying).  Can I have an explicit ack
for patches 1 and 2 from the Hyper-V people?

Thanks,

Paolo

> Change since v2:
>        - Make ept_pointers_match as tristate "check", "match" and "mismatch".
>        Set "check" in vmx_set_cr3(), check all ept table pointers in hv_remote_flush_tlb()
>        and call hypercall when all ept pointers are same.
>        - Rename kvm_arch_hv_flush_remote_tlb with kvm_arch_flush_remote_tlb and
>        Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops->tlb_remote_flush
>        - Fix issue that ignore updating tlbs_dirty during calling kvm_arch_flush_remote_tlbs()
>        - Merge patch "KVM/VMX: Add identical ept table pointer check" and
>        patch "KVM/x86: Add tlb_remote_flush callback support for vmx"
> 
> Change since v1:
>        - Fix compilation error for non-x86 platform.
>        - Use ept_pointers_match to check condition of identical ept
>             table pointer and get ept pointer from struct vcpu_vmx->ept_pointer.
>        - Add hyperv_nested_flush_guest_mapping ftrace support
> 		     
> 
> 
> Lan Tianyu (4):
>   X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
>     support
>   X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
>   KVM: Add tlb remote flush callback in kvm_x86_ops.
>   KVM/x86: Add tlb_remote_flush callback support for vmx
> 
>  arch/x86/hyperv/Makefile            |  2 +-
>  arch/x86/hyperv/nested.c            | 67 ++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
>  arch/x86/include/asm/kvm_host.h     | 11 ++++++
>  arch/x86/include/asm/mshyperv.h     |  2 ++
>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
>  arch/x86/kvm/vmx.c                  | 72 ++++++++++++++++++++++++++++++++++++-
>  include/linux/kvm_host.h            |  7 ++++
>  virt/kvm/kvm_main.c                 |  3 +-
>  9 files changed, 183 insertions(+), 3 deletions(-)
>  create mode 100644 arch/x86/hyperv/nested.c
> 

