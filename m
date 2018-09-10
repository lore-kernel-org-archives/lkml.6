Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A39FC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951E82064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fwpWyw6t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 951E82064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbeIJHTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:19:40 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:38135 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbeIJHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:19:39 -0400
Received: by mail-it0-f52.google.com with SMTP id p129-v6so26730778ite.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Sep 2018 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ORQHYZqnlKwZrur8FS7FDuYJXCKR34e582YFhSDpO+s=;
        b=fwpWyw6t9wa9jkZxEciL16+cCsjxp5v6XZLQ/K5c/d+WTj3ngIB/LOm4um/Pg1KQov
         yR7qHOc9q/pfdjfQW/3rcnb72GFKcFt4djl5E1A3GHEe2bdruBaJu5KeV17jrq5Umqsk
         zAUAM9CaYshNmfM5Lrwb/Mb+sb+ZvUnSb1AwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ORQHYZqnlKwZrur8FS7FDuYJXCKR34e582YFhSDpO+s=;
        b=kNxTUzx6nXtHeDrNSAmUO7LFQ+TTo6rhsX5gfHr5q7oFmiBkDW4hfsKbCnLU70Hd1y
         bqwE3Cx1524h4z7nTj+rHwp9T625ZyzOLgyrtEcrkELcGqBRorjYlEeFito6COXkKoaQ
         dLTAL2CJOmiayCR+EWsnYehy+5lI6gAx/QJd7zhKsg7N+zXS5XL19IjuI1zUMjXFd8jP
         3cLBwOfBIdqg3/3VHHlb3ToKLKBPGtHh7mMkeb98MX4NI31JNDZESv9MTIdzpAaZnNHE
         Xa8B94wSy+aTGMOzgsUYOrrjfcsz4ha6gDtXi9D73QaNy4LShHEuQnVon0ErSt6GDODr
         H7JA==
X-Gm-Message-State: APzg51ApvObcToYV/qiEsaGM5bK1Mj9c994efzjw6HHPeVSnD7xhbQ2T
        jAa9Fa74SpI0nSMl4qgnSWKMJ/tUzedag6bicFxNUeFY
X-Google-Smtp-Source: ANB0VdYMUELOC05mXiGf5E894VOFIwwxzI/3els9gl4GL1qfS/05Sr29LEiqBSU4bPJXbSf4jKYEUbnISLKUwefntoE=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr16571085jaf.70.1536539724706;
 Sun, 09 Sep 2018 17:35:24 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Sep 2018 17:35:13 -0700
Message-ID: <CA+55aFwSxCt0aKkTxcBstthYXqJ5LtxRbO-CDyqgNwU94Ldq+w@mail.gmail.com>
Subject: Linux 4.19-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another rc.

Things look fairly normal.  The diffstat shows some unusual patterns,
but that's partly due to some late nds32 updates and nilfs2 got the
copyright messages converted to SPDX, and that just shows up like a
sore thumb in the diffstat.

But other than odd details like that, nothing really stands out.
Drivers, networking and arch fixes, with misc random small changes all
over (eg btrfs fixes).

Shortlog appended, in case people want to look at the details.

                Linus

---

Alexey Brodkin (3):
      ARC: configs: cleanup
      ARC: [plat-axs*/plat-hsdk]: Allow U-Boot to pass MAC-address to the k=
ernel
      ARC: [plat-axs*]: Enable SWAP

Alexey Khoroshilov (1):
      gpio: dwapb: Fix error handling in dwapb_gpio_probe()

Alexey Kodanev (2):
      vti6: remove !skb->ignore_df check from vti6_xmit()
      ipv6: don't get lwtstate twice in ip6_rt_copy_init()

Amir Goldstein (1):
      fsnotify: fix ignore mask logic in fsnotify()

Anand Jain (1):
      btrfs: btrfs_shrink_device should call commit transaction at the end

Andrew Lunn (1):
      net: phy: sfp: Handle unimplemented hwmon limits and alarms

