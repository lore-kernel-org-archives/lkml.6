Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC90C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C760720892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4Tb8vA4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C760720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeLEQTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:19:07 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36837 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbeLEQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:19:07 -0500
Received: by mail-pl1-f195.google.com with SMTP id g9so10300556plo.3;
        Wed, 05 Dec 2018 08:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TkmL002NIrFI/+qlHIQs+8PHenuR75IqlFLC7k33xLk=;
        b=h4Tb8vA4breO2EQ5nRHAlajpKtVZwS4M19enDNuL/h72S0J0Xk8HY+FqCYMti8Bi3d
         57gkNY9J8ZDog3o3O3Q+w0Qfk4A7ntOY0yUU84ywqtRyEGVkoXmG7/9JqaA5UOOVPK/V
         1smgF1Z2gJCvYtJ4zW5ZOnf0GHXEK/KqfU1F/cD//mlV/q4lqC9sumKSyoXTZwZ68ba2
         +PA7u1AAAhbdIOxvN4d+Wvixr/uPN5Ck4i2MbOJqouFObt1SKVytSbp3AGlpd1Y0+2kI
         9PB58N8BMjqanRlJdziFthD5U4HKPZS8j91HB5e8SRsOoeF4hm3U+p8Wq3THXzve2SYM
         92YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TkmL002NIrFI/+qlHIQs+8PHenuR75IqlFLC7k33xLk=;
        b=G4gTXbJrzeTkg66u42A6ZQE0g+lBY9WVGLYVINvhO+X8zRrRgT8O552txVnVaIVIzZ
         iAD9JLiwxYBww1oYVxYCM9R1+vqHoWO6VjCXgCu0B01x7FlvPQzSCVl7ibvUKnC/aSqV
         FA2v8Fc2dC3Z063+jYDSsKIyETzpX8mqVV103RVzF0Xxu7KF+ylKHXttr7qYAA8u9hEG
         swgZRikyMXl0ccRyr2Vt/RgloiVc8gCedQEidNtagpRKFDJeKeNW187PGQDAax+/xDu2
         u+PaMOfBVnNfKbhyQBp30bCHgvd/PWz9bY2v37Eh5RzLlZtVxgq9U+uan4tu3Nj+imH3
         wGtw==
X-Gm-Message-State: AA+aEWaHmvJi58zOBstSl5cnHqNaYTA+kYYBBxE+xsOG001ngY3/tiup
        l2SRNVo8dLvQ6AznG2ptBz0=
X-Google-Smtp-Source: AFSGD/VVDjWyxipNkFrCccRko39MIoR6sZ9UlhG9MGv7loJC8nVBAFn1I0Q6bVwS3isDcnw3CW2L7A==
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7mr25362376plt.106.1544026746670;
        Wed, 05 Dec 2018 08:19:06 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id x3sm66303001pgt.45.2018.12.05.08.19.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:19:06 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr, okaya@kernel.org,
        andy.gross@linaro.org, david.brown@linaro.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/4] dmaengine: amba-pl08x: convert to DEFINE_SHOW_ATTRIBUTE
Date:   Wed,  5 Dec 2018 11:18:57 -0500
Message-Id: <20181205161900.16434-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/dma/amba-pl08x.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 97483df1f82e..fc8c2bab563c 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2505,24 +2505,14 @@ static int pl08x_debugfs_show(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int pl08x_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, pl08x_debugfs_show, inode->i_private);
-}
-
-static const struct file_operations pl08x_debugfs_operations = {
-	.open		= pl08x_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(pl08x_debugfs);
 
 static void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 {
 	/* Expose a simple debugfs interface to view all clocks */
 	(void) debugfs_create_file(dev_name(&pl08x->adev->dev),
 			S_IFREG | S_IRUGO, NULL, pl08x,
-			&pl08x_debugfs_operations);
+			&pl08x_debugfs_fops);
 }
 
 #else
-- 
2.17.0

