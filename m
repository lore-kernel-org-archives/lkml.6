Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCCC46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19E3B218DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 19:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EVztt3+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E3B218DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHEWEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:04:39 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:34560 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeHEWEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:04:38 -0400
Received: by mail-it0-f53.google.com with SMTP id d70-v6so10437295ith.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 12:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fwVpZ5c+xrBU4R2kjvZULlbQmc+lrjyhQUfc4kR5gNs=;
        b=EVztt3+2rJIgUeURqJho7KR3hqRK22amjR+of/zylsz8IJNdaPef3GyS9/7yNMKdCp
         eUhIv6KWCz8NkJaMjtVaVPTwN3z7BP1J46GNOzenEDuCY7UA3H6vHVr13VtnkF/RQGkK
         kgjkG9QlKcQFUPE6+MzjxKE+AbITpu6bOc8fo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fwVpZ5c+xrBU4R2kjvZULlbQmc+lrjyhQUfc4kR5gNs=;
        b=V2dR+v/d/eW7YFdFtYfNStC5HD80tXo+MDE7RicgYcKoFpgv7rymogsO7QnUhyQNv+
         3m6NG3D6zbzIDhMEPLaEdiyyhx0fKY7iBGY41A0P+HXlfFdp+yKW4jR+D4EiP4ScS4To
         kMK3O169w+qxgv31yj0H1sJmfNAJ26DbMISJC3AuAI83ToYsjwBix1uHG+r3tXuOG9CC
         2wr/qQnYZKHXrmDuhXtua6ln/twxutr/hwk4YcB8hRBfu/oIM+zTyM3gMoU4UxPVCKdZ
         dLxJgzBbj47FYgSYMZV69w7Eds8bLg6lMlbVuqy40px86Y+SQz+bJ5ZNyyhbDfDBur6+
         Hj7g==
X-Gm-Message-State: AOUpUlFVveW7wKmaGJKkjxpd+ekTvON0v7b12Je8m6bgpIRwUtIWKwTS
        yfVLSh0bAVGxy3xQdOoxpfjFhQNaHm8NdcuCJOmjZajS
X-Google-Smtp-Source: AAOMgpeDBNohMoxxwCM7aCwqTse2IPtMrZBlV5DcufnbRpTe+ws9S3fKNLr2anANsYezaw2mOzqgwDRlamaLCwSWMmc=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr12760632ite.1.1533499135130;
 Sun, 05 Aug 2018 12:58:55 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Aug 2018 12:58:44 -0700
Message-ID: <CA+55aFw49Bh9u3KvGsMbnSLfHvevpWPuqgrWQT0tC0XCajNwzA@mail.gmail.com>
Subject: Linux 4.18-rc8
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So as already mentioned a couple of times in some of the relevant
threads, this last week wasn't entirely painless, and 4.18 ended up
being one of those releases that gets an extra week of rc testing
before release.

The original impetus for this was the continued VM worries - although
it looks like we finally root-caused all the issues and got it all in
shape on Wednesday. Still, that is somewhat late, and merits another
rc for final testing.

That said, if it had been _only_ that silly VM issue that turned out
to not be so annoying as it could have been, I might have reconsidered
and done a final release anyway, but we had some last-minute
networking noise too, and there's actually a pending (old) VFS issue
too. So while I may prefer to keep our regular release cadence, but
this time around we are just going to see that extra week.

I realize that this may mess with people who had planned for the merge
window to start tomorrow - particularly the Europeans where August is
often peak vacation time. Never fear, you can send me your merge
window pull request next week as planned, and I'll just sit on it for
the extra week. So go off on your planned vacations.

Anyway, appended is the shortlog for the changes during the last week
- and despite the extra week, it's not really horrible. Over a quarter
of the patch is tooling updates, with some testing and tooling updates
for perf, turbostat and bpf.

On the actual kernel side, most of the (small) changes were to
drivers, with network drivers leading the way. There's also some core
networking changes, along with some minor arch updates.

And we've got the VM fixes. and misc noise elsewhere. See below for
the shortlog, or delve into the git repo for the nitty-gritty details.

                    Linus

---

Adi Nissim (1):
      net/mlx5e: Fix null pointer access when setting MTU of vport represen=
tor

Ananth N Mavinakayanahalli (1):
      MAINTAINERS: Add Naveen N. Rao as kprobes co-maintainer

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix SERDES support on 88E6141/6341

Andy Lutomirski (1):
      x86/entry/64: Remove %ebx handling from error_entry/exit

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Anton Vasilyev (2):
      net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
      can: ems_usb: Fix memory leak on ems_usb_disconnect()

