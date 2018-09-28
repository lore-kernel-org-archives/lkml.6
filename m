Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B83C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54CFB206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+jxCCgi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54CFB206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbeI2Fnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:43:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38835 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeI2Fnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:43:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id g89-v6so6149137lfl.5;
        Fri, 28 Sep 2018 16:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WWWKJ1zlBbt4lU1sunTBciSft97pJ2WUkNeHtfMiXu0=;
        b=k+jxCCgiAzV4yJN89AHry7Ebjs6vHKKOWRKS9gU8yAWLkAkd5rSJOf8NizMVGSOGT1
         bxBXqub8gu/LGHZs9od/KxCTDNO85YefCdHXLRJJaSwFDSIa6TKJHG3AJqKxOBHy/8DM
         mQHLRyJ/YgfT/GAT432YT1VOHaTeA1hwy20wNthBhQrcUOLDL+FHJgXs1MSXd8QtNwmp
         9s9RP1WSs7l27OHq5lZ28hZiMvLujQT/pkgxGuZ9TCnzR6HnugCvaaw7XdJI/r86sdX7
         ZoZTVWiPiCoClcJYVGbPPy9pEZL+bkhTj26ieD6M18mfWhlbKXzDDYXbs4BjqFKrtUtH
         AgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WWWKJ1zlBbt4lU1sunTBciSft97pJ2WUkNeHtfMiXu0=;
        b=UrZYZ2oc/FrcHqy7cUmzjbrxQUK4bRYRso9Rh41v5w2vPr86C5UWkiZ+taE2atUDk8
         +zgsOkcjjg1FHmNJYHsy8jdkDItAksl1ojV/n9nLMxZSLXB5KFmRmGCzuh8zI+9ckDjp
         7ZTmkhxlhzEewejg2SXh1KaRTmzLsr5tbtUDSRqkLb4dA+fm/xQjyFuY5myYgU8+6h/I
         PT6UPkjEs1KSXCZQo/+c0OVYPK5w+v+sF8vk3N31xFED/2RxIrRTHZsJpe/9J0EP6yHQ
         U1ZY9v05gxjGuHtbT9ed2yRgVqatObSg2L9c1iQEwKgGaR6kFl6Udjn8TbyK98hPV5Ki
         NZmA==
X-Gm-Message-State: ABuFfoi8y/8ofyFZet/FVrIdVi9gstzzlQUgGySSTvABUH/ml2v8UkmS
        A6AYnNZ8kOHoF2aWUx9q7uo=
X-Google-Smtp-Source: ACcGV63Xxao/fjN1QpXWuaYLcaWguWPNQEXfF0XjtEs2X8TQEwJZ+WBDOZznBcKyXjCHDBHCVo3cng==
X-Received: by 2002:a19:c44f:: with SMTP id u76-v6mr334394lff.141.1538176657621;
        Fri, 28 Sep 2018 16:17:37 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id h27-v6sm1270761lfl.31.2018.09.28.16.17.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 16:17:36 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Tony Lindgren <tony@atomide.com>
Cc:     Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
 <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
 <20180928202251.GM5662@atomide.com>
 <2c0132ff-ea0f-f19e-ebfb-a0d077565d2c@gmail.com>
 <20180928224109.GS5662@atomide.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ea0a59ef-e201-986a-9499-a0638359b1b9@gmail.com>
Date:   Sat, 29 Sep 2018 02:17:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928224109.GS5662@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/18 1:41 AM, Tony Lindgren wrote:
> * Dmitry Osipenko <digetx@gmail.com> [180928 22:31]:
>> On 9/28/18 11:22 PM, Tony Lindgren wrote:
>>> * Dmitry Osipenko <digetx@gmail.com> [180928 20:13]:
>>>> Tony, could you please give a try to the patch below?
>>>>
>>>> Do the following:
>>>>
>>>> 1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
>>>> 2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
>>>> 3) Apply this patch:
>>>
>>> Seems to be getting closer, system boots up and starts
>>> init, but then I start getting tons of this on beagle-x15:
>>
>> Tony, could you please try this one? Fixed couple more bugs, should be good now.
> 
> I'm still getting these errors after init:

Thank you very much again, seems I got what's wrong with your case. The ti-abb-regulator driver sets the "abb->current_info_idx = -EINVAL" on probe and that value is getting updated only after the first voltage change, hence _regulator_get_voltage() returns -22.

Please try this patch:


From 2f10c29547778499f614b363a7756a40099bfa5a Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 28 Sep 2018 21:49:20 +0300
Subject: [PATCH] Fixup regulator_balance_voltage() v3

---
 drivers/regulator/core.c | 91 ++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 282511508698..d0edb66b37a2 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,7 +105,7 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
