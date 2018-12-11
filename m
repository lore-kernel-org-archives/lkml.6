Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77934C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A482084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 02:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43A482084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeLKCGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 21:06:11 -0500
Received: from muru.com ([72.249.23.125]:57222 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbeLKCGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 21:06:10 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 737D980F0;
        Tue, 11 Dec 2018 02:06:13 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date:   Mon, 10 Dec 2018 18:05:55 -0800
Message-Id: <20181211020557.61783-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here are two fixes that allow me to have multiple endpoints defined in
the dts file for audio-graph-card. To do that, we need to fix up few
issues as the graph binding Documentation/devicetree/bindings/graph.txt
allows multiple endpoints per port. This allows configuring TDM codecs
for I2S for example.

Kuninori-san, can you please check if this makes sense to you and
compare against the graph binding?

Cheers,

Tony


Tony Lindgren (2):
  ASoC: simple-card-utils: revert port changes to follow graph binding
  ASoC: audio-graph-card: Fix parsing of multiple endpoints

 sound/soc/generic/audio-graph-card.c  | 41 +++++++++++++++++++++++----
 sound/soc/generic/simple-card-utils.c | 22 ++++++++++++--
 2 files changed, 55 insertions(+), 8 deletions(-)

-- 
2.19.2
