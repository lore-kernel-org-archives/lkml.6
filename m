Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C815BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3622084D
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="fVC6bKaw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbeLOPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 10:18:47 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:35440 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbeLOPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 10:18:46 -0500
Received: by mail-yw1-f67.google.com with SMTP id h32so3545096ywk.2
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 07:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u6EgDcE8CqeNPfSXbwSTx5LLeFBg8mTxzA16z58qpO4=;
        b=fVC6bKaw6eqbYhWUKZX23R39GST/ZuU1lG12A703cH45erfwRMm0OjP+T+HAkUsGQ3
         lOpiLk1qedrJHUuG5AfLQl0/UXhlMyAtKzBGvg/Hy3D6Hu/v4diYnx9e4QQtHWTmFuXl
         7G+QoLwCkykn81om7orz2ysgyh8AMKu6qjcso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u6EgDcE8CqeNPfSXbwSTx5LLeFBg8mTxzA16z58qpO4=;
        b=i/7ZARlrc7CwQNpaULuPc2Fio0g/R9sjPeW04l7xD368PpYLK1hsj0TiZIVb3DY+xx
         1JON9rjYWj2TZk9M90lVQ6+W/iKc8tqz41/ifQZ8fAF2CuRutKoJJ5Cb2/FdeCdPMzJC
         Md/JXuVQX/3XiSQOysvl5oWQ+Wc9jWrgzVXp9xc8nq+YtI/QW+B2kIRNl5PagILZhuOL
         geDyx+1Wo6PQJsVXEcEUlJNQGUiwrUBYEkpJoKlYVB8apuqG27C14XHcppjwM0Hketoi
         8NjCNWfhHgCb1XQPCXxaH4aBSGR758kDIZc1aNwADZ7oL0Vy9h7VqkEUHu/rk3xfwYLe
         5Dpg==
X-Gm-Message-State: AA+aEWahSTlMcEfsbzg9guoEbC0Yv5WqfkIQy5wTyjADSu4W56jozJJd
        8HhqzTGJRgvBUzGBfQD7MqHiWA==
X-Google-Smtp-Source: AFSGD/Ulz76WX+AW4X53a/2eSH1TIJPOeiA5LM2XPzlX5Pp0a21wqE6EHbbXPpiLnwUgRGYcG3VF1Q==
X-Received: by 2002:a81:ad1a:: with SMTP id l26mr6951367ywh.324.1544887125255;
        Sat, 15 Dec 2018 07:18:45 -0800 (PST)
Received: from jagan-XPS-13-9350.homenet.telecomitalia.it (host211-95-static.0-79-b.business.telecomitalia.it. [79.0.95.211])
        by smtp.gmail.com with ESMTPSA id x203sm2855664ywd.41.2018.12.15.07.18.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 07:18:44 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v3 4/4] Input: goodix - Add GT5663 CTP support
Date:   Sat, 15 Dec 2018 20:48:02 +0530
Message-Id: <20181215151802.18592-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20181215151802.18592-1-jagan@amarulasolutions.com>
References: <20181215151802.18592-1-jagan@amarulasolutions.com>
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
index 7371f6946098..735ab8e246b6 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -218,6 +218,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -965,6 +966,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

