Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D07BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D83FD20684
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 13:12:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHoqAuh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D83FD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbeKVXv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 18:51:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46152 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbeKVXv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 18:51:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so1726375pgp.13;
        Thu, 22 Nov 2018 05:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fXhGYmuE8qiW7lSzkIhnjvOvbNI7+RUcOO/wpOBun4E=;
        b=jHoqAuh5byooGNSt+uUBOD9EI3QVj7lUd+dz/iwRUxczAkddsDMc+Plvxy1VeehkML
         fJDbqyMJg30lkNgg3qC3A1DGLFee7K9HomyzVm+qVIReOyZ6ZbIgzohQXOj6yDu+fAd8
         ivbja13QhVpsOr9kw6yZGuknQ1w4Eq6AVgzgbzq4PHjl56P6SLq6WC3O8f1cbDwd0D0p
         GPUCaseol36l7nbsEBjW3Y1WLT0sfrhSODKrojrNVrpacr5lyvdmRz/NVaoPbV0eOKCZ
         KUrGm7vtTSv9sAZuR4Ap9wl1/vLDbY7knQmDrRDWYN5RQsbqg9tbPWpefTJcTG+HpCJJ
         XpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fXhGYmuE8qiW7lSzkIhnjvOvbNI7+RUcOO/wpOBun4E=;
        b=ZRZ+wsbGRm2thR5K/RFLI01Wnw4hk9pCmBNZlTRuC9M8ZZOjrKJVqt2Bo1NyP2svuk
         5B31iGKt69gUt7j6Kvp5WDhewi5q/4knaadelUoyYiBhoZi2xSRpK/5UxFFFiiPQW7lq
         2bhxYcV3/5VkiUawprJGcnJN2pknmJXIxkVREchqdEprCuDmeSYlfvAJbyNQdHYxaAUR
         4kla4L7GlTRh3ny9o047jkECalOjqNXSy1HMrOCamIiNlysmlhZPd5jVnz8fXchqHcrO
         jTerUZLVQkGLtNCXgtbusS8mOGYw4zJU6oEoChQ0RKF5R31trcoc58HyPuCheacwcwFW
         6jYA==
X-Gm-Message-State: AA+aEWZT0e2aI1FuStsKfxhJvrI6EVwa40RhluAFV9A2f/U3SG07JjuE
        Bscm14aKDlWwqZ8rJ4Ie1fY=
X-Google-Smtp-Source: AFSGD/XfcFDkxDdpy9cYwEPlpa/+MLWZuYEdqnz+DvvxOtMrSn5d3Zdv3nd5bB9sjV9GkFTAz1mz2Q==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr10161892pgl.314.1542892330862;
        Thu, 22 Nov 2018 05:12:10 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id y1-v6sm50526282pfb.81.2018.11.22.05.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 05:12:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        avienamo@nvidia.com, mperttunen@nvidia.com, andy.gross@linaro.org,
        robh@kernel.org, vivek.gautam@codeaurora.org
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] soc/tegra: pmc: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Thu, 22 Nov 2018 08:12:07 -0500
Message-Id: <20181122131207.24791-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/soc/tegra/pmc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 1fa840e3d930..d42a1f5ced82 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -717,17 +717,7 @@ static int powergate_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int powergate_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, powergate_show, inode->i_private);
-}
-
-static const struct file_operations powergate_fops = {
-	.open = powergate_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(powergate);
 
 static int tegra_powergate_debugfs_init(void)
 {
-- 
2.17.0

