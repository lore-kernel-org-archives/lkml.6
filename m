Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id FfsFLw12GVslEwAAmS7hNA
	; Thu, 07 Jun 2018 18:16:13 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0F0CC608C8; Thu,  7 Jun 2018 18:16:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8CBA4606FA;
	Thu,  7 Jun 2018 18:16:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CBA4606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936222AbeFGSQK (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:16:10 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34090 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936071AbeFGSNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so4070572pgr.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SWb5QeE+21llbmN/IZkUxeVqFa2RAmJAr0TMkSP535Q=;
        b=EuBA0SKieI8yW8lZ/sTTO13zDI4ypvysBhSKSjLOnbPIIp/JY0ZAZddmbuHHMG8sqW
         bQL+Gh/Zo+rrzirlL2stnkTk1W7Ad0mwGZmMmGVrPtugI6znJed2xRE0xud9WL76b/qL
         g+tr/yyD/lQniIROxJiG11zSNWwwBqQiiE6EC2Pz9E8b8kU+edYhPTusXkxPQTbIxVNV
         augpQj/mbkkF4UiKxIuO+1CJF1LOheOmARZ54Hh6eDFnkZdcsI9Tpdilu7SlTyt8nIgA
         HvAkhVCP66VnIyLla4vfP52viV8q6KuY9VcmbWiO1DynIzbCccqthvVOKgG4NNYuhT7V
         gBQw==
X-Gm-Message-State: APt69E1j95b53vX9MQRhT8uiuRC+tFlTukMaWU4PCOxvVahkoH4d60X9
        TrQhFXiIVDMo3lfJnCwM+dZKVw==
X-Google-Smtp-Source: ADUXVKJinG8fg6t90/YZ2x63em5SpHT/26VBYyEJ4SPZpuz0nqBAUHad4uENRsT1Nc1d1a4H3F55ag==
X-Received: by 2002:a63:18c:: with SMTP id 134-v6mr2439035pgb.138.1528395180574;
        Thu, 07 Jun 2018 11:13:00 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.12.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:12:59 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 06/11] PM / devfreq: Make update_devfreq() public
Date: Thu,  7 Jun 2018 11:12:09 -0700
Message-Id: <20180607181214.30338-7-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently update_devfreq() is only visible to devfreq governors outside
of devfreq.c. Make it public to allow drivers that adjust devfreq policies
to cause a re-evaluation of the frequency after a policy change.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
---
Changes in v2:
- added 'Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>' tag

 drivers/devfreq/governor.h | 3 ---
 include/linux/devfreq.h    | 8 ++++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index b81700244ce3..f53339ca610f 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -57,9 +57,6 @@ struct devfreq_governor {
 				unsigned int event, void *data);
 };
 
-/* Caution: devfreq->lock must be locked before calling update_devfreq */
-extern int update_devfreq(struct devfreq *devfreq);
-
 extern void devfreq_monitor_start(struct devfreq *devfreq);
 extern void devfreq_monitor_stop(struct devfreq *devfreq);
 extern void devfreq_monitor_suspend(struct devfreq *devfreq);
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 8a4c0f10a394..781edefb0087 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -222,6 +222,14 @@ extern void devm_devfreq_remove_device(struct device *dev,
 extern int devfreq_suspend_device(struct devfreq *devfreq);
 extern int devfreq_resume_device(struct devfreq *devfreq);
 
+/**
+ * update_devfreq() - Reevaluate the device and configure frequency
+ * @devfreq:	the devfreq device
+ *
+ * Note: devfreq->lock must be held
+ */
+extern int update_devfreq(struct devfreq *devfreq);
+
 /* Helper functions for devfreq user device driver with OPP. */
 extern struct dev_pm_opp *devfreq_recommended_opp(struct device *dev,
 					   unsigned long *freq, u32 flags);
-- 
2.18.0.rc1.242.g61856ae69a-goog
