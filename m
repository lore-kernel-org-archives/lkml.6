Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06027C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61CF20858
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 16:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCxEbUdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61CF20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbeKKCBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 21:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbeKKCBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 21:01:52 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50E0220858;
        Sat, 10 Nov 2018 16:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541866579;
        bh=ZMW/5MHGcles9G7G+cI9neue3KNXMtmIQvHMEMd+HUY=;
        h=Date:From:To:Cc:Subject:From;
        b=bCxEbUdt56JwjynHgBDQn8BEQO9fFdhUA+ts1NWSCfOS/5ru00CeN8HgtPGPcjgqv
         cOCAXMvJYFi6dYletdAE4032nFpNqtleq/pmKNRKTFf00KIg9VGBMsCIgHTd0cICU8
         IaBxUdvifPZ7PB3XqMGTW0tBIyhmpn8mIQR3zYBQ=
Date:   Sat, 10 Nov 2018 08:16:17 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.18.18
Message-ID: <20181110161617.GA28836@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.18.18 kernel.

All users of the 4.18 kernel series must upgrade.

The updated 4.18.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.18.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                       |    2=20
 arch/x86/include/asm/fpu/internal.h            |    2=20
 arch/x86/include/asm/percpu.h                  |    8 +-
 arch/x86/kernel/pci-swiotlb.c                  |    2=20
 arch/x86/kernel/setup.c                        |    2=20
 arch/x86/kernel/time.c                         |    2=20
 arch/x86/kernel/tsc.c                          |    6 -
 drivers/clk/sunxi-ng/ccu-sun4i-a10.c           |   10 ++
 drivers/gpio/gpio-mxs.c                        |    4 -
 drivers/gpu/drm/drm_edid.c                     |    5 +
 drivers/gpu/drm/drm_fb_helper.c                |   91 +++++++-------------=
-----
 drivers/gpu/drm/sun4i/sun4i_dotclock.c         |   12 +++
 drivers/infiniband/core/ucm.c                  |    3=20
 drivers/infiniband/core/ucma.c                 |    3=20
 drivers/input/mouse/elan_i2c_core.c            |    1=20
 drivers/misc/eeprom/at24.c                     |   17 ++++
 drivers/ptp/ptp_chardev.c                      |    4 +
 drivers/usb/class/cdc-acm.c                    |   16 ++--
 drivers/usb/core/devio.c                       |    4 -
 drivers/usb/gadget/function/f_mass_storage.c   |    3=20
 drivers/usb/host/xhci-pci.c                    |    6 +
 drivers/usb/roles/intel-xhci-usb-role-switch.c |    2=20
 drivers/usb/usbip/vhci_hcd.c                   |   57 +++++++++++----
 fs/cachefiles/namei.c                          |    2=20
 fs/fscache/cookie.c                            |   31 ++------
 fs/fscache/internal.h                          |    1=20
 fs/fscache/main.c                              |    4 -
 fs/ioctl.c                                     |    2=20
 fs/nfsd/vfs.c                                  |    3=20
 fs/overlayfs/copy_up.c                         |    2=20
 fs/read_write.c                                |   17 ++++
 include/drm/drm_edid.h                         |    6 -
 include/linux/bpf_verifier.h                   |    3=20
 include/linux/fs.h                             |   17 ----
 kernel/bpf/verifier.c                          |   10 +-
 kernel/sched/fair.c                            |   22 +++++-
 kernel/sched/sched.h                           |    2=20
 kernel/trace/trace_events_hist.c               |   32 ++++++--
 38 files changed, 243 insertions(+), 173 deletions(-)

Al Viro (1):
      cachefiles: fix the race between cachefiles_bury_object() and rmdir(2)

Alan Chiang (1):
      eeprom: at24: Add support for address-width property

Alan Stern (1):
      USB: fix the usbfs flag sanitization for control transfers

Amir Goldstein (1):
      vfs: swap names of {do,vfs}_clone_file_range()

Boris Brezillon (1):
      drm/sun4i: Fix an ulong overflow in the dotclock driver

Chen-Yu Tsai (1):
      clk: sunxi-ng: sun4i: Set VCO and PLL bias current to lowest setting

Christoph Hellwig (1):
      x86/swiotlb: Enable swiotlb for > 4GiG RAM on 32-bit kernels

