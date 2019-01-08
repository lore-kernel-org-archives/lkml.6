Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD4AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E13020660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIXyMLEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfAHUFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:54 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42295 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732070AbfAHUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so3870515lfh.9;
        Tue, 08 Jan 2019 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=guPCTwuWnn47rPONmcgssOljllOslnow0b18H5K7mjI=;
        b=LIXyMLEBheOJO3UAd9rTK0qeugFaM2RBAkfmNV0KTvKGlnkjD8AM+hWkuZ2ALCY0AV
         X/YOpK6l9DlwYTpfVIPLQ45RCkVeGW7xOYw5AKBUudMZ7uwcqmdhIsflNSqiOfrQ3muS
         9g1PbWTm7BPsElNOaTEO3j+vGh1WubrQCuuxoiFDY833BRGvkWxQjZv3NWkV2rnJ5qua
         hZP6SA/82NckRg2twRkmDdj47lOUrTzGEvn4zhcLaNX6ci2iEbdNONNPhz529vtmiUeR
         wqergCCjpmbR0PQz8Xq4OzD/YGMT2npObu/ulteYwyCJUd0DsXbOvPjAiE/vm8iJFci/
         pPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=guPCTwuWnn47rPONmcgssOljllOslnow0b18H5K7mjI=;
        b=YRStbyOHCvwog6RvzclIPeC0qdODU3+6IOlE5reXb046UMlO3lb5xu3o8OjmQNy0X9
         aB5neVvVgOdC3n2JQ1FUU4BHELy3Ijr8uuQ40u3294eQ/cXqr4ggGh22qtGo3NXszQQr
         dtWAR3EM4oVV7adobaj1WaNprYWxVmD7J2OfQEMp26w97PoX2GpCpA6LldUyXowJ6WAm
         KLhgw7tD67HmNpenGVsnNMbAoOavkwdjuU4zCf4E1dR8u1iPLZPzWkrT94emoGoxihHF
         zyhU7xw/NQ7HD3J5rKD/xXbfoZI7sM2uzpA1SLNWEpr/Wa2yV8cavmr0AHqnz6LlliLs
         a1MA==
X-Gm-Message-State: AJcUukd+AROHG7cxAQYzhyHxTGxw8Vk4DONT7QN4eZHjpWM5fQPyBCPi
        UwcjurpaV6wv7s9IZTVIrzM=
X-Google-Smtp-Source: ALg8bN5Tg3hlmHVJyiBjR7tOBcXM6cK0vSXgZxUTEU4dG4QVgn9I3JC31Hr6TBOtFWvOVpy3xQxK0w==
X-Received: by 2002:a19:e01e:: with SMTP id x30mr1778838lfg.89.1546977925100;
        Tue, 08 Jan 2019 12:05:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id y23-v6sm14486768ljk.95.2019.01.08.12.05.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:05:24 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/4] cpufreq: s5pv210: Don't flood kernel log after cpufreq change
Date:   Tue,  8 Jan 2019 21:05:07 +0100
Message-Id: <20190108200509.30494-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit replaces printk with pr_debug, so we don't flood kernel log.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index dbecd7667db2..f51697f1e0b3 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -481,7 +481,7 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 				arm_volt, arm_volt_max);
 	}
 
-	printk(KERN_DEBUG "Perf changed[L%d]\n", index);
+	pr_debug("Perf changed[L%d]\n", index);
 
 exit:
 	mutex_unlock(&set_freq_lock);
-- 
2.17.1

