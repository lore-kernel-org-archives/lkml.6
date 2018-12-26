Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8441C43444
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B0218EA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 16:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n2yeI7h8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbeLZQpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 11:45:14 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42948 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbeLZQpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 11:45:13 -0500
Received: by mail-qk1-f194.google.com with SMTP id 68so9569928qke.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 08:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=InwYWFVcgsNeL+HQcZ5vgHtIv1cvzFUFvu3UrzzVaBw=;
        b=n2yeI7h8aHMbPfRTciWj/doMgM6b2hrPX6d2Nj/RJqxw4rXomNTuaPW2Erzqdxudqj
         HNe4J7qjWuhAu+sr6kO2Cn9ZtG7nf3kjP2aoJHXeK3lK8Ps5PHigegMsS8th/kDj44RG
         2mFff9fAxK5Lhg7TT1GJ+S/ZVllpWgq26/9WsY+UpSgrZQxiaowZwLsfbGehuZbieptq
         +RKEDVN2NxOqxiU239+RxtiFJNFjTvJ5TDIv3+q7DUFMpMkha/70/Hj3FnN3EjHRMLai
         KTeD5ntD/a2Gl56CwuVqAuhsRChHnrdJGl+4yHROJecu0iOZFh265NPi+4ktGHw06pxr
         3qOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=InwYWFVcgsNeL+HQcZ5vgHtIv1cvzFUFvu3UrzzVaBw=;
        b=IBewGzGlAjVS3C41hpWQXsqDGAOsPA1FrYvxtl1kDDlt3dzz17qUhzwGte5OAvkCPh
         IlJ0r2bIAx6XF5JEj8hMVyamRuBBJD1YqBpMRZTvaWh7F73s1clq13q3vDxpPlcvXRkF
         O7u0lboZcMtOopkjDkBnTVcr2f0LDeRu2EIiJ7xfQXNI+1uYTgmtd5pAS3TS4hPJ8DhR
         AsD0HpidBEze8FP45mQkKApw4OVjRJRuqkhw07XLMFebtlwogcWgGVeLq9l9xdjbsdlC
         xFNgVCqn/w7x9APgaiTcMW4FE0sr6JfPtooaS5gR4ZV/JCX6b/gmOuZj7DmdW9g6KUB/
         esXA==
X-Gm-Message-State: AJcUukdCgI3ODecDn1DHnUvGKuSrH/4eOhDPyrEJ4WgV08vAf3EnRqWO
        9jR9xZwP5xenAs9+WQxZ8A+Pxg==
X-Google-Smtp-Source: ALg8bN5hCYw0xiCyKIk/UBSJ8upSjDurDY60a3X/min2YuOsLsTeTR9K8nj0IoPeS3sKp4NPKWn6TQ==
X-Received: by 2002:ae9:ec02:: with SMTP id h2mr18855149qkg.84.1545842713028;
        Wed, 26 Dec 2018 08:45:13 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id m41sm17874920qtc.58.2018.12.26.08.45.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Dec 2018 08:45:12 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v3 1/3] arm_arch_timer: add macro for timer nbits
Date:   Wed, 26 Dec 2018 11:45:07 -0500
Message-Id: <20181226164509.22916-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181226164509.22916-1-pasha.tatashin@soleen.com>
References: <20181226164509.22916-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimum value of bits arm defines for timer value is 56bits, add a new
macro ARCH_TIMER_NBITS to use it in code instead of hardcoding 56.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 drivers/clocksource/arm_arch_timer.c | 8 ++++----
 include/clocksource/arm_arch_timer.h | 3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..e4843ad48bd3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -175,13 +175,13 @@ static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
 	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 };
 
 struct ate_acpi_oem_info {
@@ -963,8 +963,8 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS,
+			     arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 349e5957c949..c485512e1d01 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -71,6 +71,9 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
 	(USEC_PER_SEC / ARCH_TIMER_EVT_STREAM_PERIOD_US)
 
+/* 56 bits minimum, so we assume worst case rollover */
+#define	ARCH_TIMER_NBITS		56
+
 struct arch_timer_kvm_info {
 	struct timecounter timecounter;
 	int virtual_irq;
-- 
2.20.1

