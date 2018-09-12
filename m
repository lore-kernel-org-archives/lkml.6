Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB78C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E411420866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdZ588XX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E411420866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeILNdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:31 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37386 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeILNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so652898pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jPGAIL3sdk1Aa+qVaM14yKId1VZA9MbnVLCDYEKFuXg=;
        b=MdZ588XXa/wpGdUAt4Ygq+BCWjnFwYVNL5v3gbPoGfNpZ10R8QGd1gS6l7AFo1hziz
         Am6Tm7Y9f9SpD319PLWMdd519oGNHaY5n1uNYr0Y291U6IFIuHvUT3rQJGxRH/eFYeR5
         EgKbamcC9lN1n059MA6tx938cPi+3WYav74r4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jPGAIL3sdk1Aa+qVaM14yKId1VZA9MbnVLCDYEKFuXg=;
        b=Vf+BJRnWotNN2YKfQK2/e3M/9Edtmiz3NowkE/gQrhiyJ9JthXuUaenHLbE0dV3hRR
         DM9ro0Y9fWujh3mVrlOTJgE1FmLdpfj+enxFj2/6j7K/++BXYo9zj05f/gunBUzJKdpJ
         Nuzb36vAkbEYuX0rSseHa3UKuQd8nzbrmv/mu/qYmN6rLTOThR8uI58waQBsnv2LNPjP
         8RC8uUK2PDH2WPXxLP8uUoGxNhNcjsf3wesj6aWQB/r0sQe29ZUdYREwXfefhexoIior
         M4LiP4lZMp94pW3jp+NE168dWukOFf+Psmbtw7SoPqlvhX9d4C9lqtxQC6XFe3k6GzPR
         2MZw==
X-Gm-Message-State: APzg51Da5aFJK9cA+K41XRi9KT6ckscUY5q2DC8buOKLtzyY4GWEKYqa
        hmxulgkCa+45I69mMxqdhRp7Iw==
X-Google-Smtp-Source: ANB0VdZHu0cZ6GYi+8xaK12kwFYzxX6B5EYZSuWcAMT76APSbXJ9gzGM19eMMT++Tejq8tFatiqxJg==
X-Received: by 2002:a62:2744:: with SMTP id n65-v6mr920713pfn.125.1536741002527;
        Wed, 12 Sep 2018 01:30:02 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id g25-v6sm1079645pfd.23.2018.09.12.01.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:30:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/11] OPP: Don't take OPP table's kref for static OPPs
Date:   Wed, 12 Sep 2018 13:58:44 +0530
Message-Id: <08942a9ab06dd76034242cb70dd2446020a2efe0.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference count is only required to be incremented for every call
that may lead to adding the OPP table. For static OPPs the same should
be done from the parent routine which adds all static OPPs together and
so only one refcount for all static OPPs.

Update code to reflect that.

The refcount is incremented every time a dynamic OPP is created (as that
can lead to creating the OPP table) and the same is dropped when the OPP
is removed.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 332748adc262..2a6976265580 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -919,7 +919,6 @@ static void _opp_kref_release(struct kref *kref)
 	kfree(opp);
 
 	mutex_unlock(&opp_table->lock);
-	dev_pm_opp_put_opp_table(opp_table);
 }
 
 void dev_pm_opp_get(struct dev_pm_opp *opp)
@@ -963,11 +962,15 @@ void dev_pm_opp_remove(struct device *dev, unsigned long freq)
 
 	if (found) {
 		dev_pm_opp_put(opp);
+
+		/* Drop the reference taken by dev_pm_opp_add() */
+		dev_pm_opp_put_opp_table(opp_table);
 	} else {
 		dev_warn(dev, "%s: Couldn't find OPP with freq: %lu\n",
 			 __func__, freq);
 	}
 
+	/* Drop the reference taken by _find_opp_table() */
 	dev_pm_opp_put_opp_table(opp_table);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_remove);
@@ -1085,9 +1088,6 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 	new_opp->opp_table = opp_table;
 	kref_init(&new_opp->kref);
 
-	/* Get a reference to the OPP table */
-	_get_opp_table_kref(opp_table);
-
 	ret = opp_debug_create_one(new_opp, opp_table);
 	if (ret)
 		dev_err(dev, "%s: Failed to register opp to debugfs (%d)\n",
@@ -1566,8 +1566,9 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 		return -ENOMEM;
 
 	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	if (ret)
+		dev_pm_opp_put_opp_table(opp_table);
 
-	dev_pm_opp_put_opp_table(opp_table);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_add);
-- 
2.18.0.rc1.242.g61856ae69a2c

