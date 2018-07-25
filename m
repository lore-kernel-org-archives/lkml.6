Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BF3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A998E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 07:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQxr2vkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A998E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbeGYItF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 04:49:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52290 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeGYItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 04:49:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id o11-v6so4938230wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 00:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSt1pwQsxGzBw3uquJPq4af2a8gX01/8NUMRtpKzH84=;
        b=XQxr2vkbGxb5Npumn7LinVcpj0de4epDl3HQyGlzcyj+oyE07jW3UHqUXqtTbdwK1T
         cVrBuhgCAPb8ThnG4OGRSMkzBz7qTCbwmjk07dvdCRDl1r+daD8Kaxz/gABqrW5bQJXu
         7dAQCRXeFlNY9qhpngSrJAnEo+CFOItyzMbiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cSt1pwQsxGzBw3uquJPq4af2a8gX01/8NUMRtpKzH84=;
        b=ivRbbiw/fa7GBaj0zmTjIB1zoM8To1JdsirZG0lnujvgg/Wr5WVa9C39MddkiB2jlv
         7heCWzo+S2pz5zHzhKLvVDCvLdXDFPjPwnArDigu5aXpdk8e6nuOluX1jPAznk52iXIE
         bUpSqZeJBsjJW9nJDtboy7J0DmMuqqXuGHJuq0OHJntLF8NNOD6Jt7cgSRSm3zCy2j7N
         hKMHXbgIDDUgQD0wzDYj5Ci5TR7+COk+jTsVu+EnfNMj7I/JGTbkHCCibJq8IQ6bPIPH
         dF82O6pSxiCo+j4KpUNkEgIdjtVzkNPa9dQCcxfagdCNwipqcox1v2Uwn/fWzpb+uAc6
         5kfA==
X-Gm-Message-State: AOUpUlFdyOIS362COEQJqj0iXdtVui8g3bfeuDv9lWqgNSmP1+Ze068v
        5S9YScu70i5Vz3RshPurC15ATQ==
X-Google-Smtp-Source: AAOMgpdJmDFN1yo6ugml6NGoyoPnSjZ0Zge8XeT8R33erBCUa3bzorJIIIJfXN5a2aFc5ttwCbGhTw==
X-Received: by 2002:a1c:8406:: with SMTP id g6-v6mr3666024wmd.18.1532504318356;
        Wed, 25 Jul 2018 00:38:38 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h7-v6sm10243795wrs.8.2018.07.25.00.38.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 00:38:37 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v4] backlight: pwm_bl: Fix uninitialized variable
Date:   Wed, 25 Jul 2018 08:38:30 +0100
Message-Id: <20180725073830.31421-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716210241.9457-1-daniel.thompson@linaro.org>
References: <20180716210241.9457-1-daniel.thompson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the DT does not define num-interpolated-steps then
num_steps is undefined and the interpolation code will deploy randomly.
Fix with a simple initialize to zero.

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---

Notes:
    v4:
     - Remove line break from Fixes: and update the *-by:s
    
    v3:
     - Switch to the simplest fix and zero the uninitialized variable. git
       grep indicates that ~25% of calls to of_property_read_u32() use this
       pattern (pre-initialize optional properties with sane values and
       ignore the return code).
    
    v2:
     - Simplify SoB chain (with Marcel's permission)
     - Separate complex if statement and make other similar calls use same
       return code checking approach
     - Tidy up comment formatting and fix pre-existing grammar error

 drivers/video/backlight/pwm_bl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 9ee4c1b735b2..bdfcc0a71db1 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -250,7 +250,7 @@ static int pwm_backlight_parse_dt(struct device *dev,
 	struct device_node *node = dev->of_node;
 	unsigned int num_levels = 0;
 	unsigned int levels_count;
-	unsigned int num_steps;
+	unsigned int num_steps = 0;
 	struct property *prop;
 	unsigned int *table;
 	int length;
--
2.17.1

