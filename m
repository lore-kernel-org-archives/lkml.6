Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id YU5mIEyaHlupXAAAmS7hNA
	; Mon, 11 Jun 2018 15:51:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9C46060791; Mon, 11 Jun 2018 15:51:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcqLYnx5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1F59F60791;
	Mon, 11 Jun 2018 15:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F59F60791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752631AbeFKPvR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:51:17 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:41885 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932970AbeFKPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:50:12 -0400
Received: by mail-wr0-f181.google.com with SMTP id h10-v6so20925938wrq.8;
        Mon, 11 Jun 2018 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OctNiOvMZQodFuTkoSXeGAEO1GOlWVaF2nnI2M6IWAY=;
        b=NcqLYnx5NyzLLKb/fMQZ2xzLbcEFV86yJyzBCMXaON2UjI0jA+ti8MuHZ6HrQhGylC
         eR/E4v0VHRQEvZ1vV9keUCExBG4iQ8tywl4D3Hp+l403YRf0dxhaYuQNp+qC2P8iV2bl
         3cLnLASlCeDZtpt1PfcIt5YQ9Go4a2gR7EY94YoCwTlf6A1JgAiJQoXB8MnscdMYQlAK
         2gzgXIT423tnGkxHjq1o3NY+NiXRosy+kjMMaMEB17ZKzD1nV7Ctbf4Ev7SkqeDWhTRS
         SyHNVX7pnl/O/E8iicwLHG2pmYMXmu+mO8H/1y/x1AU3F60ZM0E/BD76vwQPbqJhpQ/Q
         +dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OctNiOvMZQodFuTkoSXeGAEO1GOlWVaF2nnI2M6IWAY=;
        b=X9NvdfDNHeK2p3C/7u3JfKy2yN+0cHyAsh0Z1bjjc2qDsQbrwrNiPVhIYDeXyURBZD
         i3tJnh9yal4W0RSOEY7ViBu4ninsrdCBm9Juol/AH1NsGv105DdTAj5vQGgIxOoTyVlP
         edzUCKeSiy0PZo4ZdYajjbWmCo5AWZYfTBL/ui8qa3tMdSN3JyHPONKw/846sA33/CCp
         +91SozId73+nnJSLhWsXtg9d5u5+emZLZ7eY3mRGPoN68T6srYNfl1gzgXMyJGXGk19W
         cbc5FLyCwNzd/WFCxj96SJAaDtuKksD4ZBqjhORFf5fMHyacbHuAyeea+1Tntk8fvpuu
         Qq0A==
X-Gm-Message-State: APt69E35chbjzFfiw3UKa8B+DyBITja1g05wiAhn4n6O5CwHzXQs8m9I
        u/LBTgB4HlE6qcafvISZE+c=
X-Google-Smtp-Source: ADUXVKJCfCjxWZO+ALKnn05m0/9g/pRZCZ3dsZv1lZQvEB6myBzYnHC6Amx7JQFccweN2RUtUZde2g==
X-Received: by 2002:adf:8023:: with SMTP id 32-v6mr11831390wrk.243.1528732210643;
        Mon, 11 Jun 2018 08:50:10 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id n11-v6sm30308862wro.13.2018.06.11.08.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 08:50:09 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: Colin Didier <colin.didier@devialet.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Stefan Agner <stefan@agner.ch>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v7 2/5] ARM: imx: remove inexistant EPIT timer init
Date: Mon, 11 Jun 2018 17:49:58 +0200
Message-Id: <20180611155001.3506-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611155001.3506-1-peron.clem@gmail.com>
References: <20180611155001.3506-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clément Peron <clement.peron@devialet.com>

i.MX EPIT timer has been removed but not the init function declaration.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
Tested-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/mach-imx/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/common.h b/arch/arm/mach-imx/common.h
index c8d68e918b2f..18aae76fa2da 100644
--- a/arch/arm/mach-imx/common.h
+++ b/arch/arm/mach-imx/common.h
@@ -38,7 +38,6 @@ void imx21_soc_init(void);
 void imx27_soc_init(void);
 void imx31_soc_init(void);
 void imx35_soc_init(void);
-void epit_timer_init(void __iomem *base, int irq);
 int mx21_clocks_init(unsigned long lref, unsigned long fref);
 int mx27_clocks_init(unsigned long fref);
 int mx31_clocks_init(unsigned long fref);
-- 
2.17.1
