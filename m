Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FFFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F9D21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 10:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="X51BDEbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbfBSKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 05:17:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36324 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbfBSKRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 05:17:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so9929979pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 02:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qBAytqDvKDadHVjYVKQCnCJze4dzvzWHsSozDnE632s=;
        b=X51BDEbMgUnJHjUCSEf92WD8DgJl62qb1uGyuOyMtmggIHFSocT+LDz1g4u5FFSvs9
         g8gn6NeXHUPwqeq6Cjl9lYuxrDolHa+e2la/lwLJOGbLb/6tGWTwANXUzMvSr6LddHeN
         IZns7Wv5FN9nQFy9f+092yn8vTnxhkDY0x9Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qBAytqDvKDadHVjYVKQCnCJze4dzvzWHsSozDnE632s=;
        b=WmRq0PIU+/nT2V5iWDNPPBbM2+XBRtlpRLSujxDUowEBHiY75B76K074MWIDsfWB6J
         u6oRYhyCvwT6sFHFc/YHO5MoiUUAK4Xe83P229lUrlwFGjR0b6sEnBkuWW9nGY+9DzFd
         +26TSMvQ6gyc4ptPI+r/ktLPpAxA0TjmWrdz1ftO6Gci09fUEwB9nwiG1IsLGZIkfypM
         p48juGFos8M3awmb/bFp8MU3Z8xVjGuizErbP3KuHZrxdCOp1ayMUqOzKr+GLpdJgpvA
         sOGNWi15RCDwbjxEjre3Wye1YyMFE+nkEjduOEDFarV5UmMkxei9DtCRtyfSQojUbcBx
         x6bA==
X-Gm-Message-State: AHQUAub/aBIXy6D+SABrpTqmv9YrFsgYOLW1StZtMEoO++hh7WPLb0Dk
        EUm2VHsTL8vpRLqiD4SZPslOEA==
X-Google-Smtp-Source: AHgI3IZt86G3crysCdL9JyMArvzdU1t7lU/H9wizxjAOK4q/ZSvtxoq7f7MAsHRcsPi2fPjqhH3uug==
X-Received: by 2002:a63:ae0e:: with SMTP id q14mr27484370pgf.151.1550571419987;
        Tue, 19 Feb 2019 02:16:59 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id g10sm21324011pgo.64.2019.02.19.02.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:16:59 -0800 (PST)
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
Subject: [PATCH v6 4/4] Input: goodix - Add GT5663 CTP support
Date:   Tue, 19 Feb 2019 15:46:29 +0530
Message-Id: <20190219101629.15977-5-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190219101629.15977-1-jagan@amarulasolutions.com>
References: <20190219101629.15977-1-jagan@amarulasolutions.com>
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
index 5f9e755c5bc7..405246d61701 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -219,6 +219,7 @@ static const struct goodix_chip_data *goodix_get_chip_data(u16 id)
 {
 	switch (id) {
 	case 1151:
+	case 5663:
 		return &gt1x_chip_data;
 
 	case 911:
@@ -1000,6 +1001,7 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt1151" },
+	{ .compatible = "goodix,gt5663" },
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
-- 
2.18.0.321.gffc6fa0e3

