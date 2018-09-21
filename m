Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808ADECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 328F02154D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 12:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fW1cpt7O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 328F02154D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389892AbeIUSOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 14:14:50 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:47656 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389835AbeIUSOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 14:14:50 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180921122609euoutp021c02fc8ecb7d7850ce5790a086542b3f~Waehrqc6W2161621616euoutp02v
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 12:26:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180921122609euoutp021c02fc8ecb7d7850ce5790a086542b3f~Waehrqc6W2161621616euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1537532769;
        bh=qNeEP+7HXq9SGE+CjBE6vlpUiMCq7UfYYHsClMC0LFk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=fW1cpt7Ocq8Lgw3P/69fcloomrWujslw5lXw5Sb3j2x7+ryRYNBSgJ9iMQsPhPXZO
         D3zrSqdTdjw2Rms8WUDk8R4HtYqp8c+kQBon5zbGBvZ9Aw/r+jRBbrvpB0Q+qduOHZ
         tcuJWEGfi6LtUn7yUuF3GMkkXNJxiZLXZ4SX+Tek=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180921122608eucas1p1d539d21124d479810ea7ce3a37c85442~Waegg55510407704077eucas1p1S;
        Fri, 21 Sep 2018 12:26:08 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BE.7A.04806.063E4AB5; Fri, 21
        Sep 2018 13:26:08 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b~WaefRJq8x0332003320eucas1p1W;
        Fri, 21 Sep 2018 12:26:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180921122606eusmtrp1e8cdc647be8fb08c25b10a0e686c7159~Waee-EYlQ2872728727eusmtrp17;
        Fri, 21 Sep 2018 12:26:06 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-64-5ba4e360be09
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 41.69.04284.E53E4AB5; Fri, 21
        Sep 2018 13:26:06 +0100 (BST)
