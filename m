Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63D0218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 02:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Awx02oNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfBRC5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 21:57:24 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:45528 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728093AbfBRC5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 21:57:23 -0500
Received: by mail-lf1-f48.google.com with SMTP id h10so10917661lfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 18:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vSSQzLFuMcApaLM7hfUPqpmbEDz5Y60UrAc7IDws+EI=;
        b=Awx02oNzd/eSlXb4LMhTWGTjM8J4e9+4XzujvlgpMlsDoPxeDzsWdCMsX5lpKmTGRS
         N8SCWdRjlJHiru6eV5nDfcq5g4vzMYz86ynRqYsfiNml/NG8qj/SJ8PF6/QvxXB3bxPH
         asH9DUo6kben8EEbsx5us/mx/QX1pLQiz1PJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=vSSQzLFuMcApaLM7hfUPqpmbEDz5Y60UrAc7IDws+EI=;
        b=ZBETfNuZ9U1DFDeIniQhCZlaI2K32faLIgkxhvv6/usgeh8Wv7BJ/BqBRlAMpScVpD
         8NQSHPlYEU9mZygcXcLunkBKVgESvYwTzBso+sQLOz6ui9qRhF4uiktpY/IiAglp3QFD
         dcO84uBL5Q0/Ce2EQHcrDpSgwHOqjXvMJ2d8OIs0f/TlFbB6pPVYzkw5frfNGT8cRNOC
         2ieM407Z6zfU3z8jKjPVIP9bLsbVr3z/hq7x72lHAvENMX8WViWm+amjeutMFYnWHRgS
         6/TgI4oXSAr992SfZsVmpemxW+XtvdoF5jwJFL3ChhIcyU6UDJH4EWA5YCsc9fiadhM5
         Uwkw==
X-Gm-Message-State: AHQUAuZCZkEAgVdA2pHR28FT/cU8mGzIlrKXQGzs4ON2T7EnAbtkKs9D
        O88P9slrAPgKoVSIXAzz5PVyl/S1qNU=
X-Google-Smtp-Source: AHgI3IZgJB8V07j0c6lDjdhMBDowz3/1KvJCp5uTeUSEL4T+E0E+SIr4aKG8SqwsVFbgnE97ux7ScQ==
X-Received: by 2002:ac2:4116:: with SMTP id b22mr12164401lfi.19.1550458639715;
        Sun, 17 Feb 2019 18:57:19 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id t19-v6sm3249884lje.23.2019.02.17.18.57.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 18:57:18 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id l10so11129755lfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 18:57:18 -0800 (PST)
X-Received: by 2002:a19:4847:: with SMTP id v68mr12063954lfa.136.1550458637889;
 Sun, 17 Feb 2019 18:57:17 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Feb 2019 18:57:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvF18PqBch4=56DFwCamYpy+owngTZXGnjVbFgKq467g@mail.gmail.com>
Message-ID: <CAHk-=wgvF18PqBch4=56DFwCamYpy+owngTZXGnjVbFgKq467g@mail.gmail.com>
Subject: Linux 5.0-rc7
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nice and calm week, with statistics looking normal. Just under half
drivers (gpu, networking, input, md, block, sound, ...), with the rest
being architecture fixes (arm64, arm, x86, kvm), networking and misc
(filesystem etc).

Nothing particularly odd stands out, and everything is pretty small.
Just the way I like it. Shortlog appended,

               Linus

---

Aditya Swarup (1):
      drm/i915/cnl: Fix CNL macros for Voltage Swing programming

Alex Deucher (1):
      drm/amdgpu/psp11: TA firmware is optional (v3)

Alexander Shiyan (1):
      gpu: ipu-v3: Fix i.MX51 CSI control registers offset

Amit Kucheria (2):
      thermal: of-thermal: Print name of device node with error
      thermal: cpu_cooling: Clarify error message

Andrea Claudi (1):
      ipvs: fix dependency on nf_defrag_ipv6

