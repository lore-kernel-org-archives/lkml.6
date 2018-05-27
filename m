Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751554AbeE0VAQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 17:00:16 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:50399 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbeE0VAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 17:00:13 -0400
X-Google-Smtp-Source: AB8JxZqX1P8xiyw1uw5QFLvt5VfPgmW6ZW2oXu9uI7ekPvnEPaI88cmDHphOWYQWMmwzXFS36o3yK46DGUlcjJ5Gu9M=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 May 2018 14:00:01 -0700
Message-ID: <CA+55aFwUqz9z1Rf4Wwr29W7DeKxQ67qKEW5xty+JPyCY3aNQ=A@mail.gmail.com>
Subject: Linux 4.17-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4RL0lpP028571

So this week wasn't as calm as the previous weeks have been, but despite
that I suspect this is the last rc.

This week we had the whole "spectre v4" thing, and yes, the fallout from
that shows up as part of the patch and commit log. But it's not actually
dominant: the patch is pretty evenly one third arch updates, one third
networking updates, and one third "rest".

The arch updates are largely - although not exclusively - spectre v4.

The networking stuff is mostly network drivers, but there's some core
networking too.

And "the rest" is just that - misc drivers (rdma, gpu, other),
documentation, some vfs, vm, bpf, tooling..

The bulk of it is really pretty trivial one-liners, and nothing looks
particularly scary. Let's see how next week looks, but if nothing really
happens I suspect we can make do without an rc8.

Shortlog appended as usual. Go out and test.

          Linus

---

Al Viro (11):
       do d_instantiate/unlock_new_inode combinations safely
       fix breakage caused by d_find_alias() semantics change
       affs_lookup(): close a race with affs_remove_link()
       affs_lookup: switch to d_splice_alias()
       befs_lookup(): use d_splice_alias()
       kernfs: deal with kernfs_fill_super() failures
       unfuck sysfs_mount()
       cachefiles: vfs_mkdir() might succeed leaving dentry negative unhashed
       nfsd: vfs_mkdir() might succeed leaving dentry negative unhashed
       ext2: fix a block leak
       aio: fix io_destroy(2) vs. lookup_ioctx() race

Alexander Potapenko (1):
       scsi: sg: allocate with __GFP_ZERO in sg_build_indirect()

Alexandre Belloni (2):
       MIPS: xilfpga: Stop generating useless dtb.o
       MIPS: xilfpga: Actually include FDT in fitImage

Alexandru Moise (1):
       nvmet,rxe: defer ip datagram sending to tasklet

Alexei Starovoitov (1):
       bpf: Prevent memory disambiguation attack

Alexey Kodanev (1):
       dccp: don't free ccid2_hc_tx_sock struct in dccp_disconnect()

Amritha Nambiar (1):
       net: Fix a bug in removing queues from XPS map

Anders Roxell (2):
       selftests: bpf: config: enable NET_SCH_INGRESS for xdp_meta.sh
       selftests: net: reuseport_bpf_numa: don't fail if no numa support

Andrew Boyer (3):
       RDMA/i40iw: Avoid panic when objects are being created and destroyed
       RDMA/i40iw: Avoid reference leaks when processing the AEQ
       RDMA/i40iw: Avoid panic when reading back the IRQ affinity hint

Andrew Zaborowski (1):
       mac80211_hwsim: Fix radio dump for radio idx 0

Andrey Ryabinin (1):
       mm/kasan: don't vfree() nonexistent vm_area

Ben Hutchings (1):
       ALSA: timer: Fix pause event notification

Benjamin Herrenschmidt (1):
       KVM: PPC: Book3S HV: XIVE: Resend re-routed interrupts on CPU
priority change

Bo Chen (1):
       pcnet32: add an error handling path in pcnet32_probe_pci()

Bob Copeland (1):
       mac80211: mesh: fix premature update of rc stats

Borislav Petkov (3):
       Documentation/spec_ctrl: Do some minor cleanups
       x86/speculation: Use synthetic bits for IBRS/IBPB/STIBP
       x86/bugs: Unify x86_spec_ctrl_{set_guest,restore_host}

