Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57E2C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A45A7206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Zorl0OBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbfBLLZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:25:11 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38516 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729500AbfBLLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:25:05 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so1114742pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 03:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jN1AEYXn1oTS8hv3nCa5g6mHOWe4184ZoqP3aZRC2A=;
        b=Zorl0OBnsEZ3WXSdMUxKLQZqEZ3CXkhgtEuipWlqZsyQy96VWSN8+UGfnGGLw8kKQE
         0THRWJFKPZOiOHxCBZGAGDsypDOVGUBa/9pXUJRCOniPl7tigqK81aBNLDGfTcM1w92I
         8RVrwh5L95rtw8KYUO+qdBYzUjZp1EoRUfPUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jN1AEYXn1oTS8hv3nCa5g6mHOWe4184ZoqP3aZRC2A=;
        b=gw87lv7naPJ9f6yKa5ImCKRyyTfquxt211IUHi/o3BRZlQPs083WCXzEpUGFiPyNYv
         0pZKZABVasMGLfCWEkiPmqkAOs5s8ld8LB0rVo3ALMiVHGKV6KxbmmRcYk/t91qjJFj5
         57VxUrIAWHCP6heQvjqvwclYjDKk1hv6pt2/NRP9z9FRFhX9udhLrRQRG1ZzZ7L29ff3
         KM4+JYWIjO65Q1WxaCI7r57PqwAmPlqpTwuWb2sqSVMFbxCKmpTA/VGn2v/1D9v+/7xs
         k+TdCpCkc/hvcXnCF+RZp8qLInxfmw4/YZ9ON8PAdOo78zzuOFtFJFRie5HTHhrde2gC
         8Vjw==
X-Gm-Message-State: AHQUAuZBw8J40Fsx7quLSZnMlilMP2Ux+t9IJyPsZxGVh0u5/qiQ0kKP
        XOvAZAu9K241LOJDqsRWr83pAw==
X-Google-Smtp-Source: AHgI3IYpJkLOgwEvgrN30KB4Xz09IsHt+0WLdxDUbvSjjF3tCLxTgzilXaAw63FSVifHZ2b+hNZSIw==
X-Received: by 2002:a65:424c:: with SMTP id d12mr3224976pgq.126.1549970705026;
        Tue, 12 Feb 2019 03:25:05 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id q28sm22399460pgl.35.2019.02.12.03.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 03:25:04 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v4 4/4] Input: goodix - Add GT5663 CTP support
Date:   Tue, 12 Feb 2019 16:54:39 +0530
Message-Id: <20190212112439.2025-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190212112439.2025-1-jagan@amarulasolutions.com>
References: <20190212112439.2025-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GT5663 is capacitive touch controller with customized smart
wakeup gestures.

Add support for it by adding compatible and supported chip data.

The chip data on GT5663 is similar to GT1151, like
- config data register has 0x8050 address
- config data register max len is 240
- config data checksum has 16-bit

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 drivers/input/touchscreen/goodix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index e92b90be1ac2..9a676dec79c6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -218,6 +218,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -976,6 +977,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

