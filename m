Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A338C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1D208D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LW/cHi0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A1D208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933481AbeGHX51 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:57:27 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:55357 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933118AbeGHX5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:57:24 -0400
Received: by mail-it0-f45.google.com with SMTP id 16-v6so23048809itl.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 16:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vgoCsdOClvFXJ24yu+ZNRhQed1C3v7NrP8ypibOL+Dc=;
        b=LW/cHi0gU+bjQRwpAHQ0QDh2LgFp1qw+Whr4Y2lzI12A/Ekau7lXmaEMHGd65dUK5T
         8JQkyz6PzNQftffSot5TqC9yl2TfoikmIsn6TI0x06XsIjnNTq55kUk1N3zaLvu0Mo9t
         X8IcL7W5G8FfLef3rsxUoyBPo2H83NRz2+jTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vgoCsdOClvFXJ24yu+ZNRhQed1C3v7NrP8ypibOL+Dc=;
        b=m7CXLqWDQd/+xDRTRDF1eoUJUa0xfo2QyCmt3GvihwmNtBmzZuiNywvoyppW0xzQvm
         qDQaCe7tlEzIZcfjSlnxA8BndlLICtmcHw0HMDlBbKMftG5TWBhGbHlYuCQPaJ8mEf+n
         AKz4AR0/mlJXO9G6u1q8qG+/CW6uLeglSjjDLLhhAmys4v0twliHV2SqW2L7Fa6qNXyA
         tgP+qPCaLtxyowZQazG+14+UgX3eR28DkRCZUBq6Www5yEzsHIa5O4WQun5kH0pSRIC7
         XdnEjBRqevBptqLHrMPdX8Iys6eGTu/djIPRWhnHsUKrLgAajlosfyucZEzCkVUWTxRu
         klFw==
X-Gm-Message-State: APt69E0F6Hz2apq+Vn7iWj9az2gimUxBNJvl/eYl6DBWDEk1X0puy0/c
        FgokJOXxvP/Km/ulKQETorNSjUNHxO/2H+GTklknOgHf
X-Google-Smtp-Source: AAOMgpdrHdINiQ4+/eRyhGlYq6xUvNxUQHeK/L0UST4FOS96w/NGH9OAbO7OZsCBf8kxXtxR4wAft2r64hHSHY1A5XI=
X-Received: by 2002:a02:2b12:: with SMTP id h18-v6mr12356915jaa.10.1531094243609;
 Sun, 08 Jul 2018 16:57:23 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Jul 2018 16:57:12 -0700
Message-ID: <CA+55aFwXGyZ1Yx+Z8a93gpvb596ZRJ5ppiQL_+-k7gjeQLtcsQ@mail.gmail.com>
Subject: Linux 4.18-rc4
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things look pretty normal here, and size-wise this looks good too, so
it's another of those "solid progress to release" weeks. Boring is
good.

About half of the updates are to drivers, with GPU and networking
being the bulk of it, but there's some misc noise all over (PCI, SCSI,
power management, acpi, dmaengine).

Outside of drivers, it's networking (including some bpf fixed),
filesystems (cifs and ext4), some core scheduler fixes, and some arch
updatyes (x86, riscv, small other updates).

Let's hope this release continues being quiet. But go test to make
sure it's all working for you all,

              Linus

---

Adam Ford (1):
      ARM: dts: omap3: Fix am3517 mdio and emac clock references

Alex Deucher (2):
      drm/amdgpu: fix swapped emit_ib_size in vce3
      drm/amdgpu/pm: fix display count in non-DC path

Alex Vesker (2):
      net/mlx5: Fix incorrect raw command length parsing
      net/mlx5: Fix command interface race in polling mode

Alex Williamson (1):
      vfio/pci: Make IGD support a configurable option

Alexandre Belloni (1):
      net: macb: initialize bp->queues[0].bp for at91rm9200

Anders Roxell (1):
      selftests: bpf: add missing NET_SCHED to config

Andreas Schwab (1):
      RISC-V: fix R_RISCV_ADD32/R_RISCV_SUB32 relocations

Andrzej Pietrasiewicz (1):
      drm/exynos: scaler: Reset hardware before starting the operation

Arnd Bergmann (2):
      tracing: Avoid string overflow
      ARM: disable KCOV for trusted foundations code

Bartosz Golaszewski (1):
      clk: davinci: fix a typo (which leads to build failures)

Bert Kenward (1):
      sfc: correctly initialise filter rwsem for farch

