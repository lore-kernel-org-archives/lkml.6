Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF73C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F4E20837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F4E20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeFUBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:53:12 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:40070 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754420AbeFUBxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:53:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id w8-v6so639124pgp.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Nsp0g8YXr2r0a/RUnmIzUqht+fwpZClvdZQU3BCvCY=;
        b=Gx0RX88YCixHx+bFFgFAHWMPOcF/tIOX4kO8nSr+ubFFb/jUI/m+Z50zQqzWoV5akv
         KMWtn5EiCRMJHzLO1Y/IGHiq3ZM9NZg02pCOyZhk239AwlFCHm+0cTJWGpvFziaDtrrB
         SLbD2N3Xt79VktuS5iKaKrmJs9rAKlpavB0F0Luaf5+WAaLQNV9vPqRyk+LKWE2ZbzmN
         cWJejaXgRzTtPytH1DIEb4C51a6WLi5HrJKPWFXGOJ4lKPtzRU4FfiOk9vouJdFGypi3
         1FWpX3qsZXB34LOs9Kd5J6EXjA/wdvsdBHvY7YW3s47emxxs2hS/1JnN1/CiewmkMwsC
         uOQw==
X-Gm-Message-State: APt69E1LzcV7mtLOloAkx8xnK/bCXeWt+wDPcH7hN0KuqTgUEaHuKNvS
        1naEhurXx2cbI3hUTYwatY51YA==
X-Google-Smtp-Source: ADUXVKLUlDpx9rB6bF8Ra/Sp6wLJqRq8lLMW6cIjVHsi/Ysat69kLRcOrU8XN+EmLivnzCcemihvRA==
X-Received: by 2002:a62:ca99:: with SMTP id y25-v6mr25075350pfk.187.1529545983551;
        Wed, 20 Jun 2018 18:53:03 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id p12-v6sm6585877pfi.175.2018.06.20.18.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 18:53:02 -0700 (PDT)
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
        Benson Leung <bleung@chromium.org>,
        Olof Johansson <olof@lixom.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v4 07/12] PM / devfreq: export devfreq_class
Date:   Wed, 20 Jun 2018 18:52:32 -0700
Message-Id: <20180621015237.100100-8-mka@chromium.org>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
In-Reply-To: <20180621015237.100100-1-mka@chromium.org>
References: <20180621015237.100100-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporting the device class allows other parts of the kernel to enumerate
the devfreq devices and receive notification when a devfreq device is
added or removed.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
---
Changes in v4:
- added 'Reviewed-by: Brian Norris <briannorris@chromium.org>' tag

Changes in v3:
- none

Changes in v2:
- patch added to series
---
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
index c4f84a769cb5..964e064a951f 100644
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
2.18.0.rc2.346.g013aa6912e-goog

