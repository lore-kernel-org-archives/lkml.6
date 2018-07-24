Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872C5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E28F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fETF1unX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E28F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388410AbeGXIRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:17:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbeGXIRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:17:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so2965551wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 00:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oLGamEtSDPMo5QXPl/PAJUvNOCABGEBrWaLjnEXWrOY=;
        b=fETF1unXgJfLeIjJh5EtZTwbWZFBaouvGP3O/7B/reEEmT2L3me6VjtDwkS3QmjnCx
         dUxa5PmFySpYVstOOvHV+gVH9aOGe52WIm6rmJsCWq//BYgvJeB9A5UOIGDOPC0fk59G
         LmLYBQ/9/Nd4RhcDUrB23Jlxqcz6hZ9Sly/Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oLGamEtSDPMo5QXPl/PAJUvNOCABGEBrWaLjnEXWrOY=;
        b=UbjLPyyeom301ovKR2+ACJdfogGJm/LQaLxbaTWaHePkspD6PfOWlZtKwW6DdqHY/6
         Jzb3t2vOJokc2MhXuBOI17yhQLArh/kzhxsinpjWYaHOmL1nBEpqylyjvLG3bIVHeIl9
         B7eZmks572zWWdC4HEuopBHGPwp1nXUvkkLYeBBTCJxwGhcgLeNjY0E04DtNk8/DxKGy
         TVN0ENvLA9tbwae8vGMxL7dg9ZWIk85Fm/TV36Cz0Bp+hom1TW0BC4wcXFN1XM6l7m53
         EUc18IHXt+ZlrKVmA9Qwq52mx6h1yXB5PXd4CMKJeeP+DclUiYdwBIOYEuyqBV+pSu11
         O1Aw==
X-Gm-Message-State: AOUpUlFLIH9chuqenU5902geoi+YjerQGY0O4aDUPb8F55BJbs/Ea8Km
        ZyAjb4lVESmnTcuRaWziFyef9w==
X-Google-Smtp-Source: AAOMgpcwcvQd2azYXOJqMoTQDJ53zjerDbsXx5oTceRpxQ57GvQpgUcvuzwvsMUPoCjgQ1tU1IuLng==
X-Received: by 2002:adf:e0cc:: with SMTP id e12-v6mr10485334wri.199.1532416362841;
        Tue, 24 Jul 2018 00:12:42 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o4-v6sm736960wmo.20.2018.07.24.00.12.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:12:41 -0700 (PDT)
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
Subject: [PATCH v3] backlight: pwm_bl: Fix uninitialized variable
Date:   Tue, 24 Jul 2018 08:12:23 +0100
Message-Id: <20180724071223.18901-1-daniel.thompson@linaro.org>
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

Fixes: 573fe6d1c25c ("backlight: pwm_bl: Linear interpolation between
brightness-levels")
Reported-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

Notes:
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

