Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755F7C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9C92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548938691;
	bh=QJ36bzcb4Ue8M5zbY/RAqxmNUU8P01JDZ5e6RNQloo4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=sW0NgiH8m2lkjawDDXEdkpFrzG5hdrOfMHpd6JJG87W2MmZiZTRvbsMFE6vogWiZA
	 oEQJccCSS242mJ32ylnoPFgm4x31wbmYHLlp5E7Q48Xv8alSkJ/fESkNqvyr0aqilR
	 2W7ku8HH2lTncSfL7MQWbp846qr/1Sj89RlEfAx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733107AbfAaMot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 07:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:36976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732996AbfAaMot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 07:44:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D960218AF;
        Thu, 31 Jan 2019 12:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548938687;
        bh=QJ36bzcb4Ue8M5zbY/RAqxmNUU8P01JDZ5e6RNQloo4=;
        h=Date:From:To:Cc:Subject:From;
        b=kzAKDJ6N5D4JOzRd52jQH2j1lQewUmiWAzlrO7m9iLCThSBpeXRsqMVXgT3zYIBXW
         Qx1ojvP6SEtwr+7eLoFU50WEWlaa3zctlHx09Jgm5I785qF+E5O26J60jnz4R+ET2p
         MViWQfby4jD0TghokUc0IXh9ncnwvvd5S0y6KY5s=
Date:   Thu, 31 Jan 2019 13:44:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.9.154
Message-ID: <20190131124445.GB7471@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.9.154 kernel.

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

 Makefile                                      |    2=20
 arch/arc/include/asm/perf_event.h             |    3=20
 arch/arc/lib/memset-archs.S                   |   40 ++++-
 arch/s390/kernel/early.c                      |    4=20
 arch/s390/kernel/setup.c                      |    2=20
 arch/s390/kernel/smp.c                        |   12 +
 arch/x86/kvm/x86.c                            |    3=20
 arch/x86/lib/kaslr.c                          |    4=20
 drivers/acpi/nfit/core.c                      |   57 +++++--
 drivers/char/mwave/mwavedd.c                  |    7=20
 drivers/input/joystick/xpad.c                 |    3=20
 drivers/input/misc/uinput.c                   |    5=20
 drivers/irqchip/irq-gic-v3-its.c              |   25 +--
 drivers/md/dm-thin-metadata.c                 |    4=20
 drivers/md/dm-thin-metadata.h                 |    2=20
 drivers/md/dm-thin.c                          |   10 -
 drivers/net/can/dev.c                         |   27 +--
 drivers/net/ppp/pppoe.c                       |    1=20
 drivers/nvme/target/rdma.c                    |   17 +-
 drivers/s390/char/sclp_config.c               |    2=20
 drivers/staging/rtl8188eu/os_dep/usb_intf.c   |    1=20
 drivers/tty/n_hdlc.c                          |    1=20
 drivers/tty/serial/serial_core.c              |   12 +
 drivers/tty/tty_io.c                          |    3=20
 drivers/tty/vt/vt.c                           |    1=20
 drivers/usb/serial/pl2303.c                   |    1=20
 drivers/usb/serial/pl2303.h                   |    2=20
 drivers/usb/serial/usb-serial-simple.c        |    3=20
 drivers/vhost/net.c                           |    3=20
 drivers/vhost/vhost.c                         |   97 ++++++++++--
 drivers/vhost/vhost.h                         |    3=20
 fs/btrfs/dev-replace.c                        |    9 -
 fs/cifs/smb2ops.c                             |    6=20
 fs/f2fs/node.c                                |    4=20
 include/linux/compiler-clang.h                |   14 +
 include/linux/compiler-gcc.h                  |    4=20
 include/linux/compiler-intel.h                |    4=20
 include/linux/overflow.h                      |  205 +++++++++++++++++++++=
+++++
 include/linux/skbuff.h                        |    1=20
 include/net/ip_fib.h                          |    2=20
 net/bridge/br_forward.c                       |    9 -
 net/bridge/br_netfilter_ipv6.c                |    1=20
 net/bridge/netfilter/nft_reject_bridge.c      |    1=20
 net/can/bcm.c                                 |   27 +++
 net/ipv4/fib_frontend.c                       |    4=20
 net/ipv4/fib_trie.c                           |   14 +
 net/ipv4/inet_fragment.c                      |    2=20
 net/ipv4/ip_input.c                           |    1=20
 net/openvswitch/flow_netlink.c                |    2=20
 net/sched/sch_api.c                           |    3=20
 sound/soc/codecs/rt5514-spi.c                 |    2=20
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |    8 -
 tools/perf/util/unwind-libdw.c                |    4=20
 tools/testing/selftests/x86/protection_keys.c |   41 +++--
 54 files changed, 604 insertions(+), 121 deletions(-)

Alexander Popov (1):
      KVM: x86: Fix single-step debugging

Anand Jain (1):
      btrfs: dev-replace: go back to suspended state if target device is mi=
ssing

Charles Yeh (1):
      USB: serial: pl2303: add new PID to support PL2303TB