BingJing Chang (1):
      md/raid10: fix that replacement cannot complete recovery after reasse=
mble

Bob Copeland (1):
      nl80211: relax ht operation checks for mesh

Borislav Petkov (1):
      crypto: x86 - Add missing RETs

Cannon Matthews (1):
      mm: hugetlb: yield when prepping struct pages

Changbin Du (1):
      tracing: Fix missing return symbol in function_graph output

Chengguang Xu (1):
      nfp: cast sizeof() to int when comparing with error code

Chris Wilson (1):
      drm/i915: Try GGTT mmapping whole object as partial

Christian Borntraeger (1):
      s390: Correct register corruption in critical section cleanup

Christoph Hellwig (1):
      Revert "iommu/intel-iommu: Enable CONFIG_DMA_DIRECT_OPS=3Dy and
clean up intel_{alloc,free}_coherent()"

Cong Wang (1):
      net: use dev_change_tx_queue_len() for SIOCSIFTXQLEN

Corey Minyard (1):
      ipmi: Cleanup oops on initialization failure

Dan Carpenter (5):
      clk: davinci: cfgchip: testing the wrong variable
      dmaengine: k3dma: Off by one in k3_of_dma_simple_xlate()
      PCI: endpoint: Use after free in pci_epf_unregister_driver()
      atm: iphase: fix a 64 bit bug
      cnic: tidy up a size calculation

Dan Murphy (1):
      net: phy: DP83TC811: Fix disabling interrupts

Daniel Borkmann (3):
      bpf, arm32: fix to use bpf_jit_binary_lock_ro api
      bpf, s390: fix potential memleak when later bpf_jit_prog fails
      bpf: undo prog rejection on read-only lock failure

Daniel Mack (1):
      ARM: dts: am437x: make edt-ft5x06 a wakeup source

Dave Stevenson (4):
      net: lan78xx: Allow for VLAN headers in timeout calcs
      net: lan78xx: Add support for VLAN filtering.
      net: lan78xx: Add support for VLAN tag stripping.
      net: lan78xx: Use s/w csum check on VLANs without tag stripping

David Ahern (2):
      bpf: Change bpf_fib_lookup to return lookup status
      net/ipv6: Fix updates to prefix route

David Disseldorp (1):
      scsi: target: Fix truncated PR-in ReadKeys response

Denis Kenzior (1):
      mac80211: disable BHs/preemption in ieee80211_tx_control_port()

Doron Roberts-Kedes (1):
      strparser: Remove early eaten to fix full tcp receive buffer stall

Eli Cohen (2):
      net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being
esw manager
      net/mlx5: Fix required capability for manipulating MPFS

Eric Biggers (2):
      crypto: arm/speck - fix building in Thumb2 mode
      ipv6: sr: fix passing wrong flags to crypto_alloc_shash()

Eric Dumazet (3):
      netfilter: nf_queue: augment nfqa_cfg_policy
      netfilter: ipv6: nf_defrag: reduce struct net memory waste
      tcp: add one more quick ack after after ECN events

Eric Farman (1):
      s390/mm: fix refcount usage for 4K pgste

Evan Green (1):
      loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl

Evan Quan (3):
      drm/amd/powerplay: correct vega12 thermal support as true
      drm/amd/powerplay: correct vega12 bootup values settings
      drm/amd/powerplay: smc_dpm_info structure change

Fabio Estevam (3):
      dt-bindings: clock: imx6ul: Do not change the clock definition order
      ARM: imx_v6_v7_defconfig: Select ULPI support
      ARM: imx_v4_v5_defconfig: Select ULPI support

Florian Westphal (1):
      netfilter: nf_conncount: fix garbage collection confirm race

Frederic Weisbecker (1):
      sched/nohz: Skip remote tick on idle task entirely

Gao Feng (1):
      netfilter: nf_ct_helper: Fix possible panic after
nf_conntrack_helper_unregister

Geert Uytterhoeven (1):
      PCI: controller: dwc: Do not let PCIE_DW_PLAT_HOST default to yes

Gerd Hoffmann (2):
      sample/mdev/mbochs: remove mbochs_kmap_atomic_dmabuf
      sample/mdev/mbochs: add mbochs_kunmap_dmabuf

Greg Hackmann (1):
      arm64: remove no-op -p linker flag

Greg Ungerer (1):
      m68k: fix "bad page state" oops on ColdFire boot

Gustavo A. R. Silva (1):
      atm: zatm: Fix potential Spectre v1

