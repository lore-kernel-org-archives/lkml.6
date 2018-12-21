Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FCCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BD521903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 16:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545409496;
	bh=APXFja2JkKWFh3dmUsblDbaF3nRwpwMVoCpoffA2mQ8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Am1elidplGxBTOzuUdJhsCy6JBiuJufB4CtJ19M8NYuxL/jFPGcGoMb3uYk8fd4b4
	 7QHx3ZRR41x0D4dOR31b6KQrs3OGZP9wIVWdfFvPbyMB7qB5qT+wPgpbDM70XIcoHV
	 6neZWzOyv+2MaqQJjrrK8FCEnw8RNIGuNKUu1878=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbeLUQYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 11:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:47402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbeLUQYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 11:24:53 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F9F121903;
        Fri, 21 Dec 2018 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545409493;
        bh=APXFja2JkKWFh3dmUsblDbaF3nRwpwMVoCpoffA2mQ8=;
        h=Date:From:To:Cc:Subject:From;
        b=ILl6UOmlO2OUXufx5ceLY7++DMDOGk/GoqKxGYnEdR61faksZG4RZ2TEpySEyx41f
         Y4+PbCv4ZxXHsYNWVIpx3P7odbmnlUXtNBfmkWdPDWfnluUhBPbYWLxbSOhkFvDEmG
         HPNlUTsp60EMtRyrHaZBjD+hqil0XjOh4OD9KJe8=
Date:   Fri, 21 Dec 2018 17:24:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.12
Message-ID: <20181221162450.GA7488@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.12 kernel.

All users of the 4.19 kernel series must upgrade.

The updated 4.19.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linu=
x-4.19.y
and can be browsed at the normal kernel.org git web browser:
	http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-stable.git;a=3Dsu=
mmary

thanks,

greg k-h

------------

 Makefile                                                    |    2=20
 arch/arc/include/asm/io.h                                   |   72 ++
 arch/arm/mm/cache-v7.S                                      |    8=20
 arch/arm/mm/cache-v7m.S                                     |   14=20
 arch/arm/mm/dma-mapping.c                                   |    2=20
 arch/x86/include/asm/qspinlock.h                            |   21=20
 arch/x86/platform/efi/early_printk.c                        |    2=20
 drivers/acpi/nfit/core.c                                    |    2=20
 drivers/ata/libata-core.c                                   |    1=20
 drivers/clk/mmp/clk.c                                       |    2=20
 drivers/clk/mvebu/cp110-system-controller.c                 |    4=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c                     |    6=20
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c                       |    3=20
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c |    2=20
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c                 |    3=20
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c                |    2=20
 drivers/gpu/drm/ast/ast_fb.c                                |    1=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c                    |    1=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c                 |    2=20
 drivers/gpu/drm/msm/dsi/pll/dsi_pll_10nm.c                  |    4=20
 drivers/gpu/drm/msm/hdmi/hdmi.c                             |    6=20
 drivers/gpu/drm/msm/hdmi/hdmi.h                             |    1=20
 drivers/gpu/drm/msm/hdmi/hdmi_connector.c                   |   10=20
 drivers/gpu/drm/msm/msm_atomic.c                            |    5=20
 drivers/gpu/drm/msm/msm_debugfs.c                           |   15=20
 drivers/gpu/drm/msm/msm_gpu.c                               |    9=20
 drivers/gpu/drm/msm/msm_iommu.c                             |    2=20
 drivers/gpu/drm/msm/msm_rd.c                                |    5=20
 drivers/gpu/drm/ttm/ttm_bo_util.c                           |    4=20
 drivers/hid/hid-hyperv.c                                    |    2=20
 drivers/i2c/busses/i2c-axxia.c                              |   40 -
 drivers/i2c/busses/i2c-rcar.c                               |    9=20
 drivers/i2c/busses/i2c-scmi.c                               |   10=20
 drivers/i2c/busses/i2c-uniphier-f.c                         |   19=20
 drivers/i2c/busses/i2c-uniphier.c                           |    8=20
 drivers/ide/pmac.c                                          |    1=20
 drivers/infiniband/hw/hfi1/user_sdma.c                      |   24=20
 drivers/infiniband/hw/hfi1/user_sdma.h                      |    9=20
 drivers/input/keyboard/omap4-keypad.c                       |   18=20
 drivers/input/mouse/synaptics.c                             |    1=20
 drivers/input/serio/hyperv-keyboard.c                       |    2=20
 drivers/net/bonding/bond_3ad.c                              |    3=20
 drivers/net/dsa/mv88e6060.c                                 |   10=20
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.c   |    2=20
 drivers/net/ethernet/cavium/liquidio/lio_vf_rep.c           |    4=20
 drivers/net/ethernet/freescale/fman/fman.c                  |    5=20
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c             |   34 +
 drivers/net/ethernet/mellanox/mlx4/Kconfig                  |    2=20
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c    |   10=20
 drivers/net/ethernet/socionext/sni_ave.c                    |   14=20
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c           |   23=20
 drivers/net/macvlan.c                                       |    7=20
 drivers/net/wireless/mac80211_hwsim.c                       |   12=20
 drivers/nvme/host/core.c                                    |   10=20
 drivers/nvme/target/rdma.c                                  |    3=20
 drivers/sbus/char/display7seg.c                             |    1=20
 drivers/sbus/char/envctrl.c                                 |    2=20
 drivers/scsi/libiscsi.c                                     |    4=20
 drivers/scsi/vmw_pvscsi.c                                   |    4=20
 drivers/thermal/armada_thermal.c                            |    2=20
 drivers/tty/serial/suncore.c                                |    1=20
 drivers/vhost/vsock.c                                       |   22=20
 fs/btrfs/disk-io.c                                          |   51 -
 fs/cifs/Kconfig                                             |    2=20
 fs/nfs/direct.c                                             |    9=20
 kernel/bpf/verifier.c                                       |    3=20
 kernel/locking/qspinlock.c                                  |   71 +-
 net/sunrpc/xprt.c                                           |   11=20
 tools/testing/nvdimm/test/nfit.c                            |   35 +
 tools/testing/selftests/bpf/test_btf.c                      |  375 +++++++=
