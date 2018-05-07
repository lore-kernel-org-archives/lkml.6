Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeEGDHr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 23:07:47 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52553 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751869AbeEGDHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 23:07:44 -0400
X-Google-Smtp-Source: AB8JxZpqAHiif/5yVglAsRGPX6WGkK2FmA5/nfUE54Ri5nThgFlcO5sOn/r9HAq0lLJArE6eNqwTqLXaH6Ve12N9AYM=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 07 May 2018 03:07:32 +0000
Message-ID: <CA+55aFyry0qeZvYjU5pf8a6zvb_ALmP-2T9+HZH2DHK93P6rQg@mail.gmail.com>
Subject: Linux 4.17-rc4
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4737veg015221

Hmm. Things look fairly normal.

Two thirds of the  4.17-rc4 patch is drivers, which sounds about right.
Media, networking, rdma, input, nvme, usb. A little bit of everything, in
other words.

There's the usual architecture suspects, and some othe rcore updates too
(mainly networking, but some filesystem fixes too).

Go out and test. The shortlog below gives you an overview of the exact
details if you care,

               Linus

---

Agustin Vega-Frias (1):
       irqchip/qcom: Fix check for spurious interrupts

Alan Stern (1):
       USB: Accept bulk endpoints with 1024-byte maxpacket

Alexandre Belloni (1):
       net: phy: allow scanning busses with missing phys

Anders Roxell (1):
       selftests: net: add in_netns.sh TEST_GEN_PROGS_EXTENDED

Anthoine Bourgeois (1):
       KVM: x86: remove APIC Timer periodic/oneshot spikes

Arend Van Spriel (1):
       brcmfmac: fix firmware request processing if nvram load fails

Ariel Levkovich (2):
       IB/uverbs: Prevent reregistration of DM_MR to regular MR
       IB/uverbs: Fix kernel crash during MR deregistration flow

Arnaud Pouliquen (1):
       remoteproc: fix crashed parameter logic on stop call

Arnd Bergmann (5):
       clk: cs2000: mark resume function as __maybe_unused
       hexagon: add memset_io() helper
       hexagon: export csum_partial_copy_nocheck
       iommu/amd: Hide unused iommu_table_lock
       iommu: rockchip: fix building without CONFIG_OF

Artur Petrosyan (1):
       usb: dwc2: WA for Full speed ISOC IN in DDMA mode.

Arvind Yadav (1):
       sparc: vio: use put_device() instead of kfree()

Baolin Wang (1):
       parisc: time: Convert read_persistent_clock() to
read_persistent_clock64()

Bharat Potnuri (1):
       iw_cxgb4: Atomically flush per QP HW CQEs

Bin Liu (2):
       usb: musb: host: fix potential NULL pointer dereference
       usb: musb: trace: fix NULL pointer dereference in musb_g_tx()

Bjørn Mork (1):
       qmi_wwan: do not steal interfaces from class drivers

Boris Brezillon (1):
       drm/vc4: Make sure vc4_bo_{inc,dec}_usecnt() calls are balanced

Bryant G Ly (1):
       scsi: target: Fix fortify_panic kernel exception

Changbin Du (1):
       iommu/vt-d: fix shift-out-of-bounds in bug checking

Chen LinX (1):
       ftrace: Have set_graph_* files have normal file modes

Chengguang Xu (1):
       nvme: fix potential memory leak in option parsing

Chris Mi (1):
       net/mlx5: Properly deal with flow counters when deleting rules

Christophe JAILLET (1):
       Input: synaptics-rmi4 - fix an unchecked out of memory error path

Colin Ian King (8):
       scsi: isci: Fix infinite loop in while loop
       RDMA/iwpm: fix memory leak on map_info
       net: systemport: fix spelling mistake: "asymetric" -> "asymmetric"
       qed: fix spelling mistake: "checksumed" -> "checksummed"
       net: ethernet: ucc: fix spelling mistake: "tx-late-collsion" ->
"tx-late-collision"
       net/mlx4: fix spelling mistake: "failedi" -> "failed"
       net/mlx5e: fix spelling mistake: "loobpack" -> "loopback"
       qed: fix spelling mistake: "offloded" -> "offloaded"

Coly Li (6):
       bcache: store disk name in struct cache and struct cached_dev
       bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
       bcache: count backing device I/O error for writeback I/O
       bcache: add wait_for_kthread_stop() in bch_allocator_thread()
       bcache: set dc->io_disable to true in conditional_stop_bcache_device()
       bcache: use pr_info() to inform duplicated CACHE_SET_IO_DISABLE set

