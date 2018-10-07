Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606D1C00449
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4482084D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 15:45:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4482084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbeJGWxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 18:53:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47880 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbeJGWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 18:53:16 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B57EA6965;
        Sun,  7 Oct 2018 15:45:33 +0000 (UTC)
Date:   Sun, 7 Oct 2018 17:45:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Linux 4.19-rc7
Message-ID: <20181007154529.GA4493@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Yet again, it's time for a kernel -rc release.  This one is bigger than
-rc6 was, for a variety of unrelated reasons it seems.  Lots of
different trees being merged this week, much more so than the previous
one.  Highlights include two sets of networking fixes, lots of different
driver subsystem fixes, arm and arm64 and x86 and riscv and powerpc64
fixes, as well as scheduler, iommu, and vfs fixes.  Not a huge quantity
overall, just overall a lot of different things.

Given the current rate of change, and looking at the travel/conference
schedule happening this month, it seems like we will be having a -rc8
just to be sure 4.19 is solid as well as not having to be in the middle
of a merge window during a conference week.  Please go test and make
sure any remaining problems are sent in in time.

thanks,

greg k-h

Adam Jackson (1):
      uvesafb: Fix URLs in the documentation

Alaa Hleihel (1):
      net/mlx5e: Avoid unbounded peer devices when unpairing TC hairpin rules

Alan Tull (3):
      fpga: do not access region struct after fpga_region_unregister
      fpga: bridge: fix obvious function documentation error
      docs: fpga: document fpga manager flags

Alex Xu (Hello71) (1):
      r8169: always autoneg on resume

Alexandre Belloni (1):
      soc: fsl: qbman: qman: avoid allocating from non existing gen_pool

Amelie Delaunay (1):
      ARM: dts: stm32: update SPI6 dmas property on stm32mp157c

Amir Goldstein (5):
      ovl: fix memory leak on unlink of indexed file
      ovl: fix freeze protection bypass in ovl_write_iter()
      ovl: fix freeze protection bypass in ovl_clone_file_range()
      vfs: swap names of {do,vfs}_clone_file_range()
      ovl: fix access beyond unterminated strings

Andreas Gruenbacher (1):
      sysfs: Do not return POSIX ACL xattrs via listxattr

Andrei Otcheretianski (3):
      mac80211: Always report TX status
      mac80211: Don't wake up from PS for offchannel TX
      cfg80211: reg: Init wiphy_idx in regulatory_hint_core()

Andrew Lunn (1):
      net: phy: sfp: Fix unregistering of HWMON SFP device

Andy Lutomirski (4):
      x86/vdso: Fix asm constraints on vDSO syscall fallbacks
      selftests/x86: Add clock_gettime() tests to test_vdso
      x86/vdso: Only enable vDSO retpolines when enabled and supported
      x86/vdso: Fix vDSO syscall fallback asm constraint regression

Anisse Astier (1):
      HID: i2c-hid: disable runtime PM operations on hantick touchpad

Anshuman Khandual (2):
      mm/migrate.c: split only transparent huge pages when allocation fails
      mm/hugetlb: add mmap() encodings for 32MB and 512MB page sizes

Antoine Tenart (1):
      MAINTAINERS: update the Annapurna Labs maintainer email

Anusha Srivatsa (1):
      drm/i915: Do not redefine the has_csr parameter.

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Atish Patra (1):
      RISCV: Fix end PFN for low memory

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Baruch Siach (1):
      net: phy: phylink: fix SFP interface autodetection

Bjorn Andersson (1):
      firmware: Always initialize the fw_priv list object

Bjorn Helgaas (1):
      MAINTAINERS: Remove obsolete drivers/pci pattern from ACPI section

Bob Copeland (1):
      mac80211: fix pending queue hang due to TX_DROP

Brian Foster (6):
      xfs: remove last of unnecessary xfs_defer_cancel() callers
      xfs: don't unlock invalidated buf on aborted tx commit
      xfs: clean up xfs_trans_brelse()
      xfs: refactor xfs_buf_log_item reference count handling
      xfs: remove invalid log recovery first/last cycle check
      iomap: set page dirty after partial delalloc on mkwrite