Andrew Morton (1):
      mm/util.c: improve kvfree() kerneldoc

Andy Shevchenko (1):
      gpiolib: acpi: Switch to cansleep version of GPIO library call

Aneesh Kumar K.V (1):
      mm/hugetlb: filter out hugetlb pages if HUGEPAGE migration is
not supported.

Anthony Wong (1):
      r8169: add support for NCube 8168 network card

Arnd Bergmann (1):
      rfkill-gpio: include linux/mod_devicetable.h

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Azat Khuzhin (1):
      r8169: set RxConfig after tx/rx is enabled for RTL8169sb/8110sb devic=
es

Bartosz Golaszewski (1):
      memory: ti-aemif: fix a potential NULL-pointer dereference

Baruch Siach (1):
      net: mvpp2: initialize port of_node pointer

Chris Brandt (1):
      sh_eth: Add R7S9210 support

Christian Borntraeger (1):
      timekeeping: Fix declaration of read_persistent_wall_and_boot_offset(=
)

Christoph Hellwig (2):
      kernel/dma/direct: take DMA offset into account in dma_direct_support=
ed
      sparc: set a default 32-bit dma mask for OF devices

Chuanhua Lei (1):
      x86/tsc: Prevent result truncation on 32bit

Colin Ian King (1):
      KVM: SVM: remove unused variable dst_vaddr_end

Colin Xu (2):
      drm/i915/gvt: Make correct handling to vreg BXT_PHY_CTL_FAMILY
      drm/i915/gvt: Handle GEN9_WM_CHICKEN3 with F_CMD_ACCESS.

Cong Wang (3):
      tipc: fix a missing rhashtable_walk_exit()
      tipc: switch to rhashtable iterator
      act_ife: fix a potential use-after-free

Dan Carpenter (3):
      btrfs: use after free in btrfs_quota_enable
      scsi: aacraid: fix a signedness bug
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Borkmann (6):
      bpf, sockmap: fix potential use after free in bpf_tcp_close
      bpf, sockmap: fix psock refcount leak in bpf_tcp_recvmsg
      bpf: fix several offset tests in bpf_msg_pull_data
      bpf: fix msg->data/data_end after sg shift repair in bpf_msg_pull_dat=
a
      bpf: fix shift upon scatterlist ring wrap-around in bpf_msg_pull_data
      bpf: fix sg shift repair start offset in bpf_msg_pull_data

Dave Jiang (1):
      mm: fix BUG_ON() in vmf_insert_pfn_pud() from VM_MIXEDMAP removal

David Ahern (1):
      net/ipv6: Only update MTU metric if it set

David Howells (1):
      afs: Fix cell specification to permit an empty address list

Davide Caratti (1):
      net/sched: act_pedit: fix dump of extended layered op

Davidlohr Bueso (1):
      ipc/shm: properly return EIDRM in shm_lock()

Dennis Zhou (Facebook) (3):
      Revert "blk-throttle: fix race between blkcg_bio_issue_check()
and cgroup_rmdir()"
      blkcg: delay blkg destruction until after writeback has finished
      blkcg: use tryget logic when associating a blkg with a bio

Dexuan Cui (1):
      hv_netvsc: Fix a deadlock by getting rtnl lock earlier in netvsc_prob=
e()

Dinh Nguyen (1):
      net: stmmac: build the dwmac-socfpga platform driver for Stratix10

Doug Berger (1):
      net: bcmgenet: use MAC link status for fixed phy

Dreyfuss, Haim (1):
      mac80211: fix WMM TXOP calculation

Emmanuel Grumbach (4):
      mac80211: don't update the PM state of a peer upon a multicast frame
      mac80211: fix a race between restart and CSA flows
      mac80211: don't Tx a deauth frame if the AP forbade Tx
      mac80211: shorten the IBSS debug messages

Eric Dumazet (1):
      Revert "packet: switch kvzalloc to allocate memory"

