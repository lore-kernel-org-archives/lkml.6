Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F98F21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCXzsBYb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F98F21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbeJTUOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJTUOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:14:48 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214CE21523;
        Sat, 20 Oct 2018 12:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540037072;
        bh=segmp5m18w7e7nId4YE14zBdFNV5+rx1z8kl7lauLv4=;
        h=Date:From:To:Cc:Subject:From;
        b=GCXzsBYb0X+d+O2jGG5iQxKluXTXaC4EZi74oDozrwdQ3/suq2Nu4fcSihgfTxgxs
         RI5moLJsvSFHgHvkc/p8HGL4hXCb0gm02CmijoYTf9Etw2RPWKAmHx6fHIC274V9Sj
         wQSD12Y+vH51K0JpQQ/kR/Z7C2HY4lmvj7cgmGzA=
Date:   Sat, 20 Oct 2018 14:04:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.135
Message-ID: <20181020120428.GA14147@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.135 kernel.

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

 Makefile                                 |    2=20
 arch/arc/Makefile                        |   24 ---------
 arch/powerpc/kernel/tm.S                 |   20 +++++++-
 arch/s390/appldata/appldata_os.c         |   16 +++---
 arch/x86/include/asm/pgtable_types.h     |    2=20
 drivers/clocksource/timer-ti-32k.c       |    3 +
 drivers/cpufreq/cpufreq.c                |    6 +-
 drivers/cpufreq/cpufreq_governor.c       |    2=20
 drivers/cpufreq/cpufreq_stats.c          |    1=20
 drivers/gpu/drm/arm/malidp_drv.c         |    1=20
 drivers/hid/hid-core.c                   |    3 +
 drivers/hv/hv_kvp.c                      |   13 +++--
 drivers/input/keyboard/atakbd.c          |   74 +++++++++++---------------=
----
 drivers/iommu/amd_iommu.c                |    6 ++
 drivers/macintosh/rack-meter.c           |   28 +++++------
 drivers/media/usb/dvb-usb-v2/af9035.c    |    6 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c  |    3 -
 drivers/net/ethernet/renesas/ravb.h      |    5 ++
 drivers/net/ethernet/renesas/ravb_main.c |   11 ++--
 drivers/net/ethernet/renesas/ravb_ptp.c  |    2=20
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c |    5 --
 drivers/scsi/sd.c                        |    3 -
 drivers/usb/gadget/function/u_serial.c   |    2=20
 fs/ext4/ext4.h                           |    3 -
 fs/ext4/inline.c                         |   38 ---------------
 fs/ext4/xattr.c                          |   18 -------
 fs/proc/stat.c                           |   68 ++++++++++++++------------=
--
 fs/proc/uptime.c                         |    7 --
 include/linux/huge_mm.h                  |    2=20
 kernel/sched/cpuacct.c                   |    2=20
 kernel/sched/cputime.c                   |   75 +++++++++++++-------------=
-----
 kernel/sched/sched.h                     |   12 +++-
 mm/huge_memory.c                         |   10 +---
 mm/mremap.c                              |   30 +++++-------
 net/batman-adv/bat_v_elp.c               |    8 ++-
 net/batman-adv/bridge_loop_avoidance.c   |   10 +++-
 net/batman-adv/network-coding.c          |   27 ++++++-----
 net/batman-adv/soft-interface.c          |   25 +++++++---
 net/batman-adv/sysfs.c                   |   30 ++++++++----
 net/batman-adv/translation-table.c       |    6 +-
 net/batman-adv/tvlv.c                    |    8 ++-
 net/netfilter/nf_nat_core.c              |    2=20
 42 files changed, 295 insertions(+), 324 deletions(-)

Alexandru Gheorghe (1):
      drm: mali-dp: Call drm_crtc_vblank_reset on device init

Alexey Brodkin (2):
      ARC: build: Get rid of toolchain check
      ARC: build: Don't set CROSS_COMPILE in arch's Makefile

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Arindam Nath (1):
      iommu/amd: Return devid as alias for ACPI HID devices

