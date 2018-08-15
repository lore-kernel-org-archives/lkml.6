Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8578C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785C321725
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0E/Za/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 785C321725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeHODv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 23:51:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46445 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbeHODv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 23:51:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so10000447pfn.13;
        Tue, 14 Aug 2018 18:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=84WqiqyaQFyM8qg5/6Oz1dF7AzO2GOWNTPGqHmMyQJE=;
        b=l0E/Za/P03WlimgdQZIex3rsQDl8se9SgHGUWddtdTmUkQNlxPN7KfdSMawaX9AmOY
         tddd9Y7F1UblTd5OeRupxxeC/haNXwSwDyxuh7QeUFgdjsVwuGwDhfN9gHA/KKQaouuk
         3UuLQ3oiwCRWvtDtow0si6lqPKxE7P8gn8p2x3zYOhzns4RoRBgAK1AEVtQLIe36KJmK
         SPrJzUTm0UgM4E5UdBuW18p9atscXOkUXM3X4TmoAoXMjHLYmGSHe9j0hhdr64dNho5C
         JI/7kW+ryr8mFueCi21ubAuaCrsffZXblC4XoXK2tglzTFaH7SyB5/MdFIghfUb2nQWm
         6GDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=84WqiqyaQFyM8qg5/6Oz1dF7AzO2GOWNTPGqHmMyQJE=;
        b=NQwTuDV2WP47nL26mzsvxk6QIO9N9HQI23lk3MB/xt3rebNx4ifn/0OyIjwl8Phesm
         zQg4wUdRqcFGA9x/CXSFQly52hnZDbjhyZ2thNBOe0xqf0EAhK1ynsf8nfoVT0WukZH2
         tgTCdj/001eCc17vdru8g5B79Xlu1PZ1cb08ixtFF/n/wpnF3lDPfBD4zHbxP3LoQ2Kv
         2HKO7qhdLxxG4GiVvLTuzTTvrCY68LbDUH2NpTWLs1MC8VoAPHYNBDL9y8S2lHuW8O25
         RwgndwO6t8n6jlubZTFL9Nbt+7LXtRXcyALcCwsPm9XUrnxJRgamCxBt3pu8Ux/igXYE
         ER3A==
X-Gm-Message-State: AOUpUlFiPl2Shd62qArigzzDimX6GcnpfkeOs7Sh9JmdR9qrBkAxmQD2
        3rdpw91pV9ufaWRGm4K7SF3a+Yzm
X-Google-Smtp-Source: AA+uWPx5/LfH3/DiFRlxApXPiuWZKlmwp06DsZ22tzETxBYvSkhz7gQ/3zRrYFysUlpHBtLVtyaHTw==
X-Received: by 2002:a62:411a:: with SMTP id o26-v6mr25354405pfa.111.1534294901462;
        Tue, 14 Aug 2018 18:01:41 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m4-v6sm21309349pgn.82.2018.08.14.18.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 18:01:40 -0700 (PDT)
Subject: Re: [PATCH 4.9 000/107] 4.9.120-stable review
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180814171520.883143803@linuxfoundation.org>
 <891d41f8-e0e3-afa8-3274-b9a10afd3dbb@dd-wrt.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <72777101-78dc-408d-76e3-88cffc68f456@roeck-us.net>
Date:   Tue, 14 Aug 2018 18:01:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <891d41f8-e0e3-afa8-3274-b9a10afd3dbb@dd-wrt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 05:36 PM, Sebastian Gottschall wrote:
> if SWAP is disabled in kernel config, the following compile error will raise up with this release
> 
> arch/x86/built-in.o: in function `max_swapfile_size': (.text+0x3bba1): undefined reference to `generic_max_swapfile_size'
> 
> of course this is simple to fix. the function max_swapfile_size must be excluded if CONFIG_SWAP is disabled
> 

Fixed with upstream commit 792adb90fa72 ("x86/init: fix build with CONFIG_SWAP=n").
Also needed in other stable branches (at least in 4.4).

Guenter