Clint Taylor (1):
      drm/edid: VSDB yCBCr420 Deep Color mode bit definitions

Daniel Borkmann (1):
      bpf: fix partial copy of map_ptr when dst is scalar

David Howells (1):
      fscache: Fix incomplete initialisation of inline key space

Eric Sandeen (1):
      fscache: Fix out of bound read in long cookie keys

Eugeniy Paltsev (1):
      drm: fb-helper: Reject all pixel format changing requests

Greg Kroah-Hartman (1):
      Linux 4.18.18

Gustavo A. R. Silva (4):
      ptp: fix Spectre v1 vulnerability
      RDMA/ucma: Fix Spectre v1 vulnerability
      IB/ucm: Fix Spectre v1 vulnerability
      usb: gadget: storage: Fix Spectre v1 vulnerability

Heikki Krogerus (1):
      usb: xhci: pci: Enable Intel USB role mux on Apollo Lake platforms

Kai-Heng Feng (1):
      drm/edid: Add 6 bpc quirk for BOE panel in HP Pavilion 15-n233sl

Linus Walleij (1):
      gpio: mxs: Get rid of external API call

Masami Hiramatsu (2):
      tracing: Fix synthetic event to accept unsigned modifier
      tracing: Fix synthetic event to allow semicolon at end

Mikhail Nikiforov (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15IGM

Nathan Chancellor (1):
      x86/time: Correct the attribute on jiffies' definition

Oliver Neukum (1):
      cdc-acm: fix race between reset and control messaging

Peter Zijlstra (2):
      x86/tsc: Force inlining of cyc2ns bits
      x86/percpu: Fix this_cpu_read()

Phil Auld (1):
      sched/fair: Fix throttle_list starvation with low CFS quota

Sebastian Andrzej Siewior (1):
      x86/fpu: Fix i486 + no387 boot crash by only saving FPU registers on =
context switch if there is an FPU

Shuah Khan (Samsung OSG) (1):
      usb: usbip: Fix BUG: KASAN: slab-out-of-bounds in vhci_hub_control()

Tobias Herzog (2):
      cdc-acm: do not reset notification buffer index upon urb unlinking
      cdc-acm: correct counting of UART states in serial state notification

Wan Ahmad Zainie (1):
      usb: roles: intel_xhci: Fix Unbalanced pm_runtime_enable

Zhimin Gu (1):
      x86, hibernate: Fix nosave_regions setup for hibernation


--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvnBFEACgkQONu9yGCS
aT58xw/+IgoBXD5MgkkpwaPy7nGsjJJ9+eCv/4fj5a43X0KEg1Weilu4KJGpDKvp
swNGM9yRjIJnboIt0E/yJMXCG7qpoKJryb3RTCs93A1hJJ+MINrpaWS+OCoUeBjT
/7CW4aimuEtgLCKBxps6avenD+N7A961qZ0/2M4It8HVqEynmkdnlKjbIOOxKMyi
MLvdnU6YtM+P6TXF4qveWQDzJB4qC8jSE0L/SLuugct/DvKuSI1bGojpJ5Ddouwb
mAE/lth98bD6lzNDIXAF0FNcN4V8pEiU9P8psUyTiB/+PgZNIZTn5KyU/2Fw6yEJ
7P7AjDx4DCvlgJFuDy0oudvwLl5ql6J9s5RjdHP3VQlvvAWyWGb/cabXnEPdX0cK
fqr+YUReAG27BWRPZvsSUDOWvb/G8egSOas/GT6rxGELPN5gI2zttGbnxvZ43r12
bU9FMI8dXNJrJ8h6inTxu0Pt6/JE+DRMA7k8xhhCGoYe+Z4h3qM2Dj5/w4xf+Un/
5e8ssn37X2HVHvfmYUBcuQKJcI5O4L3Zmtr1ufJ8tGTXf20fQzn1Aio1HRI+/pk7
tkQTq644I/Rfie8wCSFabifq6vJMeuOlBukBYxkn9EUAWKxAt7B2QdqXENSGS5B0
JmH9Eiuwx+d1rqk2c0W2RNEWCXdep0XfLwbBUmAow6l/sXJzOWU=
=mhq2
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
