Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9649E21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 13:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gIO9puQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9649E21527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbeJQVhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 17:37:53 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeJQVhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 17:37:53 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017134206euoutp02319bac558511364ff81b80992e480874~eaSQScKsk1242412424euoutp02D;
        Wed, 17 Oct 2018 13:42:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017134206euoutp02319bac558511364ff81b80992e480874~eaSQScKsk1242412424euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539783726;
        bh=FmS+J3JJTvut009BxTrAFIqs4XPK8kZ4fZBFGNUBXtE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=gIO9puQdn75S6pzHCE1QTb4USisJuP3MV5j8Z640JVEfNIPy2Lub+AGZnlLuNNbFL
         o12g22nykwU3iFRcor8y0BvQyM7Yp5rUtrTz1BojsRAyhf2cXhnG4XmDMP7//OveGq
         KfR0qSasKsz3UqtUYT/KpVVQqFeW/AQcu0e/udfU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134205eucas1p115ab1b6990bc3654fdb5dcc9fadfd454~eaSP0jvTg1940619406eucas1p1K;
        Wed, 17 Oct 2018 13:42:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9B.4E.04441.D2C37CB5; Wed, 17
        Oct 2018 14:42:05 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181017134204eucas1p10d92a91f2b945afdc7b39ce6e7813a8e~eaSPGVt071609216092eucas1p16;
        Wed, 17 Oct 2018 13:42:04 +0000 (GMT)
X-AuditID: cbfec7f2-a1ae89c000001159-8d-5bc73c2dbdb3
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 37.22.04284.C2C37CB5; Wed, 17
        Oct 2018 14:42:04 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGQ001A0WQ1IZ80@eusync4.samsung.com>;
        Wed, 17 Oct 2018 14:42:04 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [PATCH v3 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
Date:   Wed, 17 Oct 2018 15:41:53 +0200
Message-id: <20181017134159.9656-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7djPc7q6NsejDV5NkrbYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mj592cJYMIOnYv/CJSwNjO84uxg5OSQETCT+7+hi7GLk4hASWMEosWnvWVYI5zOjxMpZ
        V1lgqh58+sUEkVjGKPH6xHaoqgYmie6Tl5lBqtgEDCW63naxgdgiAtkSnY8fMILYzAKLmCUO
        HBMGsYUFwiQunnkBNpVFQFWicx2EzStgI/Hu2XdmiG3yEqs3HGAGWSAhsIRNYsmk52wQCReJ
        zmdzoYqEJV4d38IOYctIdHYcZIJoaGaUaJ8xix3C6WGU2DpnB1S3tcTh4xdZIU7ik5i0bTrQ
        JA6gOK9ER5sQRImHxLkVT8BKhARiJY7eaWGdwCixgJFhFaN4amlxbnpqsWFearlecWJucWle
        ul5yfu4mRmDcnv53/NMOxq+Xkg4xCnAwKvHw7hA7Fi3EmlhWXJl7iFGCg1lJhLdK8Xi0EG9K
        YmVValF+fFFpTmrxIUZpDhYlcd5l8zZGCwmkJ5akZqemFqQWwWSZODilGhgVpmR63WDdNC3h
        eMj8lA0y+77/PNtw6tGSr+ksfnr2Cswzv0m+P2i4baZPD5OJyHkNblOxxNia2a7V97carAi/
        d9vg7YbM2k+MLF6b9V60Puji+fXq/ilmViW/tGDPS1uM5U7Jtk945TdVJ14nrG3Jgb/ZOb7z
        m/092K7cVM6fddKhOMjzlagSS3FGoqEWc1FxIgBxWbrd1wIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t/xa7o6NsejDW6etbDYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZbN40ldni
        5ccTLA68HmvmrWH02LSqk83jzrU9bB7vzp1j99i8pN6jb8sqRo/Pm+QC2KO4bFJSczLLUov0
        7RK4Mj592cJYMIOnYv/CJSwNjO84uxg5OSQETCQefPrF1MXIxSEksIRR4seOL1BOE5PEvVWb
        GEGq2AQMJbredrGB2CIC2RLz93azg9jMAkuYJW7edwCxhQXCJE7+vcsCYrMIqEp0rnsBZvMK
        2Ei8e/adGWKbvMTqDQeYJzByLWBkWMUoklpanJueW2yoV5yYW1yal66XnJ+7iREYWNuO/dy8
        g/HSxuBDjAIcjEo8vDvEjkULsSaWFVfmHmKU4GBWEuGtUjweLcSbklhZlVqUH19UmpNafIhR
        moNFSZz3vEFllJBAemJJanZqakFqEUyWiYNTqoFxouqeSdy1PVyTfsRHsJy9t0iy9MPbLWb3
        hGQr7m5o3/MhutlVavUWGRmt+z+jj3gnnv24+kK9XcnsyUfsBK1Oqyy02prBd0bo7hcWh18t
        ec0WfxTdN5x0mf0+4E/E4WuF+2dYOmtorT39Y9JBRp2VeWFz6ja7uW5+PvllllT19/mhkiGb
        CgsPK7EUZyQaajEXFScCAJF4+DAoAgAA
X-CMS-MailID: 20181017134204eucas1p10d92a91f2b945afdc7b39ce6e7813a8e
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181017134204eucas1p10d92a91f2b945afdc7b39ce6e7813a8e
References: <CGME20181017134204eucas1p10d92a91f2b945afdc7b39ce6e7813a8e@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

This patchset is an attempt to submit the last piece of missing code
to have proper support for Exynos5433 SoCs based TM2(e) boards. It
performs a cleanup of timer configuration, which so far needed various
out-of-tree workarounds. The fixes provided by this patchset are also
needed for add proper support for system suspend/resume.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


Changelog:

v3:
- added patch, which splits resources and interrupts allocation
- simplified arch timer cooperation mode
- dropped CPU hotplug priority change patch, it is not really needed
- removed more non-dt dead code

v2:
- dropped arch timer patch, it will be discussed separately
- fixed issues pointed by Krzysztof Kozlowski

v1: https://patchwork.kernel.org/project/linux-samsung-soc/list/?series=27965&state=*&archive=both
- initial version


Patch summary:

Marek Szyprowski (6):
  clocksource: exynos_mct: Remove dead code
  clocksource: exynos_mct: Fix error path in timer resources
    initialization
  clocksource: exynos_mct: Refactor resources allocation
  clocksource: exynos_mct: Add arch_timer cooperation mode for ARM64
  arm64: dts: exynos: Move arch-timer node to right place
  arm64: platform: Add enable Exynos Multi-Core Timer driver

 arch/arm64/Kconfig.platforms               |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 23 +++---
 drivers/clocksource/exynos_mct.c           | 81 ++++++++++++++--------
 3 files changed, 67 insertions(+), 38 deletions(-)

-- 
2.17.1

