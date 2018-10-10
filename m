Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A00AC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D4220645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lunRJSLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D4220645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbeJJQdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbeJJQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:33:47 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFED220645;
        Wed, 10 Oct 2018 09:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539162752;
        bh=2iFFTi8w4FAvpYtVBjdP/87VxIi8KSGs8jDDIq8ib6w=;
        h=Date:From:To:Cc:Subject:From;
        b=lunRJSLnHfdUB79kXFoGcRdybyG/IUuED1TDgAgHZq6JO7HfNFmWgVv320WW3Mt3v
         65EN+3uuJCxQhgbJsiG0rgbR637IroitdHykhwUKqki6Kzu2ZWyjOvyJY6SUjh3Soq
         pyJWDrDTE2CBHHhdoxwmoBUBsP5vPKhleV4bTgMI=
Date:   Wed, 10 Oct 2018 11:12:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.132
Message-ID: <20181010091229.GA2654@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.132 kernel.

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

 Makefile                                            |    2=20
 arch/arc/include/asm/atomic.h                       |    2=20
 arch/arm64/include/asm/jump_label.h                 |    4 -
 arch/hexagon/include/asm/bitops.h                   |    4 -
 arch/hexagon/kernel/dma.c                           |    2=20
 arch/powerpc/kvm/book3s_64_mmu_hv.c                 |    2=20
 arch/x86/events/intel/lbr.c                         |    4 +
 drivers/crypto/mxs-dcp.c                            |   53 ++++++++------
 drivers/crypto/qat/qat_c3xxx/adf_drv.c              |    6 -
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c            |    6 -
 drivers/crypto/qat/qat_c62x/adf_drv.c               |    6 -
 drivers/crypto/qat/qat_c62xvf/adf_drv.c             |    6 -
 drivers/crypto/qat/qat_dh895xcc/adf_drv.c           |    6 -
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c         |    6 -
 drivers/gpio/gpio-adp5588.c                         |   24 +++++-
 drivers/gpio/gpiolib-of.c                           |    1=20
 drivers/gpio/gpiolib.c                              |    2=20
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/gm200.c |    3=20
 drivers/hid/hid-apple.c                             |    9 ++
 drivers/hid/hid-ids.h                               |    3=20
 drivers/hid/hid-saitek.c                            |    2=20
 drivers/i2c/busses/i2c-uniphier-f.c                 |    7 -
 drivers/i2c/busses/i2c-uniphier.c                   |    7 -
 drivers/infiniband/core/ucma.c                      |    6 +
 drivers/md/dm-raid.c                                |    5 +
 drivers/md/dm-thin-metadata.c                       |   34 +++++++++
 drivers/md/dm-thin.c                                |   73 +++++++++++++++=
++---
 drivers/md/raid10.c                                 |    5 +
 drivers/net/ethernet/amazon/ena/ena_netdev.c        |   10 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.h        |   11 +++
 drivers/net/ethernet/cadence/macb.c                 |    2=20
 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c    |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/dev.c       |    7 +
 drivers/net/ethernet/realtek/r8169.c                |    9 +-
 drivers/net/wireless/mac80211_hwsim.c               |    3=20
 drivers/nvme/target/rdma.c                          |   27 ++++++-
 drivers/s390/net/qeth_core_main.c                   |    5 -
 drivers/s390/net/qeth_l2_main.c                     |    2=20
 drivers/s390/net/qeth_l3_main.c                     |    2=20
 drivers/tty/serial/mvebu-uart.c                     |    4 -
 drivers/usb/gadget/udc/fotg210-udc.c                |   15 ++--
 drivers/usb/misc/yurex.c                            |    3=20
 drivers/xen/cpu_hotplug.c                           |   15 ++--
 drivers/xen/events/events_base.c                    |    2=20
 drivers/xen/manage.c                                |    6 +
 fs/cifs/cifs_unicode.c                              |    3=20
 fs/cifs/cifssmb.c                                   |   11 ++-
 fs/cifs/misc.c                                      |    8 ++
 fs/cifs/smb2ops.c                                   |    2=20
 fs/ocfs2/dlm/dlmmaster.c                            |    4 -
 fs/proc/base.c                                      |   14 +++
 fs/xattr.c                                          |   24 +++---
 include/linux/jiffies.h                             |    2=20
 kernel/time/time.c                                  |   10 ++
 kernel/time/timeconst.bc                            |    6 +
 mm/madvise.c                                        |    2=20
 net/mac80211/ibss.c                                 |   22 +++---
 net/mac80211/main.c                                 |   28 ++++++-
 net/mac80211/mesh_hwmp.c                            |    4 +
 net/mac80211/mlme.c                                 |   70 +++++++++++++++=
