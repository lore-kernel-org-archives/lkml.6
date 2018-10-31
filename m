Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A484C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937872081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 14:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IQPVi9E0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937872081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729548AbeJaX3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 19:29:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40926 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729513AbeJaX3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 19:29:33 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181031143115euoutp0129b0a6d044780ff6e42c35e34140cdf3~it-K6p0nX2896628966euoutp01-
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:31:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181031143115euoutp0129b0a6d044780ff6e42c35e34140cdf3~it-K6p0nX2896628966euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1540996275;
        bh=ZOLZMP1qXTwOfSE3VAC4Ps4hPLidEHe1GDYl58uemFc=;
        h=To:Cc:From:Subject:Date:References:From;
        b=IQPVi9E0edkrz2Pyx4ta6obHsEe3jrMB560hYJ+2e77Unjk25h/z1r90ShXvpdz/5
         1N80Jgf/X8MZHlnoMwbOj6b2dAVxD6jdmNEQ54EOK4zrn0JzaBeSHUIafrygCksGdn
         KZoLTqRfv2aVzaHXN2PD8C9p3EJppP5np4xFoi+g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181031143115eucas1p2bcc388f781a54ab6b58bfcb8c571255c~it-Kdb0r91729017290eucas1p2m;
        Wed, 31 Oct 2018 14:31:15 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.29.04441.2BCB9DB5; Wed, 31
        Oct 2018 14:31:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a~it-JkIlai2795727957eucas1p1q;
        Wed, 31 Oct 2018 14:31:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181031143113eusmtrp1de106477b9037bab5ff9c4f6a3710212~it-JVX2uT1374413744eusmtrp1M;
        Wed, 31 Oct 2018 14:31:13 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-b6-5bd9bcb2afa6
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id FC.B5.04284.1BCB9DB5; Wed, 31
        Oct 2018 14:31:13 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181031143113eusmtip1e13e7b241d0cc26e3306fed33f8df0f0~it-JFYb4c3169631696eusmtip1b;
        Wed, 31 Oct 2018 14:31:13 +0000 (GMT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev changes for v4.20
Message-ID: <c0f72f36-5fdf-4207-03a5-fd903ae4d278@samsung.com>
Date:   Wed, 31 Oct 2018 15:31:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduzned1Ne25GG/x9qmVx5et7NosTfR9Y
        LS7vmsNm8ajvLbsDi8eJGb9ZPO53H2fy+LxJLoA5issmJTUnsyy1SN8ugSujsTuuYJN2xZO+
        CewNjKcUuhg5OSQETCS2Tu9l72Lk4hASWMEo8ebRehYI5wujxN8Tr9kgnM+MEquuH2WBafn0
        7DsTRGI5UMv0TVBV7xkl+h6fYAWpEhEwkvj84gqYzSyQIPHl5mdmEJtNwEpiYvsqRhBbWEBb
        4uTu3WwgNq+AncTrJ7eZQGwWAVWJbUefAtVzcIgKREj0n1GHKBGUODnzCQvESHmJ5q2zmUH2
        Sgg8ZwOac5Ad4joXid/n90PZwhKvjm+BsmUkTk/uYYFomA509a+lUM56Rok1Z44xQVRZSxw+
        fpEVZDOzgKbE+l36IKaEgKNEV4MXhMknceOtIMQNfBKTtk1nhgjzSnS0CUHMUJPYsGwDG8zW
        rp0rmSFsD4mZKy+AXSMkECsxe8VU9gmMCrOQfDYLyWezEE5YwMi8ilE8tbQ4Nz212DAvtVyv
        ODG3uDQvXS85P3cTIzBtnP53/NMOxq+Xkg4xCnAwKvHwPki+ES3EmlhWXJl7iFGCg1lJhNdj
        0c1oId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzL5m2MFhJITyxJzU5NLUgtgskycXBKNTCuMyw6
        3eQrW1lr/ya3e0XnmolZOeYt7tq34lbf636Ze337Ap8Op+qbfc3NMkk+7+WtJf6/F0llUr85
        XyQ3NGSubMfkdIV9k3b8+e2VwMZY3nhqt2rtnqMapexzA1b0iOw/HvJn8i4BzrSnh766LtC1
        80iccTaw+3vYusdrJ/dGCX7MOXpw83QlluKMREMt5qLiRACGkmOMFwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7ob99yMNlh8xMLiytf3bBYn+j6w
        WlzeNYfN4lHfW3YHFo8TM36zeNzvPs7k8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl5GY3dcwSbtiid9E9gbGE8pdDFyckgImEh8evad
        qYuRi0NIYCmjRHvrLuYuRg6ghIzE8fVlEDXCEn+udbFB1LxllDj/8igbSEJEwEji84srrCA2
        s0CCxKb7U8HibAJWEhPbVzGC2MIC2hInd+8Gi/MK2Em8fnKbCcRmEVCV2Hb0KTOILSoQIXHr
        YQcLRI2gxMmZT1ggZqpL/Jl3iRnClpdo3jqbeQIj/ywkZbOQlM1CUraAkXkVo0hqaXFuem6x
        oV5xYm5xaV66XnJ+7iZGYHhvO/Zz8w7GSxuDDzEKcDAq8fA+SL4RLcSaWFZcmXuIUYKDWUmE
        12PRzWgh3pTEyqrUovz4otKc1OJDjKZAh09klhJNzgfGXl5JvKGpobmFpaG5sbmxmYWSOO95
        g8ooIYH0xJLU7NTUgtQimD4mDk6pBsb2e7+1xS0M05pl6pe93PBP8/TiSY+VfjfquHxI82L8
        cZBBSYJhsm3bksSdxo/mHb+hOIlNawOrtrV5RprpfwflS8ufn5+pXHWVs7G0Z3JS1MnifbFM
        m1oV/q+a8+/jrCU5B9OFX+hvN/vFd9zvA0PK1Y6d//RjfRi9mpMldOJsTyv5OHa3OimxFGck
        GmoxFxUnAgCL6ApahQIAAA==
X-CMS-MailID: 20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a
References: <CGME20181031143114eucas1p17d216460a93d5d5e29e71609e2f2214a@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.20. No major changes to the subsystem
itself, mainly fb drivers fixes & cleanups (atyfb & udlfb updates stand
out from the rest) + removal of no longer needed old clps711xfb driver.
Please see the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 0238df646e6224016a45505d2c111a24669ebe21:

  Linux 4.19-rc7 (2018-10-07 17:26:02 +0200)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.20

for you to fetch changes up to 217188d9f985bd3ce8c9a0cd50ca35be62d0f8c6:

  video: fbdev: remove redundant 'default n' from Kconfig-s (2018-10-24 11:26:32 +0200)

----------------------------------------------------------------
fbdev changes for v4.20:

- update atyfb driver - improvements for ATI Mach64 chips: detect
  the dot clock divider correctly on Sparc, fix display corruptions
  (due to endianness issues and improper reading of accelerator
  registers), optimize scrolling performance and also fix debugging
  printks (Mikulas Patocka)

- rewrite USB unplug handling in udlfb driver using framebuffer
  subsystem reference counting (Mikulas Patocka)

- fix support for native-mode display-timings in atmel_lcdfb driver
  (Sam Ravnborg)

- fix information leak & add missing access_ok() checks in sbuslib
  (Dan Carpenter)

- allow using GPIO expanders that can sleep in ssd1307fb driver
  (Michal Vokáč)

- convert omapfb driver to use GPIO descriptors instead of GPIO
  numbers for Amstrad Delta board (Janusz Krzysztofik)

- fix broken Kconfig menu dependencies (Randy Dunlap)

- convert fbdev subsystem to use %pOFn instead of device_node.name
  (Rob Herring)

- remove the dead old CLPS711x LCD support driver (the new CLPS711x
  LCD support driver is still available)

- misc fixes (Jia-Ju Bai, Gustavo A. R. Silva)

- misc cleanups (Mehdi Bounya, Nathan Chancellor, YueHaibing)

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (4):
      Merge tag 'v4.19-rc7' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      Revert "video: ssd1307fb: Do not hard code active-low reset sequence"
      video: fbdev: remove dead old CLPS711x LCD support driver
      video: fbdev: remove redundant 'default n' from Kconfig-s

Dan Carpenter (2):
      fbdev: sbuslib: use checked version of put_user()
      fbdev: sbuslib: integer overflow in sbusfb_ioctl_helper()

Gustavo A. R. Silva (1):
      video: fbdev: arcfb: mark expected switch fall-through

Janusz Krzysztofik (1):
      video: fbdev: omapfb: lcd_ams_delta: use GPIO lookup table

Jia-Ju Bai (1):
      video: fbdev: add the dependency of broadsheetfb in Kconfig

Mehdi Bounya (1):
      Video: vgastate: fixed a spacing coding style

Michal Vokáč (2):
      video: ssd1307fb: Use gpiod_set_value_cansleep() for reset
      video: ssd1307fb: Do not hard code active-low reset sequence

Mikulas Patocka (6):
      udlfb: handle unplug properly
      mach64: detect the dot clock divider correctly on sparc
      mach64: fix display corruption on big endian machines
      mach64: fix image corruption due to reading accelerator registers
      mach64: optimize wait_for_fifo
      atyfb: fix debugging printks

Nathan Chancellor (1):
      video: fbdev: sis: Remove unnecessary parentheses and commented code

Randy Dunlap (1):
      fbdev: fix broken menu dependencies

Rob Herring (1):
      fbdev: Convert to using %pOFn instead of device_node.name

Sam Ravnborg (1):
      atmel_lcdfb: support native-mode display-timings

YueHaibing (1):
      pxa168fb: remove set but not used variables 'mi'

 drivers/video/fbdev/Kconfig                  |  59 +----
 drivers/video/fbdev/Makefile                 |   1 -
 drivers/video/fbdev/arcfb.c                  |   2 +
 drivers/video/fbdev/atmel_lcdfb.c            |  43 +---
 drivers/video/fbdev/aty/atyfb.h              |  15 +-
 drivers/video/fbdev/aty/atyfb_base.c         |  43 ++--
 drivers/video/fbdev/aty/mach64_accel.c       |  32 ++-
 drivers/video/fbdev/aty/mach64_ct.c          |  10 +-
 drivers/video/fbdev/cg14.c                   |   4 +-
 drivers/video/fbdev/cg3.c                    |   2 +-
 drivers/video/fbdev/clps711xfb.c             | 314 ---------------------------
 drivers/video/fbdev/core/fbmon.c             |   4 +-
 drivers/video/fbdev/imsttfb.c                |   2 +-
 drivers/video/fbdev/leo.c                    |   2 +-
 drivers/video/fbdev/mmp/hw/Kconfig           |   1 -
 drivers/video/fbdev/mmp/panel/Kconfig        |   1 -
 drivers/video/fbdev/offb.c                   |  12 +-
 drivers/video/fbdev/omap/lcd_ams_delta.c     |  55 ++---
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig |   7 -
 drivers/video/fbdev/p9100.c                  |   2 +-
 drivers/video/fbdev/pxa168fb.c               |   3 -
 drivers/video/fbdev/sbuslib.c                |  28 +--
 drivers/video/fbdev/sis/init301.c            |   4 +-
 drivers/video/fbdev/ssd1307fb.c              |   4 +-
 drivers/video/fbdev/udlfb.c                  | 141 ++++--------
 drivers/video/of_display_timing.c            |   2 +-
 drivers/video/vgastate.c                     |   2 +-
 include/video/udlfb.h                        |   3 -
 28 files changed, 169 insertions(+), 629 deletions(-)
 delete mode 100644 drivers/video/fbdev/clps711xfb.c