H. Peter Anvin (1):
      x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h=
>

Haiyue Wang (1):
      ipmi: kcs_bmc: fix IRQ exception if the channel is not open

Hangbin Liu (1):
      ipvlan: call dev_change_flags when ipvlan mode is reset

Heiko Carstens (2):
      s390: wire up io_pgetevents system call
      s390: wire up rseq system call

Ilpo J=C3=A4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jakub Kicinski (5):
      tools: bpftool: remove duplicated error message on prog load
      tools: bpftool: remember to close the libbpf object after prog load
      nfp: bpf: don't stop offload if replace failed
      PCI/IOV: Reset total_VFs limit after detaching PF driver
      nfp: stop limiting VFs to 0

Jann Horn (4):
      netfilter: nf_log: fix uninit read in nf_log_proc_dostring
      netfilter: nf_log: don't hold nf_log_mutex during user access
      scsi: sg: mitigate read/write abuse
      x86/mtrr: Don't copy out-of-bounds data in mtrr_write

Janosch Frank (1):
      userfaultfd: hugetlbfs: fix userfaultfd_huge_must_wait() pte access

Janusz Krzysztofik (1):
      dmaengine: ti: omap-dma: Fix OMAP1510 incorrect residue_granularity

Jason A. Donenfeld (1):
      fib_rules: match rules based on suppress_* properties too

Jason Gunthorpe (1):
      vfio: Use get_user_pages_longterm correctly

Jeffrin Jose T (3):
      selftests: bpf: notification about privilege required to run
test_kmod.sh testing script
      selftests: bpf: notification about privilege required to run
test_lirc_mode2.sh testing script
      selftests: bpf: notification about privilege required to run
test_lwt_seg6local.sh testing script

Jesper Dangaard Brouer (3):
      ixgbe: split XDP_TX tail and XDP_REDIRECT map flushing
      i40e: split XDP_TX tail and XDP_REDIRECT map flushing
      virtio_net: split XDP_TX kick and XDP_REDIRECT map flushing

Jim Wilson (1):
      RISC-V: Fix PTRACE_SETREGSET bug.

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

Johannes Berg (1):
      nl80211: check nla_parse_nested() return values

John Fastabend (4):
      bpf: sockmap, fix crash when ipv6 sock is added
      bpf: sockmap, fix smap_list_map_remove when psock is in many maps
      bpf: sockhash fix omitted bucket lock in sock_close
      bpf: sockhash, add release routine

John Hurley (1):
      nfp: reject binding to shared blocks

Jon Derrick (1):
      ext4: check superblock mapped prior to committing

Jose Abreu (1):
      net: stmmac: Set DMA buffer size in HW

Josh Poimboeuf (1):
      objtool: Support GCC 8 '-fnoreorder-functions'

Jouke Witteveen (1):
      ACPI / battery: Safe unregistering of hooks

Julian Wiedmann (4):
      Revert "s390/qeth: use Read device to query hypervisor for MAC"
      s390/qeth: fix race when setting MAC address
      s390/qeth: don't clobber buffer on async TX completion
      s390/qeth: consistently re-enable device features

K. Y. Srinivasan (1):
      x86/hyper-v: Fix the circular dependency in IPI enlightenment

Kees Cook (1):
      bus: ti-sysc: Use 2-factor allocator arguments

Kleber Sacilotto de Souza (1):
      test_bpf: flag tests that cannot be jited on s390

Lars Ellenberg (1):
      drbd: fix access after free

Lars Persson (1):
      cifs: Fix use after free of a mid_q_entry

Linus Torvalds (4):
      net/smc: fix up merge error with poll changes
      autofs: rename 'autofs' module back to 'autofs4'
      Fix up non-directory creation in SGID directories
      Linux 4.18-rc4

Lyude Paul (3):
      drm/amdgpu: Make struct amdgpu_atif private to amdgpu_acpi.c
      drm/amdgpu: Add amdgpu_atpx_get_dhandle()
      drm/amdgpu: Dynamically probe for ATIF handle (v2)

Maciej Purski (3):
      drm/bridge/sii8620: Send AVI infoframe in all MHL versions
      drm/bridge/sii8620: Fix display of packed pixel modes
      drm/bridge/sii8620: Fix link mode selection

Madalin Bucur (2):
      fsl/fman: fix parser reporting bad checksum on short frames
      dpaa_eth: DPAA SGT needs to be 256B

