Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614D1ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EF220C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:50:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16EF220C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731219AbeGQLWb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:22:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730039AbeGQLWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:22:31 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F3B7DAD8;
        Tue, 17 Jul 2018 10:50:28 +0000 (UTC)
Date:   Tue, 17 Jul 2018 12:50:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.113
Message-ID: <20180717105026.GA18469@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.113 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                          |    2=20
 arch/mips/kernel/process.c        |    4 -
 arch/mips/kernel/traps.c          |    1=20
 arch/mips/mm/ioremap.c            |   37 ++++++++++++-----
 arch/x86/kernel/uprobes.c         |    2=20
 drivers/ata/ahci.c                |   59 ++++++++++++++++++++++++++++
 drivers/ata/libata-core.c         |    3 +
 drivers/ata/libata-scsi.c         |   18 +++++---
 drivers/block/loop.c              |   79 +++++++++++++++++++++------------=
-----
 drivers/block/loop.h              |    1=20
 drivers/hid/hid-ids.h             |    3 +
 drivers/hid/usbhid/hid-quirks.c   |    1=20
 drivers/i2c/busses/i2c-tegra.c    |   17 +++-----
 drivers/infiniband/Kconfig        |   12 +++++
 drivers/infiniband/core/Makefile  |    4 -
 drivers/infiniband/hw/cxgb4/mem.c |    2=20
 drivers/misc/ibmasm/ibmasmfs.c    |   27 +-----------
 drivers/misc/vmw_balloon.c        |    4 -
 drivers/mmc/host/dw_mmc.c         |    7 +--
 drivers/nvme/host/core.c          |    3 -
 drivers/nvme/host/pci.c           |   27 +++++++-----
 drivers/usb/core/quirks.c         |    4 +
 drivers/usb/host/xhci-mem.c       |    2=20
 drivers/usb/misc/yurex.c          |   23 ++---------
 drivers/usb/serial/ch341.c        |    2=20
 drivers/usb/serial/cp210x.c       |    1=20
 drivers/usb/serial/keyspan_pda.c  |    4 +
 drivers/usb/serial/mos7840.c      |    3 +
 fs/binfmt_elf.c                   |    5 --
 fs/inode.c                        |    6 ++
 include/linux/libata.h            |    1=20
 kernel/power/user.c               |    5 ++
 net/bridge/netfilter/ebtables.c   |    2=20
 net/ipv4/netfilter/ip_tables.c    |    1=20
 net/ipv6/netfilter/ip6_tables.c   |    1=20
 net/netfilter/nfnetlink_queue.c   |    3 +
 sound/pci/hda/patch_hdmi.c        |   19 ++++++---
 tools/build/Build.include         |    4 -
 38 files changed, 259 insertions(+), 140 deletions(-)

Chris Wilson (1):
      ALSA: hda - Handle pm failure during hotplug

Damien Le Moal (2):
      ata: Fix ZBC_OUT command block check
      ata: Fix ZBC_OUT all bit handling

Dan Carpenter (2):
      USB: serial: ch341: fix type promotion bug in ch341_control_in()
      xhci: xhci-mem: off by one in xhci_stream_id_to_ring()

Eric Dumazet (1):
      netfilter: nf_queue: augment nfqa_cfg_policy

Florian Westphal (1):
      netfilter: x_tables: initialise match/target check parameter struct

Greg Kroah-Hartman (1):
      Linux 4.9.113

Hans de Goede (1):
      ahci: Disable LPM on Lenovo 50 series laptops with a too old BIOS

Jann Horn (2):
      ibmasm: don't write out of bounds in read handler
      USB: yurex: fix out-of-bounds uaccess in read handler

Johan Hovold (2):
      USB: serial: keyspan_pda: fix modem-status error handling
      USB: serial: mos7840: fix status-register error handling

Jon Hunter (1):
      i2c: tegra: Fix NACK error handling

Keith Busch (1):
      nvme-pci: Remap CMB SQ entries on every controller reset

Leon Romanovsky (1):
      RDMA/ucm: Mark UCM interface as BROKEN

Linus Torvalds (1):
      Fix up non-directory creation in SGID directories

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

Paul Burton (2):
      MIPS: Call dump_stack() from show_regs()
      MIPS: Fix ioremap() RAM check

Paul Menzel (1):
      tools build: fix # escaping in .cmd files for future Make

Scott Bauer (1):
      nvme: validate admin queue before unquiesce

Steve Wise (1):
      iw_cxgb4: correctly enforce the max reg_mr depth

Tetsuo Handa (2):
      PM / hibernate: Fix oops at snapshot_write()
      loop: remember whether sysfs_create_group() was done

Theodore Ts'o (1):
      loop: add recursion validation to LOOP_CHANGE_FD

Tomasz Kramkowski (1):
      HID: usbhid: add quirk for innomedia INNEX GENESIS/ATARI adapter

x00270170 (1):
      mmc: dw_mmc: fix card threshold control configuration


--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltNyfIACgkQONu9yGCS
aT7sqBAAyHKvo+wVInQqG/BHCY1XJUvSQkdZF0bz+5cPiI7jgS1HWoUfhawiBqxf
X5vijNLVeGWDOTpX4mp4qfBEJ6nqjz8H3KZ36S93coKwjzhJliTNzGTLl3iPc5xE
+Vklh+8ZQUTWWxy7oGvk7Mq9/eFKHUzUswp40do6IYfzOPa7xQtruwKg8bYoBnZI
jppGL0rrBvw8GAt9++t4sM6Bf8Ia+ixD1y96yU15Ue8LYKuLxtzVc5hTZ+Y987Fl
3iaylPJGUqQu972FmnCZoc6J/2ZyAB7bSfszgtXPQpC9jfkNioIVTBHE0S9MH4hH
tG3M94uHaqbQ8HWYjiKqdd3uM0x8Q8qwSzbTXpMkBQK3hPN9uvEtylZLfLRvaWB6
LeovaG9o3MU6RzHc14c6BfIqqGe3cTY+NfI8pCYBR1dKRHOOQ93un/FNRLqtrcgA
xNzLAsYybg3J4cv1wHmbVggxl9zBdoey8A2B3iwEO68IIPZijbNAqeHSOODPUbcX
TxHmfeF9YhiijobS2RdEmmXbXnMp3TZz32Ez/DmdqqAcUtcmhTfBCo47CP5LqYM8
oz0tpWEQHmCZBoiBl7XeItngDQ/Ab2Bw4WHnrVwhU095NJ9ofNXGDrhE15obGn3q
8jMM0tulUGnlEL6iB6LhxxOPOOGKj8uYF8VBv+DwXfnjiNOtNYs=
=1MEV
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
