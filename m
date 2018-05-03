Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751166AbeECIZ4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 04:25:56 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:42914 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeECIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 04:24:20 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180503082418epoutp01b7926258bc1258e9b8365845123e4c45~rFOG5I6Zk0200402004epoutp01H
X-AuditID: b6c32a4b-185ff70000001094-3d-5aeac732d6ab
From: Satendra Singh Thakur <satendra.t@samsung.com>
To: linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Cc: madhur.verma@samsung.com, hemanshu.s@samsung.com,
        Satendra Singh Thakur <satendra.t@samsung.com>
Subject: [PATCH 00/13] drm/kms/mode: using helper func
 drm_display_mode_to/from_videomode for calculating timing parameters
Date: Thu,  3 May 2018 13:53:55 +0530
Message-Id: <cover.1525087679.git.satendra.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmpq7R8VdRBjt/81hc+fqezeLV+TfM
        Fgtmc1tsenyN1eLyrjlsFpebLzJazDi/j8mi88ssNovDU5ewWaw938riwOVxv/s4k8fmJfUe
        fVtWMXp83iQXwBKVapORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+Ti
        E6DrlpkDdI6SQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp2tDQSM/QwFzPyMhIz8Q01srI
        FKgkITVjxXT/guUyFcsX7GJpYOwU72Lk5JAQMJG4MvsRexcjF4eQwG5GiZ/vH7JBOJ8YJXon
        7GGFcL4xSuz93c0E07J4yy5GiMReRonZJ3qhnK+MEpdaNjODVLEBVT2fMwOsXUTgC6PEtcW/
        WUESzAJpEh//vATayMEhLFArseSIEUiYRUBVouffSbBeXgFLiX9rl7JAbJOTuHmukxlkjoTA
        FDaJOWd/MEIkXCR2bmxjhrCFJV4d38IOYUtJfH63lw2ioZlR4sG6hewQTg+jREfnMagqe4mW
        KQdYQK5gFtCUWL9LHyJsK/Flfj8zxKF8Er2/nzCBlEgI8Ep0tAlBlKhIrHxxmBlm158FXawQ
        todE675ZbBC2o8Tpde/A7hQSiJXYO30dywRGuVkIyxYwMq5ilEwtKM5NTy02LTDOSy3XK07M
        LS7NS9dLzs/dxAhObFreOxg3nfM5xCjAwajEw3vg7MsoIdbEsuLK3EOMEhzMSiK8U7pfRQnx
        piRWVqUW5ccXleakFh9iNAWG5kRmKdHkfGDSzSuJNzSxNDAxMzM3NDCwNFES57158l6UkEB6
        YklqdmpqQWoRTB8TB6dUA6MTz6NwgSDm97rfUi1t5N63bCnu+y69p11QIOdSyfq+rvoKt3vP
        5R0Fk6JM6+W8eG+4izUozrb7+NjmWKT8khhh8/oXzuvOlNcvFhDxLNtu/+xc1PKwhM6fa5Yt
        /K/Fcp9H+5J5beWXuO8xGwUazhRfZLJfI8kw+8Jt+3MKCesmK01xbipSUWIpzkg01GIuKk4E
        ANQmR2WCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSvK7h8VdRBo+OyFtc+fqezeLV+TfM
        Fgtmc1tsenyN1eLyrjlsFpebLzJazDi/j8mi88ssNovDU5ewWaw938riwOVxv/s4k8fmJfUe
        fVtWMXp83iQXwBLFZZOSmpNZllqkb5fAlbFiun/BcpmK5Qt2sTQwdop3MXJySAiYSCzesoux
        i5GLQ0hgN6PEldZ9rBAJKYllb7axQdjCEiv/PWcHsYUEPjNKfJvkD2KzATU/nzODFaRZROAX
        o8SmOZfAGpgFMiQuHn3JBGILC1RL7G3YwAhiswioSvT8O8kMYvMKWEr8W7uUBWKBnMTNc53M
        Exh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA4qLa0djCdOxB9iFOBgVOLh
        PXD2ZZQQa2JZcWXuIUYJDmYlEd4p3a+ihHhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJI
        TyxJzU5NLUgtgskycXBKNTBWV91bmCA3PWnJXcVv9UdY15yVuLpo+0rmdV7xMt6zWP/Oypm8
        b9rZpOWMc84ejFIKMJf33fGqVkrlYmzw1aV7Vkuo1ilx3XQ/lvXoctb/v66/9/hmpVpnTnO2
        YnmWL3zg3zKrzQ0KPzb9fTBl/dMdGT9S+zQnFGYuZ/sfFzJ3nfvPVfNWTehap8RSnJFoqMVc
        VJwIABd3CpwmAgAA