++++-
 tools/testing/selftests/bpf/test_verifier.c                 |    2=20
 71 files changed, 867 insertions(+), 221 deletions(-)

Abhinav Kumar (1):
      drm/msm/dsi: configure VCO rate for 10nm PLL driver

Adamski, Krzysztof (Nokia - PL/Wroclaw) (1):
      i2c: axxia: properly handle master timeout

Alexei Starovoitov (1):
      bpf: check pending signals while verifying programs

Alexey Khoroshilov (1):
      mac80211_hwsim: fix module init error paths for netlink

Anderson Luiz Alves (1):
      mv88e6060: disable hardware level MAC learning

Baruch Siach (2):
      net: mvpp2: fix detection of 10G SFP modules
      net: mvpp2: fix phylink handling of invalid PHY modes

Cathy Avery (1):
      scsi: vmw_pscsi: Rearrange code to avoid multiple calls to free_irq d=
uring unload

Chris Cole (1):
      ARM: 8814/1: mm: improve/fix ARM v7_dma_inv_range() unaligned address=
 handling

Christian K=F6nig (2):
      drm/ttm: fix LRU handling in ttm_buffer_object_transfer
      drm/amdgpu: wait for IB test on first device open

Dan Carpenter (3):
      drm/msm/gpu: Fix a couple memory leaks in debugfs
      clk: mvebu: Off by one bugs in cp110_of_clk_get()
      clk: mmp: Off by one in mmp_clk_add()

Dan Williams (2):
      tools/testing/nvdimm: Align test resources to 128M
      acpi/nfit: Fix user-initiated ARS to be "ARS-long" rather than "ARS-s=
hort"

Dave Kleikamp (1):
      nfs: don't dirty kernel pages read by direct-io

David Miller (1):
      bpf: Fix verifier log string check for bad alignment.

Dmitry Bogdanov (1):
      net: aquantia: fix rx checksum offload bits

Evan Quan (1):
      drm/amd/powerplay: issue pre-display settings for display change event

Fred Herard (1):
      scsi: libiscsi: Fix NULL pointer dereference in iscsi_eh_session_reset

Greg Kroah-Hartman (1):
      Linux 4.19.12

Hans de Goede (1):
      i2c: scmi: Fix probe error on devices with an empty SMB0001 ACPI devi=
ce node

Ido Schimmel (1):
      mlxsw: spectrum_switchdev: Fix VLAN device deletion via ioctl

Israel Rukshin (1):
      nvmet-rdma: fix response use after free

James Smart (1):
      nvme: validate controller state before rescheduling keep alive

James Zhu (1):
      drm/amdgpu/vcn: Update vcn.cur_state during suspend

Jose Abreu (1):
      ARC: io.h: Implement reads{x}()/writes{x}()

Juha-Matti Tilli (1):
      libata: whitelist all SAMSUNG MZ7KM* solid-state disks

Kunihiko Hayashi (1):
      net: ethernet: ave: Replace NET_IP_ALIGN with AVE_FRAME_HEADROOM

Martin KaFai Lau (1):
      tools/bpf: fix two test_btf unit test cases

