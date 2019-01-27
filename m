Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49E82C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7E12147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 23:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WEDGOKc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA0XkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 18:40:07 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:33045 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfA0XkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 18:40:07 -0500
Received: by mail-lj1-f173.google.com with SMTP id v1-v6so12717656ljd.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bjiO8bEjMGEW7UDBmb+UFxj2rpyHJFTlsD4hfkfEgGI=;
        b=WEDGOKc0MXoa3817w5M5bZKZNGqoCmU+13aDNFPMOgGDl40FvWkHm/7V6KUHu3md8p
         k+QS/tBlJ7pm/yuFVEvgFRXXEal2kxEEIZABPLKSYpuCUEzXxSzVVjUQogrCGZJehXol
         OIpOJCZRLLD/A5s2APNU1mRoyM5+v7fyQiuYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=bjiO8bEjMGEW7UDBmb+UFxj2rpyHJFTlsD4hfkfEgGI=;
        b=O3t26Bu7xIr/P0nPl7KMmSsnvZG2YTh03OZGB3EZdj5KkRMUNUl6F95YhctTpWKV7/
         hY334nsHsoHo3dhoPnb1WS0Yy0QBNe1Y8xOcJTPojg9vCIb9dn5Sl0RJawwBlWEy4OAf
         ZNhdrrkWid8D5HUjVW0Z4bw+sJeHTRZnGLOTYkhtEWlFbPOB2//hsWNHjuJsfpwTm5OL
         OdQYUSCBpMSkjGc6EvAdZksZM5Q0jJgDg8ZxfDRz+dZ6xvHmT4GPnP6Fz6fRQid2R9gV
         dBIxa2kbii2v3lB60LRydN1qdxy5ZTjxj1U2TC76oi0zsAdCg1VK6oIvKa3cd0jynshV
         ym4w==
X-Gm-Message-State: AJcUukcx+a+bFQqbadxocByUHeaYcP+R4n+sT1qlw1BzP8+AINlS6I/y
        kTfCsnjXtrezZTL15H2HBIqQAcOUH00=
X-Google-Smtp-Source: ALg8bN6y93znQEpPVmTfUSXB80EMchjDSqX4QS4QVf2uBOTIAoZYlf0ysqlEHVn2iN7P29/kIJNm0A==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr16718726ljj.61.1548632401724;
        Sun, 27 Jan 2019 15:40:01 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id q21-v6sm2718413ljc.5.2019.01.27.15.40.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:40:00 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id l15-v6so12681124lja.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 15:40:00 -0800 (PST)
X-Received: by 2002:a2e:9944:: with SMTP id r4-v6mr15341410ljj.185.1548632399554;
 Sun, 27 Jan 2019 15:39:59 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Jan 2019 15:39:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgNph26eD1zhP91LQLrwB91QPy4=d82SPfvYmSexV7UpQ@mail.gmail.com>
Message-ID: <CAHk-=wgNph26eD1zhP91LQLrwB91QPy4=d82SPfvYmSexV7UpQ@mail.gmail.com>
Subject: Linux 5.0-rc4
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another release candidate - this time from home.

Nothing particularly stands out, except for the fact that the bulk of
the pull requests came in late in the week. Which worked out ok, if
only because it meant I could do a fair chunk of them on my main
machine rather than on my laptop.

And that "most pull requests come in Friday-Saturday" is a pretty
common pattern, so it's not like it's worrisome. People push their
work for the week to me, and/or just target making the next rc.
Whatever the reason, things look pretty normal, and nothing huge
stands out.

Size-wise, rc4 has a bit more commits that the last few releases have
had at this point, but it's not even remotely a new record size, and
not all that much of an outlier anyway. I _do_ hope that things will
start to calm down for rc5 onwards.