Dag Moxnes (1):
       rds: ib: Fix missing call to rds_ib_dev_put in rds_ib_setup_qp

Daniel Borkmann (2):
       bpf, x64: fix memleak when not converging after image
       bpf, x64: fix memleak when not converging on calls

Danit Goldberg (1):
       IB/mlx5: Use unlimited rate when static rate is not supported

Darrick J. Wong (3):
       xfs: prevent creating negative-sized file via INSERT_RANGE
       xfs: don't fail when converting shortform attr to long form during
ATTR_REPLACE
       xfs: cap the length of deduplication requests

Dave Watson (1):
       net/tls: Don't recursively call push_record during tls_write_space
callbacks

Dmitry Torokhov (1):
       Input: leds - fix out of bound access

Edward Cree (2):
       sfc: Use filter index rather than ID for rps_flow_id table
       sfc: fix ARFS expiry check on EF10

Eric Dumazet (6):
       ipv6: fix uninit-value in ip6_multipath_l3_keys()
       tcp: fix TCP_REPAIR_QUEUE bound checking
       net_sched: fq: take care of throttled flows before reuse
       rds: do not leak kernel memory to user land
       tcp: restore autocorking
       dccp: fix tasklet usage

Eric Sandeen (2):
       xfs: enhance dinode verifier
       xfs: set format back to extents if xfs_bmap_extents_to_btree

Filipe Manana (1):
       Btrfs: send, fix missing truncate for inode with prealloc extent past
eof

Florian Fainelli (1):
       net: systemport: Correclty disambiguate driver instances

From: Gustavo A. R. Silva (1):
       media: imx-media-csi: Fix inconsistent IS_ERR and PTR_ERR

Gabriel Fernandez (6):
       clk: stm32mp1: add missing static
       clk: stm32mp1: remove unused dfsdm_src[] const
       clk: stm32mp1: fix SAI3 & SAI4 clocks
       clk: stm32mp1: add missing tzc2 clock
       clk: stm32mp1: set stgen_k clock as critical
       clk: stm32mp1: remove ck_apb_dbg clock

Geert Uytterhoeven (1):
       IB/uverbs: Add missing braces in anonymous union initializers

Gianluca Borello (1):
       bpf, x64: fix JIT emission for dead code

Greg Kroah-Hartman (2):
       USB: serial: visor: handle potential invalid device configuration
       Revert "usb: host: ehci: Use dma_pool_zalloc()"

Greg Thelen (6):
       nvme: depend on INFINIBAND_ADDR_TRANS
       nvmet-rdma: depend on INFINIBAND_ADDR_TRANS
       ib_srpt: depend on INFINIBAND_ADDR_TRANS
       cifs: smbd: depend on INFINIBAND_ADDR_TRANS
       ib_srp: depend on INFINIBAND_ADDR_TRANS
       IB: make INFINIBAND_ADDR_TRANS configurable

Grygorii Strashko (1):
       net: ethernet: ti: cpsw: fix packet leaking in dual_mac mode

Haim Dreyfuss (1):
       iwlwifi: mvm: query regdb for wmm rule if needed

Hangbin Liu (1):
       bridge: check iface upper dev when setting master via ioctl

Heikki Krogerus (2):
       usb: typec: tcpm: Release the role mux when exiting
       usb: typec: tps6598x: handle block reads separately with plain-I2C
adapters

Heiko Stuebner (1):
       iommu/rockchip: Make clock handling optional

Helge Deller (4):
       parisc: Make bzImage default build target
       parisc: Document rules regarding checksum of HPMC handler
       parisc: drivers.c: Fix section mismatches
       parisc: Fix section mismatches

Huy Nguyen (1):
       net/mlx5e: DCBNL fix min inline header size for dscp

Håkon Bugge (1):
       IB/core: Make ib_mad_client_id atomic

Ian W MORRISON (1):
       drm/i915/glk: Add MODULE_FIRMWARE for Geminilake

Ido Schimmel (2):
       mlxsw: spectrum_switchdev: Do not remove mrouter port from MDB's
ports list
       ipv6: Revert "ipv6: Allow non-gateway ECMP for IPv6"

Ingo Molnar (1):
       8139too: Use disable_irq_nosync() in rtl8139_poll_controller()

Israel Rukshin (1):
       net/mlx5: Fix mlx5_get_vector_affinity function

Jack Morgenstein (1):
       IB/mlx4: Fix integer overflow when calculating optimal MTT size

