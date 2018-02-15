Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755459AbeBOT3u (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 14:29:50 -0500
Received: from mout.web.de ([212.227.17.11]:43343 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751104AbeBOT3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 14:29:48 -0500
Subject: [PATCH 1/2] cpufreq: powernow-k8: Delete an error message for a
 failed memory allocation in three functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Message-ID: <895a6088-5266-0be7-90f6-b1f838eb58c1@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:29:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:xygb4e2kirowIwIHs32q++obxhnB9n7gOAVXl/BINrqH+SA5Add
 IjQElJFckaFcCp7iVxBzEqBewwrJ5W4S5Y0468ekwIQ+j7K/0l2DJLYCUS9D0VS/tHeWXve
 5kVjSSpeu7baBMu6hbE82KmBdv6OzfUWEZvuu60bJ5Sxgu8Q7B6puF5vDGhB4SADVFmDp1Q
 qeqXFJJlE/lPlcfnbDD+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7uQIzF+kpho=:JdMytc7MfzX371VTDxKyxJ
 7jHl5rLa/miqsvqDckm5/KngfCCvKLFnsGYE9BT7jUNbR4uuD8VOI/UbmRK4wP2ouxcZ229rm
 rmvBj1YJmicJ0NJM+x0uhtrTa0xzbB2b1Xmut/LkVE8r5//i8gfNJdfs0adtJUIiK7auTDcjp
 AUqJlDumRxGqULheA8tll/754XKBxC+GRpl1feD4yTqsY1PsWRtWmMBOwk8r4wh+Q/q/6tihD
 DbUc6z9mbwFp41wi7QbsvwOZkuf1jHR+ZZ4nOmfXdj4805DX8Sl8U0Cjm5tO3rvaLCeZw7w4v
 akkOESw32mCwdh5O7yrCy6UM03TbY1JDaIuEbT85kDB7Yjz9D6eBTGN/0KI9oq6xWe1YcDf99
 KRMnypTj8cA9J6Sd4JXakThQ/arMYu3Z6SfLpIj1C6uTjHusrVZOsrUrMG3uWMqE8b/1H375E
 0lZt8kIU7IznaAQwESayRJAUy1eT9m0KmlF8cu3e2cJ8OC5fKVNAeHbiLg5GLszAbb1Wd9b5w
 PxmmJNBtaiOwbv351UpATddtq/P85AJJBWSAxtRCuG3di3V2lbHSB/iLH5F0yRYAoUjh9OhHC
 nAEg4wojBL41+p7sWgOkgeCkJRdSsidIVV2kr29gNrz7tt++7NZ6Ie/7NPozfrCQOThUnaPTM
 QY1ryDL0/BtR1UIBBNBhYbq8+R+3cj+HAzTeaIkp3ztvRU9PW16bRqrIUdisj04/ZspjJYAq5
 TTI6cDtYvhRL8tAXpj7NwNiEUlMIW/z1m+GEjEt68Xns9f2JylpZRREPwSNMDXNvsjJ9uuZqC
 iGqJspirdk1jT4IMczhCK0W5aGAcVEcp1A11bubxkNpfKpcTHk=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 15 Feb 2018 20:00:23 +0100

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/cpufreq/powernow-k8.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
index b01e31db5f83..460bf22a8a2b 100644
--- a/drivers/cpufreq/powernow-k8.c
+++ b/drivers/cpufreq/powernow-k8.c
@@ -591,10 +591,8 @@ static int fill_powernow_table(struct powernow_k8_data *data,
 
 	powernow_table = kzalloc((sizeof(*powernow_table)
 		* (data->numps + 1)), GFP_KERNEL);
-	if (!powernow_table) {
-		pr_err("powernow_table memory alloc failure\n");
+	if (!powernow_table)
 		return -ENOMEM;
-	}
 
 	for (j = 0; j < data->numps; j++) {
 		int freq;
@@ -760,10 +758,8 @@ static int powernow_k8_cpu_init_acpi(struct powernow_k8_data *data)
 	/* fill in data->powernow_table */
 	powernow_table = kzalloc((sizeof(*powernow_table)
 		* (data->acpi_data.state_count + 1)), GFP_KERNEL);
-	if (!powernow_table) {
-		pr_debug("powernow_table memory alloc failure\n");
+	if (!powernow_table)
 		goto err_out;
-	}
 
 	/* fill in data */
 	data->numps = data->acpi_data.state_count;
@@ -1042,10 +1038,8 @@ static int powernowk8_cpu_init(struct cpufreq_policy *pol)
 		return -ENODEV;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		pr_err("unable to alloc powernow_k8_data\n");
+	if (!data)
 		return -ENOMEM;
-	}
 
 	data->cpu = pol->cpu;
 
-- 
2.16.1