X-CMS-MailID: 20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-MTR: 20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1
X-RootMTR: 20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1
References: <CGME20180503082417epcas5p19ee919d68eb5ae18f183a41881869cc1@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.There is a function in drm-core to calculate display timing parameters:
horizontal front porch, back porch, sync length,
vertical front porch, back porch, sync length and
clock in Hz.
However, some drivers are still calculating these parameters themselves.
Therefore, there is a duplication of the code.
This patch series replaces this redundant code with the function
drm_display_mode_to_videomode.
This removes nearly 100 redundant lines from the related drivers.
2.For some drivers (sun4i) the reverse helper
drm_display_mode_from_videomode is used.
3.For some drivers it replaces arithmatic operators (*, /) with shifting
operators (>>, <<).
4.For some drivers DRM_MODE_FLAG_* are replaced with DISPLAY_FLAGS_* flags.
5.These changes apply to following crtc and encoder drivers:
atmel-hlcdc
bridge-tc358767
exynos-dsi
fsl-dcu
gma500-mdfld_dsi_dpi
hisilicon-kirin_dsi, ade
meson-encoder
pl111-display
sun4i-tv
ti lcdc
tegra dc
mediatek dpi dsi
bridge-adv7533

Satendra Singh Thakur (13):
  drm/kms/mode/atmel-hlcdc: using helper func
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/bridge-tc358767: using helper func
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/exynos-dsi: using helper func
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/fsl-dcu: using helper func drm_display_mode_to_videomode 
       for calculating timing parameters
  drm/kms/mode/gma500-mdfld_dsi_dpi: using helper function
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/hisilicon-kirin-dsi-ade: using helper function    
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/meson-encoder: using helper function
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/pl111-display: using helper function
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/sun4i-tv: using helper func
    drm_display_mode_from_videomode for calculating timing
    parameters
  drm/kms/mode/ti-lcdc: using helper func drm_display_mode_to_videomode 
       for calculating timing parameters
  drm/kms/mode/tegra: using helper func drm_display_mode_to_videomode
    for calculating timing parameters
  drm/kms/mode/mtk_dpi_dsi: using helper func
    drm_display_mode_to_videomode for calculating timing parameters
  drm/kms/mode/bridge-adv7533: using helper func
    drm_display_mode_to_videomode for calculating timing parameters

 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    |  28 +++--
 drivers/gpu/drm/bridge/adv7511/adv7533.c        |  35 +++---
 drivers/gpu/drm/bridge/tc358767.c               |  42 +++----
 drivers/gpu/drm/exynos/exynos_drm_dsi.c         |   9 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c      |  29 ++---
 drivers/gpu/drm/gma500/mdfld_dsi_dpi.c          |  28 ++---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c    |  42 ++++---
 drivers/gpu/drm/hisilicon/kirin/kirin_drm_ade.c |  52 +++------
 drivers/gpu/drm/mediatek/mtk_dpi.c              |  60 +++++-----
 drivers/gpu/drm/mediatek/mtk_dsi.c              |  14 +--
 drivers/gpu/drm/meson/meson_venc.c              | 149 +++++++++++-------------
 drivers/gpu/drm/pl111/pl111_display.c           |  40 +++----
 drivers/gpu/drm/sun4i/sun4i_tv.c                |  67 ++++-------
 drivers/gpu/drm/tegra/dc.c                      |  15 ++-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c            |  60 +++++-----
 15 files changed, 280 insertions(+), 390 deletions(-)

-- 
2.7.4
