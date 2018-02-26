Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeBZDFK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 22:05:10 -0500
Received: from mail-it0-f42.google.com ([209.85.214.42]:39761 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751945AbeBZDFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 22:05:08 -0500
X-Google-Smtp-Source: AG47ELvMm7muF7NIx6N/aNX1yiZI9/s2G3NEsVOyWsH4ykn2iJfYSoif1naWsBQ30u3GaBZjdgNl/SGT0bqQ+x4pRi4=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 25 Feb 2018 19:05:06 -0800
X-Google-Sender-Auth: FAJDldk9P0PxndKrhq_lmVAfTXQ
Message-ID: <CA+55aFxk5KBxL9DvRtBivP3hKT-aOAzvSA_B47L1+y0P2GLe_A@mail.gmail.com>
Subject: Linux 4.16-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're on the normal schedule for 4.16 and everything still looks very regular.

rc3 is larger than rc2 was, but as mentioned last week, that's
expected - rc2 really was tiny. People have started finding things to
fix, but there's nothing that really stands out as particularly scary
here.

"Small changes all over" is the word.

About half the changes are drivers (networking, rdma, scsi, usb, gpu),
with half of the remainder being core networking (most of it
netfilter, but it's all over). The remaining 25% of the patch is
"misc" - arch fixes, core kernel and vm, security subsystem, and
tooling being the main stuff.

The appended shortlog gives an overview of the details for interested parties.

                          Linus

---

AMAN DEEP (1):
      usb: ohci: Proper handling of ed_rm_list to handle race
condition between usb_kill_urb() and finish_unlinks()

Adam Borowski (1):
      vsprintf: avoid misleading "(null)" for %px

Adit Ranadive (1):
      RDMA/vmw_pvrdma: Fix usage of user response structures in ABI file

Alaa Hleihel (1):
      IB/ipoib: Do not warn if IPoIB debugfs doesn't exist

Alexander Usyskin (1):
      mei: me: add cannon point device ids

Alexandru Ardelean (2):
      staging: iio: adc: ad7192: fix external frequency setting
      staging: iio: ad5933: switch buffer mode to software

Alexey Kodanev (2):
      udplite: fix partial checksum initialization
      macvlan: fix use-after-free in macvlan_common_newlink()

Anders Roxell (4):
      selftests/memfd: add run_fuse_test.sh to TEST_FILES
      lib/Kconfig.debug: enable RUNTIME_TESTING_MENU
      selftests/bpf: tcpbpf_kern: use in6_* macros from glibc
      selftests/bpf: update gitignore with test_libbpf_open

Andi Kleen (1):
      certs/blacklist_nohashes.c: fix const confusion in certs blacklist

Andrea Parri (3):
      locking/xchg/alpha: Add unconditional memory barrier to cmpxchg()
      locking/xchg/alpha: Clean up barrier usage by using smp_mb() in
place of __ASM__MB
      locking/xchg/alpha: Fix xchg() and cmpxchg() memory ordering bugs

Andreas Kemnade (1):
      usb: musb: fix enumeration after resume

Andreas Klinger (1):
      iio: srf08: fix link error "devm_iio_triggered_buffer_setup" undefined

Andrew Morton (1):
      include/linux/sched/mm.h: re-inline mmdrop()

Andrew Vasquez (1):
      scsi: qedi: Fix truncation of CHAP name and secret

Andy Shevchenko (1):
      i2c: designware: Consider SCL GPIO optional

Andy Spencer (1):
      gianfar: simplify FCS handling and fix memory leak

Arnd Bergmann (8):
      staging: fsl-mc: fix build testing on x86
      cfg80211: fix cfg80211_beacon_dup
      drm/exynos: g2d: use monotonic timestamps
      x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()
      Kbuild: always define endianess in kconfig.h
      bug.h: work around GCC PR82365 in BUG()
      bpf: clean up unused-variable warning
      ipv6 sit: work around bogus gcc-8 -Wrestrict warning

Avraham Stern (1):
      cfg80211: clear wep keys after disconnection

Bart Van Assche (3):
      scsi: qla2xxx: Avoid triggering undefined behavior in
qla2x00_mbx_completion()
      scsi: scsi_dh: Document alua_rtpg_queue() arguments
      scsi: qla2xxx: Fix a locking imbalance in qlt_24xx_handle_els()

Ben Gardner (1):
      i2c: designware: must wait for enable

Ben Hutchings (1):
      staging: android: ashmem: Fix a race condition in pin ioctls

Bharata B Rao (1):
      powerpc/mm/drmem: Fix unexpected flag value in ibm,dynamic-memory-v2

Bhupesh Sharma (1):
      arm64: Fix compilation error while accessing MPIDR_HWID_BITMASK
from .S files

Bill.Baker@oracle.com (1):
      nfs: system crashes after NFS4ERR_MOVED recovery

Bin Liu (1):
      Revert "usb: musb: host: don't start next rx urb if current one failed"

Boris Pismenny (3):
      tls: retrun the correct IV in getsockopt
      tls: reset the crypto info if copy_from_user fails
      tls: getsockopt return record sequence number

Brian Norris (1):
      usb: dwc3: Undo PHY init if soft reset fails

Casey Leedom (1):
      PCI/cxgb4: Extend T3 PCI quirk to T4+ devices

Chad Dupuis (1):
      scsi: bnx2fc: Fix check in SCSI completion handler for timed out request

Chris Wilson (1):
      drm: Handle unexpected holes in color-eviction

Christophe JAILLET (1):
      iio: adc: aspeed: Fix error handling path

Colin Ian King (3):
      scsi: csiostor: remove redundant assignment to pointer 'ln'
      gpu: ipu-v3: make const arrays int_reg static, shrinks object size
      NFS: make struct nlmclnt_fl_close_lock_ops static

Cong Wang (2):
      netfilter: ipt_CLUSTERIP: fix a race condition of proc file creation
      netfilter: ipt_CLUSTERIP: fix a refcount bug in
clusterip_config_find_get()

Corentin Labbe (3):
      scsi: aic7xxx: remove aiclib.c
      scsi: Remove Makefile entry for oktagon files
      drm/exynos: remove exynos_drm_rotator.h

Dan Carpenter (3):
      scsi: sym53c8xx_2: iterator underflow in sym_getsync()
      scsi: mptfusion: Add bounds check in mptctl_hp_targetinfo()
      net: aquantia: Fix error handling in aq_pci_probe()

Daniel Axtens (3):
      docs: segmentation-offloads.txt: update for UFO depreciation
      docs: segmentation-offloads.txt: Fix ref to SKB_GSO_TUNNEL_REMCSUM
      docs: segmentation-offloads.txt: add SCTP info

Daniel Borkmann (4):
      bpf: fix bpf_prog_array_copy_to_user warning from perf event prog query
      bpf: fix mlock precharge on arraymaps
      bpf, x64: implement retpoline for tail call
      bpf, arm64: fix out of bounds access in tail call

Daniel Jurgens (1):
      net/mlx5: Use 128B cacheline size for 128B or larger cachelines

Daniel Vetter (1):
      drm/cirrus: Load lut in crtc_commit

David Ahern (1):
      net: ipv4: Set addr_type in hash_keys for forwarded case

David Howells (3):
      rxrpc: Work around usercopy check
      KEYS: Use individual pages in big_key for crypto buffers
      rxrpc: Fix send in rxrpc_send_data_packet()

David Rientjes (1):
      kernel/relay.c: limit kmalloc size to KMALLOC_MAX_SIZE

David S. Miller (1):
      skbuff: Fix comment mis-spelling.

Devesh Sharma (2):
      RDMA/bnxt_re: Disable atomic capability on bnxt_re adapters
      RDMA/bnxt_re: Unpin SQ and RQ memory if QP create fails

Dominik Bozek (1):
      usb: cdc_acm: prevent race at write to acm while system resumes

Dou Liyang (1):
      x86/topology: Fix function name in documentation

Enric Balletbo i Serra (1):
      usb: dwc3: of-simple: fix oops by unbalanced clk disable call

Eran Ben Elisha (1):
      net/mlx5e: Verify inline header size do not exceed SKB linear size

Eric Anholt (1):
      i2c: bcm2835: Set up the rising/falling edge delays

Eric Biggers (6):
      binder: check for binder_thread allocation failure in binder_poll()
      PKCS#7: fix certificate chain verification
      PKCS#7: fix certificate blacklisting
      PKCS#7: fix direct verification of SignerInfo signature
      X.509: fix BUG_ON() when hash algorithm is unsupported
      X.509: fix NULL dereference when restricting key with unsupported_sig

Eric Dumazet (8):
      bpf: fix sock_map_alloc() error path
      netfilter: xt_hashlimit: fix lock imbalance
      tun: fix tun_napi_alloc_frags() frag allocator
      netfilter: IDLETIMER: be syzkaller friendly
      smsc75xx: fix smsc75xx_set_features()
      tcp_bbr: better deal with suboptimal GSO
      bpf: add schedule points in percpu arrays management
      net_sched: gen_estimator: fix broken estimators based on percpu stats

Eugenia Emantayev (1):
      net/mlx5: E-Switch, Fix drop counters use before creation

Fabio Estevam (1):
      usb: phy: mxs: Fix NULL pointer dereference on i.MX23/28

Fabrice Gasnier (1):
      iio: adc: stm32: fix stm32h7_adc_enable error handling

Felix Fietkau (1):
      mac80211: round IEEE80211_TX_STATUS_HEADROOM up to multiple of 4

Finn Thain (1):
      net/smc9194: Remove bogus CONFIG_MAC reference

Florian Westphal (10):
      netfilter: add back stackpointer size checks
      netfilter: x_tables: remove pr_info where possible
      netfilter: x_tables: use pr ratelimiting in xt core
      netfilter: xt_CT: use pr ratelimiting
      netfilter: xt_NFQUEUE: use pr ratelimiting
      netfilter: xt_set: use pr ratelimiting
      netfilter: bridge: use pr ratelimiting
      netfilter: x_tables: rate-limit table mismatch warnings
      netfilter: x_tables: use pr ratelimiting in matches/targets
      netfilter: x_tables: use pr ratelimiting in all remaining spots

Frederic Barrat (1):
      ocxl: Fix potential bad errno on irq allocation

Gal Pressman (2):
      net/mlx5e: Fix TCP checksum in LRO buffers
      net/mlx5e: Specify numa node when allocating drop rq

Ganesh Goudar (1):
      cxgb4: free up resources of pf 0-3

Geert Uytterhoeven (2):
      ravb: Remove obsolete explicit clock handling for WoL
      sh_eth: Remove obsolete explicit clock handling for WoL

H.J. Lu (1):
      x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Hans de Goede (3):
      extcon: axp288: Constify the axp288_pwr_up_down_info array
      Revert "extcon: axp288: Redo charger type detection a couple of
seconds after probe()"
      extcon: int3496: process id-pin first so that we start with the
right status

Hauke Mehrtens (1):
      uapi/if_ether.h: move __UAPI_DEF_ETHHDR libc define

Himanshu Madhani (1):
      scsi: qla2xxx: Fix incorrect handle for abort IOCB

Huang Ying (1):
      mm, swap, frontswap: fix THP swap if frontswap enabled

Ido Schimmel (1):
      mlxsw: spectrum_router: Do not unconditionally clear route
offload indication

Ilan Peer (2):
      mac80211: Do not disconnect on invalid operating class
      mac80211: Fix sending ADDBA response for an ongoing session

Ilya Lesokhin (1):
      tcp: Honor the eor bit in tcp_mtu_probe

Inbar Karmy (1):
      net/mlx5e: Fix loopback self test when GRO is off

Ingo Molnar (1):
      treewide/trivial: Remove ';;$' typo noise

Ingo van Lil (1):
      net: phy: fix wrong mask to phy_modify()

Jacek Anaszewski (1):
      MAINTAINERS: Remove Richard Purdie from LED maintainers

Jack Pham (2):
      usb: gadget: f_fs: Process all descriptors during bind
      usb: gadget: f_fs: Use config_ep_by_speed()

Jack Stocker (1):
      Add delay-init quirk for Corsair K70 RGB keyboards

Jakub Kicinski (1):
      net: fix race on decreasing number of TX queues

James Hogan (1):
      MIPS: Drop spurious __unused in struct compat_flock

Jan Glauber (1):
      net: cavium: fix NULL pointer dereference in cavium_ptp_put

Jan Luebbe (1):
      gpu: ipu-csi: add 10/12-bit grayscale support to mbus_code_to_bus_cfg

Jani Nikula (1):
      drm/tve200: fix kernel-doc documentation comment include

Jarkko Nikula (1):
      i2c: i801: Add missing documentation entries for Braswell and Kaby Lake

Jason A. Donenfeld (1):
      netlink: put module reference if dump start fails

Jason Gunthorpe (6):
      IB/uverbs: Use inline data transfer for UHW_IN
      IB/uverbs: Use u64_to_user_ptr() not a union
      IB/uverbs: Use __aligned_u64 for uapi headers
      IB/uverbs: Hold the uobj write lock after allocate
      IB/uverbs: Improve lockdep_check
      IB/uverbs: Fix unbalanced unlock on error path for rdma_explicit_destroy

Jason Wang (2):
      ptr_ring: prevent integer overflow when calculating size
      bpf: cpumap: use GFP_KERNEL instead of GFP_ATOMIC in
__cpu_map_entry_alloc()

Jeremy Cline (1):
      tools/libbpf: Avoid possibly using uninitialized variable

Jesper Dangaard Brouer (5):
      Revert "net: thunderx: Add support for xdp redirect"
      virtio_net: disable XDP_REDIRECT in receive_mergeable() case
      virtio_net: fix XDP code path in receive_small()
      virtio_net: fix memory leak in XDP_REDIRECT
      virtio_net: fix ndo_xdp_xmit crash towards dev not ready for XDP

Jiri Pirko (3):
      mlxsw: spectrum_router: Fix error path in mlxsw_sp_vr_create
      net: sched: don't set q pointer for shared blocks
      net: sched: fix tc_u_common lookup

Joe Lee (1):
      xhci: workaround for AMD Promontory disabled ports wakeup

Johannes Berg (3):
      cfg80211: use only 1Mbps for basic rates in mesh
      mac80211_hwsim: don't use WQ_MEM_RECLAIM
      regulatory: add NUL to request alpha2

Johannes Weiner (1):
      mm: memcontrol: fix NR_WRITEBACK leak in memcg and system stats

John Keeping (1):
      usb: gadget: f_uac2: fix bFirstInterface in composite gadget

Juan J. Alvarez (1):
      powerpc/eeh: Fix crashes in eeh_report_resume()

Juergen Gross (1):
      mm: don't defer struct page initialization for Xen pv guests

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA

Kamil Konieczny (1):
      crypto: s5p-sss - Fix kernel Oops in AES-ECB mode

KarimAllah Ahmed (1):
      x86/headers/UAPI: Use __u64 instead of u64 in <uapi/asm/hyperv.h>

Karsten Koop (1):
      usb: ldusb: add PIDs for new CASSY devices supported by this driver

Kees Cook (3):
      NFC: llcp: Limit size of SDP URI
      kconfig.h: Include compiler types to avoid missed struct attributes
      MIPS: boot: Define __ASSEMBLY__ for its.S build

Kristian Evensen (1):
      USB: serial: option: Add support for Quectel EP06

Lars-Peter Clausen (1):
      iio: adis_lib: Initialize trigger before requesting interrupt

Leo (Sunpeng) Li (1):
      drm/atomic: Fix memleak on ERESTARTSYS during non-blocking commits

Leon Romanovsky (9):
      RDMA/restrack: Remove unimplemented XRCD object
      RDMA/uverbs: Protect from races between lookup and destroy of uobjects
      RDMA/uverbs: Protect from command mask overflow
      RDMA/restrack: Increment CQ restrack object before committing
      RDMA/uverbs: Fix bad unlock balance in ib_uverbs_close_xrcd
      RDMA/uverbs: Fix circular locking dependency
      RDMA/uverbs: Sanitize user entered port numbers prior to access it
      RDMA/verbs: Check existence of function prior to accessing it
      RDMA/uverbs: Fix kernel panic while using XRC_TGT QP type

Li Zhijian (1):
      selftests/bpf/test_maps: exit child process without error in ENOMEM case

Liam Mark (1):
      staging: android: ion: Zero CMA allocated memory

Linus Torvalds (1):
      Linux 4.16-rc3

Lukas Wunner (5):
      workqueue: Allow retrieval of current task's work struct
      drm: Allow determining if current task is output poll worker
      drm/nouveau: Fix deadlock on runtime suspend
      drm/radeon: Fix deadlock on runtime suspend
      drm/amdgpu: Fix deadlock on runtime suspend

Manish Rangankar (1):
      scsi: qla4xxx: skip error recovery in case of register disconnect.

Manu Gautam (2):
      usb: dwc3: core: Power-off core/PHYs on system_suspend in host mode
      usb: gadget: core: Fix use-after-free of usb_request

Mark Lord (1):
      powerpc/bpf/jit: Fix 32-bit JIT for seccomp_data access

Mark Rutland (9):
      ARM: ux500: remove PMU IRQ bouncer
      arm_pmu: kill arm_pmu_platdata
      arm_pmu: fold platform helpers into platform code
      arm_pmu: add armpmu_alloc_atomic()
      arm_pmu: acpi: check for mismatched PPIs
      arm_pmu: explicitly enable/disable SPIs at hotplug
      arm_pmu: note IRQs and PMUs per-cpu
      arm_pmu: acpi: request IRQs up-front
      arm64: perf: correct PMUVer probing

Markus Elfring (1):
      drm/exynos: g2d: Delete an error message for a failed memory
allocation in two functions

Martijn Coenen (1):
      ANDROID: binder: synchronize_rcu() when using POLLFREE.

Martin Kelly (1):
      tools: fix cross-compile var clobbering

Matan Barak (4):
      IB/uverbs: Always use the attribute size provided by the user
      IB/uverbs: Fix method merging in uverbs_ioctl_merge
      IB/uverbs: Add ioctl support for 32bit processes
      IB/uverbs: Fix possible oops with duplicate ioctl attributes

Mathias Nyman (1):
      xhci: Don't print a warning when setting link state for disabled ports

Max Filippov (2):
      xtensa: fix high memory/reserved memory collision
      xtensa: support DMA buffers in high memory

Meelis Roos (1):
      scsi: aacraid: fix shutdown crash when init fails

Michael Bringmann (1):
      powerpc/pseries: Revert support for ibm,drc-info devtree property

Michael Clark (1):
      Rename sbi_save to parse_dtb to improve code readability

Michael Ellerman (3):
      powerpc/pseries: Fix duplicate firmware feature for DRC_INFO
      powerpc/pseries: Support firmware disable of RFI flush
      powerpc/powernv: Support firmware disable of RFI flush

Michael Kelley (EOSG) (1):
      scsi: storvsc: Increase cmd_per_lun for higher speed devices

Michael Weiser (2):
      arm64: Disable unhandled signal log messages by default
      arm64: Remove unimplemented syscall log message

Michal Hocko (2):
      netfilter: x_tables: remove size check
      vmalloc: fix __GFP_HIGHMEM usage for vmalloc_32 on 32b systems

Mika Westerberg (2):
      net: thunderbolt: Tear down connection properly on suspend
      net: thunderbolt: Run disconnect flow asynchronously when logout
is received

Mike Rapoport (2):
      mm/zpool.c: zpool_evictable: fix mismatch in parameter name and kernel-doc
      mm/swap.c: make functions and their kernel-doc agree (again)

Mikulas Patocka (1):
      mvpp2: fix multicast address filter

Minas Harutyunyan (2):
      usb: dwc2: Add safety check in setting of descriptor chain pointers
      usb: dwc2: Add safety check for STSPHSERCVD intr

Neil Armstrong (1):
      drm/meson: fix vsync buffer update

Nilesh Javali (1):
      scsi: qedi: Cleanup local str variable

Or Gerlitz (4):
      net/mlx5e: Eliminate build warnings on no previous prototype
      net/mlx5: Address static checker warnings on non-constant initializers
      net/mlx5e: Return error if prio is specified when offloading
eswitch vlan push
      net/mlx5: Add header re-write to the checks for conflicting actions

Paolo Abeni (4):
      netfilter: drop outermost socket lock in getsockopt()
      netfilter: x_tables: fix missing timer initialization in xt_LED
      netfilter: nat: cope with negative port range
      dn_getsockoptdecnet: move nf_{get/set}sockopt outside sock lock

Patryk Kocielnik (1):
      i2c: busses: i2c-sirf: Fix spelling: "formular" -> "formula".

Peter Chen (2):
      usb: host: ehci: use correct device pointer for dma ops
      usb: host: ehci: always enable interrupt for qtd completion at test mode

Peter Oh (1):
      mac80211: mesh: fix wrong mesh TTL offset calculation

Peter Zijlstra (1):
      locking/mutex: Add comment to __mutex_owner() to deter usage

Philipp Zabel (5):
      gpu: ipu-cpmem: add 8-bit grayscale support to ipu_cpmem_set_image
      gpu: ipu-cpmem: add 16-bit grayscale support to ipu_cpmem_set_image
      drm/edid: quirk Oculus Rift headsets as non-desktop
      drm/edid: quirk Windows Mixed Reality headsets as non-desktop
      drm/edid: quirk Sony PlayStation VR headset as non-desktop

Prashant Sreedharan (1):
      tg3: APE heartbeat changes

Pratyush Anand (1):
      arm64: fix unwind_frame() for filtered out fn for function graph tracing

Quentin Monnet (2):
      tools: bpftool: preserve JSON for batch mode when dumping insns to file
      tools: bpftool: preserve JSON output on errors on batch file parsing

Quinn Tran (2):
      scsi: qla2xxx: Fix memory corruption during hba reset test
      scsi: qla2xxx: Fix double free bug after firmware timeout

Rahul Lakkireddy (1):
      cxgb4: fix trailing zero in CIM LA dump

Randy Dunlap (2):
      fs/signalfd: fix build error for BUS_MCEERR_AR
      integrity/security: fix digsig.c build error with header file

Rasmus Villemoes (1):
      ida: do zeroing in ida_pre_get()

Robin Murphy (1):
      arm64: uaccess: Formalise types for access_ok()

Roger Quadros (2):
      usb: dwc3: omap: don't miss events during suspend/resume
      usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_init
during suspend/resume

Roman Kapl (1):
      net: sched: report if filter is too large to dump

Samuel Neves (1):
      x86/topology: Update the 'cpu cores' field in /proc/cpuinfo
correctly across CPU hotplug operations

Sara Sharon (2):
      mac80211: fix a possible leak of station stats
      mac80211: fix calling sleeping function in atomic context

Selvin Xavier (3):
      RDMA/bnxt_re: Synchronize destroy_qp with poll_cq
      RDMA/bnxt_re: Fix system crash during load/unload
      RDMA/bnxt_re: Avoid system hang during device un-reg

Shakeel Butt (1):
      mm, mlock, vmscan: no more skipping pagevecs

Shigeru Yoshida (1):
      ohci-hcd: Fix race condition caused by ohci_urb_enqueue() and
io_watchdog_func()

Shuah Khan (1):
      usbip: keep usbip_device sockfd state in sync with tcp_socket

Sowmini Varadhan (1):
      rds: do not call ->conn_alloc with GFP_KERNEL

Stefan Agner (1):
      usb: gadget: fsl_udc_core: fix ep valid checks

Stefan Windfeldt-Prytz (1):
      iio: buffer: check if a buffer has been set up when poll is called

Stefano Brivio (1):
      fib_semantics: Don't match route with mismatching tclassid

Steve Wise (1):
      RDMA/restrack: don't use uaccess_kernel()

Subash Abhinov Kasiviswanathan (3):
      net: qualcomm: rmnet: Fix crash on real dev unregistration
      net: qualcomm: rmnet: Fix warning seen with 64 bit stats
      net: qualcomm: rmnet: Fix possible null dereference in command processing

Sujit Reddy Thumma (1):
      scsi: ufs: Enable quirk to ignore sending WRITE_SAME command

Sylwester Nawrocki (1):
      drm: exynos: Use proper macro definition for HDMI_I2S_PIN_SEL_1

Thinh Nguyen (3):
      usb: dwc3: gadget: Set maxpacket size for ep0 IN
      usb: dwc3: ep0: Reset TRB counter for ep0 IN
      usb: dwc3: Fix GDBGFIFOSPACE_TYPE values

Thomas Falcon (7):
      ibmvnic: Wait until reset is complete to set carrier on
      ibmvnic: Fix login buffer memory leaks
      ibmvnic: Fix NAPI structures memory leak
      ibmvnic: Free RX socket buffer in case of adapter error
      ibmvnic: Clean RX pool buffers during device close
      ibmvnic: Check for NULL skb's in NAPI poll routine
      ibmvnic: Fix early release of login buffer

Thomas Gleixner (2):
      genirq/matrix: Handle CPU offlining proper
      x86/apic/vector: Handle vector release on CPU unplug correctly

Tobias Jordan (2):
      gpu: ipu-v3: pre: fix device node leak in ipu_pre_lookup_by_phandle
      gpu: ipu-v3: prg: fix device node leak in ipu_prg_lookup_by_phandle

Tobias Klauser (1):
      net: af_unix: fix typo in UNIX_SKB_FRAGS_SZ comment

Todd Kjos (2):
      ANDROID: binder: remove WARN() for redundant txn error
      binder: replace "%p" with "%pK"

Tom Lendacky (1):
      amd-xgbe: Restore PCI interrupt enablement setting on resume

Tomas Henzl (1):
      scsi: mpt3sas: fix an out of bound write

Tomas Winkler (2):
      mei: set device client to the disconnected state upon suspend.
      mei: me: add cannon point device ids for 4th device

Tony Luck (1):
      efivarfs: Limit the rate for non-root to read files

Trond Myklebust (1):
      NFSv4: Fix broken cast in nfs4_callback_recallany()

Tycho Andersen (3):
      seccomp, ptrace: switch get_metadata types to arch independent
      ptrace, seccomp: tweak get_metadata behavior slightly
      seccomp: add a selftest for get_metadata

Tyrel Datwyler (1):
      scsi: ibmvfc: fix misdefined reserved field in ibmvfc_fcp_rsp_info

Ulf Magnusson (4):
      usb: gadget: udc: Remove USB_GADGET_DUALSPEED select
      riscv: Remove ARCH_WANT_OPTIONAL_GPIOLIB select
      riscv: kconfig: Remove RISCV_IRQ_INTC select
      riscv: Remove ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE select

Vardan Mikayelyan (1):
      usb: dwc2: Fix dwc2_hsotg_core_init_disconnected()

Vlad Buslov (1):
      net/mlx5: Fix error handling when adding flow rules

Wang Hui (1):
      x86/intel_rdt: Fix incorrect returned value when creating
rdgroup sub-directory in resctrl file system

Wei Yongjun (1):
      USB: gadget: udc: Add missing platform_device_put() on error in
bdc_pci_probe()

Will Deacon (3):
      arm64: cpufeature: Fix CTR_EL0 field definitions
      arm64: __show_regs: Only resolve kernel symbols when running at EL1
      arm64: Enforce BBM for huge IO/VMAP mappings

Wolfram Sang (1):
      drm/exynos: fix comparison to bitshift when dealing with a mask

Xin Long (6):
      bridge: check brport attr show in brport_show
      sctp: do not pr_err for the duplicated node in transport rhlist
      sctp: add SCTP_CID_I_DATA and SCTP_CID_I_FWD_TSN conversion in sctp_cname
      sctp: remove the useless check in sctp_renege_events
      sctp: fix some copy-paste errors for file comments
      sctp: remove the left unnecessary check for chunk in sctp_renege_events

Ying Xue (7):
      tipc: Refactor __tipc_nl_compat_doit
      tipc: Introduce __tipc_nl_bearer_disable
      tipc: Introduce __tipc_nl_bearer_enable
      tipc: Introduce __tipc_nl_bearer_set
      tipc: Introduce __tipc_nl_media_set
      tipc: Introduce __tipc_nl_net_set
      tipc: Fix missing RTNL lock protection during setting link properties

Yonghong Song (2):
      bpf: fix memory leak in lpm_trie map_free callback function
      bpf: fix rcu lockdep warning for lpm_trie map_free callback

Yoshihiro Shimoda (3):
      usb: gadget: udc: renesas_usb3: fix oops in renesas_usb3_remove()
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path
      usb: renesas_usbhs: missed the "running" flag in usb_dmac with rx path

Zhengjun Xing (4):
      xhci: Fix NULL pointer in xhci debugfs
      xhci: Fix xhci debugfs devices node disappearance after hibernation
      xhci: xhci debugfs device nodes weren't removed after device plugged out
      xhci: fix xhci debugfs errors in xhci_stop

Zhu Lingshan (1):
      .gitignore: ignore ASN.1 auto generated files

zongbox@gmail.com (1):
      RISC-V: Enable IRQ during exception handling
