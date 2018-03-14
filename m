Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752301AbeCNRG7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:06:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37326 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeCNQ7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:09 -0400
X-Google-Smtp-Source: AG47ELsaN+OYArM4e6wd9t+LSqqsc4wUWKc6zcaDjFTzEp8+vtKq1FRHwqj2Na6QWUmQQ0EtSqT+1A==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/25] PM / Domains: Add generic data pointer to genpd_power_state struct
Date: Wed, 14 Mar 2018 17:58:13 +0100
Message-Id: <1521046715-30683-4-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lina Iyer <lina.iyer@linaro.org>

Let's add a data pointer to the genpd_power_state struct, to allow
platforms to store per state specific data.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/pm_domain.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 04dbef9..55ad34d 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -44,6 +44,7 @@ struct genpd_power_state {
 	s64 residency_ns;
 	struct fwnode_handle *fwnode;
 	ktime_t idle_time;
+	void *data;
 };
 
 struct genpd_lock_ops;
-- 
2.7.4
