Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0852C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA882082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9qA/MNd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA882082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbeK1GUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:20:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:41264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbeK1GUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:20:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9289B2082F;
        Tue, 27 Nov 2018 19:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543346298;
        bh=WMR0SPEIkaCLvDqbEnvLVdGYNcerFOE/kganBLczr+Y=;
        h=Date:From:To:Cc:Subject:From;
        b=T9qA/MNdPBRuSP3WssdHTi0IiJUHifG+z6XSJP0LmqRr1Sn7Y4nh5uKXmPcNwUxzK
         +jLcu9iYVPXkU6npYp+PQGWyo3i5qg5xJpyIMUicIw98XD5/npVgNB6jQZta8r0+MO
         rPdDVDrVUjcc/UNH3guupQN/pv178lLqzgbmuvNA=
Date:   Tue, 27 Nov 2018 20:18:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.141
Message-ID: <20181127191815.GA1720@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.141 kernel.

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

 Makefile                                          |    2=20
 arch/arm64/include/asm/percpu.h                   |    3=20
 arch/s390/kernel/vdso32/Makefile                  |    6 -
 arch/s390/kernel/vdso64/Makefile                  |    6 -
 arch/s390/numa/numa.c                             |    1=20
 arch/um/os-Linux/skas/process.c                   |    5 +
 drivers/acpi/acpi_platform.c                      |    1=20
 drivers/acpi/acpi_watchdog.c                      |   77 +++++++++++++++++=
++---
 drivers/block/zram/zram_drv.c                     |   26 +------
 drivers/bluetooth/Kconfig                         |    1=20
 drivers/clk/clk-fixed-factor.c                    |    1=20
 drivers/clk/clk-fixed-rate.c                      |    1=20
 drivers/clk/samsung/clk-exynos5420.c              |    1=20
 drivers/gpu/drm/drm_edid.c                        |    3=20
 drivers/hid/uhid.c                                |   13 +++
 drivers/hwmon/ibmpowernv.c                        |    7 --
 drivers/media/v4l2-core/v4l2-event.c              |   43 ++++++------
 drivers/media/v4l2-core/videobuf2-core.c          |    9 --
 drivers/misc/atmel-ssc.c                          |    2=20
 drivers/misc/sgi-gru/grukdump.c                   |    4 +
 drivers/net/ethernet/qlogic/qed/qed_sp.h          |    3=20
 drivers/net/ethernet/qlogic/qed/qed_sp_commands.c |   16 ++++
 drivers/net/ethernet/qlogic/qed/qed_spq.c         |   57 ++++++++--------
 drivers/platform/x86/acerhdf.c                    |    1=20
 drivers/platform/x86/intel_telemetry_debugfs.c    |    8 +-
 drivers/s390/net/qeth_l3_main.c                   |    8 +-
 drivers/uio/uio.c                                 |    7 +-
 drivers/usb/class/cdc-acm.c                       |    3=20
 drivers/usb/core/quirks.c                         |    8 ++
 drivers/usb/misc/appledisplay.c                   |    1=20
 fs/btrfs/disk-io.c                                |   19 ++++-
 fs/btrfs/extent-tree.c                            |   63 +++++++++++-------
 fs/btrfs/ioctl.c                                  |   11 ++-
 fs/cifs/cifsfs.c                                  |    7 +-
 fs/exofs/super.c                                  |    5 +
 fs/gfs2/rgrp.c                                    |    3=20
 fs/hfs/brec.c                                     |    4 +
 fs/hfsplus/brec.c                                 |    4 +
 fs/reiserfs/xattr.c                               |    7 ++
 include/linux/netfilter/ipset/ip_set_comment.h    |    4 -
 include/linux/uaccess.h                           |    3=20
 lib/raid6/test/Makefile                           |    4 -
 net/ceph/messenger.c                              |   12 ++-
 net/netfilter/ipset/ip_set_hash_netportnet.c      |    8 +-
 net/netfilter/xt_IDLETIMER.c                      |   20 +++++
 net/sunrpc/xdr.c                                  |    2=20
 46 files changed, 350 insertions(+), 150 deletions(-)

Al Viro (1):
      new helper: uaccess_kernel()

Alan Tull (1):
      clk: fixed-rate: fix of_node_get-put imbalance

Andreas Gruenbacher (1):
      gfs2: Put bitmap buffers in put_super

Chengguang Xu (1):
      fs/exofs: fix potential memory leak in mount option parsing

Colin Ian King (1):
      cifs: don't dereference smb_file_target before null check

Dan Carpenter (1):
      uio: Fix an Oops on load

Denis Bolotin (2):
      qed: Fix memory/entry leak in qed_init_sp_request()
      qed: Fix blocking/unlimited SPQ entries leak

Emmanuel Pescosta (1):
      usb: quirks: Add delay-init quirk for Corsair K70 LUX RGB

Eric Biggers (1):
      HID: uhid: forbid UHID_CREATE under KERNEL_DS or elevated privileges

Eric Westbrook (1):
      netfilter: ipset: actually allow allowable CIDR 0 in hash:net,port,net

