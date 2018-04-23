Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753953AbeDWCoZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 22:44:25 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34763 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753889AbeDWCoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 22:44:23 -0400
X-Google-Smtp-Source: AIpwx48/x6O3jsZ7tkg6A061GUcLpYrbTzkWYNCb6/6h4f9vT+tf+Vzu3rnyGsIAcfiocKQRp0a2JYKEM1dulsyCPUA=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Apr 2018 19:44:22 -0700
X-Google-Sender-Auth: ACtyMFUAgvLac7GeHUIhibUXaoo
Message-ID: <CA+55aFwzkGuq5ASF-vhYj7mEX26V0K+uZCLWi1BLYq+9F1n-Rw@mail.gmail.com>
Subject: Linux 4.17-rc2
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3N2iXiR000488

So rc2 is out, and things look fairly normal.

The diff looks a bit unusual, with the tools subdirectory dominating,
with 30%+ of the whole diff. Mostly perf and test scripts.

But if you ignore that, the rest looks fairly usual. Arch updates
(s390 and x86 dominate) and drivers (networking, gpu, HID, mmc, misc)
are the bulk of it, with misc other changes all over (filesystems,
core kernel, networking, docs).

We've still got some known fallout from the merge window, but it
shouldn't affect most normal configurations, so go out and test.

             Linus

---

Aaron Armstrong Skomra (1):
      HID: wacom: bluetooth: send exit report for recent Bluetooth devices

Aaron Ma (1):
      HID: i2c-hid: Fix resume issue on Raydium touchscreen device

Al Viro (5):
      hypfs_kill_super(): deal with failed allocations
      jffs2_kill_sb(): deal with failed allocations
      orangefs_kill_sb(): deal with allocation failures
      rpc_pipefs: fix double-dput()
      Don't leak MNT_INTERNAL away from internal mounts

Alexey Budankov (4):
      perf stat: Enable 1ms interval for printing event counters values
      perf/core: Store context switch out type in PERF_RECORD_SWITCH[_CPU_WIDE]
      perf report: Extend raw dump (-D) out with switch out event type
      perf script: Extend misc field decoding with switch out event type

Alexey Dobriyan (2):
      proc: revalidate kernel thread inodes to root:root
      proc: fix /proc/loadavg regression

Alison Schofield (1):
      x86,sched: Allow topologies where NUMA nodes share an LLC

Amir Goldstein (4):
      fanotify: fix logic of events on child
      fsnotify: fix ignore mask logic in send_to_group()
      fsnotify: fix typo in a comment about mark->g_list
      MAINTAINERS: add an entry for FSNOTIFY infrastructure

Anders Roxell (1):
      selftests: net: add in_netns.sh to TEST_PROGS

Andi Kleen (4):
      perf mem: Allow all record/report options
      perf hists browser: Clarify top/report browser help
      perf record: Remove misleading error suggestion
      perf record: Remove suggestion to enable APIC

Andrey Konovalov (1):
      kasan: add no_sanitize attribute for clang builds

Anson Huang (5):
      dt-bindings: timer: tpm: fix typo of clock name
      clocksource/drivers/imx-tpm: Fix typo of clock name
      clocksource/drivers/imx-tpm: Correct some registers operation flow
      clocksource/drivers/imx-tpm: Add different counter width support
      clocksource/imx-tpm: Correct -ETIME return condition check

Arnaldo Carvalho de Melo (11):
      perf annotate: Allow showing offsets in more than just jump targets
      perf annotate browser: Allow showing offsets in more than just
jump targets
      perf jvmti: Give hints about package names needed to build
      perf tests bpf: Remove unused ptrace.h include from LLVM test
      Revert "x86/asm: Allow again using asm.h when building for the
'bpf' clang target"
      perf report: Fix switching to another perf.data file
      perf annotate: Allow setting the offset level in .perfconfig
      perf annotate: Handle variables in 'sub', 'or' and many other instructions
      perf trace: Support MAP_FIXED_NOREPLACE
      perf tests mmap: Show which tracepoint is failing
      perf test BPF: Fixup BPF test using epoll_pwait syscall function probe

