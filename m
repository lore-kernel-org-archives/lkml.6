Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A780DC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0D4208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LyoZfH8r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0D4208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755240AbeFNLGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:06:41 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39509 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754860AbeFNLGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:06:36 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180614110633euoutp027df9494e90f523b0a7f6b0a3ab5f9005~4AhwgX_tf1135511355euoutp02U;
        Thu, 14 Jun 2018 11:06:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180614110633euoutp027df9494e90f523b0a7f6b0a3ab5f9005~4AhwgX_tf1135511355euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1528974393;
        bh=c8sA8WWAGwPKd6UrPz/TyQ7BdRqj9pVy03XOZxC7vhs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=LyoZfH8rA5/GJPxP5bgRqo9NAN0o+GZRBH56ER1Bg7TvVW3wUd0y4kN357ZPj+hyV
         meVypl2zqA9HfeowbT4ujXFoG7UQu3Es6ep+RO25k0g+92bGNM0nOxXzl+zdTxrx5w
         qj0sEpEBg0lbcJl+hDWke2YdlrblFdw1qhqEsBUA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180614110631eucas1p25b0ddaacaddff063bc81b6ca9d9f96f7~4AhvFXxeM0753707537eucas1p2D;
        Thu, 14 Jun 2018 11:06:31 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 00.DC.10409.63C422B5; Thu, 14
        Jun 2018 12:06:30 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180614110629eucas1p2205094587cda711188f72d8dd8395ac9~4AhtU8vuE2288022880eucas1p2W;
        Thu, 14 Jun 2018 11:06:29 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-2f-5b224c36b304
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 63.E4.04183.53C422B5; Thu, 14
        Jun 2018 12:06:29 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PAB0091N86TGRA0@eusync3.samsung.com>; Thu, 14 Jun
        2018 12:06:29 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev changes for v4.18
Date:   Thu, 14 Jun 2018 13:06:29 +0200
Message-id: <4529972.sH8mM7iiAP@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRmVeSWpSXmKPExsWy7djP87pmPkrRBk+3GVtc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MqY0JRYsMe+4sJ6
        2QbGJ3pdjJwcEgImEgevbWftYuTiEBJYwSix41YLI0hCSOAzo0THDH2Yov7Hb9ghipYxSkza
        fpYZwvnNKHFr8xs2kCo2ASuJie2rwLpFBIwkPr+4wgpiMwskSPw/v5MJxBYW0JaYNHEhmM0i
        oCqx5cROdhCbV0BT4uv/fWBzRAW8JLbsa2eCiAtK/Jh8jwVijrzEvv1ToWbqSJw9to4R4rqP
        rBLn//BC2C4Sl673QsWFJV4d38IOYctIXJ7czQJytITAdEaJN7+WQjnrGSXWnDnGBFFlLXH4
        +EWoDXwSk7ZNB3qTAyjOK9HRJgRR4iHx6+MlJkgQxUq0r57KMoFRehaSW2chuXUWklsXMDKv
        YhRPLS3OTU8tNs5LLdcrTswtLs1L10vOz93ECIzg0/+Of93BuO9P0iFGAQ5GJR7eDXKK0UKs
        iWXFlbmHGCU4mJVEeCf/BArxpiRWVqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1I
        LYLJMnFwSjUwnnt/val9zmMVlcP5/LPebOdYH6IkslKhaoqm9emp6QzK86d+aph04kVUbsv7
        0mSf7/9KeWuLBI9y8R87aX78stmSWD7r1QHueQoLNzkd8t22+MuuV88bS3IOTFQzlCmtOOWg
        8MNZrjrYvavcOyWx2b7KTpXxksr+h50RqVpKdxw+NhxlUy1UYinOSDTUYi4qTgQA+mQz99wC
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDLMWRmVeSWpSXmKPExsVy+t/xq7qmPkrRBtvWGVhc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MqY0JRYsMe+4sJ6
        2QbGJ3pdjJwcEgImEv2P37B3MXJxCAksYZSYtnMBM4Tzl1Fi0oR3TCBVbAJWEhPbVzGC2CIC
        RhKfX1xhBbGZBRIkNq9sZAaxhQW0JSZNXAhWzyKgKrHlxE52EJtXQFPi6/99bCC2qICXxJZ9
        7UwQcUGJH5PvsUDMkZfYt38q1EwtifU7jzNNYOSdhaRsFpKyWUjKFjAyr2IUSS0tzk3PLTbS
        K07MLS7NS9dLzs/dxAgMs23Hfm7Zwdj1LvgQowAHoxIP7wY5xWgh1sSy4srcQ4wSHMxKIryT
        fwKFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MMq/nPts
        l9TGp0xuna1nzd/9L2Ux8/HO4Wgr2RTs4XDsZbZixK3cvDyx+PPuR/5q/1fs+RZbJmSlk3lK
        njvyYIjNvfmlV1KyHDtCJVV+hTzTlVxqrjQjqaVojqV2P+vSixw/Aqfsz/mwZPYVryiP+/li
        h41lDWfd4HOM+O4ptNx7sev03arpSizFGYmGWsxFxYkAD5feWC8CAAA=