Eugeniy Paltsev (5):
      ARC: cleanup show_faulting_vma()
      ARC: dma [IOC]: mark DMA devices connected as dma-coherent
      ARC: dma [IOC] Enable per device io coherency
      ARC: IOC: panic if both IOC and ZONE_HIGHMEM enabled
      ARC: don't check for HIGHMEM pages in arch_dma_alloc

Fabio Estevam (2):
      dt-bindings: imx-lpi2c: Remove mx8dv compatible entry
      i2c: imx-lpi2c: Remove mx8dv compatible entry

Felipe Balbi (1):
      i2c: i801: fix DNV's SMBCTRL register offset

Filipe Manana (2):
      Btrfs: sync log after logging new name
      Btrfs: fix data corruption when deduplicating between different files

Filippo Sironi (1):
      x86/microcode: Update the new microcode revision unconditionally

Florian Westphal (1):
      tcp: do not restart timewait timer on rst reception

Geert Uytterhoeven (2):
      scsi: core: Update SCSI_MQ_DEFAULT help text to match default
      scsi: libata: Add missing newline at end of file

Genki Sky (1):
      scripts/setlocalversion: git: Make -dirty check more robust

Gleb Fotengauer-Malinovskiy (1):
      vhost: fix VHOST_GET_BACKEND_FEATURES ioctl request definition

Greentime Hu (5):
      nds32: fix logic for module
      nds32: Only print one page of stack when die to prevent printing
too much information.
      nds32: Fix a kernel panic issue because of wrong frame pointer access=
.
      nds32: fix build error because of wrong semicolon
      nds32: linker script: GCOV kernel may refers data in __exit

Guoqing Jiang (1):
      md-cluster: release RESYNC lock after the last resync message

Haim Dreyfuss (2):
      nl80211: Fix nla_put_u8 to u16 for NL80211_WMMR_TXOP
      nl80211: Pass center frequency in kHz instead of MHz

Haiqing Bai (1):
      tipc: fix the big/little endian issue in tipc_dest

Hang Yuan (1):
      drm/i915/gvt: move intel_runtime_pm_get out of spin_lock in stop_sche=
dule

Hangbin Liu (3):
      igmp: fix incorrect unsolicit report count when join group
      igmp: fix incorrect unsolicit report count after link down and up
      ip6_tunnel: respect ttl inherit for ip6tnl

Hans de Goede (1):
      gpiolib-acpi: Register GpioInt ACPI event handlers from a late_initca=
ll

Icenowy Zheng (1):
      arm64: allwinner: dts: h6: fix Pine H64 MMC bus width

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

Ilya Dryomov (3):
      ceph: avoid a use-after-free in ceph_destroy_options()
      rbd: factor out get_parent_info()
      rbd: support cloning across namespaces

Imre Deak (1):
      drm/i915/dp_mst: Fix enabling pipe clock for all streams

Ivan Mikhaylov (1):
      net/ibm/emac: wrong emac_calc_base call was used by typo

Jakub Kicinski (1):
      nfp: wait for posted reconfigs when disabling the device

James Smart (2):
      scsi: lpfc: Default fdmi_on to on
      scsi: lpfc: Correct MDS diag and nvmet configuration

Jan-Marek Glogowski (1):
      drm/i915: Re-apply "Perform link quality check, unconditionally
during long pulse"

Jann Horn (1):
      x86/process: Don't mix user/kernel regs in 64bit __show_regs()

Janosch Frank (2):
      KVM: s390: Fix pfmf and conditional skey emulation
      KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting

Jean Delvare (1):
      ACPI / bus: Only call dmi_check_system() on X86

Jens Axboe (1):
      nbd: don't allow invalid blocksize settings

Jerome Brunet (1):
      Revert "net: stmmac: Do not keep rearming the coalesce timer in
stmmac_xmit"

Jia He (1):
      irqchip/gic-v3-its: Cap lpi_id_bits to reduce memory footprint

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Jinbum Park (1):
      mac80211_hwsim: Fix possible Spectre-v1 for hwsim_world_regdom_custom

