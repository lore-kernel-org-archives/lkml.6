Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CAAECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9107D20875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 13:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9107D20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeGVOru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 10:47:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51414 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGVOru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 10:47:50 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5E486AE0;
        Sun, 22 Jul 2018 13:51:04 +0000 (UTC)
Date:   Sun, 22 Jul 2018 15:51:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.143
Message-ID: <20180722135102.GA14268@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.143 kernel.

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

 Makefile                                        |    2=20
 arch/mips/kernel/process.c                      |   31 +++++++++++
 arch/mips/kernel/traps.c                        |    1=20
 arch/x86/include/asm/asm.h                      |   59 +++++++++++++++++++=
+++
 drivers/atm/zatm.c                              |    2=20
 drivers/crypto/amcc/crypto4xx_core.c            |   23 ++++----
 drivers/net/ethernet/broadcom/bcm63xx_enet.c    |   34 +++++++++---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c |    2=20
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c   |    8 +--
 drivers/net/ethernet/qlogic/qed/qed_main.c      |    9 +++
 drivers/net/ethernet/sun/sungem.c               |   22 ++++----
 drivers/net/usb/r8152.c                         |    3 -
 drivers/net/wireless/realtek/rtlwifi/core.c     |    1=20
 drivers/vhost/net.c                             |    3 -
 fs/ocfs2/cluster/nodemanager.c                  |   63 +++++++++++++++++++=
+----
 include/linux/compiler-gcc.h                    |   35 ++++++++++---
 net/bridge/netfilter/ebtables.c                 |   13 ++++
 net/dccp/ccids/ccid3.c                          |   16 +++---
 net/dns_resolver/dns_key.c                      |   28 ++++++----
 net/ipv4/sysctl_net_ipv4.c                      |   18 ++++--
 net/ipv4/tcp_input.c                            |    9 +++
 net/ipv6/sit.c                                  |    1=20
 net/nfc/llcp_commands.c                         |    9 ++-
 net/rds/loop.c                                  |    1=20
 net/rds/rds.h                                   |    5 +
 net/rds/recv.c                                  |    5 +
 net/sched/sch_blackhole.c                       |    2=20
 27 files changed, 319 insertions(+), 86 deletions(-)

Alex Vesker (2):
      net/mlx5: Fix incorrect raw command length parsing
      net/mlx5: Fix command interface race in polling mode

Christian Lamparter (2):
      crypto: crypto4xx - remove bad list_del
      crypto: crypto4xx - fix crypto4xx_build_pdr, crypto4xx_build_sdr leak

David Rientjes (2):
      compiler, clang: suppress warning for unused static inline functions
      compiler, clang: always inline when CONFIG_OPTIMIZE_INLINING is disab=
led

David S. Miller (1):
      Revert "sit: reload iphdr in ipip6_rcv"

Eric Biggers (1):
      KEYS: DNS: fix parsing multiple options

Eric Dumazet (3):
      net: dccp: avoid crash in ccid3_hc_rx_send_feedback()
      net: dccp: switch rx_tstamp_last_feedback to monotonic clock
      net: sungem: fix rx checksum support

Florian Westphal (1):
      netfilter: ebtables: reject non-bridge targets

Greg Kroah-Hartman (1):
      Linux 4.4.143

Gustavo A. R. Silva (2):
      atm: zatm: Fix potential Spectre v1
      net: cxgb3_main: fix potential Spectre v1

H. Peter Anvin (1):
      x86/asm: Add _ASM_ARG* constants for argument registers to <asm/asm.h>

Ilpo J=E4rvinen (1):
      tcp: prevent bogus FRTO undos with non-SACK flows

Jason Wang (1):
      vhost_net: validate sock before trying to put its fd

Jiri Slaby (1):
      r8152: napi hangup fix after disconnect

Jonas Gorski (2):
      bcm63xx_enet: correct clock usage
      bcm63xx_enet: do not write to random DMA channel on BCM6345

Konstantin Khlebnikov (1):
      net_sched: blackhole: tell upper qdisc about dropped packets

Linus Torvalds (1):
      compiler, clang: properly override 'inline' for clang

Nick Desaulniers (1):
      compiler-gcc.h: Add __attribute__((gnu_inline)) to all inline declara=
tions

Paul Burton (2):
      MIPS: Call dump_stack() from show_regs()
      MIPS: Use async IPIs for arch_trigger_cpumask_backtrace()

Ping-Ke Shih (1):
      rtlwifi: rtl8821ae: fix firmware is not ready to run

Santosh Shilimkar (1):
      rds: avoid unenecessary cong_update in loop transport

Sudarsana Reddy Kalluru (1):
      qed: Limit msix vectors in kdump kernel to the minimum required count.

Tetsuo Handa (1):
      net/nfc: Avoid stalls when nfc_alloc_send_skb() returned NULL.

Yuchung Cheng (1):
      tcp: fix Fast Open key endianness

alex chen (1):
      ocfs2: subsystem.su_mutex is required while accessing the item->ci_pa=
rent


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAltUi8UACgkQONu9yGCS
aT5bnQ/+MnlybDAhFtCeLrBynQxgB82oW3T3O9FR6pmgEsJ9ro6PrszVzNuW4whR
WUEXUjrvshUX7BBm1vpDL87PKn0nyLMq4o8KwdxlhSdC835glZWTLO6COw5jfBbc
m7Yezw6dTf7r7x0TbI+zw2TonpnwJFHe/hYOKsutFjJGfF1DY6AFM/r9LOYpuaWe
rL6T7/eMj4Mg1A9ziZEu+L8X6XJZaykbD420naDs3Zhroa3yus5/HZD1IEqaTppw
JwbGa8GJOM1Q/tT/NKsficOl7/tOn/2YMV3uMGe/UgfXzucymTu4R7gQ+aNh/NLw
tDOaRo9gsixq3rLu0ntqcH50h8SRGMyGE8iyZeYgcewqDUieNjjtlisGIfNHQoMM
fKwwnxAfF4n88SNsZ589OMeXOu063U/XA7RByQ0XBuwoWhIKhWrVU5X3SmyVNgSu
4e1mv8kUCN6uy0YtZy9sijCA7V3/0TMHXEepwHQfQfxcx/HD9OtRl2NMWtmi1HnX
ZqXssPQlTDk/Ne30Qm9Ec4X8+4zJXzlop8ZCVNZHcIzhihdhQveebFXqT78C0FW9
wkIgqKfrvUYV5MIb5yc8idYys5GAa+caHDWGR1r2f6VpNLxHJ47UG1SGfpuRg8CK
gQlTsP5xRN9PZm09xVwGhPd7R9kh4YoCxl3O8vbnvWLzRfCXhJk=
=Up7g
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
