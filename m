Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4657CC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F169620866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwj+Zh/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F169620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeILNdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33841 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeILNdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so662431pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uUI5Y3mekTjxrtv6ALknOR0cOq3hMnDP+U5fQNkXcFc=;
        b=kwj+Zh/fU6acby92dexeKGSe9U2V665kaeTu0q0NJEsEGh77+8KwgM+XVljNEBiztX
         /N6wopayxojgsKkY/Rp9kcXiYJkzLWHrd44ikCtCUgnhADXuraNAL1THTG1JROrmcrTY
         cHUGgiqqNQXYebZ5M0iV/DOypWhgIgPXQzxUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uUI5Y3mekTjxrtv6ALknOR0cOq3hMnDP+U5fQNkXcFc=;
        b=tithDDpnzEHax1pXlniO38MK0lh0BokTE1mqSWZ82HUIjNa4aZbaCQH24HrFQTAiyK
         cCVBJbKcXpFI9ArOlQX0Deg4C/NY8yVGjrC8vp6vKZwqjacMtNYUgDpD1fND1GCnCh0A
         DQCY2bIDjr4dD11cpADmY74UX+MJon2eJglJeYZZ5Jx65KwZveh3kVAVtoKHbYamDNDd
         1Q43g7yN8rKM8rKqgLJfOGt+F77YaWJJBYD2eAj5NkLi30OEUg7yu6Fbk6//to9ZUpWp
         QipW26M37yoILfejek8+NT40fjNS5n8LUumgto5IQsLmMULKTmu51uEP7BURUqXvQrow
         GEiA==
X-Gm-Message-State: APzg51C1KWkrQqeZCiifSvtHiEphxKb18EOKthxvYdltBwfv2JKFQ1Wf
        1yQsTVkXeprwAzILpnSTMVlrBg==
X-Google-Smtp-Source: ANB0VdZ5el16nuRa+e+C7BsVjl5vQFzn5pedoQH+9aEybk2dPMbmWqxNp7KnVLs2I95oz8ir2kyl9Q==
X-Received: by 2002:a65:6292:: with SMTP id f18-v6mr877898pgv.85.1536740989727;
        Wed, 12 Sep 2018 01:29:49 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id s75-v6sm772624pfd.108.2018.09.12.01.29.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:29:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "4 . 18" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] OPP: Free OPP table properly on performance state irregularities
Date:   Wed, 12 Sep 2018 13:58:40 +0530
Message-Id: <14486fb4c32047983ace6af4f4ffe2366242f3b5.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPP table was freed, but not the individual OPPs which is done from
_dev_pm_opp_remove_table(). Fix it by calling _dev_pm_opp_remove_table()
as well.

Cc: 4.18 <stable@vger.kernel.org> # v4.18
Fixes: 3ba98324e81a ("PM / OPP: Get performance state using genpd helper")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 7af0ddec936b..20988c426650 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -425,6 +425,7 @@ static int _of_add_opp_table_v2(struct device *dev, struct device_node *opp_np)
 		dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
 			count, pstate_count);
 		ret = -ENOENT;
+		_dev_pm_opp_remove_table(opp_table, dev, false);
 		goto put_opp_table;
 	}
 
-- 
2.18.0.rc1.242.g61856ae69a2c

