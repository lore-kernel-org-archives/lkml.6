Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C4ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC802083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 20:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lbx/RwVI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC802083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeJVFNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 01:13:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38242 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbeJVFNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 01:13:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id k11-v6so3122699lja.5;
        Sun, 21 Oct 2018 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrTw1iWYFqStGSAXz8HRkl720Yd7i09+fJLQHCGG5JE=;
        b=Lbx/RwVIciT1o16jxmqr1uTLUGkwmKqFAIDWNvdLOKbgZugbq+gpXv5n+Uv/v9rI/x
         XU5xl63XlmmakNvs4fEqSqpL4GnuZDVEVUUpnucjHONNaxB3y9IVndMoyA9fyMLWcyYO
         Onc8L+J+IJsNbhTm/VrvpDmhiwwgsSsqKgW0KUHOnkn9acFiCBWghM4ZPok9TdmwcQ8d
         Li64Xh6GapR6hENzwyU/1BirRlfteJWrk3WMTDhoRkQunTrI/y3533hy0cYc3jVNW2ei
         FRhWMUr+a5R2jv1C2EifmPhk1OSH6+uhV4jVbI2OajYWSXLzJs7AvCYgsR7o1/oQ1Cgw
         s9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrTw1iWYFqStGSAXz8HRkl720Yd7i09+fJLQHCGG5JE=;
        b=HiXvKuezOoGoTPQzJv/kSeyBXNFtUpiZq6jHr26QZXS7U1qUcD5S9mQj0J8zLDoJpV
         q0PmM4F0Qct1wjjs3Al/wiOpxqE0/hvJ3nMBRJVNlJDDm2HU8iQ9JLCjxiBl/MBQwx86
         5m+V7uFO6jkO2D+j3TnBkOwv7TU+WtirpKvxm9PwNIJW7bNUfDNY/kdr/zmSP3XPH0v3
         IXD7Ssno4lSjOcWpoIdDZz485WA+eSKYs582cByWP+UTcDpuB/46lNzTWHPQTvyhwRl6
         dQ7I/OJDDsWMDwGmyKtfNXEJ4FuY5ngLHOPVy9sN1IIjt6ZBcUHZ5DUR1kWErb7AhJEN
         +NbQ==
X-Gm-Message-State: ABuFfohSj/L0waAw9LTa6CosTt9OyZszXhOHN7pvsJOImoBfvVjMVHja
        RbOrvTdCdciXxuBjNGOqurs=
X-Google-Smtp-Source: AJdET5fepY2Z7Voi2NqHPLZ4IejaaipfS8ryhTu/Z40IQAVm14TzjsgJLRS+excJEacWIOqRYrI9yA==
X-Received: by 2002:a2e:7217:: with SMTP id n23-v6mr5582964ljc.71.1540155484934;
        Sun, 21 Oct 2018 13:58:04 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-118.nat.spd-mgts.ru. [109.252.91.118])
        by smtp.gmail.com with ESMTPSA id p63-v6sm6515919lfg.46.2018.10.21.13.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 13:58:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 01/17] OPP: Allow to request stub voltage regulators
Date:   Sun, 21 Oct 2018 23:54:45 +0300
Message-Id: <20181021205501.23943-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181021205501.23943-1-digetx@gmail.com>
References: <20181021205501.23943-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Voltage regulators may be not available on some variations of HW, allow to
request stub voltage regulators by OPP core in a such case to reduce code
churning within drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/cpufreq-dt.c | 2 +-
 drivers/cpufreq/ti-cpufreq.c | 3 ++-
 drivers/opp/core.c           | 9 +++++++--
 include/linux/pm_opp.h       | 4 ++--
 4 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e58bfcb1169e..6ebca472ec76 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -196,7 +196,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	 */
 	name = find_supply_name(cpu_dev);
 	if (name) {
-		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1);
+		opp_table = dev_pm_opp_set_regulators(cpu_dev, &name, 1, false);
 		if (IS_ERR(opp_table)) {
 			ret = PTR_ERR(opp_table);
 			dev_err(cpu_dev, "Failed to set regulator for cpu%d: %d\n",
diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 3f0e2a14895a..9099c8cdf447 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -268,7 +268,8 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (opp_data->soc_data->multi_regulator) {
 		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
 							 reg_names,
-							 ARRAY_SIZE(reg_names));
+							 ARRAY_SIZE(reg_names),
+							 false);
 		if (IS_ERR(ti_opp_table)) {
 			dev_pm_opp_put_supported_hw(opp_data->opp_table);
 			ret =  PTR_ERR(ti_opp_table);
diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 2c2df4e4fc14..fba1d7a1eb7c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1365,6 +1365,7 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  * @dev: Device for which regulator name is being set.
  * @names: Array of pointers to the names of the regulator.
  * @count: Number of regulators.
+ * @allow_stub_regulator: Some or all regulators can be missed.
  *
  * In order to support OPP switching, OPP layer needs to know the name of the
  * device's regulators, as the core would be required to switch voltages as
@@ -1374,7 +1375,8 @@ static void _free_set_opp_data(struct opp_table *opp_table)
  */
 struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[],
-					    unsigned int count)
+					    unsigned int count,
+					    bool allow_stub_regulator)
 {
 	struct opp_table *opp_table;
 	struct regulator *reg;
@@ -1403,7 +1405,10 @@ struct opp_table *dev_pm_opp_set_regulators(struct device *dev,
 	}
 
 	for (i = 0; i < count; i++) {
-		reg = regulator_get_optional(dev, names[i]);
+		if (allow_stub_regulator)
+			reg = regulator_get(dev, names[i]);
+		else
+			reg = regulator_get_optional(dev, names[i]);
 		if (IS_ERR(reg)) {
 			ret = PTR_ERR(reg);
 			if (ret != -EPROBE_DEFER)
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d399eeef172..480666b0a008 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -120,7 +120,7 @@ struct opp_table *dev_pm_opp_set_supported_hw(struct device *dev, const u32 *ver
 void dev_pm_opp_put_supported_hw(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count);
+struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count, bool allow_stub_regulator);
 void dev_pm_opp_put_regulators(struct opp_table *opp_table);
 struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char * name);
 void dev_pm_opp_put_clkname(struct opp_table *opp_table);
@@ -258,7 +258,7 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count)
+static inline struct opp_table *dev_pm_opp_set_regulators(struct device *dev, const char * const names[], unsigned int count, bool allow_stub_regulator)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-- 
2.19.0