All the other statistics look pretty normal too: a bit more than half
the patch is drivers (networking, sound, tty, usb, gpu, scsi,
binderfs, you name it). With the rest being arch updates (x86, arm,
arc) headers, some library fixes, core networking and kernel. And some
selftest updates, but the tooling changes are much smaller than they
were the last couple of rc's.

So everything looks ok. Shortlog appended for people who want to skim
the details.

Go test and report any oddities you can find, but I think we're doing fine.

                   Linus

---

Aaron Hill (1):
      drivers: thermal: int340x_thermal: Fix sysfs race condition

Abel Vesa (1):
      clk: imx: Remove Kconfig duplicate include

Adrian Vladu (1):
      hv_netvsc: fix typos in code comments

Ajit Pandey (1):
      ASoC: soc-core: defer card probe until all component is added to list

Alban Bedel (2):
      phy: ath79-usb: Fix the power on error path
      phy: ath79-usb: Fix the main reset name to match the DT binding

Alex Deucher (1):
      drm/amdgpu: Add APTX quirk for Lenovo laptop

Alexander Popov (1):
      KVM: x86: Fix single-step debugging

Alexander Usyskin (1):
      mei: me: mark LBG devices as having dma support

Alexandre Belloni (2):
      selftests: rtc: rtctest: fix alarm tests
      selftests: rtc: rtctest: add alarm test on minute boundary

Alexey Kardashevskiy (1):
      vfio-pci/nvlink2: Fix ancient gcc warnings

Alison Schofield (1):
      selftests/vm/gup_benchmark.c: match gup struct to kernel

Anders Roxell (2):
      Input: raspberrypi-ts - fix link error
      misc: pvpanic: fix warning implicit declaration

Andreas Fenkart (1):
      mmc: meson-gx: enable signal re-sampling together with tuning

Andrew Lunn (1):
      net: phy: Fixup GPLv2+ SPDX tags based on license text

Anthony Wong (1):
      ALSA: hda - Add mute LED support for HP ProBook 470 G5

Arnd Bergmann (2):
      drm/msm/gpu: fix building without debugfs
      drm/msm: avoid unused function warning

Atsushi Nemoto (1):
      net: altera_tse: fix connect_local_phy error path

Aya Levin (1):
      net/mlx4_core: Add masking for a few queries on HCA caps

Balaji Pothunoori (1):
      mac80211: don't initiate TDLS connection if station is not
associated to AP

Bart Van Assche (1):
      blk-wbt: Declare local functions static

Ben Gardon (1):
      kvm: selftests: Fix region overlap check in kvm_util

Bo He (1):
      usb: dwc3: gadget: synchronize_irq dwc irq in suspend

Bob Copeland (1):
      mac80211: fix miscounting of ttl-dropped frames

Chaitanya Tata (2):
      cfg80211: reg: remove warn_on for a normal case
      cfg80211: extend range deviation for DMG

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Chris Wilson (1):
      drm/i915/execlists: Mark up priority boost on preemption

Christian Borntraeger (1):
      s390/early: improve machine detection

Christian Brauner (15):
      binderfs: remove wrong kern_mount() call
      binderfs: make each binderfs mount a new instance
      binderfs: implement "max" mount option
      binderfs: rename header to binderfs.h
      binderfs: reserve devices for initial mount
      binderfs: handle !CONFIG_IPC_NS builds
      binderfs: use correct include guards in header
      binderfs: use __u32 for device numbers
      binderfs: remove outdated comment
      binderfs: prevent renaming the control dentry
      binderfs: rework binderfs_fill_super()
      binderfs: rework binderfs_binder_device_create()
      binderfs: kill_litter_super() before cleanup
      binderfs: drop lock in binderfs_binder_ctl_create
      binderfs: switch from d_add() to d_instantiate()

Christian Lamparter (1):
      USB: leds: fix regression in usbport led trigger

Christoph Hellwig (3):
      ide: fix a typo in the settings proc file name
      scsi: communicate max segment size to the DMA mapping code
      arm64/xen: fix xen-swiotlb cache flushing

