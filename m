Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A89CC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 445AB2073F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 20:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3h++Oud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445AB2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeI2Ces (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 22:34:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41483 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeI2Ces (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 22:34:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3-v6so5198678pgv.8;
        Fri, 28 Sep 2018 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=n+3Rk+UYwaASXOgUiBKyc9xr1KIVO9+e0SuvE5Th8Rs=;
        b=C3h++Ouduxhaex5fjgkZrIvqMEWoGBTlQaYXPhOr362aRCity7/YwHjBp3gKEfAONf
         WU7olnWlLtvvUCKVt4dt0b/ptCHC5ltrye5ng8XXVTynMSu0ybCkQ00PUxh4BuGxrHDP
         JhSEGEX5jPumGCzJVHRg4j3D8trwsND2OCjVQFskBiIWAkg/0wL7HsQgDpF1vpZ77HxG
         kJASv5zXj9CrNlvv15MYiMqYaCy1MmoUNfOzTNQDTrsgXWnZIw6puJKBmVtsu17hB4AS
         n4kGWc6yNeleICHEUZ4I82uYN6L23Kbqe039WOt5IeeicqEfzXDWz0Wva96UsQmcmktr
         GOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=n+3Rk+UYwaASXOgUiBKyc9xr1KIVO9+e0SuvE5Th8Rs=;
        b=eIaNxZQ6x6KXP904U5qWV3zB9lKvwnkiTm8xThVuglVjmlo+ghMRwfrMuWYV7aXakg
         /85QeY8566bRTcrZM7nlHsvvRka5EKDB4mcb4yik/E1hXbCfEsvL/jjyv2kmiieJUB8L
         VeWbbxRUeR2he2n4zQzPwp7ZlkRp1hcsNUSRs4/8LUiSljJVC0TxSwHPC1CqsMFf50Y9
         v3efNHyRvLZcUxnjuWjy5Yfy4degJD5mhMfA2mNKBi3etV3xgADqYEvaJQNdGntdxz7I
         x84i2VJlnRCbBQK/VHUEthVeXSjFP51Yu3MzJuTMCTLqfymUo9b4uoFHTM5gcoiMH3xn
         BnQQ==
X-Gm-Message-State: ABuFfogx7xa2Aj+OxKXIQIEK9M0kbndbkFZJbxx35EF+mwJa+BL4EM2D
        nY4SnfnW0izW+JCP1TBLD8Y=
X-Google-Smtp-Source: ACcGV62jvNxitTlt253RL4D+Qvz0GVYNdwOj3KaeXUa7DZzGcLsruY7w4hClQ//7/Ra4qR+EJE5m/A==
X-Received: by 2002:a63:730c:: with SMTP id o12-v6mr138268pgc.397.1538165367017;
        Fri, 28 Sep 2018 13:09:27 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.91.213])
        by smtp.googlemail.com with ESMTPSA id t63-v6sm9690081pfa.158.2018.09.28.13.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:09:26 -0700 (PDT)
Subject: Re: [PATCH] regulator: core: Pass max_uV value to
 regulator_set_voltage_rdev
To:     Tony Lindgren <tony@atomide.com>,
        Maciej Purski <m.purski@samsung.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Newsgroups: gmane.linux.kernel,gmane.linux.ports.arm.kernel,gmane.linux.ports.arm.omap
References: <20180615112916.GK112168@atomide.com>
 <CGME20180618140856eucas1p281619f9bf003655a3c2eac356216ab25@eucas1p2.samsung.com>
 <1529330913-11152-1-git-send-email-m.purski@samsung.com>
 <20180702080505.GN112168@atomide.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95655644-ef41-f5bd-7e8e-a257d48cd020@gmail.com>
Date:   Fri, 28 Sep 2018 23:09:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180702080505.GN112168@atomide.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20180928200917.7y7CZjkYadBgLvbQOo4hX9lmx8XXAQQMHkGSaJCP0S8@z>

On 7/2/18 11:05 AM, Tony Lindgren wrote:
> * Maciej Purski <m.purski@samsung.com> [180618 14:11]:
>> If the regulator is not coupled, balance_voltage() should preserve
>> its desired max uV, instead of setting the exact value like in
>> coupled regulators case.
>>
>> Remove debugs, which are not necessary for now.
> 
> Sorry for the delay in testing. I gave your series with this one
> a quick boot test on beagleboard-x15 and now the output is
> different. So instead of just hanging it seems to be stuck in
> some eternal loop see below.

Hello guys,

I'm working on the CPUFreq driver for NVIDIA Tegra and it requires the coupled-regulators functionality, hence I'm interested in getting the coupled regulators series finalized ASAP and want to help with it.

It looks to me that the infinite-loop problem is caused by the voltage value that is getting rounded-up by the driver because it isn't aligned to the uV_step. IIUC, uV_step is relevant only for the "linear" regulators and hence we can't simply set the best_delta to uV_step to solve the problem. Other solution could be to bail out of the loop once regulator sets value equal to the "desired".

Tony, could you please give a try to the patch below?

Do the following:

1) git cherry-pick 696861761a58d8c93605b5663824929fb6540f16
2) git cherry-pick 456e7cdf3b1a14e2606b8b687385ab2e3f23a49a
3) Apply this patch:

From 7928aecb3af9d367dd3c085972349aaa16318c1b Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 28 Sep 2018 21:49:20 +0300
Subject: [PATCH] Fixup regulator_balance_voltage()

---
 drivers/regulator/core.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 282511508698..4a386fe9f26a 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -3187,7 +3187,8 @@ static int regulator_set_voltage_rdev(struct regulator_dev *rdev, int min_uV,
 	return ret;
 }
 
-static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
+					 int *min_uV, int *max_uV)
 {
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
@@ -3211,7 +3212,9 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
 	 * by consumers.
 	 */
 	if (n_coupled == 1) {
-		ret = desired_min_uV;
+		*min_uV = desired_min_uV;
+		*max_uV = desired_max_uV;
+		ret = 1;
 		goto out;
 	}
 
@@ -3285,8 +3288,10 @@ static int regulator_get_optimal_voltage(struct regulator_dev *rdev)
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
@@ -3298,7 +3303,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 	struct regulator_dev *best_rdev;
 	struct coupling_desc *c_desc = &rdev->coupling_desc;
 	int n_coupled;
-	int i, best_delta, best_uV, ret = 1;
+	int i, best_delta, best_min_uV, best_max_uV, ret = 1;
+	bool last = false;
 
 	c_rdevs = c_desc->coupled_rdevs;
 	n_coupled = c_desc->n_coupled;
@@ -3314,9 +3320,10 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
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
@@ -3330,24 +3337,26 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
 			 * max_spread constraint in order to balance
 			 * the coupled voltages.
 			 */
-			int optimal_uV, current_uV;
+			int optimal_uV, optimal_max_uV, current_uV;
 
-			optimal_uV = regulator_get_optimal_voltage(c_rdevs[i]);
-			if (optimal_uV < 0) {
-				ret = optimal_uV;
+			ret = regulator_get_optimal_voltage(c_rdevs[i],
+							    &optimal_uV,
+							    &optimal_max_uV);
+			if (ret < 0)
 				goto out;
-			}
 
 			current_uV = _regulator_get_voltage(c_rdevs[i]);
 			if (current_uV < 0) {
-				ret = optimal_uV;
+				ret = current_uV;
 				goto out;
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
 
@@ -3357,8 +3366,8 @@ static int regulator_balance_voltage(struct regulator_dev *rdev,
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
