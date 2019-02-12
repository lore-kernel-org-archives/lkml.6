Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC80C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378E22229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EnliON/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730170AbfBLSEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:04:43 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:59101 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfBLSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:04:42 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190212180440epoutp03d50222970def5b1e66716ff4e6a09019~Cr-MHthri0209002090epoutp03j;
        Tue, 12 Feb 2019 18:04:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190212180440epoutp03d50222970def5b1e66716ff4e6a09019~Cr-MHthri0209002090epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994680;
        bh=TI54RdZxP7agNJuur/D2EZkKLdFzQMysNnOG9Flydvk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=EnliON/PmnF7uF4aSAUEaUn9F0o7MQ4h9AzzCHm0rZEPDfkxLKmKWvvRzg3UxLUja
         MA22qL9qkLK+X0humXQPgzANnMruHda9kBXupWhWwtlaV9uW0KUFKqqrGXRy8sYwen
         yK4rFbOINYjVSHcM7bbuIvAFlsOlNVXiBG6b7jiY=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180438epcas1p17d7fc756e42acf35f32fb00c2b6e65e2~Cr-K_kj-Z1360813608epcas1p1h;
        Tue, 12 Feb 2019 18:04:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BA.AF.04074.6BA036C5; Wed, 13 Feb 2019 03:04:38 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190212180438epcas1p3ae9da367bddb639b15638886f43f69e5~Cr-Kb9om10780707807epcas1p39;
        Tue, 12 Feb 2019 18:04:38 +0000 (GMT)
X-AuditID: b6c32a35-297ff70000000fea-30-5c630ab63a0c
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9F.01.04015.6BA036C5; Wed, 13 Feb
        2019 03:04:38 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:04:38 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 00/21] ASoC: dmaengine updates, secondary CPU DAI for
 Odroid boards
Date:   Tue, 12 Feb 2019 19:03:21 +0100
Message-id: <20190212180342.32040-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDIsWRmVeSWpSXmKPExsWy7bCmnu42ruQYg+3txhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MeZcWsxRcE69Y8PoiWwPjHqEuRk4O
        CQETiQWLj7B0MXJxCAnsYJSY07eJGcL5zijx8uwcVpiql98ms0MkNjBKnFvfwQiSEBL4xSix
        dpY7iM0mYCjRe7QPLC4iICZxe04n2CRmgRYmiTlzlzKDJIQFIiQu9m9kA7FZBFQlthx9C7Sb
        g4NXwFpi38YsiGXyEud717GD2LwCghI/Jt9jAbGZgeIHrzxngahZwybx5q0khO0i0bJlMzvI
        GAkBaYlLR20hwtUSu7Z3g50gIdDBKNFyYTszRMJa4vDxi6wQM/kk3n3tYYXo5ZXoaIOGiofE
        033trBAvxko83P+QcQKj5CwkF81CctECRqZVjGKpBcW56anFhgWGesWJucWleel6yfm5mxjB
        caxluoNxyjmfQ4wCHIxKPLwrjibFCLEmlhVX5h5ilOBgVhLhTWNOjhHiTUmsrEotyo8vKs1J
        LT7EKM3BoiTOu97BOUZIID2xJDU7NbUgtQgmy8TBKdXAuF75rcMHqc01d94e+sp8x3yycMKK
        V6bG7lUCDOvXBBycIPRm/uuG360TTG9asfJIlLu+/K6/6B+LC+P9niStE1UHg/pzveN98kWm
        fTRdvKg3uC6hRtQ3dqunjsKDxuJIpkC5OAHJu1XuHhM8bnT+0lvx9kkMy6M5BZ1z/NnEP9Q4
        SzHqLVqhxFKckWioxVxUnAgAg7UdXd8CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t9jQd1tXMkxBt9aeCyuXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZ8y4tZim4Jl6x4PVFtgbGPUJdjJwc
        EgImEi+/TWbvYuTiEBJYxyjxcv9TVgjnF6PEzglH2UCq2AQMJXqP9jGC2CICYhK353QygxQx
        CzQxSey6fZEdJCEsECGx9M1bFhCbRUBVYstREJuDg1fAWmLfxiyIbfIS53vXgZXzCghK/Jh8
        D6ycGSh+8MpzlgmMPLOQpGYhSS1gZFrFKJlaUJybnltsVGCYl1quV5yYW1yal66XnJ+7iREY
        lNsOa/XtYLy/JP4QowAHoxIP74qjSTFCrIllxZW5hxglOJiVRHjTmJNjhHhTEiurUovy44tK
        c1KLDzFKc7AoifPezjsWKSSQnliSmp2aWpBaBJNl4uCUamA0/jtNMq6Yo+SA47/s7aaq25ev
        v8KnOk11T45iT0j7o3W61Qmzolh3/xf1Dr31Xkawu3jXFt97H0zcth1cksc1r8lE4lXrrGMM
        fNtmGC1av8XwPON59dtXL/3zfua4WKDP5OFh27mz+T98Cdsc7Dx72z/n0PLMaIb3Cz8sz+TW
        03P9P/vU/vwQJZbijERDLeai4kQAKiJJE0YCAAA=
