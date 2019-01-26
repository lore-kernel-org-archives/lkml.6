Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC2AC282C8
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5D92218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548495031;
	bh=ek1Ge8tutdwLbnXPSlEEzqJZlxwQjq1YJsthk81ZFZM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ks1rUUa+bxR37zTIyITg41TK/K9gFrFwnjlYdjIXlTrvjlPCwVga6RF+bch6Ttu+8
	 NYStks9OhtImlQ5bWWrXtJ2IB9bLL8KCZZzLFLFVqLbHzqlYoi5aXT58inq0/mufze
	 JKLuC70fQgXD2QKeipjMnUY0ve6tXxMjZh6vdIuc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfAZJa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 04:30:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:41286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfAZJa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 04:30:29 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 400C1218F0;
        Sat, 26 Jan 2019 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548495027;
        bh=ek1Ge8tutdwLbnXPSlEEzqJZlxwQjq1YJsthk81ZFZM=;
        h=Date:From:To:Cc:Subject:From;
        b=yZjm0dk5QagCxaoRZ4zC8ORtTvFU1tnv1N6FhBXC72/en9T3Y+8Y190ObxqnGZLha
         mxGXU85M4ccCOU1XgRRx7vha62PvGpOaiDC5NH1Z872pnZ4ghJ5F/kf/h0tOIlQ/Dt
         HhCMJQze/34FTvESNjb9CqvzV/S8F1ik45tqcnGw=
Date:   Sat, 26 Jan 2019 10:30:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.153
Message-ID: <20190126093025.GA23578@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.153 kernel.

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

 Documentation/filesystems/proc.txt          |    4 ++-
 Makefile                                    |    2 -
 arch/arm64/kernel/perf_event.c              |    1=20
 arch/mips/Kconfig                           |    3 ++
 arch/mips/sibyte/common/Makefile            |    1=20
 arch/mips/sibyte/common/dma.c               |   14 +++++++++++
 arch/powerpc/xmon/xmon.c                    |   18 +++++++++++---
 drivers/base/bus.c                          |    7 ++++-
 drivers/char/ipmi/ipmi_ssif.c               |   25 +++++++++++++-------
 drivers/clk/imx/clk-imx6q.c                 |    6 ++++
 drivers/cpuidle/cpuidle-pseries.c           |    8 +++++-
 drivers/infiniband/sw/rxe/rxe_req.c         |    1=20
 drivers/md/dm-kcopyd.c                      |   19 +++++++++++----
 drivers/md/dm-snap.c                        |   22 +++++++++++++++++
 drivers/media/firewire/firedtv-avc.c        |    6 +++-
 drivers/media/firewire/firedtv.h            |    6 +++-
 drivers/mmc/host/atmel-mci.c                |    3 +-
 drivers/net/ethernet/intel/e1000e/ptp.c     |   13 ++++++++--
 drivers/net/ethernet/realtek/r8169.c        |    2 +
 drivers/platform/x86/asus-wmi.c             |    3 +-
 drivers/scsi/megaraid/megaraid_sas_fp.c     |    2 -
 drivers/scsi/megaraid/megaraid_sas_fusion.c |    2 -
 drivers/scsi/smartpqi/smartpqi_init.c       |    3 ++
 drivers/target/target_core_spc.c            |   17 +++++++++----
 drivers/tty/serial/amba-pl011.c             |    2 +
 drivers/tty/serial/pic32_uart.c             |    1=20
 drivers/tty/serial/serial_core.c            |   22 ++++++++++++-----
 drivers/tty/serial/xilinx_uartps.c          |    1=20
 fs/jffs2/super.c                            |    3 +-
 fs/ocfs2/localalloc.c                       |    9 +++++--
 fs/pstore/ram_core.c                        |    5 ++++
 include/asm-generic/qspinlock_types.h       |    2 +
 include/linux/backing-dev-defs.h            |    8 ++++++
 mm/page-writeback.c                         |   35 ++++++++++++++++-------=
-----
 net/core/sock.c                             |    1=20
 net/ipv6/af_inet6.c                         |   14 ++++++++++-
 scripts/kconfig/zconf.l                     |    4 ++-
 security/selinux/hooks.c                    |    2 -
 sound/firewire/Kconfig                      |    1=20
 sound/firewire/bebob/bebob.c                |    2 -
 sound/firewire/oxfw/oxfw.c                  |    8 ++++++
 tools/lib/subcmd/Makefile                   |    2 -
 tools/perf/arch/x86/util/intel-pt.c         |   11 ++++++++
 tools/perf/util/parse-events.c              |    2 -
 tools/perf/util/svghelper.c                 |    2 -
 45 files changed, 255 insertions(+), 70 deletions(-)

Adrian Hunter (1):
      perf intel-pt: Fix error with config term "pt=3D0"

Anders Roxell (3):
      writeback: don't decrement wb->refcnt if !wb->bdi
      serial: set suppress_bind_attrs flag only if builtin
      arm64: perf: set suppress_bind_attrs flag to true