> Sebastian
> 
> Am 14.08.2018 um 19:16 schrieb Greg Kroah-Hartman:
>> This is the start of the stable review cycle for the 4.9.120 release.
>> There are 107 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Aug 16 17:14:53 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.120-rc1.gz
>> or in the git tree and branch at:
>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>>
>> -------------
>> Pseudo-Shortlog of commits:
>>
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>      Linux 4.9.120-rc1
>>
>> Josh Poimboeuf <jpoimboe@redhat.com>
>>      x86/microcode: Allow late microcode loading with SMT disabled
>>
>> Ashok Raj <ashok.raj@intel.com>
>>      x86/microcode: Do not upload microcode if CPUs are offline
>>
>> David Woodhouse <dwmw@amazon.co.uk>
>>      tools headers: Synchronise x86 cpufeatures.h for L1TF additions
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/mm/kmmio: Make the tracer robust against L1TF
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/mm/pat: Make set_memory_np() L1TF safe
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Invert all not present mappings
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Fix SMT supported evaluation
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      x86/speculation: Use ARCH_CAPABILITIES to skip L1D flush on vmentry
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      x86/speculation: Simplify sysfs report of VMX L1TF vulnerability
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR
>>
>> Wanpeng Li <wanpengli@tencent.com>
>>      KVM: X86: Allow userspace to define the microcode version
>>
>> Wanpeng Li <wanpengli@tencent.com>
>>      KVM: X86: Introduce kvm_get_msr_feature()
>>
>> Tom Lendacky <thomas.lendacky@amd.com>
>>      KVM: SVM: Add MSR-based feature support for serializing LFENCE
>>
>> Tom Lendacky <thomas.lendacky@amd.com>
>>      KVM: x86: Add a framework for supporting MSR-based features
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      Documentation/l1tf: Remove Yonah processors from not vulnerable list
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Don't set l1tf_flush_l1d from vmx_handle_external_intr()
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86: Don't include linux/irq.h from asm/hardirq.h
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Introduce per-host-cpu analogue of l1tf_flush_l1d
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/irq: Demote irq_cpustat_t::__softirq_pending to u16
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Move the l1tf_flush_l1d test to vmx_l1d_flush()
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Replace 'vmx_l1d_flush_always' with 'vmx_l1d_flush_cond'
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Don't set l1tf_flush_l1d to true from vmx_l1d_flush()
>>
>> Josh Poimboeuf <jpoimboe@redhat.com>
>>      cpu/hotplug: detect SMT disabled by BIOS
>>
>> Tony Luck <tony.luck@intel.com>
>>      Documentation/l1tf: Fix typos
>>
>> Nicolai Stange <nstange@suse.de>
>>      x86/KVM/VMX: Initialize the vmx_l1d_flush_pages' content
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      Documentation: Add section about CPU vulnerabilities
>>
>> Jiri Kosina <jkosina@suse.cz>
>>      x86/bugs, kvm: Introduce boot-time control of L1TF mitigations
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Set CPU_SMT_NOT_SUPPORTED early
>>
>> Jiri Kosina <jkosina@suse.cz>
>>      cpu/hotplug: Expose SMT control init function
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/kvm: Allow runtime control of L1D flush
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/kvm: Serialize L1D flush parameter setter
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/kvm: Add static key for flush always
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/kvm: Move l1tf setup function
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/l1tf: Handle EPT disabled state proper
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/kvm: Drop L1TF MSR list approach
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/litf: Introduce vmx status variable
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Online siblings when SMT control is turned on
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Extend add_atomic_switch_msr() to allow VMENTER only MSRs
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Separate the VMX AUTOLOAD guest/host number accounting
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Add find_msr() helper function
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Split the VMX MSR LOAD structures to have an host/guest numbers
>>
>> Jim Mattson <jmattson@google.com>
>>      kvm: nVMX: Update MSR load counts on a VMCS switch
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      x86/KVM/VMX: Add L1D flush logic
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      x86/KVM/VMX: Add L1D MSR based flush
>>
>> Paolo Bonzini <pbonzini@redhat.com>
>>      x86/KVM/VMX: Add L1D flush algorithm
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM/VMX: Add module argument for L1TF mitigation
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug being present
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Boot HT siblings at least once
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      Revert "x86/apic: Ignore secondary threads if nosmt=force"
>>
>> Michal Hocko <mhocko@suse.cz>
>>      x86/speculation/l1tf: Fix up pte->pfn conversion for PAE
>>
>> Vlastimil Babka <vbabka@suse.cz>
>>      x86/speculation/l1tf: Protect PAE swap entries against L1TF
>>
>> Borislav Petkov <bp@suse.de>
>>      x86/CPU/AMD: Move TOPOEXT reenablement before reading smp_num_siblings
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/cpufeatures: Add detection of L1D cache flush support.
>>
>> Vlastimil Babka <vbabka@suse.cz>
>>      x86/speculation/l1tf: Extend 64bit swap file size limit
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/apic: Ignore secondary threads if nosmt=force
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu/AMD: Evaluate smp_num_siblings early
>>
>> Borislav Petkov <bp@suse.de>
>>      x86/CPU/AMD: Do not check CPUID max ext level before parsing SMP info
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu/intel: Evaluate smp_num_siblings early
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu/topology: Provide detect_extended_topology_early()
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu/common: Provide detect_ht_early()
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu/AMD: Remove the pointless detect_ht() call
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/cpu: Remove the pointless CPU printout
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Provide knobs to control SMT
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Split do_cpu_down()
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      cpu/hotplug: Make bringup/teardown of smp threads symmetric
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/topology: Provide topology_smt_supported()
>>
>> Thomas Gleixner <tglx@linutronix.de>
>>      x86/smp: Provide topology_is_primary_thread()
>>
>> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>      x86/bugs: Move the l1tf function and define pr_fmt properly
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Limit swap file size to MAX_PA/2
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Disallow non privileged high MMIO PROT_NONE mappings
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Add sysfs reporting for l1tf
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Make sure the first page is always reserved
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
>>
>> Linus Torvalds <torvalds@linux-foundation.org>
>>      x86/speculation/l1tf: Protect swap entries against L1TF
>>
>> Linus Torvalds <torvalds@linux-foundation.org>
>>      x86/speculation/l1tf: Change order of offset/type in swap entry
>>
>> Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
>>      mm: x86: move _PAGE_SWP_SOFT_DIRTY from bit 7 to bit 1
>>
>> Andi Kleen <ak@linux.intel.com>
>>      x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT
>>
>> Nick Desaulniers <ndesaulniers@google.com>
>>      x86/irqflags: Provide a declaration for native_save_fl
>>
>> Masami Hiramatsu <mhiramat@kernel.org>
>>      kprobes/x86: Fix %p uses in error messages
>>
>> Jiri Kosina <jkosina@suse.cz>
>>      x86/speculation: Protect against userspace-userspace spectreRSB
>>
>> Peter Zijlstra <peterz@infradead.org>
>>      x86/paravirt: Fix spectre-v2 mitigations for paravirt guests
>>
>> Oleksij Rempel <o.rempel@pengutronix.de>
>>      ARM: dts: imx6sx: fix irq for pcie bridge
>>
>> Michael Mera <dev@michaelmera.com>
>>      IB/ocrdma: fix out of bounds access to local buffer
>>
>> Fabio Estevam <fabio.estevam@nxp.com>
>>      mtd: nand: qcom: Add a NULL check for devm_kasprintf()
>>
>> Jack Morgenstein <jackm@dev.mellanox.co.il>
>>      IB/mlx4: Mark user MR as writable if actual virtual memory is writable
>>
>> Jack Morgenstein <jackm@dev.mellanox.co.il>
>>      IB/core: Make testing MR flags for writability a static inline function
>>
>> Eric W. Biederman <ebiederm@xmission.com>
>>      proc: Fix proc_sys_prune_dcache to hold a sb reference
>>
>> Eric W. Biederman <ebiederm@xmission.com>
>>      proc/sysctl: Don't grab i_lock under sysctl_lock.
>>
>> Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>      proc/sysctl: prune stale dentries during unregistering
>>
>> Al Viro <viro@zeniv.linux.org.uk>
>>      fix __legitimize_mnt()/mntput() race
>>
>> Al Viro <viro@zeniv.linux.org.uk>
>>      fix mntput/mntput race
>>
>> Al Viro <viro@zeniv.linux.org.uk>
>>      make sure that __dentry_kill() always invalidates d_seq, unhashed or not
>>
>> Al Viro <viro@zeniv.linux.org.uk>
>>      root dentries need RCU-delayed freeing
>>
>> Linus Torvalds <torvalds@linux-foundation.org>
>>      init: rename and re-order boot_cpu_state_init()
>>
>> Bart Van Assche <bart.vanassche@wdc.com>
>>      scsi: sr: Avoid that opening a CD-ROM hangs with runtime power management enabled
>>
>> Hans de Goede <hdegoede@redhat.com>
>>      ACPI / LPSS: Add missing prv_offset setting for byt/cht PWM devices
>>
>> Juergen Gross <jgross@suse.com>
>>      xen/netfront: don't cache skb_shinfo()
>>
>> Linus Torvalds <torvalds@linux-foundation.org>
>>      Mark HI and TASKLET softirq synchronous
>>
>> Andrey Konovalov <andreyknvl@google.com>
>>      kasan: add no_sanitize attribute for clang builds
>>
>> John David Anglin <dave.anglin@bell.net>
>>      parisc: Define mb() and add memory barriers to assembler unlock sequences
>>
>> Helge Deller <deller@gmx.de>
>>      parisc: Enable CONFIG_MLONGCALLS by default
>>
>> Tadeusz Struk <tadeusz.struk@intel.com>
>>      tpm: fix race condition in tpm_common_write()
>>
>> Theodore Ts'o <tytso@mit.edu>
>>      ext4: fix check to prevent initializing reserved inodes
>>
>>
>> -------------
>>
>> Diffstat:
>>
>>   Documentation/ABI/testing/sysfs-devices-system-cpu |  24 +
>>   Documentation/index.rst                            |   1 +
>>   Documentation/kernel-parameters.txt                |  78 +++
>>   Documentation/l1tf.rst                             | 610 +++++++++++++++++++++
>>   Documentation/virtual/kvm/api.txt                  |  40 +-
>>   Makefile                                           |   4 +-
>>   arch/Kconfig                                       |   3 +
>>   arch/arm/boot/dts/imx6sx.dtsi                      |   2 +-
>>   arch/parisc/Kconfig                                |   2 +-
>>   arch/parisc/include/asm/barrier.h                  |  32 ++
>>   arch/parisc/kernel/entry.S                         |   2 +
>>   arch/parisc/kernel/pacache.S                       |   1 +
>>   arch/parisc/kernel/syscall.S                       |   4 +
>>   arch/x86/Kconfig                                   |   1 +
>>   arch/x86/include/asm/apic.h                        |  10 +
>>   arch/x86/include/asm/cpufeatures.h                 |   4 +-
>>   arch/x86/include/asm/dmi.h                         |   2 +-
>>   arch/x86/include/asm/hardirq.h                     |  26 +-
>>   arch/x86/include/asm/irqflags.h                    |   2 +
>>   arch/x86/include/asm/kvm_host.h                    |   9 +
>>   arch/x86/include/asm/msr-index.h                   |   7 +
>>   arch/x86/include/asm/page_32_types.h               |   9 +-
>>   arch/x86/include/asm/pgtable-2level.h              |  17 +
>>   arch/x86/include/asm/pgtable-3level.h              |  37 +-
>>   arch/x86/include/asm/pgtable-invert.h              |  32 ++
>>   arch/x86/include/asm/pgtable.h                     |  85 ++-
>>   arch/x86/include/asm/pgtable_64.h                  |  48 +-
>>   arch/x86/include/asm/pgtable_types.h               |  10 +-
>>   arch/x86/include/asm/processor.h                   |  17 +
>>   arch/x86/include/asm/topology.h                    |   6 +-
>>   arch/x86/include/asm/vmx.h                         |  11 +
>>   arch/x86/kernel/apic/apic.c                        |  17 +
>>   arch/x86/kernel/apic/htirq.c                       |   2 +
>>   arch/x86/kernel/apic/io_apic.c                     |   1 +
>>   arch/x86/kernel/apic/msi.c                         |   1 +
>>   arch/x86/kernel/apic/vector.c                      |   1 +
>>   arch/x86/kernel/cpu/amd.c                          |  53 +-
>>   arch/x86/kernel/cpu/bugs.c                         | 171 ++++--
>>   arch/x86/kernel/cpu/common.c                       |  56 +-
>>   arch/x86/kernel/cpu/cpu.h                          |   2 +
>>   arch/x86/kernel/cpu/intel.c                        |   7 +
>>   arch/x86/kernel/cpu/microcode/core.c               |  26 +
>>   arch/x86/kernel/cpu/topology.c                     |  41 +-
>>   arch/x86/kernel/fpu/core.c                         |   1 +
>>   arch/x86/kernel/ftrace.c                           |   1 +
>>   arch/x86/kernel/hpet.c                             |   1 +
>>   arch/x86/kernel/i8259.c                            |   1 +
>>   arch/x86/kernel/irq.c                              |   1 +
>>   arch/x86/kernel/irq_32.c                           |   1 +
>>   arch/x86/kernel/irq_64.c                           |   1 +
>>   arch/x86/kernel/irqinit.c                          |   1 +
>>   arch/x86/kernel/kprobes/core.c                     |   5 +-
>>   arch/x86/kernel/kprobes/opt.c                      |   1 +
>>   arch/x86/kernel/paravirt.c                         |  14 +-
>>   arch/x86/kernel/setup.c                            |   6 +
>>   arch/x86/kernel/smp.c                              |   1 +
>>   arch/x86/kernel/smpboot.c                          |  18 +
>>   arch/x86/kernel/time.c                             |   1 +
>>   arch/x86/kvm/svm.c                                 |  46 +-
>>   arch/x86/kvm/vmx.c                                 | 426 ++++++++++++--
>>   arch/x86/kvm/x86.c                                 | 133 ++++-
>>   arch/x86/mm/fault.c                                |   1 +
>>   arch/x86/mm/init.c                                 |  23 +
>>   arch/x86/mm/kaiser.c                               |   1 +
>>   arch/x86/mm/kmmio.c                                |  25 +-
>>   arch/x86/mm/mmap.c                                 |  21 +
>>   arch/x86/mm/pageattr.c                             |   8 +-
>>   arch/x86/platform/efi/efi_64.c                     |   1 +
>>   arch/x86/platform/efi/quirks.c                     |   1 +
>>   .../intel-mid/device_libs/platform_mrfld_wdt.c     |   1 +
>>   arch/x86/platform/uv/tlb_uv.c                      |   1 +
>>   arch/x86/xen/enlighten.c                           |   1 +
>>   arch/x86/xen/setup.c                               |   1 +
>>   drivers/acpi/acpi_lpss.c                           |   2 +
>>   drivers/base/cpu.c                                 |   8 +
>>   drivers/char/tpm/tpm-dev.c                         |  43 +-
>>   drivers/infiniband/core/umem.c                     |  11 +-
>>   drivers/infiniband/hw/mlx4/mr.c                    |  50 +-
>>   drivers/infiniband/hw/ocrdma/ocrdma_stats.c        |   2 +-
>>   drivers/mtd/nand/qcom_nandc.c                      |   3 +
>>   drivers/net/xen-netfront.c                         |   8 +-
>>   drivers/pci/host/pci-hyperv.c                      |   2 +
>>   drivers/scsi/sr.c                                  |  29 +-
>>   fs/dcache.c                                        |  13 +-
>>   fs/ext4/ialloc.c                                   |   5 +-
>>   fs/ext4/super.c                                    |   8 +-
>>   fs/namespace.c                                     |  28 +-
>>   fs/proc/inode.c                                    |   3 +-
>>   fs/proc/internal.h                                 |   7 +-
>>   fs/proc/proc_sysctl.c                              |  83 ++-
>>   include/asm-generic/pgtable.h                      |  12 +
>>   include/linux/compiler-clang.h                     |   3 +
>>   include/linux/cpu.h                                |  23 +-
>>   include/linux/swapfile.h                           |   2 +
>>   include/linux/sysctl.h                             |   1 +
>>   include/rdma/ib_verbs.h                            |  14 +
>>   include/uapi/linux/kvm.h                           |   2 +
>>   init/main.c                                        |   2 +-
>>   kernel/cpu.c                                       | 282 +++++++++-
>>   kernel/smp.c                                       |   2 +
>>   kernel/softirq.c                                   |  12 +-
>>   mm/memory.c                                        |  29 +-
>>   mm/mprotect.c                                      |  49 ++
>>   mm/swapfile.c                                      |  46 +-
>>   tools/arch/x86/include/asm/cpufeatures.h           |   4 +-
>>   105 files changed, 2680 insertions(+), 366 deletions(-)
>>
>>
>>
> 