Christophe JAILLET (1):
      i3c: master: Fix an error checking typo in 'cdns_i3c_master_probe()'

Colin Ian King (3):
      x86/mpx/selftests: fix spelling mistake "succeded" -> "succeeded"
      phy: ti: ensure priv is not null before dereferencing it
      cifs: fix memory leak of an allocated cifs_ntsd structure

Corey Minyard (2):
      ipmi:ssif: Fix handling of multi-part return messages
      ipmi: Don't initialize anything in the core until something uses it

Curtis Malainey (1):
      ASoC: soc-core: fix init platform memory handling

Cyrill Gorcunov (1):
      XArray: Fix typo in comment

Damien Le Moal (2):
      uapi: fix ioctl documentation
      block: Fix comment typo

Dan Carpenter (11):
      ASoC: dma-sh7760: cleanup a debug printk
      ASoC: pcm512x: Fix a double unlock in pcm512x_digital_mute()
      ASoC: qdsp6: q6asm-dai: Off by one in of_q6asm_parse_dai_data()
      ASoC: qdsp6: q6asm-dai: Fix a NULL vs IS_ERR() bug
      ASoC: qdsp6: q6asm-dai: Fix a small memory leak
      ALSA: compress: prevent potential divide by zero bugs
      clk: tegra: dfll: Fix a potential Oop in remove()
      thermal: int340x_thermal: Fix a NULL vs IS_ERR() check
      usb: gadget: Potential NULL dereference on allocation error
      Staging: wilc1000: unlock on error in init_chip()
      XArray: Fix an arithmetic error in xa_is_err

Dan Williams (3):
      libnvdimm/security: Require nvdimm_security_setup_events() to succeed
      acpi/nfit: Block function zero DSMs
      acpi/nfit: Fix command-supported detection

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

Daniel Vacek (1):
      x86/tsc: Make calibration refinement more robust

Dave Hansen (2):
      x86/pkeys: Properly copy pkey state at fork()
      x86/selftests/pkeys: Fork() to check for state being preserved

Dave Jiang (1):
      nfit_test: fix security state pull for nvdimm security nfit_test

Dave Young (1):
      x86/kexec: Fix a kexec_file_load() failure

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

David S. Miller (1):
      qed: Revert error handling changes.

Deepa Dinamani (2):
      Input: input_event - provide override for sparc64
      Input: input_event - fix the CONFIG_SPARC64 mixup

Dexuan Cui (2):
      Drivers: hv: vmbus: Check for ring when getting debug info
      vmbus: fix subchannel removal

Dinh Nguyen (2):
      clk: socfpga: stratix10: fix rate calculation for pll clocks
      clk: socfpga: stratix10: fix naming convention for the fixed-clocks

Dmitry Torokhov (1):
      Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Douglas Anderson (1):
      drm/msm: Fix A6XX support for opp-level

Edward Cree (1):
      sfc: suppress duplicate nvmem partition types in efx_ef10_mtd_probe

Eric Dumazet (1):
      ax25: fix possible use-after-free

Ernesto A. Fern=C3=A1ndez (1):
      direct-io: allow direct writes to empty inodes

Eugeniy Paltsev (8):
      ARC: fix __ffs return value to avoid build warnings
      ARC: adjust memblock_reserve of kernel memory
      ARC: perf: map generic branches to correct hardware condition
      ARC: perf: trivial code cleanup
      ARC: perf: introduce Kernel PMU events support
      ARC: perf: move HW events mapping to separate function
      ARC: perf: avoid kernel killing where it is possible
      ARCv2: lib: memeset: fix doing prefetchw outside of buffer

Ewan D. Milne (2):
      scsi: lpfc: nvme: avoid hang / use-after-free when destroying localpo=
rt
      scsi: lpfc: nvmet: avoid hang / use-after-free when destroying target=
port

