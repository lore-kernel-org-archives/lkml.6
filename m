Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1421698-1521022865-2-12494577795545999580
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521022863; b=a0Wa6PmvwQcdHXFoXZVREY/hHR4zE66jjTSVQrnqnOcpoPo
    topVl/02abbVhil4bG8fSooszndLEtG4+G8VXemxixC87UGYX4LVcvmTpSikA+JT
    9mYsEuiYt0MxgTM89sfAXKjehF863HkVizEpPXAwrstAQKjZGKtXXQNTayhnA5Hq
    rSHgQj1UT7e7rZTbx6Mnqjv2fxa8Bgp0M6zoABVGB1CFFfhiFZTLpX6cwlfl3JSn
    HSwXH2Pk1nwbXg+glpzl1z0RzNpya1rBT5rJ7ZWRYn/cMsadcZHuoHFCeWRLLq7d
    r2O+5dttvm3I7Q23r5HXy7O4QdC9NpQhxCGY0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521022863; bh=hcWSg7YkGWV9yEUqTVyr5tpMf5lq1o1D1HzE7l
    NvHHA=; b=jz3uraRZax4HcAL8ivK855NUUzlvangf4rDCP1wuAsxzW723gZYHeH
    o04JFeDurAoFS4SpITmVENLm08tk0tFDunU6K7EmEqHGVTf23V3GKq0XDl4f016z
    2JKGfdOxKh66T3IXA70hkQP8S3X5CUskqo0JLfDiaKCCI3ehYBJFVPdXUJ5cUiIT
    8lKSmqtimGwRAC3TJoYQ943DJ7yyKfisEw+rI3p29gn3uoUCRH0WkiMxIMtvbNG+
    g0rgAXSjr4qQiDC4kSixXlPCQbzp7A5y4KQzcf8BymM1I97HjTnQZdnNVBaKAHDj
    okPjmAm8/oV57b5rujjK4QkBBGwjKEtw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FiyGk1tH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h6HLeJsI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=FiyGk1tH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=h6HLeJsI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeCNKVC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 06:21:02 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43801 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeCNKU7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 06:20:59 -0400
