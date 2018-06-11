Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D0hkGyZkHlu+YgAAmS7hNA
	; Mon, 11 Jun 2018 11:59:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E951607A4; Mon, 11 Jun 2018 11:59:43 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFA2SFro"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 720A3601C3;
	Mon, 11 Jun 2018 11:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 720A3601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933440AbeFKL7j (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:39 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38280 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbeFKL7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:23 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so11854792wrs.5;
        Mon, 11 Jun 2018 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1b3T00LT776cjws/7uRu1+/NoUBBVjylLXcQSc5tQnY=;
        b=aFA2SFrodI/AIU+2WMIItf6lmRZfuGP4cWMLYTSKEMJjv7gT2cdTl//qtJEGMdv5in
         MwChWJz5hwF6GJR6X9MPV3ICXKLxifvGMHNZN04FBqfOBsMmRdbaSDgSLrhD/bloC+/r
         0PDyULcVjn8X5VrzgkQFs8qI9IlSDUgwe36RDWJ0v0z0mmio4PWHHEIpcVmyobiJXtFG
         BLo/R9xRzvY2qcUJ60kVODz09OKhiVDiWk8Yid/YBphlArcM+2BJDpXi3DKQfif0qJ9S
         VPjdukShEksksOVHabKPl/YvYl/wewcRaPOmSf8SZDSyBjfo5/DkcvYcZWv2jvkOHKcg
         pNtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1b3T00LT776cjws/7uRu1+/NoUBBVjylLXcQSc5tQnY=;
        b=pEYZSIALK3wge43i8eAXZatudukVFDgIH2dC5ns5RamUT/37JDOGuHcLcfxigIgVhf
         mKq/MPHYWdurnGLner5+TLmY9md09Fz61twYW6pYgv6w3lFVhtCMs8UgWQP2ygnxiDAM
         UZM0bI5raZ2Cxw/C0l6XGgwwWWIcZW2naUFTaMbtJqqo9RExOcqNUY5k+sFiyltujSOI
         zwm5WOV9ncJaFqhi+M67vBLuIKnm8JzUdcQ+6YDDFLs135X5zx7M7NJmdwPBew0VTbJv
         WHxdsLHlmWQj3huipogrE7nUMJtHm8i5uxgvy2mLFS8s87ypf6mMEISC7RIcQP/Bngfp
         gAUA==
X-Gm-Message-State: APt69E0mYJ8EQF5dBi6JtYxcP0me9n0uSe/0Y8ayUUAMKMLBueoPXfLv
        IuMh06OUvWtida1F8m9jJLTC2Vhl
X-Google-Smtp-Source: ADUXVKJ2H4szoYlkTl4hxnUpBvLMcp43Beofl1eIeTfNR8Mn52BCNzALSQYz3UtA843bekV3cjbQjQ==
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr12756727wru.120.1528718361596;
        Mon, 11 Jun 2018 04:59:21 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:20 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 14/14] mfd: da9063: Add DA9063L support
Date: Mon, 11 Jun 2018 13:58:51 +0200
Message-Id: <20180611115851.1987-14-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for DA9063L, which is a reduced variant of the DA9063
with less regulators and without RTC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
---
V2: No change
V3: No change
V4: No change
V5: No change
V6: No change
---
 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index a449a9263dd7..50a24b1921d0 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -186,6 +186,7 @@ static struct regmap_config da9063_regmap_config = {
 
 static const struct of_device_id da9063_dt_ids[] = {
 	{ .compatible = "dlg,da9063", },
+	{ .compatible = "dlg,da9063l", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, da9063_dt_ids);
@@ -231,6 +232,7 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{ "da9063", PMIC_TYPE_DA9063 },
+	{ "da9063l", PMIC_TYPE_DA9063L },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, da9063_i2c_id);
-- 
2.16.2
