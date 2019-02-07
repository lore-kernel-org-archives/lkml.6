Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB7C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9930021904
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ERB4mvUT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfBGRAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:00:47 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:31975 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfBGRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:00:47 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190207170044epoutp03b7b46623f8eb37a0c6c5c9f1aa5997e0~BI4841w0s2895028950epoutp03o;
        Thu,  7 Feb 2019 17:00:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190207170044epoutp03b7b46623f8eb37a0c6c5c9f1aa5997e0~BI4841w0s2895028950epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558844;
        bh=18BBmeXihB13WWyX/bdOdL7ELIk/wnCfgR+TEmFsEuU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ERB4mvUTh6L2ivCXQWDkvsPFx29++IjkKsKWigVg7CPMH62XZU72WNGN+eJwTbykc
         MQCvVZfbKd4PQ3w8HYch1XlBGU9sWLusWpIgeVIyuFacFJqitoQl7KSCP3MG5Ff0O+
         wOL95FCFDpL4QLQpYBIge9vLgHtENsBmugL6fYL0=
Received: from epsmges2p4.samsung.com (unknown [182.195.42.72]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190207170044epcas2p25fcfb5b8d533a6030b395d27a9d10661~BI48kWrBL2395223952epcas2p2x;
        Thu,  7 Feb 2019 17:00:44 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.A6.04093.C346C5C5; Fri,  8 Feb 2019 02:00:44 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170044epcas2p3d00762663b971845bc86db84af7d3b23~BI48V23Zp2769327693epcas2p3p;
        Thu,  7 Feb 2019 17:00:44 +0000 (GMT)
X-AuditID: b6c32a48-18bff70000000ffd-dc-5c5c643c69be
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0B.B8.03689.C346C5C5; Fri,  8 Feb 2019 02:00:44 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00MP9F8VXL10@mmp1.samsung.com>; Fri, 08 Feb 2019
        02:00:44 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 00/22] ASoC: dmaengine updates, secondary CPU DAI for Odroid
 boards
Date:   Thu, 07 Feb 2019 18:00:08 +0100
Message-id: <20190207170028.720-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWy7bCmma5NSkyMwa1zMhZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M3rtTmAvOS1ccOraVtYFxgWgXIyeH
        hICJxNkVJxi7GLk4hAR2MEqsu3aTBcL5ziixYelr9i5GDrCqee9jIOK7GSXWb3/BBuH8YpTY
        1HyQGWQUm4ChRO/RPkYQW0RATOL2nE5mkCJmgRYmiTlzlzKDTBIWCJV4s5wPpIZFQFXi+tYF
        LCA2r4ClxPfzfxkhTpKXON+7jh0iLijxY/I9sBpmoPjBK8/BrpMQWMMmsebRMTaIBheJRUs2
        sEDY0hLPVm2EGlQtsWt7NzNEQwejRMuF7cwQCWuJw8cvskJM5ZPoOPwX6k1eiY42IYgSD4nZ
        U6eDzRESiJV4MPci6wRGyVlIbpqF5KYFjEyrGMVSC4pz01OLjQpM9IoTc4tL89L1kvNzNzGC
        Y1nLYwfjgXM+hxgFOBiVeHgvaMfECLEmlhVX5h5ilOBgVhLhlU0ACvGmJFZWpRblxxeV5qQW
        H2KU5mBREud9KD03WkggPbEkNTs1tSC1CCbLxMEp1cAY0/TCyKzzCNc3xlcP4zb8L/7jLy/d
        f4vjyknTba77X99SipV+bvCMQy61VzQ0bcaupaummzY+NS9d4fSzvfa7UQeLfzr73sJbVp/+
        yU5OSvyaY+h6KTmJxTQq8kIz5/4r8tcbOb9euzfZz23fyUUJX2bq8i+0VJb2YuPZ7/9q/7Zz
        dbv9F31SYinOSDTUYi4qTgQAeZMuQeECAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsVy+t9jAV2blJgYg+VNPBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6M3rtTmAvOS1ccOraVtYFxgWgXIweH
        hICJxLz3MV2MXBxCAjsZJV4v28cG4fxilJjTuJqpi5GTg03AUKL3aB8jiC0iICZxe04nM0gR
        s0ATk8Su2xfZQRLCAqESjX9WsoDYLAKqEte3LgCzeQUsJb6f/wvWLCEgL3G+dx07RFxQ4sfk
        e2A1zEDxg1ees0xg5JmFJDULSWoBI9MqRsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzA
        oNx2WKt/B+PjJfGHGAU4GJV4eC9ox8QIsSaWFVfmHmKU4GBWEuGVTQAK8aYkVlalFuXHF5Xm
        pBYfYpTmYFES5+XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNTasvH9x6Obg8Nnxv1O3/L+iHmJ
        3Fr5Q+JCOy+Eau/gLPr+07/ex2pT1YRvS86ytcQarD6+rXKryg+NaU/PsqjbWB21YX9qHCki
        U50590noNSkmH43LT//zuAo2TDfJk1+jITNj1+Gvx/6knDn9+2zhpp4wh2+9r9eacqWf0X54
        5m9I0v1a1sVKLMUZiYZazEXFiQD/1Sw8RgIAAA==