Masahiro Yamada (2):
      i2c: uniphier: fix violation of tLOW requirement for Fast-mode
      i2c: uniphier-f: fix violation of tLOW requirement for Fast-mode

Matteo Croce (1):
      macvlan: return correct error value

Michael J. Ruhl (1):
      IB/hfi1: Remove race conditions in user_sdma send path

Nathan Jones (1):
      ARM: 8816/1: dma-mapping: fix potential uninitialized return

Nicolas Saenz Julienne (1):
      ethernet: fman: fix wrong of_node_put() in probe function

Omar Sandoval (1):
      Btrfs: fix missing delayed iputs on unmount

Pan Bian (1):
      liquidio: read sc->iq_no before release sc

Peter Zijlstra (2):
      locking/qspinlock: Re-order code
      locking/qspinlock, x86: Provide liveness guarantee

Rob Clark (1):
      drm/msm: fix handling of cmdstream offset

Roman Li (1):
      drm/amd/display: Fix 6x4K displays light-up on Vega20 (v2)

Russell King (1):
      thermal: armada: fix legacy validity test sense

Saeed Mahameed (1):
      net/mlx4_en: Fix build break when CONFIG_INET is off

Sam Bobroff (1):
      drm/ast: Fix connector leak during driver unload

Sean Paul (2):
      drm/msm: Grab a vblank reference when waiting for commit_done
      drm/msm: dpu: Don't set legacy plane->crtc pointer

Sharat Masetty (1):
      drm/msm: Fix task dump in gpu recovery

Stefan Hajnoczi (1):
      vhost/vsock: fix reset orphans race with close timeout

Steve French (1):
      cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure =
cifs)

Teika Kazura (1):
      Input: synaptics - enable SMBus for HP 15-ay000

Thierry Reding (1):
      net: stmmac: Move debugfs init/exit to ->probe()/->remove()

Todor Tomov (1):
      drm/msm/hdmi: Enable HPD after HDMI IRQ is set up

Toni Peltonen (1):
      bonding: fix 802.3ad state sent to partner when unbinding slave

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Trond Myklebust (1):
      SUNRPC: Fix a potential race in xprt_connect()

Vitaly Kuznetsov (1):
      Input: hyper-v - fix wakeup from suspend-to-idle

Vladimir Murzin (1):
      ARM: 8815/1: V7M: align v7m_dma_inv_range() with v7 counterpart

Wen Yang (1):
      drm/msm: Fix error return checking

Wolfram Sang (1):
      i2c: rcar: check bus state before reinitializing

Yangtao Li (4):
      sbus: char: add of_node_put()
      drivers/sbus/char: add of_node_put()
      drivers/tty: add missing of_node_put()
      ide: pmac: add of_node_put()

YiFei Zhu (1):
      x86/earlyprintk/efi: Fix infinite loop on some screen widths

Yonghong Song (1):
      tools/bpf: add addition type tests to test_btf

YueHaibing (1):
      drm/msm: dpu: Fix "WARNING: invalid free of devm_ allocated data"


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwdE9IACgkQONu9yGCS
aT4ssBAAsO4MKZnb3jkJuWWI90nawXt1IYLni1eoHkd7cdjlvWPM3BdomIwGN/Zf
qGeYRoTKRUNxL5nnGIRxqtlFvOc3l5ya46Q6Np4rz4SqsH2RdVRDlerCvaV9XWVu
suEj2qQta+N+jEp/UqcDKz7T1ALUrntzZMAoXR2T1h704OEd+TxUjIA++scrQ3bk
vPOY1HU+OKiEjZYgibO7e0xZaP1KZa3eBFiUsab5kFj1Wf9gVyr28J177sXDnwOH
63v9s9vaPTFitdnN4RuP6PasWASAxieBZUCUGzR9YJf/S7+oYMN7RxLTjdmnTvSy
6pKP89uI8Sv2N6j0lKpWI652q6a0XV3SchLXwBuSEpSNm51LoMZDP26dsUMg4i4H
jTYe1vUrg3Nj7PHTh69tUyEmq3iDZxv306Pvi532V0kcQMcE295tncCQ3Hbefe39
Wx0jorFXoxfc8ztpp9/mmO0qi3IjKSPpoIibKnuNHkbraMm95H0DbDCWWdhzc5Z4
PVQiapyEQfFPsNS9bhWK3KksJcGvcfKPKNHVqQEqa37I7JhNKk/rDx5/uZiUEDRL
iXMb8ZtLJJNjlxUUCp/iHLAkqFx4NyYbS9kAelIK76s3lNLb7o3n16Tzx4SXKVNV
zdopv1sI1cBDSVedt/MuTy139jvJRk6kUDP1aLrSmfetFOWkS5s=
=4sTg
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
