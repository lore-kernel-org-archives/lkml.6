Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC694C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCB120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCB120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbeIJVgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:36:17 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:29534 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbeIJVgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:36:16 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id w8AGdcP7048264;
        Tue, 11 Sep 2018 01:39:38 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Tue, 11 Sep 2018 01:39:38 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from localhost.localdomain (239.166.151.153.ap.dti.ne.jp [153.151.166.239])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id w8AGdZHM048256
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 11 Sep 2018 01:39:38 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
To:     Mark Brown <broonie@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM attribute
Date:   Tue, 11 Sep 2018 01:39:32 +0900
Message-Id: <20180910163932.13722-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 sound/soc/rockchip/rockchip_pcm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
index f77538319221..9e7b5fa4cf59 100644
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -21,7 +21,8 @@ static const struct snd_pcm_hardware snd_rockchip_hardware = {
 	.info			= SNDRV_PCM_INFO_MMAP |
 				  SNDRV_PCM_INFO_MMAP_VALID |
 				  SNDRV_PCM_INFO_PAUSE |
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME |
+				  SNDRV_PCM_INFO_INTERLEAVED,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
 	.periods_min		= 1,
-- 
2.18.0