Frederic Weisbecker (4):
      sched/cputime: Convert kcpustat to nsecs
      macintosh/rack-meter: Convert cputime64_t use to u64
      sched/cputime: Increment kcpustat directly on irqtime account
      sched/cputime: Fix ksoftirqd cputime accounting regression

Greg Kroah-Hartman (1):
      Linux 4.9.135

Jan Kara (1):
      mm: Preserve _PAGE_DEVMAP across mprotect() calls

Johannes Thumshirn (1):
      scsi: sd: don't crash the host on invalid commands

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

Kazuya Mizuguchi (1):
      ravb: do not write 1 to reserved bits

Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for=
 non-am43 SoCs

Laura Abbott (2):
      scsi: ibmvscsis: Fix a stringop-overflow warning
      scsi: ibmvscsis: Ensure partition name is properly NUL terminated

Linus Torvalds (1):
      mremap: properly flush TLB before releasing the page

Long Li (1):
      HV: properly delay KVP packets when negotiation is in progress

Marek Lindner (2):
      batman-adv: fix backbone_gw refcount on queue_work() failure
      batman-adv: fix hardif_neigh refcount on queue_work() failure

Michael Neuling (2):
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Natanael Copa (1):
      HID: quirks: fix support for Apple Magic Keyboards

Nathan Chancellor (1):
      net/mlx4: Use cpumask_available for eq->affinity_mask

Stephen Warren (1):
      usb: gadget: serial: fix oops when data rx'd after close

Sven Eckelmann (6):
      batman-adv: Fix segfault when writing to throughput_override
      batman-adv: Fix segfault when writing to sysfs elp_interval
      batman-adv: Prevent duplicated nc_node entry
      batman-adv: Prevent duplicated softif_vlan entry
      batman-adv: Prevent duplicated global TT entry
      batman-adv: Prevent duplicated tvlv handler

Theodore Ts'o (1):
      ext4: avoid running out of journal credits when appending to an inlin=
e file

Xin Long (1):
      netfilter: check for seqadj ext existence before adding it in nf_nat_=
setup_info


--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvLGcwACgkQONu9yGCS
aT4Y2xAAqAA+acH7+pEpJRTeoobZZYVx2ticzVwOI8iF6kWADlJ8Jk4ZyNufw/dR
jYmQcn6SMHzaD7CRtajnUHIvUmj4Xnr+XU4iyp121vswalr9EXr02yL0delw7aCz
8bloTDAXOLqrKKnllS43/mDiEjN1XBPp2aHIpUqEu1o9Y5Sq3/dcuoRFm/Q5WQ9m
CMmRADhoRv5jEsHW4HfDkgRvyYTftXGfgYtSWU3B0hour++J2JWNfgIUzGma/YgK
8BXoWNvfFcXMM+cFSqJN/zMVAIrbpGztwCg0BzxUYENMJGS4BkTYNl9IFd76zVOK
1i0fMzLqqkFKNPtrK35nQtPOfP2k4qmsoKtOXK8yLv2qpynU828uPKtbjNZr+5bC
cWv62hCQhClYb9GHt8pDMhXZN5jD3nDb9+8ISgx9FLN3RJhWYqG1mWIfxhxYyx/g
AgqaFf57tEKYZA0EDW1Ltfaa+x3/cChFdHKb9epf0nGAogVlqpggplNZNtgkdi69
vPRbflmZlkTb2PzqCJDSSQGCJrm7dscnq+r+JedOkDTS5w7JcmwazaFhRTG316m+
rxjgtuRjf69TFz/lvoT+UZThldT0zHIDYATCnw4IFRqkxem6f+KRKgLbjPrrUB0q
i0SlOhRg3hqEQV9gyNkbrcxy7HTbDryYJNSWwz9+GoruyKGqZdc=
=5B7G
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
