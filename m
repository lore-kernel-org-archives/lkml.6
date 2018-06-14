Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 472C2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E2C208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 19:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E2C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755532AbeFNTss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 15:48:48 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36551 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755470AbeFNTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 15:47:34 -0400
Received: by mail-pg0-f68.google.com with SMTP id m5-v6so3383036pgd.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 12:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Am8u4T8YEJ192VlnC7mxIIJ+wIqtTkEuSaMw62gHrDQ=;
        b=Tt9lEMzD7tZD71ONtzsOiSFzDv04MA2zJT8sLHo8styZwOs5jtGn5FbIpm3H8MX2yV
         7kxejtTnPd9n1Xjr4KnO9rVZXt9tQzWyQKoUwohzxxO8IZogkfBTiMlahD2WFZi1gcqr
         Ai5SoVs/PnlJd5aQPRkeTP41F92FzGUvzyITuBgo8wuFh3Ld81ZCRPI9qygNwEqZW1jX
         iNkdU1zZ+E14VvhdGpNXfZL4t3u0fCLJkXoKHsF0hM8B0dcMudzsto2npcKxDakrCufW
         bqW7gpfCOrPqExz8BkLsLGji8XEmiG7ZKkxvhFZMhqnbwHT2egYamxzgLOJ2PNyWaHkg
         yF2A==
X-Gm-Message-State: APt69E1OMzb7UOWiasMpaSyv+gWftk0Y5iyMax7tuMl1NYTERNgCsXC2
        ycssfLF87hK0SjUNhikfhq9nLQ==
X-Google-Smtp-Source: ADUXVKJe7oMJW85vYx0DH93lfaE/O/5lqhXb1ziL5fBa7YBVZS0JnPSh3TamO591vAGEA48Hb94MsQ==
X-Received: by 2002:aa7:8148:: with SMTP id d8-v6mr10870894pfn.78.1529005653643;
        Thu, 14 Jun 2018 12:47:33 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id s28-v6sm9955506pfg.89.2018.06.14.12.47.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 12:47:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 08/12] cpufreq: Add stub for cpufreq_update_policy()
Date:   Thu, 14 Jun 2018 12:47:08 -0700
Message-Id: <20180614194712.102134-9-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180614194712.102134-1-mka@chromium.org>
References: <20180614194712.102134-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq stubs out some functions when CONFIG_CPU_FREQ=n , but
cpufreq_update_policy() is not among them. The throttler driver
(https://patchwork.kernel.org/patch/10453351/) uses cpufreq as one
possible throttling mechanism, but it can still be useful without
cpufreq. Stubbing out cpufreq_update_policy() allows the throttler
driver to be built without ugly #ifdef'ery when cpufreq is disabled.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v3:
- patch added to series

 include/linux/cpufreq.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..dba8c4951e2e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -210,6 +210,7 @@ static inline unsigned int cpufreq_quick_get_max(unsigned int cpu)
 	return 0;
 }
 static inline void disable_cpufreq(void) { }
+static inline void cpufreq_update_policy(unsigned int cpu) { }
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.18.0.rc1.242.g61856ae69a-goog