Ernesto A. Fern=E1ndez (2):
      hfs: prevent btree data loss on root split
      hfsplus: prevent btree data loss on root split

Geert Uytterhoeven (1):
      hwmon: (ibmpowernv) Remove bogus __init annotations

Greg Kroah-Hartman (2):
      Revert "Bluetooth: h5: Fix missing dependency on BT_HCIUART_SERDEV"
      Linux 4.9.141

Gustavo A. R. Silva (1):
      drivers/misc/sgi-gru: fix Spectre v1 vulnerability

Hans Verkuil (1):
      Revert "media: videobuf2-core: don't call memop 'finish' when queuein=
g"

Hans de Goede (1):
      ACPI / platform: Add SMB0001 HID to forbidden_id_list

Ilya Dryomov (1):
      libceph: fall back to sendmsg for slab pages

Jann Horn (1):
      reiserfs: propagate errors from fill_with_dentries() properly

Jeremy Linton (1):
      lib/raid6: Fix arm64 test build

Jozsef Kadlecsik (1):
      netfilter: ipset: Correct rcu_dereference() call in ip_set_put_commen=
t()

Julian Wiedmann (1):
      s390/qeth: fix HiperSockets sniffer

Justin M. Forbes (1):
      s390/mm: Fix ERROR: "__node_distance" undefined!

Kai-Heng Feng (1):
      USB: quirks: Add no-lpm quirk for Raydium touchscreens

Lee, Shawn C (1):
      drm/edid: Add 6 bpc quirk for BOE panel.

Lu Fengqi (1):
      btrfs: fix pinned underflow after transaction aborted

Maarten Jacobs (1):
      usb: cdc-acm: add entry for Hiro (Conexant) modem

Marek Szyprowski (1):
      clk: samsung: exynos5420: Enable PERIS clocks for suspend

Mattias Jacobsson (1):
      USB: misc: appledisplay: add 20" Apple Cinema Display

Mika Westerberg (2):
      ACPI / watchdog: Prefer iTCO_wdt on Lenovo Z50-70
      ACPI / watchdog: Prefer iTCO_wdt always when WDAT table uses RTC SRAM

Minchan Kim (1):
      zram: close udev startup race condition as default groups

Nathan Chancellor (2):
      arm64: percpu: Initialize ret in the default case
      misc: atmel-ssc: Fix section annotation on atmel_ssc_get_driver_data

Paul Gortmaker (1):
      platform/x86: acerhdf: Add BIOS entry for Gateway LT31 v1.3307

Qu Wenruo (2):
      btrfs: Enhance btrfs_trim_fs function to handle error better
      btrfs: Ensure btrfs_trim_fs can trim the whole filesystem

Rajneesh Bhardwaj (1):
      platform/x86: intel_telemetry: report debugfs failure

Ricardo Ribalda Delgado (1):
      clk: fixed-factor: fix of_node_get-put imbalance

Richard Weinberger (1):
      um: Give start_idle_thread() a return code

Sakari Ailus (1):
      media: v4l: event: Add subscription to list before calling "add" oper=
ation

Taehee Yoo (1):
      netfilter: xt_IDLETIMER: add sysfs filename checking routine

Vasily Gorbik (1):
      s390/vdso: add missing FORCE to build targets

YueHaibing (1):
      SUNRPC: drop pointless static qualifier in xdr_get_next_encode_buffer=
()


--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlv9mHcACgkQONu9yGCS
aT6AvQ//WyRn8y7ct8sChVJHOJPYTtZxxd9wg5vEFRaIviMmUsa/+7EmH5CGN7AK
OIEiTcdS4+FU8wg5Pw1fqxB6qjRTbcCCmu3bE47rh8DxWF9T0l34A/1cHIstyeX8
kVMPI3Lp90+8Tw70b1mM2eOK505PSLeYGjqg+GO/CMmvWlspU/JR7vqZ3rlmc28l
qoSOLfZRkjRHYfSBD+OXzYGZMvt/wJk2SAkkrd1Mn3/yNFhm4y6dI+yx9nOaMfMh
t4V7fdEQQRfMvV1k9rJetUOcE8Z2jrywIziveWQ6ejmKV4wQnFZ5cyLoncf4HP+0
NnqCJgSU8apL06JeJIBxnF08ECq4A8dq6oZjE2uE0g12HapVawRXk+Ji4AdRJsAs
myyGdsq0x41GTAZsybTLznew17GN3YkOGoBEn+WybKuhE6CRft2FvF1UtCKX9aO5
85pUjYtD3pJhUymS/iPFqnQZCEnBlIeOvg35STZ7M1quBsjdFOW30QxuhQ3etjRJ
9DX6tv0J9PcOw30NqFk2adYUTa+fJB+3zMghmiemFg4OCn88uLgZODnco61oFwzR
wgFiaXU72fHx1Ezu5Ogn3PLlWB2ePlPL/+Xt7BXtixZwCLdj9+u4Fg0zRKcgRXlx
6DUxLZyDiPV8DF/dd3UZIq8GnK//9itUPdC7KRLRDgYGfpUEqX4=
=wLFM
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
