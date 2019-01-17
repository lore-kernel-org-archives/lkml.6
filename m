Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53273C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16A1820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547725262;
	bh=uZ+9RodCmIJ3cvO73jQAFoOq0KbHbNs+vjaF5fwT68Y=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=g5W0tUZfqr+wOCEb/bEDb4yJzKxp3DM4JUnK+SY8ZOaYZE1FAYWBtGQseNov5qJJ3
	 bM/GqgNDc0CS4f+HTtv5N9MZslwzFnh+BkgwrC3FQSWQqzotQYT/VBEGf15MDWxExH
	 DZqEhlPBRDY4waMi/d7FMIx4Wqhtxfi1dmKKxorM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbfAQLlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:41:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfAQLk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:40:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1557B20657;
        Thu, 17 Jan 2019 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547725258;
        bh=uZ+9RodCmIJ3cvO73jQAFoOq0KbHbNs+vjaF5fwT68Y=;
        h=Date:From:To:Cc:Subject:From;
        b=b4SMPJTPr78gjfibQVTvqbS2a/Bzg0GDxsvfJAlVYA6XRGO+L08olKEj95nIL7KOS
         DdA1MspTEykJ+umrmZlha6V2KI1WEsy5x+ubyWkMiC2jFEIWobIwi0daQIATg5DzPV
         7ynYes0nXl2HHWeZrHt8DHzeTRKof1OQI6ZMEUwc=
Date:   Thu, 17 Jan 2019 12:40:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.171
Message-ID: <20190117114056.GA1867@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.171 kernel.

All users of the 4.4 kernel series must upgrade.

The updated 4.4.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.4.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                           |    2=20
 crypto/cts.c                       |    8=20
 drivers/acpi/power.c               |   22 +
 drivers/i2c/i2c-dev.c              |    6=20
 drivers/pci/host/pcie-altera.c     |  201 ++++++++---
 drivers/usb/class/cdc-acm.c        |    7=20
 drivers/usb/core/quirks.c          |    3=20
 drivers/usb/storage/scsiglue.c     |    8=20
 drivers/usb/storage/unusual_devs.h |   12=20
 fs/btrfs/Makefile                  |    2=20
 fs/btrfs/ctree.c                   |   14=20
 fs/btrfs/ctree.h                   |  141 ++++----
 fs/btrfs/dev-replace.c             |    2=20
 fs/btrfs/disk-io.c                 |   80 ----
 fs/btrfs/extent-tree.c             |  112 ++++++
 fs/btrfs/extent_io.c               |   43 +-
 fs/btrfs/extent_io.h               |   19 -
 fs/btrfs/extent_map.c              |    2=20
 fs/btrfs/extent_map.h              |   10=20
 fs/btrfs/scrub.c                   |    2=20
 fs/btrfs/struct-funcs.c            |    9=20
 fs/btrfs/tree-checker.c            |  649 ++++++++++++++++++++++++++++++++=
+++++
 fs/btrfs/tree-checker.h            |   38 ++
 fs/btrfs/volumes.c                 |  139 +++++++
 fs/btrfs/volumes.h                 |    2=20
 fs/cifs/file.c                     |    8=20
 fs/cifs/smb2file.c                 |    4=20
 fs/cifs/transport.c                |    2=20
 fs/ext4/inline.c                   |    6=20
 include/linux/sunrpc/svc.h         |    5=20
 mm/slab.c                          |    6=20
 net/sunrpc/svc.c                   |   10=20
 net/sunrpc/svc_xprt.c              |    5=20
 net/sunrpc/svcsock.c               |    2=20
 sound/pci/hda/patch_realtek.c      |   16=20
 35 files changed, 1323 insertions(+), 274 deletions(-)

Arnd Bergmann (1):
      btrfs: tree-checker: use %zu format string for size_t

Bjorn Helgaas (1):
      PCI: altera: Reorder read/write functions

Christoph Lameter (1):
      slab: alien caches must not be initialized if the allocation of the a=
lien cache failed

Daniele Palmas (1):
      usb: cdc-acm: send ZLP for Telit 3G Intel based modems

David Sterba (1):
      btrfs: tree-check: reduce stack consumption in check_dir_item

Eric Biggers (1):
      crypto: cts - fix crash on short inputs

Filipe Manana (1):
      Btrfs: fix emptiness check for dirtied extent buffers at check_leaf()

Greg Kroah-Hartman (1):
      Linux 4.4.171

Gu Jinxiang (1):
      btrfs: validate type when reading a chunk

Hans de Goede (1):
      ACPI: power: Skip duplicate power resource references in _PRx

Icenowy Zheng (2):
      USB: storage: don't insert sane sense for SPC3+ when bad sense specif=