Arnd Bergmann (1):
      rbd: avoid Wreturn-type warnings

Aurelien Aptel (1):
      CIFS: fix typo in cifs_dbg

Baolin Wang (1):
      timekeeping: Remove __current_kernel_time()

Bartlomiej Zolnierkiewicz (1):
      dt-bindings: thermal: remove no longer needed samsung thermal properties

Benjamin Herrenschmidt (1):
      powerpc/xive: Fix trying to "push" an already active pool VP

Bert Kenward (1):
      sfc: check RSS is active for filter insert

Bjørn Mork (1):
      tun: fix vlan packet truncation

Changbin Du (2):
      drm/i915/gvt: Missed to cancel dma map for ggtt entries
      drm/i915/gvt: Cancel dma map when resetting ggtt entries

Chengguang Xu (1):
      isofs: fix potential memory leak in mount option parsing

Chris Wilson (2):
      drm/i915/execlists: Clear user-active flag on preemption completion
      drm/i915: Call i915_perf_fini() on init_hw error unwind

Christoph Hellwig (1):
      x86: Remove pci-nommu.c

Colin Ian King (4):
      ecryptfs: fix spelling mistake: "cadidate" -> "candidate"
      kvm: selftests: fix spelling mistake: "divisable" and "divisible"
      net: caif: fix spelling mistake "UKNOWN" -> "UNKNOWN"
      atm: iphase: fix spelling mistake: "Tansmit" -> "Transmit"

Cong Wang (1):
      llc: hold llc_sap before release_sock()

Dan Carpenter (1):
      Revert "macsec: missing dev_put() on error in macsec_newlink()"

Dan Williams (6):
      libnvdimm, dimm: handle EACCES failures from label reads
      tools/testing/nvdimm: allow custom error code injection
      tools/testing/nvdimm: support nfit_test_dimm attributes under nfit_test.1
      tools/testing/nvdimm: fix missing newline in nfit_test_dimm
'handle' attribute
      tools/testing/nvdimm: enable labels for nfit_test.1 dimms
      Revert "libnvdimm, of_pmem: workaround OF_NUMA=n build error"

Daniel J Blueman (1):
      drm/vc4: Fix memory leak during BO teardown

Daniel Kurtz (1):
      mmc: sdhci-pci: Only do AMD tuning for HS200

Daniel Stone (3):
      drm/exynos: Move GEM BOs to drm_framebuffer
      drm/exynos: Move dma_addr out of exynos_drm_fb
      drm/exynos: exynos_drm_fb -> drm_framebuffer

Dave Jiang (2):
      device-dax: allow MAP_SYNC to succeed
      MAINTAINERS: Add backup maintainers for libnvdimm and DAX

Dave Young (1):
      kexec_file: do not add extra alignment to efi memmap

David Howells (2):
      afs: Fix server record deletion
      vfs: Undo an overly zealous MS_RDONLY -> SB_RDONLY conversion

David Sterba (1):
      btrfs: fix unaligned access in readdir

David Wang (1):
      ALSA: hda - New VIA controller suppor no-snoop path

Dmitry Torokhov (1):
      HID: input: fix battery level reporting on BT mice

Dongsheng Yang (1):
      rbd: support timeout in rbd_wait_state_locked()

Doron Roberts-Kedes (1):
      strparser: Fix incorrect strp->need_bytes value.

Dou Liyang (2):
      x86/acpi: Prevent X2APIC id 0xffffffff from being accounted
      x86/processor: Remove two unused function declarations

Eddie James (1):
      aspeed: watchdog: Set bootstatus during probe

Edward Cree (3):
      sfc: insert ARFS filters with replace_equal=true
      sfc: pass the correctly bogus filter_id to rps_may_expire_flow()
      sfc: limit ARFS workitems in flight per channel

Eric Biggers (1):
      KEYS: DNS: limit the length of option strings

