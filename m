Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF705C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BE2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 04:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHFw2PTV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGEfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 23:35:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43508 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfBGEfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 23:35:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so3948480pgk.10;
        Wed, 06 Feb 2019 20:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SwDO0i0fqjqyoIRgY+ZZt4h4DIJn4R+h9rsWoZMPFOI=;
        b=nHFw2PTVUy1Sx0YeTr9HJlN5G33yvDjfTY8op5lWut+MZCs5wvYFXcCE/7f/bq3333
         k+q9HBnjN6FgBNAy+3WglIbrvB0k/dxGH12H2Aeh9Pr/taJ9/uCkGMGX9/wsT1Y4skE9
         /UTxMBZG7iBZuyAUb8ebwEk1oJFNV6kZe1yirbClSBmTet3x0V6LPImkea3wFhDp/612
         BdebUzh1qeR4eQWxCPE6lUjNjZ2sVBaaGYythBQYywZJGgRLWmXWF6xmTR6ljr2rYAJ8
         9/HJbNq4BIbCF7oeQrsKuD1lYBV7gsfaW4Pt1Er+MYEr3fqfsGYEP3FYRzRbGGWHFoJV
         ATaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SwDO0i0fqjqyoIRgY+ZZt4h4DIJn4R+h9rsWoZMPFOI=;
        b=Jlsf8v7SchKQTx2iLXgUjk/1kLD1b6QGjCnI30xW8wUjquBybc3j/jG2zHAyffBCTO
         Fq7wMwUYNe+bo0nLazLaeXDWCPtlfcrb0BpvCy/0Cd/Nx0zdFJSjx1YY+NqnPkSioEpv
         eEE03C4O2IIo3z7aa8PGGg10ivOMc+/iHZkaDNUr0VDSIc2oFGLLLw2GoG1qVns64vJo
         IUnkwNsC7GY3kx98X+F//hwbiDgFu8DDrfAiakAAqb9tOI876cHb3O8pjnG0vo0ZGFkh
         7WLg1N0SQLUwJIFz4mG+YNzkqXUXlFenCp/zsjsqlukL5xoFsUYUT842k/wB0wjQFsYO
         Ezdg==
X-Gm-Message-State: AHQUAuZ//pyUvfDJwdxJYFFAAlOzYHVT4qQMQWKsGF0EH/uMRxkUM93O
        uErRWrYErAKy8+6e2arnVFI=
X-Google-Smtp-Source: AHgI3IZw7JLGYm1pzmFGeCDC9vDGAb6bOjeezw3FSLgusAoQZZgpOluBLLqihTGL+WrOe6M1SOVXHg==
X-Received: by 2002:a63:e309:: with SMTP id f9mr9662450pgh.280.1549514152799;
        Wed, 06 Feb 2019 20:35:52 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id b68sm11436236pfg.160.2019.02.06.20.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 20:35:52 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     khilman@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        quentin.perret@arm.com, linux-kernel@vger.kernel.org
Cc:     linux-omap@vger.kernel.org, linux-pm@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/2] cpufreq: OMAP: Register an Energy Model
Date:   Wed,  6 Feb 2019 23:35:50 -0500
Message-Id: <20190207043550.3890-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try and register an Energy Model from omap-cpufreq.c to allow
interested subsystems like the task scheduler to use the provided
information.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/omap-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpufreq.c
index 71e81bbf031b..68052b74d28f 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -133,8 +133,10 @@ static int omap_cpu_init(struct cpufreq_policy *policy)
 
 	/* FIXME: what's the actual transition time? */
 	result = cpufreq_generic_init(policy, freq_table, 300 * 1000);
-	if (!result)
+	if (!result) {
+		dev_pm_opp_of_register_em(policy->cpus);
 		return 0;
+	}
 
 	freq_table_free();
 fail:
-- 
2.17.0

