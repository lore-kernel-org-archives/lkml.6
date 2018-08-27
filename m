Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19303C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62242174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="kSA+bUIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C62242174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeH0MHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:07:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41005 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbeH0MHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:07:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id z96-v6so12751554wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rAADFiEcrgAP/MWUhEq9f5JToaQRAnXC+gfalAjE3k=;
        b=kSA+bUIPd6Kz4LJRN6u2xwlR03fuwZZ0LXX7sehdNQwu33qwmRrZyno38C8pUoZHfw
         JeAER5jFwAR2r3pHlT72urG7rxpz27ZVMgsenvJk3vF9hJLAVE90j5/OlXAZupc+s3p+
         tehRe76aLGrVhr/oZL/mdKoNuNCap/PIrVVcc4VZbZQ26r/dZxUekiJsXE67ET5wIOrG
         rPaamujN3EOrUS4t/N5dUJLHG7g8pvmO2+8HzrU+Wug2Vqt4WEo9hKOJjigQN8Uv+5Ny
         zc/DapaghZbfFfpIK7LLFtW/JQNpCfpK1mwPw+wKyo1A/S1BJsrMHK7bgBhmw57NPf9y
         tqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rAADFiEcrgAP/MWUhEq9f5JToaQRAnXC+gfalAjE3k=;
        b=DP1OqS3jQskRmvq1PLGS76H2TSUui5mjvIn3NC/ke4KkE+1RtXEXPYQqoiDPcY60b0
         zYZHZWmL9fv+ohsSEqEw4hALoxJaRN/x9dxjsDUDV3fNEn1hVC+VNdOXtkwENuSKaQq6
         hArPM2oqiKbNKGzijj553uSkGofGHmNgdeElz5DrCHqYXJlUvivH7DU/Jnmxjx2bLYQQ
         FEsrPMu5/pQtY2pgfNNd7hL1gx9aiWsIShUZ3Y3jwnwNn7HFxlFZXfKec6TUN67kwZiD
         NGhD2RbfTThpwTrgS4RQ9G9zn80e0IwyL5YCW8xT49d8UHb4G7NJK1syBBWurLpwqOFj
         i5Zg==
X-Gm-Message-State: APzg51BsK21F5jpP6meA1fTZ2gCo4mz/BnXIhGZZKYiz6yTF6k6Ztz6e
        Tyk+VVqGWlX7EA87qJSY+yeCBw==
X-Google-Smtp-Source: ANB0Vda/wBMEVgVNlmupmmRuXOmBZUZx3pISV5xfHqiKv7wtutnfRK5d+xufRmR7miQhQbIZvZxuAw==
X-Received: by 2002:adf:f24e:: with SMTP id b14-v6mr7420220wrp.184.1535358098735;
        Mon, 27 Aug 2018 01:21:38 -0700 (PDT)
Received: from brgl-bgdev.baylibre.local (AStLambert-681-1-34-229.w90-86.abo.wanadoo.fr. [90.86.153.229])
        by smtp.gmail.com with ESMTPSA id b144-v6sm15402309wmd.23.2018.08.27.01.21.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:21:38 -0700 (PDT)
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH 2/2] clk: pmc-atom: use devm_kstrdup_const()
Date:   Mon, 27 Aug 2018 10:21:01 +0200
Message-Id: <20180827082101.5036-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082101.5036-1-brgl@bgdev.pl>
References: <20180827082101.5036-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_kstrdup_const() in the pmc-atom driver. This mostly serves as
an example of how to use this new routine to shrink driver code.

While we're at it: replace a call to kcalloc() with devm_kcalloc().

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/clk/x86/clk-pmc-atom.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/x86/clk-pmc-atom.c b/drivers/clk/x86/clk-pmc-atom.c
index 08ef69945ffb..daa2192e6568 100644
--- a/drivers/clk/x86/clk-pmc-atom.c
+++ b/drivers/clk/x86/clk-pmc-atom.c
@@ -253,14 +253,6 @@ static void plt_clk_unregister_fixed_rate_loop(struct clk_plt_data *data,
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
@@ -286,8 +278,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 	if (!data->parents)
 		return ERR_PTR(-ENOMEM);
 
-	parent_names = kcalloc(nparents, sizeof(*parent_names),
-			       GFP_KERNEL);
+	parent_names = devm_kcalloc(&pdev->dev, nparents,
+				    sizeof(*parent_names), GFP_KERNEL);
 	if (!parent_names)
 		return ERR_PTR(-ENOMEM);
 
@@ -300,7 +292,8 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 			err = PTR_ERR(data->parents[i]);
 			goto err_unreg;
 		}
-		parent_names[i] = kstrdup_const(clks[i].name, GFP_KERNEL);
+		parent_names[i] = devm_kstrdup_const(&pdev->dev,
+						     clks[i].name, GFP_KERNEL);
 	}
 
 	data->nparents = nparents;
@@ -308,7 +301,6 @@ static const char **plt_clk_register_parents(struct platform_device *pdev,
 
 err_unreg:
 	plt_clk_unregister_fixed_rate_loop(data, i);
-	plt_clk_free_parent_names_loop(parent_names, i);
 	return ERR_PTR(err);
 }
 
@@ -351,15 +343,12 @@ static int plt_clk_probe(struct platform_device *pdev)
 		goto err_unreg_clk_plt;
 	}
 
-	plt_clk_free_parent_names_loop(parent_names, data->nparents);
-
 	platform_set_drvdata(pdev, data);
 	return 0;
 
 err_unreg_clk_plt:
 	plt_clk_unregister_loop(data, i);
 	plt_clk_unregister_parents(data);
-	plt_clk_free_parent_names_loop(parent_names, data->nparents);
 	return err;
 }
 
-- 
2.18.0

