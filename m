Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFDEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F48208A5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 12:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F48208A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732067AbeHIPBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 11:01:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49654 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730573AbeHIPBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 11:01:51 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D8DD0D0E;
        Thu,  9 Aug 2018 12:37:07 +0000 (UTC)
Date:   Thu, 9 Aug 2018 14:37:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.62
Message-ID: <20180809123704.GA8075@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.62 kernel.

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

 Makefile                          |    2 -
 drivers/i2c/busses/i2c-imx.c      |    3 -
 drivers/idle/intel_idle.c         |    7 +++-
 drivers/nvme/host/pci.c           |   64 ++++++++++++++++-----------------=
-----
 drivers/nvme/target/fc.c          |   44 ++++++++++++++++++++------
 drivers/pci/pci-acpi.c            |    2 -
 drivers/scsi/qla2xxx/qla_attr.c   |    1=20
 drivers/scsi/qla2xxx/qla_gbl.h    |    1=20
 drivers/scsi/qla2xxx/qla_gs.c     |    4 ++
 drivers/scsi/qla2xxx/qla_init.c   |    7 +---
 drivers/scsi/qla2xxx/qla_inline.h |    2 +
 drivers/scsi/qla2xxx/qla_mid.c    |    5 ++
 drivers/scsi/qla2xxx/qla_os.c     |    7 ++--
 fs/btrfs/extent_io.c              |    3 +
 fs/ext4/super.c                   |    4 +-
 fs/jfs/xattr.c                    |   10 +++--
 fs/xfs/libxfs/xfs_attr_leaf.c     |    5 +-
 fs/xfs/xfs_icache.c               |   58 ++++++++++++++++++++++++++++++----
 include/linux/ring_buffer.h       |    1=20
 kernel/irq/manage.c               |    9 ++++-
 kernel/softirq.c                  |    2 -
 kernel/time/tick-sched.c          |    2 -
 kernel/trace/ring_buffer.c        |   16 +++++++++
 kernel/trace/trace.c              |    6 +++
 net/netlink/af_netlink.c          |    4 +-
 25 files changed, 191 insertions(+), 78 deletions(-)

Anil Gurumurthy (1):
      scsi: qla2xxx: Return error when TMF returns

Anna-Maria Gleixner (1):
      nohz: Fix local_timer_softirq_pending()

Dave Chinner (2):
      xfs: catch inode allocation state mismatch corruption
      xfs: validate cached inodes are free when allocated

Dmitry Safonov (1):
      netlink: Don't shift on 64 for ngroups

Eric Sandeen (1):
      xfs: don't call xfs_da_shrink_inode with NULL bp

Esben Haabendal (1):
      i2c: imx: Fix reinit_completion() use

Filipe Manana (1):
      Btrfs: fix file data corruption after cloning a range and fsync

Frederic Weisbecker (1):
      nohz: Fix missing tick reprogram when interrupting an inline softirq

Greg Kroah-Hartman (1):
      Linux 4.14.62

James Smart (1):
      nvmet-fc: fix target sgl list on large transfers

Keith Busch (1):
      nvme-pci: Fix queue double allocations

Len Brown (1):
      intel_idle: Graceful probe failure when MWAIT is disabled

Masami Hiramatsu (1):
      ring_buffer: tracing: Inherit the tracing setting to next ring buffer

Quinn Tran (3):
      scsi: qla2xxx: Fix unintialized List head crash
      scsi: qla2xxx: Fix NPIV deletion by calling wait_for_sess_deletion
      scsi: qla2xxx: Fix ISP recovery on unload

Sagi Grimberg (1):
      nvme-pci: allocate device queues storage space at probe

Shankara Pailoor (1):
      jfs: Fix inconsistency between memory allocation and ea_buf->max_size

Theodore Ts'o (1):
      ext4: fix false negatives *and* false positives in ext4_check_descrip=
tors()

Thomas Gleixner (1):
      genirq: Make force irq threading setup more robust

Vitaly Kuznetsov (1):
      ACPI / PCI: Bail early in acpi_pci_add_bus() if there is no ACPI hand=
le


--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltsNXAACgkQONu9yGCS
aT7+Fw/8CDOW1C+ppFjev12aSP4SobSrCoSoatQiIiqGG5AaE1vsVSZUId/tGACo
Xw0mOoTgBbwinKXmutEPGMeXdwwb8t8w0NXqrI2wnBxzmnu9XUZ0QSzwo7xLltG/
yOYHpcTqqm3pjlCLyIZ4/CbTqE/II8bbt0Xtj9tLHW/1RIyHVBpelhLHBJGzhDSm
z/AvdCvpT06MQnsaMV5Ivh+VrsTn4YHlAZ4GMpFWcxhiVelD8YkwrvKlDfvjlx9J
QQPGgPncQE0VN8aNG+iRZi8CdWzc3cCx7+6DQrv89D7u98ghbfvPZ8g1qKHT611y
VGRQrfgkurmPC31HKOnHPeqhIXqVWdHNj0u3W8VqxaCPBQ9+qQpc2cGAPKTH0yFw
PxCfIYPtQqyNsAyBmpohNx4Qxa1D50lepPmX7u7AGso4gY2q9LSjriBCYvK7Ouwq
02y4Qt+G/2/RTZhHLn1Bp3qi4HHx03BWmIXpHl5aGdapz1BIJE6/7yd/E4ol75Df
w/ezCakWPcu0x+KsqqISCQqhvFfmj/zGaNx3YyG5a72z1HpbfGmmxcrxg/vWdpPs
IsQ41pYIg3lWkhvIRItZItGQPdaJ8OoDCRzX6/1Pb34oKm02oYuv5is5XziylDv+
Bt9Z4G9sjE56FZhEcVrtgJ7kqXFOOH4KkDVHcPUOyFFlfq/pEFE=
=BEvu
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