Brian Norris (1):
       mfd: cros_ec: Retry commands when EC is known to be busy

Changwei Ge (1):
       ocfs2: revert "ocfs2/o2hb: check len for bio_add_page() to avoid
getting incorrect bio"

Chen-Yu Tsai (1):
       ARM: dts: sun8i: h3: Re-enable EMAC on Orange Pi One

Christoph Hellwig (3):
       3c59x: convert to generic DMA API
       alpha: use dma_direct_ops for jensen
       alpha: simplify get_arch_dma_ops

Christophe Jaillet (1):
       iw_cxgb4: Fix an error handling path in 'c4iw_get_dma_mr()'

Colin Ian King (5):
       batman-adv: don't pass a NULL hard_iface to batadv_hardif_put
       ARM: sun8i: v3s: fix spelling mistake: "disbaled" -> "disabled"
       netfilter: nf_tables: fix memory leak on error exit return
       KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
       net/mlx4: fix spelling mistake: "Inrerface" -> "Interface" and
rephrase message

Corneliu Doban (2):
       mmc: sdhci-iproc: fix 32bit writes for TRANSFER_MODE register
       mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus

Daniel Borkmann (2):
       bpf: fix truncated jump targets on heavy expansions
       bpf: properly enforce index mask to prevent out-of-bounds speculation

Daria Velikovsky (1):
       RDMA/mlx5: Use proper spec flow label type

Dave Chinner (1):
       fs: don't scan the inode cache before SB_BORN is set

David Ahern (1):
       net/ipv4: Initialize proto and ports in flow struct

David Hildenbrand (3):
       KVM: s390: vsie: fix < 8k check for the itdba
       kasan: free allocated shadow memory on MEM_CANCEL_ONLINE
       kasan: fix memory hotplug during boot

David Vrabel (1):
       x86/kvm: fix LAPIC timer drift when guest uses periodic mode

Davide Caratti (1):
       net/sched: fix refcnt leak in the error path of tcf_vlan_init()

Davidlohr Bueso (2):
       Revert "ipc/shm: Fix shmat mmap nil-page protection"
       ipc/shm: fix shmat() nil address after round-down when remapping

Dedy Lansky (1):
       nl80211: fix nlmsg allocation in cfg80211_ft_event

Dominik Brodowski (1):
       x86/speculation: Simplify the CPU bug detection logic

Eran Ben Elisha (1):
       net/mlx5e: When RXFCS is set, add FCS data into checksum calculation

Eric Biggers (3):
       net/smc: check for missing nlattrs in SMC_PNETID messages
       cfg80211: further limit wiphy names to 64 bytes
       ppp: remove the PPPIOCDETACH ioctl

Eric Dumazet (3):
       tcp: purge write queue in tcp_connect_init()
       sock_diag: fix use-after-free read in __sk_free
       ipmr: properly check rhltable_init() return value

Fabio Estevam (2):
       net: fec: ptp: Switch to SPDX identifier
       net: fec: Add a SPDX identifier

Florian Fainelli (6):
       net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite for last rule
       net: dsa: bcm_sf2: Fix IPv6 rules and chain ID
       net: dsa: bcm_sf2: Fix IPv6 rule half deletion
       net: dsa: Do not register devlink for unused ports
       net: phy: broadcom: Fix auxiliary control register reads
       net: phy: broadcom: Fix bcm_write_exp()

Florian Westphal (9):
       netfilter: x_tables: check name length in find_match/target, too
       netfilter: nf_tables: skip synchronize_rcu if transaction log is empty
       netfilter: nf_tables: nft_compat: fix refcount leak on xt module
       netfilter: core: add missing __rcu annotation
       netfilter: prefer nla_strlcpy for dealing with NLA_STRING attributes
       netfilter: x_tables: add module alias for icmp matches
       netfilter: nf_tables: don't assume chain stats are set when jumplabel
