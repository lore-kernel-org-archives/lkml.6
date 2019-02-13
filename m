Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044FBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBAD222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388511AbfBMHFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:05:16 -0500
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34828 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733262AbfBMHFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:05:09 -0500
Received: by wens.csie.org (Postfix, from userid 1000)
        id 2D3235FBF9; Wed, 13 Feb 2019 15:05:04 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] arm64: allwinner: a64: Rename hpvcc-supply to cpvdd-supply
Date:   Wed, 13 Feb 2019 15:04:55 +0800
Message-Id: <20190213070457.26049-1-wens@csie.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is a small series to fix the CPVDD regulator supply name for the
A64 codec. The datasheet specifies the name "CPVDD" for the supply rail
for the audio codec's internal headphone amp charge pump.

Somehow I managed to write "CPVDD" in the commit message and the device
tree binding, but used "HPVCC" (which is the name used by the A33) in
the device tree files and the device driver. (facepalm)

This feature was just introduced in v5.0-rc1, so if we could merge this
as fixes for v5.0 that would be great.

Thanks, and sorry for the blunder on my part.


Regards
ChenYu


Chen-Yu Tsai (2):
  ASoC: sunxi: sun50i-codec-analog: Rename hpvcc regulator supply to
    cpvdd
  arm64: dts: allwinner: a64: Rename hpvcc-supply to cpvdd-supply

 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi      | 2 +-
 sound/soc/sunxi/sun50i-codec-analog.c                     | 4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.20.1