Ard Biesheuvel (1):
      crypto/arm64: aes-ce-gcm - add missing kernel_neon_begin/end pair

Arjun Vynipadath (1):
      cxgb4: Added missing break in ndo_udp_tunnel_{add/del}

Arnaldo Carvalho de Melo (5):
      tools headers uapi: Update tools's copy of linux/perf_event.h
      tools headers powerpc: Update asm/unistd.h copy to pick new
      tools headers uapi: Refresh linux/bpf.h copy
      tools arch: Update arch/x86/lib/memcpy_64.S copy used in 'perf
bench mem memcpy'
      perf tools: Fix the build on the alpine:edge distro

Artem Bityutskiy (1):
      tools/power turbostat: fix bogus summary values

Avinash Repaka (1):
      RDS: RDMA: Fix the NULL-ptr deref in rds_ib_get_mr

Bj=C3=B6rn T=C3=B6pel (1):
      xsk: fix poll/POLLIN premature returns

Boris Brezillon (3):
      drm/atomic: Check old_plane_state->crtc in drm_atomic_helper_async_ch=
eck()
      drm/atomic: Initialize variables in
drm_atomic_helper_async_check() to make gcc happy
      drm/vc4: Reset ->{x, y}_scaling[1] when dealing with uniplanar format=
s

Brijesh Singh (1):
      x86/efi: Access EFI MMIO data as unencrypted when SEV is active

Calvin Walton (1):
      tools/power turbostat: Read extended processor family from CPUID

Colin Ian King (1):
      drivers: net: lmc: fix case value for target abort error

Dan Carpenter (1):
      PCI: mobiveil: Avoid integer overflow in IB_WIN_SIZE

Daniel Borkmann (1):
      bpf: fix bpf_skb_load_bytes_relative pkt length check

Daniel Bristot de Oliveira (1):
      sched/deadline: Update rq_clock of later_rq when pushing a task

David S. Miller (1):
      Revert "net/ipv6: fix metrics leak"

Dmitry Safonov (3):
      netlink: Do not subscribe to non-existent groups
      netlink: Don't shift with UB on nlk->ngroups
      netlink: Don't shift on 64 for ngroups

Eli Cohen (1):
      net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager

Emmanuel Grumbach (1):
      iwlwifi: add more card IDs for 9000 series

Eric Dumazet (4):
      xfrm_user: prevent leaking 2 bytes of kernel memory
      inet: frag: enforce memory limits earlier
      ipv4: frags: handle possible skb truesize change
      bonding: avoid lockdep confusion in bond_get_stats()

Eric Sandeen (1):
      fs: fix iomap_bmap position calculation

Erik Schmauss (1):
      ACPICA: AML Parser: ignore control method status in module-level code

Eugeniy Paltsev (4):
      ARC: dma [non IOC]: fix arc_dma_sync_single_for_(device|cpu)
      ARC: dma [non-IOC] setup SMP_CACHE_BYTES and cache_line_size
      NET: stmmac: align DMA stuff to largest cache line length
      ARC: add SMP_CACHE_BYTES value validate

Eyal Birger (1):
      vti6: fix PMTU caching and reporting on xmit

Feras Daoud (1):
      net/mlx5e: IPoIB, Set the netdevice sw mtu in ipoib enhanced flow

Florian Fainelli (1):
      net: dsa: Do not suspend/resume closed slave_dev

Florian Westphal (1):
      xfrm: free skb if nlsk pointer is NULL

Frederic Barrat (1):
      powerpc/64s/radix: Fix missing global invalidations when removing cop=
ro

Frederic Weisbecker (1):
      nohz: Fix missing tick reprogram when interrupting an inline softirq

Gal Pressman (1):
      net: ena: Fix use of uninitialized DMA address bits field

Govindarajulu Varadarajan (2):
      enic: handle mtu change for vf properly
      enic: do not call enic_change_mtu in enic_probe

Guillaume Nault (1):
      l2tp: fix missing refcount drop in pppol2tp_tunnel_ioctl()

Hailong Liu (1):
      sched/rt: Restore rt_runtime after disabling RT_RUNTIME_SHARE

Hari Vyas (1):
      PCI: Fix is_added/is_busmaster race condition

Herbert Xu (1):
      crypto: padlock-aes - Fix Nano workaround data corruption

Hugh Dickins (1):
      mm: delete historical BUG from zap_pmd_range()

Ioana Ciornei (1):
      Documentation: dpaa2: Use correct heading adornment