Marek Szyprowski (11):
      dmaengine: pl330: report BURST residue granularity
      drm/exynos: ipp: Rework checking for the correct buffer formats
      drm/exynos: rotator: Fix DRM_MODE_REFLECT_{X,Y} interpretation
      drm/exynos: scaler: Fix support for YUV420, YUV422 and YUV444 modes
      drm/exynos: gsc: Use real buffer width for configuring the hardware
      drm/exynos: gsc: Increase Exynos5433 buffer width alignment to 16 pix=
els
      drm/exynos: gsc: Fix DRM_MODE_REFLECT_{X,Y} interpretation
      drm/exynos: gsc: Fix support for NV16/61, YUV420/YVU420 and YUV422 mo=
des
      drm/exynos: fimc: Use real buffer width for configuring the hardware
      drm/exynos: decon5433: Fix per-plane global alpha for XRGB modes
      drm/exynos: decon5433: Fix WINCONx reset value

Marek Vasut (2):
      PCI: rcar: Shut the PHY down in failpath
      PCI: rcar: Clean up PHY init on failure

Masahiro Yamada (4):
      clk: sunxi-ng: replace lib-y with obj-y
      bpfilter: check compiler capability in Kconfig
      bpfilter: include bpfilter_umh in assembly instead of using objcopy
      arm64: add endianness option to LDFLAGS instead of LD

Mathieu Malaterre (1):
      tracing: Use __printf markup to silence compiler

Michal Hocko (1):
      net: cleanup gfp mask in alloc_skb_with_frags

Michel D=C3=A4nzer (1):
      drm: Use kvzalloc for allocating blob property memory

Mikita Lipski (2):
      drm/amd/display: adding ycbcr420 pixel encoding for hdmi
      drm/amd/display: add a check for display depth validity

Mikulas Patocka (1):
      drm/udl: fix display corruption of the last line

Nicholas Mc Guire (3):
      PCI: xilinx: Add missing of_node_put()
      PCI: xilinx-nwl: Add missing of_node_put()
      PCI: faraday: Add missing of_node_put()

Nick Desaulniers (2):
      compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declara=
tions
      x86/paravirt: Make native_save_fl() extern inline

Nick Dyer (1):
      ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl

Nicolai H=C3=A4hnle (1):
      drm/amdgpu: fix user fence write race condition

Or Gerlitz (4):
      net/mlx5e: Don't attempt to dereference the ppriv struct if not
being eswitch manager
      net/mlx5: E-Switch, Avoid setup attempt if not being e-switch manager
      net/mlx5e: Avoid dealing with vport representors if not being
e-switch manager
      IB/mlx5: Avoid dealing with vport representors if not being
e-switch manager

Palmer Dabbelt (1):
      RISC-V: Don't include irq-riscv-intc.h

Paul Kocialkowski (1):
      arm64: Use aarch64elf and aarch64elfb emulation mode variants

Paulo Alcantara (4):
      cifs: Fix validation of signed data in smb3+
      cifs: Fix validation of signed data in smb2
      cifs: Fix memory leak in smb2_set_ea()
      cifs: Fix infinite loop when using hard mount option

Pavel Tatashin (1):
      mm: teach dump_page() to correctly output poisoned struct pages

Peter Zijlstra (1):
      kthread, sched/core: Fix kthread_parkme() (again...)

Pieter Jansen van Vuuren (1):
      nfp: flower: fix mpls ether type detection

Rafael J. Wysocki (2):
      PCI / ACPI / PM: Resume bridges w/o drivers on suspend-to-RAM
      ACPICA: Drop leading newlines from error messages

Raghava Aditya Renukunta (1):
      scsi: aacraid: Fix PD performance regression over incorrect qd being =
set

Rob Herring (1):
      riscv: remove unnecessary of_platform_populate call

Robert Nelson (1):
      ARM: dts: am335x-bone-common: Fix mmc0 Write Protect

Roger Quadros (1):
      ARM: dts: dra7: Disable metastability workaround for USB2

Ronnie Sahlberg (1):
      cifs: fix SMB1 breakage

Roopa Prabhu (1):
      net: fib_rules: bring back rule_exists to match rule during add

Sabrina Dubroca (2):
      alx: take rtnl before calling __alx_open from resume
      net: fix use-after-free in GRO with ESP

Sean Young (1):
      bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF

Shakeel Butt (1):
      net, mm: account sock objects to kmemcg

Shaohua Li (1):
      MD: cleanup resources in failure

Shay Agroskin (1):
      net/mlx5: Fix wrong size allocation for QoS ETC TC regitster