Received: from AMDC2034.DIGITAL.local (unknown [106.120.51.41]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180921122606eusmtip1b5f5ca0078fcfe949b292c51c99d161e~WaeeRnRNy2133221332eusmtip1Y;
        Fri, 21 Sep 2018 12:26:06 +0000 (GMT)
From:   Christoph Manszewski <c.manszewski@samsung.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Christoph Manszewski <c.manszewski@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: [PATCH 0/3] drm/exynos: mixer: Cleanup and add properties 
Date:   Fri, 21 Sep 2018 14:24:35 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSbUhTYRjtvV+7jmbXKfqmIbLKUkot0y4Zkmi4fgT9TYtceVNzm7KrS6XQ
        CiNvmVMTJTQSDU3xa/OLiZKfU8yNLMQsM1sw01bQnH2g0rar9e885znnPeeBl0TFNbgvmabM
        YlRKmVxCCLHusd+mw0nm+sSw1kUhPddqxOli4wRCd1S14bSh7xmg39i/E3TZggajlz68wugS
        8wpKm0ztAnrq9lcBrTXP4PRrfTVBV5kGELplZF5AV5V/IU7tkmqbighpz9pHXLpw34BIdfX5
        0oedTUBq0/qfIxKEJ5MZeZqaUYVGJwlTOVM1kmkmcqwWC1IAJnAOuJGQOgaLp7sRDghJMdUI
        4JyxbGtYBfD58DecH2wAzrduINsW+3oNwS8aABxtfYn/s9RWlBJOFUFFwHfzP1zYi9oLN0qb
        gFOEUl0Y7J+YdT3lScXCDavV1QSj9sPJT/0EH+EP3xqLUKcBUuUCWN0+hzoXIkoNdY+sW9Xj
        4C3DMMpjT7hs6BTweA+cLH+A8eY7jpNWZ3B+0AA42MxhvCoKameXHTVIR6cg2KYP5ekYqOPe
        u2hIucNZq4eTRh2wrLsS5WkRvHdXzKsD4UpnJ7Edu2SzAx5LYYduxHWjmLoIm/80ohrg//h/
        1lMAmoAPk80qUhg2XMlcD2FlCjZbmRJyJUOhBY5PM7lpsPeCgfXLQ4AigWSnKKyuLlGMy9Rs
        rmIIQBKVeIkGuPpEsShZlpvHqDIuqbLlDDsE/EhM4iNyD76aKKZSZFlMOsNkMqrtLUK6+RaA
        FznDmT9tlkh5TFAs6Jk7Gumed7C2ML56fPNAvCL/zMKNwc+kckcCFW4LUI6NcmeXnkzdTK8L
        ZE8Haqb7Rrh94wFRDQnnDS2Veq9eM+FRqEtdy2Abji9WdJ2IYBZHfYtKYn4d8jPWe2vQlgsW
        9W69XWEvjov2Lr6Wq6ppiJuWYGyq7EgwqmJlfwGs4ZeUMAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsVy+t/xu7pxj5dEG6x+YWBxa905VovecyeZ
        LDbOWM9qcXz3UkaLK1/fs1lMuj+BxeLFvYssFv2PXzNbnD+/gd3ibNMbdotNj6+xWlzeNYfN
        Ysb5fUwWa4/cZbeYMfklmwO/x6ZVnWwe2789YPW4332cyWPzknqPvi2rGD0+b5ILYIvSsynK
        Ly1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy+g6P4ep4DFb
        xdvnz5kaGE+ydjFyckgImEh8/TOXrYuRi0NIYCmjxN+uYywQCRmJeWf72CBsYYk/17qgij4x
        Shzb+h4swSZgKnH77icwW0RAWeLvxFWMIEXMAgdZJFo2nmEESQgLOEv8ffsWbB2LgKrE6Ud7
        wRp4BdwlGhcsgNogJ3HzXCfzBEaeBYwMqxhFUkuLc9Nziw31ihNzi0vz0vWS83M3MQLDe9ux
        n5t3MF7aGHyIUYCDUYmH12Dx4mgh1sSy4srcQ4wSHMxKIrz7upZEC/GmJFZWpRblxxeV5qQW
        H2I0BVo+kVlKNDkfGHt5JfGGpobmFpaG5sbmxmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4
        pRoYmYMX7BLIFA5xZL8VkxPQZTLJcIPj63X++RF1Ryp2aV10XlH0NtplDiML8/c9gQr1+5kd
        haWFmPlspm+Jk9BVlQkw/6Tad+OC5EuzzbzvjqjN38VySWD5rOJkk/+PT8syC7yLWb70IEvf
        fL1Hu9TdLtuy1c6YmNE8myNo0aI9eULP3vn027YpsRRnJBpqMRcVJwIAYQPB94UCAAA=
Message-Id: <20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b~WaefRJq8x0332003320eucas1p1W@eucas1p1.samsung.com>
X-CMS-MailID: 20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b
References: <CGME20180921122607eucas1p1d8d56bd57fcfc8285469208b1db3fa3b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds two new configurable properties to exynos_mixer,
and introduces use of helper functions in exynos_drm_plane_reset.

Patch 1 incorporate use of helper functions, to correctly initialize
parameters used in following patches.
Patch 2 add pixel blend mode property.
Patch 3 add window alpha property.

Regards,
Chris

Christoph Manszewski (3):
  drm/exynos: drm_plane: Correct exynos_drm_plane_reset
  drm/exynos: mixer: Make pixel blend mode configurable
  drm/exynos: mixer: Make plane alpha configurable

 drivers/gpu/drm/exynos/exynos_drm_drv.h   |  2 ++
 drivers/gpu/drm/exynos/exynos_drm_plane.c | 16 ++++++---
 drivers/gpu/drm/exynos/exynos_mixer.c     | 56 +++++++++++++++++++++----------
 drivers/gpu/drm/exynos/regs-mixer.h       |  5 ++-
 4 files changed, 57 insertions(+), 22 deletions(-)

-- 
2.7.4

