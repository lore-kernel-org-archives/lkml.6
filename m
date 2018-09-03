Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D564FC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5320652
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SqNT//bI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DA5320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeICTKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51425 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbeICTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 15:10:21 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180903144949euoutp016723265129b2156081e8a81d78f36f93~Q600dk1JZ1998019980euoutp016;
        Mon,  3 Sep 2018 14:49:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180903144949euoutp016723265129b2156081e8a81d78f36f93~Q600dk1JZ1998019980euoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535986189;
        bh=YXnQWrz7EK8gXGeL3Bje412w5XmMqG5Doeg8NF1kVxE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=SqNT//bIsfXirccXfqhl2W7Yp4WpbaS84X4+YCf6uGzlFlHon2ORypbjCD7lL7Hq2
         2O58RFTTRrdXyHra7dD52k/iyzHN5px7GgQT5ucl+pxypBXqd6hsHhEI1L3SRniioa
         o3yQZfP5c1ElFoOuv8d1LjAxcp40q5PecHtEDyxM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180903144948eucas1p1efbd111a8a05e20b6c6ea2e2b490ed35~Q60zwoTwo2291422914eucas1p1H;
        Mon,  3 Sep 2018 14:49:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 9E.63.04441.C0A4D8B5; Mon,  3
        Sep 2018 15:49:48 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180903144947eucas1p2039e13961d8bfd21edcf1f1d152a5a12~Q60yyvI_N0770807708eucas1p2i;
        Mon,  3 Sep 2018 14:49:47 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-c0-5b8d4a0c443b
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E1.B9.04284.B0A4D8B5; Mon,  3
        Sep 2018 15:49:47 +0100 (BST)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync4.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PEH00LLMIIVL500@eusync4.samsung.com>;
        Mon, 03 Sep 2018 15:49:47 +0100 (BST)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/2] regualtors: Fix suspend/resume issues since v4.16
Date:   Mon, 03 Sep 2018 16:49:35 +0200
Message-id: <20180903144937.16507-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7djPc7o8Xr3RButuCVpsnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBZrj9xlt5i86CCrA7vHzll32T02repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGWs2XGaqeAHR0XLbY4GxjXsXYycHBICJhKPPz9l62Lk4hASWMEo
        seHSCijnM6PEhNvvmGCqdu+czgqRWMYo8ezvKnYIp4FJYufls2BVbAKGEl1vu9hAbBGBXIn3
        V36BjWIW2MgoMeXRe6AODg5hATeJE99zQUwWAVWJ7ndSIOW8ArYSnxafYYFYJi+xesMBZpBW
        CYGXrBLXTzVCJVwkljTtZoWwhSVeHd8C9YOMRGfHQSaIhmZGifYZs9ghnB5Gia1zdrBBVFlL
        HD5+EaybWYBPYtK26cwgV0gI8Ep0tAlBlHhI7Ly9jxnEFhKIlfgy8STLBEaJBYwMqxjFU0uL
        c9NTiw3zUsv1ihNzi0vz0vWS83M3MQLj7PS/4592MH69lHSIUYCDUYmHN8CgN1qINbGsuDL3
        EKMEB7OSCG+jO1CINyWxsiq1KD++qDQntfgQozQHi5I4L59WWrSQQHpiSWp2ampBahFMlomD
        U6qBsWntp79m1alOeV9YVy8452fz792Wfi7j3Cgv4zSr/1sXm8zgd1tjUBzx6V3UZ7vG28qf
        E15+/iuguG3arC87eYQ4jbszJnMoXJAsWpC2WFesatfzzzvV5kpX1v+84Muu4lR3eteHnx84
        ZnnELoo5r3Hf6EHLJF1Xge66SpFF526H31q8QbJGUYmlOCPRUIu5qDgRACc3V6CvAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLJMWRmVeSWpSXmKPExsVy+t/xa7rcXr3RBv+/y1psnLGe1WLqwyds
        Ft+udDBZXN41h81ixvl9TBZrj9xlt5i86CCrA7vHzll32T02repk87hzbQ+bR9+WVYwenzfJ
        BbBGcdmkpOZklqUW6dslcGWs2XGaqeAHR0XLbY4GxjXsXYycHBICJhK7d05n7WLk4hASWMIo
        0b3+KBOE08QkMff4FEaQKjYBQ4mut11sILaIQK7E/mudYEXMApsZJf7vPgBUxMEhLOAmceJ7
        LojJIqAq0f1OCqScV8BW4tPiMywQy+QlVm84wDyBkWsBI8MqRpHU0uLc9NxiQ73ixNzi0rx0
        veT83E2MwEDYduzn5h2MlzYGH2IU4GBU4uENMOiNFmJNLCuuzD3EKMHBrCTC2+gOFOJNSays
        Si3Kjy8qzUktPsQozcGiJM573qAySkggPbEkNTs1tSC1CCbLxMEp1cAokb+dbXPG5ZDKeZaC
        cotapyr2bYrI+ed+gc0nv+tvk/u9lzM+Bpw8Vm71a8KD1VsN3x0/t4H97NLtVZz1BXumd+Sx
        Nxme+Bn2sXfZ8r8yInN+sn0/e3dPgbZEzem359iF914NFBd5nlq9W5Irc8YSzS2+l//qTA5f
        6y2493TC5D72nbN7V6w6rMRSnJFoqMVcVJwIAP32Nw0AAgAA
X-CMS-MailID: 20180903144947eucas1p2039e13961d8bfd21edcf1f1d152a5a12
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180903144947eucas1p2039e13961d8bfd21edcf1f1d152a5a12
References: <CGME20180903144947eucas1p2039e13961d8bfd21edcf1f1d152a5a12@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

While working on suspend/resume support for Samsung Exynos5433-based TM2
board (arch/arm64/boot/dts/exynos/exynos5433-tm2.dts), I've noticed that
v4.16 kernel release introduced some serious problems with regulator
configuration in system suspend state. Further investigation revealed
that the following 2 commits are responsible for my issues:

1. f7efad10b5c4: regulator: add PM suspend and resume hooks
2. 72069f9957a1: regulator: leave one item to record whether regulator is enabled

I've been really surprised that no-one noticed those issues for almost
4 kernel releases. Please review my fixes and apply to v4.19-rcX if
possible.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland


Patch summary:

Marek Szyprowski (2):
  regulator: Fix useless O^2 complexity in suspend/resume
  regulator: Fix 'do-nothing' value for regulators without suspend state

 drivers/regulator/core.c          | 41 +++++++++----------------------
 drivers/regulator/of_regulator.c  |  2 --
 include/linux/regulator/machine.h |  6 ++---
 3 files changed, 15 insertions(+), 34 deletions(-)

-- 
2.17.1

