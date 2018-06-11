Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id N6m8EU0HHlstDgAAmS7hNA
	; Mon, 11 Jun 2018 05:24:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AF713607A4; Mon, 11 Jun 2018 05:24:06 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgNLxmy0"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 41C11606FA;
	Mon, 11 Jun 2018 05:24:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41C11606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753949AbeFKFYD (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:24:03 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35169 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbeFKFYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:24:02 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so9176482pge.2;
        Sun, 10 Jun 2018 22:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cj9wXdp8pS9DKoRbfk2NrSh7hlosJB4rOwcJ3OStNI8=;
        b=dgNLxmy0zM2cYgyukp2DsAlA+cOS2+joQz6Sv29FK/I4OnZKiNx3OtHVNpRI8iOEfI
         RaKOfr0G6Zt4rQrDLnr8O6ZM6SHL08aRCK1juU4HB9VOmX/D1nJaQFmMQl4t3tO5KP2P
         08j0oQfiuZexF6D87gSi8t5r4eS0Yy58AQyyLiaRY7bXZyY7hgxRzSO3p3OPLqwLoLza
         nkAa3fT3Avm54CooLEQiCO9IFNIY015ZzfdNHpyJwo60IUbKiR7QRFk1DT08wOVHoKFV
         bCp5jZAy2vKybnlmk/38blvf83uwMoLoJXyg/gxO27u+lXqwfUEvbdgNR25Rg2+zDZ1w
         p5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cj9wXdp8pS9DKoRbfk2NrSh7hlosJB4rOwcJ3OStNI8=;
        b=IodGbY6kaywhbVl1EvmJmNKlazDVBTcevJ+Jb43bdeBmojYos8An0hENMN23OP4HPC
         eDgREtvl0G84anDP+FvvFJ7iehik1QKASDJQDtcGbAcGhFAfVBM2e0jiz8xa2eReumh2
         eQ79VGkRLMfuVq1GgrvR3nMjiB9NrcYBDrZFO+Gh6rXgwcoojlKml+rPFeaO5GXlPDMs
         l6SNCX04Q9FWR0v7X1v2yFSDAbj4kNMRBdxlRQZkBeeMaedtuFlx5JaPl+dvXBSSjoQ6
         WaknS8Beng7F+H+T0CfzsD+MpbkXQseop7B2ueW/5bjWpD/SlCx44y/V9RhYazxbMOsf
         1+7A==
X-Gm-Message-State: APt69E0ILuA73b0aZcrEzdoYR3L1a0mWQsSkIClWbCp7J8jnIBB1EiW8
        8a//nS/yJif0IEj8o3JDFo8=
X-Google-Smtp-Source: ADUXVKLyKdB95d1WsAALQ37Hm/+eG778LbalktSSNHOOqdWQU8jNSBsmS+B2nn2spMoL1lhlcxnDvA==
X-Received: by 2002:a63:7f44:: with SMTP id p4-v6mr10920705pgn.416.1528694641661;
        Sun, 10 Jun 2018 22:24:01 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id t10-v6sm38793159pgn.20.2018.06.10.22.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 22:24:01 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: add error handling for da9052_reg_write
Date: Mon, 11 Jun 2018 13:23:39 +0800
Message-Id: <1528694619-31889-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When da9052_reg_write fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling da9052_reg_write.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/input/touchscreen/da9052_tsi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index b5dfd594..60c82a0 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -319,8 +319,11 @@ static int da9052_ts_probe(struct platform_device *pdev)
 static int  da9052_ts_remove(struct platform_device *pdev)
 {
 	struct da9052_tsi *tsi = platform_get_drvdata(pdev);
+	int error;
 
-	da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
+	error = da9052_reg_write(tsi->da9052, DA9052_LDO9_REG, 0x19);
+	if (error < 0)
+		return error;
 
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_TSIREADY, tsi);
 	da9052_free_irq(tsi->da9052, DA9052_IRQ_PENDOWN, tsi);
-- 
2.7.4
