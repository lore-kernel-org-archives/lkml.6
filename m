Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F2C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FBC206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVlGwazD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9FBC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730369AbeGSJtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 05:49:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38300 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727055AbeGSJtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 05:49:24 -0400
Received: by mail-wm0-f68.google.com with SMTP id 69-v6so5548492wmf.3;
        Thu, 19 Jul 2018 02:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jk4a9Zc5Ngur0p6FFaoMuR3MNXAALxfLWy/VOINzPnE=;
        b=nVlGwazDU5t0EzFDcBlEzuxPX+mI3IqZ59bRnWWvGVXo9fO61l+EGUTmXSDo8Rv7c1
         x6Z+humTOghnWJgsl5qGTV2frUvKg8SRsf1q6twDMk0LstlprVv2jC2TYY+9Q77Sat8d
         t+Jb6ypdcHIkyVVlPabAh+lQYfxlr39lAGGBlKTUnL5MKuaQkmMs5cC8IXBEsYXkGlNI
         wUmlrtYk4ZgtPEzF9xw6FTLwrz11Un3TNzSz9CL8DNY7VVcUKeglBc5lJUf5Bx4MXGRu
         C+M9FzXYulAgcJX6q83MRyGNJU4pluJ03S8JWdd5dvH8quscN+j3OFeTID2iRbNEsC39
         0jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jk4a9Zc5Ngur0p6FFaoMuR3MNXAALxfLWy/VOINzPnE=;
        b=doNreJ6VDmOMp3bwKqkECiIvaW1jAYlfwn4VQzdpNxy8tDfw0suHHu/74+jPch6ZZO
         Ts9jKKI/1D6tdJUGiGbnwt9YFLC+KjDUADfI1+pxdop5e+f+tZXt1HR13keAWppm2muZ
         wKqPJaVhFvF7ec3erO5Z2EVsfvTsehMT15MM8fMxCyBtKhNtH0X3SCdUO2Wy6ABUnJes
         ZtsSGtjQqWCBSyz41ghPECWlhFgSBayPpTHZnOVU4KagoFScMZWnPjzxjLMUCztDgtEI
         bSUWbWBnm5hHnvcPmt/0Ej8vWECyfeA+yXdHwixXFI7B+hZDYqALKH3Q3gVdHJNpcIFL
         LjqA==
X-Gm-Message-State: AOUpUlGBOLIEFUVMr7URHbAbsSqwW9Av5Von+PvuQAZ7O/6icaM22PcA
        xdD3L2SP7863Gw0RhA9Zmu4=
X-Google-Smtp-Source: AAOMgpcxHpCe0Np2GFxkHv16975xf5RQ10XrUAwY25Jhn+pJmCsJdlbg3qD7EbHspvpDWMw4jfeTHg==
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr3737489wma.143.1531991231886;
        Thu, 19 Jul 2018 02:07:11 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id j11-v6sm8162160wrr.37.2018.07.19.02.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 02:07:11 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        sboyd@kernel.org
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux@cubietech.com, sravanhome@gmail.com, support@cubietech.com,
        catalin.marinas@arm.com, mturquette@baylibre.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        thomas.liau@actions-semi.com, darren@cubietech.com,
        robh+dt@kernel.org, jeff.chen@actions-semi.com, pn@denx.de,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mp-cs@actions-semi.com
Subject: [PATCH v7 1/5] clk: actions: Add missing REGMAP_MMIO dependency
Date:   Thu, 19 Jul 2018 11:06:45 +0200
Message-Id: <20180719090649.12460-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180719090649.12460-1-sravanhome@gmail.com>
References: <20180719090649.12460-1-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGMAP_MMIO as dependency to avoid undefined
reference to regmap symbols.

Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Reviewed-by: Andreas Färber <afaerber@suse.de>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 8854adb37847..39491154abbf 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -1,6 +1,7 @@
 config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
+	select REGMAP_MMIO
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
-- 
2.14.4