Isaac J. Manjarres (1):
      stop_machine: Disable preemption after queueing stopper threads

Jack Morgenstein (1):
      RDMA/uverbs: Expand primary and alt AV port checks

Jakub Kicinski (2):
      netdevsim: don't leak devlink resources
      net: xsk: don't return frames via the allocator on error

Jane Chu (1):
      ipc/shm.c add ->pagesize function to shm_vm_ops

Jeremy Cline (3):
      net: socket: fix potential spectre v1 gadget in socketcall
      net: socket: Fix potential spectre v1 gadget in sock_is_registered
      netlink: Fix spectre v1 gadget in netlink_create()

Jiang Biao (1):
      virtio_balloon: fix another race between migration and ballooning

John Hurley (1):
      nfp: flower: fix port metadata conversion bug

John Stultz (1):
      staging: ashmem: Fix SIGBUS crash when traversing mmaped ashmem pages

Jose Abreu (1):
      net: stmmac: Fix WoL for PCI-based setups

Justin Pettit (1):
      openvswitch: meter: Fix setting meter id for new entries

Kan Liang (1):
      perf/x86/intel/uncore: Fix hardcoded index of Broadwell extra PCI dev=
ices

Kees Cook (3):
      mmc: mxcmmc: Fix missing parentheses and brace
      x86/boot: Fix if_changed build flip/flop bug
      jfs: Fix usercopy whitelist for inline inode data

Kirill A. Shutemov (1):
      x86/boot/compressed/64: Validate trampoline placement against E820

Kirill Tkhai (1):
      memcg: remove memcg_cgroup::id from IDR on mem_cgroup_css_alloc() fai=
lure

Laurent Pinchart (1):
      media: v4l: vsp1: Fix deadlock in VSPDL DRM pipelines

Lawrence Brakmo (1):
      tcp: ack immediately when a cwr packet arrives

Len Brown (5):
      tools/power turbostat: Update turbostat(8) RAPL throttling
column description
      tools/power turbostat: fix -S on UP systems
      x86/apic: Future-proof the TSC_DEADLINE quirk for SKX
      tools/power turbostat: fix x2apic debug message output file
      tools/power turbostat: version 18.07.27

Leon Romanovsky (1):
      ARC: Add Ofer Levi as plat-eznps maintainer

Linus Torvalds (7):
      squashfs: more metadata hardening
      ia64: mark special ia64 memory areas anonymous
      squashfs metadata 2: electric boogaloo
      mm: do not initialize TLB stack vma's with vma_init()
      squashfs: more metadata hardening
      Partially revert "block: fail op_is_write() requests to
read-only partitions"
      Linux 4.18-rc8

Lorenzo Bianconi (1):
      ipv4: remove BUG_ON() from fib_compute_spec_dst

Maninder Singh (1):
      selftest/net: fix protocol family to work for IPv4.

Martin KaFai Lau (5):
      bpf: btf: Ensure the member->offset is in the right order
      bpf: btf: Sync uapi btf.h to tools
      bpf: Replace [u]int32_t and [u]int64_t in libbpf
      bpf: Introduce BPF_ANNOTATE_KV_PAIR
      bpf: btf: Use exact btf value_size match in map_check_btf()

Mathieu Poirier (1):
      perf/core: Fix crash when using HW tracing kernel filters

Mathieu Xhonneux (1):
      selftests/bpf: update test_lwt_seg6local.sh according to iproute2

Michael S. Tsirkin (2):
      tools/virtio: add dma barrier stubs
      tools/virtio: add kmalloc_array stub

Mike Rapoport (1):
      userfaultfd: remove uffd flags from vma->vm_flags if UFFD_EVENT_FORK =
fails

Ming Lei (1):
      blk-mq: fix blk_mq_tagset_busy_iter

Neal Cardwell (1):
      tcp_bbr: fix bw probing to raise in-flight data for very small BDPs

Nicholas Mc Guire (1):
      drm: re-enable error handling

Nir Dotan (4):
      mlxsw: core_acl_flex_actions: Return error for conflicting actions
      mlxsw: core_acl_flex_actions: Remove redundant resource destruction
      mlxsw: core_acl_flex_actions: Remove redundant counter destruction
      mlxsw: core_acl_flex_actions: Remove redundant mirror resource destru=
ction

Ofer Levi (1):
      ARC: [plat-eznps] Add missing struct nps_host_reg_aux_dpc

Or Gerlitz (1):
      net/mlx5e: Set port trust mode to PCP as default

