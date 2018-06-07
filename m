Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dgs/J9A7GVvbLwAAmS7hNA
	; Thu, 07 Jun 2018 14:07:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 126E0608BA; Thu,  7 Jun 2018 14:07:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsJ9KVXh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 819CC607DC;
	Thu,  7 Jun 2018 14:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 819CC607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932951AbeFGOHQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:07:16 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:40569 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932663AbeFGOGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:06 -0400
Received: by mail-wr0-f171.google.com with SMTP id l41-v6so10001004wre.7;
        Thu, 07 Jun 2018 07:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SZwnYaLOHvWnvhVnz3/4bviYQXo2F1Odm5lNcgFNkNg=;
        b=bsJ9KVXhA5O490LXm/fPWO1QcxOOssyzoBms/FZGFp4xZTp/DplO8TuxoJ9Dbf/p9H
         Rq/M9ZayXYVGGfOBhvKO6RC0U4bhnhLs1Q94/fR0jQeiB91V/7eu9wvpEQle6UdlNiOp
         qz/P1DkjREF4HzQpy7jrK/7tWwln4+Tbvjh0ex6ORebC373+kebqUvwepWmiVUfEunF1
         zGdPbk+P9ohkoZwO8ThlFCnk3dsxXXlD+P29udlkv2dP/kvtglPsvigucncVAI+AIXxx
         Z1Cjtkm1DhhOMHqCaR8y177RzpQzDNMLj5Pgv6yhBV5qr9iGZqscZXhXXhrSozqSEyt+
         f/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SZwnYaLOHvWnvhVnz3/4bviYQXo2F1Odm5lNcgFNkNg=;
        b=sTYAbjacwEmBWmfyOTEcQiZptXlGQ8ec7Hf1soipO8mbc7qEqIjnu5ZwCpf18S4+pF
         WhAGKdBRnmf4X2wzUjVZCZOkRBRu8Nra4RmGPLYNmHBff+Qqx7JuoCVPV4hTAREoAGlt
         acaMqykM7/vuyks5ZUe45xMnQ6TBz//pt0NzFg9noY0cSOTmKfW6MPUQoZqVvFSOac+2
         PSYwfkuefL6aEBN07W3PhrhhaK3OQegJSNQgXjqNJDlkxC+Mg3thYGrH1JBJyKt3d7RI
         3Yn3QkQ9ZLh9bNo4w2bMRJeTI6buCChGbEyn71kDfqlwbwdSWzg84FdNUeJ5HjDVMei7
         NgZg==
X-Gm-Message-State: APt69E1hptJMPG1dmGBBM14pj1sP56KxJbhKHQOvqXci/sWHl47TU09n
        m0S9SQJU5dPEMMC/3h7e9Fs=
X-Google-Smtp-Source: ADUXVKJ4Nl7WP0K/wSucUo7wQW7K51ZK8e766W67so7Ff4Zg5hz9/5YvgLHTJCggo0SCQYDN2izNSQ==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr1801578wra.114.1528380365605;
        Thu, 07 Jun 2018 07:06:05 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 135-v6sm2032331wmx.21.2018.06.07.07.06.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:04 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v6 1/5] clk: imx6: add EPIT clock support
Date: Thu,  7 Jun 2018 16:05:40 +0200
Message-Id: <20180607140544.22268-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180607140544.22268-1-peron.clem@gmail.com>
References: <20180607140544.22268-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Didier <colin.didier@devialet.com>

Please ignore this commit.

It has already been merged in clk-next.

Leave it here to avoid error with automatic CI.

---
 drivers/clk/imx/clk-imx6q.c               | 2 ++
 include/dt-bindings/clock/imx6qdl-clock.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..b9ea7037e193 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -753,6 +753,8 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	else
 		clk[IMX6Q_CLK_ECSPI5] = imx_clk_gate2("ecspi5",        "ecspi_root",        base + 0x6c, 8);
 	clk[IMX6QDL_CLK_ENET]         = imx_clk_gate2("enet",          "ipg",               base + 0x6c, 10);
+	clk[IMX6QDL_CLK_EPIT1]        = imx_clk_gate2("epit1",         "ipg",               base + 0x6c, 12);
+	clk[IMX6QDL_CLK_EPIT2]        = imx_clk_gate2("epit2",         "ipg",               base + 0x6c, 14);
 	clk[IMX6QDL_CLK_ESAI_EXTAL]   = imx_clk_gate2_shared("esai_extal",   "esai_podf",   base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_IPG]     = imx_clk_gate2_shared("esai_ipg",   "ahb",           base + 0x6c, 16, &share_count_esai);
 	clk[IMX6QDL_CLK_ESAI_MEM]     = imx_clk_gate2_shared("esai_mem", "ahb",             base + 0x6c, 16, &share_count_esai);
diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
index da59fd9cdb5e..7ad171b8f3bf 100644
--- a/include/dt-bindings/clock/imx6qdl-clock.h
+++ b/include/dt-bindings/clock/imx6qdl-clock.h
@@ -271,6 +271,8 @@
 #define IMX6QDL_CLK_PRE_AXI			258
 #define IMX6QDL_CLK_MLB_SEL			259
 #define IMX6QDL_CLK_MLB_PODF			260
-#define IMX6QDL_CLK_END				261
+#define IMX6QDL_CLK_EPIT1			261
+#define IMX6QDL_CLK_EPIT2			262
+#define IMX6QDL_CLK_END				263
 
 #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
-- 
2.17.1