Chris Wilson (2):
      drm/i915: Avoid compiler warning for maybe unused gu_misc_iir
      drm/i915: Handle incomplete Z_FINISH for compressed error states

Christoph Hellwig (2):
      xfs: don't bring in extents in xfs_bmap_punch_delalloc_range
      xfs: skip delalloc COW blocks in xfs_reflink_end_cow

Christophe Leroy (1):
      powerpc/lib: fix book3s/32 boot failure due to code patching

Chunfeng Yun (1):
      usb: xhci-mtk: resume USB3 roothub first

Colin Ian King (4):
      drm/i2c: tda9950: fix timeout counter check
      i2c: i2c-isch: fix spelling mistake "unitialized" -> "uninitialized"
      qed: fix spelling mistake "toogle" -> "toggle"
      wimax/i2400m: fix spelling mistake "not unitialized" -> "uninitialized"

Dan Carpenter (1):
      net: sched: act_ipt: check for underflow in __tcf_ipt_init()

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Drake (1):
      PCI: Reprogram bridge prefetch registers on resume

Darrick J. Wong (1):
      xfs: don't crash the vfs on a garbage inline symlink

Dave Chinner (3):
      xfs: avoid lockdep false positives in xfs_trans_alloc
      xfs: fix transaction leak in xfs_reflink_allocate_cow()
      xfs: fix error handling in xfs_bmap_extents_to_btree

Dave Jones (1):
      bond: take rcu lock in netpoll_send_skb_on_dev

Dave Martin (1):
      arm64: KVM: Tighten guest core register access from userspace

David Ahern (4):
      netfilter: bridge: Don't sabotage nf_hook calls from an l3mdev
      net/ipv6: Remove extra call to ip6_convert_metrics for multipath case
      rtnetlink: Fail dump if target netnsid is invalid
      net: sched: Add policy validation for tc attributes

David Howells (8):
      rxrpc: Remove dup code from rxrpc_find_connection_rcu()
      rxrpc: Fix checks as to whether we should set up a new call
      rxrpc: Fix RTT gathering
      rxrpc: Emit BUSY packets when supposed to rather than ABORTs
      rxrpc: Improve up-front incoming packet checking
      rxrpc: Make service call handling more robust
      rxrpc: Fix transport sockopts to get IPv4 errors on an IPv6 socket
      rxrpc: Fix error distribution

David S. Miller (1):
      Revert "net: phy: fix WoL handling when suspending the PHY"

Davide Caratti (1):
      be2net: don't flip hw_features when VXLANs are added/deleted

Dexuan Cui (1):
      Drivers: hv: vmbus: Use get/put_cpu() in vmbus_connect()

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Eran Ben Elisha (1):
      net/mlx5: E-Switch, Fix out of bound access when setting vport rate

Eric Dumazet (18):
      netpoll: do not test NAPI_STATE_SCHED in poll_one_napi()
      hinic: remove ndo_poll_controller
      ehea: remove ndo_poll_controller
      net: hns: remove ndo_poll_controller
      virtio_net: remove ndo_poll_controller
      qlcnic: remove ndo_poll_controller
      qlogic: netxen: remove ndo_poll_controller
      net: ena: remove ndo_poll_controller
      sfc: remove ndo_poll_controller
      sfc-falcon: remove ndo_poll_controller
      ibmvnic: remove ndo_poll_controller
      tcp/dccp: fix lockdep issue when SYN is backlogged
      tun: remove unused parameters
      tun: initialize napi_mutex unconditionally
      tun: napi flags belong to tfile
      inet: make sure to grab rcu_read_lock before using ireq->ireq_opt
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()

Eric Sandeen (2):
      xfs: don't treat unknown di_flags2 as corruption in scrub
      xfs: validate inode di_forkoff

Felix Fietkau (2):
      mac80211: allocate TXQs for active monitor interfaces
      mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Felix Kuehling (1):
      drm/amdkfd: Fix incorrect use of process->mm

Flavio Leitner (3):
      netfilter: xt_socket: check sk before checking for netns.
      Revert "openvswitch: Fix template leak in error cases."
      openvswitch: load NAT helper

