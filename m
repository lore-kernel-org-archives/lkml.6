Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32579C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E869C21537
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 05:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E869C21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbeI0LU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 07:20:26 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:57666 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeI0LU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 07:20:26 -0400
Received: from svr-orw-mbx-03.mgc.mentorg.com ([147.34.90.203])
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g5OT3-00029V-Bi from Jiada_Wang@mentor.com ; Wed, 26 Sep 2018 22:04:01 -0700
Received: from jiwang-OptiPlex-980.tokyo.mentorg.com (147.34.91.1) by
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Wed, 26 Sep 2018 22:03:57 -0700
From:   <jiada_wang@mentor.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>
CC:     <jiada_wang@mentor.com>, <twischer@de.adit-jv.com>,
        <dragos_tarcatu@mentor.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH linux-next 00/10] ASoC: rsnd: support to set different busif
Date:   Thu, 27 Sep 2018 14:03:57 +0900
Message-ID: <20180927050407.17765-1-jiada_wang@mentor.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-04.mgc.mentorg.com (147.34.90.204) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Rcar audio DMA/SSIU already support to use different BUSIF
to transfer data, but busif is fixed at 0.

This patch set adds kctrl interface "SSI Out/In BUSIF", which enables
to configure busif for each dai-stream used in transfer.

device tree files are updated to use extended audio dmac register,
and add dma request number for busif1 ~ busif7 

Jiada Wang (10):
  ASoC: rsnd: ssi: Request dedicated dma channels for busif1 to 7
  arm64: r8a7795: add dma request number for busif1 ~ busif7
  arm64: r8a7796: add dma request number for busif1 ~ busif7
  arm64: r8a774a1: add dma request number for busif1 ~ busif7
  arm64: r8a7795: change to use extended audio dmac register
  arm64: r8a7796: change to use extended audio dmac register
  arm64: r8a774a1: change to use extended audio dmac register
  arm64: r8a77965: change to use extended audio dmac register
  ASoC: rsnd: add busif property to dai stream
  ASoC: rsnd: Add kctrl to configure dai's busif

 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 139 ++++++++++++++++++----
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 132 +++++++++++++++++---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi  | 138 +++++++++++++++++----
 arch/arm64/boot/dts/renesas/r8a77965.dtsi |   2 +-
 sound/soc/sh/rcar/core.c                  |  16 ++-
 sound/soc/sh/rcar/dma.c                   |  32 +++++
 sound/soc/sh/rcar/rsnd.h                  |   5 +
 sound/soc/sh/rcar/ssi.c                   |  56 +++++++--
 8 files changed, 451 insertions(+), 69 deletions(-)

-- 
2.17.0

