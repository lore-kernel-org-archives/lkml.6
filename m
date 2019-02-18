Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CBEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8164D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550484604;
	bh=x2YxbIibcRpS3JCBBhmlIUFNRtqMc538gIKyPVT69z8=;
	h=From:To:Subject:Date:List-ID:From;
	b=iAWLtN6DF+4SkvXK18APSXFYunFHDZ23EOH3RvD8IiGOu7ESDxP1WECx+esNBBquI
	 SMHEGvSOTonGUT74hWHRQPn1pEN3ghsIoIASi/mmUhwkVIM0c91X/JeITUYQWQnpNA
	 qCikj2eVrLF/QrmbXW9+S9FAG2Bs9TZYFNJseVFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfBRKKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:10:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:57662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfBRKKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:10:03 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791212147A;
        Mon, 18 Feb 2019 10:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550484602;
        bh=x2YxbIibcRpS3JCBBhmlIUFNRtqMc538gIKyPVT69z8=;
        h=From:To:Subject:Date:From;
        b=MI7kUcTne/D/wZ7869PqljelgXNrTHvJl2rCXEEB7ehtFrGr5YaMvm4k8gZGjOUk1
         prKJd1tVluksweCxNY88D6ZpEGnJlWjJ6G06CLS0aTje0i6Uafya/IqADOrQHbqq8m
         WFnrKRvpbzCW1W8JmKoEJ619X/3wYWR0yqoGeOHI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] clocksource: exynos_mct: Remove unused header includes
Date:   Mon, 18 Feb 2019 11:09:58 +0100
Message-Id: <1550484598-1952-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver does not use sched.h and platform_device.h.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clocksource/exynos_mct.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 7a244b681876..33fc4038da06 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -10,14 +10,12 @@
  * published by the Free Software Foundation.
 */
 
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/cpu.h>
-#include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/percpu.h>
 #include <linux/of.h>
-- 
2.7.4