X-CMS-MailID: 20180614110629eucas1p2205094587cda711188f72d8dd8395ac9
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180614110629eucas1p2205094587cda711188f72d8dd8395ac9
References: <CGME20180614110629eucas1p2205094587cda711188f72d8dd8395ac9@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.18. There is nothing really major
here, few small fixes, some cleanups and dead drivers removal (please
see the signed tag description for details).

Test merge revealed a small merge conflict, the resolution is trivial:

diff --cc drivers/video/fbdev/mmp/fb/mmpfb.c
index f27697e,292b3e4..ee212be
--- a/drivers/video/fbdev/mmp/fb/mmpfb.c
+++ b/drivers/video/fbdev/mmp/fb/mmpfb.c
@@@ -493,12 -493,11 +493,11 @@@ static int modes_setup(struct mmpfb_inf
  		return 0;
  	}
  	/* put videomode list to info structure */
 -	videomodes = kzalloc(sizeof(struct fb_videomode) * videomode_num,
 -			GFP_KERNEL);
 +	videomodes = kcalloc(videomode_num, sizeof(struct fb_videomode),
 +			     GFP_KERNEL);
- 	if (!videomodes) {
- 		dev_err(fbi->dev, "can't malloc video modes\n");
+ 	if (!videomodes)
  		return -ENOMEM;
- 	}
+ 
  	for (i = 0; i < videomode_num; i++)
  		mmpmode_to_fbmode(&videomodes[i], &mmp_modes[i]);
  	fb_videomode_to_modelist(videomodes, videomode_num, &info->modelist);


Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.18

for you to fetch changes up to 85ebd164de56c5146e0f65cebee7fcc4babe52e3:

  fb_omap2: add gpiolib dependency (2018-06-08 18:08:12 +0200)

----------------------------------------------------------------
fbdev changes for v4.18:

- mark omapfb drivers as orphans in MAINTAINERS file (Tomi Valkeinen)

- add missing module license tags to omap/omapfb driver (Arnd Bergmann)

- add missing GPIOLIB dependendy to omap2/omapfb driver (Arnd Bergmann)

- convert savagefb, aty128fb & radeonfb drivers to use msleep & co.
  (Jia-Ju Bai)

- allow COMPILE_TEST build for viafb driver (media part was reviewed by
  media subsystem Maintainer)

- remove unused MERAM support from sh_mobile_lcdcfb and shmob-drm drivers
  (drm parts were acked by shmob-drm driver Maintainer)

- remove unused auo_k190xfb drivers

- misc cleanups (Souptick Joarder, Wolfram Sang, Markus Elfring, Andy
  Shevchenko, Colin Ian King)

----------------------------------------------------------------
Andy Shevchenko (1):
      video: fbdev: pxafb: Convert to use match_string() helper

Arnd Bergmann (2):
      video/omap: add module license tags
      fb_omap2: add gpiolib dependency

Bartlomiej Zolnierkiewicz (7):
      Merge tag 'v4.17-rc2' of git://git.kernel.org/.../torvalds/linux into fbdev-for-next
      video: fbdev: remove unused auo_k190xfb drivers
      video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
      drm: shmobile: remove unused MERAM support
      video: fbdev: remove unused sh_mobile_meram driver
      video: fbdev: via: allow COMPILE_TEST build
      video: fbdev: pxafb: match_string() conversion fixup

Colin Ian King (2):
      video: fbdev: fix spelling mistake: "frambuffer" -> "framebuffer"
      video: fbdev: nvidia: fix spelling mistake: "scaleing" -> "scaling"

Geert Uytterhoeven (1):
      video: fbdev: sh_mobile_meram: Drop SUPERH platform dependency

Jia-Ju Bai (3):
      video: fbdev: savage: Replace mdelay with usleep_range in savage_init_hw
      video: fbdev: aty: aty128fb: Replace mdelay with msleep in aty128_set_suspend
      video: fbdev: aty: radeon_pm: Replace mdelay with msleep in radeonfb_pci_suspend

