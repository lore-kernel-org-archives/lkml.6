Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6375C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2892080D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 19:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545247254;
	bh=xayT41wwzRm7zzva+15wemlUgcGEazNnxceiP65GRgc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=pD93ceQtGYkYbKbpiWcbwSW7RDqHkEQJIju65KY84FXqLgfZClTu9fqvWN+9QtPnl
	 ppBHfGqXgCVRGU8W8AnwpAnpMdz62O0oWcq+lfKjmP9r+5tTnub6PMrRS0ZUcktFsq
	 zWin8hhZaHhU6QfpwIqVkWPz4kmXlyhO/J5OQFyI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbeLSTUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:20:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbeLSTUw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 14:20:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B672F2080D;
        Wed, 19 Dec 2018 19:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545247251;
        bh=xayT41wwzRm7zzva+15wemlUgcGEazNnxceiP65GRgc=;
        h=Date:From:To:Cc:Subject:From;
        b=pvIarW3M6bsAjmJt0B07LEDZ3JrbMbXLj89O+SXrSKerdsAk1csve4HjlnyhSH3Q2
         dQOpoPMv2jEF/4qVVCPCMJaQzvxEk/V/Xi0ljHJLGOhwPQ9zazB8TBJv7YrZLRvcCA
         5zDHqcK+cy5OCX6xvBdrbxveN3D4s+V9uCVpbRvE=
Date:   Wed, 19 Dec 2018 20:20:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Linux 4.19.11
Message-ID: <20181219192048.GA4272@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm announcing the release of the 4.19.11 kernel.

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

 Makefile                                                |    2=20
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts              |    2=20
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts                   |    2=20
 arch/arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts     |    5=20
 arch/arm/mach-mmp/cputype.h                             |    6=20
 arch/arm64/mm/dma-mapping.c                             |    2=20
 arch/powerpc/kernel/legacy_serial.c                     |    6=20
 arch/powerpc/kernel/msi.c                               |    7=20
 arch/x86/Makefile                                       |   10 -
 block/bio.c                                             |    3=20
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c                 |   36 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 |    6=20
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                 |    6=20
 drivers/gpu/drm/amd/powerplay/inc/smu7_ppsmc.h          |    2=20
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c |    6=20
 drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c           |    3=20
 drivers/gpu/drm/i915/gvt/fb_decoder.c                   |    2=20
 drivers/gpu/drm/i915/intel_lrc.c                        |    7=20
 drivers/gpu/drm/msm/disp/dpu1/dpu_dbg.c                 |    8 -
 drivers/gpu/drm/nouveau/dispnv50/disp.c                 |   30 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c             |    6=20
 drivers/i2c/busses/i2c-aspeed.c                         |    4=20
 drivers/md/dm-cache-metadata.c                          |    4=20
 drivers/md/dm-thin.c                                    |   68 ++++----
 drivers/md/dm-zoned-target.c                            |  122 ++++-------=
-----
 drivers/md/dm.c                                         |    2=20
 drivers/media/common/videobuf2/videobuf2-core.c         |    4=20
 drivers/mmc/core/block.c                                |   15 +
 drivers/mmc/host/omap.c                                 |   11 +
 drivers/mmc/host/sdhci-omap.c                           |   12 +
 drivers/mmc/host/sdhci.c                                |   18 +-
 drivers/pinctrl/sunxi/pinctrl-sun8i-a83t.c              |    2=20
 drivers/scsi/raid_class.c                               |    4=20
 drivers/slimbus/qcom-ngd-ctrl.c                         |    6=20
 drivers/staging/olpc_dcon/Kconfig                       |    1=20
 fs/aio.c                                                |    2=20
 fs/fuse/dir.c                                           |    2=20
 fs/fuse/file.c                                          |   21 +-
 fs/fuse/fuse_i.h                                        |    2=20
 fs/iomap.c                                              |    7=20
 fs/overlayfs/dir.c                                      |   14 +
 fs/overlayfs/export.c                                   |    6=20
 fs/userfaultfd.c                                        |    3=20
 init/Kconfig                                            |    5=20
 kernel/sched/core.c                                     |    7=20
 kernel/sched/fair.c                                     |    2=20
 kernel/sched/pelt.c                                     |    2=20
 kernel/sched/pelt.h                                     |    2=20
 kernel/sched/sched.h                                    |    5=20
 kernel/trace/ftrace.c                                   |    1=20
 kernel/trace/trace_events_filter.c                      |    5=20
 kernel/trace/trace_events_trigger.c                     |    6=20
 scripts/spdxcheck.py                                    |    6=20
 53 files changed, 310 insertions(+), 218 deletions(-)

Aaro Koskinen (1):
      MMC: OMAP: fix broken MMC on OMAP15XX/OMAP5910/OMAP310

Alek Du (1):
      mmc: sdhci: fix the timeout check window for clock and reset

Alex Deucher (3):
      drm/amdkfd: add new vega10 pci ids
      drm/amdgpu: add some additional vega10 pci ids
      drm/amdgpu: update smu firmware images for VI variants (v2)

Amir Goldstein (2):
      ovl: fix decode of dir file handle with multi lower layers
      ovl: fix missing override creds in link of a metacopy upper