Eric Dumazet (5):
      tcp: md5: reject TCP_MD5SIG or TCP_MD5SIG_EXT on established sockets
      net: validate attribute sizes in neigh_dump_table()
      net: af_packet: fix race in PACKET_{R|T}X_RING
      tipc: add policy for TIPC_NLA_NET_ADDR
      tipc: fix possible crash in __tipc_nl_net_set()

Fabián Inostroza (1):
      ALSA: line6: Use correct endpoint type for midi output

Gao Feng (1):
      net: Fix one possible memleak in ip_setup_cork

Gaurav K Singh (1):
      drm/i915/audio: Fix audio detection issue on GLK

Geert Uytterhoeven (1):
      clockevents: Fix kernel messages split across multiple lines

Gerd Hoffmann (1):
      drm/i915/gvt: throw error on unhandled vfio ioctls

Greg Thelen (1):
      writeback: safer lock nesting

Guenter Roeck (1):
      ecryptfs: lookup: Don't check if mount_crypt_stat is NULL

Guillaume Nault (3):
      l2tp: hold reference on tunnels in netlink dumps
      l2tp: hold reference on tunnels printed in pppol2tp proc file
      l2tp: hold reference on tunnels printed in l2tp/tunnels debugfs file

Guoqing Jiang (1):
      md-cluster: don't update recovery_offset for faulty device

Gustavo A. R. Silva (5):
      drm/i915/gvt: Mark expected switch fall-through in handle_g2v_notification
      watchdog: sch311x_wdt: Mark expected switch fall-through
      watchdog: w83977f_wdt: Mark expected switch fall-through
      watchdog: wafer5823wdt: Mark expected switch fall-through
      cifs: smb2ops: Fix NULL check in smb2_query_symlink

Harry Wentland (1):
      drm/amd/display: Don't program bypass on linear regamma LUT

Heiko Carstens (4):
      s390/kexec_file: add generated files to .gitignore
      s390: add support for IBM z14 Model ZR1
      s390: remove gcov defconfig
      s390: rename default_defconfig to debug_defconfig

Helge Deller (1):
      parisc: Fix missing binfmt_elf32.o build error

Huang Ying (1):
      mm, pagemap: fix swap offset value for PMD migration entry

Hui Wang (2):
      ALSA: hda/realtek - set PINCFG_HEADSET_MIC to parse_flags
      ALSA: hda/realtek - adjust the location of one mic

Ian Kent (1):
      autofs: mount point create should honour passed in mode

Ilya Dryomov (3):
      rbd: refactor rbd_wait_state_locked()
      rbd: adjust queue limits for "fancy" striping
      rbd: notrim map option

Imre Deak (1):
      drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Ingo Molnar (1):
      tools/headers: Synchronize kernel ABI headers, v4.17-rc1

Ioan Nicu (1):
      rapidio: fix rio_dma_transfer error handling

Jakub Kicinski (2):
      nfp: ignore signals when communicating with management FW
      nfp: print a message when mutex wait is interrupted

Jan Kara (1):
      udf: Fix leak of UTF-16 surrogates into encoded strings

Jani Nikula (1):
      drm/i915/bios: filter out invalid DDC pins from VBT child devices

Jason Wang (1):
      virtio-net: add missing virtqueue kick when flushing packets

Jerry Hoemann (1):
      watchdog: hpwdt: change maintainer.

Jia-Ju Bai (6):
      fs: quota: Replace GFP_ATOMIC with GFP_KERNEL in dquot_init
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_probe
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in
pcistub_init_device
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in
pcistub_device_alloc
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in
xen_pcibk_config_quirks_init
      xen: xen-pciback: Replace GFP_ATOMIC with GFP_KERNEL in pcistub_reg_add

Jin Yao (3):
      perf script: Use HAVE_LIBXXX_SUPPORT to replace NO_LIBXXX
      perf tools: Rename HAVE_SYSCALL_TABLE to HAVE_SYSCALL_TABLE_SUPPORT
      perf version: Print status for syscall_table

