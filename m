Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Z76gCso7GVuOLwAAmS7hNA
	; Thu, 07 Jun 2018 14:06:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 06354607DC; Thu,  7 Jun 2018 14:06:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzvYr0FD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 780906063F;
	Thu,  7 Jun 2018 14:06:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 780906063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753733AbeFGOGM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:06:12 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:43882 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932906AbeFGOGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:06:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id d2-v6so9984622wrm.10;
        Thu, 07 Jun 2018 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5lSXkjONMMnvJE6XenhHmZNdOtNXMav6m/rBBVrGSCA=;
        b=DzvYr0FDV+wsZCGJHTMi8sUo6CDZ9dRCPe+yxB9INMqM4ZwfEoK26Bg08fgY+6NNHL
         QgEmagie6O8dQQus92bpHWDt/mIwxoZX4OyubsNKXyaGCzOLzo8oOCjmq+DRFn81wXSO
         uhW8kcOVCaGMknnl+0c7I8Pzwgf49cCr7NShX7p+1UxMrSGrbshAsykdLvcnZw3ljGQe
         DaF7XR7EWy+GUAk4M1TTajms2zwkkiRwjLRYC87xge0eV0TZUvP+5tqi1p87DmKfjloh
         S7M/nVdPIRJYCZNBRB+Ck1qIMc3wtoQvvzZL24HCnkkxsyj+FjfB4QpKioCg58cgAl82
         /87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5lSXkjONMMnvJE6XenhHmZNdOtNXMav6m/rBBVrGSCA=;
        b=gJN1Du8InA6j7Rv/FUjp0/5jAXi1w3g7QZf+Zddf5bQvBA/kuaIG52nBH5ZNrS5p9G
         6JjkRvUMNt/ZJUBmuD6LfH5VGLP36O4DAcFw2uHteNOQzP4C3FzbrtYloc8l+tMmrVqB
         giDcT3z/f6eJi9EC4r2H8ZAdZQG2C+2UGMlFi+SpCyksiNOYZaJ4x6FLEJzuDEe9ONDW
         qHVPD6wmAPLkGWBeT2VHSDwKGveWVyH+cABL2c8+mhQAvhPjx8I197Fz1H2kEQ3Md0lF
         auBri5uHWTIaDYBocw6tVrE+NS3RNkXIuwnn5wX+VaEAHZSPfidNPa3sx4n9BRJAboGg
         gfGA==
X-Gm-Message-State: APt69E1TV75vXPSpsXOQJEstvJUJlx0ElMT2N8aX4GarSh1gtU1Hj19O
        c9izptl7DkTbZmv0C8E8Ugw=
X-Google-Smtp-Source: ADUXVKJiF1y1soyb42fcafqzeF/K651isTSWbMVGM9YHf2nyNl1RtMTBXJwTeezIiYL0xFdNSVNFDA==
X-Received: by 2002:adf:8da1:: with SMTP id o30-v6mr1835739wrb.81.1528380366690;
        Thu, 07 Jun 2018 07:06:06 -0700 (PDT)
Received: from cperon-Latitude-7490.lan (static-css-csd-151233.business.bouyguestelecom.com. [176.162.151.233])
        by smtp.gmail.com with ESMTPSA id 135-v6sm2032331wmx.21.2018.06.07.07.06.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:06:05 -0700 (PDT)
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
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?q?Cl=C3=A9ment=20Peron?= <clement.peron@devialet.com>
Subject: [PATCH v6 2/5] ARM: imx: remove inexistant EPIT timer init
Date: Thu,  7 Jun 2018 16:05:41 +0200
Message-Id: <20180607140544.22268-3-peron.clem@gmail.com>
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

From: Clément Peron <clement.peron@devialet.com>

i.MX EPIT timer has been removed but not the init function declaration.

Signed-off-by: Clément Peron <clement.peron@devialet.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
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
