Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DC6C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6168A222E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaHX6me/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731183AbfBPQb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:31:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45620 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfBPQb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:31:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so6262447pgc.12;
        Sat, 16 Feb 2019 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LO3QrEf9owC5ZOEMrXxiFtSgd/NWCotfP8eeokdC2i8=;
        b=PaHX6me/h9dvQWxmJNZs39smveT2uy2UddFwRbuTcGq/9ARB9PsJt0pSJ10sloH9SE
         /8+G0FtEAB/xfzk9RJ9XiDegqWST7Gjhly2pAY2GkR0KpMfo56rf9OOq/YKV53KLQ4lU
         hmp+5KVM29VeOS5/j+etuOjOf0N1C/tHQt9/c2SAYZT9vWpv8uAf2OiWcw/RHQScAlNu
         +jVA5cRmFGRdWvc928IxlO1XIkUg2V5RVSEX/VW9/QlTlX1Zmz9pfW3p8FuGaSf4MprX
         PkF3tTwGBukjOGontQiOiW9nYqRS4gtj2ju94V593DGUYUE6TBMk8LJNYw33ffKIFdlF
         ouJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LO3QrEf9owC5ZOEMrXxiFtSgd/NWCotfP8eeokdC2i8=;
        b=j4LZm1dZUe98P89m0U7eLbvqO7rRzK7Z0mVRg2bwiyjZjhJEFJEgVwKX1A7obt2N9G
         l2h/V6zi7IUZmce9yquyw21srIVCnS0UhziSYZhTirkCqVPlu6jX9tin0OQ70JNW6Cp7
         bd4tLxlfCnUDoBe8qUbHYhGIb0nV/QwIxxvYuWTYK+kwtzxQ+5A4n4YG6vk38/64y7Z0
         QyK1Q6B64tBYpXNPifbtoteaG8J1nB1Ahb0DHHMvrLWTNUrJ2KvuDT2ZVVfRswwWM7Bk
         NJuhsyhCVVq65TvkAJiGIS5Ly2qKwPizFVwyRXe7ob5SuLSfkUOQo1AXEUUvEN0peC93
         ECrQ==
X-Gm-Message-State: AHQUAubU6ErALypjQDJKvFWIvezG/jDD5Phe+Mu82+ngyLNja4QjPA4r
        XW+FkdElTBOmmFmrOud1wRY=
X-Google-Smtp-Source: AHgI3IZA8RrwU96a2b4ROhL2T4Xuw9ulV3+X8XQn3r4wK1JP1Szg2+fr5WaoBClngjdv4YK0LszfJg==
X-Received: by 2002:a63:f10c:: with SMTP id f12mr14667460pgi.374.1550334715958;
        Sat, 16 Feb 2019 08:31:55 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l22sm14763633pfj.179.2019.02.16.08.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 08:31:55 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     sudeep.holla@arm.com, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: scmi: fix use-after-free in scmi_cpufreq_exit()
Date:   Sat, 16 Feb 2019 11:31:48 -0500
Message-Id: <20190216163148.12375-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This issue was detected with the help of Coccinelle. So
change the order of function calls to fix it.

Fixes: 1690d8bb91e37 (cpufreq: scpi/scmi: Fix freeing of dynamic OPPs)

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 242c3370544e..9ed46d188cb5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -187,8 +187,8 @@ static int scmi_cpufreq_exit(struct cpufreq_policy *policy)
 
 	cpufreq_cooling_unregister(priv->cdev);
 	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
-	kfree(priv);
 	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	kfree(priv);
 
 	return 0;
 }
-- 
2.17.0

