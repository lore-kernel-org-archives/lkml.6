Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B921581
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHv4GXS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71B921581
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbeHQL6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:58:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38069 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeHQL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:58:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id p6-v6so5792176ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 01:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=3HdOn7vSKNFQw6GmgMmI2m3L9MwEOkQiloeRj/72Fog=;
        b=JHv4GXS5A3Zil7CyCYSSv1lgRETHl0gYR8TKapSUlrAONTYQSb/6DjksD2/ehqpO5Y
         cx6YVcycMqJCajaj2K8X9XUsdVMNNVjx1aAyQCagUKYTH21m8dsFsskPy7VGFUm2Omna
         xy2Q2LBbz5rSqo8crpvqEgDMimZtIFe91p5AifFHGDWtPIBhORqdb15bMmaav+o2p8lt
         txR5pd/ZoqawC0t9q4dGC4cUnNlYgfDX6w6qliAM2mSivtjf/GU8ChO+XDnzGfbl+I/+
         +8dR07c80Jrn5SqHI73kkg+DzUVP10ctk5fcZeOJ+4SpTZRo6rOYh33uo/+Fkif5gVsM
         /qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=3HdOn7vSKNFQw6GmgMmI2m3L9MwEOkQiloeRj/72Fog=;
        b=bNFDgcSIY/8F9NwMltbT3KLPnsMOdig+dVCL0kFDDx+O7dw3HgwA9ufsXJQpK2tnvV
         dp68uEFAB7mz/4XGOvQe0jaHz8rJJHNOsb1VzilUD1jjhB4sdgCT3pMnOoLcu58CYXem
         BbRE1WYzSzLDqouapRM7LP3zQhIfFbdw8BDSziYpzcqMtqMv18zjXhTNCdCBLwtwPeq0
         eSRZRdrSBAsoAT2nR+EPAm6FqQYumgQne7zdN1+yEJ2RQXrx7MNurpfq2PU5nWislmSu
         TP59M4eiUE1clWRWvyMQpixiozFcVpWAm09DnvnlXl1W4LHJPo+VL9ABBBeBfl+dqVDr
         i4Vw==
X-Gm-Message-State: AOUpUlH253zhxX9DGB+EDZcbsc9ihiT+VoJXGuqQmQSpSXF9Ot3A9Z+W
        IiRXf8qUSMMa4O0wfTfD11XXMXags97A5VFwebomBTwJCdE=
X-Google-Smtp-Source: AA+uWPwt70APB/1CR+oCnG/s7OzGi+9Mo/6puWGn+GB68VeYy8iNuA/o/TGLXrdGfFnoypRmBiQkkFM9pemo7qSUHd0=
X-Received: by 2002:a2e:40ca:: with SMTP id r71-v6mr22801681lje.41.1534496132620;
 Fri, 17 Aug 2018 01:55:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5051:0:0:0:0:0 with HTTP; Fri, 17 Aug 2018 01:55:31
 -0700 (PDT)
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAOMGZ=G-MU7qTSeA4VFK+-nx2jFAM2fGL8WpQ6eBRvovEhaneQ@mail.gmail.com>
References: <CA+icZUW9Cg0G41ZSwjUBaJ+F9qCc23GGMp8aCgfNQejstKJmmQ@mail.gmail.com>
 <CAFLxGvxhUyqs3_esJwBjHrTY0Ba=bPB=425hWr0rz-BySTjzoA@mail.gmail.com> <CAOMGZ=G-MU7qTSeA4VFK+-nx2jFAM2fGL8WpQ6eBRvovEhaneQ@mail.gmail.com>
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Aug 2018 10:55:31 +0200
Message-ID: <CA+icZUWjbKxN+ED1dO0qDk_2UerV2aEXMjxeQtGkmsoGvv3aNw@mail.gmail.com>
Subject: Re: Merge branch 'l1tf-final' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
To:     Vegard Nossum <vegard.nossum@gmail.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        x86 maintainers <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 10:33 AM, Vegard Nossum <vegard.nossum@gmail.com> wrote:
> On 16 August 2018 at 17:42, Richard Weinberger
> <richard.weinberger@gmail.com> wrote:
>> On Thu, Aug 16, 2018 at 2:58 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>>
>>> Hi Linus,
>>>
>>> I am here on Linux v4.18 and tried first to merge the l1tf-final Git-branch.
>>> Unfortunately, this is no more available in the tip Git-tree.
>>>
>>> Then I saw Linux v4.18.1 which includes all the above stuff.
>>>
>>> I tried to 'git cherry-pick -m 1 958f338e96f874a0d29442396d6adf9c1e17aa2d'.
>>> I know the commit-id is the hash of a merge.
>>> Luckily, I could get the "diff" and applied it.
>>> But the history misses.
>>>
>>> How can I get the history and subjects of all commits in your tree to
>>> cherry-pick the single commits?
>>>
>>> Do you happen to know another solution to get easily all L1TF commits
>>> with any other tricks?
>>
>> That should help:
>> git log --oneline
>> 958f338e96f874a0d29442396d6adf9c1e17aa2d^..958f338e96f874a0d29442396d6adf9c1e17aa2d
>
> Hey,
>
> As a shorthand for this, you can also use just:
>
> git log --oneline 958f338e96f87^-
>
> The syntax was made especially so that you can see all the commits
> that arrived via a merge commit without having to write the rev of the
> merge twice but is otherwise exactly equivalent to "rev^..rev".
>
> It should work from git v2.13. Just a tip :-)
>

