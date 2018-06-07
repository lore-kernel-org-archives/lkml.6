Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ycWQNTD5GFuxZQAAmS7hNA
	; Thu, 07 Jun 2018 09:22:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1D795607E7; Thu,  7 Jun 2018 09:22:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yOFh8Ci/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6530460115;
	Thu,  7 Jun 2018 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6530460115
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932918AbeFGJWu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:22:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932861AbeFGJWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:22:36 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CB3220874;
        Thu,  7 Jun 2018 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528363355;
        bh=VFrLAjhpOwGnR4D4WdO1x++lrf/E+fB9384Y/24v3eo=;
        h=Date:From:To:Cc:Subject:From;
        b=yOFh8Ci/Ako3G6KcZjRxAwMwQ7JZdB4jtqe7MMhjajxOCpbBJg7NMAgNy9bWEXgj7
         stHSsVb+x7jvci+pBR+BgxzdB/GuITEw8XzmzhEprJpZ8fRVCrZHyilJntz7fXFLlg
         bHPaEbD+YehFfDh6pl4k84KpAx7ymsozRbdTO3w8=
Date: Thu, 7 Jun 2018 11:22:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.136
Message-ID: <20180607092211.GA21301@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.136 kernel.

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

 Makefile                                            |    2=20
 arch/arm64/include/asm/atomic_lse.h                 |   14 -
 arch/mips/kernel/process.c                          |    4=20
 arch/mips/kernel/ptrace.c                           |    2=20
 arch/mips/kernel/ptrace32.c                         |    2=20
 arch/powerpc/kernel/cpu_setup_power.S               |    4=20
 arch/sh/kernel/sh_ksyms_32.c                        |    3=20
 arch/sh/lib/ashlsi3.S                               |   35 ++-
 arch/sh/lib/ashrsi3.S                               |   33 ++-
 arch/sh/lib/lshrsi3.S                               |   34 ++-
 arch/sparc/kernel/ds.c                              |    2=20
 drivers/dma/sh/usb-dmac.c                           |    4=20
 drivers/gpu/drm/i915/intel_lvds.c                   |    8=20
 drivers/hwtracing/stm/core.c                        |    7=20
 drivers/i2c/busses/i2c-rcar.c                       |  202 ++++++++-------=
-----
 drivers/iio/buffer/kfifo_buf.c                      |    7=20
 drivers/input/mouse/elan_i2c_smbus.c                |   22 +-
 drivers/net/irda/w83977af_ir.c                      |    4=20
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rf.c |    3=20
 drivers/scsi/scsi_transport_srp.c                   |   22 +-
 drivers/usb/serial/cp210x.c                         |    9=20
 fs/aio.c                                            |    3=20
 fs/xfs/libxfs/xfs_alloc.c                           |   94 +++++++++
 fs/xfs/xfs_mount.h                                  |    1=20
 fs/xfs/xfs_trace.h                                  |    9=20
 include/linux/tcp.h                                 |    2=20
 include/uapi/linux/nl80211.h                        |    2=20
 init/Kconfig                                        |   13 +
 kernel/trace/trace_events_trigger.c                 |    5=20
 mm/vmscan.c                                         |    2=20
 net/ipv4/tcp_input.c                                |   10=20
 security/integrity/ima/ima_appraise.c               |    8=20
 security/selinux/ss/services.c                      |    2=20
 sound/soc/intel/common/sst-firmware.c               |    2=20
 34 files changed, 373 insertions(+), 203 deletions(-)

Al Viro (1):
      fix io_destroy()/aio_complete() race

Alexander Shishkin (1):
      stm class: Use vmalloc for the master map

Arnd Bergmann (2):
      irda: fix overly long udelay()
      Kbuild: change CC_OPTIMIZE_FOR_SIZE definition

Bart Van Assche (1):
      scsi: scsi_transport_srp: Fix shost to rport translation

Benjamin Tissoires (1):
      Input: elan_i2c_smbus - fix corrupted stack

