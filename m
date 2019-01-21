Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00023C2F420
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEA520879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqzSE40g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbfAUOs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:48:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39471 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbfAUOs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:48:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so9935213pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 06:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMreXA/IqFnxqO8rhAGPb6mVIJdBYNw498K8q3B7msw=;
        b=bqzSE40gvNfqVEm80hLCdUoUSt0Tq2gSLJflNOifvHZhHUOQoV8HxrmpEvcr2F6meS
         9WYXoEKBgxpw8zXNktyUB+ntcJPFvZZpDAO/fINrdSXSCDSGU9fkP2aaqZUX5nCLrUil
         jliNWDHRa8wS5bh5to5F7wuySy5lbzvGNPDqncJuhBIWNG5juqL5Pc+QE93viyow9/By
         GaKvJE2Z33QKh1Ea/aLG3ODxPkKlksB8WjeN2G82cp/umxcI+ecHfAQz+iYL3jvGY5a6
         R/JXTap4S/JQoy82TedaeD1JSpTQYzJxIjaQ2JmeyqGd3a+k9grOcWTDMHCUK3vavhF8
         d2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AMreXA/IqFnxqO8rhAGPb6mVIJdBYNw498K8q3B7msw=;
        b=nWBUdzNNLtyV9BlTir2pstQjR5paHpUJF2xVcnUvU+WC7KLGEegGQZU3l5I1y2jLhQ
         wiIquEMN4CEA12BMw07qKh7VpABm0zbp6/ddwjCI67bZEavLIo5HtfhDwu48octjGzYO
         4f7AU5wMR8KrzPeFwU5xXlGlGx1LMyiGWsAXlz+6evZ/Mf9g912Tc9QmJTpdQGs2yAh3
         7J6oTiyCodxIH8cmfL8Zmv65v38ujEZEgzAUEMa55ZQLlluI/GWjgZWPnDmR/Icx8RGI
         64Nf32GRruYlTEou3ns48QHtLfNeHLUdVpRvlc/LkaSW0UTMRIAWxamV3s0uB1yNMfEy
         Ycxg==
X-Gm-Message-State: AJcUukdI66H9/9PpwCgkvuTtqkSEXIQE7Ni/aLL2cACdIAZ3Y5XmbZal
        fSpa/yW32DLlGXVpgrng/vX/zfGfCQQ=
X-Google-Smtp-Source: ALg8bN6TnUc4uL6tWhR0GAQzPWAYNlR3B9orT6zSstsd4EA4/0uvZH4vSIr8IGR0d9AF5lhjtu0Dag==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr30443627pls.293.1548082106162;
        Mon, 21 Jan 2019 06:48:26 -0800 (PST)
Received: from localhost.localdomain ([222.129.236.86])
        by smtp.gmail.com with ESMTPSA id r8sm17259084pgu.38.2019.01.21.06.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jan 2019 06:48:25 -0800 (PST)
From:   Zhiwei Jiang <qq282012236@gmail.com>
To:     qq282012236@gmail.com
Cc:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dapm: Skip suspending widgets with ignore flag
Date:   Mon, 21 Jan 2019 22:48:18 +0800
Message-Id: <20190121144818.23042-1-qq282012236@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For endpoint wigdets which have set the suspend ignore flag, asoc
shouldn't mark them as dirty when ASoC suspend function is called.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index a5178845065b..68c49090f561 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -278,7 +278,7 @@ void dapm_mark_endpoints_dirty(struct snd_soc_card *card)
 	mutex_lock(&card->dapm_mutex);
 
 	list_for_each_entry(w, &card->widgets, list) {
-		if (w->is_ep) {
+		if (w->is_ep && !w->ignore_suspend) {
 			dapm_mark_dirty(w, "Rechecking endpoints");
 			if (w->is_ep & SND_SOC_DAPM_EP_SINK)
 				dapm_widget_invalidate_output_paths(w);
-- 
2.19.0