Cool. I have here git v2.18.
Finally, I found --no-pager and the place to put in my git-line.

sdi@iniza:~/src/linux-kernel/linux$ git --no-pager log --oneline
--no-merges 958f338e96f87^-
07d981ad4cf1 x86/microcode: Allow late microcode loading with SMT disabled
e24f14b0ff98 tools headers: Synchronise x86 cpufeatures.h for L1TF additions
1063711b5739 x86/mm/kmmio: Make the tracer robust against L1TF
958f79b9ee55 x86/mm/pat: Make set_memory_np() L1TF safe
0768f91530ff x86/speculation/l1tf: Make pmd/pud_mknotpresent() invert
f22cc87f6c1f x86/speculation/l1tf: Invert all not present mappings
bc2d8d262cba cpu/hotplug: Fix SMT supported evaluation
5b76a3cff011 KVM: VMX: Tell the nested hypervisor to skip L1D flush on vmentry
8e0b2b916662 x86/speculation: Use ARCH_CAPABILITIES to skip L1D flush on vmentry
ea156d192f52 x86/speculation: Simplify sysfs report of VMX L1TF vulnerability
583311361369 Documentation/l1tf: Remove Yonah processors from not
vulnerable list
18b57ce2eb8c x86/KVM/VMX: Don't set l1tf_flush_l1d from
vmx_handle_external_intr()
ffcba43ff66c x86/irq: Let interrupt handlers set kvm_cpu_l1tf_flush_l1d
447ae3166702 x86: Don't include linux/irq.h from asm/hardirq.h
45b575c00d8e x86/KVM/VMX: Introduce per-host-cpu analogue of l1tf_flush_l1d
9aee5f8a7e30 x86/irq: Demote irq_cpustat_t::__softirq_pending to u16
5b6ccc6c3b1a x86/KVM/VMX: Move the l1tf_flush_l1d test to vmx_l1d_flush()
427362a14244 x86/KVM/VMX: Replace 'vmx_l1d_flush_always' with
'vmx_l1d_flush_cond'
379fd0c7e6a3 x86/KVM/VMX: Don't set l1tf_flush_l1d to true from vmx_l1d_flush()
73d5e2b47264 cpu/hotplug: detect SMT disabled by BIOS
1949f9f49792 Documentation/l1tf: Fix typos
288d152c23dc x86/KVM/VMX: Initialize the vmx_l1d_flush_pages' content
6c26fcd2abfe x86/speculation/l1tf: Unbreak
!__HAVE_ARCH_PFN_MODIFY_ALLOWED architectures
3ec8ce5d866e Documentation: Add section about CPU vulnerabilities
d90a7a0ec83f x86/bugs, kvm: Introduce boot-time control of L1TF mitigations
fee0aede6f47 cpu/hotplug: Set CPU_SMT_NOT_SUPPORTED early
8e1b706b6e81 cpu/hotplug: Expose SMT control init function
895ae47f9918 x86/kvm: Allow runtime control of L1D flush
dd4bfa739a72 x86/kvm: Serialize L1D flush parameter setter
4c6523ec59fe x86/kvm: Add static key for flush always
7db92e165ac8 x86/kvm: Move l1tf setup function
a7b9020b06ec x86/l1tf: Handle EPT disabled state proper
2f055947ae5e x86/kvm: Drop L1TF MSR list approach
72c6d2db64fa x86/litf: Introduce vmx status variable
215af5499d9e cpu/hotplug: Online siblings when SMT control is turned on
390d975e0c4e x86/KVM/VMX: Use MSR save list for IA32_FLUSH_CMD if required
989e3992d2ec x86/KVM/VMX: Extend add_atomic_switch_msr() to allow
VMENTER only MSRs
3190709335dd x86/KVM/VMX: Separate the VMX AUTOLOAD guest/host number accounting
ca83b4a7f2d0 x86/KVM/VMX: Add find_msr() helper function
33966dd6b2d2 x86/KVM/VMX: Split the VMX MSR LOAD structures to have an
host/guest numbers
c595ceee4570 x86/KVM/VMX: Add L1D flush logic
3fa045be4c72 x86/KVM/VMX: Add L1D MSR based flush
a47dd5f06714 x86/KVM/VMX: Add L1D flush algorithm
a399477e52c1 x86/KVM/VMX: Add module argument for L1TF mitigation
26acfb666a47 x86/KVM: Warn user if KVM is loaded SMT and L1TF CPU bug
being present
0cc3cd21657b cpu/hotplug: Boot HT siblings at least once
506a66f37489 Revert "x86/apic: Ignore secondary threads if nosmt=force"
e14d7dfb41f5 x86/speculation/l1tf: Fix up pte->pfn conversion for PAE
0d0f62490588 x86/speculation/l1tf: Protect PAE swap entries against L1TF
7ce2f0393ea2 x86/CPU/AMD: Move TOPOEXT reenablement before reading
smp_num_siblings
11e34e64e410 x86/cpufeatures: Add detection of L1D cache flush support.
1a7ed1ba4bba x86/speculation/l1tf: Extend 64bit swap file size limit
2207def700f9 x86/apic: Ignore secondary threads if nosmt=force
1e1d7e25fd75 x86/cpu/AMD: Evaluate smp_num_siblings early
119bff8a9c9b x86/CPU/AMD: Do not check CPUID max ext level before
parsing SMP info
1910ad562496 x86/cpu/intel: Evaluate smp_num_siblings early
95f3d39ccf7a x86/cpu/topology: Provide detect_extended_topology_early()
545401f4448a x86/cpu/common: Provide detect_ht_early()
44ca36de56d1 x86/cpu/AMD: Remove the pointless detect_ht() call
55e6d279abd9 x86/cpu: Remove the pointless CPU printout
05736e4ac13c cpu/hotplug: Provide knobs to control SMT
cc1fe215e1ef cpu/hotplug: Split do_cpu_down()
c4de65696d86 cpu/hotplug: Make bringup/teardown of smp threads symmetric
f048c399e0f7 x86/topology: Provide topology_smt_supported()
6a4d2657e048 x86/smp: Provide topology_is_primary_thread()
ba2591a5993e sched/smt: Update sched_smt_present at runtime
56563f53d306 x86/bugs: Move the l1tf function and define pr_fmt properly
377eeaa8e11f x86/speculation/l1tf: Limit swap file size to MAX_PA/2
42e4089c7890 x86/speculation/l1tf: Disallow non privileged high MMIO
PROT_NONE mappings
17dbca119312 x86/speculation/l1tf: Add sysfs reporting for l1tf
10a70416e1f0 x86/speculation/l1tf: Make sure the first page is always reserved
6b28baca9b1f x86/speculation/l1tf: Protect PROT_NONE PTEs against speculation
2f22b4cd45b6 x86/speculation/l1tf: Protect swap entries against L1TF
bcd11afa7ada x86/speculation/l1tf: Change order of offset/type in swap entry
50896e180c6a x86/speculation/l1tf: Increase 32bit PAE __PHYSICAL_PAGE_SHIFT

Thanks,
- Sedat -