Faiz Abbas (1):
      mmc: host: Fix Kconfig warnings on keystone_defconfig

Fathi Boudra (1):
      selftests: seccomp: use LDLIBS instead of LDFLAGS

Fred Klassen (1):
      ipmi: Prevent use-after-free in deliver_response

Geert Uytterhoeven (2):
      ASoC: xlnx: Grammar s/the the/the/
      selftests: gpio-mockup-chardev: Check asprintf() for error

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Greg Kroah-Hartman (3):
      USB: usbip: delete README file
      USB: serial: keyspan_usa: add proper SPDX lines for .h files
      tty: Handle problem if line discipline does not have receive_buf

Gustavo A. R. Silva (8):
      clk: zynqmp: Fix memory allocation in zynqmp_clk_setup
      staging: wilc1000: fix memory leak in wilc_add_rx_gtk
      ASoC: rt5514-spi: Fix potential NULL pointer dereference
      ASoC: amd: Fix potential NULL pointer dereference
      misc: ibmvsm: Fix potential NULL pointer dereference
      char/mwave: fix potential Spectre v1 vulnerability
      ipmi: msghandler: Fix potential Spectre v1 vulnerabilities
      KVM: x86: Mark expected switch fall-throughs

Haiyang Zhang (3):
      hv_netvsc: Fix ethtool change hash key error
      hv_netvsc: Refactor assignments of struct netvsc_device_info
      hv_netvsc: Fix hash key value reset after other ops

Hannes Reinecke (1):
      nvme-multipath: drop optimization for static ANA group IDs

He Zhe (1):
      serial: 8250: Fix serial8250 initialization crash

Huacai Chen (1):
      genirq/irqdesc: Fix double increment in alloc_descs()

Ilya Dryomov (1):
      libceph: avoid KEEPALIVE_PENDING races in ceph_con_keepalive()

Jack Morgenstein (1):
      net/mlx4_core: Fix error handling when initializing CQ bufs in the dr=
iver

Jack Pham (1):
      usb: dwc3: gadget: Clear req->needs_extra_trb flag on cleanup

Jakub Kicinski (1):
      net/ipv6: don't return positive numbers when nothing was dumped

Jan Beulich (1):
      x86/entry/64/compat: Fix stack switching for XEN PV

Jens Axboe (1):
      Revert "block: cover another queue enter recursion via BIO_QUEUE_ENTE=
RED"

Jianchao Wang (1):
      blk-mq: fix the cmd_flag_name array

Joe Perches (1):
      drm/msm: Add __printf verification

Joe Thornber (1):
      dm thin: fix passdown_double_checking_shared_status()

Johannes Berg (2):
      mac80211_hwsim: check that n_limits makes sense
      nl80211: fix NLA_POLICY_NESTED() arguments

John Hubbard (1):
      phy: fix build breakage: add PHY_MODE_SATA

Jonathan Corbet (1):
      genirq: Fix the kerneldoc comment for struct irq_affinity_desc

Jordan Crouse (2):
      drm/msm/gpu: Remove hardcoded interrupt name
      drm/msm: drop interrupt-names

J=C3=BAlius Milan (1):
      staging: wilc1000: fix registration frame size

Kai-Heng Feng (1):
      HID: i2c-hid: Disable runtime PM on Goodix touchpad

Kailang Yang (1):
      ALSA: hda/realtek - Fix typo for ALC225 model

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Karoly Pados (1):
      USB: serial: ftdi_sio: fix GPIO not working in autosuspend

Kees Cook (1):
      selftests/seccomp: Abort without user notification support

Kenneth Feng (1):
      drm/amd/powerplay: OD setting fix on Vega10

Kristian H. Kristensen (1):
      drm/msm: Unblock writer if reader closes file

Liam Mark (1):
      staging: android: ion: Support cpu access during dma_buf_detach

Liming Sun (1):
      mmc: dw_mmc-bluefield: : Fix the license information

