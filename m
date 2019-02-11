Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CCFC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A92620821
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895033;
	bh=uRUPajl/UDhS5+zK1uXjxNruKuHrapUPjTqeP7I4JeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MVcmlvQJg8AustMhUFFKfSpQdVyfZGMT+djpVBDwHcEPT+BjBfRCPZBxvDwhsOC8a
	 00WKp8SIhAWMlR3Gam0CEk8ClT+81MFTgErN9iJJjk0JHKub0Rw5jwcwbPNNs5hfLM
	 zTZa1qMiEBlLKhOYdRb6GgumOV+EqBz578uXpTzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbfBKOXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:23:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfBKOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:23:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE723222A1;
        Mon, 11 Feb 2019 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895026;
        bh=uRUPajl/UDhS5+zK1uXjxNruKuHrapUPjTqeP7I4JeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXjS/ac1iOlrGEeEdtTPYftA6XiTID7sTn+h/4O9K/JzKU/7a7OYY+SbOqIIlS1MB
         HcKryziMguFwuK1DvC67lDehKGONF6nbkJq1aj5mHpNkozcGJXv5VSqB8kUbO+xXg/
         mUsiyDwz5WF5arptD1jkD0NngzRtTx4IKo7JGRQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 066/352] ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply
Date:   Mon, 11 Feb 2019 15:14:53 +0100
Message-Id: <20190211141850.315232314@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ca0412a05756cd0b94751ca4d54fe6522f00b1f4 ]

On the Allwinner A64 SoCs, the audio codec has a built-in headphone
amplifier. This amplifier has a power supply separate from the rest of
the analog audio circuitry, labeled cpvdd.

This patch adds a DAPM widget for this supply, and ties it to the
headphone amp widget.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sunxi/sun50i-codec-analog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun50i-codec-analog.c b/sound/soc/sunxi/sun50i-codec-analog.c
index 8f5f999df631..df1fed0aa001 100644
--- a/sound/soc/sunxi/sun50i-codec-analog.c
+++ b/sound/soc/sunxi/sun50i-codec-analog.c
@@ -274,6 +274,7 @@ static const struct snd_soc_dapm_widget sun50i_a64_codec_widgets[] = {
 	 * stream widgets at the card level.
 	 */
 
+	SND_SOC_DAPM_REGULATOR_SUPPLY("hpvcc", 0, 0),
 	SND_SOC_DAPM_MUX("Headphone Source Playback Route",
 			 SND_SOC_NOPM, 0, 0, sun50i_codec_hp_src),
 	SND_SOC_DAPM_OUT_DRV("Headphone Amp", SUN50I_ADDA_HP_CTRL,
@@ -361,6 +362,7 @@ static const struct snd_soc_dapm_route sun50i_a64_codec_routes[] = {
 	{ "Headphone Source Playback Route", "Mixer", "Left Mixer" },
 	{ "Headphone Source Playback Route", "Mixer", "Right Mixer" },
 	{ "Headphone Amp", NULL, "Headphone Source Playback Route" },
+	{ "Headphone Amp", NULL, "hpvcc" },
 	{ "HP", NULL, "Headphone Amp" },
 
 	/* Microphone Routes */
-- 
2.19.1



