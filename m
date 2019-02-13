Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ADDC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD02320835
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wh4IqUCx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394229AbfBMSxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:53:21 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:30870 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405743AbfBMSm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:42:57 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190213184254epoutp02a6ef7436423fabe577eb578fca8a2ab6~DAJ3I3Nu00220402204epoutp02E;
        Wed, 13 Feb 2019 18:42:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190213184254epoutp02a6ef7436423fabe577eb578fca8a2ab6~DAJ3I3Nu00220402204epoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550083374;
        bh=NtuAGQahGCyd7DCok94cl4TUwN73t3SOacwj64SSrPI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Wh4IqUCxzz+i8sSN9FlV+1g1JButFG1Zh4W8rBAPNCCrmdlO0cYw36zHYst4hGn1i
         6AsykegOzL7foOzpz4YFCK7TaGrvQcNQaUeagTxg5xY1WeypOBCFjNIZVXq8Q5dmh4
         2QMQXz72Q3EoXHQS/+HYxzJgHLM77yhYL6RSM1MA=
Received: from epsmges1p4.samsung.com (unknown [182.195.42.56]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184253epcas1p1d031667d15dbd08d1551cbd0cdf177fa~DAJ19mu7j0131801318epcas1p1h;
        Wed, 13 Feb 2019 18:42:53 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.C9.04288.D25646C5; Thu, 14 Feb 2019 03:42:53 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345~DAJ1fg6sk0131701317epcas1p1c;
        Wed, 13 Feb 2019 18:42:52 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-e3-5c64652d7d07
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 44.CE.04015.C25646C5; Thu, 14 Feb
        2019 03:42:52 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMV00HOONZ3WX60@mmp2.samsung.com>; Thu, 14 Feb 2019
        03:42:52 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v3 00/13] ASoC: dmaengine updates, secondary CPU DAI for
 Odroid boards
Date:   Wed, 13 Feb 2019 19:41:59 +0100
Message-id: <20190213184212.5473-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsWy7bCmnq5uakqMwcfnrBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Ms4tesRXcEa5Y9/4CcwPjZf4uRg4O
        CQETifWLwrsYuTiEBHYwSpy5NYUZwvnOKNF5/QczTNG5Q1BFGxglXr1fwgTh/GKU2HzxGmMX
        IycHm4ChRO/RPjBbREBM4vacTrBJzAItTBJz5i5lBkkIC0RIzJ25gR3EZhFQlfh29zwLiM0r
        YCWxbHsbE4gtISAvsXrDAbBmCYEeNolZd0+yQSRcJObO+84IcZK0xKWjthDhaold27uh6jsY
        JVoubGeGSFhLHD5+kRXEZhbgk3j3tYcVopdXoqNNCKLEQ+Jz8yqwvUICsRITH+1kncAovoCR
        YRWjWGpBcW56arFhgYlecWJucWleul5yfu4mRnCkaVnsYNxzzucQowAHoxIPb4VQSowQa2JZ
        cWXuIUYJDmYlEV69KKAQb0piZVVqUX58UWlOavEhRmkOFiVx3vUOzjFCAumJJanZqakFqUUw
        WSYOTqkGxvnVS4NYu75VfrZd+/aWZEpY0Cbv1XuOHXVa/vC5rJRSj/EENlalF/pl36dbLC99
        rvhZ85DDH9cDGnNtdzhKB+z58+3IfV6O3BSlU6Gz9mte5S859LFBcb+nlFE6z4Sf7Cqbptxq
        23TLd0Vhw9SJF9IuxXonrjkve+2N39p3rPK6+S/CnihwRimxFGckGmoxFxUnAgA7TLIzsAIA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmluLIzCtJLcpLzFFi42I5/e+xoK5OakqMwcTvShZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6Ms4tesRXcEa5Y9/4CcwPjZf4uRg4O
        CQETiXOHwrsYuTiEBNYxSly9/oYVwvnFKHHy1iH2LkZODjYBQ4neo32MILaIgJjE7TmdzCBF
        zAJNTBK7bl8EKxIWiJBY9PIPmM0ioCrx7e55FhCbV8BKYtn2NiYQW0JAXmL1hgPMExi5FjAy
        rGKUTC0ozk3PLTYqMMxLLdcrTswtLs1L10vOz93ECAyabYe1+nYw3l8Sf4hRgINRiYdXQSAl
        Rog1say4MvcQowQHs5IIr14UUIg3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6Yklqdmp
        qQWpRTBZJg5OqQZGiwfMH1ZIn94eUi/XnMUc882ITzF/ivX3SY9knxx7Wxn19xpb2A4eAXkn
        7uxl9RsTlFfkbMwNC75f+fuuclBKacr69BVqzCn5FxZp1+2afWn37l//cw/PfvW5acPTfSuT
        94oXXA6OuhYd5bL3b91ERrbSvl3Cxz9f2PluYmX2iejT/7/fYimzU2Ipzkg01GIuKk4EANJp
        Md0WAgAA
X-CMS-MailID: 20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345
CMS-TYPE: 101P
X-CMS-RootMailID: 20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345
References: <CGME20190213184252epcas1p131e1023b7f6ec280e880b160a4a96345@epcas1p1.samsung.com>
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

