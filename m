Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79D97C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44518217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 19:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV03iVYN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfBZTgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 14:36:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45308 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfBZTge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 14:36:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so6657781pgc.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 11:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZD8IznxWy7CqeE4Azr2UQLZvJTlUTz8IeNFsGWvGXF8=;
        b=LV03iVYNnCMB0G8raqGDzG20KEeQp3RHnwMz2e39Efl7rwsHJC3PGJxRVdtdUuTaRL
         ATxr/pcl9WPt4QL0WuqecylqPAjq5Uuk6NK0qk7heD7D3I0TskQokT8eWyG+Mt+4N2vr
         MagL11g9Fx1t1X1jh2z1svXL7ulX3+7uMyNAgCrSH2AtBRbG49xnvO8YRNw9gUhwYz4a
         E5XE7oDlwAgUPd78/3HAbFiJirTh5YpygzhE9akTutFBfe7dc5purIYEd3w7g6fM1SVk
         ukI7+kH43p499Q3gwCqFolrCfaAc2Zw8dTrJBzhfLG/XDtymHmCwWYLFZ0pLqzK5NyJu
         kGrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZD8IznxWy7CqeE4Azr2UQLZvJTlUTz8IeNFsGWvGXF8=;
        b=jqIRdlnI/CkLT5j28q7vU23kZZc3tA0cH6oW5sSQT+xMmedJrggPlPXMIjFydJO+fq
         ogg2Zcknv1vzPLH2AOYtA459DbqF7FBwH0Aj0K00WWAD+cdHaVgtp1n1cMRodr6suOBE
         nwHJ6eGaLsvMMMKzd4qw2w1qs1ipqJLSxQSBxTexAqT1GMRlIKdLL3xTdSVja+3yzufN
         ljqi+Qv7yiytSwVegNfQYgnmB7/Ezns6y7233ZPc21NFjcqODtjvcyGawsv0ivHN2BGD
         y0yhhPB3+qQeIQUoqaMDSXQKB+4HjO5m/a7zGF/uXNgV+5ZhV6D2Nz4kSYfOOWzd9lOl
         /pYg==
X-Gm-Message-State: AHQUAuZVxTnobLYC5YQkCKsEYHtIglChTpJFfGjGtY4hNLAadzxn9Da4
        RnSMl3vecOOcCmKJgV2TRwU=
X-Google-Smtp-Source: AHgI3IbXRwVqDQxRzoxQGu32bhQ3aNhR3RbMzJH7j0vuVh6N/rMuNaUuRED/IT6Ld/RAlD50PH+xFA==
X-Received: by 2002:a63:295:: with SMTP id 143mr25173772pgc.362.1551209793568;
        Tue, 26 Feb 2019 11:36:33 -0800 (PST)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id l79sm28951220pfb.102.2019.02.26.11.36.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 11:36:32 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/9] drm/bridge: tc358767: Simplify polling in tc_link_training()
Date:   Tue, 26 Feb 2019 11:36:05 -0800
Message-Id: <20190226193609.9862-6-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226193609.9862-1-andrew.smirnov@gmail.com>
References: <20190226193609.9862-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit polling in tc_link_training() with equivalent call to
regmap_read_poll_timeout() for simplicity. No functional change
intended (not including slightly altered debug output).

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Archit Taneja <architt@codeaurora.org>
Cc: Andrzej Hajda <a.hajda@samsung.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/bridge/tc358767.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 6455e6484722..ea30cec4a0c3 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -735,7 +735,6 @@ static int tc_link_training(struct tc_data *tc, int pattern)
 	const char * const *errors;
 	u32 srcctrl = tc_srcctrl(tc) | DP0_SRCCTRL_SCRMBLDIS |
 		      DP0_SRCCTRL_AUTOCORRECT;
-	int timeout;
 	int retry;
 	u32 value;
 	int ret;
@@ -765,20 +764,17 @@ static int tc_link_training(struct tc_data *tc, int pattern)
 		tc_write(DP0CTL, DP_EN);
 
 		/* wait */
-		timeout = 1000;
-		do {
-			tc_read(DP0_LTSTAT, &value);
-			udelay(1);
-		} while ((!(value & LT_LOOPDONE)) && (--timeout));
-		if (timeout == 0) {
+		ret = regmap_read_poll_timeout(tc->regmap, DP0_LTSTAT, value,
+					       value & LT_LOOPDONE, 1, 1000);
+		if (ret) {
 			dev_err(tc->dev, "Link training timeout!\n");
 		} else {
 			int pattern = (value >> 11) & 0x3;
 			int error = (value >> 8) & 0x7;
 
 			dev_dbg(tc->dev,
-				"Link training phase %d done after %d uS: %s\n",
-				pattern, 1000 - timeout, errors[error]);
+				"Link training phase %d done: %s\n",
+				pattern, errors[error]);
 			if (pattern == DP_TRAINING_PATTERN_1 && error == 0)
 				break;
 			if (pattern == DP_TRAINING_PATTERN_2) {
-- 
2.20.1