Jagannathan Raman (1):
       iommu/vt-d: Fix usage of force parameter in
intel_ir_reconfigure_irte()

Jakub Kicinski (1):
       nfp: don't depend on eth_tbl being available

James Morse (2):
       KVM: arm64: Fix order of vcpu_write_sys_reg() arguments
       arm64: vgic-v2: Fix proxying of cpuif access

Jan Kara (1):
       bdi: Fix oops in wb_workfn()

Jason Gunthorpe (2):
       RDMA/ucma: Check for a cm_id->device in all user calls that need it
       uapi: Fix SPDX tags for files referring to the 'OpenIB.org' license

Javier Martinez Canillas (1):
       Input: atmel_mxt_ts - add missing compatible strings to OF device
table

Jerome Brunet (2):
       clk: honor CLK_MUX_ROUND_CLOSEST in generic clk mux
       clk: meson: honor CLK_MUX_ROUND_CLOSEST in clk_regmap

Jianbo Liu (1):
       net/mlx5e: Allow offloading ipv4 header re-write for icmp

Jianchao Wang (1):
       IB/rxe: add RXE_START_MASK for rxe_opcode IB_OPCODE_RC_SEND_ONLY_INV

Jiri Slaby (1):
       tools: power/acpi, revert to LD = gcc

Joel Pepper (1):
       usb: gadget: composite Allow for larger configuration descriptors

Joerg Roedel (1):
       iommu/vt-d: Use WARN_ON_ONCE instead of BUG_ON in qi_flush_dev_iotlb()

Johannes Thumshirn (1):
       nvmet: switch loopback target state to connecting when resetting

John Fastabend (10):
       bpf: Document sockmap '-target bpf' requirement for PROG_TYPE_SK_MSG
       bpf: sockmap sample use clang flag, -target bpf
       bpf: sockmap, map_release does not hold refcnt for pinned maps
       bpf: sockmap, sk_wait_event needed to handle blocking cases
       bpf: sockmap, fix double page_put on ENOMEM error in redirect path
       bpf: fix for lex/yacc build error with gcc-5
       bpf: fix uninitialized variable in bpf tools
       bpf: sockmap, fix scatterlist update on error path in send with apply
       bpf: sockmap, zero sg_size on error when buffer is released
       bpf: sockmap, fix error handling in redirect failures

John Hurley (1):
       nfp: flower: set tunnel ttl value to net default

Jon Maloy (1):
       tipc: fix bug in function tipc_nl_node_dump_monitor

João Paulo Rechi Vita (1):
       platform/x86: asus-wireless: Fix NULL pointer dereference

Julian Anastasov (1):
       ipv4: fix fnhe usage by non-cached routes

Karsten Graul (2):
       net/smc: call consolidation
       net/smc: handle unregistered buffers

Keith Busch (3):
       nvme: Set integrity flag for user passthrough commands
       nvme/multipath: Disable runtime writable enabling parameter
       nvme/multipath: Fix multipath disabled naming collisions

Lance Richardson (1):
       net: support compat 64-bit time in {s,g}etsockopt

Laura Abbott (1):
       x86/xen: Remove use of VLAs

Leon Romanovsky (4):
       RDMA/mlx5: Fix multiple NULL-ptr deref errors in rereg_mr flow
       RDMA/mlx5: Protect from shift operand overflow
       RDMA/mlx5: Properly check return value of mlx5_get_uars_page
       RDMA/mlx4: Add missed RSS hash inner header flag

Linus Torvalds (1):
       Linux 4.17-rc4

Long Li (1):
       scsi: storvsc: Set up correct queue depth values for IDE devices

Luc Van Oostenryck (3):
       usb: gadget: f_phonet: fix pn_net_xmit()'s return type
       IB/nes: fix nes_netdev_start_xmit()'s return type
       IB/ipoib: fix ipoib_start_xmit()'s return type

Luca Coelho (1):
       iwlwifi: mvm: fix old scan version sizes

Marc Zyngier (1):
       KVM: arm/arm64: vgic: Fix source vcpu issues for GICv2 SGI

Marcelo Ricardo Leitner (1):
       MAINTAINERS: add myself as SCTP co-maintainer

Mario Limonciello (1):
       platform/x86: Kconfig: Fix dell-laptop dependency chain.

Martin Blumenstingl (2):
       clk: meson: meson8b: fix meson8b_fclk_div3_div clock name
       clk: meson: meson8b: fix meson8b_cpu_clk parent clock name

