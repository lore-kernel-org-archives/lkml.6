Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5782FC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF11C2152A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 12:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbMPDrsq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF11C2152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeJTUOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 16:14:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727315AbeJTUOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 16:14:24 -0400
Received: from localhost (10.193.71.37.rev.sfr.net [37.71.193.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B16F21523;
        Sat, 20 Oct 2018 12:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540037049;
        bh=6/JEZLHtVuS+2zEG1mmv/iDyz2junrQ4WXP+RdgaRHQ=;
        h=Date:From:To:Cc:Subject:From;
        b=YbMPDrsqbeyddza920a5stmi25WGF3xAtlCUirj734wcHASnYs0N09u119MGpANDN
         QKbDBQFxS3StpHppNrMqCszn2G5wsoQkQCgGF6Pw9+7NW3tmsDujFcrt4kssafAQcf
         Q+TWyxFZjMY0PJDUnSD4X/hChDKLUDZr40T0zv3g=
Date:   Sat, 20 Oct 2018 14:04:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.4.162
Message-ID: <20181020120404.GA14068@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.4.162 kernel.

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

 Documentation/devicetree/bindings/net/macb.txt        |    1=20
 Documentation/kernel-parameters.txt                   |    5 -
 Makefile                                              |    2=20
 arch/arc/Makefile                                     |   14 ---
 arch/arm/boot/dts/sama5d3_emac.dtsi                   |    2=20
 arch/powerpc/kernel/tm.S                              |   20 ++++
 arch/x86/crypto/crc32c-intel_glue.c                   |   17 ----
 arch/x86/include/asm/cpufeatures.h                    |    1=20
 arch/x86/include/asm/fpu/internal.h                   |   37 ---------
 arch/x86/include/asm/fpu/types.h                      |   34 --------
 arch/x86/include/asm/kvm_host.h                       |    1=20
 arch/x86/kernel/fpu/core.c                            |   41 +--------
 arch/x86/kernel/fpu/signal.c                          |    8 -
 arch/x86/kvm/cpuid.c                                  |    5 -
 arch/x86/kvm/x86.c                                    |   10 --
 drivers/clocksource/timer-ti-32k.c                    |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c     |    2=20
 drivers/hv/hv_fcopy.c                                 |    2=20
 drivers/hv/hv_kvp.c                                   |   40 +++++++++
 drivers/hv/hv_snapshot.c                              |    4=20
 drivers/hv/hv_util.c                                  |    1=20
 drivers/hv/hyperv_vmbus.h                             |    5 +
 drivers/i2c/busses/i2c-scmi.c                         |    1=20
 drivers/input/keyboard/atakbd.c                       |   74 ++++++-------=
-----
 drivers/media/usb/dvb-usb-v2/af9035.c                 |    6 -
 drivers/mfd/omap-usb-host.c                           |   11 +-
 drivers/net/bonding/bond_main.c                       |   43 ++++------
 drivers/net/ethernet/broadcom/bcmsysport.c            |   22 ++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c             |   13 ++-
 drivers/net/ethernet/cadence/macb.c                   |    8 +
 drivers/net/ethernet/marvell/mvpp2.c                  |   10 +-
 drivers/net/ethernet/mellanox/mlx4/eq.c               |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic.h           |    8 +
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.h   |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.h        |    3=20
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c        |   12 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c |    5 -
 drivers/net/team/team.c                               |    5 +
 drivers/net/usb/smsc75xx.c                            |    1=20
 drivers/usb/gadget/function/u_serial.c                |    2=20
 drivers/usb/host/xhci-hub.c                           |   18 ++--
 drivers/video/fbdev/aty/atyfb.h                       |    3=20
 drivers/video/fbdev/aty/atyfb_base.c                  |    7 -
 drivers/video/fbdev/aty/mach64_ct.c                   |   10 +-
 fs/ext4/xattr.c                                       |   22 +++--
 fs/jffs2/xattr.c                                      |    6 -
 include/linux/hyperv.h                                |    1=20
 include/linux/netdevice.h                             |    7 +
 include/net/bonding.h                                 |    7 -
 include/net/ip_fib.h                                  |    1=20
 mm/vmstat.c                                           |    1=20
 net/core/dev.c                                        |   28 ++++++
 net/core/rtnetlink.c                                  |    6 +
 net/ipv4/fib_frontend.c                               |   12 +-
 net/ipv4/fib_semantics.c                              |   50 ++++++++++++
 net/ipv4/ip_sockglue.c                                |    3=20
 net/ipv4/ip_tunnel.c                                  |    9 ++
 net/ipv6/addrconf.c                                   |    4=20
 net/ipv6/ip6_tunnel.c                                 |   13 ++-
 net/netlabel/netlabel_unlabeled.c                     |    3=20
 sound/hda/hdac_controller.c                           |    8 +
 sound/soc/codecs/sigmadsp.c                           |    3=20
 sound/soc/codecs/wm8804-i2c.c                         |   15 +++
 tools/perf/scripts/python/export-to-postgresql.py     |    9 ++
 tools/testing/selftests/efivarfs/config               |    1=20
 66 files changed, 396 insertions(+), 339 deletions(-)

Adrian Hunter (1):
      perf script python: Fix export-to-postgresql.py occasional failure

Alexey Brodkin (1):
      ARC: build: Get rid of toolchain check

Amber Lin (1):
      drm/amdgpu: Fix SDMA HQD destroy error on gfx_v7

Andreas Schwab (1):
      Input: atakbd - fix Atari keymap

Andy Lutomirski (2):
      x86/fpu: Remove use_eager_fpu()
      x86/fpu: Finish excising 'eagerfpu'

Danny Smith (1):
      ASoC: sigmadsp: safeload should not have lower byte limit

Edgar Cherkasov (1):
      i2c: i2c-scmi: fix for i2c_smbus_write_block_data

Eric Dumazet (2):
      ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
      rtnl: limit IFLA_NUM_TX_QUEUES and IFLA_NUM_RX_QUEUES to 4096

Florian Fainelli (1):
      net: systemport: Fix wake-up interrupt race during resume

Greg Kroah-Hartman (1):
      Linux 4.4.162

Hou Tao (1):
      jffs2: return -ERANGE when xattr buffer is too small

Ido Schimmel (1):
      team: Forbid enslaving team device to itself

Jann Horn (1):
      mm/vmstat.c: fix outdated vmstat_text

Jeff Barnhill (1):
      net/ipv6: Display all addresses in output of /proc/net/if_inet6

Jongsung Kim (1):
      stmmac: fix valid numbers of unicast filter entries

Jozef Balga (1):
      media: af9035: prevent buffer overflow on write

K. Y. Srinivasan (2):
      Drivers: hv: utils: Invoke the poll function after handshake
      Drivers: hv: util: Pass the channel information during the init call

Keerthy (1):
      clocksource/drivers/ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP flag for=
 non-am43 SoCs

Lei Yang (1):
      selftests/efivarfs: add required kernel configs

Long Li (1):
      HV: properly delay KVP packets when negotiation is in progress

Mahesh Bandewar (1):
      bonding: avoid possible dead-lock

Mathias Nyman (1):
      xhci: Don't print a warning when setting link state for disabled ports

Maxime Chevallier (1):
      net: mvpp2: Extract the correct ethtype from the skb for tx csum offl=
oad

Michael Chan (1):
      bnxt_en: Fix TX timeout during netpoll.

Michael Neuling (2):
      powerpc/tm: Fix userspace r13 corruption
      powerpc/tm: Avoid possible userspace r1 corruption on reclaim

Michael Schmitz (1):
      Input: atakbd - fix Atari CapsLock behaviour

Mikulas Patocka (1):
      mach64: detect the dot clock divider correctly on sparc

Nathan Chancellor (1):
      net/mlx4: Use cpumask_available for eq->affinity_mask

Nicolas Ferre (2):
      net: macb: disable scatter-gather for macb on sama5d3
      ARM: dts: at91: add new compatibility string for macb on sama5d3

Paolo Abeni (2):
      ip6_tunnel: be careful when accessing the inner header
      ip_tunnel: be careful when accessing the inner header

Paolo Bonzini (1):
      KVM: x86: remove eager_fpu field of struct kvm_vcpu_arch

Pierre-Louis Bossart (1):
      ASoC: wm8804: Add ACPI support

Rik van Riel (1):
      x86/fpu: Remove struct fpu::counter

Sabrina Dubroca (1):
      net: ipv4: update fnhe_pmtu when first hop's MTU changes

Sean Tranchetti (1):
      netlabel: check for IPV4MASK in addrinfo_get

Shahed Shaikh (1):
      qlcnic: fix Tx descriptor corruption on 82xx devices

Stephen Warren (1):
      usb: gadget: serial: fix oops when data rx'd after close

Theodore Ts'o (1):
      ext4: add corruption check in ext4_xattr_set_entry()

Tony Lindgren (1):
      mfd: omap-usb-host: Fix dts probe of children

Vitaly Kuznetsov (1):
      Drivers: hv: kvp: fix IP Failover

Yu Zhao (2):
      sound: enable interrupt after dma buffer initialization
      net/usb: cancel pending work when unbinding smsc75xx


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlvLGbIACgkQONu9yGCS
aT5O9Q/+NkQfExkxOnzTa1dX8SA7aXha8Ws4NrfeKq73LMAqiB2RBHkMuA8gW7Oe
IHlmOGsaLQTHoda3+78y612FBRg5ln/udqiK15Fd2oZRPwUziJB9ub3Xk5ohe6sM
9Et8t74YWN/r0mZ9uX4vwL1J+wptGvbnZ75ZJ266fM/mgBF3DUY4CmMEMiWrm95r
TLxE2Xxl8JSQcL5yyiuvo0xI/R95jQd0QwMwUKnfGHp/+jS+Dg46TP2K1/IqTelz
qUH24ZYB9k8zBJFwmqbL2JQ4i4qiivP1//2S/LdKtTkfzqcBmIJBYmX1PEcjdT4r
pWBt7lCgxXGXndTwVNTk1oryE9AnZkVSpptNd/yjMMV92+e7rZ8GDEyEMqK4RKMv
8V09htxHvy8Ank05hoh3BDb3iW5XuinfSJKBkui9GgR3SFZaCWBF0tJtGIMiQ3Tg
jWqYF4tSsZOxmR/Y7LfO1itryTIteImhkUC1OxpkXJd2YbFSq/ulq4DYn7lXLbDT
b0PI/hhrSrOeu51CG8yxhIDgsWbZZpNLBCL1gqXdYpBj8TjaLgJ4jR4MKguGlOQF
4awIf5qNrT6Q9sMarjsKmszRhJpWfl4hUFaP7E7ktvAJcybkIJ/JoVa6sU4483Ua
cakMAtRRWtOT8c31D3QFizCzo95QoQS7fYtWyP8+thpE1FtNZb4=
=QDCE
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
