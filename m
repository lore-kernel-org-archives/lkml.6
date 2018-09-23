Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7721AECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD2521476
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 17:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD2521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbeIWXyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 19:54:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49216 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeIWXyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 19:54:07 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A82CE8D4;
        Sun, 23 Sep 2018 17:55:49 +0000 (UTC)
Date:   Sun, 23 Sep 2018 19:55:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: Linux 4.19-rc5
Message-ID: <20180923175547.GA4462@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

As almost everyone knows, it's been an "interesting" week from a social
point-of-view.  But from the technical side, -rc5 looks totally normal.

The diffstat is a bit higher than previous -rc5's, but the number of
trees pulled is lower, so overall, pretty much all is on track.  I'm not
seeing any major "these bugs are not being fixed!" type of reports, so I
can hope that the initial churn that -rc1 threw at everyone is under
control.

The majority size-wise of changes here are with more tests being added
and fixed up, but there is also the usual networking, x86, sound, drm,
ppc, and other fixes.  Full details are in the shortlog below.

As usual, please go and test this thing, and let me know if anything
technical isn't getting addressed that needs to be.

thanks,

greg "keeping the seat warm for a few weeks" k-h

---

Akshu Agrawal (1):
      ASoC: AMD: Ensure reset bit is cleared before configuring

Alex Deucher (1):
      drm/amdgpu: add new polaris pci id

Alexei Starovoitov (1):
      bpf/verifier: disallow pointer subtraction

Alexey Kardashevskiy (1):
      KVM: PPC: Avoid marking DMA-mapped pages dirty in real mode

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Anders Roxell (2):
      selftests: android: move config up a level
      selftests: add headers_install to lib.mk

Andrew F. Davis (1):
      ASoC: tas6424: Save last fault register even when clear

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix ATU Miss Violation

Andy Shevchenko (1):
      KVM: SVM: Switch to bitmap_zalloc()

Andy Whitcroft (1):
      floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

Angelo Dureghello (1):
      spi: spi-fsl-dspi: fix broken DSPI_EOQ_MODE

Antoine Tenart (1):
      net: mvpp2: let phylink manage the carrier state

Arnaldo Carvalho de Melo (1):
      tools lib bpf: Provide wrapper for strerror_r to build in !_GNU_SOURCE systems

Ben Hutchings (1):
      perf Documentation: Fix out-of-tree asciidoctor man page generation

Bjørn Mork (1):
      qmi_wwan: set DTR for modems in forced USB2 mode

Boris Brezillon (2):
      drm/vc4: Fix the "no scaling" case on multi-planar YUV formats
      mtd: devices: m25p80: Make sure the buffer passed in op is DMA-able

Boris Ostrovsky (1):
      xen/x86/vpmu: Zero struct pt_regs before calling into sample handling code

Brijesh Singh (3):
      crypto: ccp - add timeout support in the SEV command
      x86/mm: Add .bss..decrypted section to hold shared variables
      x86/kvm: Use __bss_decrypted attribute in shared variables

Charles Keepax (1):
      ASoC: dapm: Fix NULL pointer deference on CODEC to CODEC DAIs

Chen-Yu Tsai (1):
      drm/sun4i: Remove R40 display pipeline compatibles

Colin Ian King (1):
      net: hp100: fix always-true check for link up state

Colin Xu (2):
      drm/i915/gvt: Init PHY related registers for BXT
      drm/i915/gvt: Add GEN9_CLKGATE_DIS_4 to default BXT mmio handler

Cong Wang (1):
      net_sched: notify filter deletion when deleting a chain

Corentin Labbe (1):
      net: ethernet: ti: add missing GENERIC_ALLOCATOR dependency

Dan Carpenter (3):
      hwmon: (nct6775) Set weight source to zero correctly
      scsi: qla2xxx: Fix an endian bug in fcpcmd_is_corrupted()
      x86/paravirt: Fix some warning messages

Daniel Borkmann (1):
      tls: fix currently broken MSG_PEEK behavior

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

Dave Airlie (1):
      drm: fix drm_drv_uses_atomic_modeset on non modesetting drivers.

David S. Miller (1):
      Revert "kcm: remove any offset before parsing messages"

Davide Caratti (1):
      net/sched: act_sample: fix NULL dereference in the data path

