Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD5AECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47FE20C0E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:51:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47FE20C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbeGQLXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:23:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbeGQLXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:23:05 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 02A24AD8;
        Tue, 17 Jul 2018 10:51:02 +0000 (UTC)
Date:   Tue, 17 Jul 2018 12:51:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.56
Message-ID: <20180717105100.GA20647@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.56 kernel.

All users of the 4.14 kernel series must upgrade.

The updated 4.14.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.14.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Documentation/kbuild/kbuild.txt                     |    9=20
 Makefile                                            |    2=20
 arch/arm64/include/asm/simd.h                       |   19=20
 arch/mips/kernel/process.c                          |   43=20
 arch/mips/kernel/traps.c                            |    1=20
 arch/mips/mm/ioremap.c                              |   37=20
 arch/x86/crypto/Makefile                            |    4=20
 arch/x86/crypto/salsa20-i586-asm_32.S               | 1114 ---------------=
-----
 arch/x86/crypto/salsa20-x86_64-asm_64.S             |  919 ----------------
 arch/x86/crypto/salsa20_glue.c                      |  116 --
 arch/x86/kernel/uprobes.c                           |    2=20
 arch/x86/xen/enlighten_pv.c                         |   24=20
 arch/x86/xen/irq.c                                  |    4=20
 crypto/Kconfig                                      |   26=20
 drivers/ata/ahci.c                                  |   59 +
 drivers/ata/libata-core.c                           |    3=20
 drivers/ata/libata-scsi.c                           |   18=20
 drivers/block/loop.c                                |   79 -
 drivers/block/loop.h                                |    1=20
 drivers/i2c/busses/i2c-tegra.c                      |   17=20
 drivers/infiniband/Kconfig                          |   12=20
 drivers/infiniband/core/Makefile                    |    4=20
 drivers/infiniband/hw/cxgb4/mem.c                   |    2=20
 drivers/infiniband/hw/hfi1/rc.c                     |    2=20
 drivers/infiniband/hw/hfi1/uc.c                     |    4=20
 drivers/infiniband/hw/hfi1/ud.c                     |    4=20
 drivers/infiniband/hw/hfi1/verbs_txreq.c            |    4=20
 drivers/infiniband/hw/hfi1/verbs_txreq.h            |    4=20
 drivers/media/rc/ir-mce_kbd-decoder.c               |    2=20
 drivers/misc/ibmasm/ibmasmfs.c                      |   27=20
 drivers/misc/vmw_balloon.c                          |    4=20
 drivers/mmc/host/dw_mmc.c                           |    7=20
 drivers/mmc/host/sdhci-esdhc-imx.c                  |   21=20
 drivers/nvme/host/pci.c                             |   27=20
 drivers/scsi/megaraid/megaraid_sas.h                |   10=20
 drivers/scsi/megaraid/megaraid_sas_base.c           |  296 +++--
 drivers/scsi/megaraid/megaraid_sas_fp.c             |   20=20
 drivers/scsi/megaraid/megaraid_sas_fusion.c         |   54=20
 drivers/scsi/megaraid/megaraid_sas_fusion.h         |    7=20
 drivers/staging/rtl8723bs/core/rtw_ap.c             |    2=20
 drivers/staging/rtlwifi/rtl8822be/hw.c              |    2=20
 drivers/staging/rtlwifi/wifi.h                      |    1=20
 drivers/usb/core/quirks.c                           |    4=20
 drivers/usb/host/xhci-mem.c                         |    2=20
 drivers/usb/misc/yurex.c                            |   23=20
 drivers/usb/serial/ch341.c                          |    2=20
 drivers/usb/serial/cp210x.c                         |    1=20
 drivers/usb/serial/keyspan_pda.c                    |    4=20
 drivers/usb/serial/mos7840.c                        |    3=20
 fs/binfmt_elf.c                                     |    5=20
 fs/devpts/inode.c                                   |   48=20
 fs/f2fs/f2fs.h                                      |   13=20
 fs/f2fs/inode.c                                     |   13=20
 fs/f2fs/node.c                                      |   21=20
 fs/inode.c                                          |    6=20
 fs/proc/task_mmu.c                                  |    2=20
 include/linux/libata.h                              |    1=20
 kernel/irq/affinity.c                               |   30=20
 kernel/power/user.c                                 |    5=20
 kernel/trace/trace.c                                |    8=20
 kernel/trace/trace_output.c                         |    5=20
 mm/gup.c                                            |    2=20
 mm/mmap.c                                           |   29=20
 mm/rmap.c                                           |    8=20
 net/bridge/netfilter/ebtables.c                     |    2=20
 net/ipv4/netfilter/ip_tables.c                      |    1=20
 net/ipv6/netfilter/ip6_tables.c                     |    1=20
 net/netfilter/nfnetlink_queue.c                     |    3=20
 sound/pci/hda/patch_hdmi.c                          |   19=20
 sound/pci/hda/patch_realtek.c                       |    6=20
 sound/soc/mediatek/common/mtk-afe-platform-driver.c |    4=20
 tools/build/Build.include                           |    4=20
 72 files changed, 664 insertions(+), 2624 deletions(-)

