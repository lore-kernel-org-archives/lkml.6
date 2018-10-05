Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E38DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EB92087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 15:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1Vq09w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EB92087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbeJEWhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 18:37:13 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37093 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728411AbeJEWhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 18:37:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id 63-v6so12016757ljs.4;
        Fri, 05 Oct 2018 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lU0m4dcxkmldXRenrk9EE1odt3YDCqwjd90AyKmVxsA=;
        b=J1Vq09w/dRr5xEjam4Pr1v9UtnlBzcl1CwhmWK2LQISNYjI8IyEnK9LD+9Roh2n6yA
         RwF4EOeZ/stN64NVY8JLG7E6N7WEqVvcGliou0zCI+VFbiQJ2LFM6ujIpEb68FdF1BCG
         xwctbBJb0qZUaUpzDEjrSrAj5s22obWRjrjEXdcA2zQgDRbiXwG106PbYEcjTZl197LY
         p82ojaZg8GHtJ7fdcx1Fy/ddVUm2jvT5TDRCcOwGwcdEID193LG64RQFZlFfgBIabUxD
         17YWIZ/2pDcs618kgrUqpEvs/xoCWFpMHnQ1NFfn3LI0WMTuQ6LKADr0auvK/imaFoEA
         WiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lU0m4dcxkmldXRenrk9EE1odt3YDCqwjd90AyKmVxsA=;
        b=WbnT4ZzGFvf5CZX+k+Kg1HIaxwC6CVH8SUpTLkYqJXc2gEuOhekR4t3xlm7rSJRWNh
         /2xxi7nLdC/MYVSi37TW0R4PLXVD3euEUuZvvDgwOph736wPXQwFRSESzIdVYBLUUjcv
         W6QeGZ+V/vhRoWYMhD5c3L3BvDSNTfviTXqi/anxKbGLbwDhkwUxhGE40I48YB2LZJMf
         I3xd/YGEtb7OnKO3vVMxr8hLyS1s7R3Mpbr/iPWr/1uejacZGHEYJskFooeuIiutmwRa
         2kTHNsImXSzyR9BflTbJENqeNmwMIpsFQY+H9WF02Rinlpn//7l4+711Jxw/qPc/hsO6
         4UVw==
X-Gm-Message-State: ABuFfojhOOY/hetAMxwSr/Ir6y18ikDYMa1i910mhSBWZQ+CrLFz0hRe
        zn1fqDqXejEjfF+WYg4TwfI=
X-Google-Smtp-Source: ACcGV61LHz6eImyJzoCI+1KqMSL6RxiuPCOFZfDYcd1WX/zr3s4QjO84DO2czBRtfy+CKpP5mM2vHQ==
X-Received: by 2002:a2e:99d3:: with SMTP id l19-v6mr2089413ljj.132.1538753873872;
        Fri, 05 Oct 2018 08:37:53 -0700 (PDT)
Received: from localhost.localdomain (109-252-91-213.nat.spd-mgts.ru. [109.252.91.213])
        by smtp.gmail.com with ESMTPSA id w22-v6sm1879373lfd.72.2018.10.05.08.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 08:37:53 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Maciej Purski <m.purski@samsung.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH v1 01/11] regulator: core: Add voltage balancing mechanism
Date:   Fri,  5 Oct 2018 18:36:28 +0300
Message-Id: <20181005153638.1886-2-digetx@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005153638.1886-1-digetx@gmail.com>
References: <20181005153638.1886-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Purski <m.purski@samsung.com>

On Odroid XU3/4 and other Exynos5422 based boards there is a case, that
different devices on the board are supplied by different regulators
with non-fixed voltages. If one of these devices temporarily requires
higher voltage, there might occur a situation that the spread between
two devices' voltages is so high, that there is a risk of changing
'high' and 'low' states on the interconnection between devices powered
by those regulators.

Introduce new function regulator_balance_voltage(), which
keeps max_spread constraint fulfilled between a group of coupled
regulators. It should be called if a regulator changes its
voltage or after disabling or enabling. Disabled regulators should
follow changes of the enabled ones, but their consumers' demands
shouldn't be taken into account while calculating voltage of other
coupled regulators.

Find voltages, which are closest to suiting all the consumers' demands,
while fulfilling max_spread constraint, keeping the following rules:
- if one regulator is about to rise its voltage, rise others
  voltages in order to keep the max_spread