Linus Torvalds (2):
      Revert "Change mincore() to count "mapped" pages rather than
"cached" pages"
      Linux 5.0-rc4

Linus Walleij (1):
      irqchip/madera: Drop GPIO includes

Loic Pallardy (1):
      irqchip/stm32-exti: Add domain translate function

Lorenzo Bianconi (1):
      net: ip_gre: use erspan key field for tunnel lookup

Lubomir Rintel (4):
      clk: sysfs: fix invalid JSON in clk_dump
      Input: olpc_apsp - assign priv->dev earlier
      USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
      net/ipv6: lower the level of "link is not ready" messages

Mac Chiang (1):
      ASoC: Intel: Boards: move the codec PLL configuration to _init

Maciej =C5=BBenczykowski (1):
      net: dev_is_mac_header_xmit() true for ARPHRD_RAWIP

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for
non-existing skb by removing it

Marc Gonzalez (2):
      clk: qcom: Select QCOM_GDSC with MSM_GCC_8998
      scsi: ufs: Use explicit access size in ufshcd_dump_regs

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Marek Vasut (1):
      clk: vc5: Abort clock configuration without upstream clock

Mark Brown (1):
      ASoC: core: Make snd_soc_find_component() more robust

Martin Schwidefsky (1):
      s390/mm: always force a load of the primary ASCE on context switch

Maruthi Srinivas Bayyavarapu (1):
      ASoC: xlnx: change license header format style

Masahiro Yamada (2):
      arc: remove redundant kernel-space generic-y
      KVM: x86: fix TRACE_INCLUDE_PATH and remove -I. header search paths

Mathieu Malaterre (1):
      mac80211: Add attribute aligned(2) to struct 'action'

Matthew Wilcox (6):
      XArray tests: Add RCU locking
      XArray: Turn xa_init_flags into a static inline
      XArray: Change xa_for_each iterator
      XArray: Permit storing 2-byte-aligned pointers
      XArray: Honour reserved entries in xa_insert
      XArray tests: Check mark 2 gets squashed

Matthias Kaehlcke (1):
      tty: serial: qcom_geni_serial: Allow mctrl when flow control is disab=
led

Matthias Reichl (1):
      ASoC: core: Don't defer probe on optional, NULL components

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Mike Snitzer (4):
      dm: fix clone_bio() to trigger blk_recount_segments()
      dm: fix redundant IO accounting for bios that need splitting
      dm: fix dm_wq_work() to only use __split_and_process_bio() if appropr=
iate
      dm: add missing trace_block_split() to __split_and_process_bio()

Milan Broz (1):
      dm crypt: fix parsing of extended IV arguments

Minas Harutyunyan (1):
      usb: dwc2: gadget: Fix Remote Wakeup interrupt bit clearing

Ming Lei (1):
      block: cover another queue enter recursion via BIO_QUEUE_ENTERED

Nathan Chancellor (1):
      staging: rtl8723bs: Fix build error with Clang when inlining is disab=
led

Nicolas Pitre (4):
      vt: make vt_console_print() compatible with the unicode screen buffer
      vt: always call notifier with the console lock held
      vt: invoke notifier on screen size change
      vgacon: unconfuse vc_origin when using soft scrollback

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Pavel Shilovsky (7):
      CIFS: Fix possible hang during async MTU reads and writes
      CIFS: Do not reconnect TCP session in add_credits()
      CIFS: Fix credits calculations for reads with errors
      CIFS: Fix credit calculation for encrypted reads with errors
      CIFS: Fix credit calculations in compound mid callback
      CIFS: Do not assume one credit for async responses
      CIFS: Fix mounts if the client is low on credits

Peng Hao (1):
      x86/mm/mem_encrypt: Fix erroneous sizeof()

Peter Chen (1):
      usb: chipidea: fix static checker warning for NULL pointer

