Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC3DC43444
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFDC2176F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546088901;
	bh=1PigwbfSTdth2GT/B5SO5Sggm1hJX/gNXXVW7voJvkA=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FWVfQ4LpnNd2p4J/0FTlPJQSJAp8FLDgxuZnzTocj/rUu1Kotcr5vgWDfNCPzkAhM
	 RaugZPeuMy38LskSiBuh4811c7s/tutb4hW2Gdjk1P2h05WnReVTKglyJtZqdLKx3q
	 Zow6nXwuMRl85rjOxp0UCkB9PcQyNXDYHKpK4/TM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeL2NIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbeL2NIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:08:20 -0500
Received: from localhost (83-68-17-109.ip.xs4all.nl [83.68.17.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 057FE20873;
        Sat, 29 Dec 2018 13:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546088899;
        bh=1PigwbfSTdth2GT/B5SO5Sggm1hJX/gNXXVW7voJvkA=;
        h=Date:From:To:Cc:Subject:From;
        b=ciB0nxKpf3WQz765S/FoMykCae/ywynVTmSkleXr9p3ogDuylzem5i8FvqzGrmKYK
         mYIETkurALeSopnWhaHs+rrn5iR+lk0hi23L6US+YD4qs/cfcdKGfuHaAsxM3ptR57
         FYieBPEe9qplx/gec7/1XLekMkB6euwSs9ZQ6Ff0=
Date:   Sat, 29 Dec 2018 14:08:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.14.91
Message-ID: <20181229130814.GA15220@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.14.91 kernel.

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

 Makefile                                      |    2=20
 arch/x86/include/asm/msr-index.h              |    1=20
 arch/x86/kernel/cpu/mtrr/if.c                 |    2=20
 arch/x86/kvm/vmx.c                            |    2=20
 arch/x86/kvm/x86.c                            |    2=20
 block/blk-lib.c                               |   22 +++
 drivers/gpio/gpio-max7301.c                   |   12 --
 drivers/gpio/gpiolib-acpi.c                   |  144 +++++++++++++++------=
-----
 drivers/gpu/drm/drm_ioctl.c                   |   10 +
 drivers/hv/vmbus_drv.c                        |   20 +++
 drivers/infiniband/ulp/srpt/ib_srpt.c         |    4=20
 drivers/mmc/core/mmc.c                        |   24 ++--
 drivers/mmc/host/omap_hsmmc.c                 |   12 +-
 drivers/net/usb/hso.c                         |   18 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |    9 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   50 +++++++++
 drivers/scsi/sd.c                             |   23 +++-
 drivers/spi/spi-imx.c                         |   91 ++++++++++++----
 drivers/usb/host/xhci-hub.c                   |    3=20
 drivers/usb/host/xhci.h                       |    4=20
 drivers/usb/serial/option.c                   |   16 ++
 fs/cifs/smb2pdu.c                             |    4=20
 fs/proc/proc_sysctl.c                         |   13 +-
 fs/ubifs/dir.c                                |    5=20
 fs/ubifs/replay.c                             |   37 ++++++
 include/linux/math64.h                        |    3=20
 kernel/panic.c                                |    6 -
 kernel/time/posix-timers.c                    |    5=20
 mm/vmscan.c                                   |    6 -
 sound/soc/codecs/sta32x.c                     |    3=20
 tools/perf/builtin-record.c                   |   18 +--
 31 files changed, 429 insertions(+), 142 deletions(-)

Bart Van Assche (1):
      ib_srpt: Fix a use-after-free in __srpt_close_all_ch()

Cfir Cohen (1):
      KVM: Fix UAF in nested posted interrupt processing

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Colin Ian King (1):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Dan Carpenter (1):
      cifs: integer overflow in in SMB2_ioctl()

Daniel Mack (1):
      ASoC: sta32x: set ->component pointer in private struct

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Eduardo Habkost (1):
      kvm: x86: Add AMD's EX_CFG to the list of ignored MSRs

Emmanuel Grumbach (1):
      iwlwifi: mvm: don't send GEO_TX_POWER_LIMIT to old firmwares

Greg Kroah-Hartman (1):
      Linux 4.14.91

Gustavo A. R. Silva (1):
      drm/ioctl: Fix Spectre v1 vulnerabilities

Hans de Goede (1):
      gpiolib-acpi: Only defer request_irq for GpioInt ACPI event handlers

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data

Ihab Zhaika (1):
      iwlwifi: add new cards for 9560, 9462, 9461 and killer series

Ivan Delalande (1):
      proc/sysctl: don't return ENOMEM on lookup when a table is unregister=
ing

Jens Axboe (2):
      block: break discard submissions into the user defined size
      scsi: sd: use mempool for discard special page

Jiri Olsa (1):
      perf record: Synthesize features before events in pipe mode

J=F6rgen Storvist (4):
      USB: serial: option: add GosunCn ZTE WeLink ME3630
      USB: serial: option: add Simcom SIM7500/SIM7600 (MBIM mode)
      USB: serial: option: add Fibocom NL668 series
      USB: serial: option: add Telit LN940 series

Mathias Nyman (1):
      xhci: Don't prevent USB2 bus suspend in state check intended for USB3=
 only

Mikulas Patocka (1):
      block: fix infinite loop if the device loses discard capability

Nicolas Saenz Julienne (1):
      USB: xhci: fix 'broken_suspend' placement in struct xchi_hcd

Richard Weinberger (2):
      ubifs: Fix directory size calculation for symlinks
      ubifs: Handle re-linking of inodes correctly while recovery

Roman Gushchin (1):
      mm: don't miss the last page because of round-off error

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Sergey Senozhatsky (1):
      panic: avoid deadlocks in re-entrant console drivers

Thomas Gleixner (1):
      posix-timers: Fix division by zero bug

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Ulf Hansson (3):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs
      mmc: core: Allow BKOPS and CACHE ctrl even if no HPI support
      mmc: core: Use a minimum 1600ms timeout when enabling CACHE ctrl

Uwe Kleine-K=F6nig (2):
      spi: imx: add a device specific prepare_message callback
      spi: imx: mx51-ecspi: Move some initialisation to prepare_message hoo=
k.


--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwncb4ACgkQONu9yGCS
aT7TPQ/+IbDxt6YRUm3YNhFZQFdBvW5WgS+PngGJOuEELVSP3yViHdKvvYqu9CjX
qrowGffpYPqiNIv43hjgwB0zaZ4kM1GyleI67w+H49ERGo1//y4MXXho1PDipsBy
U8T5ivH4WSG2S6GBeBtew1O1djLDFg3qfUOZ7pPXrw86bm8Ik3lfIHKhonCscdoB
3G3ybhbVKpkvjqHvZtjnGvV+ebpcYM5yXkC/elL5H3LyTjrvFNGNW4MG93r/6m/T
k0MfNHvwV/yknRZQjYGQWt9bKK+wRmUSg94GK58Tt0XU4UUpup98CyKY3S3BorMH
xjMw2FQGQSWQjXfclQ5OMYdbhWWgXUoyEjIyQwoRvN2XYRd2es3ctvt0qFXG1fco
4tG1fT6jtTxe69XZMNbVtMl/LQLYAAisb961Mx25GJ9jD1jnuGyIW8Ut5FnyjhEZ
VAhd2ycvoSMVZeMeJEnAwY6mTlI8rSyv3ZE6fab5yQg4OpIw/VAjZiUdeIGecMOa
jOL5TbY9+MYJmWgM1eksTx4U6YplfvS4ub/I14C1C0b5Vr9eq5hLPcaEKnmgvP0Q
/v+52Fc6aglBGF1os91mHNkcgm2ZysXkBjXvMfbJoQJYSdxOf2rtJESne2JK5fUD
cD/JW6xMA9INjp29Bs/hnvABD2BzqO+3jCIuOoiuyP6Ofs3fFTo=
=aMwL
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