is set
       netfilter: nft_compat: prepare for indirect info storage
       netfilter: nft_compat: fix handling of large matchinfo size

François Cami (1):
       libata: Apply NOLPM quirk for SAMSUNG PM830 CXM13D1Q.

Geert Uytterhoeven (2):
       net: 8390: ne: Fix accidentally removed RBTX4927 support
       sh_eth: Change platform check to CONFIG_ARCH_RENESAS

Govindarajulu Varadarajan (1):
       enic: set DMA mask to 47 bit

Greg Thelen (1):
       IB: remove redundant INFINIBAND kconfig dependencies

Gustavo A. R. Silva (1):
       kernel/sys.c: fix potential Spectre v1 issue

Haim Dreyfuss (1):
       cfg80211: fix NULL pointer derference when querying regdb

Hugh Dickins (1):
       proc: fix smaps and meminfo alignment

Ilya Dryomov (2):
       iov_iter: fix return type of __pipe_get_pages()
       iov_iter: fix memory leak in pipe_get_pages_alloc()

Jack Morgenstein (1):
       net/mlx4: Fix irq-unsafe spinlock usage

Jakub Kicinski (2):
       nfp: bpf: allow zero-length capabilities
       tools: bpf: handle NULL return in bpf_prog_load_xattr()

Jason A. Donenfeld (1):
       arm64: export tishift functions to modules

Jason Gunthorpe (1):
       IB/uverbs: Fix uverbs_attr_get_obj

Jason Wang (8):
       tun: fix use after free for ptr_ring
       tuntap: fix use after free during release
       virtio-net: correctly redirect linearized packet
       virtio-net: correctly transmit XDP buff after linearizing
       virtio-net: correctly check num_buf during err path
       virtio-net: fix leaking page for gso packet during mergeable XDP
       tuntap: correctly set SOCKWQ_ASYNC_NOSPACE
       vhost: synchronize IOTLB message with dev cleanup

Jeff Layton (1):
       loop: clear wb_err in bd_inode when detaching backing file

Jens Axboe (1):
       sr: pass down correctly sized SCSI sense buffer

Jens Remus (1):
       scsi: zfcp: fix infinite iteration on ERP ready list

Jesper Dangaard Brouer (1):
       selftests/bpf: check return value of fopen in test_verifier.c

Jim Mattson (2):
       x86/cpu: Make alternative_msr_write work for 32-bit code
       kvm: x86: IA32_ARCH_CAPABILITIES is always supported

Jiri Kosina (2):
       x86/bugs: Fix __ssb_select_mitigation() return type
       x86/bugs: Make cpu_show_common() static

Joe Jin (1):
       xen-swiotlb: fix the check condition for xen_swiotlb_free_coherent

Joe Perches (2):
       cramfs: Fix IS_ENABLED typo
       checkpatch: fix macro argument precedence test

John Fastabend (2):
       bpf: sockmap update rollback on error can incorrectly dec prog refcnt
       bpf: parse and verdict prog attach may race with bpf map update

John Stultz (1):
       arm64: dts: hikey: Fix eMMC corruption regression

Jonathan Cameron (1):
       mm/memory_hotplug: fix leftover use of struct page during hotplug

Joonsoo Kim (1):
       Revert "mm/cma: manage the memory of the CMA area by using the
ZONE_MOVABLE"

Jozsef Kadlecsik (1):
       netfilter: Fix handling simultaneous open in TCP conntrack

Julian Anastasov (2):
       ipvs: fix refcount usage for conns in ops mode
       ipvs: fix stats update from local clients

Juri Lelli (1):
       sched/topology: Clarify root domain(s) debug string

Kalderon, Michal (1):
       RDMA/qedr: Fix doorbell bar mapping for dpi > 1

Kalle Valo (3):
       MAINTAINERS: update Kalle's email address
       MAINTAINERS: change Kalle as ath.ko maintainer
       MAINTAINERS: change Kalle as wcn36xx maintainer

Keefe Liu (1):
       ipvlan: call netdevice notifier when master mac address changed

