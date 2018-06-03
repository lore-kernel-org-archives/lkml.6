Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751368AbeFCV7M (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 17:59:12 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38151 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeFCV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 17:59:09 -0400
X-Google-Smtp-Source: ADUXVKJDDPwvpaJAShHIbslWhlJ1cU7eCVx3ezWkyOMDoHd/S9w5ep9bN9Ku/H93QLFrBVqaRVPzO0k2j5c600ivtrA=
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 3 Jun 2018 14:58:57 -0700
Message-ID: <CA+55aFxhx_tKGm02UySguvbyfB_7oTF31QfgOHCK0YkBvmfV0g@mail.gmail.com>
Subject: Linux 4.17
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w53LxIS7022440

So this last week was pretty calm, even if the pattern of most of the
stuff coming in on a Friday made it feel less so as the weekend
approached.

And while I would have liked even less changes, I really didn't get
the feeling that another week would help the release in any way, so
here we are, with 4.17 released.

No, I didn't call it 5.0, even though all the git object count
numerology was in place for that. It will happen in the not _too_
distant future, and I'm told all the release scripts on kernel.org are
ready for it, but I didn't feel there was any real reason for it. I
suspect that around 4.20 - which is I run out of fingers and toes to
keep track of minor releases, and thus start getting mightily confused
- I'll switch over. That was what happened for 4.0, after all.

As for the actual changes since rc7 - the shortlog is appended - it's
mostly drivers, networking, perf tooling, and a set of nds32 fixes.
With some random other stuff thrown in. Again, the shortlog is
obviously only the last calm week, the overall changes since 4.16 are
much too big to list in that format.

The big 4.17 stuff was mentioned in the rc1 email when the merge
window closed, but I guess it's worth repeating how 4.17 is actually a
slightly smaller kernel than 4.16, thanks to the removal of a number
of effectively dead architectures (blackfin, cris, frv, m32r, metag,
mn10300, score, and tile). Obviously all the other changes are much
more important, but it's always nice to see spring cleaning like that.

And with this, the merge window for 4.18 is obviously open. I actually
have some travel the second week of the merge window, which is very
inconvenient for me, but I do hope that we'll get all the big stuff
merged the first week and it won't impact any release scheduling. But
we'll have to see.

                      Linus


---

Aaron Ma (1):
      Input: synaptics - add Intertouch support on X1 Carbon 6th and X280

Al Viro (2):
      fix io_destroy()/aio_complete() race
      Revert "fs: fold open_check_o_direct into do_dentry_open"

Alex Williamson (1):
      Revert "vfio/type1: Improve memory pinning process for raw PFN mapping"

Alexander Duyck (1):
      net-sysfs: Fix memory leak in XPS configuration

Alexander Shishkin (2):
      stm class: Use vmalloc for the master map
      intel_th: Use correct device when freeing buffers

Antoine Tenart (1):
      crypto: inside-secure - do not use memset on MMIO

Ard Biesheuvel (1):
      net: netsec: reduce DMA mask to 40 bits

Arnaldo Carvalho de Melo (1):
      perf tools: Fix perf.data format description of NRCPUS header

Arnd Bergmann (1):
      IB: Revert "remove redundant INFINIBAND kconfig dependencies"

Bart Van Assche (1):
      scsi: scsi_transport_srp: Fix shost to rport translation

Benjamin Tissoires (2):
      Input: synaptics - add Lenovo 80 series ids to SMBus
      Input: elan_i2c_smbus - fix corrupted stack

Chris Wilson (3):
      drm/i915/lvds: Move acpi lid notification registration to
registration phase
      drm/i915/query: Protect tainted function pointer lookup
      drm/i915/query: nospec expects no more than an unsigned long

Damien Thébault (1):
      net: dsa: b53: Add BCM5389 support

Dan Carpenter (1):
      net: ethernet: davinci_emac: fix error handling in probe()

Daniel Borkmann (1):
      bpf: fix uapi hole for 32 bit compat applications

Daniele Palmas (1):
      net: usb: cdc_mbim: add flag FLAG_SEND_ZLP

Darrick J. Wong (1):
      fs: clear writeback errors in inode_init_always

David Francis (1):
      drm/amd/display: Make atomic-check validate underscan changes

David Howells (1):
      afs: Fix directory permissions check

Davidlohr Bueso (1):
      sched/headers: Fix typo

Devesh Sharma (1):
      RDMA/bnxt_re: Fix broken RoCE driver due to recent L2 driver changes

Dhinakaran Pandiyan (1):
      drm/psr: Fix missed entry in PSR setup time table.

Dmitry Torokhov (1):
      Input: synaptics - Lenovo Carbon X1 Gen5 (2017) devices should use RMI

Edvard Holst (1):
      Input: synaptics - Lenovo Thinkpad X1 Carbon G5 (2017) with
Elantech trackpoints should use RMI

Eric Dumazet (2):
      xfrm6: avoid potential infinite loop in _decode_session6()
      netfilter: provide correct argument to nla_strlcpy()

Eugen Hristev (2):
      iio: adc: at91-sama5d2_adc: fix channel configuration for
differential channels
      iio: adc: select buffer for at91-sama5d2_adc

Fabrice Gasnier (2):
      iio: adc: stm32-dfsdm: fix successive oversampling settings
      iio: adc: stm32-dfsdm: fix sample rate for div2 spi clock

Federico Vaga (1):
      i2c: ocores: update HDL sources URL

Finn Thain (1):
      net/sonic: Use dma_mapping_error()

George Cherian (1):
      i2c: xlp9xx: Add MAINTAINERS entry

Greentime Hu (12):
      nds32: lib: To use generic lib instead of libgcc to prevent the
symbol undefined issue.
      nds32: Fix building error when CONFIG_FREEZE is enabled.
      nds32: Fix building error of crypto/xor.c by adding xor.h
      nds32: Fix drivers/gpu/drm/udl/udl_fb.c building error by
defining PAGE_SHARED
      nds32: Fix xfs_buf built failed by export
invalidate_kernel_vmap_range and flush_kernel_vmap_range
      nds32: Fix the symbols undefined issue by exporting them.
      nds32: Fix the unknown type u8 issue.
      nds32: Fix build failed because arch_trace_hardirqs_off is
changed to trace_hardirqs_off.
      nds32: Fix the allmodconfig build. To make sure
CONFIG_CPU_LITTLE_ENDIAN is default y
      nds32: Fix the virtual address may map too much range by tlbop issue.
      nds32: To refine readability of INT_MASK_INITAIAL_VAL
      nds32: To fix a cache inconsistency issue by setting correct
cacheability of NTC

Greg Kroah-Hartman (1):
      hwtracing: stm: fix build error on some arches

Hans de Goede (1):
      iio: hid-sensor-trigger: Fix sometimes not powering up the
sensor after resume

Hao Wei Tee (1):
      iwlwifi: pcie: compare with number of IRQs requested for, not
number of CPUs

Hugh Dickins (2):
      mm/huge_memory.c: __split_huge_page() use atomic ClearPageDirty()
      mm: fix the NULL mapping case in __isolate_lru_page()

Ivan Bornyakov (1):
      atm: zatm: fix memcmp casting

Jason Wang (1):
      vhost_net: flush batched heads before trying to busy polling

Josh Hill (1):
      net: qmi_wwan: Add Netgear Aircard 779S

João Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Fix NULL pointer dereference

Julian Anastasov (1):
      ipvs: fix buffer overflow with sync daemon and service

Juri Lelli (1):
      sched/deadline: Fix missing clock update

Kan Liang (1):
      perf parse-events: Handle uncore event aliases in small groups properly

Kirill Tkhai (1):
      kcm: Fix use-after-free caused by clonned sockets

Leo (Sunpeng) Li (2):
      drm/amd/display: Fix BUG_ON during CRTC atomic check update
      drm/amd/display: Update color props when modeset is required

Leo Yan (1):
      perf script python: Add addr into perf sample dict

Linus Torvalds (1):
      Linux 4.17

Maciej W. Rozycki (2):
      MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs

Marc Dionne (1):
      afs: Fix mounting of backup volumes

Martin Kelly (2):
      iio:buffer: make length types match kfifo types
      iio:kfifo_buf: check for uint overflow

Mathias Kresin (1):
      MIPS: lantiq: gphy: Drop reboot/remove reset asserts

Mathieu Poirier (1):
      perf cs-etm: Fix indexing for decoder packet queue

Mathieu Xhonneux (1):
      ipv6: sr: fix memory OOB access in seg6_do_srh_encap/inline

Max Gurtovoy (1):
      nvme: fix extended data LBA supported setting

Michael Nosthoff (1):
      iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ

Mika Westerberg (1):
      thunderbolt: Handle NULL boot ACL entries properly

Neil Armstrong (1):
      drm/bridge/synopsys: dw-hdmi: fix dw_hdmi_setup_rx_sense

Nickhu (2):
      nds32: Renaming the file for unaligned access
      nds32: Fix the unaligned access handler

Nicolas Dichtel (2):
      ip_tunnel: restore binding to ifaces with a large mtu
      ip6_tunnel: remove magic mtu value 0xFFF8

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Ondřej Hlavatý (1):
      ixgbe: fix parsing of TC actions for HW offload

Pablo Neira Ayuso (2):
      netfilter: nft_limit: fix packet ratelimiting
      netfilter: nf_tables: disable preemption in nft_update_chain_stats()

Paolo Abeni (1):
      netfilter: ebtables: handle string from userspace with care

Parav Pandit (1):
      IB/core: Fix error code for invalid GID entry

Paul Blakey (1):
      cls_flower: Fix incorrect idr release when failing to modify rule

Paul Burton (1):
      sched/core: Require cpu_active() in select_task_rq(), for user tasks

Peter Zijlstra (1):
      sched/core: Fix rules for running on online && !active CPUs

Petr Machata (1):
      mlxsw: spectrum: Forbid creation of VLAN 1 over port/LAG

Philipp Rudo (1):
      s390/purgatory: Fix endless interrupt loop

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Samuel Mendoza-Jonas (1):
      net/ncsi: Fix array size in dumpit handler

Sebastian Ott (1):
      s390/dasd: use blk_mq_rq_from_pdu for per request data

Stanislaw Gruszka (1):
      Revert "rt2800: use TXOP_BACKOFF for probe frames"

Steffen Klassert (1):
      xfrm Fix potential error pointer dereference in xfrm_bundle_create.

Steven Rostedt (VMware) (2):
      tracing: Fix crash when freeing instances with event triggers
      tracing: Make the snapshot trigger work with instances

Suresh Reddy (1):
      be2net: Fix error detection logic for BE3

Taehee Yoo (4):
      netfilter: nf_tables: fix NULL pointer dereference on
nft_ct_helper_obj_dump()
      netfilter: nft_meta: fix wrong value dereference in nft_meta_set_eval
      netfilter: nf_tables: fix NULL-ptr in nf_tables_dump_obj()
      netfilter: nf_tables: increase nft_counters_enabled in
nft_chain_stats_replace()

Thomas Richter (2):
      perf test: "Session topology" dumps core on s390
      perf data: Update documentation section on cpu topology

Tomi Valkeinen (1):
      drm/omap: fix NULL deref crash with SDI displays

Toshiaki Makita (1):
      tun: Fix NULL pointer dereference in XDP redirect

Vincent Chen (4):
      nds32: Correct flush_dcache_page function
      nds32: Flush the cache of the page at vmaddr instead of kaddr in
flush_anon_page
      nds32: Disable local irq before calling cpu_dcache_wb_page in
copy_user_highpage
      nds32: Fix compiler warning, Wstringop-overflow, in vdso.c

YueHaibing (1):
      perf bpf: Fix NULL return handling in bpf__prepare_load()