Markus Elfring (7):
      video: sh_mobile_meram: Delete an error message for a failed memory allocation in sh_mobile_meram_probe()
      video: sh_mobile_lcdcfb: Delete an error message for a failed memory allocation in two functions
      video: auo_k190x: Delete an error message for a failed memory allocation in auok190x_common_probe()
      video: fbdev-MMP: Delete an error message for a failed memory allocation in two functions
      video: fbdev-MMP: Improve a size determination in path_init()
      video: sm501fb: Improve a size determination in sm501fb_probe()
      video: omap: Improve a size determination in omapfb_do_probe()

Souptick Joarder (1):
      video: fbdev: core: Change return type to vm_fault_t

Tomi Valkeinen (1):
      MAINTAINERS: make omapfb orphan

Wolfram Sang (2):
      video: fbdev: simplify getting .drvdata
      video: fbdev: omap2: omapfb: displays: simplify getting .drvdata

 MAINTAINERS                                        |    6 +-
 drivers/gpu/drm/shmobile/Kconfig                   |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.c          |   42 -
 drivers/gpu/drm/shmobile/shmob_drm_crtc.h          |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_drv.h           |    2 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.c           |   11 -
 drivers/gpu/drm/shmobile/shmob_drm_kms.h           |    1 -
 drivers/gpu/drm/shmobile/shmob_drm_plane.c         |    2 -
 drivers/media/platform/via-camera.c                |    5 +
 drivers/video/fbdev/Kconfig                        |   48 +-
 drivers/video/fbdev/Makefile                       |    4 -
 drivers/video/fbdev/aty/aty128fb.c                 |    2 +-
 drivers/video/fbdev/aty/radeon_pm.c                |    8 +-
 drivers/video/fbdev/au1100fb.c                     |    2 +-
 drivers/video/fbdev/au1200fb.c                     |    2 +-
 drivers/video/fbdev/auo_k1900fb.c                  |  204 ----
 drivers/video/fbdev/auo_k1901fb.c                  |  257 -----
 drivers/video/fbdev/auo_k190x.c                    | 1195 --------------------
 drivers/video/fbdev/auo_k190x.h                    |  129 ---
 drivers/video/fbdev/core/fb_defio.c                |    4 +-
 drivers/video/fbdev/mmp/fb/mmpfb.c                 |    5 +-
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c              |    8 +-
 drivers/video/fbdev/nvidia/nvidia.c                |    2 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c           |    4 +
 drivers/video/fbdev/omap/lcd_h3.c                  |    4 +
 drivers/video/fbdev/omap/lcd_htcherald.c           |    4 +
 drivers/video/fbdev/omap/lcd_inn1510.c             |    4 +
 drivers/video/fbdev/omap/lcd_inn1610.c             |    4 +
 drivers/video/fbdev/omap/lcd_osk.c                 |    4 +
 drivers/video/fbdev/omap/lcd_palmte.c              |    4 +
 drivers/video/fbdev/omap/lcd_palmtt.c              |    4 +
 drivers/video/fbdev/omap/lcd_palmz71.c             |    4 +
 drivers/video/fbdev/omap/omapfb_main.c             |    2 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig           |    1 +
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     |   18 +-
 drivers/video/fbdev/pxafb.c                        |    8 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |    8 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.c             |   77 +-
 drivers/video/fbdev/sh_mobile_lcdcfb.h             |    1 -
 drivers/video/fbdev/sh_mobile_meram.c              |  758 -------------
 drivers/video/fbdev/sm501fb.c                      |    3 +-
 drivers/video/fbdev/via/global.h                   |    6 +
 drivers/video/fbdev/via/hw.c                       |    1 -
 drivers/video/fbdev/via/via-core.c                 |    1 -
 drivers/video/fbdev/via/via_clock.c                |    2 +-
 drivers/video/fbdev/via/viafbdev.c                 |    1 -
 include/linux/platform_data/shmob_drm.h            |    4 -
 include/video/auo_k190xfb.h                        |  107 --
 include/video/sh_mobile_lcdc.h                     |    3 -
 include/video/sh_mobile_meram.h                    |   95 --
 50 files changed, 87 insertions(+), 2986 deletions(-)
 delete mode 100644 drivers/video/fbdev/auo_k1900fb.c
 delete mode 100644 drivers/video/fbdev/auo_k1901fb.c
 delete mode 100644 drivers/video/fbdev/auo_k190x.c
 delete mode 100644 drivers/video/fbdev/auo_k190x.h
 delete mode 100644 drivers/video/fbdev/sh_mobile_meram.c
 delete mode 100644 include/video/auo_k190xfb.h
 delete mode 100644 include/video/sh_mobile_meram.h

