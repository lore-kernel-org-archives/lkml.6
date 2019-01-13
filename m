Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE47C43612
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3A020879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547373238;
	bh=gtL4pw7T2CImI+BC3kmGal5n50+w2P2/eV3gQR4fC5c=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NYuBovav2+6ywTM5n3gUUnOm2NdwLIggv0ftfaPllc/IvDih+Y4iAAZd+CZYCfu2/
	 Qf/5WvvsHNXuWL2kWQHMCMCCdVT4L0KTsKbD86V8DivQrFXkLr5CFbZx6TQ/32tYNH
	 gIOr6ojnQQemZi6grV1nxupLUH+lLO/fFIga+pxg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfAMJx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:53:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:48122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfAMJx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:53:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2843320873;
        Sun, 13 Jan 2019 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547373235;
        bh=gtL4pw7T2CImI+BC3kmGal5n50+w2P2/eV3gQR4fC5c=;
        h=Date:From:To:Cc:Subject:From;
        b=DEWZmvSF/oG10HJmXeXwJw9ZLI2nlA1XHlrS/yWcwwFUiFt87HuRtdd5UJsVCr9JH
         doU2BQU9N1FydpR6Np6r6hTI50R54auMhNxwosoohrK4Rt2Ss1Vm8/OsStC8qTmElW
         AkRR/Xx06i8apq0dw7qUBPTZXIFccMMvrCbCI1yg=
Date:   Sun, 13 Jan 2019 10:53:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 3.18.132
Message-ID: <20190113095352.GA16302@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 3.18.132 kernel.

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

 Makefile                                           |    2=20
 arch/mips/boot/compressed/calc_vmlinuz_load_addr.c |    7 +-
 arch/mips/include/asm/pgtable-64.h                 |    5 +
 arch/x86/include/asm/kvm_host.h                    |    2=20
 arch/x86/kernel/cpu/mtrr/if.c                      |    2=20
 drivers/gpio/gpio-max7301.c                        |   12 ---
 drivers/hv/vmbus_drv.c                             |   20 ++++++
 drivers/isdn/capi/kcapi.c                          |    4 -
 drivers/media/platform/vivid/vivid-vid-cap.c       |    2=20
 drivers/misc/genwqe/card_utils.c                   |    2=20
 drivers/mmc/core/mmc.c                             |    4 -
 drivers/mmc/host/omap_hsmmc.c                      |   12 +++
 drivers/net/ethernet/ibm/ibmveth.c                 |    6 +
 drivers/net/usb/hso.c                              |   18 +++++
 drivers/net/wireless/b43/phy_common.c              |    2=20
 drivers/net/xen-netfront.c                         |    2=20
 drivers/power/olpc_battery.c                       |    4 -
 drivers/s390/scsi/zfcp_aux.c                       |    6 -
 drivers/usb/class/cdc-acm.c                        |   10 +++
 drivers/usb/class/cdc-acm.h                        |    1=20
 drivers/usb/host/r8a66597-hcd.c                    |    5 +
 drivers/usb/serial/option.c                        |    7 +-
 drivers/usb/serial/pl2303.c                        |    5 +
 drivers/usb/serial/pl2303.h                        |    5 +
 drivers/vhost/vhost.c                              |    2=20
 fs/ceph/caps.c                                     |    1=20
 fs/cifs/smb2maperror.c                             |    4 -
 fs/dlm/lock.c                                      |   17 +++--
 fs/dlm/lockspace.c                                 |    2=20
 fs/ext4/inline.c                                   |    5 +
 fs/ext4/super.c                                    |   13 +++-
 fs/gfs2/rgrp.c                                     |    2=20
 include/net/sock.h                                 |   36 ++++++++++-
 include/trace/events/ext4.h                        |   20 ++++++
 kernel/fork.c                                      |   13 +++-
 net/9p/client.c                                    |   21 ++++++
 net/ax25/af_ax25.c                                 |   11 ++-
 net/ax25/ax25_dev.c                                |    2=20
 net/compat.c                                       |   15 ++--
 net/core/sock.c                                    |    3=20
 net/ipv6/ip6_udp_tunnel.c                          |    3=20
 net/netrom/af_netrom.c                             |   15 +++-
 net/packet/af_packet.c                             |    8 +-
 net/sctp/ipv6.c                                    |    1=20
 net/sunrpc/auth_gss/svcauth_gss.c                  |    8 +-
 net/sunrpc/cache.c                                 |    9 ++
 net/sunrpc/svcsock.c                               |    2=20
 net/vmw_vsock/vmci_transport.c                     |   67 +++++++++++++++-=
-----
 sound/pci/cs46xx/dsp_spos.c                        |    3=20
 sound/usb/mixer.c                                  |   10 ++-
 sound/usb/quirks-table.h                           |    3=20
 51 files changed, 351 insertions(+), 90 deletions(-)

Andreas Gruenbacher (1):
      gfs2: Fix loop in gfs2_rbm_find

Christian Borntraeger (1):
      genwqe: Fix size check

Christophe Leroy (1):
      gpio: max7301: fix driver for use with CONFIG_VMAP_STACK

Colin Ian King (1):
      x86/mtrr: Don't copy uninitialized gentry fields back to userspace

Cong Wang (3):
      ax25: fix a use-after-free in ax25_fillin_cb()
      ipv6: explicitly initialize udp6_addr in udp_sock_create6()
      netrom: fix locking in nr_find_socket()