Florian Fainelli (10):
      ARM: dts: BCM63xx: Fix incorrect interrupt specifiers
      asix: Check for supported Wake-on-LAN modes
      ax88179_178a: Check for supported Wake-on-LAN modes
      lan78xx: Check for supported Wake-on-LAN modes
      sr9800: Check for supported Wake-on-LAN modes
      r8152: Check for supported Wake-on-LAN Modes
      smsc75xx: Check for Wake-on-LAN modes
      smsc95xx: Check for Wake-on-LAN modes
      net: systemport: Fix wake-up interrupt race during resume
      net: dsa: b53: Keep CPU port as tagged in all VLANs

Florian Westphal (1):
      netfilter: avoid erronous array bounds warning

Geert Uytterhoeven (3):
      dm raid: remove bogus const from decipher_sync_action() return type
      Revert "serial: sh-sci: Remove SCIx_RZ_SCIFA_REGTYPE"
      Revert "serial: sh-sci: Allow for compressed SCIF address"

Greg Kroah-Hartman (1):
      Linux 4.19-rc7

Guenter Roeck (2):
      Revert "serial: 8250_dw: Fix runtime PM handling"
      locking/ww_mutex: Fix runtime warning in the WW mutex selftest

Gustavo A. R. Silva (2):
      video/fbdev/stifb: Fix spelling mistake in fall-through annotation
      sctp: fix fall-through annotation

Hangbin Liu (1):
      vxlan: fill ttl inherit info

Hans Verkuil (1):
      drm/i2c: tda9950: set MAX_RETRIES for errors only

Hans de Goede (3):
      HID: i2c-hid: Remove RESEND_REPORT_DESCR quirk and its handling
      efifb: BGRT: Add nobgrt option
      r8169: Disable clk during suspend / resume

Harsh Jain (1):
      crypto: chelsio - Fix memory corruption in DMA Mapped buffers.

Heiner Kallweit (4):
      net: phy: fix WoL handling when suspending the PHY
      net: core: add member wol_enabled to struct net_device
      net: phy: fix WoL handling when suspending the PHY
      r8169: fix network stalls due to missing bit TXCFG_AUTO_FIFO

Horia Geantă (1):
      crypto: caam/jr - fix ablkcipher_edesc pointer arithmetic

Icenowy Zheng (1):
      ARM: dts: sun8i: drop A64 HDMI PHY fallback compatible from R40 DT

Ido Schimmel (2):
      mlxsw: spectrum: Delete RIF when VLAN device is removed
      team: Forbid enslaving team device to itself

Jakub Kicinski (1):
      nfp: avoid soft lockups under control message storm

Jan Beulich (3):
      xen-netback: fix input validation in xenvif_set_hash_mapping()
      xen-netback: validate queue numbers in xenvif_set_hash_mapping()
      xen-netback: handle page straddling in xenvif_set_hash_mapping()

Jann Horn (5):
      drm: fix use-after-free read in drm_mode_create_lease_ioctl()
      bpf: 32-bit RSH verification must truncate input before the ALU op
      proc: restrict kernel stack dumps to root
      mm/vmstat.c: fix outdated vmstat_text
      mm/vmstat.c: skip NR_TLB_REMOTE_FLUSH* properly

Jarkko Nikula (1):
      i2c: designware: Call i2c_dw_clk_rate() only when calculating timings

Jean Delvare (1):
      s390: qeth: Fix potential array overrun in cmd/rc lookup

Jianbo Liu (1):
      net/mlx5e: Set vlan masks for all offloaded TC rules

Jianfeng Tan (1):
      net/packet: fix packet drop as of virtio gso

Jiri Olsa (1):
      perf/ring_buffer: Prevent concurent ring buffer access

Joe Thornber (1):
      dm cache metadata: ignore hints array being too small during resize

Joel Stanley (1):
      lib/xz: Put CRC32_POLY_LE in xz_private.h

Johan Hovold (2):
      USB: serial: option: add two-endpoints device-id flag
      USB: serial: simple: add Motorola Tetra MTP6550 id

