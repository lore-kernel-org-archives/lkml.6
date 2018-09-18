Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE242ECE567
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941C620652
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTyZjwNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C620652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbeIROwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:52:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35068 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeIROwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:52:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so728633pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 02:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=GTyZjwNh+8tjNC36wgk/FjMscOtVon2H2rz5t6BOtL2hUz0g86KBoeiQz1sjggf2Oj
         gLqYhhc3l/lfy3PJy2eyQxpCIVxDQz8Ctr0nPoIiDgOHC5Mg/17s0rGDlAkePLzKbe+Z
         FMaBxM6CrOmmbpWiIyR6rWgzEFRsbZcooQi3Duq/a1FdQIkqOIadTwJpanyCp5SsIhOz
         1tWKOYz34tsPUo0ru1Fg6KwPfQkbJcnOS2tqHI1sFrgnTWFigkv8FwTzsMZovQcvBo/Y
         xXUGz8j5iaVnxVLEBx3n2rsYYb7k6aZbptwHMsVPuW/CnAa2ZOF4tm2kFqPGHeT/VWS3
         7p7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ul55wigUjE4to1TohXKcjf7rrHR2DeP0tn9CFO87rmQ=;
        b=By8CLbpc2mPDPpgoHybEp9CJrO1aWzc9JpGSoiM+P9Y6RS1RKiCrFat+0UU6DJ+gAe
         iwqV9iR8kCs9pZT45ZCr5x2otUrCvg1jFg2lPgdEWU6/EuYIjw0loaVOwjHw1ZFMV8iA
         1uXoCR66YMXcbUhLpGokH/anvrQwavPFPgv63nPNTflXtkus9vvsHuTDtx9evEYt3+W5
         fd848tp1sVPyuCvqKF9hPnSDVTGZVDHWfVivf4uOCr0jx0OeHH9cjV/RU1eqGGTW6VCr
         GzlOWY9dXOnKg6vD/fgO+UvQUWwmjR0//thWuETX0kuO31409SN9eW6Mvyhlax+eTTo5
         97Ug==
X-Gm-Message-State: APzg51BfGjZIzKyUAK7JGYFsT23Xr8rRptqoMKpiqRe2idrLY/8gHC/G
        c55h3jhxRcyOLWvzpH1aqyY=
X-Google-Smtp-Source: ANB0VdZEgqZ7RTUVRTl3SjZFzhsu4A0f0WtHQ0PzPhsyRhIGMHB002l50pJ2HJZYIxQGYA6tgAnunA==
X-Received: by 2002:a62:e412:: with SMTP id r18-v6mr29979318pfh.25.1537262450234;
        Tue, 18 Sep 2018 02:20:50 -0700 (PDT)
Received: from app09.andestech.com ([118.163.51.199])
        by smtp.gmail.com with ESMTPSA id 1-v6sm29932877pfm.145.2018.09.18.02.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:20:49 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     vincentc@andestech.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH 1/5] RISC-V: Build tishift only on 64-bit
Date:   Tue, 18 Sep 2018 17:19:13 +0800
Message-Id: <40c77db9ee2d23479ff90f2658539d29d7a30896.1537260207.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1537260207.git.zongbox@gmail.com>
References: <cover.1537260207.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only RV64 supports 128 integer size.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/lib/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index 445ec84..5739bd0 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -2,6 +2,7 @@ lib-y	+= delay.o
 lib-y	+= memcpy.o
 lib-y	+= memset.o
 lib-y	+= uaccess.o
-lib-y	+= tishift.o
+
+lib-(CONFIG_64BIT) += tishift.o
 
 lib-$(CONFIG_32BIT) += udivdi3.o
-- 
2.7.4