+++-
 net/wireless/nl80211.c                              |    1=20
 net/wireless/util.c                                 |    2=20
 sound/pci/hda/patch_realtek.c                       |    1=20
 tools/perf/arch/powerpc/util/sym-handling.c         |    4 -
 tools/perf/util/evsel.c                             |    5 -
 tools/vm/page-types.c                               |    6 -
 tools/vm/slabinfo.c                                 |    4 -
 67 files changed, 483 insertions(+), 165 deletions(-)

Andreas Gruenbacher (1):
      sysfs: Do not return POSIX ACL xattrs via listxattr

Anton Vasilyev (1):
      usb: gadget: fotg210-udc: Fix memory leak of fotg210->ep[i]

Arunk Khandavalli (1):
      cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Ashish Samant (1):
      ocfs2: fix locking for res->tracking and dlm->tracking_list

Aurelien Aptel (1):
      smb2: fix missing files in root share directory listing

Ben Hutchings (1):
      USB: yurex: Check for truncation in yurex_read()

Ben Skeggs (1):
      drm/nouveau/TBDdevinit: don't fail when PMU/PRE_OS is missing from VB=
IOS

Dan Carpenter (2):
      cfg80211: fix a type issue in ieee80211_chandef_to_operating_class()
      cifs: read overflow in is_valid_oplock_break()

Danek Duvall (2):
      mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X
      mac80211_hwsim: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Daniel Black (1):
      mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Daniel Jurgens (1):
      net/mlx5: Consider PCI domain in search for next dev

Emmanuel Grumbach (3):
      mac80211: fix a race between restart and CSA flows
      mac80211: don't Tx a deauth frame if the AP forbade Tx
      mac80211: shorten the IBSS debug messages

Frederic Weisbecker (1):
      time: Introduce jiffies64_to_nsecs()

Greg Kroah-Hartman (1):
      Linux 4.9.132

Harry Mallon (1):
      HID: hid-saitek: Add device ID for RAT 7 Contagion

Heinz Mauelshagen (1):
      dm raid: fix rebuild of specific devices by updating superblock

Hisao Tanabe (1):
      perf evsel: Fix potential null pointer dereference in perf_evsel__new=
_idx()

Ilan Peer (1):
      mac80211: Fix station bandwidth setting after channel switch

Jacek Tomaka (1):
      perf/x86/intel: Add support/quirk for the MISPREDICT bit on Knights L=
anding CPUs

Jan Kiszka (1):
      serial: mvebu-uart: Fix reporting of effective CSIZE to userspace

Jann Horn (2):
      RDMA/ucma: check fd type in ucma_migrate_id()
      proc: restrict kernel stack dumps to root

Jia-Ju Bai (1):
      net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Joe Thornber (1):
      dm thin metadata: try to avoid ever aborting transactions

Jon Kuhn (1):
      fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Josh Abraham (1):
      xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Julian Wiedmann (1):
      s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng (2):
      r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENAB=
LED
      ALSA: hda/realtek - Cannot adjust speaker's volume on Dell XPS 27 7760

Leonard Crestez (1):
      crypto: mxs-dcp - Fix wait logic on chan threads

Masahiro Yamada (2):
      i2c: uniphier: issue STOP only for last message or I2C_M_STOP
      i2c: uniphier-f: issue STOP only for last message or I2C_M_STOP