Kees Cook (6):
       nospec: Allow getting/setting on non-current task
       proc: Provide details on speculation flaw mitigations
       seccomp: Enable speculation flaw mitigations
       x86/bugs: Make boot modes __ro_after_init
       seccomp: Add filter flag to opt-out of SSB mitigation
       x86/speculation: Make "seccomp" the default mode for Speculative
Store Bypass

Konrad Rzeszutek Wilk (16):
       x86/bugs: Concentrate bug detection into a separate function
       x86/bugs: Concentrate bug reporting into a separate function
       x86/bugs: Read SPEC_CTRL MSR during boot and re-use reserved bits
       x86/bugs, KVM: Support the combination of guest and host IBRS
       x86/bugs: Expose /sys/../spec_store_bypass
       x86/cpufeatures: Add X86_FEATURE_RDS
       x86/bugs: Provide boot parameters for the spec_store_bypass_disable
mitigation
       x86/bugs/intel: Set proper CPU features and setup RDS
       x86/bugs: Whitelist allowed SPEC_CTRL MSR values
       x86/bugs/AMD: Add support to disable RDS on Fam[15,16,17]h if
requested
       x86/KVM/VMX: Expose SPEC_CTRL Bit(2) to the guest
       x86/bugs: Rename _RDS to _SSBD
       proc: Use underscores for SSBD in 'status'
       x86/bugs: Fix the parameters alignment and missing void
       x86/bugs: Rename SSBD_NO to SSB_NO
       KVM/VMX: Expose SSBD properly to guests

Kumar Sanghvi (1):
       cxgb4: Correct ntuple mask validation for hash filters

Laura Abbott (1):
       arm64: Make sure permission updates happen for pmd/pud

Laurent Pinchart (1):
       drm: rcar-du: lvds: Fix crash in .atomic_check when disabling
connector

Leon Romanovsky (1):
       MAINTAINERS: Remove bouncing @mellanox.com addresses

Lidong Chen (1):
       IB/umem: Use the correct mm during ib_umem_release

Linus Lüssing (1):
       batman-adv: Fix TT sync flags for intermediate TT responses

Linus Torvalds (2):
       x86/nospec: Simplify alternative_msr_write()
       Linux 4.17-rc7

Linus Walleij (1):
       ARM: Fix i2c-gpio GPIO descriptor tables

Lukas Wunner (1):
       ALSA: hda - Fix runtime PM

Maciej W. Rozycki (2):
       MIPS: ptrace: Expose FIR register through FP regset
       MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR accesses to o32
FGRs

Marek Lindner (1):
       batman-adv: prevent TT request storms by not sending inconsistent TT
TLVLs

Markus Niebel (1):
       net: phy: micrel: add 125MHz reference clock workaround

Mathieu Malaterre (2):
       mmc: block: propagate correct returned value in mmc_rpmb_ioctl
       init/main.c: include <linux/mem_encrypt.h>

Matt Mullins (1):
       tls: don't use stack memory in a scatterlist

Matthew Wilcox (1):
       idr: fix invalid ptr dereference on item delete

Michael J. Ruhl (1):
       IB/hfi1: Use after free race condition in send context error path

Michael Neuling (1):
       powerpc/64s: Clear PCR on boot

Michal Hocko (2):
       mm, memory_hotplug: make has_unmovable_pages more robust
       mm: do not warn on offline nodes unless the specific node is
explicitly requested

Michal Kalderon (4):
       qede: Fix ref-cnt usage count
       qed: LL2 flush isles when connection is closed
       qed: Fix possibility of list corruption during rmmod flows
       qed: Fix LL2 race during connection terminate

Michal Kubecek (1):
       Makefile: disable PIE before testing asm goto

Mika Westerberg (1):
       ahci: Add PCI ID for Cannon Lake PCH-LP AHCI

Mike Kravetz (1):
       MAINTAINERS: change hugetlbfs maintainer and update files

Mustafa Ismail (2):
       i40iw: Fix memory leak in error path of create QP
       i40iw: Use correct address in dst_neigh_lookup for IPv6

