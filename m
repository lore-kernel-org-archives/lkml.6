Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC83C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AFF7206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AFF7206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIJL6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 07:58:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58112 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeIJL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 07:58:38 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 071ACCAA;
        Mon, 10 Sep 2018 07:06:02 +0000 (UTC)
Date:   Mon, 10 Sep 2018 09:05:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.122
Message-ID: <20180910070559.GA21006@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.122 kernel.

All users of the 3.18 kernel series must upgrade.

The updated 3.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-3.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                              |    2=20
 arch/alpha/kernel/osf_sys.c           |   64 ++++++++++------------
 arch/arm/boot/dts/tegra30-cardhu.dtsi |    1=20
 arch/powerpc/include/asm/fadump.h     |    3 -
 arch/powerpc/kernel/fadump.c          |   92 +++++++++++++++++++++++++++--=
---
 arch/powerpc/platforms/pseries/ras.c  |    2=20
 arch/sparc/kernel/sys_sparc_32.c      |   22 ++++---
 arch/sparc/kernel/sys_sparc_64.c      |   20 ++++---
 drivers/iio/frequency/ad9523.c        |    4 -
 drivers/md/bcache/writeback.c         |    4 +
 drivers/md/dm-cache-metadata.c        |    3 -
 drivers/pwm/pwm-tiehrpwm.c            |    2=20
 drivers/spi/spi-davinci.c             |    2=20
 drivers/video/fbdev/core/fbmem.c      |   38 +++++++++++--
 fs/nfs/blocklayout/dev.c              |    2=20
 fs/ubifs/journal.c                    |    7 ++
 fs/ubifs/lprops.c                     |    8 +-
 fs/xattr.c                            |    2=20
 include/video/udlfb.h                 |    2=20
 kernel/kthread.c                      |    8 ++
 kernel/sys.c                          |   95 ++++++++++++++++-------------=
-----
 kernel/trace/blktrace.c               |    4 +
 kernel/trace/trace.c                  |    4 +
 kernel/trace/trace_uprobe.c           |    2=20
 kernel/user_namespace.c               |   39 ++++++-------
 kernel/utsname_sysctl.c               |   41 ++++++++------
 mm/memory.c                           |    9 ---
 net/9p/client.c                       |    2=20
 net/9p/trans_fd.c                     |    7 ++
 net/9p/trans_rdma.c                   |    3 +
 net/9p/trans_virtio.c                 |    6 +-
 31 files changed, 308 insertions(+), 192 deletions(-)

Al Viro (1):
      osf_getdomainname(): use copy_to_user()

Bartosz Golaszewski (1):
      spi: davinci: fix a NULL pointer dereference

Christian Brauner (1):
      getxattr: use correct xattr length

Dan Carpenter (1):
      pnfs/blocklayout: off by one in bl_map_stripe()

Eric W. Biederman (1):
      userns; Correct the comment in map_write

Greg Kroah-Hartman (1):
      Linux 3.18.122

Hari Bathini (1):
      powerpc/fadump: handle crash memory ranges array index overflow

Jann Horn (2):
      sys: don't hold uts_sem while accessing userspace memory
      userns: move user access out of the mutex

Jon Hunter (1):
      ARM: tegra: Fix Tegra30 Cardhu PCA954x reset

Lars-Peter Clausen (2):
      iio: ad9523: Fix displayed phase
      iio: ad9523: Fix return value for ad952x_store()

Mahesh Salgaonkar (1):
      powerpc/pseries: Fix endianness while restoring of r3 in MCE handler.

Mike Snitzer (1):
      dm cache metadata: save in-core policy_hint_size to on-disk superblock

Mikulas Patocka (2):
      fb: fix lost console when the user unplugs a USB adapter
      udlfb: set optimal write delay

Peter Zijlstra (1):
      mm/tlb: Remove tlb_remove_table() non-concurrent condition

Richard Weinberger (3):
      ubifs: Fix memory leak in lprobs self-check
      Revert "UBIFS: Fix potential integer overflow in allocation"
      ubifs: Fix synced_i_size calculation for xattr inodes

Shan Hai (1):
      bcache: release dc->writeback_lock properly in bch_writeback_thread()

Snild Dolkow (1):
      kthread, tracing: Don't expose half-written comm when creating kthrea=
ds

Steven Rostedt (VMware) (3):
      tracing: Do not call start/stop() functions when tracing_on does not =
change
      tracing/blktrace: Fix to allow setting same value
      uprobes: Use synchronize_rcu() not synchronize_sched()

Tomas Bortoli (3):
      net/9p/client.c: version pointer uninitialized
      net/9p/trans_fd.c: fix race-condition by flushing workqueue before th=
e kfree()
      9p: fix multiple NULL-pointer-dereferences

Vignesh R (1):
      pwm: tiehrpwm: Fix disabling of output of PWMs

jiangyiwen (1):
      9p/virtio: fix off-by-one error in sg list bounds check


--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAluWF9UACgkQONu9yGCS
aT59KA/+MvZgJ/2jY+KdvHCs6G5vmjoX8V94VqUyUsDhVseJ7lSAbING+zVhqkFU
RmakzpF+VqJ3I3JslP5P4czG4MDtlyydFG8N7IYZe5+3a8g9N0NVLFIkxHb0aNCS
nMHu7O4reoGmT7ra40e7fddJmw++kquoCvLfM4e8nAAQAgM4IEuvUd3qbvfDdpGf
bcB3qbdqAi+hFOgSFwWKoinj8vNpjtqMtPvh5xw5qqc9OVKG2mbpJ8V1hMpPxe35
eoYddQv0SsBCIe/CzD/quQfO9nF9oAWgMGIlywOsuLw92O2ATEMFxhMYpIVdRA1L
6meEkZ6T5jPMMEA+hAJC5fgExbBLPn8Wa1BSVvNGDoOnEow2Q0GJDKG/HfV+75Ai
VV8m14BQ+uiJDut8H/nc6GN8e6au9FFh+w5sZ16k4SaNX/uVKwCY00h8aAGFyMqI
/8xDQ1knJbyVa/32WfBRNZLD9kb1CCetTM5oSnX0XUkser16NV6F9AHHLE/n5j0H
CxxlkNqhtTfkXwU4qpcq7MfzZqNg90BCHnor/YfNNbIGhnvGmF85TFGiDsG4SjeA
Jg6M1QTK2qxCC6PP/l9kVBHKM8930Gtnckj8GkhlatqfoWz0UlGlQMsQwAW2E5Jp
Tb/GjedrX6lqsfA2EmWXikarda8s8q390RDn8nCdm25D2Bn31vc=
=xr4v
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--