Jiri Kosina (1):
      HID: i2c-hid: fix inverted return value from i2c_hid_command()

Jiri Olsa (3):
      perf: Return proper values for user stack errors
      perf: Fix sample_max_stack maximum check
      perf: Remove superfluous allocation error check

Joerg Roedel (3):
      x86/ldt: Fix support_pte_mask filtering in map_ldt_struct()
      x86/mm: Prevent kernel Oops in PTDUMP code with HIGHPTE=y
      x86/power/64: Fix page-table setup for temporary text mapping

Jon Maloy (3):
      tipc: fix unbalanced reference counter
      tipc: fix missing initializer in tipc_sendmsg()
      tipc: fix use-after-free in tipc_nametbl_stop

Jonathan Corbet (1):
      MAINTAINERS: Direct networking documentation changes to netdev

Jose Abreu (1):
      net: stmmac: Disable ACS Feature for GMAC >= 4

KarimAllah Ahmed (3):
      X86/VMX: Disable VMX preemption timer if MWAIT is not intercepted
      X86/KVM: Do not allow DISABLE_EXITS_MWAIT when LAPIC ARAT is not available
      X86/KVM: Properly update 'tsc_offset' to represent the running guest

Kees Cook (3):
      ibmvnic: Define vnic_login_client_data name field as unsized array
      net/tls: Remove VLA usage
      fork: unconditionally clear stack on fork

Kenneth Feng (1):
      drm/amd/powerplay: header file interface to SMU update

Kim Phillips (1):
      perf tests: Run dwarf unwind test on arm32

Krish Sadhukhan (1):
      x86: Add check for APIC access address for vmentry of L2 guests

Kyle Spiers (1):
      isofs compress: Remove VLA usage

Laura Abbott (3):
      mISDN: Remove VLAs
      objtool: Support HOSTCFLAGS and HOSTLDFLAGS
      posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated

Linus Torvalds (1):
      Linux 4.17-rc2

Liu, Changcheng (1):
      timers: Remove stale struct tvec_base forward declaration

Long Li (2):
      cifs: smbd: Check for iov length on sending the last iov
      cifs: smbd: Dump SMB packet when configured

Madhavan Srinivasan (1):
      powerpc/64s: Default l1d_size to 64K in RFI fallback flush

Mariusz Dabrowski (1):
      raid1: copy write hint from master bio to behind bio

Mark Rutland (3):
      tools headers: Restore READ_ONCE() C++ compatibility
      arm64: kasan: avoid pfn_to_nid() before page array is initialized
      arm64: signal: don't force known signals to SIGKILL

Martin Schwidefsky (3):
      s390/smsgiucv: disable SMSG on module unload
      s390: update defconfig
      s390/signal: cleanup uapi struct sigaction

Mathieu Poirier (1):
      coresight: Move to SPDX identifier

Matt Redfearn (5):
      MIPS: dts: Boston: Fix PCI bus dtc warnings:
      MIPS: memset.S: EVA & fault support for small_memset
      MIPS: memset.S: Fix return of __clear_user from Lpartial_fixup
      MIPS: memset.S: Fix clobber of v1 in last_fixup
      MIPS: uaccess: Add micromips clobbers to bzero invocation

Matthew Wilcox (1):
      mm/filemap.c: fix NULL pointer in page_cache_tree_insert()

Maxime Chevallier (2):
      net: mvpp2: Fix TCAM filter reserved range
      net: mvpp2: Fix DMA address mask size

Michael Ellerman (3):
      powerpc/lib: Fix off-by-one in alternate feature patching
      selftests/filesystems: Don't run dnotify_test by default
      powerpc/kvm: Fix lockups when running KVM guests on Power8

Michael Neuling (1):
      powerpc/eeh: Fix enabling bridge MMIO windows

Michael S. Tsirkin (3):
      virtio_net: split out ctrl buffer
      virtio_net: fix adding vids on big-endian
      virtio_net: sparse annotation fix

Michal Hocko (1):
      mm: fix do_pages_move status handling

