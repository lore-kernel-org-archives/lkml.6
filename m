Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF04C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C7C421871
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBLJFBXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeLRV3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:29:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35214 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRV3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id c126so4281510wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ilQ0qqZNQydQTJlGafIg3unftBFJ87HWUKycWJC64gY=;
        b=kBLJFBXyQU5bWk4V+BjSeU8IefqrlHUiDLqB9fl8eOgGnEahZO7lxt36z444jjE4Rm
         Yh7VLWa+yv4HGZJrd5tZsGRnmin7hTkLNwis8Ru+amXwF3f7MSaNg0B1EKd+QsuHB2sx
         FkbYZ1eyhGEwb7tyezhHvDRZUwH6tKm3A2/Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ilQ0qqZNQydQTJlGafIg3unftBFJ87HWUKycWJC64gY=;
        b=N7xVxguWgZ1wJwMMH8ZfMteTxdCEAnTfXUQ3Ym/jITcXF4aX1RGz2uUPewoiMhPS6w
         4k7dArhv1Qy4p6DNfmShXG1QgpzeCWbj3o3R1+uhL1/etz0lmT16syBNVREtxZj+ZzBA
         acfc/C5v3WSQyuoWd6aWI4nZc7BfdhgrCsRU4QenzdQMGXZ5YI98g7yvZGvx623yGZim
         u5XdAvwbvrpdtZl+ELs2qSulepZNMX4LaDYsWcrP4lGn24UHedv08i3keI8cA8H3AEFX
         tj1HjJj69TT2JRkVdun3wso264Q7aQQ7uE531MJPdBMnZ47njI28A0/uUZHb8Mc4NuYv
         Qsqw==
X-Gm-Message-State: AA+aEWZsKZJ1Qk7FSGDAcfPRtBJDE7NrmlBktKzgpQSA0WhLAm+db02g
        Vb9gkvpbJKAlD7L/HoyDgOfr/Q==
X-Google-Smtp-Source: AFSGD/WNmmVnTdmTIv0ywBPCnkhuJv7po4peI6vkBXGMUaUCxURw95jcE2ojoY769Gavaj9AYcrz1w==
X-Received: by 2002:a1c:4108:: with SMTP id o8mr4525681wma.91.1545168550254;
        Tue, 18 Dec 2018 13:29:10 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:09 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/VT8500 ARM
        ARCHITECTURE)
Subject: [PATCH 01/25] clocksource/drivers/timer-vt8500: Remove duplicate function name
Date:   Tue, 18 Dec 2018 22:28:19 +0100
Message-Id: <20181218212844.30445-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

We print the function name twice in a row in the error message so I've
removed one.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-vt8500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-vt8500.c b/drivers/clocksource/timer-vt8500.c
index e0f7489cfc8e..c3aff1a8f7d5 100644
--- a/drivers/clocksource/timer-vt8500.c
+++ b/drivers/clocksource/timer-vt8500.c
@@ -145,7 +145,7 @@ static int __init vt8500_timer_init(struct device_node *np)
 
 	ret = clocksource_register_hz(&clocksource, VT8500_TIMER_HZ);
 	if (ret) {
-		pr_err("%s: vt8500_timer_init: clocksource_register failed for %s\n",
+		pr_err("%s: clocksource_register failed for %s\n",
 		       __func__, clocksource.name);
 		return ret;
 	}
-- 
2.17.1

