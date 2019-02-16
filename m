Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED81C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB40222A3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qIlJz3mp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbfBPPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 10:18:49 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34261 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbfBPPSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 10:18:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id j18so6295812pfe.1;
        Sat, 16 Feb 2019 07:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SIG+Lmpa8nZxwp/WdoBDzBbfQWf8IQ+YMup+W1n5rIA=;
        b=qIlJz3mpCgeIVKE4/QPwLeAiUZ2jiD504u9gTdtZ2egCr0V8t53TxQb1jLUOzQWcrA
         Vb1raaB82E0YndMwhSmn6WxILZu8Vv51zShas5SdgRYlCi1q+iDsitgd/FiP3QGtVKy6
         DZaZ+NSGspUWzShZ0H5GgKVH8yPw5NsX620Lf5XPuS2QcFagHeXigHcp22yhxHwUjyEt
         pb5QOxXxU0kvic24exq4pyKGLfQHkDx8R8D612OTPB7K/cl7VzS3u55TS3Mw6Jyca8ip
         h7dqsX7dkjUGtEdsZv6Rw9qLveuFmGfXHyY9si23dvHkj4I6sPLLFpa+jjXyAGdTCfto
         pVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SIG+Lmpa8nZxwp/WdoBDzBbfQWf8IQ+YMup+W1n5rIA=;
        b=iN+QQrBeuHAquthZ3rfvOy943xn4hAph5OqUxmeX3zGGS/wlYp1MjNHSm634wlVeuO
         RwAE/XPxl/lQx2dl2JuNE0xeHEsUCw74L0VR8q5y3A9auitQ+Ar/20V+cmczcZW43oM2
         SH/IRkpPKa5VbAjf7iFbBV8OJn6ldNfkF3JdH6JRnJFiWOQeJDAofXUKBZA9dESnnO2k
         PFoQJieksyLGq8V/chRIIQW0ZfbNAza4vpJh0igXTiNVScpxwGCoLApX4qASgteUDkBZ
         ue9gpqrSlcB2uu7Ubclmt3rEsrJNTWqev9zZyDcH3Z6vtYARPtLjkDm3+bsxVQjk4SS4
         BAjA==
X-Gm-Message-State: AHQUAuZlf77JM0yVi2yNmCAyNaq4Cojbc0m/aYwXipGCNxlFOWPzv6k3
        Aur6meRfsK6CX/jzK1Jt8Qg=
X-Google-Smtp-Source: AHgI3IY+Xsf+vgV6zCpM2LC6oINCYqpY2j0HCRScZUBs7CsqvJKaOaraRdTsaTtMp6gOrQK1U5jB+w==
X-Received: by 2002:aa7:8d57:: with SMTP id s23mr15131241pfe.237.1550330327281;
        Sat, 16 Feb 2019 07:18:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id c124sm12197367pfb.3.2019.02.16.07.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Feb 2019 07:18:46 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     cw00.choi@samsung.com, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com, heiko@sntech.de,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
Date:   Sat, 16 Feb 2019 10:18:25 -0500
Message-Id: <20190216151826.11584-3-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22b113363ffc..fcbf76ebf55d 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -211,7 +211,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk)) {
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->clk);
-	};
+	}
 
 	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-- 
2.17.0