Dan Carpenter (1):
      ALSA: cs46xx: Potential NULL dereference in probe

David Herrmann (1):
      fork: record start_time late

Deepa Dinamani (1):
      sock: Make sock->sk_stamp thread-safe

Dexuan Cui (1):
      Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened cha=
nnels

Dominique Martinet (1):
      9p/net: put a lower bound on msize

Eric Dumazet (1):
      isdn: fix kernel-infoleak in capi_unlocked_ioctl

Georgy A Bystrenin (1):
      CIFS: Fix error mapping for SMB2_LOCK command which caused OFD lock p=
roblem

Greg Kroah-Hartman (1):
      Linux 3.18.132

Hans Verkuil (1):
      media: vivid: free bitmap_cap when updating std/timings/etc.

Huacai Chen (2):
      MIPS: Ensure pmd_present() returns false after pmd_mknotpresent()
      MIPS: Align kernel load address to 64KB

Hui Peng (2):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data
      ALSA: usb-audio: Fix an out-of-bound read in create_composite_quirks

Jason Wang (1):
      vhost: make sure used idx is seen before log in vhost_add_used_n()

Jia-Ju Bai (1):
      usb: r8a66597: Fix a possible concurrency use-after-free bug in r8a66=
597_endpoint_disable()

Jorgen Hansen (1):
      VSOCK: Send reset control packet when socket is partially bound

Juergen Gross (1):
      xen/netfront: tolerate frags with no data

Larry Finger (1):
      b43: Fix error in cordic routine

Lubomir Rintel (1):
      power: supply: olpc_battery: correct the temperature units

Macpaul Lin (1):
      cdc-acm: fix abnormal DATA RX issue for Mediatek Preloader.

Maurizio Lombardi (1):
      ext4: missing unlock/put_page() in ext4_try_to_write_inline_data()

Pan Bian (1):
      ext4: fix possible use after free in ext4_quota_enable

Russell King (1):
      mmc: omap_hsmmc: fix DMA API warning

Scott Chen (1):
      USB: serial: pl2303: add ids for Hewlett-Packard HP POS pole displays

Sean Christopherson (1):
      KVM: x86: Use jmp to invoke kvm_spurious_fault() from .fixup

Steffen Maier (1):
      scsi: zfcp: fix posting too many status read buffers leading to adapt=
er shutdown

Takashi Iwai (1):
      ALSA: usb-audio: Avoid access before bLength check in build_audio_pro=
cunit()

Theodore Ts'o (1):
      ext4: force inode writes when nfsd calls commit_metadata()

Tore Anderson (1):
      USB: serial: option: add HP lt4132

Tyrel Datwyler (1):
      ibmveth: fix DMA unmap error in ibmveth_xmit_start error path

Ulf Hansson (1):
      mmc: core: Reset HPI enabled state during re-init and in case of erro=
rs

Vasily Averin (6):
      sunrpc: fix cache_head leak due to queued request
      sunrpc: use SVC_NET() in svcauth_gss_* functions
      dlm: fixed memory leaks after failed ls_remove_names allocation
      dlm: possible memory leak on error path in create_lkb()
      dlm: lost put_lkb on error path in receive_convert() and receive_unlo=
ck()
      dlm: memory leaks on error path in dlm_user_request()

Willem de Bruijn (2):
      packet: validate address length
      packet: validate address length if non-zero

Xin Long (1):
      sctp: initialize sin6_flowinfo for ipv6 addrs in sctp_inet6addr_event

Yan, Zheng (1):
      ceph: don't update importing cap's mseq when handing cap export


--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlw7Cq4ACgkQONu9yGCS
aT55NhAAi/MJ1kfQyki+u6AhfB3s5n3Yiha0P38UAhReZbBK+M25lnwa5d2NqkSO
KPfGjnPe8ly9AQH9R7Aq2qxYnsAAQXKluUWtEX3Fs50jLE8mgBV9AYdcNRIoe2c6
6Zg83LIeVDyPWUWfDVlLmyQSIXqRPq5jn/RRi9hTFLB/JXd94mpugR7jGIQnDmrk
95AG9GIKvPLEkLWDgBxClMluhJzqxv//Q9lZw40FnWpZ+JMYfKMJOxQCz9Lyej8N
7J/GDWkt93nqfMW6ZQfCKnVdAqTu8Zg5y6F+jatLrjL8zQiBzfSowGTPxgbJmDKF
MNtgKX2e0ZC3C9qkprMsWJVuFUknAgDloGl3P0a3WVOmr9uO0XIayakqDm6czeNV
OGM6ia7L2DhWfsj7K2U8n+ioThgp85umsCQMIqtxYrDwtW3YHG6F8jgohIyjNRYu
89sNqxXCZ1f30gDGaJCsKbyiMzMI3zzpCEkrLZoNRivzazwqpJp66c2cIIxyfwSS
SlgOSZdLkUWPyiT6uePL/HhTtuiKfJCcpH7joBvTJvVImRC6LiBXZH6i1OouYarX
5Zdwjw7+Q9Fenwy3+3k/wbOHz0Nmno9ZPSzvCMgIL5PNAMoVwja8TPkBN2LGnRWD
ELdvBFB/GYc1EBqYMFMk7pBxt6E7NSV9Q4mPGYqxR2n5pbJbZzM=
=03z8
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