Nathan Fontenot (1):
       ibmvnic: Only do H_EOI for mobility events

NeilBrown (1):
       MIPS: c-r4k: Fix data corruption related to cache coherence

Nicholas Piggin (3):
       KVM: PPC: Book3S HV: Make radix use correct tlbie sequence in
kvmppc_radix_tlbie_page
       KVM: PPC: Book3S HV: Make radix clear pte when unmapping
       powerpc/64s: Add support for a store forwarding barrier at kernel
entry/exit

Nick Desaulniers (1):
       kbuild: gcov: enable -fno-tree-loop-im if supported

Niklas Cassel (1):
       firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()

Omar Sandoval (2):
       Btrfs: fix error handling in btrfs_truncate()
       mm: fix nr_rotate_swap leak in swapon() error case

Or Gerlitz (1):
       net : sched: cls_api: deal with egdev path only if needed

Pablo Neira Ayuso (1):
       netfilter: nf_tables: bogus EBUSY in chain deletions

Paolo Abeni (1):
       net: sched: red: avoid hashing NULL child

Pascal Roeleven (1):
       ARM: dts: sun4i: Fix incorrect clocks for displays

Paul Cercueil (1):
       MIPS: Fix build with DEBUG_ZBOOT and MACH_JZ4770

Paul Mackerras (2):
       KVM: PPC: Book3S HV: Snapshot timebase offset on guest entry
       KVM: PPC: Book 3S HV: Do ptesync in radix guest exit path

Peter Maydell (1):
       arm64: fault: Don't leak data in ESR context for user fault on kernel
VA

Peter Zijlstra (1):
       kthread: Allow kthread_park() on a parked kthread

Petr Machata (7):
       net: ip6_gre: Request headroom in __gre6_xmit()
       net: ip6_gre: Fix headroom request in ip6erspan_tunnel_xmit()
       net: ip6_gre: Split up ip6gre_tnl_link_config()
       net: ip6_gre: Split up ip6gre_tnl_change()
       net: ip6_gre: Split up ip6gre_newlink()
       net: ip6_gre: Split up ip6gre_changelink()
       net: ip6_gre: Fix ip6erspan hlen calculation

Prasanna Kumar Kalever (1):
       scsi: target: tcmu: fix error resetting qfull_time_out to default

Qing Huang (1):
       mlx4_core: allocate ICM memory in page size chunks

Radim Krčmář (1):
       KVM: x86: fix #UD address of failed Hyper-V hypercalls

Rafael J. Wysocki (1):
       PM / core: Fix direct_complete handling for devices with no callbacks

Rafał Miłecki (3):
       bcma: fix buffer size caused crash in bcma_core_mips_print_irq()
       Revert "ssb: Prevent build of PCI host features in module"
       ssb: make SSB_PCICORE_HOSTMODE depend on SSB = y

Rahul Lakkireddy (1):
       cxgb4: fix offset in collecting TX rate limit info

Randy Dunlap (1):
       scsi: core: clean up generated file scsi_devinfo_tbl.c

Roopa Prabhu (1):
       net: ipv4: add missing RTA_TABLE to rtm_ipv4_policy

Saeed Mahameed (1):
       net/mlx5: Fix build break when CONFIG_SMP=n

Sebastian Andrzej Siewior (1):
       sched, tracing: Fix trace_sched_pi_setprio() for deboosting

Shahed Shaikh (1):
       qed: Fix mask for physical address in ILT entry

Sinan Kaya (1):
       alpha: io: reorder barriers to guarantee writeX() and iowriteX()
ordering #2

Srinath Mannam (1):
       mmc: sdhci-iproc: remove hard coded mmc cap 1.8v

Stefano Brivio (1):
       selftests/net: Add missing config options for PMTU tests

Stephen Hemminger (1):
       netfilter: bridge: stp fix reference to uninitialized data

Sudip Mukherjee (1):
       libata: blacklist Micron 500IT SSD with MU01 firmware

Sven Eckelmann (1):
       batman-adv: Avoid race in TT TVLV allocator helper

