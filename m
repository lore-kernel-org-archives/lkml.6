Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B077ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2821620C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:59:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2821620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731300AbeGQLbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:31:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbeGQLbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:31:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 33D37AD8;
        Tue, 17 Jul 2018 10:59:31 +0000 (UTC)
Date:   Tue, 17 Jul 2018 12:59:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.17.7
Message-ID: <20180717105929.GA18343@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

NOTE, this kernel release is broken for i386 systems.  If you are
running such a machine, do NOT update to this release, you will not be
able to boot properly.

I did this release anyway with this known problem as there is a fix in
here for x86-64 systems that was nasty to track down and was affecting
people.  Given that the huge majority of systems are NOT i386, I felt
this was a safe release to do at this point in time.

Once the proper fix for i386 systems has been accepted into Linus's tree
(it has been posted already), I will pick it up and do a new 4.17.y
release so that users of those systems can update.

All users of non-i386 systems running the 4.17 kernel series must upgrade.

The updated 4.17.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.17.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/kbuild/kbuild.txt               |    9=20
 Makefile                                      |    2=20
 arch/arm/boot/dts/armada-38x.dtsi             |    2=20
 arch/arm64/include/asm/simd.h                 |   19=20
 arch/mips/kernel/process.c                    |   43 -
 arch/mips/kernel/traps.c                      |    1=20
 arch/mips/mm/ioremap.c                        |   37 -
 arch/x86/crypto/Makefile                      |    4=20
 arch/x86/crypto/salsa20-i586-asm_32.S         |  938 ---------------------=
-----
 arch/x86/crypto/salsa20-x86_64-asm_64.S       |  805 ----------------------
 arch/x86/crypto/salsa20_glue.c                |   91 --
 arch/x86/include/asm/vmx.h                    |    3=20
 arch/x86/kernel/uprobes.c                     |    2=20
 arch/x86/kvm/vmx.c                            |   67 +
 arch/x86/kvm/x86.h                            |    9=20
 arch/x86/purgatory/Makefile                   |    2=20
 arch/x86/xen/enlighten_pv.c                   |   25=20
 arch/x86/xen/irq.c                            |    4=20
 block/bsg.c                                   |    2=20
 crypto/Kconfig                                |   28=20
 crypto/sha3_generic.c                         |    2=20
 drivers/acpi/acpica/hwsleep.c                 |   15=20
 drivers/acpi/nfit/core.c                      |   44 -
 drivers/acpi/nfit/nfit.h                      |    1=20
 drivers/ata/ahci.c                            |   60 +
 drivers/ata/libata-core.c                     |    3=20
 drivers/ata/libata-scsi.c                     |   18=20
 drivers/block/loop.c                          |   79 +-
 drivers/block/loop.h                          |    1=20
 drivers/gpu/drm/etnaviv/etnaviv_drv.c         |   24=20
 drivers/gpu/drm/etnaviv/etnaviv_gpu.h         |    3=20
 drivers/gpu/drm/etnaviv/etnaviv_sched.c       |   24=20
 drivers/i2c/busses/i2c-tegra.c                |   17=20
 drivers/i2c/i2c-core-base.c                   |   11=20
 drivers/infiniband/Kconfig                    |   11=20
 drivers/infiniband/core/Makefile              |    4=20
 drivers/infiniband/hw/cxgb4/mem.c             |    2=20
 drivers/infiniband/hw/hfi1/rc.c               |    2=20
 drivers/infiniband/hw/hfi1/uc.c               |    4=20
 drivers/infiniband/hw/hfi1/ud.c               |    4=20
 drivers/infiniband/hw/hfi1/verbs_txreq.c      |    4=20
 drivers/infiniband/hw/hfi1/verbs_txreq.h      |    4=20
 drivers/misc/ibmasm/ibmasmfs.c                |   27=20
 drivers/misc/mei/interrupt.c                  |    5=20
 drivers/misc/vmw_balloon.c                    |    4=20
 drivers/mmc/host/dw_mmc.c                     |    7=20
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |    3=20
 drivers/mmc/host/sdhci-esdhc-imx.c            |   21=20
 drivers/mtd/spi-nor/cadence-quadspi.c         |    6=20
 drivers/staging/rtl8723bs/core/rtw_ap.c       |    2=20
 drivers/staging/rtlwifi/rtl8822be/hw.c        |    2=20
 drivers/staging/rtlwifi/wifi.h                |    1=20
 drivers/thunderbolt/domain.c                  |    4=20
 drivers/usb/core/quirks.c                     |    4=20
 drivers/usb/host/xhci-mem.c                   |    2=20
 drivers/usb/misc/yurex.c                      |   23=20
 drivers/usb/serial/ch341.c                    |    2=20
 drivers/usb/serial/cp210x.c                   |    1=20
 drivers/usb/serial/keyspan_pda.c              |    4=20
 drivers/usb/serial/mos7840.c                  |    3=20
 fs/binfmt_elf.c                               |    5=20
 fs/f2fs/f2fs.h                                |   13=20
 fs/f2fs/inode.c                               |   33=20
 fs/f2fs/node.c                                |   21=20
 fs/f2fs/segment.c                             |   25=20
 fs/inode.c                                    |    6=20
 fs/proc/task_mmu.c                            |    3=20
 fs/xfs/libxfs/xfs_ialloc_btree.c              |    2=20
 include/linux/libata.h                        |    1=20
 kernel/bpf/verifier.c                         |   48 -
 kernel/power/user.c                           |    5=20
 kernel/trace/trace.c                          |    8=20
 kernel/trace/trace_kprobe.c                   |    6=20
 kernel/trace/trace_output.c                   |    5=20
 mm/gup.c                                      |    2=20
 mm/mmap.c                                     |   29=20
 mm/page_alloc.c                               |    4=20
 mm/rmap.c                                     |    8=20
 net/bridge/netfilter/ebtables.c               |    2=20
 net/ipv4/netfilter/ip_tables.c                |    1=20
 net/ipv6/netfilter/ip6_tables.c               |    1=20
 net/netfilter/nfnetlink_queue.c               |    3=20
 sound/pci/hda/patch_hdmi.c                    |   19=20
 sound/pci/hda/patch_realtek.c                 |    6=20
 tools/build/Build.include                     |    4=20
 tools/testing/selftests/bpf/test_verifier.c   |   58 +
 86 files changed, 701 insertions(+), 2168 deletions(-)

