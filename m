Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FC4C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495BE2088E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=birdec.tech header.i=@birdec.tech header.b="S3OIlaWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495BE2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birdec.tech
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbeHUU6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:58:03 -0400
Received: from host.euro-space.net ([87.117.239.2]:32989 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbeHUU6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:58:03 -0400
X-Greylist: delayed 2682 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 16:58:02 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.tech
        ; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t4f8oPdQWR7CVGpy8qipQ4CMEZcm7J/RuzuRdUSZytU=; b=S3OIlaWFNpEe/scrazHbbp8EzK
        gN+k7CFAMqfmwYWvwyJIFawFHnTVHdCRx2RCo/yWTBvkPbFvOkfXHm1cRJL8gB3qmbWsF8FlYDXpN
        mFXuhT2MmEVurmdqIKomsA4U6Y4YVvgdjZQF+iJOJoILmPcRax4w7q5CWRvb7jixIMR/izWfWT0RR
        iEnwBUR3RTF4l5i9xgN2n0z5gyIEoedxnhlOy55XwVtGhMEYLI+a/DvVii/TXRd9IwCcL6lDHFrLv
        rvoUzsLGQxkxr3XVgco1hs/AKnpBvntnHmirWJ9PdceIco6XwitqfBn2SP6j7UY3OYHlxcwSDJDzN
        ZTmrjFmA==;
Received: from x55b18169.dyn.telefonica.de ([85.177.129.105]:39848 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <kmarinushkin@birdec.tech>)
        id 1fs9tG-0003Hx-St; Tue, 21 Aug 2018 17:52:22 +0100
From:   Kirill Marinushkin <kmarinushkin@birdec.tech>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        M R Swami Reddy <mr.swami.reddy@ti.com>,
        Vishwas A Deshpande <vishwas.a.deshpande@ti.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.tech>
Subject: [PATCH 0/1] ASoC: pcm3060: Add codec driver
Date:   Tue, 21 Aug 2018 18:52:45 +0200
Message-Id: <20180821165246.9479-1-kmarinushkin@birdec.tech>
X-Mailer: git-send-email 2.13.6
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.tech
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.tech
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.tech
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

I am developing sound support for a Linux-based device, with playback and
capture through the TI PCM3060 codec.

With the following patch, I propose to add the PCM3060 codec driver into
the kernel.

Best Regards,
Kirill

Kirill Marinushkin (1):
  ASoC: pcm3060: Add codec driver

 .../devicetree/bindings/sound/pcm3060.txt          |  17 ++
 MAINTAINERS                                        |   7 +
 sound/soc/codecs/Kconfig                           |  17 ++
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/pcm3060-i2c.c                     |  61 +++++
 sound/soc/codecs/pcm3060-spi.c                     |  60 +++++
 sound/soc/codecs/pcm3060.c                         | 290 +++++++++++++++++++++
 sound/soc/codecs/pcm3060.h                         |  88 +++++++
 8 files changed, 546 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/pcm3060.txt
 create mode 100644 sound/soc/codecs/pcm3060-i2c.c
 create mode 100644 sound/soc/codecs/pcm3060-spi.c
 create mode 100644 sound/soc/codecs/pcm3060.c
 create mode 100644 sound/soc/codecs/pcm3060.h

-- 
2.13.6

