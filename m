Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD509C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC31218FF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 09:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="a6na9x5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfBQJPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 04:15:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35153 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbfBQJPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 04:15:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so6977636pgs.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 01:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U3aS7aZspUVXaJLVPXE9mGfHChnxYiwxohb9NgNnEus=;
        b=a6na9x5Eae2qvd8qxgS0CyWjZSh+CjeLFzUqYm0WK6WiXehrDVPI1IregatkYGdmfl
         uvgZWD0tBsMxkIfoY5TFTvUm9IRJmcjXVaD7XTJ2H+ZYbtJUiaJFXbYb/uElsBXSLUVR
         48fO6PghodQOi0FrA+OUuCUx9Tl96kBzSbGcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U3aS7aZspUVXaJLVPXE9mGfHChnxYiwxohb9NgNnEus=;
        b=ub+QYx8VExMxfS0VWlb+eUJpOqi+pOm2lkagZg6O+m7Xqa82oZb8hlt5lW2ZNkrZIq
         LuFks4aFoYon6km9tJ+Xs5kQfZwSSXW7HPNMGr7u21YwIjJDBjQMoz/b6tE7oOTBGUZU
         rNiSkyjVu6Q3Bu+ID+fvdJhny+VLSx5uoTspmAgEgtx+BEv9ZLOI7+9peXjqFZjqTJev
         IogpfucgQBozmgzqlTEtMWPlGQwOgowlnOgDRzBozDuNIz2AFv7ppt3a3rNPh8vwfwub
         ZJROjuUIWl2rXnvy9wYT0rslP/WhbYAHBapWdz7299pRqkK9cIdkzI5W4iLOoiFgaC9C
         UHyg==
X-Gm-Message-State: AHQUAuZbDIjDSsnKQ8X+03o8Zdzh/Ovv+C80+T8fI6n3ZCvKMoHHCjuX
        efkw/lYLFOCTs0ScwXe445TRPA==
X-Google-Smtp-Source: AHgI3IbqdKjGGkOemK316sGeG0SCm1rNMVUr212TOQpRk1zCKWZzZApJT0UihVTHeXZYJ10bpJ7llQ==
X-Received: by 2002:a63:df50:: with SMTP id h16mr13718193pgj.421.1550394902364;
        Sun, 17 Feb 2019 01:15:02 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id v15sm5565924pfa.75.2019.02.17.01.14.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 01:15:01 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v5 4/4] Input: goodix - Add GT5663 CTP support
Date:   Sun, 17 Feb 2019 14:44:36 +0530
Message-Id: <20190217091436.3702-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190217091436.3702-1-jagan@amarulasolutions.com>
References: <20190217091436.3702-1-jagan@amarulasolutions.com>
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
index 294456a53fe0..80f8b920ef5e 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -227,6 +227,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -988,6 +989,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