Deepak Rawat (4):
      drm/vmwgfx: don't check for old_crtc_state enable status
      drm/vmwgfx: limit screen size to stdu_max during check_modeset
      drm/vmwgfx: limit mode size for all display unit to texture_max
      drm/vmwgfx: Don't impose STDU limits on framebuffer size

Dmitry V. Levin (1):
      ASoC: uapi: fix sound/skl-tplg-interface.h userspace compilation errors

Dominique Martinet (2):
      kcm: remove any offset before parsing messages
      fs/proc/kcore.c: fix invalid memory access in multi-page read optimization

Drew Schmitt (3):
      KVM: x86: Turbo bits in MSR_PLATFORM_INFO
      KVM: x86: Control guest reads of MSR_PLATFORM_INFO
      kvm: selftests: Add platform_info_test

Emil Lundmark (1):
      drm: udl: Destroy framebuffer only if it was initialized

Eric Biggers (1):
      ext4: show test_dummy_encryption mount option in /proc/mounts

Eric Dumazet (1):
      ipv6: fix possible use-after-free in ip6_xmit()

Feng Tang (1):
      x86/mm: Expand static page table for fixmap space

Fenghua Yu (1):
      x86/intel_rdt: Add Reinette as co-maintainer for RDT

Geert Uytterhoeven (1):
      spi: Fix double IDR allocation with DT aliases

Greg Kroah-Hartman (1):
      Linux 4.19-rc5

Guenter Roeck (4):
      hwmon: (nct6775) Fix access to fan pulse registers
      hwmon: (nct6775) Fix virtual temperature sources for NCT6796D
      hwmon: (nct6775) Fix RPM output for fan7 on NCT6796D
      hwmon: (nct6775) Use different register to get fan RPM for fan7

Guillaume Nault (1):
      pppoe: fix reception of frames with no mac header

Hannes Reinecke (1):
      nvme: count all ANA groups for ANA Log page

Hans de Goede (4):
      ASoC: Intel: bytcr_rt5640: Add quirks for 2 more devices
      clk: x86: add "ether_clk" alias for Bay Trail / Cherry Trail
      r8169: Get and enable optional ether_clk clock
      clk: x86: Stop marking clocks as CLK_IS_CRITICAL

Hermes Zhang (1):
      Bluetooth: hci_ldisc: Free rw_semaphore on close

Icenowy Zheng (1):
      drm: sun4i: drop second PLL from A64 HDMI PHY

Janosch Frank (2):
      s390/mm: Check for valid vma before zapping in gmap_discard
      KVM: s390: Make huge pages unavailable in ucontrol VMs

Jay Kamat (2):
      Fix cg_read_strcmp()
      Add tests for memory.oom.group

Jens Axboe (1):
      libata: mask swap internal and hardware tag

Jiada Wang (1):
      ASoC: rsnd: fixup not to call clk_get/set under non-atomic

Joel Fernandes (Google) (1):
      mm: shmem.c: Correctly annotate new inodes for lockdep

Johan Hedberg (1):
      Bluetooth: SMP: Fix trying to use non-existent local OOB data

Johannes Berg (1):
      socket: fix struct ifreq size in compat ioctl

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Juergen Gross (2):
      xen/netfront: don't bug in case of too many frags
      xen: issue warning message when out of grant maptrack entries

Junaid Shahid (1):
      kvm: mmu: Don't read PDPTEs when paging is not enabled

Junxiao Bi (1):
      ocfs2: fix ocfs2 read block panic

KJ Tsanaktsidis (1):
      fork: report pid exhaustion correctly

Kai-Heng Feng (2):
      r8169: Align ASPM/CLKREQ setting function with vendor driver
      r8169: enable ASPM on RTL8106E

Katsuhiro Suzuki (1):
      ASoC: uniphier: change status to orphan

Kirill Kapranov (1):
      spi: fix IDR collision on systems with both fixed and dynamic SPI bus numbers

Krish Sadhukhan (2):
      nVMX x86: check posted-interrupt descriptor addresss on vmentry of L2
      nVMX x86: Check VPID value on vmentry of L2 guests

Kuninori Morimoto (2):
      ASoC: rsnd: adg: care clock-frequency size
      ASoC: rsnd: don't fallback to PIO mode when -EPROBE_DEFER

Laura Abbott (1):
      scsi: iscsi: target: Don't use stack buffer for scatterlist

Lei Yang (4):
      selftests/efivarfs: add required kernel configs
      selftests: memory-hotplug: add required configs
      cgroup: kselftests: add test_core to .gitignore
      kvm: selftests: use -pthread instead of -lpthread