X-Google-Smtp-Source: AG47ELtVj8iPTH/XRJ0A0ZHnOz4up4/GOeEUSKI3RcIPC5Z26pnjzDH7VTfY0nHSe9qnJs/+6CSdUMirypalUI42o0g=
MIME-Version: 1.0
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 14 Mar 2018 15:50:56 +0530
Message-ID: <CA+G9fYspDG9qukkn__sLVpsWkXDhwQ-sOLn6p7R_G0E4xa4vFA@mail.gmail.com>
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Daniel Vacek <neelx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 13 March 2018 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.15.10 release.
> There are 146 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 4.15.10-rc1
>
> Trond Myklebust <trond.myklebust@primarydata.com>
>     NFS: Fix unstable write completion
>
> Trond Myklebust <trond.myklebust@primarydata.com>
>     pNFS: Prevent the layout header refcount going to zero in pnfs_roc()
>
> Trond Myklebust <trond.myklebust@primarydata.com>
>     NFS: Fix an incorrect type in struct nfs_direct_req
>
> himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
>     scsi: qla2xxx: Fix memory leak in dual/target mode
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix system crash in qlt_plogi_ack_unref
>
> Giridhar Malavali <giridhar.malavali@cavium.com>
>     scsi: qla2xxx: Remove aborting ELS IOCB call issued as part of timeout.
>
> Giridhar Malavali <giridhar.malavali@cavium.com>
>     scsi: qla2xxx: Defer processing of GS IOCB calls
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Clear loop id after delete
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix scan state field for fcport
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Replace fcport alloc with qla2x00_alloc_fcport
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix abort command deadlock due to spinlock
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix PRLI state check
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix Relogin being triggered too fast
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Relogin to target port on a cable swap
>
> Sawan Chandak <sawan.chandak@cavium.com>
>     scsi: qla2xxx: Fix NPIV host cleanup in target mode
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix login state machine stuck at GPDB
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Serialize GPNID for multiple RSCN
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Retry switch command on time out
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix re-login for Nport Handle in use
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Skip IRQ affinity for Target QPairs
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Move session delete to driver work queue
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix gpnid error processing
>
> Quinn Tran <quinn.tran@cavium.com>
>     scsi: qla2xxx: Fix system crash for Notify ack timeout handling
>
> Prarit Bhargava <prarit@redhat.com>
>     x86/xen: Calculate __max_logical_packages on PV domains
>
> Javier Martinez Canillas <javierm@redhat.com>
>     tpm: only attempt to disable the LPC CLKRUN if is already enabled
>
> Arnd Bergmann <arnd@arndb.de>
>     tpm: remove unused variables
>
> Javier Martinez Canillas <javierm@redhat.com>
>     tpm: delete the TPM_TIS_CLK_ENABLE flag
>
> Azhar Shaikh <azhar.shaikh@intel.com>
>     tpm: Keep CLKRUN enabled throughout the duration of transmit_cmd()
>
> Azhar Shaikh <azhar.shaikh@intel.com>
>     tpm_tis: Move ilb_base_addr to tpm_tis_data
>
> Eric Dumazet <edumazet@google.com>
>     netfilter: use skb_to_full_sk in ip6_route_me_harder
>
> Florian Westphal <fw@strlen.de>
>     netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt
>
> Florian Westphal <fw@strlen.de>
>     netfilter: bridge: ebt_among: add missing match size checks
>
> Florian Westphal <fw@strlen.de>
>     netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets
>
> Eric Dumazet <edumazet@google.com>
>     netfilter: IDLETIMER: be syzkaller friendly
>
> Paolo Abeni <pabeni@redhat.com>
>     netfilter: nat: cope with negative port range
>
> Paolo Abeni <pabeni@redhat.com>
>     netfilter: x_tables: fix missing timer initialization in xt_LED
>
> Eric Dumazet <edumazet@google.com>
>     netfilter: xt_hashlimit: fix lock imbalance
>
> Cong Wang <xiyou.wangcong@gmail.com>
>     netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation
>
> Florian Westphal <fw@strlen.de>
>     netfilter: add back stackpointer size checks
>
> Jerry Hoemann <jerry.hoemann@hpe.com>
>     watchdog: hpwdt: Remove legacy NMI sourcing.
>
> Arnd Bergmann <arnd@arndb.de>
>     watchdog: hpwdt: fix unused variable warning
>
> Jerry Hoemann <jerry.hoemann@hpe.com>
>     watchdog: hpwdt: Check source of NMI
>
> Jerry Hoemann <jerry.hoemann@hpe.com>
>     watchdog: hpwdt: SMBIOS check
>
> Francis Deslauriers <francis.deslauriers@efficios.com>
>     x86/kprobes: Fix kernel crash when probing .entry_trampoline code
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     objtool: Fix 32-bit build
>
> Josh Poimboeuf <jpoimboe@redhat.com>
>     objtool: Fix another switch table detection issue
>
> Peter Zijlstra <peterz@infradead.org>
>     objtool, retpolines: Integrate objtool with retpoline support more closely
>
> Peter Zijlstra <peterz@infradead.org>
>     objtool: Add module specific retpoline rules
>
> Peter Zijlstra <peterz@infradead.org>
>     objtool: Add retpoline validation
>
> Peter Zijlstra <peterz@infradead.org>
>     objtool: Use existing global variables for options
>
> Peter Zijlstra <peterz@infradead.org>
>     x86/mm/sme, objtool: Annotate indirect call in sme_encrypt_execute()
>
> Peter Zijlstra <peterz@infradead.org>
>     x86/boot, objtool: Annotate indirect jump in secondary_startup_64()
>
> Peter Zijlstra <peterz@infradead.org>
>     x86/paravirt, objtool: Annotate indirect calls
>
> Ingo Molnar <mingo@kernel.org>
>     x86/speculation: Move firmware_restrict_branch_speculation_*() from C to CPP
>
> Peter Zijlstra <peterz@infradead.org>
>     x86/speculation, objtool: Annotate indirect calls/jumps for objtool
>
> David Woodhouse <dwmw@amazon.co.uk>
>     x86/retpoline: Support retpoline builds with Clang
>
> David Woodhouse <dwmw@amazon.co.uk>
>     x86/speculation: Use IBRS if available before calling into firmware
>
> David Woodhouse <dwmw@amazon.co.uk>
>     Revert "x86/retpoline: Simplify vmexit_fill_RSB()"
>
> Jan Beulich <JBeulich@suse.com>
>     x86-64/realmode: Add instruction suffix
>
> Jan Beulich <JBeulich@suse.com>
>     x86/LDT: Avoid warning in 32-bit builds with older gcc
>
> Jan Beulich <JBeulich@suse.com>
>     x86/IO-APIC: Avoid warning in 32-bit builds
>
> Jan Beulich <JBeulich@suse.com>
>     x86/asm: Improve how GEN_*_SUFFIXED_RMWcc() specify clobbers
>
> Jann Horn <jannh@google.com>
>     x86/mm: Remove stale comment about KMEMCHECK
>
> Dominik Brodowski <linux@dominikbrodowski.net>
>     x86/entry/64: Use 'xorl' for faster register clearing
>
> Dominik Brodowski <linux@dominikbrodowski.net>
>     x86/entry: Reduce the code footprint of the 'idtentry' macro
>
> Dan Williams <dan.j.williams@intel.com>
>     nospec: Include <asm/barrier.h> dependency
>
> Dan Williams <dan.j.williams@intel.com>
>     nospec: Kill array_index_nospec_mask_check()
>
> Paul Burton <paul.burton@mips.com>
>     MIPS: CPC: Map registers using DT in mips_cpc_default_phys_base()
>
> Paul Burton <paul.burton@mips.com>
>     dt-bindings: Document mti,mips-cpc binding
>
> himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
>     scsi: qla2xxx: Fix recursion while sending terminate exchange
>
> himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
>     scsi: qla2xxx: Fix NULL pointer crash due to probe failure
>
> Dennis Wassenberg <dennis.wassenberg@secunet.com>
>     ALSA: hda: add dock and led support for HP ProBook 640 G2
>
> Dennis Wassenberg <dennis.wassenberg@secunet.com>
>     ALSA: hda: add dock and led support for HP EliteBook 820 G3
>
> Hui Wang <hui.wang@canonical.com>
>     ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: seq: More protection for concurrent write and ioctl races
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: seq: Don't allow resizing pool in use
>
> Dennis Wassenberg <dennis.wassenberg@secunet.com>
>     ALSA: hda/realtek - Make dock sound work on ThinkPad L570
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: hda/realtek - Fix dock line-out volume on Dell Precision 7520
>
> Benjamin Berg <bberg@redhat.com>
>     ALSA: hda/realtek: Limit mic boost on T480
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - Add headset mode support for Dell laptop
>
> Kailang Yang <kailang@realtek.com>
>     ALSA: hda/realtek - Add support headset mode for DELL WYSE
>
> Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>     x86/spectre_v2: Don't check microcode versions when running under hypervisors
>
> Adrian Hunter <adrian.hunter@intel.com>
>     perf tools: Fix trigger class trigger_on()
>
> Seunghun Han <kkamagui@gmail.com>
>     x86/MCE: Serialize sysfs changes
>
> Tony Luck <tony.luck@intel.com>
>     x86/MCE: Save microcode revision in machine check records
>
> Michael Lyle <mlyle@lyle.org>
>     bcache: don't attach backing with duplicate UUID
>
> Tang Junhui <tang.junhui@zte.com.cn>
>     bcache: fix crashes in duplicate cache device register
>
> Sergey Gorenko <sergeygo@mellanox.com>
>     IB/mlx5: Fix incorrect size of klms in the memory region
>
> Arnd Bergmann <arnd@arndb.de>
>     dm bufio: avoid false-positive Wmaybe-uninitialized warning
>
> James Hogan <jhogan@kernel.org>
>     kbuild: Handle builtin dtb file names containing hyphens
>
> Christoph Hellwig <hch@lst.de>
>     Revert "nvme: create 'slaves' and 'holders' entries for hidden controllers"
>
> Parav Pandit <parav@mellanox.com>
>     IB/core: Fix missing RDMA cgroups release in case of failure to register device
>
> Ard Biesheuvel <ard.biesheuvel@linaro.org>
>     arm64: mm: fix thinko in non-global page table attribute check
>
> David Hildenbrand <david@redhat.com>
>     KVM: s390: fix memory overwrites when not using SCA entries
>
> Tiwei Bie <tiwei.bie@intel.com>
>     virtio_ring: fix num_free handling in error case
>
> Ross Zwisler <ross.zwisler@linux.intel.com>
>     loop: Fix lost writes caused by missing flag
>
> Matthew Wilcox <mawilcox@microsoft.com>
>     Documentation/sphinx: Fix Directive import error
>
> Daniel Vacek <neelx@redhat.com>
>     mm/page_alloc: fix memmap_init_zone pageblock alignment


On 4.14 and 4.15, this patch breaks booting on dragonboard 410c and
hikey 620 (both arm64). The fix has been proposed and tested but is not
yet in mainline per https://lkml.org/lkml/2018/3/12/710

A new fix proposed by Daniel is under review,
mm/page_alloc: fix boot hang in memmap_init_zone
https://lkml.org/lkml/2018/3/13/1422