Andreas Ziegler (1):
      tracing: probeevent: Correctly update remaining space in dynamic area

Ard Biesheuvel (2):
      arm64, mm, efi: Account for GICv3 LPI tables in static memblock
reserve table
      efi/arm: Revert "Defer persistent reservations until after paging_ini=
t()"

Arthur Kiyanovski (2):
      net: ena: fix race between link up and device initalization
      net: ena: update driver version from 2.0.2 to 2.0.3

Aviya Erenfeld (1):
      nl80211: Fix FTM per burst maximum value

Benjamin Coddington (1):
      NFS: Don't use page_file_mapping after removing the page

Bert Kenward (1):
      sfc: initialise found bitmap in efx_ef10_mtd_probe

Bill Kuzeja (1):
      scsi: qla2xxx: Fix panic from use after free in qla2x00_async_tm_cmd

Bob Peterson (1):
      Revert "gfs2: read journal in large chunks to locate the head"

Bob Tracy (1):
      tools uapi: fix Alpha support

Borislav Petkov (1):
      x86/a.out: Clear the dump structure initially

Carlo Caione (1):
      arm64: dts: imx8mq: Fix boot from eMMC

Charles Keepax (1):
      ASoC: core: Allow soc_find_component lookups to match parent of_node

Chen-Yu Tsai (2):
      mmc: sunxi: Disable HS-DDR mode for H5 eMMC controller by default
      mmc: sunxi: Filter out unsupported modes declared in the device tree

Christoffer Dall (2):
      KVM: arm/arm64: Reset the VCPU without preemption and vcpu state load=
ed
      KVM: arm/arm64: vgic: Always initialize the group of private IRQs

Clint Taylor (1):
      drm/i915/icl: combo port vswing programming changes per BSPEC

Cong Wang (4):
      net_sched: fix a race condition in tcindex_destroy()
      net_sched: fix a memory leak in cls_tcindex
      net_sched: fix two more memory leaks in cls_tcindex
      team: avoid complex list operations in team_nl_cmd_options_set()

Dan Carpenter (1):
      net: dsa: bcm_sf2: potential array overflow in bcm_sf2_sw_suspend()

Dave Chinner (2):
      Revert "mm: don't reclaim inodes with many attached pages"
      Revert "mm: slowly shrink slabs with a relatively small number of obj=
ects"

Deepa Dinamani (1):
      selftests: fix timestamping Makefile

Dmitry Torokhov (6):
      Input: cap11xx - switch to using set_brightness_blocking()
      Input: ps2-gpio - flush TX work when closing port
      Input: matrix_keypad - use flush_delayed_work()
      Input: qt2160 - switch to using brightness_set_blocking()
      Revert "Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-=
573G"
      Input: apanel - switch to using brightness_set_blocking()

Dmitry Voytik (1):
      arm64: dts: rockchip: enable usb-host regulators at boot on rk3328-ro=
ck64

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: fix graph_port warning on rk3399 bob kevin
and excavator

Eric Anholt (1):
      drm/sched: Always trace the dependencies we wait on, to fix a race.

Eric Dumazet (4):
      vxlan: test dev->flags & IFF_UP before calling netif_rx()
      net/x25: do not hold the cpu too long in x25_new_lci()
      batman-adv: fix uninit-value in batadv_interface_tx()
      net: fix possible overflow in __sk_mem_raise_allocated()

Eric W. Biederman (1):
      signal: Restore the stop PTRACE_EVENT_EXIT

Fabio Estevam (1):
      ASoC: MAINTAINERS: fsl: Change Fabio's email address

Florian Westphal (1):
      netfilter: nat: fix spurious connection timeouts

Francesco Ruggeri (1):
      netfilter: compat: initialize all fields in xt_init

Gabriel Fernandez (1):
      Input: st-keyscan - fix potential zalloc NULL dereference

Gilad Ben-Yossef (1):
      crypto: ccree - fix resume race condition on init