Peter Hutterer (1):
      HID: core: replace the collection tree pointers with indices

Peter Ujfalusi (1):
      ASoC: ti: davinci-mcasp: Move context save/restore to runtime_pm call=
backs

Peter Zijlstra (3):
      sched/wake_q: Document wake_q_add()
      sched/wake_q: Fix wakeup ordering for wake_q
      futex: Fix (possible) missed wakeup

Phil Elwell (1):
      staging: vchiq: Fix local event signalling

Philipp Zabel (1):
      HID: core: simplify active collection tracking

Prateek Sood (1):
      sched/wait: Fix rcuwait_wake_up() ordering

Priit Laes (1):
      drm/sun4i: hdmi: Fix usage of TMDS clock

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Rander Wang (1):
      ASoC: Intel: Haswell/Broadwell: fix setting for .dynamic field

Remi Pommarel (1):
      mmc: meson-gx: Free irq in release() callback

Rob Clark (1):
      drm/msm: honor GPU_READONLY flag

Robin Murphy (1):
      iommu/of: Fix probe-deferral

Rohit kumar (2):
      ASoC: sdm845: set jack only for a specific backend
      ASoC: soc-core: Hold client_mutex around soc_init_dai_link()

Roland Dreier (1):
      x86/hpet: Remove unused FSEC_PER_NSEC define

Ronnie Sahlberg (2):
      smb3: add credits we receive from oplock/break PDUs
      cifs: print CIFSMaxBufSize as part of /proc/fs/cifs/DebugData

Sabyasachi Gupta (1):
      tools/testing/selftests/x86/unwind_vdso.c: Remove duplicate header

Sagi Grimberg (3):
      nvme-rdma: fix timeout handler
      nvme-tcp: fix timeout handler
      nvme-rdma: rework queue maps handling

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Sean Christopherson (4):
      KVM: VMX: Use the correct field var when clearing
VM_ENTRY_LOAD_IA32_PERF_GLOBAL_CTRL
      KVM: x86: Fix PV IPIs for 32-bit KVM host
      KVM: x86: WARN_ONCE if sending a PV IPI returns a fatal error
      KVM: VMX: Move vmx_vcpu_run()'s VM-Enter asm blob to a helper functio=
n

Shuah Khan (1):
      MAINTAINERS: email address update in MAINTAINERS entries

Shuming Fan (2):
      ASoC: rt5682: Fix recording no sound issue
      ASoC: rt5682: Fix PLL source register definitions

Silvio Cesare (2):
      ASoC: dapm: change snprintf to scnprintf for possible overflow
      ASoC: imx-audmux: change snprintf to scnprintf for possible overflow

Simon Horman (1):
      ravb: expand rx descriptor data to accommodate hw checksum

Sinan Kaya (4):
      ASoC: Intel: atom: Make PCI dependency explicit
      x86/intel/lpss: Make PCI dependency explicit
      mmc: sdhci-acpi: Make PCI dependency explicit
      x86/Kconfig: Select PCI_LOCKLESS_CONFIG if PCI is enabled

Srinivas Ramana (1):
      genirq: Make sure the initial affinity is not empty

Stefan Agner (1):
      net: fec: get regulator optional

Stefan Wahren (1):
      mmc: sdhci-iproc: handle mmc_of_parse() errors during probe

Sudarsana Reddy Kalluru (1):
      MAINTAINERS: Update cavium networking drivers

Suravee Suthikulpanit (2):
      svm: Add warning message for AVIC IPI invalid target
      svm: Fix AVIC incomplete IPI emulation

Takashi Iwai (1):
      ASoC: intel: skl: Fix display power regression

Tejun Heo (1):
      writeback: synchronize sync(2) against cgroup writeback
membership switches

Tetsuo Handa (1):
      inotify: Fix fd refcount leak in inotify_add_watch().

Thomas Falcon (1):
      ibmveth: Do not process frames after calling napi_reschedule