Shuah Khan (1):
      selftests/net: Fix permissions for fib_tests.sh

Sinan Kaya (1):
      MAINTAINERS: Update email-id of Sinan Kaya

Souptick Joarder (1):
      sample/vfio-mdev: Change return type to vm_fault_t

Sowmini Varadhan (1):
      rds: clean up loopback rds_connections on netns deletion

Stafford Horne (2):
      openrisc: Call destructor during __pte_free_tlb
      openrisc: entry: Fix delay slot exception detection

Stefan Agner (1):
      drm/exynos: ipp: use correct enum type

Stefan Haberland (1):
      s390/dasd: reduce the default queue depth and nr of hardware queues

Stefano Brivio (2):
      cifs: Fix slab-out-of-bounds in send_set_info() on SMB2 ACE setting
      cifs: Fix stack out-of-bounds in smb{2,3}_create_lease_buf()

Stephen Hemminger (1):
      hv_netvsc: split sub-channel setup into async and sync

Steven Rostedt (VMware) (1):
      tracing: Make create_filter() code match the comments

Sudarsana Reddy Kalluru (5):
      bnx2x: Fix receiving tx-timeout in error or recovery state.
      qed: Limit msix vectors in kdump kernel to the minimum required count=
.
      qed: Fix setting of incorrect eswitch mode.
      qed: Fix use of incorrect size in memcpy call.
      qede: Adverstise software timestamp caps when PHC is not available.

Sudeep Holla (1):
      ACPI / PPTT: use ACPI ID whenever ACPI_PPTT_ACPI_PROCESSOR_ID_VALID i=
s set

Theodore Ts'o (14):
      ext4: add warn_on_error mount option
      ext4: add corruption check in ext4_xattr_set_entry()
      ext4: always verify the magic number in xattr blocks
      ext4: always check block group bounds in ext4_init_block_bitmap()
      ext4: make sure bitmaps and the inode table don't overlap with
bg descriptors
      ext4: only look at the bg_flags field if it is valid
      ext4: verify the depth of extent tree in ext4_find_extent()
      ext4: include the illegal physical block in the bad map ext4_error ms=
g
      ext4: clear i_data in ext4_inode_info when removing inline data
      ext4: never move the system.data xattr out of the inode body
      jbd2: don't mark block as modified if the handle is out of credits
      ext4: avoid running out of journal credits when appending to an
inline file
      ext4: add more inode number paranoia checks
      ext4: add more mount time checks of the superblock

Thomas Zimmermann (3):
      drm/exynos: Replace drm_framebuffer_{un/reference} with put,get funct=
ions
      drm/exynos: Replace drm_gem_object_unreference_unlocked with put func=
tion
      drm/exynos: Replace drm_dev_unref with drm_dev_put

Tom Lendacky (2):
      x86/bugs: Update when to check for the LS_CFG SSBD mitigation
      x86/bugs: Fix the AMD SSBD usage of the SPEC_CTRL MSR

Ulf Hansson (1):
      PM / Domains: Don't power on at attach for the multi PM domain case

Ursula Braun (1):
      net/smc: rebuild nonblocking connect

Vasily Gorbik (1):
      s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]

Vincent Guittot (2):
      sched/rt: Fix call to cpufreq_update_util()
      sched/util_est: Fix util_est_dequeue() for throttled cfs_rq

Wei Yongjun (1):
      hinic: reset irq affinity before freeing irq

Xiaolin Zhang (1):
      drm/i915/gvt: changed DDI mode emulation type

Xunlei Pang (2):
      sched/fair: Fix bandwidth timer clock drift condition
      sched/fair: Advance global expiration when period timer is restarted

Yisheng Xie (1):
      ftrace: Nuke clear_ftrace_function

Yonghong Song (1):
      tools/bpf: fix test_sockmap failure

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness

Zhao Yan (1):
      drm/i915/gvt: fix a bug of partially write ggtt enties

Zhen Lei (1):
      kasan: fix shadow_size calculation error in kasan_module_alloc

Zhenzhong Duan (1):
      x86/mm/32: Initialize the CR4 shadow before __flush_tlb_all()

Zong Li (4):
      RISC-V: Add conditional macro for zone of DMA32
      RISC-V: Select GENERIC_UCMPDI2 on RV32I
      RISC-V: Add definiion of extract symbol's index and type for 32-bit
      RISC-V: Change variable type for 32-bit compatible

yuan linyu (1):
      tracing: Optimize trace_buffer_iter() logic
