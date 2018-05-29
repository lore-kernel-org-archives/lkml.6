Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933017AbeE2KHW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 06:07:22 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50349 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeE2KEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 06:04:30 -0400
X-Google-Smtp-Source: ADUXVKJMzT40/2PTq1QaebRlZduwZauw+klH1h7H1KOqei5y3Fn80g2TLQ7ZD3gflxPlsLgTXmyeqQ==
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
Subject: [PATCH v2 1/9] PM / Domains: Drop extern declarations of functions in pm_domain.h
Date: Tue, 29 May 2018 12:04:13 +0200
Message-Id: <20180529100421.31022-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529100421.31022-1-ulf.hansson@linaro.org>
References: <20180529100421.31022-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using "extern" to declare a function in a public header file is somewhat
pointless, but also doesn't hurt. However, to make all the function
declarations in pm_domain.h to be consistent, let's drop the use of
"extern".

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 51 ++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 28 deletions(-)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 4e5764083fd8..c847e9a3033d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -143,21 +143,17 @@ static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
 	return to_gpd_data(dev->power.subsys_data->domain_data);
 }
 
-extern int __pm_genpd_add_device(struct generic_pm_domain *genpd,
-				 struct device *dev,
-				 struct gpd_timing_data *td);
-
-extern int pm_genpd_remove_device(struct generic_pm_domain *genpd,
-				  struct device *dev);
-extern int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
-				  struct generic_pm_domain *new_subdomain);
-extern int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
-				     struct generic_pm_domain *target);
-extern int pm_genpd_init(struct generic_pm_domain *genpd,
-			 struct dev_power_governor *gov, bool is_off);
-extern int pm_genpd_remove(struct generic_pm_domain *genpd);
-extern int dev_pm_genpd_set_performance_state(struct device *dev,
-					      unsigned int state);
+int __pm_genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
+			  struct gpd_timing_data *td);
+int pm_genpd_remove_device(struct generic_pm_domain *genpd, struct device *dev);
+int pm_genpd_add_subdomain(struct generic_pm_domain *genpd,
+			   struct generic_pm_domain *new_subdomain);
+int pm_genpd_remove_subdomain(struct generic_pm_domain *genpd,
+			      struct generic_pm_domain *target);
+int pm_genpd_init(struct generic_pm_domain *genpd,
+		  struct dev_power_governor *gov, bool is_off);
+int pm_genpd_remove(struct generic_pm_domain *genpd);
+int dev_pm_genpd_set_performance_state(struct device *dev, unsigned int state);
 
 extern struct dev_power_governor simple_qos_governor;
 extern struct dev_power_governor pm_domain_always_on_gov;
@@ -215,8 +211,8 @@ static inline int pm_genpd_add_device(struct generic_pm_domain *genpd,
 }
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_SLEEP
-extern void pm_genpd_syscore_poweroff(struct device *dev);
-extern void pm_genpd_syscore_poweron(struct device *dev);
+void pm_genpd_syscore_poweroff(struct device *dev);
+void pm_genpd_syscore_poweron(struct device *dev);
 #else
 static inline void pm_genpd_syscore_poweroff(struct device *dev) {}
 static inline void pm_genpd_syscore_poweron(struct device *dev) {}
@@ -240,14 +236,13 @@ int of_genpd_add_provider_simple(struct device_node *np,
 int of_genpd_add_provider_onecell(struct device_node *np,
 				  struct genpd_onecell_data *data);
 void of_genpd_del_provider(struct device_node *np);
-extern int of_genpd_add_device(struct of_phandle_args *args,
-			       struct device *dev);
-extern int of_genpd_add_subdomain(struct of_phandle_args *parent,
-				  struct of_phandle_args *new_subdomain);
-extern struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
-extern int of_genpd_parse_idle_states(struct device_node *dn,
-			struct genpd_power_state **states, int *n);
-extern unsigned int of_genpd_opp_to_performance_state(struct device *dev,
+int of_genpd_add_device(struct of_phandle_args *args, struct device *dev);
+int of_genpd_add_subdomain(struct of_phandle_args *parent,
+			   struct of_phandle_args *new_subdomain);
+struct generic_pm_domain *of_genpd_remove_last(struct device_node *np);
+int of_genpd_parse_idle_states(struct device_node *dn,
+			       struct genpd_power_state **states, int *n);
+unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 				struct device_node *opp_node);
 
 int genpd_dev_pm_attach(struct device *dev);
@@ -304,9 +299,9 @@ struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 #endif /* CONFIG_PM_GENERIC_DOMAINS_OF */
 
 #ifdef CONFIG_PM
-extern int dev_pm_domain_attach(struct device *dev, bool power_on);
-extern void dev_pm_domain_detach(struct device *dev, bool power_off);
-extern void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
+int dev_pm_domain_attach(struct device *dev, bool power_on);
+void dev_pm_domain_detach(struct device *dev, bool power_off);
+void dev_pm_domain_set(struct device *dev, struct dev_pm_domain *pd);
 #else
 static inline int dev_pm_domain_attach(struct device *dev, bool power_on)
 {
-- 
2.17.0
