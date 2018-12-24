Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B452FC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0BD2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 18:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EI2K0HDJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbeLXShc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 13:37:32 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:34588 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXShc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 13:37:32 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 4F352D09
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 18:37:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MchFfOY7ucsf for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 12:37:30 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 2A123AF9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 12:37:30 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id y86so14709446ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 10:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YmLhqWFikrVyBjK/2tGEhyVwtDTbnJjZ767d5VTB8Pc=;
        b=EI2K0HDJWKeu29kHc1fKlsQUnwbiO9nx3LQqQRTrsuw4lFFPc0RXPGGF5damwxuHE+
         vxxo8aNXVCatGeWFg7aEv8Cg+WR//lP+4JqUt7O4T929O9CRY7xUzRz0bpXdDwHpPwle
         XHO8FlMY4+jZfPtlaFQQWyFKdDOdFwDZfsf0kF4je23Lyo4l+SA0pej/5fkuVncrgdKy
         XfAe0qgSNS0yLOYufaQ8fiD2dpq2IOtvoYVU1fHXHaUsNSFm0JkmCu0u5YXdhwaoatSk
         LU+oMRb0CSESAObHuZXLVpLtWBCTul8yMOiMvtHfjA9yiEsWbNRZpKieGdCVM0zUqAvk
         sQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YmLhqWFikrVyBjK/2tGEhyVwtDTbnJjZ767d5VTB8Pc=;
        b=iZZnk4dVHZs8YfCc5wKVGLlWyjYssI0mBCdanqMkPvTSCgucO03gD5Q0zEU/MdMc0U
         kksimSpIm7B3oYmpzst+964DJGfRCB5lUJ0oK3UVJvX99yUwviGWKeoYVa8EsmWAicdz
         O/+N99+wmEqaGMQKNK7o8T0VbWaC59bzQELU/zN/HTsYQCwEZmhaq+9GiYIuQ9zjMreZ
         vsOc6+khuFIdnvP3HuHxUNnMEXo6gEWQobZeT8wWk2Df7ANDYJv6DNBF/wfzTOIzK9QC
         XDmyaTTRTR08eZHN8ffr4K1CDHzSm/+mBj8XR/zrcA2PwmDmBcYC0TINcVOmtpLp0RaN
         HPZQ==
X-Gm-Message-State: AJcUukd6wYHpA/gNbSJTr3BfBbHBE7vrqmMzudNF2zs4O+vYdkNsQQGv
        iSxxhXj5+halodlxzEFu4do7+YHh950LQGAFCZbXDxRXMcb4E6ny3VpH9wzdcnR/77gGnkAH/W+
        VVv1qBwKdYFbc2fBtHkKjZJrkUyWh
X-Received: by 2002:a24:5e05:: with SMTP id h5mr9705633itb.103.1545676649716;
        Mon, 24 Dec 2018 10:37:29 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VQY7uweWKGvBEjcgBGvh90ugTFrvC/kTCQ4pwwj18IL+vnFi6n4g5cqccjnhaKHY2Txb++ww==
X-Received: by 2002:a24:5e05:: with SMTP id h5mr9705623itb.103.1545676649470;
        Mon, 24 Dec 2018 10:37:29 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id k2sm10689886itk.35.2018.12.24.10.37.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 10:37:28 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] input/touchscreen: Fix a missing check on regmap_bulk_read
Date:   Mon, 24 Dec 2018 12:37:19 -0600
Message-Id: <20181224183719.22211-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_bulk_read() can return a non zero value on failure. The fix
checks if the function call succeeded before calling mod_timer.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/input/touchscreen/ad7879.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index 6bad23ee47a1..735cb4c0d913 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -247,11 +247,12 @@ static void ad7879_timer(struct timer_list *t)
 static irqreturn_t ad7879_irq(int irq, void *handle)
 {
 	struct ad7879 *ts = handle;
+	int ret;
 
-	regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
-			 ts->conversion_data, AD7879_NR_SENSE);
+	ret = regmap_bulk_read(ts->regmap, AD7879_REG_XPLUS,
+				ts->conversion_data, AD7879_NR_SENSE);
 
-	if (!ad7879_report(ts))
+	if (!ret && !ad7879_report(ts))
 		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
-- 
2.17.1

