Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B6ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CBF20863
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 18:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qen0OnQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8CBF20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbeGUTv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 15:51:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44994 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbeGUTvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 15:51:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id r16-v6so14082159wrt.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 11:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YLG3KL26xk9nHw0M4MqU6vYagSCOUSDEnCwL3sKniXs=;
        b=Qen0OnQs3//MBTMuu3JcLqUL6Rq79vXWOOrwV87v+zf/mPpntMAt1gQb2yJ6u0b5dN
         pErvnWzL5ZDt+n95tBp/nRp/1VI+01QIYXgtpSM2M05pfGCJzcn6V2s2kl+XSMVsCyiT
         eRlaIPW53CLfbchdJlQxB9njSWPNrioczaRqR3Jdc1SCuGNRpsJzttbRhvmzElbXGZXY
         M9p6vxY3jcAZxiFlc/X/2JjlPqibUToT+P6BcdY4Ye477OXZwbJH7NWdWH8+KQfOEJJw
         ThZ9Dk0o3fwLoiGiTWC69AT3cxvZ1CVQUZV3gN27WSdJjiDSByCJL/PInQR+rRjBjM/s
         81wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YLG3KL26xk9nHw0M4MqU6vYagSCOUSDEnCwL3sKniXs=;
        b=rJ20LSGJ8TLLY4Io0Msba4GlqlRN3RWZEMX366zRSlbnYhJYjcjbV+OCQXZdZMJ8fF
         i3emkqumjEanRNfojy8K1TwmoCx6B7tBwDZa0K4aJaQMhN7mquZWCZh4h8GzNDCcdn+h
         tsrOCWKz55FIMcIb2GSoI4XAZyOUd35yViKfBDyaQoNBEAqD/aU0JrO7xiPpqiXBORRE
         559vtHuLiGoD+9O9F7P16GNNOnGyc28BigA10FOQAft1U49xHeyGPaGJqtaq1c4WWhqd
         ZrTC8P7wsfAnn8B9tbGDUdyrEdneMs44FDYfuCTStqZg+mfcZwsLN2G9IygGoEJv4FVq
         ukCQ==
X-Gm-Message-State: AOUpUlH9FfruMUBJtVqyTkRgQp8IMT4kB+37OxlnF9yMU3nMFtNlm7Un
        WkLUSPt6Iqp/HKiElsCVzW4=
X-Google-Smtp-Source: AAOMgpdndzHrzBMI29xaflFHC3vnLP+QiJI+VKDNJX/GtgskhwRNsuF7eXLXwbD487HEHwR2BpdrGg==
X-Received: by 2002:a5d:48c7:: with SMTP id p7-v6mr4831617wrs.0.1532199490611;
        Sat, 21 Jul 2018 11:58:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:34d9:1402:6a14:c45d])
        by smtp.gmail.com with ESMTPSA id w24-v6sm3657899wmc.15.2018.07.21.11.58.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 11:58:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 8/8] staging: rtl8188eu: fix lines over 80 characters
Date:   Sat, 21 Jul 2018 20:57:42 +0200
Message-Id: <20180721185742.7496-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180721185742.7496-1-straube.linux@gmail.com>
References: <20180721185742.7496-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two lines over 80 characters by removing unnecessary parentheses.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index 7c3e744cc4a9..c69edb7d174c 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -20,8 +20,8 @@ static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbu
 	}
 
 	/*  HISR */
-	memcpy(&(haldata->IntArray[0]), &(pbuf[USB_INTR_CONTENT_HISR_OFFSET]), 4);
-	memcpy(&(haldata->IntArray[1]), &(pbuf[USB_INTR_CONTENT_HISRE_OFFSET]), 4);
+	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
+	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
 
 	/*  C2H Event */
 	if (pbuf[0] != 0)
-- 
2.18.0