Chris Wilson (1):
      ALSA: hda - Handle pm failure during hotplug

Christian Borntraeger (1):
      mm: do not drop unused pages when userfaultd is running

Christian Brauner (2):
      devpts: hoist out check for DEVPTS_SUPER_MAGIC
      devpts: resolve devpts bind-mounts

Christoph Hellwig (1):
      genirq/affinity: assign vectors to all possible CPUs

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Dan Carpenter (2):
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Eric Biggers (1):
      crypto: x86/salsa20 - remove x86 salsa20 implementations

Eric Dumazet (1):
      netfilter: nf_queue: augment nfqa_cfg_policy

Florian Westphal (1):
      netfilter: x_tables: initialise match/target check parameter struct

Greg Kroah-Hartman (1):
      Linux 4.14.56

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Hui Wang (1):
      ALSA: hda/realtek - two more lenovo models need fixup of MIC_LOCATION

Jaegeuk Kim (1):
      f2fs: give message and set need_fsck given broken node id

Jann Horn (2):
      ibmasm: don't write out of bounds in read handler
      USB: yurex: fix out-of-bounds uaccess in read handler

Joel Fernandes (Google) (1):
      tracing: Reorder display of TGID to be after PID

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Juergen Gross (1):
      xen: setup pv irq ops vector earlier

Kai Chieh Chuang (1):
      ASoC: mediatek: preallocate pages use platform device

Keith Busch (1):
      nvme-pci: Remap CMB SQ entries on every controller reset

Leon Romanovsky (1):
      RDMA/ucm: Mark UCM interface as BROKEN

Linus Torvalds (1):
      Fix up non-directory creation in SGID directories

Michael J. Ruhl (1):
      IB/hfi1: Fix incorrect mixing of ERR_PTR and NULL return values

Michal Hocko (1):
      mm: do not bug_on on incorrect length in __mm_populate()

Ming Lei (1):
      scsi: megaraid_sas: fix selection of reply queue

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

Ping-Ke Shih (1):
      staging: r8822be: Fix RTL8822be can't find any wireless AP

Randy Dunlap (1):
      kbuild: delete INSTALL_FW_PATH from kbuild documentation

Sean Young (1):
      media: rc: mce_kbd decoder: fix stuck keys

Shivasharan S (4):
      scsi: megaraid_sas: use adapter_type for all gen controllers
      scsi: megaraid_sas: replace instance->ctrl_context checks with instan=
ce->adapter_type
      scsi: megaraid_sas: replace is_ventura with adapter_type checks
      scsi: megaraid_sas: Create separate functions to allocate ctrl memory

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

Vlastimil Babka (1):
      fs/proc/task_mmu.c: fix Locked field in /proc/pid/smaps*

Yandong Zhao (1):
      arm64: neon: Fix function may_use_simd() return error status

x00270170 (1):
      mmc: dw_mmc: fix card threshold control configuration


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltNyhQACgkQONu9yGCS
aT4J4Q//Q6lzp69LXyvhFDG3YmYdRB7u3cAX1eEXTYenY9gtm/yS2hB6ypOCTijz
EehjS1eKXYpJCZ7l8JwI4ZSqWNNCZrb1duSy5mch0cLBoV9EI8iJ24Paj2vwwUan
uRFTR9fmkDcOYm32akEZDLupr3jRZpbkt7zOOtYxA5dasvzDxJpHy8UKDU2dy/D5
KMy6U0LJ+RHDTUcNy6h6zUxHc7Ir9lRfhI2EGdW++V6SQo3q2QIYo8PAeAoPM6/d
Wijrw8cpio8bd/Emuxoe5sH0b1O+SPxXyuU87p3Kn5fvZRHLCgSDfV1OZTGVjnRb
0PpntbBDsSkmZm7LPBIeaDcB8bw+BCmJTqHTRLJI5XeO1OQ7EPT4ww4kIov8dubF
qJ3zZG9OUh8OujLxiiiikXrICWZbjGfRZoSNSvhKlV1d5v3xvAfb0RtOEKh4SNq9
lj359J9lFnGw4/29jkpXz0LsZScW2GcLlxpsS0XxFnnMa3bD8YyJ2Vk4qEJmY9dx
EJHDt1nWNHvthcnRCtb5lwFFpZM2+d1gM/SugZx+uXabAAVhvy0Sgjyi3OhEdXu4
6Ix4njA+H4wTnVwXwkFpkppJSzGh07mSDTbivtpDKotx8MGfLAS6B1FHyjP3yX/P
M14O4KDkCyhPEa1X4hM7IVbi/qiVq7H3kpxM4gHmc8sp8tCbr1U=
=jotd
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