Greg Kroah-Hartman (1):
      rpc: properly check debugfs dentry before using it

Guennadi Liakhovetski (1):
      ASoC: topology: fix oops/use-after-free case with dai driver

Guenter Roeck (1):
      hwmon: (nct6775) Fix fan6 detection for NCT6793D

Guo Ren (5):
      csky: Fixup _PAGE_GLOBAL bit for 610 tlb entry
      csky: Fixup wrong pt_regs size
      csky: coding convention: Use task_stack_page
      csky: Fixup io-range page attribute for mmap("/dev/mem")
      csky: Fixup dead loop in show_stack

Harald Freudenberger (1):
      s390/zcrypt: fix specification exception on z196 during ap probe

Hedi Berriche (1):
      x86/platform/UV: Use efi_runtime_lock to serialise BIOS calls

Heiner Kallweit (5):
      Revert "r8169: remove unneeded mmiowb barriers"
      Revert "r8169: make use of xmit_more and __netdev_sent_queue"
      net: phy: fix interrupt handling in non-started states
      net: phy: don't use locking in phy_is_started
      net: phy: fix potential race in the phylib state machine

Hoang Le (1):
      tipc: fix skb may be leaky in tipc_link_input

Huang Zijiang (1):
      net: hns: Fix object reference leaks in hns_dsaf_roce_reset()

Huy Nguyen (1):
      net/mlx5: No command allowed when command interface is not ready

Ilan Peer (1):
      mac80211: Fix Tx aggregation session tear down with ITXQs

Ingo Molnar (1):
      perf/core: Fix impossible ring-buffer sizes warning

J. Bruce Fields (1):
      Revert "nfsd4: return default lease period"

James Bottomley (1):
      scsi: sd: fix entropy gathering for most rotational disks

James Morse (1):
      KVM: arm64: Forbid kprobing of the VHE world-switch code

Jani Nikula (2):
      drm/i915/opregion: fix version check
      drm/i915/opregion: rvda is relative from opregion base in opregion 2.=
1+

Jann Horn (2):
      netfilter: nf_nat_snmp_basic: add missing length checks in ASN.1 cbs
      mm: page_alloc: fix ref bias in page_frag_alloc() for 1-byte allocs

Jiada Wang (1):
      ASoC: rsnd: ssiu: correct shift bit for ssiu9

Jianchao Wang (1):
      blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue

Jiri Olsa (1):
      perf/x86: Add check_period PMU callback

Johan Jonker (1):
      ARM: dts: rockchip: remove qos_cif1 from rk3188 power-domain

Johannes Berg (5):
      cfg80211: pmsr: fix MAC address setting
      cfg80211: pmsr: fix abort locking
      mac80211: call drv_ibss_join() on restart
      cfg80211: pmsr: record netlink port ID
      cfg80211: prevent speculation on cfg80211_classify8021d() return

John David Anglin (1):
      dsa: mv88e6xxx: Ensure all pending interrupts are handled prior to ex=
it

Jonathan Bakker (2):
      Input: pwm-vibra - prevent unbalanced regulator
      Input: bma150 - register input device after setting private data

Joonas Lahtinen (1):
      drm/i915: Prevent a race during I915_GEM_MMAP ioctl with WC set

Jouke Witteveen (1):
      Documentation: bring operstate documentation up-to-date

Julia Lawall (1):
      drm/imx: imx-ldb: add missing of_node_puts

Julien Thierry (3):
      KVM: arm/arm64: vgic: Make vgic_irq->irq_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
      KVM: arm/arm64: vgic: Make vgic_cpu->ap_list_lock a raw_spinlock

Jurica Vukadin (1):
      ALSA: hda - Add quirk for HP EliteBook 840 G5

Kal Conley (1):
      net/packet: fix 4gb buffer limit due to overflow check

Keith Busch (1):
      nvme-pci: add missing unlock for reset error