Michael Hennerich (1):
      gpio: adp5588: Fix sleep-in-atomic-context bug

Miguel Ojeda (1):
      arm64: jump_label.h: use asm_volatile_goto macro instead of "asm goto"

Mike Snitzer (1):
      dm thin metadata: fix __udivdi3 undefined on 32-bit

Naoya Horiguchi (2):
      tools/vm/slabinfo.c: fix sign-compare warning
      tools/vm/page-types.c: fix "defined but not used" warning

Netanel Belgazal (1):
      net: ena: fix driver when PAGE_SIZE =3D=3D 64kB

Olaf Hering (1):
      xen: avoid crash in disable_hotplug_cpu

Paul Mackerras (1):
      KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Peng Li (1):
      net: hns: add netif_carrier_off before change speed and duplex

Randy Dunlap (2):
      arch/hexagon: fix kernel/dma.c build warning
      hexagon: modify ffs() and fls() to return int

Ricardo Ribalda Delgado (1):
      gpiolib: Free the last requested descriptor

Sagi Grimberg (1):
      nvmet-rdma: fix possible bogus dereference under heavy load

Sandipan Das (1):
      perf probe powerpc: Ignore SyS symbols irrespective of endianness

Sean O'Brien (1):
      HID: add support for Apple Magic Keyboards

Stephen Rothwell (1):
      fs/cifs: suppress a string overflow warning

Toke H=F8iland-J=F8rgensen (1):
      mac80211: Run TXQ teardown code before de-registering interfaces

Vincent Whitchurch (1):
      gpio: Fix crash due to registration race

Vitaly Kuznetsov (1):
      xen/manage: don't complain about an empty value in control/sysrq node

Waiman Long (1):
      crypto: qat - Fix KASAN stack-out-of-bounds bug in adf_probe()

Wenjia Zhang (1):
      s390/qeth: use vzalloc for QUERY OAT buffer

Will Deacon (1):
      ARC: atomics: unbork atomic_fetch_##op()

Xiao Ni (1):
      RAID10 BUG_ON in raise_barrier when force is true and conf->barrier i=
s 0

Yuan-Chi Pang (1):
      mac80211: mesh: fix HWMP sequence numbering to follow standard


--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlu9wn0ACgkQONu9yGCS
aT453w//bjq5/TcuNdmQxriPfiGt2USlnqL6k5gV+qGBfeVp7sEQ3G9dL2x8J2kj
eOzHFhmylQuHQThQbJLjxK+LD4LBPc6GkT19bCKDVQ5cbXJqato6sZuplGUgfBD5
7SHCJgOlpjmR7Z5qLV6BKCV1Dv7tne3GEvjtMRljKo5kFOf19JgsbIGZ1rWfgKYd
iR47uMf9kMgPb/BSJIM5k4qvRCZkO4IBprTlwK5ZROjnYuL9ifNp1skGtTior/Le
sSUaNOucyh2J0wC0iD6ABmiOHcbgu01OecdmgMKx6dmDpvVfQe4+JX/cS6UFQ2L5
oH1M30ByIfSHMlPpHAIMZowKVhKpUhjTyGntpjjLM6+oMTOtiGR9SRnzbKmR6lVZ
ycF4kda3BLUzwjTTBUsPYgjvTlnOCfTdjpX/pwVcHmGM2lTAGRkRfpb4if3OViV8
6Xl8gTPcz5VWSCN/TT4ZsLoD33UX8/DVEgqO56DXZMVCgLw5NxvRaKyQuVV+3zv1
vpGUOdm1gywY8OBjoZg0unHJZ/Dex+f55bUe4v7kxNzph8oTT+hqJdN8AY9NkSy3
p+m+My6KzGyFIWTMa44bPna0nqorMSHZLP3ToAQL6PyUpArWq20J4R4G4MpFdA+r
B4dBS/mE/V0QlV65u9inUNf9E+aavkaRoxkFvXfli1oGqPmJ4J4=
=4wUk
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--