Li Dongyang (1):
      ext4: don't mark mmp buffer head dirty

Liran Alon (2):
      KVM: nVMX: Wake blocked vCPU in guest-mode if pending interrupt in virtual APICv
      KVM: nVMX: Fix bad cleanup on error of get/set nested state IOCTLs

Lyude Paul (1):
      drm/atomic: Use drm_drv_uses_atomic_modeset() for debugfs creation

Marcel Ziswiler (1):
      ASoC: wm9712: fix replace codec to component

Mario Limonciello (2):
      platform/x86: dell-smbios-wmi: Correct a memory leak
      platform/x86: alienware-wmi: Correct a memory leak

Martin KaFai Lau (1):
      bpf: btf: Fix end boundary calculation for type section

Masahiro Yamada (1):
      mtd: rawnand: denali: fix a race condition when DMA is kicked

Matias Karhumaa (1):
      Bluetooth: Use correct tfm to generate OOB data

Michael Chan (1):
      bnxt_en: Fix VF mac address regression.

Miguel Ojeda (2):
      Compiler Attributes: naked was fixed in gcc 4.6
      Compiler Attributes: naked can be shared

Mika Westerberg (1):
      pinctrl: intel: Do pin translation in other GPIO operations as well

Miquel Raynal (2):
      mtd: rawnand: marvell: prevent harmless warnings
      mtd: partitions: fix unbalanced of_node_get/put()

Nicholas Piggin (1):
      KVM: PPC: Book3S HV: Don't use compound_order to determine host mapping size

Nicolas Ferre (2):
      net: macb: disable scatter-gather for macb on sama5d3
      ARM: dts: at91: add new compatibility string for macb on sama5d3

Oder Chiou (1):
      ASoC: rt5514: Fix the issue of the delay volume applied again

Omar Sandoval (1):
      block: use nanosecond resolution for iostat

Ondrej Mosnacek (1):
      crypto: x86/aegis,morus - Do not require OSXSAVE for SSE2

Paolo Abeni (2):
      udp4: fix IP_CMSG_CHECKSUM for connected sockets
      udp6: add missing checks on edumux packet processing

Paolo Bonzini (1):
      KVM: VMX: check nested state and CR4.VMXE against SMM

Pasha Tatashin (1):
      mm: disable deferred struct page for 32-bit arches

Peter Oskolkov (1):
      net/ipv6: do not copy dst flags on rt init

Philipp Zabel (1):
      mfd: da9063: Fix DT probing with constraints

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Reinette Chatre (8):
      x86/intel_rdt: Fix size reporting of MBA resource
      x86/intel_rdt: Global closid helper to support future fixes
      x86/intel_rdt: Fix invalid mode warning when multiple resources are managed
      x86/intel_rdt: Fix unchecked MSR access
      x86/intel_rdt: Do not allow pseudo-locking of MBA resource
      x86/intel_rdt: Fix incorrect loop end condition
      x86/intel_rdt: Fix exclusive mode handling of MBA resource
      x86/intel_rdt: Fix incorrect loop end condition

Richard Weinberger (2):
      ubifs: Check for name being NULL while mounting
      Revert "ubifs: xattr: Don't operate on deleted inodes"

Roman Gushchin (1):
      mm: slowly shrink slabs with a relatively small number of objects

Roopa Prabhu (1):
      net: rtnl_configure_link: fix dev flags changes arg to __dev_notify_flags

Ross Zwisler (1):
      ext4: close race between direct IO and ext4_break_layouts()

Ryan Lee (2):
      ASoC: max98373: Added speaker FS gain cotnrol register to volatile.
      ASoC: max98373: Added 10ms sleep after amp software reset

Sabrina Dubroca (3):
      tls: don't copy the key out of tls12_crypto_info_aes_gcm_128
      tls: zero the crypto information from tls_context before freeing
      tls: clear key material from kernel memory when do_tls_setsockopt_conf fails

Sascha Hauer (1):
      ubifs: drop false positive assertion

Scott Branden (1):
      efi/libstub/arm: default EFI_ARMSTUB_DTB_LOADER to y

Sean Christopherson (3):
      KVM: VMX: immediately mark preemption timer expired only for zero value
      KVM: VMX: modify preemption timer bit only when arming timer
      KVM: VMX: use preemption timer to force immediate VMExit