Christian Borntraeger (1):
      s390/early: improve machine detection

Cong Wang (1):
      net_sched: refetch skb protocol for each filter

Dan Williams (2):
      acpi/nfit: Block function zero DSMs
      acpi/nfit: Fix command-supported detection

Daniel Drake (1):
      x86/kaslr: Fix incorrect i8254 outb() parameters

Dave Hansen (1):
      x86/selftests/pkeys: Fork() to check for state being preserved

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Dmitry Torokhov (1):
      Input: uinput - fix undefined behavior in uinput_validate_absinfo()

Eugeniy Paltsev (2):
      ARCv2: lib: memeset: fix doing prefetchw outside of buffer
      ARC: perf: map generic branches to correct hardware condition

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Greg Kroah-Hartman (2):
      tty: Handle problem if line discipline does not have receive_buf
      Linux 4.9.154

Gustavo A. R. Silva (2):
      ASoC: rt5514-spi: Fix potential NULL pointer dereference
      char/mwave: fix potential Spectre v1 vulnerability

Ido Schimmel (1):
      net: ipv4: Fix memory leak in network namespace dismantle

Israel Rukshin (1):
      nvmet-rdma: Add unlikely for response allocated check

Jason Wang (1):
      vhost: log dirty page correctly

Jeff Mahoney (1):
      btrfs: fix error handling in btrfs_dev_replace_start

Joe Thornber (1):
      dm thin: fix passdown_double_checking_shared_status()

Kangjie Lu (1):
      ASoC: atom: fix a missing check of snd_pcm_lib_malloc_pages

Manfred Schlaegl (1):
      can: dev: __can_get_echo_skb(): fix bogous check for non-existing skb=
 by removing it

Marc Zyngier (1):
      irqchip/gic-v3-its: Align PCI Multi-MSI allocation on their size

Martin Vuille (1):
      perf unwind: Unwind with libdw doesn't take symfs into account

Max Schulze (1):
      USB: serial: simple: add Motorola Tetra TPG2200 device id

Michael Straube (1):
      staging: rtl8188eu: Add device code for D-Link DWA-121 rev B1

Milian Wolff (1):
      perf unwind: Take pgoff into account when reporting elf to libdwfl

Nicolas Pitre (1):
      vt: invoke notifier on screen size change

Oliver Hartkopp (1):
      can: bcm: check timer values before ktime conversion

Pan Bian (1):
      f2fs: read page index before freeing

Paolo Abeni (1):
      ipfrag: really prevent allocation on netns exit

Paul Fulghum (1):
      tty/n_hdlc: fix __might_sleep warning

Pavel Shilovsky (1):
      CIFS: Fix possible hang during async MTU reads and writes

Raju Rangoju (1):
      nvmet-rdma: fix null dereference under heavy load

Rasmus Villemoes (1):
      compiler.h: enable builtin overflow checkers and add fallback code

Ross Lagerwall (2):
      net: Fix usage of pskb_trim_rcsum
      openvswitch: Avoid OOB read when parsing flow nlattrs

Samir Virmani (1):
      uart: Fix crash in uart_write and uart_put_char

Tom Panfil (1):
      Input: xpad - add support for SteelSeries Stratus Duo

Yunjian Wang (1):
      net: bridge: Fix ethernet header pointer before check skb forwardable


--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlxS7boACgkQONu9yGCS
aT5wEBAA1mbn30q0KNDOabbF0Gn/eAy8dqx8ciCiXDTlxRsOEngUqO439WkzC03g
TTG37bY2uZLN12WnDBikPfSohYfr534pw8UOc+eavyJ3xsgMPk5pwfarLe1KJA67
J6ZEI0c2MMnhi1/OeL4wvGjgJwjKWD35bthlyBVSHPoLn2vlgzhas6/xkR0UxAxY
xXU83wXD1qtnb8LLJMWnFERGVXTT8+c0E0/nodrOQmgfeoYpiUfUH3QgyMD94fOr
iEyiqnjY2bAGe4NzOZGbEU3QCV8YqkN8SDNds0W3wRHGWFQnruHxB14NJaJftzw5
9c3NnmKvwOEbtvRbAxIzI6hA4UXw43jN3NmoUiPHxJOkUC1ip/eO21iDXegSxlov
GH2EJTOIyWWoo9msIDW1s4X6dFsZbbTUxpCmR/k/gf8efSYmpopl3nxnM4Ccsn4P
cSffSeTfOF4NiCqkv4QaSroefidifdSU76/CIpT8Z667wjpsZzzeNKuiSP24hSYY
fW0Eel7T+6HjPB15ycp+McShQdmSJUSMj6hPkj+YX8nhq9M3OXs2WPkEiFHpn6Gq
0w8JqD6s7kDiJtjgpRgq9E6IWYbV37q+QN9JZGSgy4fobv8KN6C8Vu4tE5/DeTnV
vJNJSuHn9jOjjQ2a+2S56tRtI2bK6mE+NH4egi+MEZ/Dc+h3SGc=
=PzUY
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
