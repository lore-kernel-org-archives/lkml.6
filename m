Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id AAwUMxbFGVs1YgAAmS7hNA
	; Thu, 07 Jun 2018 23:51:50 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C2450608BF; Thu,  7 Jun 2018 23:51:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4C2E560290;
	Thu,  7 Jun 2018 23:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C2E560290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeFGXvr (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 19:51:47 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46718 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbeFGXvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 19:51:46 -0400
Received: by mail-pl0-f65.google.com with SMTP id 30-v6so7103835pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 16:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=K/ObkKebp8yIyKl4PklZLIsrYO+D8hbGnzTU9YOjyMs=;
        b=el0g34MqYyukqoCzH/9feR3o0QVBsBtRl8DW2KPLBdGs35tm75V28Q1PsWLc+jCtvD
         JbrpmGI3V7Hy+w9NhkYQNwJ/rHghazzixTVQWjalh5PSHnsFAL87Lf4lkvlQEOlUi8ma
         tyICdkh+Zn11a/88fhuvFsj+5MWBGh1utm8K76yqPoa2R47Tr1oFqdLC25Lo+E6JcbNx
         g9n0EIqRjGk3PPns4md4J1ZB8qFlQjac6d08ton9PAZfyTm1IQDqW9DSFBnSwf/h5fsI
         5kchTBQQzwiQfEPd+/MjUzTUj0g1o+2eU8Y3uXpk/R+/jpN7WkLyFnvxslpbxXPva/Y9
         fAjg==
X-Gm-Message-State: APt69E26mr7R9M1f2VNt2v+EGUlVTVWy3guXY56oWH7wbfENE1OgdCu0
        1q+xJaeLb1f/u1K/rxwvVLsW3g==
X-Google-Smtp-Source: ADUXVKKILV2Um9YlDIjvqzuHKhhPXr4pkYZZULWqQyzI0Bx8dv4jc1guL8mM2Ad80a3zqiNEjjSLfA==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37-v6mr3959487pla.219.1528415505695;
        Thu, 07 Jun 2018 16:51:45 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id u68-v6sm96138299pfu.32.2018.06.07.16.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 16:51:44 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] regulator: Fix typo in comment of struct regulator_linear_range
Date: Thu,  7 Jun 2018 16:51:38 -0700
Message-Id: <20180607235138.92819-1-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regulator_map_linar_range() => regulator_map_linear_range()

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 include/linux/regulator/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 4fc96cb8e5d7..2dc4f575de17 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -44,7 +44,7 @@ enum regulator_status {
 /**
  * struct regulator_linear_range - specify linear voltage ranges
  *
- * Specify a range of voltages for regulator_map_linar_range() and
+ * Specify a range of voltages for regulator_map_linear_range() and
  * regulator_list_linear_range().
  *
  * @min_uV:  Lowest voltage in range
-- 
2.18.0.rc1.242.g61856ae69a-goog
