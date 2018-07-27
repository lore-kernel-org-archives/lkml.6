Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2755C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8881C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5YrrTxF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8881C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389101AbeG1Awo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 20:52:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52104 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbeG1Awn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 20:52:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so6865968wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gl+aK2ly2QIfuIXisWYcSBHmTSF7rnKWcUrQWJgtaW8=;
        b=J5YrrTxFw+ZjzbDG8PeJSCkCcQCctoO+HaYEU2Xc43+qFHadqjXATyMC8pe2IKqd+3
         ENQl9QAOVvK7VDwgBkfYLNsOGft5r/IC+soYTuhTSmiuGl6ZGJp700I+tzHF9N+2Yw6A
         /gtOTAkCca4rb68HZpOvlPwmXXIlqYxBYeSOjY0+O1LWgDWo/fy6OqRTkoFcItkzkf8s
         5fa02DsCivpHZghkrnjrSAjCtq+8vHrDvl3sT8yTuEq50hkeujvuH7QaGZPayZedK5vj
         n++CGgrlOnK9P9bDgjHEPhJCrWh5wGk9ah0ubcgiju3tSLFFx8jrx9mNPTtYR522El4m
         Xfpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gl+aK2ly2QIfuIXisWYcSBHmTSF7rnKWcUrQWJgtaW8=;
        b=fSsRt0sBcUihDnwDxfUVYtGuCtO6JWGP7H3xGyQJAU623XnOsISPTs7/V1/rIHNg+7
         5z/wZInG1pXfWrCzvbTrqJXBo21naKFHad3/u2UkVKYwa8hRXZyG3c+mKp/YDrBH/jzo
         n2pA3ckEOmapRHl5R1I1ZBQdKP/mxPE31csP6V2n8qVY/7kqfoQy42bdF/7QI9wYthfe
         XT5OrbzdzgXQNf+BdNDuXxItiZrGvK4PRdIFfr1Sx5r1i+HBKwueTCUWXz36Z1R1gg4n
         lKhh9Q5opZx5T+mLzLihSzSl3FWUzakfU+/RGDBhd8yhKgCJy6kDZBLQh8kI0kJeCpA7
         ke+w==
X-Gm-Message-State: AOUpUlEIGlnqVj0wpg3blfhJvb5mtRmHfS1aDxyLy2GVZJX1TYj8HfbK
        zqed6wBBI/7RRnili2O1Q4G2XAo6ySE=
X-Google-Smtp-Source: AAOMgpegDKDcVsCqCQYYXZk2H1dOMqgdj+LkL9bxvk7yhdSr9zGrUxEDtnFTtIiQfiNzsn7oUWrB4Q==
X-Received: by 2002:a1c:f46:: with SMTP id 67-v6mr5625866wmp.122.1532734115097;
        Fri, 27 Jul 2018 16:28:35 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m13-v6sm7313217wru.93.2018.07.27.16.28.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 16:28:34 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/10] staging:rtl8192u: Remove unused DM_check_fsync_time_interval - Style
Date:   Sat, 28 Jul 2018 00:28:17 +0100
Message-Id: <20180727232826.28014-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727232826.28014-1-johnfwhitmore@gmail.com>
References: <20180727232826.28014-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused definition for DM_check_fsync_time_interval.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_dm.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_dm.h b/drivers/staging/rtl8192u/r8192U_dm.h
index 8f3d618dcfdb..e86dda99c223 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.h
+++ b/drivers/staging/rtl8192u/r8192U_dm.h
@@ -32,9 +32,6 @@
 #define		BW_AUTO_SWITCH_HIGH_LOW			25
 #define		BW_AUTO_SWITCH_LOW_HIGH			30
 
-#define		DM_check_fsync_time_interval				500
-
-
 #define		DM_DIG_BACKOFF				12
 #define		DM_DIG_MAX					0x36
 #define		DM_DIG_MIN					0x1c
-- 
2.18.0

