Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30581C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D7A20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 18:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLQn6YlD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAQSsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 13:48:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36662 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQSsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 13:48:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so9476643ljk.3;
        Thu, 17 Jan 2019 10:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16wQ/W+iiw7IUM5Bi30mVlqWhz2HSmpafYkT56+zMkU=;
        b=ZLQn6YlDN385GAiRZUoLQT0qlFcZ85lMqzjjM5IU094QhzHeI0HfSXmAiRWDo/DsMC
         T4CD6ejl50vjgRXILrUirFyX8edtCeDIgFhi6OEeMwdMHVycO+QlVsWwqJolXtO6q52j
         VslL3Q30IWJtx5T5n2Qjx2ZfpzFJVjOc0NesWSQW3A1AZBxBQ/GVAaJUz6DI+7qRonRO
         QkCwsUevBf8qmRy6/gdwhAuad9xplZhOMFUytzGR9KHnVPVzWoNuCWhB8i0ESJWm8jlU
         X4OfX694JER7FaW9IGtvGayvBLnmZeyJkXEUgbHSvxqwFxzzsa28QcVbps5k73TwRXhD
         tIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=16wQ/W+iiw7IUM5Bi30mVlqWhz2HSmpafYkT56+zMkU=;
        b=THngXZOwLhSyCx9DHKrMB/CXDRCP5IRbfqZPE+IR09PkUApkcJiIixI3vI0H1YN63Q
         mVu8IYm8CoG7vmu+ErCXWvh5LLhAutPo4afXG+aV2RuSYN2E+x5m983kBSmPbufHxI83
         G2nY6L+RSNejId6605S5N3E31Skn7C3NSpqofCxWP7HS1W3RBTtDz5RZGtU/aGnVUPkU
         AJxUxki5Sva6DLbsTmuHGC9PiMhVCibjVwJyHm7e8ALpRaoIucIKN12fKlFzEtDQpuNq
         n9PbYqmq+n7XzsrgLepCv2RPevoCWTntMJhhtoWJpwMkrpbnORnkcaJNAxG5riSU6TjG
         jpZQ==
X-Gm-Message-State: AJcUukdyM/aW/WaLZ0QPnrFKDm8yMsFyHk/y7RHNaY4L2HQ+ByG1hoe3
        N8I0cJCZDpogOE8RvzOLj6U=
X-Google-Smtp-Source: ALg8bN6m8tJQxd/ldebyZLarsZu++1KrySx0C0AbR2m2Kv/lUrBPbFYZEq4nkooRbWYOtcF8fjsojw==
X-Received: by 2002:a2e:9059:: with SMTP id n25-v6mr10536225ljg.155.1547750882189;
        Thu, 17 Jan 2019 10:48:02 -0800 (PST)
Received: from localhost.localdomain (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.googlemail.com with ESMTPSA id p21sm433496lfj.10.2019.01.17.10.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 10:48:01 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     panfilov.artyom@gmail.com, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: rtc: add ABEOZ9 support
Date:   Thu, 17 Jan 2019 21:47:54 +0300
Message-Id: <20190117184755.21179-1-panfilov.artyom@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Artem Panfilov <panfilov.artyom@gmail.com>
---
 Documentation/devicetree/bindings/rtc/rtc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/rtc/rtc.txt b/Documentation/devicetree/bindings/rtc/rtc.txt
index 7c8da6926095..0ac93f2dcedc 100644
--- a/Documentation/devicetree/bindings/rtc/rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/rtc.txt
@@ -39,6 +39,7 @@ possibly an interrupt line.
 Compatible		Vendor / Chip
 ==========		=============
 abracon,abb5zes3	AB-RTCMC-32.768kHz-B5ZE-S3: Real Time Clock/Calendar Module with I2C Interface
+abracon,abeoz9		AB-RTCMC-32.768kHz-EOZ9: Real Time Clock/Calendar Module with I2C Interface
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1672		Dallas DS1672 Real-time Clock
 dallas,ds3232		Extremely Accurate I²C RTC with Integrated Crystal and SRAM
-- 
2.19.1

