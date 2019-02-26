Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14274217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="w09Km95r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfBZMJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:09:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51619 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727616AbfBZMHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:07:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so2140572wmi.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 04:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CeUg0tzZvzF6i3vRIOyMy0PwSMiSVM4hJM4cSQ/yY34=;
        b=w09Km95rIIuBHcmQIqgGOzaNfxWLXY3eRUPutALA3ZtbMlEqSPL7bJxajrVqkBC+tr
         GwvB4vuFrJyL/thjd377MtomBwlI8HKEfr/8J/mQsx2ZQvqwcIkePtjGJCHb7HrJTGl0
         f8b9KLG5YnkznrNDXBB3hwE3MRw+xE6JeW2wPa3Qi2zZV6Ek4yV1z0trFOrTqyYkq/XR
         aqjJ5MxPDbkaSTExBatNjP/1m26Y23ZCPJPL1nbXL7qpQL/nBJwO2/ecYRjXljvd6PbX
         vihAm7dxf4zjaNKOlFbX1e18/hcSvD/UTo7fmrVA17PKAuh9f9N+a4+6bPRKUTIvhRvP
         b9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CeUg0tzZvzF6i3vRIOyMy0PwSMiSVM4hJM4cSQ/yY34=;
        b=XU4ltvpthUqKuQtI9CpoQ3Bs/krHZEYHPK8Oj4E2JR0ag/c/LOB6YNWYKdiC2Hijhj
         R1AXkoa2Oer5dQ2gFwmgWEQtrPMM6ylMA45nmDelrzPiBuvXyFcfrrrDgsBjKy1ZJ1ME
         DaN02zTPeLh76Z/BpzXFhbsRqjhXTI9funcNsClZAOLkq9xa7cYolo3bJpOY00mVedDX
         NxCn8vkw9yMjQRM31s590HEg1MO8Kz765PUfy9QMmUEbnNHrfEhlpkJb6NXvlI7Hae8P
         Ewe53URpziWfzwwVCGLtudJDVGWnTM/fFD8YlJHItwMQwWzSzcXOUmK9kp6rkttzkJ9+
         +yIA==
X-Gm-Message-State: AHQUAuarP298DybIK8/f0G+6Oxw+lBnb1zi4JdLkSNoFD6CJrfO08fb+
        bQnQ2Kr4rZcnr182Lqh/1WWpSA==
X-Google-Smtp-Source: AHgI3Ibnwo6rPlFREbjDwz0cEHeEKLi+LVTeWIhki2cnxRgP6ToMS3x5yVUXJ15aNN6g3VF1okK6Rw==
X-Received: by 2002:a1c:b783:: with SMTP id h125mr2315471wmf.119.1551182853533;
        Tue, 26 Feb 2019 04:07:33 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id a8sm12642158wmh.26.2019.02.26.04.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Feb 2019 04:07:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 03/11] ARM: davinci: WARN_ON() if clk_get() fails
Date:   Tue, 26 Feb 2019 13:06:25 +0100
Message-Id: <20190226120633.18200-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190226120633.18200-1-brgl@bgdev.pl>
References: <20190226120633.18200-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails. Apply this to all davinci platforms.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/da830.c  | 4 ++++
 arch/arm/mach-davinci/da850.c  | 4 ++++
 arch/arm/mach-davinci/dm355.c  | 4 ++++
 arch/arm/mach-davinci/dm365.c  | 4 ++++
 arch/arm/mach-davinci/dm644x.c | 4 ++++
 arch/arm/mach-davinci/dm646x.c | 4 ++++
 6 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 63511f638ce4..d242ce06f7e5 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -750,6 +750,10 @@ void __init da830_init_time(void)
 	da830_pll_init(NULL, pll, NULL);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 67ab71ba3ad3..72d64d39d42a 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -680,6 +680,10 @@ void __init da850_init_time(void)
 	da850_pll0_init(NULL, pll0, cfgchip);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 4a482445b9a2..57c5a660758e 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -742,6 +742,10 @@ void __init dm355_init_time(void)
 	dm355_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 8e0a77315add..1d82bb630d11 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -783,6 +783,10 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index cecc7ceb8d34..2b0e921aa755 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -678,6 +678,10 @@ void __init dm644x_init_time(void)
 	dm644x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index f33392f77a03..7e5af984ed9f 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -662,6 +662,10 @@ void __init dm646x_init_time(unsigned long ref_clk_rate,
 	dm646x_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	if (WARN_ON(IS_ERR(clk))) {
+		pr_err("Unable to get the timer clock\n");
+		return;
+	}
 
 	davinci_timer_init(clk);
 }
-- 
2.20.1