- if a regulator, which has caused rising other regulators, is
  lowered, lower other regulators if possible
- if one regulator is about to lower its voltage, but it hasn't caused
  rising other regulators, change its voltage so that it doesn't break the
  max_spread

Change regulators' voltages step by step, keeping max_spread constraint
fulfilled all the time. Function regulator_get_optimal_voltage()
should find the best possible change for the regulator, which doesn't
break max_spread constraint. In function regulator_balance_voltage()
optimize number of steps by finding highest voltage difference on
each iteration.

If a regulator, which is about to change its voltage, is not coupled,
method regulator_get_optimal_voltage() should simply return the lowest
voltage fulfilling consumers' demands.

Coupling should be checked only if the system is in PM_SUSPEND_ON state.

Signed-off-by: Maciej Purski <m.purski@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/regulator/core.c | 229 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 229 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 2c66b528aede..a2a513780fd7 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -105,6 +105,8 @@ static int _notifier_call_chain(struct regulator_dev *rdev,
 				  unsigned long event, void *data);
 static int _regulator_do_set_voltage(struct regulator_dev *rdev,
 				     int min_uV, int max_uV);
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state);
 static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  struct device *dev,
 					  const char *supply_name);
@@ -3126,6 +3128,233 @@ static int regulator_set_voltage_unlocked(struct regulator *regulator,
 	return ret;
 }
 
