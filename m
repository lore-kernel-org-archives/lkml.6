Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5A6D2229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Bc6aPOT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395146AbfBNJia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:38:30 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:43794 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBNJi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:38:26 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190214093824epoutp03c48239e62d55b972bb0d36c919a95dac~DMXutoYnZ0714107141epoutp031;
        Thu, 14 Feb 2019 09:38:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190214093824epoutp03c48239e62d55b972bb0d36c919a95dac~DMXutoYnZ0714107141epoutp031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550137104;
        bh=NtuAGQahGCyd7DCok94cl4TUwN73t3SOacwj64SSrPI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Bc6aPOT6BIxSfwALsGlPXXd2AwowR7lpn7pkt+7q+g22HLsA3lagdKOIJfeAe7P6O
         iRvXdISw2zA7nJNOnAr1sVqo84lJxPUOCPwqvfCY4DDSUilGpt3d4NhDOy0o6Lt6RV
         xekC34vdq5G1dVBzHVd24ENJJ6N5FvDWy17cmS6I=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190214093823epcas2p4bc9327b44a9c29fe9a4b278478f36494~DMXuYOsxp2520025200epcas2p4K;
        Thu, 14 Feb 2019 09:38:23 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.F8.04138.F07356C5; Thu, 14 Feb 2019 18:38:23 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190214093822epcas2p11380606cb3272aa4fd56eb55dea8f8c8~DMXtwDnSG1579015790epcas2p1u;
        Thu, 14 Feb 2019 09:38:22 +0000 (GMT)
X-AuditID: b6c32a45-60bff7000000102a-c6-5c65370fa324
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 1B.52.03689.E07356C5; Thu, 14 Feb
        2019 18:38:22 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMW0074FTFANE00@mmp2.samsung.com>; Thu, 14 Feb 2019
        18:38:22 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 Resend 00/13] ASoC: dmaengine updates, secondary CPU DAI
 for Odroid
Date:   Thu, 14 Feb 2019 10:37:34 +0100
Message-id: <20190214093747.2414-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAIsWRmVeSWpSXmKPExsWy7bCmqS6/eWqMQcMVeYsrFw8xWUx9+ITN
        4vz5DewW3650MFlc3jWHzeLwm3ZWi4srvjA5sHts+NzE5rFz1l12j02rOtk8+rasYvT4vEku
        gDWKyyYlNSezLLVI3y6BK+PsoldsBXeEK9a9v8DcwHiZv4uRk0NCwESit3EXexcjF4eQwA5G
        id1rP7FAON8ZJe6vb2SGqfoyYy0rRGIDo8SeS7vBEkICvxglZp8RArHZBAwleo/2MYLYIgJi
        ErfndDKDNDALrGSU2LJvExtIQlggQuLjw8NgRSwCqhLf529hBbF5Bawk9rdPYoTYJi+xesMB
        sGYJga+sErNXHYE6w0Vi0ppdTBC2tMSzVRuhGqoldm3vhmroYJRoubAdqsFa4vDxi2AbmAX4
        JDoO/wX6lAMozivR0SYEUeIhsW3vJTaIb2Il5i77xDKBUXwBI8MqRrHUguLc9NRiowJDveLE
        3OLSvHS95PzcTYzgeNJy3cE445zPIUYBDkYlHt4KoZQYIdbEsuLK3EOMEhzMSiK8F41SY4R4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzPpKeGy0kkJ5YkpqdmlqQWgSTZeLglGpgnLvB/s12If9d
        bLdPV71v2XfbeLfI27mNC751TO3W1TJZ4Du/9OG9TnOJ8xJGfQcOqTVkxjG82Wz5dimbpM+p
        +//88pY3TXN/MnnrUfnz+SFJCfVPFx2K+bx9w/yU47K/S56ovJLz1Q3KMGtxvtOpOztceqa2
        4YSf3w5ufmvhXnAh5/P32b9STJRYijMSDbWYi4oTAd7JI7mjAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKJMWRmVeSWpSXmKPExsVy+t9jQV0+89QYgxenTS2uXDzEZDH14RM2
        i/PnN7BbfLvSwWRxedccNovDb9pZLS6u+MLkwO6x4XMTm8fOWXfZPTat6mTz6NuyitHj8ya5
        ANYoLpuU1JzMstQifbsEroyzi16xFdwRrlj3/gJzA+Nl/i5GTg4JAROJLzPWsnYxcnEICaxj
        lHgz5wcThPOLUeLTw05mkCo2AUOJ3qN9jCC2iICYxO05IHEuDmaBlYwSR76vAksIC0RIPDm/
        mw3EZhFQlfg+fwsriM0rYCWxv30SI8Q6eYnVGw4wT2DkWsDIsIpRMrWgODc9t9iowCgvtVyv
        ODG3uDQvXS85P3cTIzAwth3W6t/B+HhJ/CFGAQ5GJR7eCqGUGCHWxLLiytxDjBIczEoivBeN
        UmOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8/LnH4sUEkhPLEnNTk0tSC2CyTJxcEo1MHbwerwO
        3CAV8OfBDAlPjw3CuTcfbIqPfC4878n963ujOaaG2X1qdRX4y/xXIEzZKV4m72v+rncLzIJ8
        b27N+n8jOW2O5ZLnjGkxE+7YbdO/Hrw02+TZ7QVPAv8dujLr9uI5W2P8dsxMdvpS/P7Zo8cb
        7l2pv9JvxhB+h/dd0INVy6a5aQsfE5NXYinOSDTUYi4qTgQAs8CyhQgCAAA=
X-CMS-MailID: 20190214093822epcas2p11380606cb3272aa4fd56eb55dea8f8c8
CMS-TYPE: 102P
X-CMS-RootMailID: 20190214093822epcas2p11380606cb3272aa4fd56eb55dea8f8c8
References: <CGME20190214093822epcas2p11380606cb3272aa4fd56eb55dea8f8c8@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rebased version with the build break fixed and added Krzysztof's 
Acks. My apologies, I double checked there is no build errors between patches 
this time.

Below is cover letter text from v2.

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

Sylwester Nawrocki (13):
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

 include/sound/dmaengine_pcm.h         |   6 -
 sound/soc/samsung/dmaengine.c         |  12 +-
 sound/soc/samsung/i2s.c               | 297 +++++++++++++-------------
 sound/soc/samsung/odroid.c            | 131 ++++++++----
 sound/soc/samsung/s3c2412-i2s.c       |   4 +-
 sound/soc/samsung/s3c24xx-i2s.c       |   4 +-
 sound/soc/soc-generic-dmaengine-pcm.c |  21 +-
 7 files changed, 250 insertions(+), 225 deletions(-)

-- 
2.17.1

