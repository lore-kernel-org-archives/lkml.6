Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7312BC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42572222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huPTkm7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390820AbfBMIr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:47:29 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43198 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389589AbfBMIr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:47:28 -0500
Received: by mail-lj1-f194.google.com with SMTP id z20so263505ljj.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQKwEsId6JLgTtjw3Rjr7HrL/WSfNzzQCt6QFtE+6CE=;
        b=huPTkm7YuTfgMiO3pS+jCGn8NhUCcSn8F3KQWlpn+sfAWdE03+0xZExbkXBqTQQ4Ms
         wSC5XGBYQ7n/wYVCJZxHRgNxIs0hdbjkEbiIaoincu8wJFzdVEshpaJd84a9VZnaoASY
         Wa6ExZJisdmciQHpsAk7/zKJeXa2gjhMLdH+QUhaJbDwDTUyBIj0opR/VRuerdRwNGyj
         N9X+1nLZ5zI6Zxcmf7tfsnG2iWQ7k4zFcRbQzQek1to6poNy/Pr3We/zzhbBAGbYO6Ro
         oA0YEz8XGmiBrSNZMRNtvdxS/XYybCvhCWzfnOj3l2QKu4NtZYQ5GbMXRXw8JVXFYSWv
         NaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQKwEsId6JLgTtjw3Rjr7HrL/WSfNzzQCt6QFtE+6CE=;
        b=jMrOt0Aj9YyDti00Tp/KcDKG9nY8GEYvwE4A28YyzcuO8c3IQ2ciqozRimTlyC2B/X
         JLyjtC8hCUA5H+/Zk5mWpDkRD/WQ55kip8t+QY42Jq6x+/8t/VtjbeamkThEQCr5aZ+e
         AkHsOeyF8BL/egXDEcXcRc1TvTApbN3xTK4f13xcoV9UZqGwAVGp8djyY83ClMG+1y5B
         7U9ejzDU2URutJrRqXF9HJh5BBXC3gvdxYup5tvXNF7ifMlJtymDWYlKxjHS1qXy1GuG
         ZO/4FooIpxsFM/W/u3HyWpWW4sUx7HeNt4d4PO88aS65T5vk0EWU8hLvO1J+PQZDqjsr
         9q0g==
X-Gm-Message-State: AHQUAubMdz3yjs+7P/5odwYmx+/WYiLY2ovETrxy6Ys9h2no2LCFGELv
        2LQkdYhcNgBnuA+d8LbAC+pG7g==
X-Google-Smtp-Source: AHgI3IZws0QWK8imzOTRnZT9SCN+xIH6k+c+7yeJ5437xHEWz8ntkEZzVxRVx+i1Hhp2RtIhJyh02w==
X-Received: by 2002:a2e:81c1:: with SMTP id s1mr202136ljg.29.1550047646117;
        Wed, 13 Feb 2019 00:47:26 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id g85-v6sm3325972lji.17.2019.02.13.00.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:47:25 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     b.zolnierkie@samsung.com
Cc:     linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] fbdev: omap2: fix warnings in dss core
Date:   Wed, 13 Feb 2019 09:47:21 +0100
Message-Id: <20190213084721.29624-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 60d2fa0dad06 ("fbdev: omap2: no need to check return value of
debugfs_create functions") changed the declaration of the return value
of function dss_debugfs_create_file() and the following two warnings
appeared:

drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘dss_debugfs_create_file’:
drivers/video/fbdev/omap2/omapfb/dss/core.c:139:9: warning: ‘return’ with a value,
 in function returning void
  return 0;
         ^
drivers/video/fbdev/omap2/omapfb/dss/core.c: In function ‘omap_dss_probe’:
drivers/video/fbdev/omap2/omapfb/dss/core.c:172:6: warning: unused variable ‘r’
 [-Wunused-variable]
  int r;
      ^

Rework so function dss_debugfs_create_file() that is declared to return
void don't 'return 0' and remove the declaration of the unused variable
'r'.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/core.c b/drivers/video/fbdev/omap2/omapfb/dss/core.c
index 7e6a3eb266d0..b5956a1a30d4 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/core.c
@@ -136,7 +136,6 @@ static inline void dss_uninitialize_debugfs(void)
 }
 void dss_debugfs_create_file(const char *name, void (*write)(struct seq_file *))
 {
-	return 0;
 }
 #endif /* CONFIG_FB_OMAP2_DSS_DEBUGFS */
 
@@ -169,8 +168,6 @@ static struct notifier_block omap_dss_pm_notif_block = {
 
 static int __init omap_dss_probe(struct platform_device *pdev)
 {
-	int r;
-
 	core.pdev = pdev;
 
 	dss_features_init(omapdss_get_version());
-- 
2.19.2