+static int regulator_get_optimal_voltage(struct regulator_dev *rdev,
+					 int *current_uV,
+					 int *min_uV, int *max_uV,
+					 suspend_state_t state,
+					 int n_coupled)
+{
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	struct regulator_dev **c_rdevs = c_desc->coupled_rdevs;
+	struct regulation_constraints *constraints = rdev->constraints;
+	int max_spread = constraints->max_spread;
+	int desired_min_uV = 0, desired_max_uV = INT_MAX;
+	int max_current_uV = 0, min_current_uV = INT_MAX;
+	int highest_min_uV = 0, target_uV, possible_uV;
+	int i, ret;
+	bool done;
+
+	*current_uV = -1;
+
+	/*
+	 * If there are no coupled regulators, simply set the voltage
+	 * demanded by consumers.
+	 */
+	if (n_coupled == 1) {
+		/*
+		 * If consumers don't provide any demands, set voltage
+		 * to min_uV
+		 */
+		desired_min_uV = constraints->min_uV;
+		desired_max_uV = constraints->max_uV;
+
+		ret = regulator_check_consumers(rdev,
+						&desired_min_uV,
+						&desired_max_uV, state);
+		if (ret < 0)
+			return ret;
+
+		possible_uV = desired_min_uV;
+		done = true;
+
+		goto finish;
+	}
+
+	/* Find highest min desired voltage */
+	for (i = 0; i < n_coupled; i++) {
+		int tmp_min = 0;
+		int tmp_max = INT_MAX;
+
+		lockdep_assert_held_once(&c_rdevs[i]->mutex);
+
+		ret = regulator_check_consumers(c_rdevs[i],
+						&tmp_min,
+						&tmp_max, state);
+		if (ret < 0)
+			return ret;
+
+		ret = regulator_check_voltage(c_rdevs[i], &tmp_min, &tmp_max);
+		if (ret < 0)
+			return ret;
+
+		highest_min_uV = max(highest_min_uV, tmp_min);
+
+		if (i == 0) {
+			desired_min_uV = tmp_min;
+			desired_max_uV = tmp_max;
+		}
+	}
+
+	/*
+	 * Let target_uV be equal to the desired one if possible.
+	 * If not, set it to minimum voltage, allowed by other coupled
+	 * regulators.
+	 */
+	target_uV = max(desired_min_uV, highest_min_uV - max_spread);
+
+	/*
+	 * Find min and max voltages, which currently aren't violating
+	 * max_spread.
+	 */
+	for (i = 1; i < n_coupled; i++) {
+		int tmp_act;
+
+		if (!_regulator_is_enabled(c_rdevs[i]))
+			continue;
+
+		tmp_act = _regulator_get_voltage(c_rdevs[i]);
+		if (tmp_act < 0)
+			return tmp_act;
+
+		min_current_uV = min(tmp_act, min_current_uV);
+		max_current_uV = max(tmp_act, max_current_uV);
+	}
+
+	/* There aren't any other regulators enabled */
+	if (max_current_uV == 0) {
+		possible_uV = target_uV;
+	} else {
+		/*
+		 * Correct target voltage, so as it currently isn't
+		 * violating max_spread
+		 */
+		possible_uV = max(target_uV, max_current_uV - max_spread);
+		possible_uV = min(possible_uV, min_current_uV + max_spread);
+	}
+
+	if (possible_uV > desired_max_uV)
+		return -EINVAL;
+
+	done = (possible_uV == target_uV);
+	desired_min_uV = possible_uV;
+
+finish:
+	/* Set current_uV if wasn't done earlier in the code and if necessary */
+	if (n_coupled > 1 && *current_uV == -1) {
+
+		if (_regulator_is_enabled(rdev)) {
+			ret = _regulator_get_voltage(rdev);
+			if (ret < 0)
+				return ret;
+
+			*current_uV = ret;
+		} else {
+			*current_uV = desired_min_uV;
+		}
+	}
+
+	*min_uV = desired_min_uV;
+	*max_uV = desired_max_uV;
+
+	return done;
+}
+
+static int regulator_balance_voltage(struct regulator_dev *rdev,
+				     suspend_state_t state)
+{
+	struct regulator_dev **c_rdevs;
+	struct regulator_dev *best_rdev;
+	struct coupling_desc *c_desc = &rdev->coupling_desc;
+	int i, ret, n_coupled, best_min_uV, best_max_uV, best_c_rdev;
+	bool best_c_rdev_done, c_rdev_done[MAX_COUPLED];
+	unsigned int delta, best_delta;
+
+	c_rdevs = c_desc->coupled_rdevs;
+	n_coupled = c_desc->n_coupled;
+
+	/*
+	 * If system is in a state other than PM_SUSPEND_ON, don't check
+	 * other coupled regulators.
+	 */
+	if (state != PM_SUSPEND_ON)
+		n_coupled = 1;
+
+	if (c_desc->n_resolved < n_coupled) {
+		rdev_err(rdev, "Not all coupled regulators registered\n");
+		return -EPERM;
+	}
+
+	for (i = 0; i < n_coupled; i++)
+		c_rdev_done[i] = false;
+
+	/*
+	 * Find the best possible voltage change on each loop. Leave the loop
+	 * if there isn't any possible change.
+	 */
+	do {
+		best_c_rdev_done = false;
+		best_delta = 0;
+		best_min_uV = 0;
+		best_max_uV = 0;
+		best_c_rdev = 0;
+		best_rdev = NULL;
+
+		/*
+		 * Find highest difference between optimal voltage
+		 * and current voltage.
+		 */
+		for (i = 0; i < n_coupled; i++) {
+			/*
+			 * optimal_uV is the best voltage that can be set for
+			 * i-th regulator at the moment without violating
+			 * max_spread constraint in order to balance
+			 * the coupled voltages.
+			 */
+			int optimal_uV = 0, optimal_max_uV = 0, current_uV = 0;
+
+			if (c_rdev_done[i])
+				continue;
+
+			ret = regulator_get_optimal_voltage(c_rdevs[i],
+							    &current_uV,
+							    &optimal_uV,
+							    &optimal_max_uV,
+							    state, n_coupled);
+			if (ret < 0)
+				goto out;
+
+			delta = abs(optimal_uV - current_uV);
+
+			if (delta && best_delta <= delta) {
+				best_c_rdev_done = ret;
+				best_delta = delta;
+				best_rdev = c_rdevs[i];
+				best_min_uV = optimal_uV;
+				best_max_uV = optimal_max_uV;
+				best_c_rdev = i;
+			}
+		}
+
+		/* Nothing to change, return successfully */
+		if (!best_rdev) {
+			ret = 0;
+			goto out;
+		}
+#if 0
+		ret = regulator_set_voltage_rdev(best_rdev, best_min_uV,
+						 best_max_uV, state);
+#endif
+		if (ret < 0)
+			goto out;
+
+		c_rdev_done[best_c_rdev] = best_c_rdev_done;
+
+	} while (n_coupled > 1);
+
+out:
+	return ret;
+}
+
 /**
  * regulator_set_voltage - set regulator output voltage
  * @regulator: regulator source
-- 
2.19.0

