Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA21FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635FA208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rw+xit24"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 635FA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937431AbeFSIUI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:20:08 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44889 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756206AbeFSIUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:20:02 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180619081958euoutp02c991dc5ccfb7960ba57f6a96e23a82e4~5gev1jGTu1395713957euoutp02R;
        Tue, 19 Jun 2018 08:19:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180619081958euoutp02c991dc5ccfb7960ba57f6a96e23a82e4~5gev1jGTu1395713957euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529396398;
        bh=VBVIK88+OALMYCuqaUeRdLnvZO3K69bT5Y14ljcQ+LM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Rw+xit24qKAM3FlWd+fPeY3D2c5357mFosaWkAGMzg0Jg3W8cQdpS0i1nodZysB2q
         lmAkIVMuwLNquQzwCMS4o7PsdcW9xH3gKC/1Hv5XOqmSkYOR9ZzimSofLmP2uUwH5s
         takmQ1NoHMdsG0FatB8YzWGWqCfSjH9tZq/FVCtU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619081958eucas1p1cb350921de2bee54c8e5c05a1669b9e2~5geu-7rkk0546305463eucas1p1O;
        Tue, 19 Jun 2018 08:19:58 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4A.79.17380.DACB82B5; Tue, 19
        Jun 2018 09:19:57 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180619081956eucas1p1de0ce0c89abdbf021c9942a2af39fe52~5get4Trfw0261802618eucas1p1W;
        Tue, 19 Jun 2018 08:19:56 +0000 (GMT)
X-AuditID: cbfec7f4-b4fc79c0000043e4-cb-5b28bcadd47e
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 27.56.04178.CACB82B5; Tue, 19
        Jun 2018 09:19:56 +0100 (BST)
