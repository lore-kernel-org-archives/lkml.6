Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA51C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBA3020823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ldltjvKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfARMiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:38:50 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47961 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbfARMit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:38:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190118123847euoutp01b498990d22ad9051956af068b7858e48~68ahpRrYM3016330163euoutp018
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 12:38:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190118123847euoutp01b498990d22ad9051956af068b7858e48~68ahpRrYM3016330163euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547815127;
        bh=0Nlffo9/9fLiiva6jOfcHNyWlIzNzlAYadPT8KNkglA=;
        h=To:Cc:From:Subject:Date:References:From;
        b=ldltjvKrGMlRsFf6TtZH1rZt/LulRZyERVa7MmG/CkHZnXA/4JH+6YzSV8PKTA7DR
         oiyhHZtFxvjd1XFnYqxDTluEnZ9QP4F+sqCCY083aO8L3q1/3jMHSPcWF2EqG1PBZG
         8ELCGXoxPrMZS7wKiZ/yuMWzyedzkVHCG2NrlcmQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190118123847eucas1p28de0c7f237def5de1d7c25edbfe630c2~68ahPvbbN0733907339eucas1p2g;
        Fri, 18 Jan 2019 12:38:47 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 18.DF.04294.6D8C14C5; Fri, 18
        Jan 2019 12:38:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190118123845eucas1p25b20e2175991a620437c338a0001f03a~68agLKyRk0733107331eucas1p2d;
        Fri, 18 Jan 2019 12:38:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190118123845eusmtrp258861f293db19d283c8d45ced43dc046~68af8jS1V1608016080eusmtrp2e;
        Fri, 18 Jan 2019 12:38:45 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-dc-5c41c8d6c79d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.90.04128.5D8C14C5; Fri, 18
        Jan 2019 12:38:45 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190118123845eusmtip2804082441d44cf6c3b57d4118a74034a~68afqRqU70627506275eusmtip2C;
        Fri, 18 Jan 2019 12:38:45 +0000 (GMT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev fixes for v5.0-rc3
Message-ID: <2bb72d22-590c-958f-1dd1-fe44f264091b@samsung.com>
Date:   Fri, 18 Jan 2019 13:38:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned1rJxxjDD5sMbG48vU9m8WJvg+s
        Fpd3zWGzeNT3lt2BxePEjN8sHve7jzN5fN4kF8AcxWWTkpqTWZZapG+XwJWx/sY5loIJfBUP
        D7czNTB+4+pi5OSQEDCR2HlkLVsXIxeHkMAKRokPfTOZIZwvjBJHnh9hhXA+M0o8P/+UFabl
        zswjTBCJ5YwSn2behHLeM0oc3LkQrEpEwEji84srYDazQILEl5ufmUFsNgEriYntqxhBbGEB
        HYknK26A1fAK2EncvzEFzGYRUJU43LYd6CgODlGBCIn+M+oQJYISJ2c+YYEYKS+x/e0csFMl
        BJ6zSUzZtZwZ4joXiaMvf7FB2MISr45vYYewZST+75zPBNEwnVHiza+lLBDOekaJNWeOMUFU
        WUscPn6RFWQzs4CmxPpd+hBhR4lHR+cxgYQlBPgkbrwVhDiCT2LStunMEGFeiY42IYhqNYkN
        yzawwazt2rkS6jQPidU3toC9LiQQK9EwdyXbBEaFWUhem4XktVkINyxgZF7FKJ5aWpybnlps
        lJdarlecmFtcmpeul5yfu4kRmDpO/zv+ZQfjrj9JhxgFOBiVeHgnbHGIEWJNLCuuzD3EKMHB
        rCTCy7XCMUaINyWxsiq1KD++qDQntfgQozQHi5I4bzXDg2ghgfTEktTs1NSC1CKYLBMHp1QD
        4yy2OYdEO6q7/3As3DA5TyTmuxnH/pdea9rCL+fofbO4X/L1+2b9p3uEd0tvNF3P4HyhzPvi
        tQ2Cs+8tVEp5sJsnWHnPhx8Vdk+N9R682PP+RR+/xO/Cy8lBH58cv/KJdeLc2VHHfe9E5csF
        /9z3dNoFmUun5Oa9q+OOqC89HsViG7zqUbXovxAlluKMREMt5qLiRAAxuWDaGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7pXTzjGGGzeomlx5et7NosTfR9Y
        LS7vmsNm8ajvLbsDi8eJGb9ZPO53H2fy+LxJLoA5Ss+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLP
        yMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j/Y1zLAUT+CoeHm5namD8xtXFyMkhIWAicWfm
        EaYuRi4OIYGljBLbZq1j62LkAErISBxfXwZRIyzx51oXG0TNW0aJk8svMIEkRASMJD6/uMIK
        YjMLJEhsuj+VDcRmE7CSmNi+ihHEFhbQkXiy4gZYDa+AncT9G1PAbBYBVYnDbdvB6kUFIiRu
        PexggagRlDg58wkLxEx1iT/zLjFD2PIS29/OYZ7AyD8LSdksJGWzkJQtYGRexSiSWlqcm55b
        bKRXnJhbXJqXrpecn7uJERjg24793LKDsetd8CFGAQ5GJR7eF9scYoRYE8uKK3MPMUpwMCuJ
        8HKtcIwR4k1JrKxKLcqPLyrNSS0+xGgKdPhEZinR5Hxg9OWVxBuaGppbWBqaG5sbm1koifOe
        N6iMEhJITyxJzU5NLUgtgulj4uCUamCs1Tq7ck/3keTgFqv/Ld97nQ70F1Q+ev3GKzP/3anV
        043r3lS+Nzt1meWh2w0302z5R4dnWactm/G/a/sEl/0ztNmPtjzIOqsxW1bcv2vPYbPD4Vvq
        212/fdwnv/Ptsu2Lzn3/Fx80s3zzF543YdZne1Z0HbDoiUt2kF8qvGv2a94ezfPP5CMWKLEU
        ZyQaajEXFScCAI8kMXiGAgAA
X-CMS-MailID: 20190118123845eucas1p25b20e2175991a620437c338a0001f03a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190118123845eucas1p25b20e2175991a620437c338a0001f03a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190118123845eucas1p25b20e2175991a620437c338a0001f03a
References: <CGME20190118123845eucas1p25b20e2175991a620437c338a0001f03a@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev fixes for v5.0-rc3 (please see the signed tag
description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 399382f8018204407174f0229b4087d40e1cdc82:

  drm/nouveau: fix incorrect FB_BACKLIGHT usage in Kconfig (2019-01-02 18:47:37 +0100)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.0-rc3

for you to fetch changes up to 890d14d2d4b57ff5a149309da3ed36c8a529987f:

  fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line option (2019-01-16 17:42:35 +0100)

----------------------------------------------------------------
fbdev fixes for v5.0-rc3:

- fix stack memory leak in omap2fb driver (Vlad Tsyrklevich)

- fix OF node name handling v4.20 regression in offb driver (Rob Herring)

- convert CONFIG_FB_LOGO_CENTER config option added in v5.0-rc1 into
  a kernel parameter (Peter Rosin)

----------------------------------------------------------------
Peter Rosin (1):
      fbdev: fbmem: convert CONFIG_FB_LOGO_CENTER into a cmd line option

Rob Herring (1):
      fbdev: offb: Fix OF node name handling

Vlad Tsyrklevich (1):
      omap2fb: Fix stack memory disclosure

 Documentation/fb/fbcon.txt                      |  8 ++++++++
 drivers/video/fbdev/core/fbcon.c                |  7 +++++++
 drivers/video/fbdev/core/fbmem.c                | 19 ++++++++++---------
 drivers/video/fbdev/offb.c                      | 18 +++++++++---------
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c |  2 ++
 drivers/video/logo/Kconfig                      |  9 ---------
 include/linux/fb.h                              |  1 +
 7 files changed, 37 insertions(+), 27 deletions(-)