Jiri Pirko (2):
      net: sched: fix extack error message when chain is failed to be creat=
ed
      net: sched: return -ENOENT when trying to remove filter from
non-existent chain

Joe Perches (2):
      checkpatch: add optional static const to blank line declarations test
      checkpatch: add __ro_after_init to known $Attribute

Johannes Berg (3):
      mac80211_hwsim: require at least one channel
      cfg80211: remove division by size of sizeof(struct ieee80211_wmm_rule=
)
      mac80211: always account for A-MSDU header changes

Johannes Weiner (1):
      mm: memcontrol: print proper OOM header when no eligible victim left

John Fastabend (2):
      bpf: sockmap, decrement copied count correctly in redirect error case
      bpf: avoid misuse of psock when TCP_ULP_BPF collides with another ULP

John Johansen (1):
      apparmor: fix bad debug check in apparmor_secid_to_secctx()

John Pittman (1):
      scsi: documentation: add scsi_mod.use_blk_mq to scsi-parameters

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Kees Cook (1):
      random: make CPU trust a boot parameter

Keyon Jie (1):
      ALSA: hda: Fix several mismatch for register mask and value

Konstantin Khlebnikov (1):
      block: bfq: swap puts in bfqg_and_blkg_put

Linus Torvalds (1):
      Linux 4.19-rc3

Linus Walleij (2):
      net: dsa: Drop GPIO includes
      of/platform: initialise AMBA default DMA masks

Liran Alon (1):
      KVM: nVMX: Fix loss of pending IRQ/NMI before entering L2

Lorenzo Bianconi (2):
      mac80211: do not convert to A-MSDU if frag/subframe limited
      mac80211: fix an off-by-one issue in A-MSDU max_subframe computation

Lu Fengqi (1):
      btrfs: fix qgroup_free wrong num_bytes in btrfs_subvolume_reserve_met=
adata

Lukas Bulwahn (1):
      kconfig: remove a spurious self-assignment

Manasi Navare (1):
      drm/i915/dsc: Fix PPS register definition macros for 2nd VDSC engine

Marc Zyngier (3):
      KVM: arm/arm64: Clean dcache to PoC when changing PTE due to CoW
      arm64: KVM: Only force FPEXC32_EL2.EN if trapping FPSIMD
      KVM: Remove obsolete kvm_unmap_hva notifier backend

Mark Rutland (1):
      arm64: fix erroneous warnings in page freeing functions

Martin Wilck (1):
      scsi: hpsa: limit transfer length to 1MB, not 512kB

Masahiro Yamada (4):
      arc: remove redundant GCC version checks
      kconfig: do not require pkg-config on make {menu,n}config
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Michael Chan (3):
      bnxt_en: Fix firmware signaled resource change logic in open.
      bnxt_en: Clean up unused functions.
      bnxt_en: Do not adjust max_cp_rings by the ones used by RDMA.

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Michal Simek (1):
      i2c: xiic: Record xilinx i2c with Zynq fragment

Mike Rapoport (1):
      m68k: fix early memory reservation for ColdFire MMU systems

Mikhail Zaslonko (1):
      memory_hotplug: fix kernel_panic on offline page processing

Mikulas Patocka (1):
      block: don't warn when doing fsync on read-only devices

Ming Lei (2):
      Revert "scsi: core: fix scsi_host_queue_ready"
      Revert "scsi: core: avoid host-wide host_busy counter for scsi_mq"

Misono Tomohiro (1):
      btrfs: Fix suspicious RCU usage warning in btrfs_debug_in_rcu

Nadav Amit (2):
      mm: respect arch_dup_mmap() return value
      x86/mm: Use WRITE_ONCE() when setting PTEs

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Neeraj Upadhyay (1):
      cpu/hotplug: Adjust misplaced smb() in cpuhp_thread_fun()

Paolo Abeni (2):
      net_sched: reject unknown tcfa_action values
      tc-testing: add test-cases for numeric and invalid control action

Paul Burton (1):
      MIPS: VDSO: Match data page cache colouring when D$ aliases