Arnaldo Carvalho de Melo (3):
      perf svghelper: Fix unchecked usage of strncpy()
      perf parse-events: Fix unchecked usage of strncpy()
      tools lib subcmd: Don't add the kernel sources to the include path

Breno Leitao (2):
      powerpc/xmon: Fix invocation inside lock region
      powerpc/pseries/cpuidle: Fix preempt warning

Brian Foster (1):
      mm/page-writeback.c: don't break integrity writeback on ->writepage()=
 error

Chuck Lever (1):
      rxe: IB_WR_REG_MR does not capture MR's iova field

Corey Minyard (1):
      ipmi:ssif: Fix handling of multi-part return messages

Daniel Santos (1):
      jffs2: Fix use of uninitialized delayed_work, lockdep breakage

Daniel Vetter (1):
      sysfs: Disable lockdep for driver bind/unbind files

Dave Airlie (1):
      locking/qspinlock: Pull in asm/byteorder.h to ensure correct endianne=
ss

David Ahern (2):
      ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped a=
ddress
      ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses

David Disseldorp (1):
      scsi: target: use consistent left-aligned ASCII INQUIRY data

Greg Kroah-Hartman (1):
      Linux 4.9.153

Joel Fernandes (Google) (1):
      pstore/ram: Do not treat empty buffers as valid

Jonas Danielsson (1):
      mmc: atmel-mci: do not assume idle after atmci_request_end

Jo=E3o Paulo Rechi Vita (1):
      platform/x86: asus-wmi: Tell the EC the OS will handle the display of=
f hotkey

Junxiao Bi (1):
      ocfs2: fix panic due to unrecovered local alloc

Kai-Heng Feng (1):
      r8169: Add support for new Realtek Ethernet

Kevin Barnett (1):
      scsi: smartpqi: correct lun reset issues

Lucas Stach (1):
      clk: imx6q: reset exclusive gates on init

Maciej W. Rozycki (1):
      MIPS: SiByte: Enable swiotlb for SWARM, LittleSur and BigSur

Masahiro Yamada (2):
      kconfig: fix file name and line number of warn_ignored_character()
      kconfig: fix memory leak when EOF is encountered in quotation

Michal Hocko (1):
      mm, proc: be more verbose about unstable VMA flags in /proc/<pid>/sma=
ps

Miroslav Lichvar (1):
      e1000e: allow non-monotonic SYSTIM readings

Nathan Chancellor (1):
      media: firewire: Fix app_info parameter type in avc_ca{,_app}_info

Nikos Tsironis (2):
      dm kcopyd: Fix bug causing workqueue stalls
      dm snapshot: Fix excessive memory usage and workqueue stalls

Ondrej Mosnacek (1):
      selinux: always allow mounting submounts

Qian Cai (1):
      scsi: megaraid: fix out-of-bound array accesses

Sergey Senozhatsky (1):
      tty/serial: do not free trasnmit buffer page under port lock

Takashi Sakamoto (2):
      ALSA: oxfw: add support for APOGEE duet FireWire
      ALSA: bebob: fix model-id of unit for Apogee Ensemble

yupeng (1):
      net: call sk_dst_reset when set SO_DONTROUTE


--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxMKLEACgkQONu9yGCS
aT4sTw//dcHlQAKHnGXQ9OLq83mERkBDUabz99bhpmCbaNw3ebCPVVIbuo5jkcSh
8sKTXaMmSTD6mg1KzB+e1CLg4bux8Uic/5TGP1+TcACwWnR/89cnQA29TWtpxisp
gTUdxDOkgqw1C7yQw/zvu44GimKPgEgs/zhOqj3JKJT4nMzkJsuZnOdJx1yOGb8H
QLlVJiyvQ9rmZccwcIeWwTIDVRdxcMUE2/5RpmcAEMZBNCSid/31TrZwqssUEKpY
hef309OTzVv0g6Nr5Csj2YyoCDlXybtCGNgUSENFh7yPoxFq0Yd6k5pYLjGMdUMh
l6FICyhbbZUz0gQxkvwCFDLiOM+60MU2BBVZrOcjDDLaRxo5NbwMBvxt4+Y6LpmG
HhFUwCJs47h/Hy0yo8+6trUbzHagcgUYBcFPPov8Ti0uLbnjav4kdj9VUMUJ1i3x
7qvc6bEeCVSVtvClnOxIIXyiqHhvkm1eDgwLLH5yoyJl0sZMtpM3Ku4alRzEamwL
U6LoQ+ldtAHl+MsShutuipEekCPqBp+1YoZkwSjEjZEEFLJ8E9aGSQwkBiGWTg6X
sO29rDu9sBqXlzvg7kQmcmaJb37v93T49pta4QuKLQmJjDt9kZUYWpPBlTdH8gwW
c9Y3Z3p+LiuqJl+UiaM4wCv6T7BbWVWOMjze4bnrDSXCqCFDMLY=
=R5Vi
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
