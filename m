Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B220CC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60FBD208A6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 09:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p//iCCA1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FBD208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeH1NeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 09:34:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbeH1NeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 09:34:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id k5-v6so923194wre.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1rAADFiEcrgAP/MWUhEq9f5JToaQRAnXC+gfalAjE3k=;
        b=p//iCCA1MuEaI2HpuhoGbJeHcq2jmfgPJ3XDrG/O5LZF3RXf2wsubecp6Goz7f0o79
         LzT65i1lmWoaar1tB5UxTxjHYLeLVHrvQscb6ydeLJHCsQEC69i39aaxHAOKVE1CKahY
         0m9Ms8Rx7z5+D6L0OSVn9vhev1b0VzkzfM2hrtrjE+pygIscDuYgdSobWncG3TQ7++De
         sD6EF5qddYdMx2C+2m+idpSPuNykz0yd5T2H8HNxVmT7wG1hwYOhg8Dyg+E1NitcTEm1
         xEWToxnbd0MTBOykkCMbKgEEowFIq/mwptYz6+dx0HFbepSNxia95yLEO1YoSRRJiJ0/
         KiIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1rAADFiEcrgAP/MWUhEq9f5JToaQRAnXC+gfalAjE3k=;
        b=Uy9tT7/N5vAPbs9JWx2F1FEEkOWfvJcFmn1X4GNjkH+9bPHlEbTfpmEjr6eZp1ulDH
         ceNrx/4jXaQWZV7qt+E7lV1lxJDNcn3qmWXpqDKtH4nq/LL8tHbFOVay9ea0eMRE1Mvi
         NriGVSomzVG8c+xL3PElMppV/ix7Dj5qHF1e2jyYkpxAzflh7Zjl1DRoeW0iznBBu2z5
         4OorIpjOGBEFLnR5FdJ/TbLfVkZr6aU0wMzYKoNW/AnpGywT60TStFbKxIElQv0hyrHQ
         wTurEBQCpVZvGhKQf9yLIrcKjFptOp2YrrteTmbBNHMMvMTLN+jPvU4WrOSa39MDOkHi
         Bw3A==
X-Gm-Message-State: APzg51CcGlqDalKgjIxZQ//wVg71H244G8uWEQCNwk9DHM2xQdK8MToM
        p1p3RLvshZkr++KX/wLvs6efDA4DAS8=
X-Google-Smtp-Source: ANB0Vdb1z1itApQb6iLVseTRPyo4shStOLvpCOq0LLmwi14Xk+YVt9l+6hKfzi1quea3dB05Pl4LFQ==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr604790wre.104.1535448851396;
        Tue, 28 Aug 2018 02:34:11 -0700 (PDT)
Received: from brgl-bgdev.home ([2a01:cb1d:af:5b00:e837:b8d5:48c1:571b])
        by smtp.gmail.com with ESMTPSA id l18-v6sm952276wru.75.2018.08.28.02.34.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 02:34:10 -0700 (PDT)
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
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v2 4/4] clk: pmc-atom: use devm_kstrdup_const()
Date:   Tue, 28 Aug 2018 11:33:32 +0200
Message-Id: <20180828093332.20674-5-brgl@bgdev.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828093332.20674-1-brgl@bgdev.pl>
References: <20180828093332.20674-1-brgl@bgdev.pl>
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