Paul Mackerras (2):
      KVM: PPC: Book3S HV: Use correct pagesize in kvm_unmap_radix()
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Pavel Machek (1):
      net/rds: RDS is not Radio Data System

Peng Li (2):
      net: hns: add the code for cleaning pkt in chip
      net: hns: add netif_carrier_off before change speed and duplex

Peter Robinson (1):
      hwmon: rpi: add module alias to raspberrypi-hwmon

Peter Zijlstra (1):
      clocksource: Revert "Remove kthread"

Pierre Morel (1):
      KVM: s390: vsie: copy wrapping keys to right place

Prarit Bhargava (1):
      x86/microcode: Make sure boot_cpu_data.microcode is up-to-date

Prashant Bhole (1):
      tools/bpf: bpftool, add xskmap in map types

Randy Dunlap (4):
      kbuild: make missing $DEPMOD a Warning instead of an Error
      x86: Fix kernel-doc atomic.h warnings
      uapi/linux/keyctl.h: don't use C++ reserved keyword as a struct
member name
      kbuild: modules_install: warn when missing System.map file

Robbie Ko (1):
      Btrfs: fix unexpected failure of nocow buffered writes after
snapshotting when low on space

Ryusuke Konishi (1):
      nilfs2: convert to SPDX license tags

Sabrina Dubroca (5):
      ipv6: fix cleanup ordering for ip6_mr failure
      ipv6: fix cleanup ordering for pingv6 registration
      net: rtnl: return early from rtnl_unregister_all when protocol
isn't registered
      selftests: pmtu: maximum MTU for vti4 is 2^16-1-20
      selftests: pmtu: detect correct binary to ping ipv6 addresses

Sara Sharon (1):
      mac80211: avoid kernel panic when building AMSDU from non-linear SKB

Sean Christopherson (8):
      KVM: VMX: Do not allow reexecute_instruction() when skipping MMIO ins=
tr
      KVM: x86: SVM: Set EMULTYPE_NO_REEXECUTE for RSM emulation
      KVM: x86: Invert emulation re-execute behavior to make it opt-in
      KVM: x86: Merge EMULTYPE_RETRY and EMULTYPE_ALLOW_REEXECUTE
      KVM: x86: Default to not allowing emulation retry in kvm_mmu_page_fau=
lt
      KVM: x86: Do not re-{try,execute} after failed emulation in L2
      KVM: x86: Rename emulate_instruction() to kvm_emulate_instruction()
      KVM: x86: Unexport x86_emulate_instruction()

Shaohua Li (1):
      md/raid5-cache: disable reshape completely

Shubhrajyoti Datta (1):
      i2c: xiic: Make the start and the byte count write atomic

Souptick Joarder (1):
      drivers/dax/device.c: convert variable to vm_fault_t type

Stanislaw Gruszka (1):
      cfg80211: make wmm_rule part of the reg_rule structure

Stefan Agner (1):
      bpf: fix build error with clang

Stefan Raspl (7):
      tools/kvm_stat: fix python3 issues
      tools/kvm_stat: fix handling of invalid paths in debugfs provider
      tools/kvm_stat: fix updates for dead guests
      tools/kvm_stat: don't reset stats when setting PID filter for debugfs
      tools/kvm_stat: handle guest removals more gracefully
      tools/kvm_stat: indicate dead guests as such
      tools/kvm_stat: re-animate display of dead guests

Steve French (3):
      SMB3: Backup intent flag missing for directory opens with backupuid m=
ounts
      smb3: minor debugging clarifications in rfc1001 len processing
      smb3: check for and properly advertise directory lease support

Steven Price (1):
      arm64: KVM: Remove pgd_lock

Steven Rostedt (VMware) (2):
      tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoi=
nts
      printk/tracing: Do not trace printk_nmi_enter()

Sudeep Holla (1):
      firmware: arm_scmi: fix divide by zero when sustained_perf_level is z=
ero

