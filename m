Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06551ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B32CE20685
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 21:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBbFAUWb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32CE20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeIZD7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 23:59:41 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40740 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIZD7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 23:59:41 -0400
Received: by mail-io1-f65.google.com with SMTP id w16-v6so3588755iom.7;
        Tue, 25 Sep 2018 14:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ysfSkpixO2yl8uMGR1FCWmHvdez/6Jg2aRagge3VwsU=;
        b=jBbFAUWbb4xkEO792L3X5JCO5yWP6VIu45P0DL7N0Ixo8uJ37ADKtmoKzYU+u5Vo8Q
         8dGHGi44/RIDAluh+TGlQghv++nRzboupvH6rkBT6eRHkMmch1DtrPLB20yo28ntBfwG
         s3tVlK0Mt8XgLOhThSCLAJqd/BY9p+ken7lESBlE6Kb+eK2iYIuDy8KUrXiUYsxlc+jn
         mJNxgo+pSj6mkUadSLhMyoYioX7i97JUyIiGq16NeV0i/h7O31ZxH+rKyzifpZNh3cYF
         f2HIlyVQxAVwkha0Jb6Pwr1/BmmAalrZdQjFYDx0LDL9+icXBYUAPLsXRkX/TMcsI131
         gCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ysfSkpixO2yl8uMGR1FCWmHvdez/6Jg2aRagge3VwsU=;
        b=KhRXgHXv8ghRN3nh+xaaCYhShANB8uah3CD0DrtAfNJhmxlGt2XpdACWpmPiednlww
         z/eN5fA8L3UxpcJzDApexYXO6w4GrjK61pOfME7LaQehBAdxZXARMyHZc6Qmj0RDXKqL
         XH5AOafWq1l10oOFZeyClH5ZOOw0oN4Evi0ZnRouOmpwNIcL2yXizFX4DnYHlXAWePqL
         R5LmxA7LeB5xR1bfjMdBJ8YYTV3xBPaWKAu7oHz7dSSIhZJJ1ERydlVaBrtIcVcgRjJB
         x2iByvUflM0p+2hXrgDDD6ESXbZm9f2MW5k08e4I+awjae0TTrbTsbs+WJDlT9faK4b2
         OBuw==
X-Gm-Message-State: ABuFfojsN7yfVlNnnIwrfDwQSd+oqzBYcmU3Z07Ms/BhCJzlyfhgFing
        OVuL+AaX7V87d7otkm/n6g==
X-Google-Smtp-Source: ACcGV62x0C5s3KaKNbBnH8bZMmkFFuOAllckZQehbOTWe+vV3TC43EvjxzjN1WPoaaSmZc1pZTiKTA==
X-Received: by 2002:a5e:d612:: with SMTP id w18-v6mr2811602iom.54.1537912204620;
        Tue, 25 Sep 2018 14:50:04 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id w193-v6sm1519981ita.11.2018.09.25.14.50.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 14:50:03 -0700 (PDT)
From:   Robert Yang <decatf@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Yang <decatf@gmail.com>
Subject: [PATCH V2] clk: tegra: Return the exact clock rate from clk_round_rate
Date:   Tue, 25 Sep 2018 17:49:40 -0400
Message-Id: <20180925214940.15188-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current behavior is that clk_round_rate would return the same clock
rate passed to it for valid PLL configurations. This change will return
the exact rate the PLL will provide in accordance with clk API.

Signed-off-by: Robert Yang <decatf@gmail.com>
---
Changes in V2:
 - Move input divider (m == 0) check into the cfg constraints check
   condition. Forgo adding WARN_ON and avoid using 0 input divider
   all together.

 drivers/clk/tegra/clk-pll.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 17a058c3bbc1..2a800a9c56e6 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -589,12 +589,13 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
 	cfg->n = cfg->output_rate / cfreq;
 	cfg->cpcon = OUT_OF_TABLE_CPCON;
 
-	if (cfg->m > divm_max(pll) || cfg->n > divn_max(pll) ||
-	    (1 << p_div) > divp_max(pll)
-	    || cfg->output_rate > pll->params->vco_max) {
+	if (cfg->m == 0 || cfg->m > divm_max(pll) ||
+	    cfg->n > divn_max(pll) || (1 << p_div) > divp_max(pll) ||
+	    cfg->output_rate > pll->params->vco_max) {
 		return -EINVAL;
 	}
 
+	cfg->output_rate = cfg->n * DIV_ROUND_UP(parent_rate, cfg->m);
 	cfg->output_rate >>= p_div;
 
 	if (pll->params->pdiv_tohw) {
-- 
2.17.1