Andrea Arcangeli (1):
      userfaultfd: check VM_MAYWRITE was set after verifying the uffd is re=
gistered

Arnd Bergmann (5):
      scsi: raid_attrs: fix unused variable warning
      slimbus: ngd: mark PM functions as __maybe_unused
      i2c: aspeed: fix build warning
      ARM: dts: qcom-apq8064-arrow-sd-600eval fix graph_endpoint warning
      drm/msm: fix address space warning

Ben Skeggs (1):
      drm/nouveau/kms/nv50-: also flush fb writes when rewinding push buffer

Benjamin Herrenschmidt (1):
      powerpc: Look for "stdout-path" when setting up legacy consoles

Brian Norris (1):
      Revert "drm/rockchip: Allow driver to be shutdown on reboot/kexec"

Chad Austin (1):
      fuse: continue to send FUSE_RELEASEDIR when FUSE_OPEN returns ENOSYS

Chen-Yu Tsai (1):
      pinctrl: sunxi: a83t: Fix IRQ offset typo for PH11

Chris Wilson (1):
      drm/i915/execlists: Apply a full mb before execution for Braswell

Damien Le Moal (1):
      dm zoned: Fix target BIO completion handling

Faiz Abbas (1):
      mmc: sdhci-omap: Fix DCRC error handling during tuning

Greg Kroah-Hartman (1):
      Linux 4.19.11

Hans Verkuil (1):
      media: vb2: don't call __vb2_queue_cancel if vb2_start_streaming fail=
ed

Jeff Moyer (1):
      aio: fix spectre gadget in lookup_ioctx

Junwei Zhang (1):
      drm/amdgpu: update SMC firmware image for polaris10 variants

Keith Busch (1):
      block/bio: Do not zero user pages

Kenneth Feng (1):
      drm/amdgpu/powerplay: Apply avfs cks-off voltages on VI

Lubomir Rintel (2):
      staging: olpc_dcon: add a missing dependency
      ARM: mmp/mmp2: fix cpu_is_mmp2() on mmp2-dt

Lyude Paul (1):
      drm/nouveau/kms: Fix memory leak in nv50_mstm_del()

Masahiro Yamada (1):
      x86/build: Fix compiler support check for CONFIG_RETPOLINE

Mike Snitzer (3):
      dm thin: send event about thin-pool state change _after_ making it
      dm cache metadata: verify cache has blocks in blocks_are_clean_separa=
te_dirty()
      dm: call blk_queue_split() to impose device limits on bios

Piotr Jaroszynski (1):
      fs/iomap.c: get/put the page in iomap_page_create/release()

Radu Rendec (1):
      powerpc/msi: Fix NULL pointer access in teardown code

Robin Murphy (1):
      arm64: dma-mapping: Fix FORCE_CONTIGUOUS buffer clearing

Stefan Wahren (1):
      ARM: dts: bcm2837: Fix polarity of wifi reset GPIOs

Steven Rostedt (VMware) (3):
      tracing: Fix memory leak in create_filter()
      tracing: Fix memory leak in set_trigger_filter()
      tracing: Fix memory leak of instance function hash filters

Thierry Reding (1):
      scripts/spdxcheck.py: always open files in binary mode

Tina Zhang (1):
      drm/i915/gvt: Fix tiled memory decoding bug on BDW

Vincent Guittot (1):
      sched/pelt: Fix warning and clean up IRQ PELT config

Wolfram Sang (1):
      mmc: core: use mrq->sbc when sending CMD23 for RPMB


--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEZH8oZUiU471FcZm+ONu9yGCSaT4FAlwamgwACgkQONu9yGCS
aT7ZxA/+Jazlv4bNmTRUYefKhVZfmObx0FbpQkD1FGDO5ww9aOJS+frwD0EkSjZV
Ij0YUWeyZ4ZjQRY1gdue0xhpy2MHQVBtMq/vWKkfDdE8+epSuO0x35p1+4EH0IJp
+uK1MnW+TxinqvxQKUBOLKGaCupMP8w4zkq8N5BGYJCHkhRrnK3VozTy6GW8gntx
Ux/4KWDp9T5PV91Ij/Z17zpd1DdsTk/4zrK+GMS5mO4SiZhfetMXJVBafVlH0QKJ
I1DYxYLFwlM/HEie4wSWH7n9XXGrXo0BhG4zV/vg14CfONkRj3k+R+rdazXLOsE3
n32yRz4pu9L2XGFMr3GKLoRLuEFfqPgMMaWGCjCggL2YMjol7nlf+NJObrs5B3so
k24ZavPZwIcr8nancJsGz1yzlakwIPRxbvakD+ZzGvf7c8jPqBiQsQHvP/vq9KgR
p5QBqN/y0SzssDU/kbmCOo5Ng9vKP7pAX2Vrv6L9jGY4CbnGDO7vQ9XwA0WBlVDW
4QJFlabxZoQA3VGAvekDVJsumKTP5j/kGjthC031tncH2xPAGvkYPmjdik3JDPrU
S4S1hh1H3Rri9tOmxyPDb2OVWydgWCY7D610ZWaKEcYklxyQ6Utny4dyj8HZC0SP
2rSihTtqlDAAeGAHSEwRd/bUwgOm2Zifaf7uff1ZlmmbK6/UcBU=
=Lpim
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
