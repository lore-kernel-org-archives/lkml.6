Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7DDC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9D320652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 20:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fieahl-im.20150623.gappssmtp.com header.i=@fieahl-im.20150623.gappssmtp.com header.b="bXpU9raR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9D320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fieahl.im
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbeIHAvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:51:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37342 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:51:35 -0400
Received: by mail-pl1-f194.google.com with SMTP id f1-v6so7052948plt.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 13:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fieahl-im.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=U+LCn+tGBn4g91J27ahpHZnhw99Dn7tqV0Pc4odJTh4=;
        b=bXpU9raRdbHUVoPJAeoRx9Dw1KRzlszzkRAFdaa9Tv3lSTzFU/8vMyWt6oATgvBDHE
         VwEpI9y8pywN9Mj28bDGAlAVYQZTNICebHrNH+eLzViTaawalIiEGBdqpQCexOJ+IOns
         cztqnzALnqiOcd3XoXIO2F7uPCMCj95UirkR29TZiYu+3qZrZOu6t1ANa63FFSlMJdyZ
         dSuUNmEpgFJmxyJl0ra3PhABRf8eUG9tI9F/9imYiP5+qlcciaP5eV5VsoW7bltzOCYi
         CBh116n/EFxBgfKr4H6Q0dN9l/3VmglRd5NFu/C8Tilt+v1vNEgBirlEnQfKzOElnTGY
         pcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U+LCn+tGBn4g91J27ahpHZnhw99Dn7tqV0Pc4odJTh4=;
        b=jewwa1aX+uyfP1qx81cpDaFOGV2F31gou4npqsFQp5elclB6P7ucETvub8zeiQjqVB
         T1juv6cq1qxgfKH4sgAHDIbn6+UMKp+afU6fAQk4Dsw/HyroRdnJyYJSD04FqOPaFJrw
         gaNHmaRpM0BcyPeGG8issXmRZu885oE6cS/E8JEjZTFHhCL7sa5+6wC3c4CF70W+d7Pa
         rFYqQA0Wtabm1lwJODAD5iRIbpBlEm8bDPQFtPJHXsMeBOoeKlzWwRmgR+j4lpeG4GOn
         lijbd0/hNF9Nzd89HDMSLZ3F9/L55zrYtY85M5Ewu91q/wPfLpXXx13qfn2x7faSTEgD
         u/Ag==
X-Gm-Message-State: APzg51ARgG79Lwpxu3GXaQxe7kJsc7NjCaSp8yvvtqqTKGp9H776+ZnC
        i+c0QtO1tMpl8xLEWPDVF0iEqQ==
X-Google-Smtp-Source: ANB0VdYmuQR668j5OXA1VYCelDCyulsuUEXFjyTGMR+cldQAnUBd5TNcc3I7+FUJvShsjlzVgR0TeQ==
X-Received: by 2002:a17:902:934c:: with SMTP id g12-v6mr9735265plp.67.1536350943635;
        Fri, 07 Sep 2018 13:09:03 -0700 (PDT)
Received: from WorkZone.localdomain ([175.138.183.133])
        by smtp.googlemail.com with ESMTPSA id o62-v6sm11266569pfb.0.2018.09.07.13.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 13:09:03 -0700 (PDT)
From:   Fieah Lim <kw@fieahl.im>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-pm@vger.kernel.org (open list:CPUIDLE DRIVERS)
Cc:     Fieah Lim <kw@fieahl.im>
Subject: [PATCH] cpuidle: Remove unnecessary wrapper cpuidle_get_last_residency()
Date:   Sat,  8 Sep 2018 04:08:38 +0800
Message-Id: <20180907200838.4966-1-kw@fieahl.im>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no magic inside, let's just make it more intuitive.

Signed-off-by: Fieah Lim <kw@fieahl.im>
---
 drivers/cpuidle/governors/ladder.c |  2 +-
 drivers/cpuidle/governors/menu.c   |  2 +-
 include/linux/cpuidle.h            | 10 ----------
 3 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/governors/ladder.c b/drivers/cpuidle/governors/ladder.c
index 704880a6612a..f0dddc66af26 100644
--- a/drivers/cpuidle/governors/ladder.c
+++ b/drivers/cpuidle/governors/ladder.c
@@ -80,7 +80,7 @@ static int ladder_select_state(struct cpuidle_driver *drv,
 
 	last_state = &ldev->states[last_idx];
 
-	last_residency = cpuidle_get_last_residency(dev) - drv->states[last_idx].exit_latency;
+	last_residency = dev->last_residency - drv->states[last_idx].exit_latency;
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index 1aef60d160eb..715520e339da 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -492,7 +492,7 @@ static void menu_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 		measured_us = 9 * MAX_INTERESTING / 10;
 	} else {
 		/* measured value */
-		measured_us = cpuidle_get_last_residency(dev);
+		measured_us = dev->last_residency;
 
 		/* Deduct exit latency */
 		if (measured_us > 2 * target->exit_latency)
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 4325d6fdde9b..d262f620890e 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -99,16 +99,6 @@ struct cpuidle_device {
 DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
 
-/**
- * cpuidle_get_last_residency - retrieves the last state's residency time
- * @dev: the target CPU
- */
-static inline int cpuidle_get_last_residency(struct cpuidle_device *dev)
-{
-	return dev->last_residency;
-}
-
-
 /****************************
  * CPUIDLE DRIVER INTERFACE *
  ****************************/
-- 
2.18.0