-static int regulator_balance_voltage(struct regulator_dev *rdev,
+static int regulator_balance_voltage(struct regulator *regulator,
 				     suspend_state_t state);
 static int regulator_set_voltage_rdev(struct regulator_dev *rdev,
 				      int min_uV, int max_uV,
@@ -2330,7 +2330,7 @@ int regulator_enable(struct regulator *regulator)
 	ret = _regulator_enable(rdev);
 	/* balance only if there are regulators coupled */
 	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		regulator_balance_voltage(regulator, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret != 0 && rdev->supply)
@@ -2440,7 +2440,7 @@ int regulator_disable(struct regulator *regulator)
 	regulator_lock_dependent(rdev);
 	ret = _regulator_disable(rdev);
 	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		regulator_balance_voltage(regulator, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (ret == 0 && rdev->supply)
@@ -2494,7 +2494,7 @@ int regulator_force_disable(struct regulator *regulator)
 	regulator->uA_load = 0;
 	ret = _regulator_force_disable(regulator->rdev);
 	if (rdev->coupling_desc.n_coupled > 1)
-		regulator_balance_voltage(rdev, PM_SUSPEND_ON);
+		regulator_balance_voltage(regulator, PM_SUSPEND_ON);
 	regulator_unlock_dependent(rdev);
 
 	if (rdev->supply)
@@ -3099,12 +3099,8 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	voltage->min_uV = min_uV;
 	voltage->max_uV = max_uV;
 
-	ret = regulator_check_consumers(rdev, &min_uV, &max_uV, state);
-	if (ret < 0)
-		goto out2;
-
 	/* for not coupled regulators this will just set the voltage */
-	ret = regulator_balance_voltage(rdev, state);
+	ret = regulator_balance_voltage(regulator, state);
 	if (ret < 0)
 		goto out2;
 
@@ -3187,7 +3183,10 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int regulator_get_optimal_voltage(struct regulator *regulator,
+					 struct regulator_dev *rdev,
+					 int *min_uV, int *max_uV,
+					 suspend_state_t state)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3198,20 +3197,29 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	int i, ret;
 
 	/* If consumers don't provide any demands, set voltage to min_uV */
-	desired_min_uV = rdev->constraints->min_uV;
-	desired_max_uV = rdev->constraints->max_uV;
-	ret = regulator_check_consumers(rdev,
-					&desired_min_uV,
-					&desired_max_uV, PM_SUSPEND_ON);
-	if (ret < 0)
-		goto out;
+	if (regulator->rdev == rdev) {
+		desired_min_uV = regulator->voltage[state].min_uV;
+		desired_max_uV = regulator->voltage[state].max_uV;
+
+		ret = regulator_check_consumers(rdev,
+						&desired_min_uV,
+						&desired_max_uV,
+						state);
+		if (ret < 0)
+			goto out;
+	} else {
+		desired_min_uV = rdev->constraints->min_uV;
+		desired_max_uV = rdev->constraints->max_uV;
+	}
 
 	/*
 	 * If there are no coupled regulators, simply set the voltage demanded
 	 * by consumers.
 	 */
-	if (n_coupled == 1) {
-		ret = desired_min_uV;
+	if (n_coupled == 1 || state != PM_SUSPEND_ON) {
+		*min_uV = desired_min_uV;
+		*max_uV = desired_max_uV;
+		ret = 1;
 		goto out;
 	}
 
@@ -3285,20 +3293,24 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 		ret = -EINVAL;
 		goto out;
 	}
-	ret = possible_uV;
+	ret = (possible_uV == desired_min_uV);
 
+	*min_uV = possible_uV;
+	*max_uV = desired_max_uV;
 out:
 	return ret;
 }
 
-static int regulator_balance_voltage(struct regulator_dev *rdev,
+static int regulator_balance_voltage(struct regulator *regulator,
 				     suspend_state_t state)
 {
+	struct regulator_dev *rdev = regulator->rdev;
 	struct regulator_dev **c_rdevs;
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled;
-	int i, best_delta, best_uV, ret = 1;
+	int i, best_delta, best_min_uV, best_max_uV, ret = 1;
+	bool last = false;
 
 	c_rdevs = c_desc->coupled_rdevs;
 	n_coupled = c_desc->n_coupled;
@@ -3314,9 +3326,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	 * Find the best possible voltage change on each loop. Leave the loop
 	 * if there isn't any possible change.
 	 */
-	while (1) {
+	while (!last) {
 		best_delta = 0;
-		best_uV = 0;
+		best_min_uV = 0;
+		best_max_uV = 0;
 		best_rdev = NULL;
 
 		/*
@@ -3330,24 +3343,30 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, optimal_max_uV, current_uV = 0;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
-			if (optimal_uV < 0) {
-				ret = optimal_uV;
+			ret = regulator_get_optimal_voltage(regulator,
+							    c_rdevs[i],
+							    &optimal_uV,
+							    &optimal_max_uV,
+							    state);
+			if (ret < 0)
 				goto out;
-			}
 
-			current_uV = _regulator_get_voltage(c_rdevs[i]);
-			if (current_uV < 0) {
-				ret = optimal_uV;
-				goto out;
+			if (n_coupled > 1) {
+				current_uV = _regulator_get_voltage(c_rdevs[i]);
+				if (current_uV < 0) {
+					ret = current_uV;
+					goto out;
+				}
 			}
 
 			if (abs(best_delta) < abs(optimal_uV - current_uV)) {
 				best_delta = optimal_uV - current_uV;
 				best_rdev = c_rdevs[i];
-				best_uV = optimal_uV;
+				best_min_uV = optimal_uV;
+				best_max_uV = optimal_max_uV;
+				last = (best_rdev == rdev && ret > 0);
 			}
 		}
 
@@ -3357,8 +3376,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			goto out;
 		}
 
-		ret = regulator_set_voltage_rdev(best_rdev, best_uV,
-						 best_uV, state);
+		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
+						 best_max_uV, state);
 
 		if (ret < 0)
 			goto out;
-- 
2.19.0

