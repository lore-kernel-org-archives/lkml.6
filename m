Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889BAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5679C20836
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SLPmARNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406558AbfBNSNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:13:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43838 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406496AbfBNSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:13:16 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so3551420plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC08aLvBr+4Oh14cEtpFriUr4EgUUFtSeVaV8LlSrVA=;
        b=SLPmARNU2JN9//Z4a8UidPtnkYpl6b6U74JlJydrltSc0TbkUgguDp2tbYG9Yer9tO
         LBcIsuhRTqEP8hbMjZiolWBRC1S4RaQEbyRuFFNZ45Jdhp/JrztOdykrKY+sus80+wo7
         QdGadpWdqdN13o2G4Dk4L1Df27n5K7X/yUdiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KC08aLvBr+4Oh14cEtpFriUr4EgUUFtSeVaV8LlSrVA=;
        b=lDKlEymBjJemhYYeyOtFJJuHs+NaSzlDzXfDu+l7xQYYyIcMwnkuKreSFHPSjyL/1t
         tykAlJXJ03Kq55hFgpUfBnsxL/yIojFrjDHal5eRRUtF8CIOSzQwTNX5PUK81EsjM+5f
         hKOPgQyRTbwprMFzAh+QbHIwvwd075P240b1DkPexBcZnXd5XsuDo1c3DyBNT0ei1hY6
         l+W8VzS5ByQ0HOL/aJrP7u/0YSqY0y3nD8oQHNo3ua3G23LRGLMFFYl8iESTm4wuVvYT
         O4GN1iqhGCaCOd3nkkpd/ECzfKZoWx3UOrNy9bzJajsamcPjoTrsJ7qpHvSwkRDc36OS
         xYcQ==
X-Gm-Message-State: AHQUAuZCXcCMa2RShs+ExHBP5goGoQMoEtUmJuoAybPkFP5Mi8siofoo
        tsbRnowh1g6c1cxsxgmzKHLK4w==
X-Google-Smtp-Source: AHgI3IYhNSFVSJ0c8erX0wD63Ext/3iDCfzgnUlwTHONVz4T9kLmGR4mCI4Lf2YX88InSHGYNtD6hw==
X-Received: by 2002:a17:902:6681:: with SMTP id e1mr5490698plk.98.1550167995113;
        Thu, 14 Feb 2019 10:13:15 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id y21sm6096349pfi.150.2019.02.14.10.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:13:14 -0800 (PST)
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
Subject: [PATCH 1/2] PM / Domains: Mark "name" const in genpd_dev_pm_attach_by_name()
Date:   Thu, 14 Feb 2019 10:12:48 -0800
Message-Id: <20190214181249.2749-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The genpd_dev_pm_attach_by_name() simply takes the name and passes it
to of_property_match_string() where the argument is "const char *".
Adding a const here allows a later patch to add a const to
dev_pm_domain_attach_by_name() which allows drivers to pass in a name
that was declared "const" in a driver.

Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/power/domain.c | 2 +-
 include/linux/pm_domain.h   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 45eafe8cf7dd..2c334c01fc43 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2483,7 +2483,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
  * power-domain-names DT property. For further description see
  * genpd_dev_pm_attach_by_id().
  */
-struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
+struct device *genpd_dev_pm_attach_by_name(struct device *dev, const char *name)
 {
 	int index;
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index dd364abb649a..203be5082f33 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -271,7 +271,7 @@ int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
 struct device *genpd_dev_pm_attach_by_name(struct device *dev,
-					   char *name);
+					   const char *name);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -324,7 +324,7 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 }
 
 static inline struct device *genpd_dev_pm_attach_by_name(struct device *dev,
-							 char *name)
+							 const char *name)
 {
 	return NULL;
 }
-- 
2.21.0.rc0.258.g878e2cd30e-goog

