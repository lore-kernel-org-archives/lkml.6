Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8190C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A23A222EE
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 16:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9w2grQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfBPQPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 11:15:07 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42405 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbfBPQPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 11:15:07 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so527004pgl.9;
        Sat, 16 Feb 2019 08:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ReTQZo60sGXBPg6k+sT2jbe543Cdh/eIkIUhoU27/xY=;
        b=F9w2grQhklcd1YfLoVfIGSlLy7NsRTpsT0GMTERpfXG1cNgsn14Fxxe1ntqihAXbbw
         YR4oIfCPi4AgzK0NBk68tdpXXFFAUSO6ks5V7D8aOEwF52m1SwI2fg89mFHbiVSdNFWb
         wR6sekQIus2WsPE+jDuKgWmFWF9GcP7Ln+IEv95QxM/VzLOiaEMKfzCHXL4E7jWo6h2f
         Su97xnWiq/U9k/xUGdx/1cKEGYdahhnRmM1m/GX8KurhTkoh8gRA8sxLKoPrzO83/reB
         FFZoKu+EPEjJ/gz4CwcP1r1eWkJFglJRH/8jkVnRXcLYRcPy1DOqhQjxAG6SD8/nSUHp
         bSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ReTQZo60sGXBPg6k+sT2jbe543Cdh/eIkIUhoU27/xY=;
        b=csmP8HSsmnjdCpCcbxAq4K+wJtASPji6R3CeHp+fF9lDPf6bQl6GgAAIgX2fGDPjmF
         U4WD7tUW2H58m64fHa+ITTRWtf0VdqCh5sC0tNB/b7jCdj3TqJll3qZW6pbpAfBQqNuO
         qkwCAGIqoRuXDWwobzrUtLDlPMq12anQJjiRZFURRONI4B8vzI8v2cztsdcXpH384fJs
         028CsLdI80Dy4eLORhEbQJ4aoo3U6ofmZyMeo5rh5DnbWsAacfbVpxbXrAJzNgHZ5Wwq
         JzPjnoyG71ny3GQ8Yr89Jtsk3IUg2k6FdRinHgigDy1Lps1wEltvlCgUX3NZJNsvFrwJ
         KbbQ==
X-Gm-Message-State: AHQUAuZmJR7M+o2AL7X+/oDwPZ0VHYgQiWkHlsoLP1Qwmst0nVYFo6PE
        GikSEpgQ/eNwwK8wDGmKWO4fpZIqaW8=
X-Google-Smtp-Source: AHgI3IbiaMe3/hGdHH6wYM9ulqhffU2465Pw8xJNoTStroojHFUe76RsgQ4Po9MXn+gnnINfJJ+DPA==
X-Received: by 2002:a63:b70b:: with SMTP id t11mr10559120pgf.404.1550333706377;
        Sat, 16 Feb 2019 08:15:06 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l12sm18629766pgk.40.2019.02.16.08.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 08:15:05 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] cpufreq: speedstep: convert BUG() to BUG_ON()
Date:   Sat, 16 Feb 2019 11:15:01 -0500
Message-Id: <20190216161501.12168-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix coccinelle WARNING.

WARNING: Use BUG_ON instead of if condition followed by BUG.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/cpufreq/speedstep-ich.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/speedstep-ich.c b/drivers/cpufreq/speedstep-ich.c
index fbbcb88db061..5d8a09b82efb 100644
--- a/drivers/cpufreq/speedstep-ich.c
+++ b/drivers/cpufreq/speedstep-ich.c
@@ -243,8 +243,7 @@ static unsigned int speedstep_get(unsigned int cpu)
 	unsigned int speed;
 
 	/* You're supposed to ensure CPU is online. */
-	if (smp_call_function_single(cpu, get_freq_data, &speed, 1) != 0)
-		BUG();
+	BUG_ON(smp_call_function_single(cpu, get_freq_data, &speed, 1));
 
 	pr_debug("detected %u kHz as current frequency\n", speed);
 	return speed;
-- 
2.17.0

