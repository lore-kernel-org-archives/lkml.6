Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A937CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA5320C01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9GYHntt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfBTKK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:10:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBTKK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:10:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so11913071wrg.9;
        Wed, 20 Feb 2019 02:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3D+XTIEUOTjhZ2BKLbZAfSOYR8kUUWV4dWyt4F/COIY=;
        b=T9GYHntts/YawcK/FOT9O0B3XjZ9SOk4avtf/W45Fl1fStc9Srfw3EMyXe4cFKAZxP
         CQyeFV+PTVPLdYi8xVHA1DTdGurKkkEHn+NQmLWgYNuqVkFGMnDdzOhcFQbAqpfJIYgn
         ek0sdoAoPLjuPwfM5uv7d1OPRStactL4nUwuyXU5TkI5di03bgqUocmlJZi+v5K0FOoI
         9X1T+6j1epGhMx9gr9KUoiyqtzODOtdafIeBAgBh5L1ls8KiEx9nJToAXYFYq/13kpbz
         jMqIzPb6j8ksiOcScg2wIfWO2QpQ5PNpyXPDHBHOt2ASHF/D5hOG1w1yEOwBD/WTCuo9
         3kMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3D+XTIEUOTjhZ2BKLbZAfSOYR8kUUWV4dWyt4F/COIY=;
        b=sXDldFvE7ZJ04pwILJCBqXzi4HNElzLNtuWmLUmP8+Y/r57qNKQaDYKgmpQ9mvsAw/
         PweGZTZaixgH40qiAFIeHTfok7CiXnw7QsfznCfPcPFPogik57IvXYMQ+uPP+gItWMDg
         FDDrPVAIdS+6s6AahDabWLgeQ+y4/sKWAVNXyoQ5P8xtIlDV9w2qvvxsr5gB9qWdiW7n
         d/4mCMek5ZQa3ovKkAx3lzxaMY7c73gfAVtM7PmgIxt3mHMFQ+EoOJ0itz2v9QJi7YgC
         RdLa7lQ6aacTfEVwBjQDaulK8TyWVgO/xlxWnNXyGwGkk9EQJuGR07mkDhIsa7yBzgUi
         cIEg==
X-Gm-Message-State: AHQUAubN7rqQ/K9DzywBICWV5A45qVKCM82nuRrQ9JvWgngu1bFkLi28
        aoU0H53USAvGcitxGbnL/uplV1KNWjo=
X-Google-Smtp-Source: AHgI3IZNhCo2bUqqF0ndb4wHZm+ub00yPuYa2Lq7BzJdn8EcFmd1eW/Ex75jmqjs6G14/3sEOv3x2Q==
X-Received: by 2002:a5d:6a88:: with SMTP id s8mr21850914wru.303.1550657457622;
        Wed, 20 Feb 2019 02:10:57 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id b4sm8290712wmj.3.2019.02.20.02.10.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 02:10:56 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] cpufreq: Report if CPU doesn't report boost technologies
Date:   Wed, 20 Feb 2019 11:10:17 +0100
Message-Id: <20190220101017.19587-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some rare cases where CPB (and possibly IDA) are missing on processors.
This is the case fixed by commit f7f3dc00f612 ("x86/cpu/AMD: Fix erratum 1076 (CPB bit)") and following.

In such context, the boost status isn't reported by /sys/devices/system/cpu/cpufreq/boost.

This commit is about printing a message reporting the CPU doesn't expose the boost capabilities.
This message could help debugging platforms hit by this phenomena.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index d62fd374d5c7..06d32d21dac0 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -916,8 +916,10 @@ static void __init acpi_cpufreq_boost_init(void)
 {
 	int ret;
 
-	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA)))
+	if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
+		pr_debug("CPU doesn't expose boost capabilities\n");
 		return;
+	}
 
 	acpi_cpufreq_driver.set_boost = set_boost;
 	acpi_cpufreq_driver.boost_enabled = boost_state(0);
-- 
2.20.1

