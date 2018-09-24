Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EA3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5A320883
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="BDV7axJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5A320883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbeIXQNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:13:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42052 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbeIXQN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:13:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id b11-v6so2857353wru.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jLISmJc2dPUxbBj3RDyXz5hdQLm9DxNuC15aZU3ms6g=;
        b=BDV7axJatr4Cp/LBdA1G+Vka0/jKPXb00CWdvOX431pLfQhTXSlFx6jbCOJK3Ajxor
         Wl9GQa5xgfkoKGBjNNdbYM3/72d+n77JH9SdjDJkKEPrG+f7+SOp8Zr/0Ki/H9YFJ3eT
         EoPuOWVQbC044VSDjJDLe9cOXRc5aAoF0MkrNyYqVkOTT/JKGmOdqZ9ZdlB6OK4YUknR
         okBgcDquosDFY3+hUcLNBsDEK5HH9XJdgjApl2acAeurJHFFd7zl2Z1xzn9YBaaYWHj7
         CTPBqInRbHes4J3J2Kd0+c5iyc0t+tnQ1/UHcyKScX2Lo+6njEHfYSxi7cUg2Ol/xTzk
         pKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jLISmJc2dPUxbBj3RDyXz5hdQLm9DxNuC15aZU3ms6g=;
        b=tvRg2TLJY2U+iR/QhJ0sGC5uQgExDrgsUJEijdgOx5JpCDZNR/E2k4nbxmwfKYBMmI
         JeYNb8zkfs5QL3hV+N7e5+aWLmACjjkrbfMruVpIq14WTapfE7IAFClu+tpng6QyhVAp
         HMFIes8qpmbtrnMiG3ItloSfOldU0HeBfcIng1EznMUuDspL0XjPFFVA4Hj/gdmsMo1y
         b3r2yvozfvvbc07p50GNiN6b7kzOqv9XC4qstLK5JacTwwxcQovcQmpKUSt7NT2hzGLt
         ww0icQcTO4SM6kNVJ78stJYu+FO9symFWcgydhC36yBko40fWqdbd7p74jodI1ZRjMDH
         FncQ==
X-Gm-Message-State: ABuFfoiviPb/goycMyhS8MgzOkvAiuwbMKq3DpKfeLeXEbYiYOvlsAeL
        EcDIq16XVl7ZXuSmatIgm8d4fw==
X-Google-Smtp-Source: ACcGV62gtGp+dWxaEzs3KziqR8iPoDl9Yh84dvTqcMksDb6+DjHYohhyApW0IsrPrgXPyHrMJnIwOw==
X-Received: by 2002:a5d:5009:: with SMTP id e9-v6mr8199080wrt.18.1537783928856;
        Mon, 24 Sep 2018 03:12:08 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-2-33.w90-86.abo.wanadoo.fr. [90.86.1.33])
        by smtp.gmail.com with ESMTPSA id o12-v6sm3291728wrj.58.2018.09.24.03.12.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 03:12:08 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joe Perches <joe@perches.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <guro@fb.com>,
        Huang Ying <ying.huang@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v3 4/4] clk: pmc-atom: use devm_kstrdup_const()
Date:   Mon, 24 Sep 2018 12:11:50 +0200
Message-Id: <20180924101150.23349-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180924101150.23349-1-brgl@bgdev.pl>
References: <20180924101150.23349-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
an example of how to use this new routine to shrink driver code.

While we're at it: replace a call to kcalloc() with devm_kcalloc().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index d977193842df..239197799ea3 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -247,14 +247,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
 		plt_clk_unregister_fixed_rate(data->parents[i]);
 }
 
-static void plt_clk_free_parent_names_loop(const char **parent_names,
-					   unsigned int i)
-{
-	while (i--)
-		kfree_const(parent_names[i]);
-	kfree(parent_names);
-}
-
 static void plt_clk_unregister_loop(struct clk_plt_data *data,
 				    unsigned int i)
 {
@@ -280,8 +272,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 	if (!data->parents)
 		return ERR_PTR(-ENOMEM);
 
-	parent_names = kcalloc(nparents, sizeof(*parent_names),
-			       GFP_KERNEL);
+	parent_names = devm_kcalloc(&pdev->dev, nparents,
+				    sizeof(*parent_names), GFP_KERNEL);
 	if (!parent_names)
 		return ERR_PTR(-ENOMEM);
 
@@ -294,7 +286,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 			err = PTR_ERR(data->parents[i]);
 			goto err_unreg;
 		}
-		parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
+		parent_names[i] = devm_kstrdup_const(&pdev->dev,
+						     clks[i].name, GFP_KERNEL);
 	}
 
 	data->nparents = nparents;
@@ -302,7 +295,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 
 err_unreg:
 	plt_clk_unregister_fixed_rate_loop(data, i);
-	plt_clk_free_parent_names_loop(parent_names, i);
 	return ERR_PTR(err);
 }
 
@@ -352,8 +344,6 @@ static int plt_clk_probe(struct platform_device *pdev)
 		goto err_drop_mclk;
 	}
 
-	plt_clk_free_parent_names_loop(parent_names, data->nparents);
-
 	platform_set_drvdata(pdev, data);
 	return 0;
 
@@ -362,7 +352,6 @@ static int plt_clk_probe(struct platform_device *pdev)
 err_unreg_clk_plt:
 	plt_clk_unregister_loop(data, i);
 	plt_clk_unregister_parents(data);
-	plt_clk_free_parent_names_loop(parent_names, data->nparents);
 	return err;
 }
 
-- 
2.18.0