Johannes Berg (2):
      mac80211: TDLS: fix skb queue/priority assignment
      netlink: fix typo in nla_parse_nested() comment

Jouni Malinen (1):
      cfg80211: Address some corner cases in scan result channel updating

Kai-Heng Feng (1):
      ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Kan Liang (1):
      perf/x86/intel/uncore: Fix PCI BDF address of M3UPI on SKX

Kees Cook (2):
      pstore/ram: Fix failure-path memory leak in ramoops_init
      ipc/shm.c: use ERR_CAST() for shm_lock() error return

Kirill A. Shutemov (1):
      mm, thp: fix mlocking THP page with migration enabled

Kirill Tkhai (1):
      mm/vmscan.c: fix int overflow in callers of do_shrink_slab()

Kristian Evensen (1):
      USB: serial: option: improve Quectel EP06 detection

LUU Duc Canh (2):
      tipc: fix failover problem
      tipc: ignore STATE_MSG on wrong link session

Larry Chen (1):
      ocfs2: fix crash in ocfs2_duplicate_clusters_by_page()

Larry Finger (1):
      b43: fix DMA error related regression with proprietary firmware

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Liran Alon (3):
      KVM: nVMX: Do not expose MPX VMX controls when guest MPX disabled
      KVM: x86: Do not use kvm_x86_ops->mpx_supported() directly
      KVM: nVMX: Fix emulation of VM_ENTRY_LOAD_BNDCFGS

Lubomir Rintel (1):
      pxa168fb: prepare the clock

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl

Maciej W. Rozycki (1):
      declance: Fix continuation with the adapter identification message

Maciej Żenczykowski (1):
      net-tcp: /proc/sys/net/ipv4/tcp_probe_interval is a u32 not int

Mahesh Bandewar (3):
      bonding: pass link-local packets to bonding master also.
      bonding: avoid possible dead-lock
      bonding: fix warning message

Marc Zyngier (1):
      arm64: KVM: Sanitize PSTATE.M when being set from userspace

Marek Szyprowski (2):
      mmc: slot-gpio: Fix debounce time to use miliseconds again
      drm/exynos: Use selected dma_dev default iommu domain instead of a fake one

Martin Willi (3):
      mac80211_hwsim: fix locking when iterating radios during ns exit
      mac80211_hwsim: fix race in radio destruction from netlink notifier
      mac80211_hwsim: do not omit multicast announce of first added radio

Masashi Honma (2):
      nl80211: Fix possible Spectre-v1 for NL80211_TXRATE_HT
      nl80211: Fix possible Spectre-v1 for CQM RSSI thresholds

Masayoshi Mizuma (1):
      perf/x86/intel/uncore: Use boot_cpu_data.phys_proc_id instead of hardcorded physical package ID 0

Mathias Nyman (1):
      xhci: Add missing CAS workaround for Intel Sunrise Point xHCI

Mathieu Desnoyers (1):
      rseq/selftests: fix parametrized test with -fpie

Matias Karhumaa (1):
      Bluetooth: SMP: fix crash in unpairing

Mauricio Faria de Oliveira (1):
      rtnetlink: fix rtnl_fdb_dump() for ndmsg header

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offload

Mel Gorman (3):
      sched/numa: Limit the conditions where scan period is reset
      mm, sched/numa: Remove rate-limiting of automatic NUMA balancing migration
      sched/numa: Migrate pages to local nodes quicker early in the lifetime of a task

Michael Chan (2):
      bnxt_en: Fix TX timeout during netpoll.
      bnxt_en: Fix VNIC reservations on the PF.

Michael Ellerman (1):
      powerpc: Don't print kernel instructions in show_user_instructions()

Michal Simek (1):
      net: macb: Clean 64b dma addresses if they are not detected

Mika Westerberg (2):
      thunderbolt: Do not handle ICM events after domain is stopped
      thunderbolt: Initialize after IOMMUs

Mike Kravetz (2):
      mm: migration: fix migration of huge PMD shared pages
      hugetlb: take PMD sharing into account when flushing tlb/caches