Minchan Kim (1):
      mm: memcg: add __GFP_NOWARN in __memcg_schedule_kmem_cache_create()

Naoya Horiguchi (1):
      mm: enable thp migration for shmem thp

Nathan Fontenot (2):
      ibmvnic: Handle all login error conditions
      ibmvnic: Do not notify peers on parameter change resets

Nicolas Dechesne (1):
      net: qrtr: add MODULE_ALIAS_NETPROTO macro

Nikolay Borisov (1):
      btrfs: Fix race condition between delayed refs and blockgroup removal

Oleksandr Andrushchenko (1):
      xen/sndif: Sync up with the canonical definition in Xen

Olivier Gayot (1):
      docs: ip-sysctl.txt: fix name of some ipv6 variables

Oskar Senft (1):
      perf/x86/intel/uncore: Fix SBOX support for Broadwell CPUs

Paolo Abeni (1):
      team: avoid adding twice the same option to the event list

Paolo Bonzini (2):
      kvm: x86: move MSR_IA32_TSC handling to x86.c
      kvm: selftests: add vmx_tsc_adjust_test

Pawel Dembicki (1):
      net: qmi_wwan: add Wistron Neweb D19Q1

Peng Hao (1):
      kvm: selftests: add -std=gnu99 cflags

Petr Mladek (2):
      livepatch: Initialize shadow variables safely by a custom callback
      livepatch: Allow to call a custom callback when freeing shadow variables

Philipp Rudo (7):
      s390/kexec_file: Prepare setup.h for kexec_file_load
      s390/kexec_file: Add purgatory
      s390/kexec_file: Add kexec_file_load system call
      s390/kexec_file: Add image loader
      s390/kexec_file: Add crash support to image loader
      s390/kexec_file: Add ELF loader
      s390/Kconfig: Move kexec config options to "Processor type and features"

Pieter Jansen van Vuuren (2):
      nfp: flower: move route ack control messages out of the workqueue
      nfp: flower: split and limit cmsg skb lists

Qu Wenruo (5):
      btrfs: qgroup: Commit transaction in advance to reduce early EDQUOT
      btrfs: qgroup: Use independent and accurate per inode qgroup rsv
      btrfs: delayed-inode: Remove wrong qgroup meta reservation calls
      btrfs: Fix wrong btrfs_delalloc_release_extents parameter
      btrfs: print-tree: debugging output enhancement

Raghuram Chary J (1):
      lan78xx: PHY DSP registers initialization to address EEE link
drop issues with long cables

Ramalingam C (1):
      drm: Fix HDCP downstream dev count read

Randy Dunlap (1):
      textsearch: fix kernel-doc warnings and add kernel-api section

Ravi Bangoria (1):
      perf tools: Add '\n' at the end of parse-options error messages

Rex Zhu (1):
      drm/amd/pp: Fix bug voltage can't be OD separately on VI

Richard Cochran (1):
      net: dsa: mv88e6xxx: Fix receive time stamp race condition.

Rob Herring (1):
      libnvdimm, of_pmem: use dev_to_node() instead of of_node_to_nid()

Rodrigo Rivas Costa (1):
      HID: hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device

Ronak Doshi (1):
      vmxnet3: fix incorrect dereference when rxvlan is disabled

Sandipan Das (1):
      perf tests: Disable breakpoint accounting test for powerpc

Sebastian Ott (1):
      s390/nospec: include cpu.h

Simon Gaiser (1):
      xen: xenbus_dev_frontend: Really return response string

Sinan Kaya (2):
      MIPS: io: Prevent compiler reordering writeX()
      MIPS: io: Add barrier after register read in readX()

Soheil Hassas Yeganeh (1):
      tcp: clear tp->packets_out when purging write queue

Song Liu (1):
      trace_kprobe: Remove warning message "Could not insert probe at..."

Souptick Joarder (2):
      fs: ext2: Adding new return type vm_fault_t
      fs: cifs: Adding new return type vm_fault_t