Sebastian Andrzej Siewior (1):
      kvm: x86: make kvm_{load|put}_guest_fpu() static

Shuming Fan (1):
      ASoC: rt5682: Change DAC/ADC volume scale

Simon Detheridge (1):
      pinctrl: cannonlake: Fix gpio base for GPP-E

Srinivas Kandagatla (1):
      ASoC: q6routing: initialize data correctly

Stephen Hemminger (3):
      hv_netvsc: fix schedule in RCU context
      PCI: hv: support reporting serial number as slot information
      hv_netvsc: pair VF based on serial number

Sébastien Szymanski (1):
      ASoC: cs4265: fix MMTLR Data switch control

Takashi Iwai (1):
      ALSA: hda - Enable runtime PM only for discrete GPU

Takashi Sakamoto (9):
      ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping
      ALSA: fireface: fix memory leak in ff400_switch_fetching_mode()
      ALSA: firewire-digi00x: fix memory leak of private data
      ALSA: firewire-tascam: fix memory leak of private data
      ALSA: oxfw: fix memory leak of private data
      ALSA: bebob: fix memory leak for M-Audio FW1814 and ProjectMix I/O at error path
      ALSA: oxfw: fix memory leak for model-dependent data at error path
      ALSA: oxfw: fix memory leak of discovered stream formats at error path
      ALSA: fireworks: fix memory leak of response buffer at error path

Theodore Ts'o (7):
      ext4: add nonstring annotations to ext4.h
      ext4: check to make sure the rename(2)'s destination is not freed
      ext4: avoid divide by zero fault when deleting corrupted inline directories
      ext4: avoid arithemetic overflow that can trigger a BUG
      ext4: recalucate superblock checksum after updating free blocks/inodes
      ext4: fix online resize's handling of a too-small final block group
      ext4: fix online resizing for bigalloc file systems with a 1k block size

Thiago Jung Bauermann (1):
      selftests: kselftest: Remove outdated comment

Thomas Gleixner (2):
      MAINTAINERS: Add Borislav to the x86 maintainers
      MAINTAINERS: Add X86 MM entry

Thomas Hellstrom (1):
      drm/vmwgfx: Fix buffer object eviction

Tianyu Lan (1):
      KVM/MMU: Fix comment in walk_shadow_page_lockless_end()

Toke Høiland-Jørgensen (1):
      gso_segment: Reset skb->mac_len after modifying network header

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

Toshi Kani (2):
      ext4, dax: add ext4_bmap to ext4_dax_aops
      ext4, dax: set ext4_dax_aops for dax files

Toshiaki Makita (1):
      veth: Orphan skb before GRO

Tushar Dave (1):
      bpf: use __GFP_COMP while allocating page

Vaibhav Nagarnaik (1):
      ring-buffer: Allow for rescheduling when removing pages

Vasily Khoruzhick (1):
      neighbour: confirm neigh entries when ARP packet is received

Vitaly Kuznetsov (2):
      x86/kvm/lapic: always disable MMIO interface in x2APIC mode
      x86/hyper-v: rename ipi_arg_{ex,non_ex} structures

Wei Yang (1):
      KVM: x86: don't reset root in kvm_mmu_setup()

Weinan Li (1):
      drm/i915/gvt: request srcu_read_lock before checking if one gfn is valid

Willy Tarreau (2):
      ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Xiaochen Shen (1):
      x86/intel_rdt: Fix data type in parsing callbacks

Xin Long (1):
      ipv6: use rt6_info members when dst is set in rt6_fill_node

Yong Zhao (2):
      drm/amdkfd: Change the control stack MTYPE from UC to NC on GFX9
      drm/amdkfd: Fix ATS capablity was not reported correctly on some APUs

Yong Zhi (1):
      ASoC: Intel: Skylake: Acquire irq after RIRB allocation

Yu Zhao (3):
      Revert "ASoC: Intel: Skylake: Acquire irq after RIRB allocation"
      sound: enable interrupt after dma buffer initialization
      sound: don't call skl_init_chip() to reset intel skl soc

YueHaibing (2):
      drm/fb-helper: Remove set but not used variable 'connector_funcs'
      kernel/sys.c: remove duplicated include

Zhipeng Gong (1):
      drm/i915/gvt: clear ggtt entries when destroy vgpu

zhong jiang (2):
      drm/pl111: Make sure of_device_id tables are NULL terminated
      net: ethernet: Fix a unused function warning.