Alexander Usyskin (1):
      mei: discard messages from not connected client during power down.

Baruch Siach (1):
      ARM: dts: armada-38x: use the new thermal binding

Chris Wilson (1):
      ALSA: hda - Handle pm failure during hotplug

Christian Borntraeger (1):
      mm: do not drop unused pages when userfaultd is running

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Dan Carpenter (2):
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Dan Williams (1):
      acpi, nfit: Fix scrub idle detection

Daniel Borkmann (1):
      bpf: reject passing modified ctx to helper functions

Darrick J. Wong (1):
      xfs: fix inobt magic number check

Dmitry Vyukov (1):
      crypto: don't optimize keccakf()

Eric Biggers (1):
      crypto: x86/salsa20 - remove x86 salsa20 implementations

Eric Dumazet (1):
      netfilter: nf_queue: augment nfqa_cfg_policy

Fabio Estevam (2):
      drm/etnaviv: Check for platform_device_register_simple() failure
      drm/etnaviv: Fix driver unregistering

Florian Westphal (1):
      netfilter: x_tables: initialise match/target check parameter struct

Greg Kroah-Hartman (1):
      Linux 4.17.7

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Hui Wang (1):
      ALSA: hda/realtek - two more lenovo models need fixup of MIC_LOCATION

Jaegeuk Kim (4):
      f2fs: give message and set need_fsck given broken node id
      f2fs: avoid bug_on on corrupted inode
      f2fs: sanity check on sit entry
      f2fs: sanity check for total valid node blocks

Jann Horn (2):
      ibmasm: don't write out of bounds in read handler
      USB: yurex: fix out-of-bounds uaccess in read handler

Jiri Olsa (1):
      tracing/kprobe: Release kprobe print_fmt properly

Joel Fernandes (Google) (1):
      tracing: Reorder display of TGID to be after PID

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Juergen Gross (2):
      xen: remove global bit from __default_kernel_pte_mask for pv guests
      xen: setup pv irq ops vector earlier

Leon Romanovsky (1):
      RDMA/ucm: Mark UCM interface as BROKEN

Linus Torvalds (1):
      Fix up non-directory creation in SGID directories

Lucas Stach (1):
      drm/etnaviv: bring back progress check in job timeout handler

Marc Orr (1):
      kvm: vmx: Nested VM-entry prereqs for event inj.

