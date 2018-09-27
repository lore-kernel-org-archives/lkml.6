Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A9BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E980A216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyPbJ3Tw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E980A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbeI1Bro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:47:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46900 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbeI1Brn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:47:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so2636046pga.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 12:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=idS9CWU81VVg7Wphz/MpSwKUtfQ6rlPXr/UIS8hVWNw=;
        b=NyPbJ3Twf18IBYzjZI8Kd/LHWSRv1QcMlXt8kDJJWhUdcXpp8XK0WI4oAunAadQv06
         Hd4Wt8qOZJLcg/2Y0R6gG/q6l/en3v087KKMB10uY/DBcYSrSM0kXgW6jy74Y25Zil6c
         0UOpmaLsVnaot/UZu2TsafnFCWX5WSCa27HAYrlPuLdS2mI5hek/R0MuqbylvhfipSTE
         40kZm4mhscsJdG4GpgVzzoJtcetCHhmdUiqMmHnIofFWYrMBQ6gislhThNFTja3PXt99
         FngPdTOQZSqgwaFSxaDtwROT2KOsZLUah+9QtAQ4XRupi+aojhZsI5Kn/oWHuydnffui
         hmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=idS9CWU81VVg7Wphz/MpSwKUtfQ6rlPXr/UIS8hVWNw=;
        b=EwNxuAT8JX2LlPIMKTeDOhJO15uL7ZoT8JzCdeSNTJSoMxUi68ZKzyyHS0JyX1oGia
         e6PxGDso043HLLNjAs2fXToq7SjL32RyEIvvpyf9pPu2R1fMpW/cm0neQx2aSe/p1+gv
         PLtRhBs8yzi9NCYx6N8rpmlW4XaJULiWkatLWoHxXRJSwPyO+9Uy7aNvH8oV220Qd7vR
         ygkQrsKMl2nh9+NrvS/GJTEEWiwcqNcNaYwm3h1F8KaxYtvQpco+pGiXcd+ZORR+sZKp
         FRV5R+gcC0Wj3Zl2jkEloJch11n+rgwc7+UUgH0I3yV5y3mrRuUQ9wTY1W6iAtGpj3lB
         YjTQ==
X-Gm-Message-State: ABuFfoj3zeY3uWm5Ax11z0VGq8cuOz5TTVhhONdXpf5x7gV+9xpGsE+m
        nv4EPFmTenfnuoTDmEaL4LU=
X-Google-Smtp-Source: ACcGV60y5iSZ28H1BZ9safitCo7nBVyNkd4r06V9q2WyA2BZvSRMQuec+V432jX7UdJWuR7X4Poneg==
X-Received: by 2002:a63:a0d:: with SMTP id 13-v6mr11955274pgk.318.1538076473735;
        Thu, 27 Sep 2018 12:27:53 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id q2-v6sm8531502pfc.17.2018.09.27.12.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 12:27:52 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM BCM7XXX ARM
        ARCHITECTURE), Rob Herring <robh@kernel.org>,
        Doug Berger <opendmb@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] firmware/psci: Fix cpu_resume entry points with THUMB2_KERNEL
Date:   Thu, 27 Sep 2018 12:27:09 -0700
Message-Id: <20180927192711.26455-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927192711.26455-1-f.fainelli@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When THUMB2_KERNEL is enabled, we would be failing to resume from an
idle or system suspend call where the reentry point is set to
cpu_resume() because that function is in Thumb2. Utilize
cpu_resume_arm() for ARM 32-bit kernels which takes care of the mode
switching for us.

Fixes: 8b6f2499ac45 ("ARM: 8511/1: ARM64: kernel: PSCI: move PSCI idle management code to drivers/firmware")
Fixes: faf7ec4a92c0 ("drivers: firmware: psci: add system suspend support")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/firmware/psci.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index c80ec1d03274..f8b154384483 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -400,9 +400,14 @@ int psci_cpu_init_idle(unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	unsigned long reentry;
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    __pa_symbol(cpu_resume));
+#ifdef CONFIG_ARM
+	reentry = __pa_symbol(cpu_resume_arm);
+#else
+	reentry = __pa_symbol(cpu_resume);
+#endif
+	return psci_ops.cpu_suspend(state[index - 1], reentry);
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
@@ -437,8 +442,15 @@ CPUIDLE_METHOD_OF_DECLARE(psci, "psci", &psci_cpuidle_ops);
 
 static int psci_system_suspend(unsigned long unused)
 {
+	unsigned long reentry;
+
+#ifdef CONFIG_ARM
+	reentry = __pa_symbol(cpu_resume_arm);
+#else
+	reentry = __pa_symbol(cpu_resume);
+#endif
 	return invoke_psci_fn(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND),
-			      __pa_symbol(cpu_resume), 0, 0);
+			      reentry, 0, 0);
 }
 
 static int psci_system_suspend_enter(suspend_state_t state)
-- 
2.17.1

