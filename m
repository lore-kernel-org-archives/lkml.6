Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81694C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03FA82238A
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 13:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpwR1LS2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03FA82238A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751986AbeFXNgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 09:36:10 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:38252 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751790AbeFXNgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 09:36:08 -0400
Received: by mail-qt0-f170.google.com with SMTP id e11-v6so9277694qtp.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:subject:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=7lPO+1aGDew0EEv5HE21WTMju93xe35XYuGSjilJVS4=;
        b=YpwR1LS2sCw+yOodqGPsn3Am/+WOpB06SFJJyyI9p+JKvJAMREP5b+RbOFtjadd+fO
         Ka7i8SbyOaoRcQn4iBMI4qf/1siGLgso1pumMUEikGCo8+gJEFreyJj4paW13Cae3JAA
         2Sahi1Z8xP+J4QYNIetgJ9qMV6+A5feNMkruntJW9tiRuKjHVySzLNyoYPcRZEmwMDak
         jjcwSekjdpuIlBMrGlMX2j4uywQDuHf7KBKHBhJcTV/iqvdNfW81K8/4A0pp14doKECf
         AaEeocAV4bPtgNdH6vrKJ49EumqFBkce/qK7IOlceTNg3wXpeytTrZNFerTaGj7cpp7F
         71MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:subject:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=7lPO+1aGDew0EEv5HE21WTMju93xe35XYuGSjilJVS4=;
        b=W9etEJL6xO9X7K2kw+Lz7w7gKOroSPALXtOFKs2dpeUhWHVTZa1nwWjVBH6gEQSY1U
         A3xf/gpgEh93Wb9YGhOrnWvQI5fGa6kEvrFFMFaOyjfz/zvMoDJmKmi/nKbQuexAtcsa
         JKUUIbWZCk0vXGkAzupyNom/PnRmDwh6fS6Y5fg66BgLC6lycpKWVE0Yc3/y+1/PptPw
         4gFSdwS9XT4/hC09DrnSmq4YprIh6PPuVUtCzHtvDPkxN+T37ZBizOBLaBukdiZzRSlH
         S8IiYK9oqglAtzWjEv4vZQgVX43cIqOrZJxR31l9F7B90mYUqLuY03vhHK9YifhNeXPk
         C0wg==
X-Gm-Message-State: APt69E3dKXE+NBlPuzb13kJtRpb5L41hfD+XI33VQePWS4Db3OwTLZ9k
        sO/jOLanBvoS/4ZZhIoeRPUAftDo
X-Google-Smtp-Source: ADUXVKKcdHLLS98jbQNmN1SAIf9dAMcFFdo+yBCCTwkvRLRqYNgOGk2Q7kkgEoCtY/ZFBuQCUZR6lA==
X-Received: by 2002:ac8:21fd:: with SMTP id 58-v6mr7599416qtz.246.1529847367145;
        Sun, 24 Jun 2018 06:36:07 -0700 (PDT)
Received: from xps13 ([172.56.30.46])
        by smtp.gmail.com with ESMTPSA id e11-v6sm8627187qkb.4.2018.06.24.06.36.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 06:36:06 -0700 (PDT)
