Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23E8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC52E208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jjT2OPmo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52E208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeH0SCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 14:02:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44656 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0SCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 14:02:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id v16-v6so13790154wro.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 07:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=71T6R6aWNapSWbayq2Twd9+vLBT/nvCcltpPmKjGfxQ=;
        b=jjT2OPmoZyY84/aYyTtlegB8hjwmjfO2+DRyO035Ey6OAo3vJElYR3vySxmhhEKEz2
         T1VughSAwIbVsSoXRmZqdjYlbYOWXZg6ciN/zyJny49jQZHeEYe6mHkMk+XZaF41X0WK
         elFN1CucRWvY8kUuxPhAnLPV9B3ww+2DmQFpqxAQwLCop2AIjl6KqLIeGgWi7+j9vShr
         5Rxor6iZrzQaxSsVdcSh2kMT4jZgT4P59QJJ2zrRniHcv1cLv387eAK8e6gsx23Kxz0u
         6VoLwFjrmp/OjGphMhhSXILsDc+CRPzzzRIoylKjblOsFgouI0Qwu0vaHLJ4EO+52U2l
         I37g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=71T6R6aWNapSWbayq2Twd9+vLBT/nvCcltpPmKjGfxQ=;
        b=N6ZUNXXQO3+a3MZBeSlDh5O5lNgGPZR8yEFisG7ZZ8FJ6takkBQv5pGBsfCgU5zYaq
         EUqy8oTj059Jz1ClhlJDDCC6/GLOeD/psHoKLd9qb4eSF920TiqiJhGTaMzMjbkYjsCt
         IiobKAQYZ/p4WCwTD/73cCIZuJdV/Ua+jcRCpEidsaEV57fZepnzgHzUw90fNYHjgEKg
         dQqfR1jXGRJ++9VZGYsnPTwN3NLCxqyWraXR+lXTdWqAeI1/VKc1s3naGXi+tCXFvH/j
         rnPL23CeySFO8pUmSU/+J7HDSkYtAUO8C1lhG88scmDfevZmTylY6FpRqEMnjUO77hgP
         vNdg==
X-Gm-Message-State: APzg51Bni2voaSfD9VDph9MJ/s96KvOFKKwsjLHiQAggRk87ivFtx/0y
        CWjdqi9hr1mvC1hPSeefq+pwnw==
X-Google-Smtp-Source: ANB0VdbpLknyy+BXtXb6C9FECTJ9VQGvccNgkkB/G3hHJWGLHziSJCeoQBvFxx6kYi6S4X8sXp2OJg==
X-Received: by 2002:adf:c08c:: with SMTP id d12-v6mr8775637wrf.268.1535379342156;
        Mon, 27 Aug 2018 07:15:42 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v133-v6sm14385055wma.36.2018.08.27.07.15.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Aug 2018 07:15:41 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: meson: axg-fifo: report interrupt request failure
Date:   Mon, 27 Aug 2018 16:15:29 +0200
Message-Id: <20180827141529.6497-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return value of request_irq() was irgnored. Fix this and report
the failure if any

Fixes: 6dc4fa179fb8 ("ASoC: meson: add axg fifo base driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-fifo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index 30262550e37b..0e4f65e654c4 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -203,6 +203,8 @@ static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
 
 	ret = request_irq(fifo->irq, axg_fifo_pcm_irq_block, 0,
 			  dev_name(dev), ss);
+	if (ret)
+		return ret;
 
 	/* Enable pclk to access registers and clock the fifo ip */
 	ret = clk_prepare_enable(fifo->pclk);
-- 
2.17.1

