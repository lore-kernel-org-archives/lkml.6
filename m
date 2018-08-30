Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CB8C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64CCF20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gv0f1O/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64CCF20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbeH3WkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:40:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39922 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeH3WkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:40:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so4271656pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 11:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7p3Rca3GRAcPgKvADJaLhWlNpbrxllQ6VJusqqY9EMo=;
        b=Gv0f1O/SFa72Zw7pm+stVl4mJPonkPHp2F4yRz9wEPW8LMz0PUtbi9ghZ3WgU5azaj
         nIaDxSL1p8FRNImN0mLN8MryEoU7yOe1btkM/uIQNHnVmRoXRwTKuR1bSuayM1u/kZep
         rcMfwv9sHhGCpwvg6jjIpbBEMeP+R1JBUQWrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7p3Rca3GRAcPgKvADJaLhWlNpbrxllQ6VJusqqY9EMo=;
        b=TPDVL50+R1fcQwaDdR0D21NymKh3sHBNFFSiCos+vLSnCdoQJgPJMdb0SKAyWNn6Xf
         TGrH5kB1CTJz2L9nAQUUazOwjQEhuiuY95viaoG74n041BK7FD2cq3XybjSdmg6zjriC
         jaIrMj5LtBG4qLLjBtX9ypU75WNSGcTXkcxtlwhZ53yPXWwd+EWMPmjvkzjpmtjK8WqW
         KR5UCeh1ETHskQ+imDb7j9xZVj9RrQ900KAKFLNHusASmssCutW228q9tKdRuiILYda5
         8AxTVVPi517xiDBt161UFgbZ6XEvRBTMFbTqQpj27WMnLMZOE8sDnTsy9u+lzgn6wOM3
         NnXA==
X-Gm-Message-State: APzg51BTRhlzBDjiphJffXG9SJZrTxFX7Wcwy4F263jISHAcN8M4zjbQ
        2mZ7ZkeQq4eP9w1nofpwmocz/g==
X-Google-Smtp-Source: ANB0VdajO1oMN2743qqr7LSG2Vaiuegsasr1N9VjicC4XK9O8QLo88HuxtYXAKcc26NvANk4mNULPg==
X-Received: by 2002:a63:c702:: with SMTP id n2-v6mr11134084pgg.108.1535654199118;
        Thu, 30 Aug 2018 11:36:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:c8e0:70d7:4be7:a36])
        by smtp.gmail.com with ESMTPSA id c68-v6sm14470946pfj.51.2018.08.30.11.36.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 11:36:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, girishm@codeaurora.org, dkota@codeaurora.org,
        evgreen@chromium.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: geni: Don't ignore clk_round_rate() errors in geni_se_clk_tbl_get()
Date:   Thu, 30 Aug 2018 11:36:11 -0700
Message-Id: <20180830183612.169572-1-dianders@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function clk_round_rate() is defined to return a "long", not an
"unsigned long".  That's because it might return a negative error
code.  Change the call in geni_se_clk_tbl_get() to check for errors.

NOTE: overall the idea that we should iterate over clk_round_rate() to
try to reconstruct a table already present in the clock driver is
questionable.  Specifically:
- This method relies on "clk_round_rate()" rounding up.
- This method only works if the table is sorted and has no duplicates.
...this patch doesn't try to fix those problems, it just makes the
error handling more correct.

Fixes: eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/soc/qcom/qcom-geni-se.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index feed3db21c10..1b19b8428c4a 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -513,7 +513,7 @@ EXPORT_SYMBOL(geni_se_resources_on);
  */
 int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 {
-	unsigned long freq = 0;
+	long freq = 0;
 	int i;
 
 	if (se->clk_perf_tbl) {
@@ -529,7 +529,7 @@ int geni_se_clk_tbl_get(struct geni_se *se, unsigned long **tbl)
 
 	for (i = 0; i < MAX_CLK_PERF_LEVEL; i++) {
 		freq = clk_round_rate(se->clk, freq + 1);
-		if (!freq || freq == se->clk_perf_tbl[i - 1])
+		if (freq <= 0 || freq == se->clk_perf_tbl[i - 1])
 			break;
 		se->clk_perf_tbl[i] = freq;
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