Stefan Hajnoczi (1):
      VSOCK: make af_vsock.ko removable again

Stephane Eranian (1):
      perf/x86/intel/uncore: Revert "Remove SBOX support for Broadwell server"

Steve French (1):
      cifs: do not allow creating sockets except with SMB1 posix exensions

Subash Abhinov Kasiviswanathan (1):
      net: qualcomm: rmnet: Fix warning seen with fill_info

Takashi Iwai (1):
      ALSA: rawmidi: Fix missing input substream checks in compat ioctls

Takuya Yamamoto (1):
      perf sched: Fix documentation for timehist

Tetsuo Handa (2):
      mm,vmscan: Allow preallocating memory for register_shrinker().
      fs, elf: don't complain MAP_FIXED_NOREPLACE unless -EEXIST error

Theodore Ts'o (5):
      random: fix crng_ready() test
      random: use a different mixing algorithm for add_device_randomness()
      random: set up the NUMA crng instances after the CRNG is fully initialized
      random: crng_reseed() should lock the crng instance that it is modifying
      random: add new ioctl RNDRESEEDCRNG

Thomas Falcon (1):
      ibmvnic: Clear pending interrupt after device reset

Thomas Richter (3):
      perf record: Change warning for missing sysfs entry to debug
      s390/decompressor: Ignore file vmlinux.bin.full
      perf list: Add s390 support for detailed/verbose PMU event description

Tina Zhang (1):
      drm/i915/gvt: Add drm_format_mod update

Tomer Maimon (2):
      dt-binding: timer: document NPCM7xx timer DT bindings
      clocksource/drivers/npcm: Add NPCM7xx timer driver

Toshiaki Makita (1):
      vlan: Fix reading memory beyond skb->tail in skb_vlan_tagged_multi

Tung Nguyen (1):
      tipc: fix infinite loop when dumping link monitor summary

Tvrtko Ursulin (1):
      drm/i915/pmu: Inspect runtime PM state more carefully while estimating RC6

Tyler Hicks (1):
      eCryptfs: don't pass up plaintext names when using filename encryption

Ursula Braun (1):
      net/smc: fix shutdown in state SMC_LISTEN

Uwe Kleine-König (1):
      MAINTAINERS: add personal addresses for Sascha and Uwe

Vasily Gorbik (3):
      s390/sclp: avoid potential usage of uninitialized value
      s390/boot: remove unused COMPILE_VERSION and ccflags-y
      s390: remove couple of duplicate includes

Vasundhara Volam (1):
      bnxt_en: Fix memory fault in bnxt_ethtool_init()

Veeraiyan Chidambaram (1):
      watchdog: renesas-wdt: Add support for WDIOF_CARDRESET

Viresh Kumar (1):
      dt-bindings: thermal: Remove "cooling-{min|max}-level" properties

Wang Sheng-Hui (1):
      filter.txt: update 'tools/net/' to 'tools/bpf/'

Wolfgang Bumiller (1):
      net: fix deadlock while clearing neighbor proxy table

Wolfram Sang (1):
      mmc: renesas_sdhi_internal_dmac: limit DMA RX for old SoCs

Xiaoming Gao (1):
      x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Xidong Wang (1):
      drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Xin Long (1):
      sctp: do not check port in sctp_inet6_cmp_addr

Xiong Zhang (2):
      drm/i915/gvt: Delete redundant error message in fb_decode.c
      drm/i915/gvt: Disable primary/sprite/cursor plane at virtual
display initialization

Yan, Zheng (1):
      ceph: always update atime/mtime/ctime for new inode

Yufen Yu (1):
      md/raid1: exit sync request if MD_RECOVERY_INTR is set

Zhipeng Gong (1):
      drm/i915/gvt: Make MI_USER_INTERRUPT nop in cmd parser

dann frazier (1):
      net: hns: Avoid action name truncation

hu huajun (1):
      KVM: X86: fix incorrect reference of trace_kvm_pi_irte_update

sunlianwen (1):
      net: change the comment of dev_mc_init
