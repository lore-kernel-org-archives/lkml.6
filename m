Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8EFC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238A0214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 06:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238A0214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeHVKJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:09:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbeHVKJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:09:51 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4EB358B1;
        Wed, 22 Aug 2018 06:46:19 +0000 (UTC)
Date:   Wed, 22 Aug 2018 08:46:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.123
Message-ID: <20180822064616.GA28172@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I'm announcing the release of the 4.9.123 kernel.

All users of the 4.9 kernel series must upgrade.

The updated 4.9.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-4.9.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                |    2 +-
 arch/x86/include/asm/pgtable.h          |   13 ++++++++-----
 drivers/acpi/sleep.c                    |    8 ++++++++
 drivers/isdn/i4l/isdn_common.c          |    8 +-------
 drivers/tty/serial/8250/8250_dw.c       |    3 ++-
 drivers/tty/serial/8250/8250_port.c     |    3 +--
 drivers/usb/serial/option.c             |    4 ++++
 drivers/usb/serial/sierra.c             |    4 ++--
 include/net/af_vsock.h                  |    4 ++--
 include/net/llc.h                       |    5 +++++
 net/bluetooth/sco.c                     |    3 ++-
 net/dccp/ccids/ccid2.c                  |    6 ++++--
 net/ipv6/ip6_tunnel.c                   |    8 ++------
 net/l2tp/l2tp_core.c                    |    2 +-
 net/llc/llc_core.c                      |    4 ++--
 net/sched/cls_matchall.c                |    2 ++
 net/sched/cls_tcindex.c                 |    8 +++-----
 net/vmw_vsock/af_vsock.c                |   15 ++++++++-------
 net/vmw_vsock/vmci_transport.c          |    3 +--
 sound/core/memalloc.c                   |    8 ++------
 sound/core/seq/seq_virmidi.c            |   10 ++++++++++
 sound/pci/cs5535audio/cs5535audio.h     |    6 +++---
 sound/pci/cs5535audio/cs5535audio_pcm.c |    4 ++--
 sound/pci/hda/hda_intel.c               |    2 +-
 sound/pci/hda/patch_conexant.c          |    4 +++-
 sound/pci/vx222/vx222_ops.c             |    8 ++++----
 sound/pcmcia/vx/vxp_ops.c               |   10 +++++-----
 27 files changed, 89 insertions(+), 68 deletions(-)

Aleksander Morgado (1):
      USB: option: add support for DW5821e

Alexey Kodanev (1):
      dccp: fix undefined behavior with 'cwnd' shift in ccid2_cwnd_restart()

Chen Hu (1):
      serial: 8250_dw: always set baud rate in dw8250_set_termios

Cong Wang (2):
      llc: use refcount_inc_not_zero() for llc_sap_find()
      vsock: split dwork to avoid reinitializations

Greg Kroah-Hartman (1):
      Linux 4.9.123

Hangbin Liu (3):
      net_sched: Fix missing res info when create new tc_index filter
      net_sched: fix NULL pointer dereference when delete tcindex filter
      cls_matchall: fix tcf_unbind_filter missing

Hans de Goede (1):
      ALSA: hda: Correct Asrock B85M-ITX power_save blacklist entry

John Ogness (1):
      USB: serial: sierra: fix potential deadlock at close

Kees Cook (1):
      isdn: Disable IIOCDBGVAR

Mark (1):
      tty: serial: 8250: Revert NXP SC16C2552 workaround

Park Ju Hyung (2):
      ALSA: hda - Sleep for 10ms after entering D3 on Conexant codecs
      ALSA: hda - Turn CX8200 into D3 as well upon reboot

Srinath Mannam (1):
      serial: 8250_dw: Add ACPI support for uart on Broadcom SoC

Sudip Mukherjee (1):
      Bluetooth: avoid killing an already killed socket

Takashi Iwai (5):
      ALSA: vx222: Fix invalid endian conversions
      ALSA: virmidi: Fix too long output trigger loop
      ALSA: cs5535audio: Fix invalid endian conversion
      ALSA: memalloc: Don't exceed over the requested size
      ALSA: vxpocket: Fix invalid endian conversions

Tom Lendacky (1):
      x86/mm: Simplify p[g4um]d_page() macros

Wei Wang (1):
      l2tp: use sk_dst_check() to avoid race on sk->sk_dst_cache

Willy Tarreau (1):
      ACPI / PM: save NVS memory for ASUS 1025C laptop

Xin Long (1):
      ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit


--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlt9BrcACgkQONu9yGCS
aT5/IQ//ZKqknKa7Dgzm3C+1ZbCyKagW5Fs7enIC9LFnjRIWxRfG+gFeovqM2ES8
yNDkyqr8lBNUIPMv69JR7CUBiA8bT05oQaefbIk3uE1csVczwmwXjKu9BeMfIb4O
atZ4oXfI6wDk3kCEccevCbLa7s/lQUwpcSc/Vjl5vgVS/6Eele0PZnIDYk3uWT6Y
E8DPfuTBclv263iZ9nLcNTxQZgUk9lLYE5cAU6uMkgL00T6AAHy51TZ+rqKzPAY2
+axKIyZhSK3KbZqngdTnKTzkqqod65LKsuBMoxeQPuBx/1kTsnnsE0Y911qoPgkv
iSga7pu0pEx28rTbFgxK1pW/4A5BVkcCkDngMYJSD8FTQT5fiM19LGJQ8relWY4n
tN/tkoaDIFB7er9CyV5+yjd6JL1DLvIhu+ztxmpYveNa+t6AFY5peRaQ1QswTw4+
P6zNP/Qkgl8Yv8m3kj1R2VZT34r9hBwgtFa+lcxHu0olifG2yDJE1qBG8leeqquQ
qcsBufB44foUbu/AvrIqVQTaP2Ao8Qi+E6b/4ufET/5KmJQJKBf2XzxiqBXbGVAT
oMO3hY8pbt9WrSGlbKK7aMxGRPKNby78RVGwv5kFn3zMIQyTvgnzZr+CklhmgN0v
C9WbElv+zs6gf6ySxJbrYlZEUKBVl+BtbANDIpBusdq1At3hGTI=
=otNG
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
