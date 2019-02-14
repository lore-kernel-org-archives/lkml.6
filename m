Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23F720836
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MF5SQMCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406628AbfBNSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:13:18 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38556 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406517AbfBNSNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:13:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so3559575plb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Dvqa6iVY6F7Vo+3Xrnek+h67MkNMGSU2J4pdYcSRRY=;
        b=MF5SQMCl3c4P8M5YyYMhkZkLeGuGx3K9xcGMs/2QQhtqa2FZ3hdR0lE+qF/xiCHCqM
         aGrjpeF8htWuXSQ2yMNiU4sG9ZAyNQPSUDaZwvNpTSjdnLDM9KLnDeW1RjWUKsCKxLZL
         x90JYmYlYPN/DkJ/mwA4Acqw+46ApLMz2i96o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Dvqa6iVY6F7Vo+3Xrnek+h67MkNMGSU2J4pdYcSRRY=;
        b=Ah+MTbAqmWH911fBbP7Q3TA6dzYglB9eJlSbHPsN/Y30GJDUtTLon0+/h23Av+ySpo
         LNYvZkH0GCA7qJEWwu3Uw1WaeGMfAfTVh8hEuCncvt63YEcwfUQLhjlflUOnlZ1M21jV
         5Vfo5ACmAiDt7eWgKDFkbUGYJVvj8QwF7fiplq2sQSzBAz7efONAZz/XSfQ0rBdFXIDM
         1sZf0TcvJDoUG8ZJw2a1fMGIGlnY5HhH03FedpjT5P9IElc48o560YW+dgoXdxGoB1CK
         EAS91tQD1owB/XJ4TeCd1dlPy2hUG1yN6fLWR6u8gueF4u5GcXzi94rtC2394VDcdcqF
         y6tg==
X-Gm-Message-State: AHQUAuY/m97xCTprZTEw6tQCr/z4t0t8T1Iy9eajiLP7YnCfOrkS+DDW
        RhbzGcbwmqYJ92v1NQp9LBi9+A==
X-Google-Smtp-Source: AHgI3Ib637XpxjjynIIZr4+xkQZeuKhMCoqsBVCc47DrFI8TTyHEMuNirhTWU0kFjCpI3miN5FsmNg==
X-Received: by 2002:a17:902:7081:: with SMTP id z1mr5490121plk.231.1550167996508;
        Thu, 14 Feb 2019 10:13:16 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y21sm6096349pfi.150.2019.02.14.10.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:13:15 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 2/2] PM / Domains: Mark "name" const in dev_pm_domain_attach_by_name()
Date:   Thu, 14 Feb 2019 10:12:49 -0800
Message-Id: <20190214181249.2749-2-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
In-Reply-To: <20190214181249.2749-1-dianders@chromium.org>
References: <20190214181249.2749-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of the patch ("PM / Domains: Mark "name" const in
genpd_dev_pm_attach_by_name()") it's clear that the name in
dev_pm_domain_attach_by_name() can be const.  Mark it as so.  This
allows drivers to pass in a name that was declared "const" in a
driver.

Fixes: 27dceb81f445 ("PM / Domains: Introduce dev_pm_domain_attach_by_name()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/common.c | 2 +-
 include/linux/pm_domain.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index b413951c6abc..22aedb28aad7 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -160,7 +160,7 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach_by_id);
  * For a detailed function description, see dev_pm_domain_attach_by_id().
  */
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
-					    char *name)
+					    const char *name)
 {
 	if (dev->pm_domain)
 		return ERR_PTR(-EEXIST);
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 203be5082f33..1ed5874bcee0 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -341,7 +341,7 @@ int dev_pm_domain_attach(struct device *dev, bool power_on);
 struct device *dev_pm_domain_attach_by_id(struct device *dev,
 					  unsigned int index);
 struct device *dev_pm_domain_attach_by_name(struct device *dev,
-					    char *name);
+					    const char *name);
 void dev_pm_domain_detach(struct device *dev, bool power_off);
 void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
@@ -355,7 +355,7 @@ static inline struct device *dev_pm_domain_attach_by_id(struct device *dev,
 	return NULL;
 }
 static inline struct device *dev_pm_domain_attach_by_name(struct device *dev,
-							  char *name)
+							  const char *name)
 {
 	return NULL;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

