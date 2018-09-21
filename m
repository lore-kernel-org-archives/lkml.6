Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91F8ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 669842156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 22:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A85+X/Lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 669842156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391601AbeIVDvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 23:51:36 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37030 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391323AbeIVDvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 23:51:36 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so13571189iob.4;
        Fri, 21 Sep 2018 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DX9KFFcKuSzYEGeCtNdPuIjmyHcNuxj4/0N5ygp7TZw=;
        b=A85+X/LjIG+tZkH4M0GMnw/q34INpo5VbpvB8/7jte3R8/c7jxRgAgZfeP/SHvtW1y
         YYYnZcnK+h+PngUryKjcQHEjTeCi3Ski6sdTxN1+xMSX0HNfBDmraV5KOL1SI9q1oXCL
         jQUfN20xOb5H8bDTF12PMd4fwOswA33EXNfjulG1okMM8vc5Htp/Ua9v4CTmyGdsgPsL
         M+SKV2HzwpGBH4uPAd2n9ANA9aTgeAINORC87hdtUtTRwJZ67eglizAXb5LSrqTBQamL
         L10fpHJNiUqekWN6CwGXkHOTVGLO/3CE5csUmoFZNglKm8lIpg1IFQnr8RyhY2yHe7s9
         WmSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DX9KFFcKuSzYEGeCtNdPuIjmyHcNuxj4/0N5ygp7TZw=;
        b=awljl6x9M0SICga3SlWFiaYpLEINhwEIyp1tgwGpAw/RPu8mfDiLGDXgJw+v6O+QkE
         UivmSeDbtjJP5pK5oRH3HjRZz5XwrAbUjs/+Rf3kHDFspaIBsb1PwhLWG4oSlFouzaf8
         JsCtGAVMl+3OUlJ8ocSFN+UjRCYYdEZ6+iJCiqAB3gl+j37cwLD/oesTeu6J2gPNN8rD
         8WCvl26IdhgeKQnulyN8adfJ+lg465phkymt/6WaFqijP/wpV0QsQyqodzR5Tpg4WWK6
         Ruz9M6uD0p86xc+Mv6kZBwY6K8mb/Oh7JpQjUpHKhBkTAeSr3l+PUxkiFVk6/g6Wfz8q
         7b3g==
X-Gm-Message-State: ABuFfoi+q9UG/6rL1w50G4Y1TBsbcHV3NurrRHCyePfWm7wp3cbw51UZ
        +3VxYwS/0cRvATNwFMNWOw==
X-Google-Smtp-Source: ACcGV60wuW+FmubhL3A3cieTqa8DbO1vWAY2LUns9lqZaKn9IQWq0xV7TuOh1ezEGATeMawq7iDvNA==
X-Received: by 2002:a5e:c009:: with SMTP id u9-v6mr7327914iol.155.1537567247949;
        Fri, 21 Sep 2018 15:00:47 -0700 (PDT)
Received: from localhost.localdomain (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id n194-v6sm2478859itg.14.2018.09.21.15.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 15:00:47 -0700 (PDT)
From:   ryang <decatf@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryang <decatf@gmail.com>
Subject: [PATCH] clk: tegra: Fix an infinite loop when clock rate is zero
Date:   Fri, 21 Sep 2018 18:00:37 -0400
Message-Id: <20180921220037.16862-1-decatf@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calling clk_set_rate or clk_round_rate will lock up the kernel when the
rate is zero. This avoids the infinite loop and uses a slightly more
optimized p divider calculation.

Signed-off-by: ryang <decatf@gmail.com>
---
 drivers/clk/tegra/clk-pll.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 830d1c87fa7c..17a058c3bbc1 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -582,9 +582,8 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
 	}
 
 	/* Raise VCO to guarantee 0.5% accuracy */
-	for (cfg->output_rate = rate; cfg->output_rate < 200 * cfreq;
-	     cfg->output_rate <<= 1)
-		p_div++;
+	p_div = rate ? fls((200 * cfreq) / rate) : 0;
+	cfg->output_rate = rate << p_div;
 
 	cfg->m = parent_rate / cfreq;
 	cfg->n = cfg->output_rate / cfreq;
-- 
2.17.1