Brian Foster (1):
      xfs: detect agfl count corruption and reset agfl

Colin Ian King (1):
      ASoC: Intel: sst: remove redundant variable dma_dev_name

David S. Miller (1):
      sparc64: Fix build warnings with gcc 7.

Eric Biggers (1):
      cfg80211: further limit wiphy names to 64 bytes

Eric Dumazet (1):
      tcp: avoid integer overflows in tcp_rcv_space_adjust()

Geert Uytterhoeven (1):
      USB: serial: cp210x: use tcflag_t to fix incompatible pointer type

Greg Kroah-Hartman (2):
      hwtracing: stm: fix build error on some arches
      Linux 4.4.136

Hugh Dickins (1):
      mm: fix the NULL mapping case in __isolate_lru_page()

Maciej W. Rozycki (2):
      MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
      MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE requests

Martin Kelly (1):
      iio:kfifo_buf: check for uint overflow

Matthias Kaehlcke (1):
      rtlwifi: rtl8192cu: Remove variable self-assignment in rf.c

Michael Neuling (1):
      powerpc/64s: Clear PCR on boot

Mimi Zohar (1):
      Revert "ima: limit file hash setting by user to fix and log modes"

Ondrej Zary (1):
      drm/i915: Disable LVDS on Radiant P845

Sachin Grover (1):
      selinux: KASAN: slab-out-of-bounds in xattr_getsecurity

Steven Rostedt (VMware) (1):
      tracing: Fix crash when freeing instances with event triggers

Will Deacon (1):
      arm64: lse: Add early clobbers to some input/output asm operands

Wolfram Sang (9):
      i2c: rcar: make sure clocks are on when doing clock calculation
      i2c: rcar: rework hw init
      i2c: rcar: remove unused IOERROR state
      i2c: rcar: remove spinlock
      i2c: rcar: refactor setup of a msg
      i2c: rcar: init new messages in irq
      i2c: rcar: don't issue stop when HW does it automatically
      i2c: rcar: check master irqs before slave irqs
      i2c: rcar: revoke START request early

Yoshihiro Shimoda (1):
      dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()

Yoshinori Sato (1):
      sh: New gcc support


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlsY+UIACgkQONu9yGCS
aT4bYBAAhutx3wioZjRbdjBYKT5WCy1d2Tek/uLynggy7rtHjNdPa4oF8ps6NiDP
/RSPnL4+JtS7U3xcj417Ltf9U7purtntHq6teTUZRJl6cgejg0NbluWbu7x1bck8
lAdghVyek93ogN1mXF6jAbZZ1S4ypsuq/DTi7aRFbwvDFzq7qZfrPRVSOj9Oe6n6
hYAeeAwbw8oGK/KbLtNmy2+BWQyYIXX+EseltdAnttVC3D7MWlGcPAv2FYPYsbBF
ny4b/48FQyGH+4nuQkcfMGn/YB07kZ6buW+9KxAZpyS19iZQH0PMLG9mshga6zDF
Mpp4CuUnpqTi8IqeF3YYxHqgJNoLopHBY3/daRHlQzJ5p/uEra8qDQh/nAPxaL9Y
v8IifOUfxg+mF9QfWpu0sDqgxz4u5dUCD/LJFfyYdQcpLOAtTYdmTUpa0ReC7fDL
TgRwnIBNkbA5fByaTJhMJoHGTzdj0rXShbMVfP5PcM0ySIz2CtiP61V7pHjKCy1p
z3/316FQ/BmBhYvFRw+vtQp7HSdX2y7syOeZwlT9g0JWMfgtwaA7/LnqTxEwByoI
hP0L4lQOciGvS2X5isJG7apgTqo7Uyn8MPoXmSS3jTkhRzZCT6rusmvT7Al+w03H
I01RK5r2OnRr4pLPcwmYcZQQmqJyAYkhWG3/m0pcdU6MzjBHyic=
=q3OG
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