Tarick Bedeir (1):
       net/mlx4_core: Fix error handling in mlx4_init_port_info.

Tejun Heo (1):
       libata: Blacklist some Sandisk SSDs for NCQ

Thomas Falcon (4):
       ibmvnic: Free coherent DMA memory if FW map failed
       ibmvnic: Fix non-fatal firmware error reset
       ibmvnic: Fix statistics buffers memory leak
       ibmvnic: Fix partial success login retries

Thomas Gleixner (18):
       x86/speculation: Create spec-ctrl.h to avoid include hell
       prctl: Add speculation control prctls
       x86/process: Allow runtime control of Speculative Store Bypass
       x86/speculation: Add prctl for Speculative Store Bypass mitigation
       prctl: Add force disable speculation
       seccomp: Use PR_SPEC_FORCE_DISABLE
       seccomp: Move speculation migitation control to arch code
       KVM: SVM: Move spec control call after restore of GS
       x86/cpufeatures: Disentangle MSR_SPEC_CTRL enumeration from IBRS
       x86/cpufeatures: Disentangle SSBD enumeration
       x86/cpufeatures: Add FEATURE_ZEN
       x86/speculation: Handle HT correctly on AMD
       x86/bugs, KVM: Extend speculation control for VIRT_SPEC_CTRL
       x86/speculation: Rework speculative_store_bypass_update()
       x86/bugs: Expose x86_spec_ctrl_base directly
       x86/bugs: Remove x86_spec_ctrl_set()
       x86/bugs: Rework spec_ctrl base and mask logic
       x86/speculation, KVM: Implement support for VIRT_SPEC_CTRL/LS_CFG

Thomas Hellstrom (3):
       drm/vmwgfx: Fix 32-bit VMW_PORT_HB_[IN|OUT] macros
       drm/vmwgfx: Fix host logging / guestinfo reading error paths
       drm/vmwgfx: Schedule an fb dirty update after resume

Tom Lendacky (2):
       x86/speculation: Add virtualized speculative store bypass disable
support
       KVM: SVM: Implement VIRT_SPEC_CTRL support for SSBD

Wei Huang (1):
       KVM: x86: Update cpuid properly when CR4.OSXAVE or CR4.PKE is changed

Wenwen Wang (1):
       isdn: eicon: fix a missing-check bug

Will Deacon (1):
       arm64: lse: Add early clobbers to some input/output asm operands

Willem de Bruijn (4):
       packet: in packet_snd start writing at link layer allocation
       net: test tailroom before appending to linear skb
       packet: fix reserve calculation
       ipv4: remove warning in ip_recv_error

William Tu (2):
       erspan: fix invalid erspan version.
       net: ip6_gre: fix tunnel metadata device sharing.

Xin Long (1):
       sctp: fix the issue that flags are ignored when using kernel_connect

Yishai Hadas (1):
       RDMA/mlx5: Don't assume that medium blueFlame register exists

Yossi Kuperman (1):
       net/mlx5: IPSec, Fix a race between concurrent sandbox QP commands

hpreg@vmware.com (2):
       vmxnet3: set the DMA mask before the first DMA map operation
       vmxnet3: use DMA memory barriers where required

oulijun (13):
       RDMA/hns: Add rq inline flags judgement
       RDMA/hns: Bugfix for rq record db for kernel
       RDMA/hns: Load the RoCE dirver automatically
       RDMA/hns: Update convert function of endian format
       RDMA/hns: Add return operation when configured global param fail
       RDMA/hns: Not support qp transition from reset to reset for hip06
       RDMA/hns: Fix the bug with rq sge
       RDMA/hns: Set desc_dma_addr for zero when free cmq desc
       RDMA/hns: Enable inner_pa_vld filed of mpt
       RDMA/hns: Set NULL for __internal_mr
       RDMA/hns: Fix the bug with NULL pointer
       RDMA/hns: Bugfix for cq record db for kernel
       RDMA/hns: Move the location for initializing tmp_len