Masahiro Yamada (2):
       gcc-plugins: fix build condition of SANCOV plugin
       kbuild: replace hardcoded bison in cmd_bison_h with $(YACC)

Masanari Iida (1):
       Input: hideep_ts - fix a typo in Kconfig

Matan Barak (1):
       IB/uverbs: Fix validating mandatory attributes

Mathias Nyman (1):
       xhci: Fix use-after-free in xhci_free_virt_device

Mathieu Desnoyers (2):
       selftests: Fix lib.mk run_tests target shell script
       tracepoint: Do not warn on ENOMEM

Matthew Wilcox (1):
       errseq: Always report a writeback error once

Mauro Carvalho Chehab (1):
       MAINTAINERS & files: Canonize the e-mails I use at files

Mauro Rossi (1):
       genksyms: fix typo in parse.tab.{c,h} generation rules

Maxime Chevallier (2):
       net: mvpp2: Fix clk error path in mvpp2_probe
       net: mvpp2: Fix clock resource by adding missing mg_core_clk

Mayank Rana (1):
       usb: dwc3: gadget: Fix list_del corruption in dwc3_ep_dequeue

Michael J. Ruhl (1):
       IB/hfi1 Use correct type for num_user_context

Michael S. Tsirkin (2):
       vhost: make msg padding explicit
       Revert "vhost: make msg padding explicit"

Michel Dänzer (1):
       swiotlb: fix inversed DMA_ATTR_NO_WARN test

Mike Marciniszyn (2):
       IB/hfi1: Fix handling of FECN marked multicast packet
       IB/hfi1: Fix loss of BECN with AHG

Neal Cardwell (1):
       tcp_bbr: fix to zero idle_restart only upon S/ACKed data

Nick Dyer (1):
       Input: atmel_mxt_ts - fix the firmware update

Omar Sandoval (2):
       blk-mq: count allocated but not started requests in iostats inflight
       blk-mq: fix sysfs inflight counter

Pali Rohár (1):
       Input: alps - fix reporting pressure of v3 trackstick

Parav Pandit (6):
       IB/core: Don't allow default GID addition at non reseved slots
       IB/core: Fix to avoid deleting IPv6 look alike default GIDs
       IB/core: Fix deleting default GIDs when changing mac adddress
       IB/mlx5: Fix represent correct netdevice in dual port RoCE
       RDMA/cma: Fix use after destroy access to net namespace for IPoIB
       RDMA/cma: Do not query GID during QP state transition to RTR

Peter Zijlstra (6):
       x86/tsc: Always unregister clocksource_tsc_early
       clocksource: Allow clocksource_mark_unstable() on unregistered
clocksources
       clocksource: Initialize cs->wd_list
       x86/tsc: Fix mark_tsc_unstable()
       clocksource: Consistent de-rate when marking unstable
       clocksource: Rework stale comment

Ping-Ke Shih (1):
       rtlwifi: cleanup 8723be ant_sel definition

Prashanth Prakash (1):
       cpufreq / CPPC: Set platform specific transition_delay_us

Qu Wenruo (1):
       btrfs: Fix wrong first_key parameter in replace_path

Raju Rangoju (1):
       RDMA/cxgb4: release hw resources on device removal

Ramon Fried (1):
       rpmsg: added MODULE_ALIAS for rpmsg_char

Randy Dunlap (1):
       infiniband: mlx5: fix build errors when INFINIBAND_USER_ACCESS=m

Rasmus Villemoes (2):
       modpost: delete stale comment
       MAINTAINERS: Update Kbuild entry with a few paths

Rishabh Bhatnagar (1):
       tracing: initcall: Ordered comparison of function pointers

Rob Gardner (1):
       sparc64: Fix mistake in oradax license text

Roland Dreier (1):
       RDMA/ucma: Allow resolving address w/o specifying source address

Roman Gushchin (1):
       bpf: disable and restore preemption in __BPF_PROG_RUN_ARRAY

SZ Lin (林上智) (2):
       NET: usb: qmi_wwan: add support for ublox R410M PID 0x90b2
       USB: serial: option: adding support for ublox R410M

Sean Paul (1):
       drm/bridge: vga-dac: Fix edid memory leak

Sebastian Sanchez (3):
       IB/hfi1: Fix NULL pointer dereference when invalid num_vls is used
       IB/{hfi1, rdmavt}: Fix memory leak in hfi1_alloc_devdata() upon
failure
       IB/hfi1: Fix memory leak in exception path in get_irq_affinity()

Shahar Klein (1):
       net/mlx5e: Fix traffic between VF and representor