Michael J. Ruhl (1):
      IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Michal Hocko (1):
      mm: do not bug_on on incorrect length in __mm_populate()

Mika Westerberg (2):
      ahci: Add Intel Ice Lake LP PCI ID
      thunderbolt: Notify userspace when boot_acl is changed

Murray McAllister (1):
      staging: rtl8723bs: Prevent an underflow in rtw_check_beacon_data().

Nadav Amit (1):
      vmw_balloon: fix inflation with batching

Nico Sneck (1):
      usb: quirks: add delay quirks for Corsair Strafe

Oleg Nesterov (1):
      uprobes/x86: Remove incorrect WARN_ON() in uprobe_init_insn()

Olli Salonen (1):
      USB: serial: cp210x: add another USB ID for Qivicon ZigBee stick

Oscar Salvador (1):
      fs, elf: make sure to page align bss in load_elf_library

Paul Burton (3):
      MIPS: Call dump_stack() from show_regs()
      MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()
      MIPS: Fix ioremap() RAM check

Paul Menzel (1):
      tools build: fix # escaping in .cmd files for future Make

Pavel Tatashin (1):
      mm: zero unavailable pages before memmap init

Philipp Rudo (1):
      x86/purgatory: add missing FORCE to Makefile target

Ping-Ke Shih (1):
      staging: r8822be: Fix RTL8822be can't find any wireless AP

Rafael J. Wysocki (1):
      ACPICA: Clear status of all events when entering S5

Randy Dunlap (1):
      kbuild: delete INSTALL_FW_PATH from kbuild documentation

Stefan Agner (1):
      mmc: sdhci-esdhc-imx: allow 1.8V modes without 100/200MHz pinctrl sta=
tes

Steve Wise (1):
      iw_cxgb4: correctly enforce the max reg_mr depth

Tetsuo Handa (2):
      PM / hibernate: Fix oops at snapshot_write()
      loop: remember whether sysfs_create_group() was done

Theodore Ts'o (1):
      loop: add recursion validation to LOOP_CHANGE_FD

Tony Battersby (1):
      bsg: fix bogus EINVAL on non-data commands

Vignesh R (1):
      mtd: spi-nor: cadence-quadspi: Fix direct mode write timeouts

Vlastimil Babka (1):
      fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*

Wolfram Sang (1):
      i2c: recovery: if possible send STOP with recovery pulses

Yandong Zhao (1):
      arm64: neon: Fix function may_use_simd() return error status

Yoshihiro Shimoda (1):
      mmc: renesas_sdhi_internal_dmac: Cannot clear the RX_IN_USE in abort

x00270170 (1):
      mmc: dw_mmc: fix card threshold control configuration


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltNzBAACgkQONu9yGCS
aT6YuQ/8DWK0iTqhnyZ8X5vDeZvMHM1jQYhBbjPa2GHblmdaXuQGtraS7UoE3Kyo
CAedML2/BZor/SkHWbRhwTIy0/pZS0e5nYLrVRueRBHG31aMqRZK0gyGr9ugok/u
AVIYgmKV1elht7enFS8lsWydVBCae7qxtAYvHyXBpi+MBni2l+VUQINnDlGnm6fu
o1y642KxmEBzW8wRTTsPkykMUHH2WBFxI2i7MRX2ls8YvL5d/whs4tZmZObghTtd
ctKI+JVJljct8mFe0ImjFaESh/WCdmHdKYkS2RWUMHxhuDYy7JbkJCmbNEicfRLt
FPqge1adJYL6P620805ZvL9CJRqckKFOaFNL0Yaj4fVP23W1yD6hmIbjZAzfNxpm
SnBwYRzuosuNZTMkYimbmIDV3x5s0qgSxE7R5zHwU/j+f/uvFFYg1VqDyXfEuOS5
P+Rk5eiVNy45KRnSpQI9iXFBH9A+Bi6PUqmrGHzKdyx/9g+xlQq/Jk3Ue//IRI3G
Y+1ZfIvgdcwZhtD+HxD8I6UFG5//TcujVa7Vz/yQ1nI2rp82Ukjkr8/JdAjx60a8
2MrzMR5y8hfJKC/LRodS5TRiZzZIjuqdhaC0Hu/XzduHDYUWWDvNHForzQK5VCZn
4ll/c8NcPVYrPMfdSsmeU9m6cuLs0ZnFgpo+laHa+Ufulzs1swY=
=finQ
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