Takashi Iwai (2):
      ALSA: hda - Fix cancel_work_sync() stall from jackpoll work
      ALSA: rawmidi: Initialize allocated buffers

Tariq Toukan (1):
      net/mlx5: Fix SQ offset in QPs with small RQ

Tetsuo Handa (1):
      mm, oom: fix missing tlb_finish_mmu() in __oom_reap_task_mm().

Thibaut Sautereau (1):
      lib/Kconfig.debug: fix three typos in help text

Thomas Falcon (1):
      ibmvnic: Include missing return code checks in reset function

Thomas Gleixner (2):
      cpu/hotplug: Prevent state corruption on error rollback
      x86/apic/vector: Make error return value negative

Thomas Werschlein (1):
      cifs: connect to servername instead of IP for IPC$ share

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      mac80211: Run TXQ teardown code before de-registering interfaces

Tony Lindgren (2):
      dt-bindings: net: cpsw: Document cpsw-phy-sel usage but prefer phandl=
e
      net: ethernet: cpsw-phy-sel: prefer phandle for phy sel

Tushar Dave (1):
      bpf: Fix bpf_msg_pull_data()

Varun Prakash (3):
      scsi: csiostor: add a check for NULL pointer after kmalloc()
      scsi: csiostor: fix incorrect port capabilities
      scsi: target: iscsi: cxgbit: use pr_debug() instead of pr_info()

Vincent Whitchurch (2):
      gpio: Fix crash due to registration race
      kmemleak: always register debugfs file

Vineet Gupta (1):
      ARC: sort Kconfig

Vinson Lee (1):
      uapi: Fix linux/rds.h userspace compilation errors.

Vitaly Kuznetsov (1):
      KVM: nVMX: avoid redundant double assignment of nested_run_pending

Vlad Buslov (2):
      net: sched: null actions array pointer before releasing action
      net: sched: action_ife: take reference to meta module

Wanpeng Li (1):
      KVM: LAPIC: Fix pv ipis out-of-bounds access

Will Deacon (1):
      ARC: atomics: unbork atomic_fetch_##op()

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier i=
s 0

Xiaolin Zhang (1):
      drm/i915/gvt: emulate gen9 dbuf ctl register access

Xin Long (5):
      sctp: hold transport before accessing its asoc in sctp_transport_get_=
next
      sctp: remove useless start_fail from sctp_ht_iter in proc
      erspan: set erspan_ver to 1 by default when adding an erspan dev
      sctp: fix invalid reference to the index variable of the iterator
      sctp: not traverse asoc trans list if non-ipv6 trans exists for
ipv6_flowlabel

Yuan-Chi Pang (1):
      mac80211: mesh: fix HWMP sequence numbering to follow standard

YueHaibing (1):
      nds32: add NULL entry to the end of_device_id array

Zhang Rui (1):
      ACPI / LPSS: Force LPSS quirks on boot

Zhenbo Gao (2):
      tipc: correct spelling errors for struct tipc_bc_base's comment
      tipc: correct spelling errors for tipc_topsrv_queue_evt() comments

Zhenyu Wang (2):
      drm/i915/gvt: Fix drm_format_mod value for vGPU plane
      drm/i915/gvt: Give new born vGPU higher scheduling chance

Zhu Yanjun (1):
      net/rds: Use rdma_read_gids to get connection SGID/DGID in IPv6

Zong Li (12):
      nds32: Fix empty call trace
      nds32: Fix get_user/put_user macro expand pointer problem
      nds32: Clean up the coding style
      nds32: Extract the checking and getting pointer to a macro
      nds32/ftrace: Support static function tracer
      nds32/ftrace: Support static function graph tracer
      nds32/ftrace: Add RECORD_MCOUNT support
      nds32/ftrace: Support dynamic function tracer
      nds32/ftrace: Support dynamic function graph tracer
      nds32/stack: Get real return address by using ftrace_graph_ret_addr
      nds32: Remove the deprecated ABI implementation
      nds32: Add macro definition for offset of lp register on stack