Konstantin Khlebnikov (1):
      inet_diag: fix reporting cgroup classid and fallback to priority

Kuninori Morimoto (2):
      ASoC: rsnd: fixup MIX kctrl registration
      ASoC: rsnd: fixup rsnd_ssi_master_clk_start() user count check

Li RongQing (1):
      ipv6: propagate genlmsg_reply return code

Linus Torvalds (2):
      Revert "exec: load_script: don't blindly truncate shebang string"
      Linux 5.0-rc7

Lorenzo Bianconi (1):
      net: ipv4: use a dedicated counter for icmp_v4 redirect packets

Lucas Stach (1):
      gpu: ipu-v3: pre: don't trigger update if buffer address doesn't chan=
ge

Luwei Kang (1):
      KVM: x86: Recompute PID.ON when clearing PID.SN

Lyude Paul (1):
      drm/i915: Block fbdev HPD processing during suspend

Manuel Reinhardt (1):
      ALSA: usb-audio: Fix implicit fb endpoint setup by quirk

Marc Zyngier (4):
      arm64: KVM: Don't generate UNDEF when LORegion feature is present
      arm/arm64: KVM: Allow a VCPU to fully reset itself
      arm/arm64: KVM: Don't panic on failure to properly reset system regis=
ters
      arm: KVM: Add missing kvm_stage2_has_pmd() helper

Maria Pasechnik (1):
      net/mlx5e: Fix NULL pointer derefernce in set channels error flow

Martin Blumenstingl (1):
      mmc: meson-gx: fix interrupt name

Martin Schwidefsky (1):
      s390/suspend: fix stack setup in swsusp_arch_suspend

Masahiro Yamada (1):
      Rename include/{uapi =3D> }/asm-generic/shmparam.h really

Matteo Croce (1):
      geneve: change NET_UDP_TUNNEL dependency to select

Matthew Wilcox (1):
      drm: Use array_size() when creating lease

Matti Kurkela (1):
      Input: elantech - enable 3rd button support on Fujitsu CELSIUS H780

Mauro Ciancio (1):
      Input: elan_i2c - add ACPI ID for touchpad in Lenovo V330-15ISK

Meelis Roos (1):
      alpha: Fix Eiger NR_IRQS to 128

Michael Ellerman (1):
      powerpc/64s: Fix possible corruption on big endian due to
pgd/pud_present()

Miguel Ojeda (4):
      auxdisplay: ht16k33: fix potential user-after-free on module unload
      lib/crc32.c: mark crc32_le_base/__crc32c_le_base aliases as __pure
      Compiler Attributes: add support for __copy (gcc >=3D 9)
      include/linux/module.h: copy __init/__exit attrs to init/cleanup_modu=
le

Mikulas Patocka (1):
      dm crypt: don't overallocate the integrity tag space

Nate Dailey (1):
      md/raid1: don't clear bitmap bits on interrupted recovery.

Nicholas Kazlauskas (1):
      drm/amd/display: Expose connector VRR range via debugfs

Nicolas Morey-Chaisemartin (1):
      xprtrdma: Make sure Send CQ is allocated on an existing compvec

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

Pablo Neira Ayuso (1):
      netfilter: nft_compat: use-after-free when deleting targets

Palmer Dabbelt (1):
      Revert "RISC-V: Make BSS section as the last section in vmlinux.lds.S=
"

Paolo Abeni (1):
      vsock: cope with memory allocation failure at socket creation time

Paul Kocialkowski (1):
      i2c: bcm2835: Clear current buffer pointers and counts after a transf=
er

Pawe=C5=82 Chmiel (1):
      Input: pwm-vibra - stop regulator after disabling pwm, not before

Philipp Zabel (1):
      drm/imx: ignore plane updates on disabled crtcs

Pierre-Louis Bossart (1):
      ASoC: dapm: fix out-of-bounds accesses to DAPM lookup tables

Qian Cai (1):
      Revert "mm: use early_pfn_to_nid in page_ext_init"