Thomas Gleixner (5):
      posix-cpu-timers: Unbreak timer rearming
      ceph: quota: cleanup license mess
      vfio/pci: Cleanup license mess
      net: sun: cassini: Cleanup license conflict
      smb3: Cleanup license mess

Thor Thayer (1):
      EDAC, altera: Fix S10 persistent register offset

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Tom Roeder (1):
      kvm: x86/vmx: Use kzalloc for cached_vmcs12

Tomas Winkler (2):
      mei: dma: silent the reject message
      mei: me: add denverton innovation engine device IDs

Tomer Tayar (3):
      qed: Revise load sequence to avoid PCI errors
      qed: Add infrastructure for error detection and recovery
      qede: Error recovery process

Tomonori Sakita (1):
      serial: fsl_lpuart: fix maximum acceptable baud rate with over-sampli=
ng

Uwe Kleine-K=C3=B6nig (1):
      can: flexcan: fix NULL pointer exception during bringup

Varun Prakash (1):
      scsi: csiostor: fix NULL pointer dereference in csio_vport_set_state(=
)

Vasily Gorbik (1):
      s390/vdso: correct vdso mapping for compat tasks

Vineet Gupta (5):
      ARCv2: boot log: BPU return stack depth
      ARC: boot log: print Action point details
      ARC: show_regs: lockdep: avoid page allocator...
      ARC: show_regs: lockdep: re-enable preemption
      ARC: mm: do_page_fault fixes #1: relinquish mmap_sem if signal
arrives while handle_mm_fault

Vitaly Kuznetsov (7):
      hv_balloon: avoid touching uninitialized struct page during tail onli=
ning
      x86/kvm/hyper-v: don't announce GUEST IDLE MSR support
      x86/kvm/hyper-v: don't recommend doing reset via synthetic MSR
      x86/kvm/hyper-v: recommend using eVMCS only when it is enabled
      KVM: nSVM: clear events pending from svm_complete_interrupts()
when exiting to L1
      x86/kvm/hyper-v: nested_enable_evmcs() sets vmcs_version incorrectly
      KVM: selftests: check returned evmcs version range

Wei Yongjun (3):
      clk: imx: fix potential NULL dereference in imx8qxp_lpcg_clk_probe()
      binderfs: fix error return code in binderfs_fill_super()
      virt_wifi: fix error return code in virt_wifi_newlink()

Weinan Li (1):
      drm/i915/gvt: release shadow batch buffer and wa_ctx before
destroy one workload

Xie Yongji (1):
      locking/rwsem: Fix (possible) missed wakeup

Xin Long (4):
      sctp: improve the events for sctp stream reset
      sctp: improve the events for sctp stream adding
      sctp: set chunk transport correctly when it's a new asoc
      sctp: set flow sport from saddr only when it's 0

Xiubo Li (1):
      scsi: tcmu: fix use after free

Yan, Zheng (1):
      ceph: clear inode pointer when snap realm gets dropped by its inode

Yang Yingliang (2):
      irqchip/gic-v3-mbi: Fix uninitialized mbi_lock
      ipmi: fix use-after-free of user->release_barrier.rda

Yangbo Lu (1):
      net: dpaa2: improve PTP Kconfig option

Yi Wang (1):
      kvm: vmx: fix some -Wmissing-prototypes warnings

Yizhuo (1):
      ASoC: Variable "val" in function rt274_i2c_probe() could be uninitial=
ized

YueHaibing (1):
      can: flexcan: fix 'passing zero to ERR_PTR()' warning

Zeng Tao (1):
      usb: dwc3: gadget: Fix the uninitialized link_state when udc starts

Zhang Run (1):
      net: usb: asix: ax88772_bind return error when hw_reset fail

b-ak (1):
      ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM standby mode

wenxu (1):
      ip_tunnel: Make none-tunnel-dst tunnel port work with lwtunnel
