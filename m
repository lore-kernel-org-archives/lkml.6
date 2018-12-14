Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD165C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB592133F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 11:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R/RkCbpC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FB592133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729685AbeLNLeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 06:34:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52260 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNLeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 06:34:18 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181214113417euoutp02c322af9cf6aef4a0a57ef3e4fcb4f007~wL9NnN0AB2202922029euoutp02Y;
        Fri, 14 Dec 2018 11:34:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181214113417euoutp02c322af9cf6aef4a0a57ef3e4fcb4f007~wL9NnN0AB2202922029euoutp02Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544787257;
        bh=ljMilkbZydBoC4OuJrbgydj2GUbp91GjT0qEfdZ17vk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=R/RkCbpCiuLA+aieLbqvFyR94+m96JVbWb1rWOKIXLTIHsIn262oY9vY8bwypKEIi
         OpF1jJTmswwUHuIs+8ftvqe7jG/sCP6V5sUtlonG3PnnoqGFhKqvDhcqryQ1dEiyiZ
         +xVmjWcZ3N6wUMb0dZ5Slfi8UFv+ca+Vn5JT1E5Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181214113416eucas1p1833c212f8ffd0ee9dd0e7e3b1928dce7~wL9Myh6zA0404804048eucas1p1I;
        Fri, 14 Dec 2018 11:34:16 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 91.59.04294.835931C5; Fri, 14
        Dec 2018 11:34:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181214113415eucas1p16dd61a4312d88216cb0d737887c751b7~wL9MJE0CB0404204042eucas1p1M;
        Fri, 14 Dec 2018 11:34:15 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-23-5c1395385d91
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E3.6D.04128.735931C5; Fri, 14
        Dec 2018 11:34:15 +0000 (GMT)
Received: from AMDC2765.digital.local ([106.116.147.25]) by
        eusync3.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0 64bit
        (built May  5 2014)) with ESMTPA id <0PJQ004655GZZA10@eusync3.samsung.com>;
        Fri, 14 Dec 2018 11:34:15 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Beomho Seo <beomho.seo@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/4] Samsung TM2(e): add Bluetooth support (resend)
Date:   Fri, 14 Dec 2018 12:34:06 +0100
Message-id: <20181214113410.22848-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7djP87oWU4VjDFY3slhsnLGe1eL0p23s
        Fs2L17NZnD+/gd3i/tejjBaXd81hs5hxfh+TxZnFvewWa4/cZbc4/Kad1WLG5JdsDtwem1Z1
        snncubaHzWP/3DXsHn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXxvPE2a8F99ooPXZ1sDYzf
        WLsYOTkkBEwkPn8/zdLFyMUhJLCCUeLe0aOMEM5nRomfZ28wwVR9aDgMlVjGKPF863cop4FJ
        Yk3XBRaQKjYBQ4mut11sILaIQLLEs7lHwIqYBR4ySXRc/AZWJCzgLLFg2kKw5SwCqhJLfu0H
        W8ErYCuxdsUKZoh18hKrNxxgBmmWEOhhk5h7bBp7FyMHkOMisf95DkSNsMSr41vYIWwZicuT
        u1kg6psZJdpnzGKHamaU2DpnBxtElbXE4eMXwTYzC/BJTNo2nRliKK9ER5sQRImHxJnjk8AO
        EhKIlTh2qpFpAqPEAkaGVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIExefrf8S87GHf9
        STrEKMDBqMTDmzFJKEaINbGsuDL3EKMEB7OSCG9Yq3CMEG9KYmVValF+fFFpTmrxIUZpDhYl
        cd5qhgfRQgLpiSWp2ampBalFMFkmDk6pBkbGl/znWs4IOYS5398rX+W4NdLpWOadLdIToxyY
        +qbNTT49ac9xEYeSI9cyqt8Uqx5b/YTZZcvU9r/PNT6UH2Ja6Ke2LU8hu9MyyqU9SHjHcvez
        T2qYpn2ZVBTS+G3KpafhhsVKp7pFbZ2n9S7v1uquiv3N3Xie5ybHZufNZS8T4hSU10pyCCix
        FGckGmoxFxUnAgCKm0lCxQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphluLIzCtJLcpLzFFi42I5/e/4VV3zqcIxBk/WKltsnLGe1eL0p23s
        Fs2L17NZnD+/gd3i/tejjBaXd81hs5hxfh+TxZnFvewWa4/cZbc4/Kad1WLG5JdsDtwem1Z1
        snncubaHzWP/3DXsHn1bVjF6fN4kF8AaxWWTkpqTWZZapG+XwJXxvPE2a8F99ooPXZ1sDYzf
        WLsYOTkkBEwkPjQcZuxi5OIQEljCKLFtbQuU08QkcfFcHyNIFZuAoUTX2y42EFtEIFli198X
        rCBFzAKPmSSmtLxgAUkICzhLLJi2EGwsi4CqxJJf+5lAbF4BW4m1K1YwQ6yTl1i94QDzBEau
        BYwMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLDZtuxn1t2MHa9Cz7EKMDBqMTDe2CKUIwQ
        a2JZcWXuIUYJDmYlEd6wVuEYId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqjhATSE0tSs1NT
        C1KLYLJMHJxSDYx11dmLL+z4YFpjXJMUXevgU12Q9O7YdlOX6bcOr31b2hE6bUfY+Umc9dpO
        C9y4Zs6f5zLDymjv02XnPl4tXsG9bsHsb1ZbNjgZ/3vELmu5XOfNpDMyB1++L1MKeu9la/nS
        +n3NjmWfPQonb/utlXJCwup83zTeX9ozbWZmMmVl5s9MXmwneyFZiaU4I9FQi7moOBEAwUio
        NRcCAAA=
X-CMS-MailID: 20181214113415eucas1p16dd61a4312d88216cb0d737887c751b7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181214113415eucas1p16dd61a4312d88216cb0d737887c751b7
References: <CGME20181214113415eucas1p16dd61a4312d88216cb0d737887c751b7@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This patchset enables Bluetooth support on TM2/TM2e boards using mainline
HCI_BCM driver. It requires a few fixes to Samsung serial driver and
adding a proper node to device tree description of the mentioned boards.
Patches can be applied independently to each subsystem.

Best regards
Marek Szyprowski
Samsung R&D Institute Poland


(resend reason: added respective maintainers and lists to cc)

Patch summary:

Beomho Seo (2):
  mfd: exynos-lpass: Enable UART module support
  tty: serial: samsung: Properly set flags in autoCTS mode

Marek Szyprowski (1):
  arm64: dts: exynos: Add Bluetooth chip to TM2(e) boards

Seung-Woo Kim (1):
  tty: serial: samsung: Increase maximum baudrate

 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 14 ++++++++++++++
 drivers/mfd/exynos-lpass.c                         |  4 +++-
 drivers/tty/serial/samsung.c                       |  5 ++++-
 3 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.17.1