Received: from AMDC2075.DIGITAL.local ([106.120.51.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PAK00EJ59T2RV00@eusync4.samsung.com>;
        Tue, 19 Jun 2018 09:19:56 +0100 (BST)
From:   Maciej Purski <m.purski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Purski <m.purski@samsung.com>
Subject: [PATCH v3 0/9] Add TOSHIBA TC358764 DSI/LVDS bridge driver
Date:   Tue, 19 Jun 2018 10:19:21 +0200
Message-id: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSbUhTURzGO7v3btfR4jItD1Z+GIRL0960DiQRNOl+KYy+uVKnXlR00za1
        zCizTKdoNiuXlZOcZsOXtqmpK/ENh6YzWZlapmb4biG+IdqLbvPbc87z/DjP/88hMf467kZG
        yxIYuUwSK2Bz8bqONYt35Tuh+MhAtgANVVkIlGPpZKG0zHkC6dXVBNK0b959Wv7NRqqRPBxN
        fe/D0YPxWQz19r7hoJ60OQ5SPtRykGG8n0DWxudspO5tYqHi6SEcVbYPc1Dplz4WSn/fzkHq
        /Gk2Wmssws/spiuKKgBtzc1h0Q2Fwxz6WeZTgjbolGz67cooQY9km1m0UXubzq3RAXrR4B7I
        DeL6RzCx0UmM/PDpUG7UlNaExf/ac/1rXjFIBaX8LOBEQsoXTkyOYFmAS/KpcgBnHjUB+2ER
        wD8vO1nbqZ7sEodRBqBpsNBm8Kl/AD7XBmcBkmRTnrAiI2Qr40LpADQOzNsAjHpMwI+aWWIL
        cKbOwoLyLhuMUwdgS1EttqV5lAg2lNQ7XnOHgxalrROk1tlQ3zmK2Q0R1K2qOHbtDGfMNQ69
        DyozWxxwCnw9/Qq3w6kALg1bHfAp2Gbus7XAqF1QVVeAbdWGFA9m3ncsg4bG0mnHZFfgerce
        5AFYDHbogCuTqJBGMopjMuaaj0IiVSTKIn3C46QGsPklPvw1L9WDxo2wVkCRQLCTJ6z2EPMJ
        SZIiWdoKIIkJXHi1pUIxnxchSb7ByONC5ImxjKIV7CVxgSsvWHgriE9FShKYGIaJZ+TbLot0
        cksFNw1i77Kuk5F+IdHdLqN96WaLXhTF90hZKLszO/Y5Jz/DYn3ROeHFjYjhPrl4ri1NdejS
        wiR+UHbc1MyO9fBZ3P+t525/lUaib3afo51HcIHQGPYznaVuxlf9L3RcFVv9lr3W++l7oh/+
        AaaVy55O531dNGOtAUGBJ7CN0HCtAFdESY56YnKF5D/FJVOADgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsVy+t/xa7pr9mhEG8zbo29xa905VovecyeZ
        LJo63rJabJyxntVi/hGg2JWv79ksJt2fwGLx4t5FFov+x6+ZLc6f38BucbbpDbtF58Ql7Bab
        Hl9jtbi8aw6bxYzz+5gsFry8xWKx9shddoul1y8yWbTuPcJuMWPySzaLn7vmsTiIeqyZt4bR
        43JfL5PHzll32T1md8xk9di0qpPNY/u3B6we97uPM3lsXlLv0bdlFaPH501yAVxRXDYpqTmZ
        ZalF+nYJXBkvluxmLngnVnF7wgLGBsalQl2MnBwSAiYSZ7sXM3YxcnEICSxhlJg7Zyo7SEJI
        oJFJYt0r1S5GDg42AS2JNe3xIDUiAqsYJab+vcMO4jALzGaVePVoAiNIg7CAs8T0FaeYQGwW
        AVWJg/O2MoPYvAIuEjsX72CC2CYncfNcJ/MERq4FjAyrGEVSS4tz03OLDfWKE3OLS/PS9ZLz
        czcxAgN527Gfm3cwXtoYfIhRgINRiYe3YaN6tBBrYllxZe4hRgkOZiUR3q1LNaKFeFMSK6tS
        i/Lji0pzUosPMUpzsCiJ8543qIwSEkhPLEnNTk0tSC2CyTJxcEo1MNZtnrjn0mLWd49YfSfG
        3tsaYhMtf/tpRJLItaNLMnMFNiY2lfmutfKYv2TzIuY1X8O97krtsquZzP8mpvcTD4/4K513
        L1nfS38M5dDawO2yMnL16uUK170S1DQmR0XzPvRblNuR+K4gnLUmKKjSwqmyrJ3pd9baONUH
        1048eXHiiO6RV55HPZRYijMSDbWYi4oTAfI0JlBgAgAA
X-CMS-MailID: 20180619081956eucas1p1de0ce0c89abdbf021c9942a2af39fe52
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180619081956eucas1p1de0ce0c89abdbf021c9942a2af39fe52
References: <CGME20180619081956eucas1p1de0ce0c89abdbf021c9942a2af39fe52@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this patchset is a next attempt to add the tc358764 driver.
The previous one can be found here:

https://lists.freedesktop.org/archives/dri-devel/2014-February/053705.html

Back then, TC358764 was added as a panel driver.

The bridge is supposed to be a DSI peripheral. Currently exynos_dsi accepts only panels
as its peripherals. Therefore, some logic in exynos_dsi had to be ammended. That is implemented
in first 3 patches.

Apart from the driver this patchset adds support for BOE HV070WSA-100 panel, which is used by
TC358764 and dts nodes to exynos5250.dtsi and exynos5250-arndale.dtsi.

Best regards,

Maciej Purski

---

Changes in v3:
- call drm_bridge_enable() and drm_bridge_pre_enable() in exynos_drm_dsi_enable()
  and make the bridge invisible for the framework in order to prevent it from
  being enabled by the framework
- expand panel binding description
- fix tc358744 binding, make port 1 mandatory and port 0 optional
- get rid of useless select VIDEOMODE_HELPERS in bridge Kconfig
- add missing SPDX license to drm/bridge/tc358764.c
- use mipi_dsi_generic_read() and mipi_dsi_generic_write() helpers
  in toshiba driver's read, write functions
- fix commit messages

Changes in v2:
- fix commits authorship
- don't call pm_runtime_put_sync() in exyons_dsi_disable(), if pm_runtime_get_sync()
  has not been called
- squash dts commits
- merge some redundant regulators in tc358764 bindings and in DTS
- fix kbuild robot errors

Andrzej Hajda (6):
  dt-bindings: display: add DT bindings for BOE HV070WSA-100 panel
  drm/panel: add support for BOE HV070WSA-100 panel to simple-panel
  dt-bindings: tc358754: add DT bindings
  drm/bridge: tc358764: Add DSI to LVDS bridge driver
  ARM: dts: exynos5250: add DSI node
  ARM: dts: exynos5250-arndale: add DSI and panel nodes

Maciej Purski (3):
  drm/exynos: rename "bridge_node" to "mic_bridge_node"
  drm/exynos: move connector creation to attach callback
  drm/exynos: enable out_bridge in exynos_dsi_enable()

 .../bindings/display/bridge/toshiba,tc358764.txt   |  35 ++
 .../bindings/display/panel/boe,hv070wsa-100.txt    |  28 ++
 arch/arm/boot/dts/exynos5250-arndale.dts           |  61 +++
 arch/arm/boot/dts/exynos5250.dtsi                  |  21 +
 drivers/gpu/drm/bridge/Kconfig                     |   8 +
 drivers/gpu/drm/bridge/Makefile                    |   1 +
 drivers/gpu/drm/bridge/tc358764.c                  | 521 +++++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |  88 ++--
 drivers/gpu/drm/panel/panel-simple.c               |  25 +
 9 files changed, 755 insertions(+), 33 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/boe,hv070wsa-100.txt
 create mode 100644 drivers/gpu/drm/bridge/tc358764.c

-- 
2.7.4