Peter Rosin (2):
      locking/rtmutex: Allow specifying a subclass for nested locking
      i2c/mux, locking/core: Annotate the nested rt_mutex usage

Peter Zijlstra (1):
      perf/x86/intel: Fix unwind errors from PEBS entries (mk-II)

Phillip Lougher (1):
      Squashfs: Compute expected length from inode size rather than block l=
ength

Prarit Bhargava (1):
      tools/power turbostat: Fix logical node enumeration to allow for
non-sequential physical nodes

Quinn Tran (4):
      scsi: qla2xxx: Fix unintialized List head crash
      scsi: qla2xxx: Fix NPIV deletion by calling wait_for_sess_deletion
      scsi: qla2xxx: Fix driver unload by shutting down chip
      scsi: qla2xxx: Fix ISP recovery on unload

Rafael J. Wysocki (1):
      ACPI / LPSS: Avoid PM quirks on suspend and resume from hibernation

Rafa=C5=82 Mi=C5=82ecki (1):
      brcmfmac: fix regression in parsing NVRAM for multiple devices

Randy Dunlap (4):
      arc: [plat-eznps] fix data type errors in platform headers
      arc: [plat-eznps] fix printk warning in arc/plat-eznps/mtm.c
      arc: fix build errors in arc/include/asm/delay.h
      arc: fix type warnings in arc/mm/cache.c

Roman Kagan (1):
      kvm: x86: vmx: fix vpid leak

Sabrina Dubroca (1):
      net/ipv6: fix metrics leak

Sean Christopherson (1):
      KVM: vmx: use local variable for current_vmptr when emulating VMPTRST

Sean Paul (1):
      drm/bridge: adv7511: Reset registers on hotplug

Sean Young (3):
      media: rc: be less noisy when driver misbehaves
      media: bpf: ensure bpf program is freed on detach
      media: rc: read out of bounds if bpf reports high protocol number

Srinivas Pandruvada (1):
      cpufreq: intel_pstate: Limit the scope of HWP dynamic boost platforms

Stefan Wahren (1):
      net: lan78xx: fix rx handling before first packet is send

Steven Rostedt (VMware) (1):
      sparc/time: Add missing __init to init_tick_ops()

Taehee Yoo (2):
      xdp: add NULL pointer check in __xdp_return()
      bpf: use GFP_ATOMIC instead of GFP_KERNEL in bpf_parse_prog()

Tariq Toukan (1):
      net: rollback orig value on failure of dev_qdisc_change_tx_queue_len

Thomas Gleixner (2):
      perf/x86/amd/ibs: Don't access non-started event
      genirq: Make force irq threading setup more robust

Thomas Petazzoni (2):
      sparc: move MSI related definitions to where they are used
      sparc: use asm-generic version of msi.h

Thomas Richter (1):
      perf build: Build error in libbpf missing initialization

Tommi Rantala (1):
      xfrm: fix missing dst_release() after policy blocking lbcast and mult=
icast

Tony Battersby (2):
      scsi: sg: fix minor memory leak in error path
      scsi: sg: update comment for blk_get_request()

Toshiaki Makita (1):
      virtio_net: Fix incosistent received bytes counter

Trond Myklebust (1):
      NFSv4: Fix _nfs4_do_setlk()

Ursula Braun (1):
      net/smc: no cursor update send in state SMC_INIT

Varun Prakash (2):
      scsi: target: iscsi: cxgbit: fix max iso npdu calculation
      scsi: libiscsi: fix possible NULL pointer dereference in case of TMF

Vincent Whitchurch (1):
      ARM: 8781/1: Fix Thumb-2 syscall return for binutils 2.29+

Waiman Long (1):
      locking/pvqspinlock/x86: Use LOCK_PREFIX in
__pv_queued_spin_unlock() assembly code

Wang YanQing (1):
      bpf, x32: Fix regression caused by commit 24dea04767e6

Wei Yongjun (1):
      net: igmp: make function __ip_mc_inc_group() static

Xiao Liang (1):
      xen-netfront: wait xenbus state change when load module manually

Yi Wang (2):
      sched/topology: Check variable group before dereferencing it
      audit: fix potential null dereference 'context->module.name'

Yonghong Song (1):
      tools/bpftool: fix a percpu_array map dump problem

YueHaibing (1):
      rxrpc: Fix user call ID check in rxrpc_service_prealloc_one

Zhen Lei (1):
      esp6: fix memleak on error path in esp6_input

dann frazier (1):
      hinic: Link the logical network device to the pci device in sysfs

tangpengpeng (1):
      net: fix amd-xgbe flow-control issue
