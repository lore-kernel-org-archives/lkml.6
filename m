Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42AC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D153E20685
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 14:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/QoltaE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D153E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440169AbeKXBfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 20:35:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45085 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389110AbeKXBfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 20:35:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so10732153plm.12;
        Fri, 23 Nov 2018 06:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=voownpDEuyOtOySXWnXP++MLmz0fNIioGWXEuqsg52c=;
        b=S/QoltaEpZZnq+ZUi9VdcxTJrS946b8xXaGIof4zcNe3kvv6jqBz5KiRWR1jvZVWh7
         qLcjKftWKSKG+E2BA+5OBJ937vaYlFFpSk4mZHRHD59MLYDSZJnYB5UGGdIKSEdZc+3y
         rtzi7gUu/rz7wcx0uuYMxz/ne64uGLADu/KZf5+/v9N1Vo3XVrMagXdVycMlo7XGuHD1
         TPyska0GcwG7vAJte5ECTSsbbWeJRd617W74hb3YFLFC6PF3GWp8G6qbDb7Yz+urT59S
         6g4tz0Ctxb5jhytTiDrLmwWaoGbmSHwUHudbUyeLpzesXgmx4NcBkps0CPd35XU1QM9M
         XK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=voownpDEuyOtOySXWnXP++MLmz0fNIioGWXEuqsg52c=;
        b=QuXQqqB5lOTns1/22fjnmJpJHue8TTSrbJOl9DzTjjeXQHuIQHH+siTI5vyc1NciBe
         6o+Snq/OXWcjEf+r5/4+Il8043HlDpCT3GbQNk6hlOOUcsKqPrrlDVQfqZ69O66BoN4F
         fEec7KDkewgAfrxq7lnha44spfN1aJKoAeuUZ1LUIRva4kvJHIP+ur4NZKFNZfHBAcxj
         W/3zZdj+w73gVwVLCLX2xnNyKxV5lMlkUpzqToviyOluhv45ndck5uVgSDAvsLOeUJlH
         DlLwk62FXPOXK1Zsb9GAENT5dWOHCTxspWrt6+24CNP6jB+ZdvV1aYadRWCSIRAuMSCQ
         kDEg==
X-Gm-Message-State: AA+aEWbg/O+7FxZICMyUCXap1IOxf4QQ+pAxIyrwhCI/vU/0GG9P69SD
        GeiJOLAY8snSDCHnB6vgY8M=
X-Google-Smtp-Source: AFSGD/XzJl/m00r7b/fzau4oRQc0kEjH5p+FzhSfmOfGzPNFNA3UbfBu0U+ejj/yk+P3Z4f+FYAF7A==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr15791340plt.2.1542984663430;
        Fri, 23 Nov 2018 06:51:03 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id o1sm75869324pgn.63.2018.11.23.06.51.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 06:51:02 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, keescook@chromium.org,
        nicoleotsuka@gmail.com, ezequiel@collabora.com,
        srplinux2008@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] thermal: tegra: soctherm: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Fri, 23 Nov 2018 09:50:58 -0500
Message-Id: <20181123145058.27115-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/thermal/tegra/soctherm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index ed28110a3535..45b41b885f49 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -803,17 +803,7 @@ static int regs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int regs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, regs_show, inode->i_private);
-}
-
-static const struct file_operations regs_fops = {
-	.open		= regs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(regs);
 
 static void soctherm_debug_init(struct platform_device *pdev)
 {
-- 
2.17.0

