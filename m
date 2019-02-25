Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB81C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161002084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hZFQ/r8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfBYJpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:45:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37921 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfBYJpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:45:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so9110776wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 01:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8g1XLIE6fTtgeGNFN37ZGEI5BE8leclv0hOaGRovJHI=;
        b=hZFQ/r8BVzOq5eaKb5QjNW+dlwIrv5V82PRD8MjwvP1s3YqKxZmSi3LHb0POYnrRRr
         3M5/h+xvaO5GkECnJqjC0sO7bL76scKWKjdKZC+7vhcJmmmKwmjmfj/odmIYJnduTffC
         alOyJYUhd3xyw/G0TLf6VWKnzPAghBWc1mbCm/wL4+QuUL4ZM4doW3SbMM0SPJmrIgkL
         T2tHT8+2VNnDJj7txdazdDEMqOJ0Ylv+6w8zY4wLhVBgsEQem6TdJgEpDDtco/hlnkTC
         IpKu76KoHXDqoZaMeIqPjLQjWxpWIllxF9nKDBsP8/1gwhKi0VdRxCM8GWj1698mBrA5
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8g1XLIE6fTtgeGNFN37ZGEI5BE8leclv0hOaGRovJHI=;
        b=T8kAwXs03MVYKkNIu0u9QYSJa3Sb5H2CKfPvoh0Kd05HEcoH4gcQRYwr4qh43zWC0z
         3MwvzYk/54KiScQINHuO2ZO5iCecAZlK39x4SvZO13RXzDp3mhLVnRT/ReShSEJrFtJV
         S/UkJIfuJ38INUF9FCHqlw2Ui76fSo7Y7x20752u6qoQ42xW9ApikPRtLcX+gxdLmcND
         mvVMINQXu5u40lJsdNBFGSR9qxhGm1KOYsxQKMzxhAcMLHFd19FV2D+RNe+RQCPzmPWi
         itqKQAv7tWzh1dQLUrKFHw6PPLH9De45gNa9A+JbRgI+udBCncmr8a0YLNq1jBO8Hv5B
         GjkA==
X-Gm-Message-State: AHQUAua9G5iBaHM6ILoby7NIBHu7LQmMFwATBAiMb/5b3GNiDeEdQyxf
        DuNw5eAYrscNA4222ZS1qR4LaA==
X-Google-Smtp-Source: AHgI3IbZ5NDniu/X8z8Jp3HPGCmNtXlVMJji0A4AcU95y6DHzZSyclWJcITIiZ2US55eYUbKhqQOzA==
X-Received: by 2002:adf:f103:: with SMTP id r3mr12984510wro.50.1551087944085;
        Mon, 25 Feb 2019 01:45:44 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id z6sm15749401wml.40.2019.02.25.01.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Feb 2019 01:45:43 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     vgupta@synopsys.com
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        khilman@baylibre.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH resend] arc: hsdk_defconfig: Enable CONFIG_BLK_DEV_RAM
Date:   Mon, 25 Feb 2019 09:45:38 +0000
Message-Id: <1551087938-28594-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have now a HSDK device in our kernelci lab, but kernel builded via
the hsdk_defconfig lacks ramfs supports, so it cannot boot kernelci jobs
yet.

So this patch enable CONFIG_BLK_DEV_RAM in hsdk_defconfig.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arc/configs/hsdk_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 6fd3d29546af..0e5fd29ed238 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -8,6 +8,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.19.2

