Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C96CC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4424521741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690405;
	bh=m3O+OByYLW8Xxzhxm158rMBPnh4EMaIxK/bSnOi7Gx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hOYs7QqPq9E8g/njJrDG6RddJLQkeYQyjbQ9oCTzLbEexugP6a4rm7xB8eMII3LXs
	 4gphS1NQ9ULiEub54pmtBBqcFwsbUzj1mC2BPi8qjtl3fTTUAMA6qAH/WxFqHV5CJb
	 9Q2RYCWVZg0J9CgoSp3RcosS+JXBXHzri0eP8sto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbfA1Pqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728056AbfA1Pql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:41 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A7521741;
        Mon, 28 Jan 2019 15:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690401;
        bh=m3O+OByYLW8Xxzhxm158rMBPnh4EMaIxK/bSnOi7Gx4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYaRGicvuEbSd7pKGrw5yY3CFVro11PwuM2Hsfy8lUuM6A4LLnHdCn5kBH1DjFysL
         N3uvy/csdqgQBWmz/B1aXCR45SZcpXVovpKAfIfRtxdL8gMcQLerGD9UO+wa1d6Tun
         d/1/hxZX91WMR5wiImAloDNCcqfB8i3lEgP5GUGg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 072/304] ASoC: sunxi: sun50i-codec-analog: Add support for cpvdd regulator supply
Date:   Mon, 28 Jan 2019 10:39:49 -0500
Message-Id: <20190128154341.47195-72-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

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

