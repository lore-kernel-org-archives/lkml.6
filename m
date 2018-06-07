Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EfsFLw12GVslEwAAmS7hNA
	; Thu, 07 Jun 2018 18:15:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4A3C26089E; Thu,  7 Jun 2018 18:15:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C7E68601C3;
	Thu,  7 Jun 2018 18:15:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C7E68601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936215AbeFGSPw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:15:52 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:44469 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936073AbeFGSND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:13:03 -0400
Received: by mail-pf0-f193.google.com with SMTP id h12-v6so5295033pfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=anGDpg5EHhH3QthmKRd1WTRFpVpJdc53yNgix7wJQi0=;
        b=XmF/yChutTBg+yu75p4pynlXOt7t4SK6uAQq+aFRhbS+3tj+kVX8VhBcic71EMHBfv
         dJcA6wKrr0oUAE67s/VfCozjKMnlwcvKX62s5dqL2FUsSt9btUzSNQpLIOVUQ6qZOZ0n
         kJb5EtwadWyiwI8qm0Hf5NzL842H5z2iyV2swP5jF0OcCYnkn1fjJxJDo0w3fhtOkTYT
         CBXtsrcfDg2TWOlnHRgnEi6h8HO/LRJofT8C1ZUIVf4HvuHKU4BmlYYkc+IWOh3bLI54
         KL1lil3c7U8yb+06ePKDS7VHvc3gKcuAezYj0PPFYgTEd4fw66oYaR/pYmYkQtPtfPSw
         OD4Q==
X-Gm-Message-State: APt69E2TzKbjOs9Jl1c+oAbQMekfeLmum4dcfxKMqU+zy88p8OKF+O/C
        Thshdm25FhwUnshQhA343pWeUw==
X-Google-Smtp-Source: ADUXVKLrCvDBQjHPOB6FrxTcr0TgOj2+Tjb3T1SIOUXRpbPrj7HfoB6T3OyPViCo4NIF5PYEfJxDMQ==
X-Received: by 2002:aa7:8311:: with SMTP id t17-v6mr2760690pfm.45.1528395182584;
        Thu, 07 Jun 2018 11:13:02 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id z3-v6sm5029002pfn.36.2018.06.07.11.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:13:01 -0700 (PDT)
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
Subject: [PATCH v2 07/11] PM / devfreq: export devfreq_class
Date: Thu,  7 Jun 2018 11:12:10 -0700
Message-Id: <20180607181214.30338-8-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
In-Reply-To: <20180607181214.30338-1-mka@chromium.org>
References: <20180607181214.30338-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the device class allows other parts of the kernel to enumerate
the devfreq devices and receive notification when a devfreq device is
added or removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v2:
- patch added to series

 drivers/devfreq/devfreq.c | 3 ++-
 include/linux/devfreq.h   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
index 4cbaa7ad1972..38b90b64fc6e 100644
--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -31,7 +31,8 @@
 #define MAX(a,b)	((a > b) ? a : b)
 #define MIN(a,b)	((a < b) ? a : b)
 
-static struct class *devfreq_class;
+struct class *devfreq_class;
+EXPORT_SYMBOL_GPL(devfreq_class);
 
 /*
  * devfreq core provides delayed work based load monitoring helper
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index 781edefb0087..99d1e02531dc 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -206,6 +206,8 @@ struct devfreq_freqs {
 };
 
 #if defined(CONFIG_PM_DEVFREQ)
+extern struct class *devfreq_class;
+
 extern struct devfreq *devfreq_add_device(struct device *dev,
 				  struct devfreq_dev_profile *profile,
 				  const char *governor_name,
-- 
2.18.0.rc1.242.g61856ae69a-goog