Shameer Kolothum (1):
       iommu/dma: Move PCI window region reservation back into dma specific
path.

Shamir Rabinovitch (1):
       RDMA/ucma: ucma_context reference leak in error path

Song Liu (3):
       tracing: Fix bad use of igrab in trace_uprobe.c
       tracing: Remove igrab() iput() call from uprobes.c
       bpf: minor fix to selftest test_stacktrace_build_id()

Stefan Raspl (1):
       smc: fix sendpage() call

Takashi Iwai (4):
       ALSA: hda - Fix incorrect usage of IS_REACHABLE()
       ALSA: seq: Fix races at MIDI encoding in snd_virmidi_output_trigger()
       ALSA: aloop: Add missing cable lock to ctl API callbacks
       ALSA: pcm: Check PCM state at xfern compat ioctl

Takashi Sakamoto (1):
       ALSA: dice: fix kernel NULL pointer dereference due to invalid
calculation for array index

Talat Batheesh (1):
       net/mlx5: Avoid cleaning flow steering table twice during error flow

Tariq Toukan (1):
       net/mlx5e: TX, Use correct counter in dma_map error flow

Tetsuo Handa (2):
       bdi: wake up concurrent wb_shutdown() callers.
       bdi: Fix use after free bug in debugfs_remove()

Thomas Gleixner (1):
       x86/cpu: Restore CPUID_8000_0008_EBX reload

Thomas Hellstrom (2):
       drm/vmwgfx: Clean up fbdev modeset locking
       drm/vmwgfx: Fix a buffer object leak

Thomas Winter (1):
       ipv6: Allow non-gateway ECMP for IPv6

Tobias Jordan (1):
       remoteproc: qcom: Fix potential device node leaks

Tom Zanussi (3):
       tracing: Restore proper field flag printing when displaying triggers
       tracing: Add field parsing hist error for hist triggers
       tracing: Add field modifier parsing hist error for hist triggers

Tomeu Vizoso (1):
       usb: dwc2: dwc2_vbus_supply_init: fix error check

Ursula Braun (2):
       net/smc: keep clcsock reference in smc_tcp_listen_work()
       net/smc: restrict non-blocking connect finish

Valentin Schneider (1):
       KVM: arm/arm64: vgic_init: Cleanup reference to process_maintenance

Vittorio Gambaletta (VittGam) (1):
       Input: atmel_mxt_ts - add touchpad button mapping for Samsung
Chromebook Pro

Vivien Didelot (1):
       MAINTAINERS: add davem in NETWORKING DRIVERS

Wei Yongjun (2):
       usb: dwc2: pci: Fix error return code in dwc2_pci_probe()
       usb: dwc3: gadget: dwc3_gadget_del_and_unmap_request() can be static

Wenwen Wang (1):
       ethtool: fix a potential missing-check bug

William Tu (1):
       bpf: clear the ip_tunnel_info.

Wolfram Sang (1):
       MAINTAINERS: Rakesh Iyer can't be reached anymore

Xin Long (5):
       sctp: handle two v4 addrs comparison in sctp_inet6_cmp_addr
       sctp: clear the new asoc's stream outcnt in sctp_stream_update
       sctp: init active key for the new asoc in dupcook_a and dupcook_b
       sctp: use the old asoc when making the cookie-ack chunk in dupcook_d
       sctp: fix the issue that the cookie-ack with auth can't get processed

Yixun Lan (1):
       clk: meson: drop meson_aoclk_gate_regmap_ops

Yuchung Cheng (1):
       tcp: ignore Fast Open on repair mode

Zhengyuan Liu (1):
       tracing: Fix the file mode of stack tracer

Zhu Yanjun (2):
       IB/mlx5: remove duplicate header file
       IB/rxe: avoid double kfree_skb

ethanwu (1):
       btrfs: Take trans lock before access running trans in
check_delayed_ref

oulijun (10):
       RDMA/hns: Bugfix for init hem table
       RDMA/hns: Intercept illegal RDMA operation when use inline data
       RDMA/hns: Fix the qp context state diagram
       RDMA/hns: Only assign mtu if IB_QP_PATH_MTU bit is set
       RDMA/hns: Remove some unnecessary attr_mask judgement
       RDMA/hns: Only assign dqpn if IB_QP_PATH_DEST_QPN bit is set
       RDMA/hns: Adjust the order of cleanup hem table
       RDMA/hns: Update assignment method for owner field of send wqe
       RDMA/hns: Submit bad wr
       RDMA/hns: Fix a couple misspellings
