Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A1EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38260208E3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pq3rKsq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfADMJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:09:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59797 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfADMJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:09:10 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190104120909euoutp016d7bbd1770483c7339da6f36d966da91~2o_pcG6lp0750107501euoutp01W
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jan 2019 12:09:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190104120909euoutp016d7bbd1770483c7339da6f36d966da91~2o_pcG6lp0750107501euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1546603749;
        bh=CVVpWD94k/3w2eTYZ0N2lVwuEJVKm+3Mj9BloqDwGB4=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Pq3rKsq7Z0K9Kh+v7bhC4edLN7vg9xwyDFHFGy8ratbDNg4RNSx6tPs1mK8j3HXOE
         vzQj9as3nVqKQi1TMy2cQZqdxQqaeoOMLdaKiTXumaVI2cX9iH8iPFIE+rRdQVazWf
         JrycD6ip7Z3AqqwRFY3Z+qjge9X2sIGeszBK4XTI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190104120908eucas1p15d92cc707a9334f72602519f93ce34c7~2o_o7C48v1096310963eucas1p1u;
        Fri,  4 Jan 2019 12:09:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.CF.04294.4EC4F2C5; Fri,  4
        Jan 2019 12:09:08 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190104120907eucas1p1cde1273265b78d7dccbe26728b717602~2o_oCPB0z2728527285eucas1p1H;
        Fri,  4 Jan 2019 12:09:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190104120907eusmtrp17bccda32821d1e6f85709cf7d8f5d671~2o_n0Bi410284502845eusmtrp1n;
        Fri,  4 Jan 2019 12:09:07 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-64-5c2f4ce4f717
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 86.39.04284.3EC4F2C5; Fri,  4
        Jan 2019 12:09:07 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190104120906eusmtip19640bd21a66526f57a4b477859fed65d~2o_nei4e51922819228eusmtip1e;
        Fri,  4 Jan 2019 12:09:06 +0000 (GMT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev changes for v4.21
Message-ID: <8389e508-e1ac-dc96-9535-49fcfe3a404a@samsung.com>
Date:   Fri, 4 Jan 2019 13:09:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleLIzCtJLcpLzFFi42LZduznOd0nPvoxBkdus1lc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MpoO9rAWHBEvuLq
        7bQGxsUSXYycHBICJhILnj1h6mLk4hASWMEo0XFrLhuE84VRYvm0+6wQzmdGiSmvHrB0MXKA
        tRzYyg4RX84osf33SijnPaNE0+sFrCBzRQSMJD6/uAJmMwskSHy5+ZkZxGYTsJKY2L6KEcQW
        FtCW6FlxkB3E5hWwk3jbcIoFxGYRUJFo2fcHbJmoQIRE/xl1iBJBiZMzn7BAjJSXaN46mxlk
        r4TAYzaJSy/nsED84yJx6udDdghbWOLV8S1QtozE6ck9LBAN0xkl3vxaCuWsZ5RYc+YYE0SV
        tcTh4xdZQTYzC2hKrN+lDxF2lNj6bAczxPd8EjfeCkIcwScxadt0qDCvREebEES1msSGZRvY
        YNZ27VzJDGF7SFyc0AB2ppBArMTJ+4/YJzAqzELy2iwkr81CuGEBI/MqRvHU0uLc9NRio7zU
        cr3ixNzi0rx0veT83E2MwLRx+t/xLzsYd/1JOsQowMGoxMPLwKMXI8SaWFZcmXuIUYKDWUmE
        N5FJP0aINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QDI1df
        QNU0HaPjUs92P1m0+o2mX94nW4lW1ouvhDhKTkQdLX2/ht1fOLjlOPeHmRkFxp+Urk+dL7Y/
        bFdHW+ebF8FzTUVvzw+7arVU93CFYvPZj2VuJVsPyf2o0hUIdNZXs7PduE7LUlTb7r7F4xOB
        y9Y7uAf/rZj+er//z86FwceE97DkLjNtUWIpzkg01GIuKk4EANgdBMcXAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsVy+t/xu7qPffRjDObs5bS48vU9m8WJvg+s
        Fpd3zWGzeNT3lt2BxePEjN8sHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJfRdrSBseCIfMXV22kNjIsluhg5OCQETCQObGXv
        YuTiEBJYyiixe9scVoi4jMTx9WVdjJxAprDEn2tdbBA1bxklJs1ZwAKSEBEwkvj84goriM0s
        kCCx6f5UNhCbTcBKYmL7KkYQW1hAW6JnxUF2EJtXwE7ibcMpsF4WARWJln1/wGxRgQiJWw87
        WCBqBCVOznzCAjFTXeLPvEvMELa8RPPW2cwTGPlnISmbhaRsFpKyBYzMqxhFUkuLc9Nziw31
        ihNzi0vz0vWS83M3MQKDe9uxn5t3MF7aGHyIUYCDUYmHN4JPL0aINbGsuDL3EKMEB7OSCG8i
        k36MEG9KYmVValF+fFFpTmrxIUZToMMnMkuJJucDIy+vJN7Q1NDcwtLQ3Njc2MxCSZz3vEFl
        lJBAemJJanZqakFqEUwfEwenVAPjjNnWD31aAgLbBaNiFqg189QmTeL1WL9xWkS6ePqXvItL
        j/dFp92+4Lx5mdmsq2umrPi31PH78tIWec9LT4WMVvVMq5kuM4WzzmbuFnkPabsnQQ46+XJL
        blz03t93Y83jorJTNbPbvToZGF1+nL6kfLM7+/stEU09++UxfrzV8qfPbrZPqL+jxFKckWio
        xVxUnAgAmlBdTIQCAAA=
X-CMS-MailID: 20190104120907eucas1p1cde1273265b78d7dccbe26728b717602
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190104120907eucas1p1cde1273265b78d7dccbe26728b717602
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190104120907eucas1p1cde1273265b78d7dccbe26728b717602
References: <CGME20190104120907eucas1p1cde1273265b78d7dccbe26728b717602@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v4.21. This time the pull request is
really small. The most notable changes are fixing fbcon to not cause
crash on unregister_framebuffer() operation when there is more than
one framebuffer, adding config option to center the bootup logo and
making FB_BACKLIGHT config option tristate (which in turn uncovered
incorrect FB_BACKLIGHT usage by DRM's nouveau driver). Please see
the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 7566ec393f4161572ba6f11ad5171fd5d59b0fbd:

  Linux 4.20-rc7 (2018-12-16 15:46:55 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v4.21

for you to fetch changes up to 399382f8018204407174f0229b4087d40e1cdc82:

  drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig (2019-01-02 18:47:37 +0100)

----------------------------------------------------------------
fbdev changes for v4.21:

- fix fbcon to not cause crash on unregister_framebuffer()
  when there is more than one framebuffer (Noralf Trønnes)

- improve support for small rotated displays (Peter Rosin)

- fix probe failure handling in udlfb driver (Dan Carpenter)

- add config option to center the bootup logo (Peter Rosin)

- make FB_BACKLIGHT config option tristate (Rob Clark)

- remove superfluous HAS_DMA dependency for goldfishfb driver
  (Geert Uytterhoeven)

- misc fixes (Alexey Khoroshilov, YueHaibing, Colin Ian King,
  Lubomir Rintel)

- misc cleanups (Yangtao Li, Wen Yang)

also there is DRM's nouveau driver fix for wrong FB_BACKLIGHT
config option usage (FB_BACKLIGHT is for internal fbdev
subsystem use only)

----------------------------------------------------------------
Alexey Khoroshilov (1):
      video: clps711x-fb: release disp device node in probe()

Bartlomiej Zolnierkiewicz (2):
      Merge tag 'v4.20-rc7' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next
      drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig

Colin Ian King (1):
      fbdev: uvesafb: fix spelling mistake "memoery" -> "memory"

Dan Carpenter (1):
      udlfb: fix some inconsistent NULL checking

Geert Uytterhoeven (1):
      fbdev: Remove depends on HAS_DMA in case of platform dependency

Lubomir Rintel (1):
      pxa168fb: trivial typo fix

Noralf Trønnes (1):
      fbdev: fbcon: Fix unregister crash when more than one framebuffer

Peter Rosin (3):
      fbdev: fbmem: behave better with small rotated displays and many CPUs
      fbdev: fbmem: make fb_show_logo_line return the end instead of the height
      fbdev: fbmem: add config option to center the bootup logo

Rob Clark (1):
      fbdev: make FB_BACKLIGHT a tristate

Wen Yang (1):
      fbdev: fsl-diu: remove redundant null check on cmap

Yangtao Li (1):
      fbdev: omap2: omapfb: convert to DEFINE_SHOW_ATTRIBUTE

YueHaibing (1):
      video: fbdev: pxafb: Fix "WARNING: invalid free of devm_ allocated data"

 drivers/gpu/drm/nouveau/Kconfig             |  3 ++-
 drivers/video/fbdev/Kconfig                 |  5 ++--
 drivers/video/fbdev/clps711x-fb.c           |  5 +++-
 drivers/video/fbdev/core/fbcon.c            |  2 +-
 drivers/video/fbdev/core/fbmem.c            | 39 ++++++++++++++++++++++++-----
 drivers/video/fbdev/core/fbsysfs.c          |  8 +++---
 drivers/video/fbdev/fsl-diu-fb.c            |  3 +--
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 18 +++----------
 drivers/video/fbdev/pxa168fb.c              |  2 +-
 drivers/video/fbdev/pxafb.c                 |  4 +--
 drivers/video/fbdev/udlfb.c                 | 14 +++++------
 drivers/video/fbdev/uvesafb.c               |  2 +-
 drivers/video/logo/Kconfig                  |  9 +++++++
 include/linux/fb.h                          |  2 +-
 include/uapi/linux/fb.h                     |  2 --
 15 files changed, 71 insertions(+), 47 deletions(-)