Date:   Sun, 24 Jun 2018 21:35:59 +0800 (CST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 4.18-rc2
Message-ID: <alpine.LFD.2.21.999.1806242116240.20621@xps13.linux-foundation.org>
User-Agent: Alpine 2.21.999 (LFD 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Another week, another -rc.

I'm still traveling - now in China - but at least I'm doing this rc Sunday 
_evening_ local time rather than _morning_. And next rc I'll be back home 
and over rmy jetlag (knock wood) so everything should be back to the 
traditional schedule.

Anyway, it's early in the rc series yet, but things look fairly normal. 
About a third of the patch is drivers (drm and s390 stand out, but here's 
networking and block updates too, and misc noise all over).

We also had some of the core dma files move from drivers/base/dma-* (and 
lib/dma-*) to kernel/dma/*. We sometimes do code movement (and other 
"renaming" things) after the merge window simply because it tends to be 
less disruptive that way.

Another 20% is under "tools" - mainly due to some selftest updates for 
rseq, but there's some turbostat and perf tooling work too.

We also had some noticeable filesystem updates, particularly to cifs. I'm 
going to point those out, because some of them probably shouldn't have 
been in rc2. They were "fixes" not in the "regressions" sense, but in the 
"missing features" sense.

So please, people, the "fixes" during the rc series really should be 
things that are _regressions_. If it used to work, and it no longer does, 
then fixing that is a good and proper fix. Or if something oopses or has a 
security implication, then the fix for that is a real fix.

But if it's something that has never worked, even if it "fixes" some 
behavior, then it's new development, and that should come in during the 
merge window. Just because you think it's a "fix" doesn't mean that it 
really is one, at least in the "during the rc series" sense.

Anyway, with that small rant out of the way, the rest is mostly arch 
updates (x86, powerpc, arm64, mips), and core networking.

Go forth and test. Things look fairly sane, it's not really all that 
scary.

Shortlog appended for people who want to scan through what changed.

              Linus

---

Anders Roxell (1):
      selftests: bpf: config: add config fragments

Andrew Morton (1):
      revert "mm/memblock: add missing include <linux/bootmem.h>"

Andrzej Hajda (2):
      drm/bridge/sii8620: simplify hardware reset procedure
      drm/bridge/sii8620: fix loops in EDID fetch logic

Andy Lutomirski (1):
      MAINTAINERS: Add me as an x86 entry code maintainer

Aneesh Kumar K.V (1):
      powerpc/mm/hash/4k: Free hugetlb page table caches correctly.

Anna Schumaker (1):
      NFS: Fix an rcu deadlock in nfs_delegation_find_inode()

Anna-Maria Gleixner (2):
      atomic: Add irqsave variant of atomic_dec_and_lock()
      locking/refcounts: Implement refcount_dec_and_lock_irqsave()

Ard Biesheuvel (2):
      KVM: arm/arm64: Drop resource size check for GICV window
      efi/x86: Fix incorrect invocation of PciIo->Attributes()

Arnaldo Carvalho de Melo (4):
      perf hists: Save the callchain_size in struct hist_entry
      perf hists: Make hist_entry__has_callchains() work with 'perf c2c'
      perf hists browser gtk: Use hist_entry__has_callchains()
      perf hists: Reimplement hists__has_callchains()

Arnd Bergmann (2):
      posix-timers: Fix nanosleep_copyout() for CONFIG_COMPAT_32BIT_TIME
      ptp: replace getnstimeofday64() with ktime_get_real_ts64()

Aurelien Aptel (5):
      CIFS: move default port definitions to cifsglob.h
      CIFS: complete PDU definitions for interface queries
      CIFS: add iface info to struct cifs_ses
      CIFS: parse and store info on iface queries
      CIFS: dump every session iface info

Bart Van Assche (2):
      Revert "block: Add warning for bi_next not NULL in bio_endio()"
      blk-mq: Fix timeout handling in case the timeout handler returns BLK_EH_DONE

Bartosz Golaszewski (1):
      net: ethernet: fix suspend/resume in davinci_emac

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: cursors always use core channel vram ctxdma

Bhadram Varka (1):
      stmmac: fix DMA channel hang in half-duplex mode

Bharat Potnuri (1):
      RDMA/core: Save kernel caller name when creating CQ using ib_create_cq()

Björn Töpel (1):
      xsk: re-add queue id check for XDP_SKB path

Boris Ostrovsky (1):
      xen: Remove unnecessary BUG_ON from __unbind_from_irq()

Borislav Petkov (1):
      x86/mce: Do not overwrite MCi_STATUS in mce_no_way_out()

Brian Norris (1):
      ACPI / processor: Finish making acpi_processor_ppc_has_changed() void

Chengguang Xu (1):
      ext2: add warning when specifying nocheck option

Chris Wilson (2):
      drm/i915: Apply batch location restrictions before pinning
      drm/i915/execlists: Avoid putting the error pointer

Christoph Hellwig (3):
      dma-mapping: use obj-y instead of lib-y for generic dma ops
      dma-mapping: move all DMA mapping code to kernel/dma
      block: fix timeout changes for legacy request drivers

Christophe Jaillet (1):
      IB/mlx4: Fix an error handling path in 'mlx4_ib_rereg_user_mr()'

Chuck Lever (1):
      sunrpc: Prevent duplicate XID allocation

Colin Ian King (1):
      pinctrl: single: Add allocation failure checking of saved_vals

Dan Carpenter (3):
      crypto: chtls - use after free in chtls_pt_recvmsg()
      blk-mq-debugfs: Off by one in blk_mq_rq_state_name()
      block: sed-opal: Fix a couple off by one bugs

Dan Williams (1):
      x86/spectre_v1: Disable compiler optimizations over array_index_mask_nospec()

Daniel Borkmann (3):
      bpf: fix panic in prog load calls cleanup
      bpf: reject any prog that failed read-only lock
      bpf, xdp, i40e: fix i40e_build_skb skb reserve and truesize

Daniel Lezcano (1):
      net/usb/drivers: Remove useless hrtimer_active check

Dave Martin (3):
      KVM: arm64: Don't mask softirq with IRQs disabled in vcpu_put()
      KVM: arm64/sve: Fix SVE trap restoration for non-current tasks
      KVM: arm64: Avoid mistaken attempts to save SVE state for vcpus

David Ahern (1):
      net/tcp: Fix socket lookups with SO_BINDTODEVICE

David S. Miller (1):
      bluetooth: hci_nokia: Don't include linux/unaligned/le_struct.h directly.

David Woodhouse (1):
      atm: Preserve value of skb->truesize when accounting to vcc

Davide Caratti (2):
      net/sched: act_ife: fix recursive lock and idr leak
      net/sched: act_ife: preserve the action control in case of error

Dinh Nguyen (1):
      net: stmmac: socfpga: add additional ocp reset line for Stratix10

Dmitry Vyukov (1):
      crypto: don't optimize keccakf()

Dong Jia Shi (4):
      vfio: ccw: fix error return in vfio_ccw_sch_event
      vfio: ccw: shorten kernel doc description for pfn_array_pin()
      vfio: ccw: refactor and improve pfn_array_alloc_pin()
      vfio: ccw: set ccw->cda to NULL defensively

Doron Roberts-Kedes (1):
      nbd: Add the nbd NBD_DISCONNECT_ON_CLOSE config flag.

Eric Dumazet (2):
      net/ipv6: respect rcu grace period before freeing fib6_info
      net: sungem: fix rx checksum support

Even Xu (1):
      HID: intel_ish-hid: ipc: register more pm callbacks to support hibernation

Fabio Estevam (1):
      pinctrl: devicetree: Fix pctldev pointer overwrite

Fathi Boudra (1):
      selftests: sync: add config fragment for testing sync framework

Geert Uytterhoeven (4):
      pinctrl: actions: Fix uninitialized error in owl_pin_config_set()
      time: Make sure jiffies_to_msecs() preserves non-zero time periods
      MAINTAINERS: Add file patterns for x86 device tree bindings
      lightnvm: Remove depends on HAS_DMA in case of platform dependency

Govindarajulu Varadarajan (2):
      enic: initialize enic->rfs_h.lock in enic_probe
      enic: do not overwrite error code

Greg Thelen (2):
      quota: reclaim least recently used dquots
      tracing: Fix SKIP_STACK_VALIDATION=1 build due to bad merge with -mrecord-mcount

Guenter Roeck (1):
      hwmon: (nct6775) Fix loop limit

Gustavo A. R. Silva (2):
      IB/mlx5: Fix memory leak in mlx5_ib_create_flow
      tracing: Use swap macro in update_max_tr

Halil Pasic (2):
      vfio: ccw: push down unsupported IDA check
      vfio: ccw: add tracepoints for interesting error paths

Hans de Goede (1):
      efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode

Harald Freudenberger (1):
      s390/archrandom: Rework arch random implementation.

Harry Wentland (1):
      drm/amdgpu: Don't default to DC support for Kaveri and older

Helge Eichelberg (1):
      hwmon: (dell-smm) Disable fan support for Dell XPS13 9333

Huacai Chen (1):
      MIPS: io: Add barrier after register read in inX()

Ilia Lin (2):
      cpufreq: kryo: Fix possible error code dereference
      cpufreq: kryo: Add module remove and exit

Israel Rukshin (1):
      nvme-rdma: Fix command completion race at error recovery

Jakub Kicinski (2):
      tools: bpftool: improve accuracy of load time
      selftests/bpf: test offloads even with BPF programs present

James Smart (1):
      nvme-fc: release io queues to allow fast fail

James Zhu (1):
      drm/amdgpu:All UVD instances share one idle_work handle

Jan Kara (5):
      quota: Cleanup list iteration in dqcache_shrink_scan()
      udf: Detect incorrect directory size
      udf: Provide function for calculating dir entry length
      udf: Drop unused arguments of udf_delete_aext()
      bdi: Fix another oops in wb_workfn()

Jason Gerecke (1):
      HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large

Jason Gunthorpe (1):
      IB/uverbs: Fix ordering of ucontext check in ib_uverbs_write

Jens Axboe (1):
      nvme-pci: limit max IO size and segments to avoid high order allocations

Jeremy Cline (1):
      drm/qxl: Call qxl_bo_unref outside atomic context

Jia He (2):
      crypto: arm64/aes-blk - fix and move skcipher_walk_done out of kernel_neon_begin, _end
      KVM: arm/arm64: add WARN_ON if size is not PAGE_SIZE aligned in unmap_stage2_range

Jian Wang (1):
      bpf, selftest: check tunnel type more accurately

Jianchao Wang (1):
      nvme-pci: move nvme_kill_queues to nvme_remove_dead_ctrl

Jiri Kosina (1):
      x86/pti: Don't report XenPV as vulnerable

Jiri Olsa (7):
      perf tools: Fix error index for pmu event parser
      perf stat: Add --interval-clear option
      perf stat: Use only color_fprintf call in print_metric_only
      perf stat: Fix metric column header display alignment
      perf stat: Allow to specify specific metric column len
      perf stat: Add event parsing error handling to add_default_attributes
      perf c2c: Keep struct hist_entry at the end of struct c2c_hist_entry

Joel Fernandes (Google) (2):
      softirq: Reorder trace_softirqs_on to prevent lockdep splat
      tracing: Fix some errors in histogram documentation

Joel Stanley (4):
      net/ncsi: Silence debug messages
      net/ncsi: Drop no more channels message
      net/ncsi: Use netdev_dbg for debug messages
      MAINTAINERS: Add Sam as the maintainer for NCSI

John Garry (1):
      irqdesc: Delete irq_desc_get_msi_desc()

Josh Poimboeuf (1):
      objtool: Add machine_real_restart() to the noreturn list

Juergen Gross (2):
      x86/xen: Add call of speculative_store_bypass_ht_init() to PV paths
      xen: add new hypercall buffer mapping device

Julia Lawall (1):
      clocksource/drivers/stm32: Fix error return code

Kalderon, Michal (1):
      RDMA/qedr: Fix NULL pointer dereference when running over iWARP without RDMA-CM

Kenneth Graunke (1):
      drm/i915: Enable provoking vertex fix on Gen9 systems.

Kirill A. Shutemov (2):
      Revert "x86/mm: Mark __pgtable_l5_enabled __initdata"
      x86/mm: Fix 'no5lvl' handling

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Len Brown (4):
      tools/power turbostat: fix show/hide issues resulting from mis-merge
      tools/power turbostat: decode cpuid.1.HT
      tools/power turbostat: add optional APIC X2APIC columns
      tools/power turbostat: version 18.06.20

Li RongQing (1):
      net: propagate dev_get_valid_name return code

Linus Torvalds (2):
      proc: fix missing final NUL in get_mm_cmdline() rewrite
      Linux 4.18-rc2

Linus Walleij (1):
      MIPS: pb44: Fix i2c-gpio GPIO descriptor table

Liran Alon (1):
      net: net_failover: fix typo in net_failover_slave_register()

Maciej Purski (6):
      drm/bridge/sii8620: fix display modes validation
      drm/bridge/sii8620: fix potential buffer overflow
      drm/bridge/sii8620: start MHL transmission after HDMI signal detection
      drm/bridge/sii8620: remove HSIC initialization
      drm/bridge/sii8620: fix HDMI cable connection to dongle
      drm/bridge/sii8620: fix display of packed pixel modes in MHL2

Marc Orr (1):
      kvm: vmx: Nested VM-entry prereqs for event inj.

Marc Zyngier (8):
      KVM: Enforce error in ioctl for compat tasks when !KVM_COMPAT
      KVM: arm64: Prevent KVM_COMPAT from being selected
      genirq/debugfs: Add missing IRQCHIP_SUPPORTS_LEVEL_MSI debug
      irqchip/ls-scfg-msi: Fix MSI affinity handling
      irqchip/gic-v2m: Fix SPI release on error path
      irqchip/gic-v3-its: Only emit SYNC if targetting a valid collection
      irqchip/gic-v3-its: Only emit VSYNC if targetting a valid collection
      irqchip/gic-v3-its: Fix reprogramming of redistributors on CPU hotplug

Marek Szyprowski (1):
      arm64: dma-mapping: clear buffers allocated with FORCE_CONTIGUOUS flag

Mark Rutland (1):
      arm64: Introduce sysreg_clear_set()

Masahiro Yamada (2):
      Revert "kexec/purgatory: Add clean-up for purgatory directory"
      x86/build: Remove unnecessary preparation for purgatory

Mathieu Desnoyers (3):
      rseq/selftests: Make run_param_test.sh executable
      rseq/selftests/arm: Align 'struct rseq_cs' on 32 bytes
      rseq/cleanup: Do not abort rseq c.s. in child on fork()

Mathieu Malaterre (1):
      perf/core: Move the inline keyword at the beginning of the function declaration

Matteo Croce (2):
      bpfilter: fix build error
      bpfilter: ignore binary files

Matthias Schiffer (1):
      mips: ftrace: fix static function graph tracing

Max Gurtuvoy (1):
      nvmet: reset keep alive timer in controller enable

Michael Buesch (1):
      hwrng: core - Always drop the RNG in hwrng_unregister()

Michael Ellerman (2):
      powerpc/64s: Fix DT CPU features Power9 DD2.1 logic
      powerpc/64s: Fix build failures with CONFIG_NMI_IPI=n

Michael Jeanson (1):
      powerpc/e500mc: Set assembler machine type to e500mc

Michel Dänzer (4):
      drm/amdgpu: Use kvmalloc_array for allocating VRAM manager nodes array
      drm/amdgpu: Update pin_size values before unpinning BO
      drm/amdgpu: Refactor amdgpu_vram_mgr_bo_invisible_size helper
      drm/amdgpu: Make amdgpu_vram_mgr_bo_invisible_size always accurate

Mika Kuoppala (1):
      drm/i915: Fix context ban and hang accounting for client

Mika Westerberg (1):
      ACPI / EC: Use ec_no_wakeup on Thinkpad X1 Carbon 6th

Nathan Ciobanu (4):
      tools/power turbostat: fix segfault on 'no node' machines
      tools/power turbostat: alphabetize the help output
      tools/power turbostat: add single character tokens to help
      tools/power turbostat: add the missing command line switches

Nicholas Piggin (5):
      powerpc/64s/radix: Fix MADV_[FREE|DONTNEED] TLB flush miss problem with THP
      powerpc/64: hard disable irqs in panic_smp_self_stop
      powerpc: smp_send_stop do not offline stopped CPUs
      powerpc/64: hard disable irqs on the panic()ing CPU
      powerpc/64s/radix: Fix radix_kvm_prefetch_workaround paca access of not possible CPU

Nicolas Boichat (1):
      HID: google: Add support for whiskers

Oleg Nesterov (1):
      uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Oleksandr Andrushchenko (2):
      drm: Fix possible race conditions while unplugging DRM device
      xen/grant-table: Export gnttab_{alloc|free}_pages as GPL

Ondrej Mosnáček (1):
      crypto: morus640 - Fix out-of-bounds access

Paul Burton (5):
      MIPS: Add support for restartable sequences
      MIPS: Add syscall detection for restartable sequences
      MIPS: Wire up the restartable sequences (rseq) syscall
      rseq/selftests: Implement MIPS support
      MIPS: Wire up io_pgetevents syscall

Paul Kocialkowski (1):
      Revert "drm/sun4i: Handle DRM_BUS_FLAG_PIXDATA_*EDGE"

Paulo Alcantara (4):
      cifs: Fix encryption/signing
      cifs: Fix kernel oops when traceSMB is enabled
      cifs: Use correct packet length in SMB2_TRANSFORM header
      cifs: Fix invalid check in __cifs_calc_signature()

Rafael J. Wysocki (3):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from S3
      PM / core: Fix supplier device runtime PM usage counter imbalance
      Documentation: intel_pstate: Fix typo

Rajan Vaja (1):
      drm/amd/pp: Fix uninitialized variable

Randy Dunlap (1):
      Fix Documentation build due to rename of main.c to mtrr.c

Rodrigo Rivas Costa (1):
      HID: steam: use hid_device.driver_data instead of hid_set_drvdata()

Roger Pau Monne (1):
      xen: share start flags between PV and PVH

Ronnie Sahlberg (4):
      cifs: add lease tracking to the cached root fid
      cifs: push rfc1002 generation down the stack
      cifs: remove smb2_send_recv()
      cifs: update __smb_send_rqst() to take an array of requests

Sagi Grimberg (3):
      nvme-rdma: fix possible double free condition when failing to create a controller
      nvme-rdma: fix possible free of a non-allocated async event buffer
      nvme-rdma: don't override opts->queue_size

Sean Wang (1):
      pinctrl: mt7622: fix a kernel panic when pio don't work as EINT controller

Sebastian Andrzej Siewior (2):
      posix-cpu-timers: Remove lockdep_assert_irqs_disabled()
      alpha: Remove custom dec_and_lock() implementation

Sebastian Ott (6):
      s390/cio: sanitize css_general_characteristics definition
      s390/dasd: simplify locking in process_final_queue
      s390/dasd: move dasd_ccw_req to per request data
      s390/dasd: remove dasd_kmalloc_set_cda
      s390/dasd: reshuffle struct dasd_ccw_req
      s390/dasd: only use preallocated requests

Seeteena Thoufeek (1):
      perf script: Show hw-cache events

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Shuah Khan (Samsung OSG) (9):
      selftests: pstore: return Kselftest Skip code for skipped tests
      selftests: static_keys: return Kselftest Skip code for skipped tests
      selftests: sysctl: return Kselftest Skip code for skipped tests
      selftests: user: return Kselftest Skip code for skipped tests
      selftests: zram: return Kselftest Skip code for skipped tests
      selftests: vm: return Kselftest Skip code for skipped tests
      selftests: sparc64: Fix to do nothing on non-sparc64
      selftests: sparc64: delete RUN_TESTS and EMIT_TESTS overrides
      selftests: sparc64: Add missing SPDX License Identifiers

Siarhei Liakh (1):
      x86: Call fixup_exception() before notify_die() in math_error()

Simon Glass (1):
      firmware: dmi: Add access to the SKU ID string

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Fix scaling max/min limits with Turbo 3.0

Stefan Agner (2):
      drm/atmel-hlcdc: check stride values in the first plane
      net: hamradio: use eth_broadcast_addr

Steve French (6):
      smb3: note that smb3.11 posix extensions mount option is experimental
      cifs: minor documentation updates
      smb3: increase initial number of credits requested to allow write
      smb3: Fix mode on mkdir on smb311 mounts
      smb3: do not display empty interface list
      smb3: fix corrupt path in subdirs on smb311 with posix

Steven Rostedt (VMware) (3):
      locking/lockdep: Do not record IRQ state within lockdep code
      tracing: Check for no filter when processing event filters
      locking/qspinlock: Fix build for anonymous union in older GCC compilers

Sudarsana Reddy Kalluru (3):
      qed: Fix possible memory leak in Rx error path handling.
      qed: Add sanity check for SIMD fastpath handler.
      qed: Do not advertise DCBX_LLD_MANAGED capability.

Suravee Suthikulpanit (1):
      x86/CPU/AMD: Fix LLC ID bit-shift calculation

Tokunori Ikegami (1):
      MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum

Tony Luck (3):
      x86/mce: Improve error message when kernel cannot recover
      x86/mce: Check for alternate indication of machine check recovery on Skylake
      x86/mce: Fix incorrect "Machine check from unknown source" message

Toshiaki Makita (1):
      xdp: Fix handling of devmap in generic XDP

Trond Myklebust (4):
      pNFS: Always free the session slot on error in nfs4_layoutget_handle_exception
      pNFS: Don't send layoutreturn if the layout is already invalid
      pNFS/flexfiles: Don't tie up all the rpciod threads in resends
      pNFS/flexfiles: Process writeback resends from nfsiod context as well

Ursula Braun (1):
      s390/net: add pnetid support

Vijay Immanuel (1):
      IB/rxe: Fix missing completion for mem_reg work requests

Ville Syrjälä (4):
      drm/i915: Allow DBLSCAN user modes with eDP/LVDS/DSI
      drm/i915: Fix PIPESTAT irq ack on i965/g4x
      drm/i915: Disallow interlaced modes on g4x DP outputs
      drm/i915: Turn off g4x DP port in .post_disable()

Vitaly Kuznetsov (1):
      KVM: fix KVM_CAP_HYPERV_TLBFLUSH paragraph number

Waiman Long (1):
      locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS

Waldemar Rymarkiewicz (1):
      PM / OPP: Update voltage in case freq == old_freq

Wei Wang (1):
      kernel.h: Fix a typo in comment

Wei Yongjun (1):
      pinctrl: mediatek: remove redundant return value check of platform_get_resource()

Will Deacon (3):
      arm64: kpti: Use early_param for kpti= command-line option
      arm64: mm: Ensure writes to swapper are ordered wrt subsequent cache maintenance
      rseq: Avoid infinite recursion when delivering SIGSEGV

Willem de Bruijn (1):
      ip: limit use of gso_size to udp

William Tu (1):
      bpf, selftests: delete xfrm tunnel when test exits.

Xin Long (1):
      ipvlan: use ETH_MAX_MTU as max mtu

Yang Yingliang (1):
      irqchip/gic-v3-its: Don't bind LPI to unavailable NUMA node

Yonghong Song (1):
      tools/bpftool: fix a bug in bpftool perf

Zhenzhong Duan (1):
      x86/microcode/intel: Fix memleak in save_microcode_patch()

Zhizhou Zhang (1):
      arm64: make secondary_start_kernel() notrace

Zhouyang Jia (3):
      xen: add error handling for xenbus_printf
      scsi: xen-scsifront: add error handling for xenbus_printf
      xen/scsiback: add error handling for xenbus_printf

Zhu Yanjun (1):
      IB/rxe: avoid double kfree skb

mike.travis@hpe.com (3):
      x86/platform/UV: Add adjustable set memory block size function
      x86/platform/UV: Use new set memory block size function
      x86/platform/UV: Add kernel parameter to set memory block size

weiyongjun (A) (1):
      IB/mlx5: Fix return value check in flow_counters_set_data()

