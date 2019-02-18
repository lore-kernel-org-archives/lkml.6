Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FFBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A00021773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdrSuPgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbfBRTMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:12:14 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41750 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728698AbfBRTMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:12:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id d25so684403pfn.8;
        Mon, 18 Feb 2019 11:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xcRi1m5iq1Fe3LlNmrWWvdAmf1L0ArE4URvvcffj3lU=;
        b=fdrSuPgKpcsZpBQ9e6La3PC5NFwACmfMOimuYzVHCLi1xbBQ8DvPiGK5Kbx3oVlia3
         zP/NTLCbGVYxT2riS03497E0rp9BDBrz//YQk+6iQCQ8UQgNYPHi2/9mDxgvopyuvPPm
         PqCB+41HrFVMR84ydlqmQIZJznY3B+QGkCxnLKd5ZIjsHzCf4gdbn7p8Q3v8Rv/19g69
         ix2TpYNKpJIZT8kU6+Qmf/MOqLMGOdA95sHUI0FGGwqb/YrTFLIwErwJU20xctMQlkvn
         jhL7c3YxrjjSg/BanmEWtJ+ULEe2F7JD0TqkVy8DfJbfYuAjOIFl8ppZw2G652gJfEif
         Hx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xcRi1m5iq1Fe3LlNmrWWvdAmf1L0ArE4URvvcffj3lU=;
        b=re5nI3XpvoeDXE4ouyGcFfIz1P65GWI2I/IqiNcvdQmfrShnTQ0FVH25hUM5xTgZKE
         86MLTfTDbf9dE79np21FIGKjfWZNHqlDBqxn38gdGkUeO1hScy/yJzZ7F079+Qr+vspB
         /H5gOiA3V79yKZEBRW1Yr53c1edVZlgm1Yi6HFKhKG+FDqylz963fSUUz26gIA9/2N4c
         9GG5Ye0sZE/Okra1OSqRBPXvxIWyAfcPDoVouudYDacL+knMrs5S8GmWPIh1v51eQYb9
         o48drJYRwQbvwKnVqzaUurngxz53dHze66lC/UUPDcNPavIk6d5bktvdDQ7ILqXKgn8w
         hqwA==
X-Gm-Message-State: AHQUAuazygn+de+LATNHhQjC+T6wcSxl7N0fQgAi06D8s9w9J1bJnayV
        AuSl93r2p7miSWpmVDqVfUYLli5V
X-Google-Smtp-Source: AHgI3IbiNcqNk+PU15N/8pfIA4g8Y5ouQcSSowIkMJqKXV0uN1C4Hp/phmKNWhdzONx67k1nSuowSA==
X-Received: by 2002:a63:ce18:: with SMTP id y24mr20375395pgf.321.1550517131090;
        Mon, 18 Feb 2019 11:12:11 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t12sm33189727pgq.68.2019.02.18.11.12.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:12:10 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] thermal: qoriq: Do not report invalid temperature reading
Date:   Mon, 18 Feb 2019 11:11:38 -0800
Message-Id: <20190218191141.3729-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before returning measured temperature data to upper layer we need to
make sure that the reading was marked as "valid" to avoid reporting
bogus data.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 6478d7a8168f..3d520d3b2da4 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -37,6 +37,7 @@
 #define REGS_TRITSR(n)	(0x100 + 16 * (n)) /* Immediate Temperature
 					    * Site Register
 					    */
+#define TRITSR_V	BIT(31)
 #define REGS_TTRnCR(n)	(0xf10 + 4 * (n)) /* Temperature Range n
 					   * Control Register
 					   */
@@ -55,8 +56,10 @@ static int tmu_get_temp(void *p, int *temp)
 	struct qoriq_tmu_data *data = p;
 
 	regmap_read(data->regmap, REGS_TRITSR(data->sensor_id), &val);
-	*temp = (val & 0xff) * 1000;
+	if (!(val & TRITSR_V))
+		return -ENODATA;
 
+	*temp = (val & 0xff) * 1000;
 	return 0;
 }
 
-- 
2.20.1