Mike Snitzer (3):
      dm thin metadata: fix __udivdi3 undefined on 32-bit
      dm mpath: fix attached_handler_name leak and dangling hw_handler_name pointer
      dm cache: fix resize crash if user doesn't reload cache table

Mike Travis (2):
      x86/platform/uv: Provide is_early_uv_system()
      x86/tsc: Fix UV TSC initialization

Miklos Szeredi (1):
      ovl: fix format of setxattr debug

Natarajan, Janakarajan (1):
      perf/x86/amd/uncore: Set ThreadMask and SliceMask for L3 Cache perf events

Nathan Chancellor (6):
      qed: Avoid implicit enum conversion in qed_set_tunn_cls_info
      qed: Fix mask parameter in qed_vf_prep_tunn_req_tlv
      qed: Avoid implicit enum conversion in qed_roce_mode_to_flavor
      qed: Avoid constant logical operation warning in qed_vf_pf_acquire
      qed: Avoid implicit enum conversion in qed_iwarp_parse_rx_pkt
      x86/cpu/amd: Remove unnecessary parentheses

Nilesh Javali (1):
      scsi: qedi: Initialize the stats mutex lock

Nir Dotan (1):
      mlxsw: pci: Derive event type from event queue number

Noralf Trønnes (1):
      drm/cma-helper: Fix crash in fbdev error path

Paolo Bonzini (3):
      KVM: x86: never trap MSR_KERNEL_GS_BASE
      KVM: VMX: hide flexpriority from guest when disabled at the module level
      kvm: nVMX: fix entry with pending interrupt if APICv is enabled

Parthasarathy Bhuvaragan (3):
      tipc: fix flow control accounting for implicit connect
      tipc: reset bearer if device carrier not ok
      tipc: lock wakeup & inputq at tipc_link_reset()

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Avoid crash from THP collapse during radix page fault

Pavel Machek (1):
      iwlwifi: 1000: set the TFD queue size

Peter Zijlstra (1):
      perf/core: Fix perf_pmu_unregister() locking

Rafael J. Wysocki (1):
      PM / core: Clear the direct_complete flag on errors

Randy Dunlap (1):
      cfg80211: fix reg_query_regdb_wmm kernel-doc

Ricardo Ribalda Delgado (1):
      gpiolib: Free the last requested descriptor

Rickard x Andersson (1):
      net: fec: fix rare tx timeout

Romain Izard (1):
      usb: cdc_acm: Do not leak URB buffers

Roman Gushchin (2):
      bpf: harden flags check in cgroup_storage_update_elem()
      bpf: don't accept cgroup local storage with zero value size

Ronnie Sahlberg (2):
      cifs: add a warning if we try to to dequeue a deleted mid
      cifs: only wake the thread for the very last PDU in a compound

Sakari Ailus (1):
      media: v4l: event: Prevent freeing event subscriptions while accessed

Sean Christopherson (2):
      KVM: x86: fix L1TF's MMIO GFN calculation
      KVM: VMX: check for existence of secondary exec controls before accessing

Sean Tranchetti (2):
      xfrm: validate template mode
      net: qualcomm: rmnet: Skip processing loopback packets

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Shanthosh RK (1):
      net: bpfilter: Fix type cast and pointer warnings

Shirish S (1):
      drm/amd/display: Signal hw_done() after waiting for flip_done()

Singh, Brijesh (1):
      iommu/amd: Clear memory encryption mask from physical address

Song Liu (1):
      ixgbe: check return value of napi_complete_done()

Sowmini Varadhan (2):
      xfrm: reset transport header back to network header after all input transforms ahave been applied
      xfrm: reset crypto_done when iterating over multiple input xfrms

Srikar Dronamraju (6):
      sched/numa: Stop multiple tasks from moving to the CPU at the same time
      sched/numa: Pass destination CPU as a parameter to migrate_task_rq
      sched/numa: Reset scan rate whenever task moves across nodes
      mm/migrate: Use spin_trylock() while resetting rate limit
      sched/numa: Avoid task migration for small NUMA improvement
      powerpc/numa: Skip onlining a offline node in kdump path

Srinivas Pandruvada (1):
      HID: intel-ish-hid: Enable Ice Lake mobile