ied
      USB: storage: add quirk for SMI SM3350

Jack Stocker (1):
      USB: Add USB_QUIRK_DELAY_CTRL_MSG quirk for Corsair K70 RGB

Jeff Mahoney (2):
      btrfs: cleanup, stop casting for extent_map->lookup everywhere
      btrfs: struct-funcs, constify readers

Josef Bacik (1):
      Btrfs: fix em leak in find_first_block_group

Kailang Yang (1):
      ALSA: hda/realtek - Disable headset Mic VREF for headset mode of ALC2=
25

Ley Foon Tan (6):
      PCI: altera: Fix altera_pcie_link_is_up()
      PCI: altera: Check link status before retrain link
      PCI: altera: Poll for link up status after retraining the link
      PCI: altera: Poll for link training status after retraining the link
      PCI: altera: Rework config accessors for use without a struct pci_bus
      PCI: altera: Move retrain from fixup to altera_pcie_host_init()

Liu Bo (9):
      Btrfs: add validadtion checks for chunk loading
      Btrfs: check inconsistence between chunk and block group
      Btrfs: detect corruption when non-root leaf has zero item
      Btrfs: check btree node's nritems
      Btrfs: fix BUG_ON in btrfs_mark_buffer_dirty
      Btrfs: memset to avoid stale content in btree node block
      Btrfs: improve check_node to avoid reading corrupted nodes
      Btrfs: kill BUG_ON in run_delayed_tree_ref
      Btrfs: memset to avoid stale content in btree leaf

Pavel Shilovsky (1):
      CIFS: Do not hide EINTR after sending network packets

Qu Wenruo (14):
      btrfs: Enhance chunk validation check
      btrfs: Refactor check_leaf function for later expansion
      btrfs: Check if item pointer overlaps with the item itself
      btrfs: Add sanity check for EXTENT_DATA when reading out leaf
      btrfs: Add checker for EXTENT_CSUM
      btrfs: Move leaf and node validation checker to tree-checker.c
      btrfs: tree-checker: Enhance btrfs_check_node output
      btrfs: tree-checker: Fix false panic for sanity test
      btrfs: tree-checker: Add checker for dir item
      btrfs: tree-checker: Verify block_group_item
      btrfs: tree-checker: Detect invalid and empty essential trees
      btrfs: Check that each block group has corresponding chunk at mount t=
ime
      btrfs: Verify that every chunk has corresponding block group at mount=
 time
      btrfs: tree-checker: Check level for leaves and nodes

Ross Lagerwall (1):
      cifs: Fix potential OOB access of lock element array

Shaokun Zhang (1):
      btrfs: tree-checker: Fix misleading group system information

Theodore Ts'o (1):
      ext4: fix a potential fiemap/page fault deadlock w/ inline_data

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()

Yi Zeng (1):
      i2c: dev: prevent adapter retries and timeout being set as minus value


--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxAacUACgkQONu9yGCS
aT6wKg/+N8QFrk9QgxzExucCa3JXrViG+4x8pT+evOzZiW828wPqjR/JEaoVVc/P
7uQ4wfdwb+Ew6yfA3q6hwgk0+IgzTtD7XPJlBSbRUCcDSt0avKvrhoKVwESBzYgb
jhu5c5PBoRt+kmfNdz01PDE5ntqPUs5WVaMZwdMSqeuwKIQARBuE4M7ptJldE8F5
uTceTDPnBdDoD75dL7pn3tDS5+vSPosSty2vIGPRW2RwsE8XuB0VFraklMdliVXH
OORGYwuKpVKnWvaA/fRsrw57YbHU47Tc/pJCY5LfsClW9L8z+t3lthir4CJ0sirS
m7fXIj636sqxQueXbAO/Dh9zefISLm5OK09ZLo0d8LSzd4ZfZeQNyzqogxfTIjtk
lFaFC2JEIwh1weTEJ61637iKh9FwuEdhY/4LJPYS2OWPudnom4WzQyBsJH8IzDwy
LpLXXBds7KpKcYYR2jT3FkrXpRg6Jn0/+PtQmHOD5MahsN1DAYehk9YPmPRQKS1N
Y07e0pnTeva1Qsg2PxUyXevOpA2c0hauEvWVMTcN4oyonrvQXcxBfb3zYz4Z5A2Q
hEDJXgcuvMsj/Tt5mJ6zZRl6BLsLI1GD5CipU2YvtBt2lEr9If/6pPRmz48gMZmV
vlv7GZ+zPTfLD/ZWvxI2YsH+xZjVojrALyPX5Fg0qMo/RZVbiH0=
=pPL2
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--
