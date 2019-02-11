Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F9FC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCF3222A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 17:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549905986;
	bh=ipfLTZpgOOTeDcV2MToD3yQuXojKV6NejI8rlFygJF0=;
	h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:List-ID:From;
	b=LGVwAG5s+/IKJibMfLQI4A+DwusI0ymDG8SN/8vomNGRIMKMMPxxoAJ1OketGOHQ6
	 1k2us5QG0LSPIcW+I1U6ynLiyAnXsCWdHc50Kh0yi1XUoFT3CSJPjUcOhWXymaVMnD
	 djh9Jm15JodrML/Y6P5EIjuLpYgaYm8S9G8vtR7g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfBKR0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 12:26:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbfBKR0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 12:26:23 -0500
Received: from localhost (unknown [23.100.24.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D06AD2229F;
        Mon, 11 Feb 2019 17:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549905982;
        bh=ipfLTZpgOOTeDcV2MToD3yQuXojKV6NejI8rlFygJF0=;
        h=Date:From:To:To:To:To:Cc:Cc:Cc:Subject:In-Reply-To:From;
        b=fF/KjstpqhN4traoyNOMvKowEMQdPgKv3Ki3XQmsp86GyRLeDBFEafYNGdPMwz27o
         UgS63yMh2nsBwXZJ/2LT4byIZe4AKXSnvZrogwinmAUUst5EvCBRNtyZNO8uRqceX9
         J1k3HNP2x7lEwBb9xQOuZd9KlP3n4a7wQnK6qEY4=
Date:   Mon, 11 Feb 2019 17:26:21 +0000
From:   Sasha Levin <sashal@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
To:     Peter Shier <pshier@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Shier <pshier@google.com>, stable@kernel.org
Cc:     stable@kernel.org
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)
In-Reply-To: <1549562945-5503-3-git-send-email-pbonzini@redhat.com>
Message-Id: <20190211172621.D06AD2229F@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<20181011184646.154065-1-pshier@google.com>
References: <1549562945-5503-3-git-send-email-pbonzini@redhat.com>
<20181011184646.154065-1-pshier@google.com>

Hi,

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: .+

The bot has tested the following trees: v4.20.7, v4.19.20, v4.14.98, v4.9.155, v4.4.173, v3.18.134.

v4.20.7: Failed to apply! Possible dependencies:
    199b118ab3d5 ("KVM: VMX: Alphabetize the includes in vmx.c")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    609363cf81fc ("KVM: nVMX: Move vmcs12 code to dedicated files")
    75edce8a4548 ("KVM: VMX: Move eVMCS code to dedicated files")
    a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")

v4.19.20: Failed to apply! Possible dependencies:
    09abb5e3e5e5 ("KVM: nVMX: call kvm_skip_emulated_instruction in nested_vmx_{fail,succeed}")
    09abe3200266 ("KVM: nVMX: split pieces of prepare_vmcs02() to prepare_vmcs02_early()")
    1438921c6dc1 ("KVM: nVMX: Flush TLB entries tagged by dest EPTP on L1<->L2 transitions")
    199b118ab3d5 ("KVM: VMX: Alphabetize the includes in vmx.c")
    1abf23fb42f5 ("KVM: nVMX: use vm_exit_controls_init() to write exit controls for vmcs02")
    327c072187f7 ("KVM: nVMX: Flush linear and combined mappings on VPID02 related flushes")
    3d5bdae8b164 ("KVM: nVMX: Use correct VPID02 when emulating L1 INVVPID")
    3df5c37e55c8 ("KVM: nVMX: try to set EFER bits correctly when initializing controls")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    5b8ba41dafd7 ("KVM: nVMX: move vmcs12 EPTP consistency check to check_vmentry_prereqs()")
    609363cf81fc ("KVM: nVMX: Move vmcs12 code to dedicated files")
    75edce8a4548 ("KVM: VMX: Move eVMCS code to dedicated files")
    7671ce21b13b ("KVM: nVMX: move check_vmentry_postreqs() call to nested_vmx_enter_non_root_mode()")
    945679e301ea ("KVM: nVMX: add enlightened VMCS state")
    a633e41e7362 ("KVM: nVMX: assimilate nested_vmx_entry_failure() into nested_vmx_enter_non_root_mode()")
    a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")
    b8bbab928fb1 ("KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR")
    d63907dc7dd1 ("KVM: nVMX: rename enter_vmx_non_root_mode to nested_vmx_enter_non_root_mode")
    efebf0aaec3d ("KVM: nVMX: Do not flush TLB on L1<->L2 transitions if L1 uses VPID and EPT")

v4.14.98: Failed to apply! Possible dependencies:
    0234bf885236 ("KVM: x86: introduce ISA specific SMM entry/exit callbacks")
    199b118ab3d5 ("KVM: VMX: Alphabetize the includes in vmx.c")
    44900ba65e16 ("KVM: VMX: optimize shadow VMCS copying")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    5b15706dbf5b ("kvm: vmx: Introduce VMCS12_MAX_FIELD_INDEX")
    609363cf81fc ("KVM: nVMX: Move vmcs12 code to dedicated files")
    6677f3dad874 ("KVM: nVMX: introduce struct nested_vmx_msrs")
    72d7b374b14d ("KVM: x86: introduce ISA specific smi_allowed callback")
    72e9cbdb4338 ("KVM: nVMX: fix SMI injection in guest mode")
    736fdf72518b ("KVM: VMX: rename RDSEED and RDRAND vmx ctrls to reflect exiting")
    74a497fae754 ("KVM: nVMX: track dirty state of non-shadowed VMCS fields")
    75edce8a4548 ("KVM: VMX: Move eVMCS code to dedicated files")
    945679e301ea ("KVM: nVMX: add enlightened VMCS state")
    a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")
    b8bbab928fb1 ("KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR")
    c5d167b27e00 ("KVM: vmx: shadow more fields that are read/written on every vmexits")
    c9e9deae76b8 ("KVM: VMX: split list of shadowed VMCS field to a separate file")
    f4160e459c57 ("kvm: nVMX: Add support for "VMWRITE to any supported field"")

v4.9.155: Failed to apply! Possible dependencies:
    1279a6b124e4 ("KVM: nVMX: single function for switching between vmcs")
    199b118ab3d5 ("KVM: VMX: Alphabetize the includes in vmx.c")
    27c42a1bb867 ("KVM: nVMX: Enable VMFUNC for the L1 hypervisor")
    2a499e49c2ec ("KVM: vmx: Enable VMFUNCs")
    3899152ccbf4 ("KVM: nVMX: fix checks on CR{0,4} during virtual VMX operation")
    44900ba65e16 ("KVM: VMX: optimize shadow VMCS copying")
    4f350c6dbcb9 ("kvm: nVMX: Handle deferred early VMLAUNCH/VMRESUME failure properly")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    5a6a9748b4b4 ("KVM: nVMX: load GUEST_EFER after GUEST_CR0 during emulated VM-entry")
    609363cf81fc ("KVM: nVMX: Move vmcs12 code to dedicated files")
    62cc6b9dc61e ("KVM: nVMX: support restore of VMX capability MSRs")
    72e9cbdb4338 ("KVM: nVMX: fix SMI injection in guest mode")
    74a497fae754 ("KVM: nVMX: track dirty state of non-shadowed VMCS fields")
    75edce8a4548 ("KVM: VMX: Move eVMCS code to dedicated files")
    7ca29de21362 ("KVM: nVMX: fix CR3 load if L2 uses PAE paging and EPT")
    858e25c06fb0 ("kvm: nVMX: Refactor nested_vmx_run()")
    85fd514e2423 ("kvm: nVMX: Shadow "high" parts of shadowed 64-bit VMCS fields")
    945679e301ea ("KVM: nVMX: add enlightened VMCS state")
    9ed38ffad473 ("KVM: nVMX: introduce nested_vmx_load_cr3 and call it on vmentry")
    a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")
    a8bc284eb70f ("kvm: nVMX: Refactor handle_vmptrld()")
    b8bbab928fb1 ("KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR")
    c5d167b27e00 ("KVM: vmx: shadow more fields that are read/written on every vmexits")
    c7c2c709b60e ("kvm: nVMX: Validate CR3 target count on nested VM-entry")
    c9e9deae76b8 ("KVM: VMX: split list of shadowed VMCS field to a separate file")
    ca0bde28f2ed ("kvm: nVMX: Split VMCS checks from nested_vmx_run()")
    cf3215d9394a ("kvm: nVMX: Fetch VM_INSTRUCTION_ERROR from vmcs02 on vmx->fail")
    ee146c1c100d ("KVM: nVMX: propagate errors from prepare_vmcs02")

v4.4.173: Failed to apply! Possible dependencies:
    199b118ab3d5 ("KVM: VMX: Alphabetize the includes in vmx.c")
    355f4fb1405e ("kvm: nVMX: VMCLEAR an active shadow VMCS after last use")
    4f2777bc9797 ("kvm: x86: nVMX: maintain internal copy of current VMCS")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    609363cf81fc ("KVM: nVMX: Move vmcs12 code to dedicated files")
    6308630bd3db ("kvm/x86: split ioapic-handled and EOI exit bitmaps")
    74a497fae754 ("KVM: nVMX: track dirty state of non-shadowed VMCS fields")
    75edce8a4548 ("KVM: VMX: Move eVMCS code to dedicated files")
    945679e301ea ("KVM: nVMX: add enlightened VMCS state")
    a821bab2d1ee ("KVM: VMX: Move VMX specific files to a "vmx" subdirectory")
    a8bc284eb70f ("kvm: nVMX: Refactor handle_vmptrld()")
    b8bbab928fb1 ("KVM: nVMX: implement enlightened VMPTRLD and VMCLEAR")
    bb3541f175a9 ("KVM: x86: Fix typos")
    d62caabb41f3 ("kvm/x86: per-vcpu apicv deactivation support")

v3.18.134: Failed to apply! Possible dependencies:
    394457a928e0 ("KVM: x86: some apic broadcast modes does not work")
    55d2375e58a6 ("KVM: nVMX: Move nested code to dedicated files")
    6ef768fac9df ("kvm: x86: move ioapic.c and irq_comm.c back to arch/x86/")
    70109e7d9d4a ("KVM: MTRR: remove mtrr_state.have_fixed")
    c274e03af705 ("kvm: x86: move assigned-dev.c and iommu.c to arch/x86/")
    e83d58874ba1 ("kvm/x86: move Hyper-V MSR's/hypercall code into hyperv.c file")
    ff53604b40b4 ("KVM: x86: move MTRR related code to a separate file")


How should we proceed with this patch?

--
Thanks,
Sasha