X-CMS-MailID: 20190207170044epcas2p3d00762663b971845bc86db84af7d3b23
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170044epcas2p3d00762663b971845bc86db84af7d3b23
References: <CGME20190207170044epcas2p3d00762663b971845bc86db84af7d3b23@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series restores support for the secondary CPU DAI in samsung/i2s.c
driver and adds support for secondary CPU DAI on Odroid boards.

First two patches introduce changes in ASoC generic dmaengine driver
so as to use custom DMA config as introduced in commit
194c7dea00c6 "ASoC: dmaengine: add custom DMA config to snd_dmaengine_pcm_config"
for handling custom DMA channel names on all Samsung platforms.

Patches 7/22...16/22 are mostly clean up, following conversion to single
component with multiple DAIs in patch 5/22, allowing to reference both
primary/secondary DAI in DT.

I tried to avoid registering new platform device in probe() as it doesn't
play well with deferred probing but couldn't find a way to avoid that new
device, unique devices are needed to register "PCM" components for each
CPU DAI.

I am not entirely sure we should be removing the
SND_DMAENGINE_PCM_FLAG_CUSTOM_CHANNEL_NAME flag like this, it might all
be a bit more explicit with the flag.

The patch set has been tested on Odroid U3, XU3, XU4 and Mini2440
(s3c2440 non-DT) boards.

This series depends on patch
"ASoC: samsung: Prevent clk_get_rate() calls in atomic context"

Sylwester Nawrocki (22):
  ASoC: dmaengine: Improve of_node test in
    dmaengine_pcm_request_chan_of()
  ASoC: dmaengine: Extend use of chan_names provided in custom DMA
    config
  ASoC: samsung: dmaengine: Allow to specify custom DMA device
  ASoC: samsung: i2s: Fix prescaler setting for the secondary DAI
  ASoC: samsung: i2s: Convert to single component with multiple DAIs
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
  ARM: dts: exynos5422-odroidxu3: Add support for secondary DAI
  ARM: dts: exynos5422-odroidxu4: Add support for secondary DAI

 .../boot/dts/exynos5422-odroidxu3-audio.dtsi  |   6 +-
 arch/arm/boot/dts/exynos5422-odroidxu4.dts    |   4 +-
 include/sound/dmaengine_pcm.h                 |   6 -
 sound/soc/samsung/dma.h                       |   3 +-
 sound/soc/samsung/dmaengine.c                 |  16 +-
 sound/soc/samsung/i2s.c                       | 630 ++++++++++--------
 sound/soc/samsung/odroid.c                    | 132 +++-
 sound/soc/samsung/pcm.c                       |   2 +-
 sound/soc/samsung/s3c2412-i2s.c               |   4 +-
 sound/soc/samsung/s3c24xx-i2s.c               |   4 +-
 sound/soc/samsung/spdif.c                     |   2 +-
 sound/soc/soc-generic-dmaengine-pcm.c         |  13 +-
 12 files changed, 489 insertions(+), 333 deletions(-)

--
2.20.1