Rajneesh Bhardwaj (1):
      x86/CPU: Add Icelake model number

Rodrigo Siqueira (1):
      drm/vkms: Fix license inconsistent

Russell King (4):
      ASoC: hdmi-codec: fix oops on re-probe
      ARM: OMAP2+: fix lack of timer interrupts on CPU1 after hotplug
      net: sfp: do not probe SFP module before we're attached
      net: phylink: avoid resolving link state too early

Saeed Mahameed (2):
      net/mlx4_en: Force CHECKSUM_NONE for short ethernet frames
      net/mlx5e: XDP, fix redirect resources availability check

Sandeep Patil (1):
      mm: proc: smaps_rollup: fix pss_locked calculation

Scott Mayhew (1):
      sunrpc: fix 4 more call sites that were using stack memory with
a scatterlist

Sean Christopherson (1):
      KVM: nVMX: Restore a preemption timer consistency check

Sebastian Ott (1):
      Revert "s390/pci: remove bit_lock usage in interrupt handler"

Sergei Trofimovich (1):
      alpha: fix page fault handling for r16-r18 targets

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the hold bit setting

Shuming Fan (1):
      ASoC: rt5682: Correct the setting while select ASRC clk for AD/DA fil=
ter

Stefan Agner (1):
      Input: snvs_pwrkey - allow selecting driver for i.MX 7D

Stefan Haberland (1):
      s390/dasd: fix using offset into zero size array error

Stefan O'Rear (1):
      riscv: Add pte bit to distinguish swap from invalid

Steve Longerbeam (1):
      gpu: ipu-v3: Fix CSI offsets for imx53

Suzuki K Poulose (1):
      KVM: arm64: Relax the restriction on using stage2 PUD huge mapping

Sylwester Nawrocki (1):
      ASoC: samsung: Prevent clk_get_rate() calls in atomic context

Takashi Iwai (1):
      ALSA: pcm: Revert capture stream behavior change in blocking mode

Tariq Toukan (1):
      net/mlx5: Fix a compilation warning in events.c

Theodore Ts'o (1):
      Revert "ext4: use ext4_write_inode() when fsyncing w/o a journal"

Tony Lindgren (4):
      clocksource: timer-ti-dm: Fix pwm dmtimer usage of fck reparenting
      ARM: OMAP5+: Fix inverted nirq pin interrupts with irq_set_type
      bus: ti-sysc: Fix timer handling with drop pm_runtime_irq_safe()
      ARM: dts: Configure clock parent for pwm vibra

Tuong Lien (1):
      tipc: fix link session and re-establish issues

Tvrtko Ursulin (1):
      drm/i915/pmu: Fix enable count array size and bounds checking

Ursula Braun (1):
      net/smc: fix byte_order for rx_curs_confirmed

Vitaly Kuznetsov (1):
      x86/kvm/nVMX: read from MSR_IA32_VMX_PROCBASED_CTLS2 only when
it is available

Vivien Didelot (1):
      net: ethernet: freescale: set FEC ethtool regs version

Waiman Long (1):
      Documentation: Fix grammatical error in sysctl/fs.txt & clarify
negative dentry

Xiaoyao Li (1):
      kvm: vmx: Fix entry number check for add_atomic_switch_msr()

Xin Long (2):
      sctp: call gso_reset_checksum when computing checksum in sctp_gso_seg=
ment
      sctp: set stream ext to NULL after freeing it in sctp_stream_outq_mig=
rate

Yizhuo (1):
      ARM: OMAP2+: Variable "reg" in function omap4_dsi_mux_pads()
could be uninitialized

Yu Zhao (1):
      mm/gup: fix gup_pmd_range() for dax

Yufen Yu (1):
      floppy: check_events callback should not return a negative number

Zachary Hays (1):
      mmc: block: handle complete_work on separate workqueue

Zhiqiang Liu (1):
      net: fix IPv6 prefix route residue
