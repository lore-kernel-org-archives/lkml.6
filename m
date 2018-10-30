Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C494FC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DF2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="toLJdzQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2DF2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJ3TPd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:15:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42705 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbeJ3TPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:15:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id y15-v6so11922673wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ygrPMk+pJcXRHcdBwiVFBHzojOA9Y2YhpU+L53lNZo8=;
        b=toLJdzQXZuWeQ41ePJRpCYzE1Y1Kkqt3wzv1EeS2IEaQLPs02n22JxHgeb4YgnQbt1
         wZPoG0YdrhFQS+Ea+on8EQV6AsiDL7Pqq83JaDSvLTzYe1kzZU/xoYCf+Zt7S88cG/ZX
         IHHJ8HWTIOcs/L8PUqryPG3vjyvgtu5GIsmTwvuBOADxK7ocW476OsheVEsP4TIF/lZC
         LgpvOa//TBh5SPzs9pQ+2auyU2A0f6kOIVCSSCxSkXq/wjkWgjBB7PdD5buGGia1kwT2
         e3U2Xz0HPvZbL/HPpHshj5QiWrBC4OBtD1PMIAZdK8fGMnsFWtvXjozYpqQO/w4Aq/fe
         yyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ygrPMk+pJcXRHcdBwiVFBHzojOA9Y2YhpU+L53lNZo8=;
        b=H0qK1JwgMADhuNrH6Cy3nHkdwESPgrYbEBCfU6SiZkNqPzus3mUwiCsmiVyDO71uo2
         md6fqs9Do+2riHnL7o38+swt6o9JvPoMHSIaYSmdEGvZcz+LQus8L1KqXtb39uhuJaCV
         8iZk1103Ju2QlcEG0o+tT55fPcAh8T8VqzyBoesJjrlLYVwIHe9s9lg9gOpS7kdLG3QU
         DvW64eQq3CbpTIfmNZmh8e52Ou6aPqC2Bzp0SyzPdJ7fU8w5SaqXleVHMXjZ+0jPU/Gy
         Vjne8s4H5V5MB21NAUnU6vECi/CNsMIvnySru4qiEV9CaNssqUw8QqIeeFHSlONBDtrz
         vn+Q==
X-Gm-Message-State: AGRZ1gJGqTzxn//ZSbEIl1K5WoHdgi0O0Ksrw0wzyuACDefoKaQOLIY+
        k6AefukAOlT54uHUzNC9WguodA==
X-Google-Smtp-Source: AJdET5cTpLf/6aUDl7mcVpuWwPuGLiWk3ee47vhlyMUW3k1KW2wHmSPuUi+TOnT/mvhMo0rFmhW2WQ==
X-Received: by 2002:adf:dc07:: with SMTP id t7-v6mr17115982wri.107.1540894959698;
        Tue, 30 Oct 2018 03:22:39 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i204-v6sm26638614wmd.28.2018.10.30.03.22.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 03:22:39 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] nvmem: meson-efuse: add error message on user_max failure.
Date:   Tue, 30 Oct 2018 11:22:28 +0100
Message-Id: <20181030102231.4851-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181030102231.4851-1-jbrunet@baylibre.com>
References: <20181030102231.4851-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an explicit error message when SM_EFUSE_USER_MAX command fails

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvmem/meson-efuse.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index d769840d1e18..40b9df1d030d 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -48,8 +48,10 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	struct nvmem_config *econfig;
 	unsigned int size;
 
-	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0)
+	if (meson_sm_call(SM_EFUSE_USER_MAX, &size, 0, 0, 0, 0, 0) < 0) {
+		dev_err(dev, "failed to get max user");
 		return -EINVAL;
+	}
 
 	econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
 	if (!econfig)
-- 
2.17.2

