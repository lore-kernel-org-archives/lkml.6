Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753126AbeBSPpL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:45:11 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56983 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753002AbeBSPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:45:06 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180219154502euoutp0144abec71fb87f5e6cf361f62693eea2e~UxJFW1V_J0858208582euoutp010
X-AuditID: cbfec7f2-1c1ff70000011644-44-5a8af0faa5e4
From: Maciej Purski <m.purski@samsung.com>
To: linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kamil Debski <kamil@wypas.org>, Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Thibault Saunier <thibault.saunier@osg.samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Hans Verkuil <hansverk@cisco.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH 0/8] Use clk bulk API in exynos5433 drivers
Date: Mon, 19 Feb 2018 16:43:58 +0100
Message-id: <1519055046-2399-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSe0hTYRjG+87d5eKwjL6sBg3KiG5GwVdGFBWcqFFUUFhmKw82crN2ZtqF
        1KCc09JmlkpFQmh5S9c0HeRlzmu4MTO1xBksIsuYZq7S1JzH/nve5/m97/d+8DK4zEoGM2qt
        ntdpVTEKSkJUNf9xrBsfNoZv9JXJ0IcyB4luO9owlDeYQqCKnBck6hrzUmj4bi5A3kIjhUwD
        mQTqqywn0ND3EgzZS99h6IvbRaDc1hQSZXi+4cjpLKdRx40hGpk93SQaSXeT6K31IYXSyytJ
        lOOsxZAt+zVATwY/EKjU3k+jAvNfDLna96LGoZkhU90VBMrJGqTQaL0J3ynn3na7cM7be5Pm
        7k1UkFxNXj/NmYtSKe6V7yPJDaS1YNzLp4mcJWPGv2MpAtyoWc512ZPpQ4Hhku1RfIz6Eq/b
        sOO05Jzlsw+/UByYYCg5ngQaA4wggIHsZjg5bsCMQMLI2GcA5pmrcbEYBbAmu4M2AmaWqs2S
        i34BgO8qPwGxmAbQbkrD/RDFroElKZH+qUFsM4CPaw74GZz10TBzvAH4g4VsGHzfN0T5NcGu
        hBmdE7hfS9ndsPOehxZXksP3jtTZLSBro2G+9TsmBntgT3cxIeqF8GuLZa5hGUw1NMwxV6Fr
        zEqJ+hpM7iufY8LgqMky+xjOLoCmqge4+DMpNNySiQgHPyY55/BdsK4nnfRrGRsBc5rGqEyw
        5AmYVwQW83GCJpoXQrV8/HpBpRHitNHrz8ZqzGDmot5MtfyoBmOdZ2yAZYAiUMr2G8NlpOqS
        cFljA5DBFUHSA70zljRKdfkKr4uN1MXF8IINLGUIxWLpqdXXw2VstErPn+f5C7zuf4oxAcFJ
        QPjjVoJq7/yEXEYv/EwzI+B1tsc7QgeWXIR6vXKVsy7qDFmXNbV/etXkck1sfZikVLjPLnoU
        X3YwMqJm+Fd2lRrmdo2fbMvfeqL9+fQ+9YhkWeLL0+4tK4ITdrce+x1xWJ3YtAnkKUP2mX5e
        L1wrZee7fmzTHs34FnJEKFZ6FIRwThW6BtcJqn9z8RJHTQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTcRjG/Z/7loPDsjoojRgYoeQFI/5hiVTCgUKKPhT7kI08qeR0bSpN
        imYXp/Myr+RGlJQXWt62aWWW2DS1oo2pDTfvLKPRTE1ciWJtRN9+z+95eL+8FCoswsKprJw8
        TpEjzRYTfOzj9ojzoH9FK4lbXYiF7g4bDits7xFo8GowaGroxOHE+jIBV6r1AC63aglYM1eF
        wameLgz6ltoQONT+GYHfZh0Y1I9qcKjzfEeh3d5Fwk+3fSQ0e5w4XC2fxeH4qwcELO/qwWGD
        vR+B1vo3ADZ63RhsH5ohYYt5C4GODylw0Bc4su00YbCh1kvAtYEaNFnEjjsdKLs8eY9k6zZN
        ONtrmCFZs7GUYF/453F2rmwEYS1Nt9huXcBXdhsBu2YWsRNDReSZUAn/aDqXnVXAKWKTLvEz
        u7/6Ufmz0OslbRfUYJCnBRTF0IeY/lqRFvApId0EGI2hHf0XihDGqZsggyOCjmLaNGlBH0YP
        A2Zh+gmuBTwKpbdIplItD/JOOpFxTfmIIGN0JKMb20SDLKBPMGN1HjLIDC1iXLZStArwG0GI
        EYRx+UpZhkwZH6OUypT5ORkxl3NlZhB4zPPhDctLMGY6ZwU0BcShAnpGKxHi0gKlSmYFDIWK
        wwSnJwNKkC5VFXKK3DRFfjantIIIChPvEdjjVBIhnSHN465ynJxT/G8RiheuBkhfgiftZ/TT
        mrsHVPd/xNGP+4/saFXM91GFxWbEcbN13f0Wt+9KsqwLZGrjo+l3+vN3jlX/+WIZSfEUn1xK
        vUIc/mXwVlAbZ1tOya0PmxMW9+GmyOO/XdduzNlSXycmTrv28kYTOqKTL4aYehWdzbvrW8rK
        Vv0D+ll3RMn+RVaMKTOl8VGoQin9C/3MRxSUAgAA
X-CMS-MailID: 20180219154456eucas1p178a82b3bb643028dc7c99ccca9c6eaca
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180219154456eucas1p178a82b3bb643028dc7c99ccca9c6eaca
X-RootMTR: 20180219154456eucas1p178a82b3bb643028dc7c99ccca9c6eaca
References: <CGME20180219154456eucas1p178a82b3bb643028dc7c99ccca9c6eaca@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

the main goal of this patchset is to simplify clk management code in
exynos5433 drivers by using clk bulk API. In order to achieve that,
patch #1 adds a new function to clk core, which dynamically allocates
clk_bulk_data array and fills its id fields.

Best regards,

Maciej Purski

Maciej Purski (8):
  clk: Add clk_bulk_alloc functions
  media: s5p-jpeg: Use bulk clk API
  drm/exynos/decon: Use clk bulk API
  drm/exynos/dsi: Use clk bulk API
  drm/exynos: mic: Use clk bulk API
  drm/exynos/hdmi: Use clk bulk API
  [media] exynos-gsc: Use clk bulk API
  [media] s5p-mfc: Use clk bulk API

 drivers/clk/clk-bulk.c                          | 16 +++++
 drivers/clk/clk-devres.c                        | 37 +++++++++--
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c   | 50 +++++----------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c         | 68 +++++++++-----------
 drivers/gpu/drm/exynos/exynos_drm_mic.c         | 44 +++++--------
 drivers/gpu/drm/exynos/exynos_hdmi.c            | 85 ++++++++-----------------
 drivers/media/platform/exynos-gsc/gsc-core.c    | 55 ++++++----------
 drivers/media/platform/exynos-gsc/gsc-core.h    |  2 +-
 drivers/media/platform/s5p-jpeg/jpeg-core.c     | 45 ++++++-------
 drivers/media/platform/s5p-jpeg/jpeg-core.h     |  2 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_common.h |  6 +-
 drivers/media/platform/s5p-mfc/s5p_mfc_pm.c     | 41 +++++-------
 include/linux/clk.h                             | 64 +++++++++++++++++++
 13 files changed, 263 insertions(+), 252 deletions(-)

-- 
2.7.4
