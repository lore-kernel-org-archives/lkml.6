Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF38C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C5D21550
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 09:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pAbsocBW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62C5D21550
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeJRR5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 13:57:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:58907 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbeJRR5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 13:57:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181018095716euoutp02eaed4a8fb6a5e565d27c908d9e1cc83c~eq3O_bHuA3210532105euoutp02r;
        Thu, 18 Oct 2018 09:57:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181018095716euoutp02eaed4a8fb6a5e565d27c908d9e1cc83c~eq3O_bHuA3210532105euoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539856636;
        bh=TO90AMWk3qukmEtJrXxlAxr9pF+bIgquT5/II9+8vu4=;
        h=From:To:Cc:Subject:Date:References:From;
        b=pAbsocBWOXUypQygQYM+50fu5HJUx26YNjxoCJGFG5cWj1oYoMnluTb49R24u2X6v
         Eaw32eiumKQUTNXmOTPEMC5aL67auU6FRdX5J2q/oAQbCsAzrWhclI5j+1G/azUKHO
         OKQdav6sOp51nft9sgVRAIysoTHrwfjPeFu+hRZM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095715eucas1p2561bf813dbcdf3301a03275c55dab76e~eq3OSyBSF2701327013eucas1p2d;
        Thu, 18 Oct 2018 09:57:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2B.D1.04294.BF858CB5; Thu, 18
        Oct 2018 10:57:15 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181018095714eucas1p2019a898487b589ff402b70fae42cabaa~eq3NVrM0P0201102011eucas1p2r;
        Thu, 18 Oct 2018 09:57:14 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-f1-5bc858fb80f6
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E8.C2.04128.AF858CB5; Thu, 18
        Oct 2018 10:57:14 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PGS00GLZGZA2H50@eusync3.samsung.com>;
        Thu, 18 Oct 2018 10:57:14 +0100 (BST)
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
        Inki Dae <inki.dae@samsung.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v4 0/6] Proper arch timer support for Exynos5433-based
 TM2(e) boards
Date:   Thu, 18 Oct 2018 11:57:02 +0200
Message-id: <20181018095708.1527-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBIsWRmVeSWpSXmKPExsWy7djPc7q/I05EGzT0cVlsnLGe1eL9sh5G
        i+tfnrNazPssazHp/gQWi/PnN7BbbHp8jdXi8q45bBYzzu9jslh75C67xd87/9gsll6/yGSx
        edNUZouXH0+wOPB5rJm3htFj06pONo871/awebw7d47dY/OSeo++LasYPT5vkgtgj+KySUnN
        ySxLLdK3S+DKmDppI3PBI56KeSuvsjcwLufqYuTkkBAwkfjX/oQZxBYSWMEo8fSnYRcjF5D9
        mVFi3oo9jDBFi3f8ZYVILGOUmLXpKBOE08AksXf/LjaQKjYBQ4mut11gtohAtkTn4weMIEXM
        AieZJf7d3MQOkhAWCJN49qcJqIiDg0VAVeLCTn6QMK+AjcSDZa+gtslLrN5wgBmkV0JgA5vE
        9P1tUAkXibN7GpkhbGGJV8e3sEPYMhKXJ3ezQDQ0M0q0z5jFDuH0MEpsnbODDaLKWuLw8Yus
        IDazAJ/EpG3TmUGukBDglehoE4Io8ZDYuWsDOyQwYiU+n9rAPIFRYgEjwypG8dTS4tz01GKj
        vNRyveLE3OLSvHS95PzcTYzA+D397/iXHYy7/iQdYhTgYFTi4X2QejxaiDWxrLgy9xCjBAez
        kghvtdmJaCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8y+ZtjBYSSE8sSc1OTS1ILYLJMnFwSjUw
        Tj5v/3+LzWfBqW0mB2Jqu3ftMK6feaHku7XzwnNhh+4ZCv50sPzb+eTj5do1IUvcpjiWeR6f
        77pAv+aGgbGL0be87R3vVCWdrwhF5FsVFOQmWQkYbPjZlmbY8uPoyrU51tEN7ze9Pdzxb6Hw
        JJ6vEx8yL40y2az89W75torNIkViQUGFqzc9U2Ipzkg01GIuKk4EAPQcoHjbAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsVy+t/xq7q/Ik5EG3S8EbXYOGM9q8X7ZT2M
        Fte/PGe1mPdZ1mLS/QksFufPb2C32PT4GqvF5V1z2CxmnN/HZLH2yF12i793/rFZLL1+kcli
        86apzBYvP55gceDzWDNvDaPHplWdbB53ru1h83h37hy7x+Yl9R59W1YxenzeJBfAHsVlk5Ka
        k1mWWqRvl8CVMXXSRuaCRzwV81ZeZW9gXM7VxcjJISFgIrF4x19WEFtIYAmjxNpmSwi7iUli
        7rZcEJtNwFCi620XG4gtIpAtMX9vN3sXIxcHs8BJZolLj9+xgCSEBcIkXh3bydjFyMHBIqAq
        cWEnP0iYV8BG4sGyV4wQu+QlVm84wDyBkWsBI8MqRpHU0uLc9NxiI73ixNzi0rx0veT83E2M
        wPDaduznlh2MXe+CDzEKcDAq8fA+SD0eLcSaWFZcmXuIUYKDWUmEt9rsRLQQb0piZVVqUX58
        UWlOavEhRmkOFiVx3vMGlVFCAumJJanZqakFqUUwWSYOTqkGxtATX9zSmI5//XbSe4LX3L9T
        fZcYvPw4u/3514btbkZRccvX77eKl61LFm3smc723aHysGF8+Bc9JaMHrGs1baJuvtx90/zQ
        5elNn25a82hezG31PxV//qrY0dbtfZ8efxfbY3xiPV9HebGEzpOIKZv8D1k9z74UE/zGfb7B
        KRXen9Uh3g82flRiKc5INNRiLipOBACZj+BYKwIAAA==
X-CMS-MailID: 20181018095714eucas1p2019a898487b589ff402b70fae42cabaa
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181018095714eucas1p2019a898487b589ff402b70fae42cabaa
References: <CGME20181018095714eucas1p2019a898487b589ff402b70fae42cabaa@eucas1p2.samsung.com>
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

v4:
- fixes lack of fixup in patch #3, pointed by Krzysztof Kozlowski

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

