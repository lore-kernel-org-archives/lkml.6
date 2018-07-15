Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF22ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FB420882
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 20:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1JaKIQU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FB420882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeGOU7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:59:41 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38494 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeGOU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:59:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so13713877wmf.3;
        Sun, 15 Jul 2018 13:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y1yA57BlSXddt5KN4OOHp1H7O42JeT8BPpuP+j4k7hs=;
        b=g1JaKIQUXUlFw6bHKW5RgTRbTn5QxROhvj84Yvb24NLpJlUnzPTExoQEOJzlI9CtZg
         NYOv9JD+CkSOtF0pb2KFbfnOn/QG4pIwgJk20BUqzymxVPKNYUguMwH2WtBNwf8muW4Z
         wp3hU33mErrcHmJz+mf675gkca+Lojkao/2PXJzQdSp7o3YoAOijxfH8BA1lIeAOGkLq
         m/0HoQF3fgDM3NQVeu/dF/aeFqeYhXk2OC9hrvRswNGMNdmA+JP15BzfOYjd7fUOLyd0
         5PuliO7wHQr4o6G5uDm0+9v9ufbz7vAb8MWLufypsOvVNd4ljJ2+eFPrsvYUg65lPFHE
         ytsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1yA57BlSXddt5KN4OOHp1H7O42JeT8BPpuP+j4k7hs=;
        b=rFRn9PKgIj7DA2/RWjryQVWBR6l0p9Wsc1sJHm0hMVzki/sUE7gP8OzPlpbhi/qsf8
         juYj7UP4NUVTdZ8i4oOeVcTz4GEpXMINXAsrV7RmTmf0wsVsjQdpdzelgXFj16Z6Y7XL
         fO1eN/9T86NFOuCnMo7cxzB678aI18iZWnHFsbfLRZYOqj5NJooCgyJ+8Zt04jia3hb/
         cZy0tc5Plm/jJxJP7tci/zxlg8kuLNfMXgQ9Kk+Cw3eXgJGpi/xnwy/NXGe/73012yGl
         MPB08kg4U9QwAAtvrfBM06xamrV5K7Oi/fOg+4mEotp4wve1bqSDaMuX3lTJloBWfhdY
         bbqA==
X-Gm-Message-State: AOUpUlFHA6QrDifi1tQYElumLArEdxLb2LtnDzsfnAIhbFhVb2c+a6UB
        QZcBdLrmFmE+jZBsJvmFnfM=
X-Google-Smtp-Source: AAOMgpc8JJQGgwYmsg/X2+VTF4wJgZkxqpvViS8FN96Z4gVVVdYjNlAPjZ9cB4ITIILcHihxhlyrjA==
X-Received: by 2002:a1c:d942:: with SMTP id q63-v6mr8758568wmg.78.1531686930875;
        Sun, 15 Jul 2018 13:35:30 -0700 (PDT)
Received: from parthiban.fritz.box ([62.91.12.240])
        by smtp.gmail.com with ESMTPSA id u25-v6sm11768387wrd.61.2018.07.15.13.35.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Jul 2018 13:35:30 -0700 (PDT)
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
Subject: [PATCH v6 1/5] clk: actions: Add missing REGMAP_MMIO dependency
Date:   Sun, 15 Jul 2018 22:35:20 +0200
Message-Id: <20180715203524.11948-2-sravanhome@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180715203524.11948-1-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGMAP_MMIO as dependency to avoid undefined
reference to regmap symbols.

Fixes: d85d20053e19 ("clk: actions: Add S900 SoC clock support")
Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
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
2.18.0

