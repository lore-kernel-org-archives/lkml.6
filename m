Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD10C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AC1217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0JBhhMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbfBQSxc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:53:32 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38324 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQSxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 13:53:32 -0500
Received: by mail-lf1-f68.google.com with SMTP id n15so10678580lfe.5;
        Sun, 17 Feb 2019 10:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=16wQ/W+iiw7IUM5Bi30mVlqWhz2HSmpafYkT56+zMkU=;
        b=e0JBhhMhVREvOLDkKvChY5NDRtMDhszUgVXlmiXBb3AL0b0FAb/O6Fp6SLsKhRK0AD
         pvhQWa1scFbs3C3tej66ATyEEz9b9GvQJQwWO5EJF053Pnu4k0oWWNKj3AGyuubOCEC8
         EQBfBiBTPXB1RaINGIOh1mqntcfl4tmcHG5r45p9IaosUtDQf2e+/5m1O+cRd8ypbwB8
         6zDh+zA5qMmoSGB+Ckw337hXhmroguunOxcvicUs+PKs6NWuBCcLK3tH+Gee60qGLY98
         3xAPxCQ/Eig7M/aK5JL7Vwh36dVEU50AjcOlB27EnHmLBRzuDhNODNkGhOLHizkHLcRd
         UCpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=16wQ/W+iiw7IUM5Bi30mVlqWhz2HSmpafYkT56+zMkU=;
        b=DbcISqyslY4OzQuE5ViodITSlk1pZV8qS6Slt3N7lHxtwCuzFqm4ar6QotOUhFKVZS
         H1zQNYssgNatqe+/eePxiZ5iI3+8fUAZ6FrcPbwbI9elppeWWng2mfFcBaMyakgmhrpJ
         nbb03HsyKpGIVVgQIYBoCnvBekOX+GuRERwhOlNnxtdvsmmE/76WFO2k02RdT+aVxAMX
         18OF1ahtu+TixL5z1u60PzuPhi95DhBTjdjCIgwJ+nLMgRH4Ry5k1fr7eRKNytp4cd0b
         c61bmH121WHWb4N6ssX4lRUOU3gcTOlvv1JR0tDyNTo6zuSVx/kfNEmPzEvb8bbRa5za
         ul6A==
X-Gm-Message-State: AHQUAuZXvzVGL2UtHJlUcH5NlZuybaVsmM7i0DJqgQMqxwhy3rdJw2mv
        htcsogk8mdfs86xNc/VJZqU=
X-Google-Smtp-Source: AHgI3IY9G5KBq98axH30G9osxSGeJOKBLdAAPTo0AtUXXe82DAoCP1Qcv8aK4le+LwVK90kWmOoG3A==
X-Received: by 2002:a19:4948:: with SMTP id l8mr12421451lfj.156.1550429609524;
        Sun, 17 Feb 2019 10:53:29 -0800 (PST)
Received: from localhost.localdomain (6-191-187-93.customer.senator-telecom.com. [93.187.191.6])
        by smtp.googlemail.com with ESMTPSA id x19sm1722243lfe.42.2019.02.17.10.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 10:53:29 -0800 (PST)
From:   Artem Panfilov <panfilov.artyom@gmail.com>
Cc:     Artem Panfilov <panfilov.artyom@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] dt-bindings: rtc: add ABEOZ9 support
Date:   Sun, 17 Feb 2019 21:53:21 +0300
Message-Id: <20190217185321.2189-1-panfilov.artyom@gmail.com>
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