X-CMS-MailID: 20190212180438epcas1p3ae9da367bddb639b15638886f43f69e5
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180438epcas1p3ae9da367bddb639b15638886f43f69e5
References: <CGME20190212180438epcas1p3ae9da367bddb639b15638886f43f69e5@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series restores support for the secondary CPU DAI in samsung/i2s.c
driver and adds support for secondary CPU DAI on Odroid boards.

I have added 4 more clean up patches comparing to first version of the
patch set (16/22...19/22).

The first patch adds new platform device for the secondary PCM, I tried to
avoid registering new platform device in probe() as it doesn't play well
with deferred probing but couldn't find a way to avoid that new device,
unique devices are needed to register "PCM" components for each CPU DAI.

Patches 2/21...11/21 are mostly a clean up, following conversion to single
component with multiple DAIs, allowing to reference both primary/secondary
DAI in DT.

The patch set has been tested on Odroid U3, XU3, XU4 and Mini2440
(s3c2440 non-DT) boards.

Changes since v1 ((addressing Krzysztof's review comments):
 - added a comment, whitespace change in patch 1/21
 - dropped unnecessary new line addition from patch 1/21

Sylwester Nawrocki (21):
  ASoC: samsung: i2s: Restore support for the secondary PCM
  ASoC: samsung: i2s: Move clk supplier data to common driver data
    structure
  ASoC: samsung: i2s: Add widgets and routes for DPCM support
  ASoC: samsung: i2s: Move core clk to the driver common data structure
  ASoC: samsung: i2s: Move opclk data to common driver data structure
  ASoC: samsung: i2s: Move registers cache to common driver data
    structure
  ASoC: samsung: i2s: Move SFR pointer to common driver data structure
  ASoC: samsung: i2s: Drop spinlock pointer from i2s_dai data structure
  ASoC: samsung: i2s: Move IP variant data to common driver data
    structure
  ASoC: samsung: i2s: Move quirks data to common driver data structure
  ASoC: samsung: i2s: Get rid of a static spinlock
  ASoC: samsung: odroid: Add support for secondary CPU DAI
  ASoC: samsung: Specify DMA channel names through custom DMA config
  ASoC: samsung: Drop DAI DMA data chan_name assignments
  ASoC: dmaengine: Remove unused
    SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag
  ASoC: samsung: i2s: Simplify pri_dai, sec_dai pointers usage
  ASoC: samsung: i2s: Change indentation in SAMSUNG_I2S_FMTS definition
  ASoC: samsung: i2s: Comments clean up
  ASoC: samsung: i2s: Convert to SPDX License Indentifier
  ARM: dts: exynos5422-odroidxu3: Add support for secondary DAI
  ARM: dts: exynos5422-odroidxu4: Add support for secondary DAI

 .../boot/dts/exynos5422-odroidxu3-audio.dtsi  |   6 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts    |   4 +-
 include/sound/dmaengine_pcm.h                 |   6 -
 sound/soc/samsung/dmaengine.c                 |  12 +-
 sound/soc/samsung/i2s.c                       | 543 ++++++++++--------
 sound/soc/samsung/odroid.c                    | 131 +++--
 sound/soc/samsung/s3c2412-i2s.c               |   4 +-
 sound/soc/samsung/s3c24xx-i2s.c               |   4 +-
 sound/soc/soc-generic-dmaengine-pcm.c         |  21 +-
 9 files changed, 413 insertions(+), 318 deletions(-)

--
2.20.1