Stanislaw Gruszka (1):
      mt76x0: fix remove_interface

Stefan Agner (2):
      ARM: 8787/1: wire up io_pgetevents syscall
      netfilter: nft_osf: use enum nft_data_types for nft_validate_register_store

Stefan Raspl (1):
      tools/kvm_stat: cut down decimal places in update interval dialog

Stefan Seyfried (1):
      cfg80211: fix wext-compat memory leak

Steffen Klassert (2):
      xfrm: Validate address prefix lengths in the xfrm selector.
      xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.

Stephen Boyd (1):
      i2c: i2c-qcom-geni: Properly handle DMA safe buffers

Stephen Hemminger (1):
      MAINTAINERS: change bridge maintainers

Steve Capper (2):
      arm64: hugetlb: Fix handling of young ptes
      arm64: hugetlb: Avoid unnecessary clearing in huge_ptep_set_access_flags

Steve French (1):
      smb3: fix lease break problem introduced by compounding

Subash Abhinov Kasiviswanathan (2):
      net: qualcomm: rmnet: Fix incorrect allocation flag in transmit
      net: qualcomm: rmnet: Fix incorrect allocation flag in receive path

Sudarsana Reddy Kalluru (2):
      Update maintainers for bnx2/bnx2x/qlge/qlcnic drivers.
      qed: Fix shmem structure inconsistency between driver and the mfw.

Taehee Yoo (1):
      netfilter: nft_set_rbtree: add missing rb_erase() in GC routine

Takashi Iwai (1):
      ALSA: hda: Fix the audio-component completion timeout

Thadeu Lima de Souza Cascardo (1):
      xfrm6: call kfree_skb when skb is toobig

Thomas Petazzoni (2):
      ARM: 8799/1: mm: fix pci_ioremap_io() offset check
      PCI: mvebu: Fix PCI I/O mapping creation sequence

Tomi Valkeinen (1):
      fbdev/omapfb: fix omapfb_memory_read infoleak

Tony Lindgren (1):
      mmc: core: Fix debounce time to use microseconds

Vasundhara Volam (2):
      bnxt_en: Fix enables field in HWRM_QUEUE_COS2BW_CFG request
      bnxt_en: get the reduced max_irqs by the ones used by RDMA

Venkat Duvvuru (1):
      bnxt_en: free hwrm resources, if driver probe fails.

Vitaly Kuznetsov (1):
      tools: hv: fcopy: set 'error' in case an unknown operation was requested

Waiman Long (1):
      crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

Wei Wang (1):
      ipv6: take rcu lock in rawv6_send_hdrinc()

Wei Yongjun (1):
      ovl: make symbol 'ovl_aops' static

Wenwen Wang (2):
      net: cxgb3_main: fix a missing-check bug
      yam: fix a missing-check bug

Will Deacon (1):
      MAINTAINERS: Remove dead path from LOCKING PRIMITIVES entry

Wolfram Sang (1):
      mmc: sdhi: sys_dmac: check for all Gen3 types when whitelisting

Xue Liu (1):
      ieee802154: mcr20a: Replace magic number with constants

Yu Zhao (2):
      cfg80211: fix use-after-free in reg_process_hint()
      net/usb: cancel pending work when unbinding smsc75xx

Yuan-Chi Pang (1):
      mac80211: fix TX status reporting for ieee80211s

YueHaibing (3):
      ieee802154: Use kmemdup instead of duplicating it in ca8210_test_int_driver_write
      xfs: remove duplicated include from alloc.c
      mm/gup_benchmark: fix unsigned comparison to zero in __gup_benchmark_ioctl

Yunsheng Lin (1):
      net: hns: fix for unmapping problem when SMMU is on

Zhao Qiang (1):
      soc: fsl: qe: Fix copy/paste bug in ucc_get_tdm_sync_shift()

zhong jiang (4):
      netfilter: conntrack: get rid of double sizeof
      ieee802154: remove unecessary condition check before debugfs_remove_recursive
      ieee802154: ca8210: remove redundant condition check before debugfs_remove
      s390: qeth_core_mpc: Use ARRAY_SIZE instead of reimplementing its function

