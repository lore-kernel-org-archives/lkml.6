Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeERKdi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:33:38 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41667 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752539AbeERKby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:31:54 -0400
X-Google-Smtp-Source: AB8JxZoAvL2q68KhQPs7hD56Svq93grsBsKVTW6zSin50UT48+5IZqw15RiJjN6ZpZkrhdZgAzn7sg==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todor Tomov <todor.tomov@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH 4/9] PM / Domains: Drop unused parameter in genpd_allocate_dev_data()
Date: Fri, 18 May 2018 12:31:25 +0200
Message-Id: <1526639490-12167-5-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
References: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The in-parameter struct generic_pm_domain *genpd to
genpd_allocate_dev_data() is unused, so let's drop it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index f08fa15..050ce07 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1316,7 +1316,6 @@ EXPORT_SYMBOL_GPL(pm_genpd_syscore_poweron);
 #endif /* CONFIG_PM_SLEEP */
 
 static struct generic_pm_domain_data *genpd_alloc_dev_data(struct device *dev,
-					struct generic_pm_domain *genpd,
 					struct gpd_timing_data *td)
 {
 	struct generic_pm_domain_data *gpd_data;
@@ -1385,7 +1384,7 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (IS_ERR_OR_NULL(genpd) || IS_ERR_OR_NULL(dev))
 		return -EINVAL;
 
-	gpd_data = genpd_alloc_dev_data(dev, genpd, td);
+	gpd_data = genpd_alloc_dev_data(dev, td);
 	if (IS_ERR(gpd_data))
 		return PTR_ERR(gpd_data);
 
-- 
2.7.4
