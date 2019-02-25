Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCC1C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDC920842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlqbMsdA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfBYOb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:31:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33647 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfBYOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:31:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id y10so4610696plp.0;
        Mon, 25 Feb 2019 06:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OSSLyOA9Xzza2IN/f9pZWdbDRiqhDtYBn/LuTWSpqBs=;
        b=jlqbMsdArMCZTiqirEdv77ZYXRJJl7y4dB1K1vuQFd7ifI+OST0KPK1BEqJ3PShhiI
         YIZZBG+iNfXfa5W1fx8ArEEEMUinrY6KcOSh3ttboU6ye4o8QlDGGAszegG3P7tEkjkq
         3tM12XQOkdoJjzXPsAy0JWnEiIYp1BAYo7EqHJAX60YoHedPTei/GNAm3j3fHIW97HAT
         1WJrNB+H5WOSeNnLOX+8XDqYLpjsxZJaigzvogmRFfQfj72aH4/p+wHEL9I2QN58uUgo
         vmD4+eZZPCClps2mvyAbb6yRvOy+Nt3i8RInal4xXYZBB/RkAG5XsCUs8kX08G4uvljV
         MqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OSSLyOA9Xzza2IN/f9pZWdbDRiqhDtYBn/LuTWSpqBs=;
        b=iRw6+0NOh1zoDwSs2JMF5TQjOYGuk5+z3aReSoct8c38318HMMFK2hgiTOUOr751QG
         OahLFVVkylX3wfKK3W2GyIaMQjFojKk8vFkZHhFrc8BWyrWJVsxJO5pkd8E//wCY6fz9
         Cuk9MeeP2Ew09acmAg6ylr9g1/j2eK94xJ/pyFr+gbWhRAUW0DGPnFbkeyI5mIfP/fnL
         RHuZQ1NCDw1uD+wiD+7S2s1r9gl5wHghZRquXsmFr8dmqaFo9QKw7fWHIeNsP38yOsUs
         8vS5wpJTR4LUrWj5OYuBVcvDPppPRg7F8ievS8KUrABoPykZRPAAvKURh59o/KBBgmEK
         ugvA==
X-Gm-Message-State: AHQUAuajD5EyuF/jVvjY3MOu5b4EwX6ztR7gsRCQL8ab/ujRBoQ+QslD
        RFU4IdllarIj8/GFwaSU/i/HOEvs
X-Google-Smtp-Source: AHgI3IYaTcbMJI7NVdDUrnJvXa5zFlYyBkD4eyhSNXafW9LGrCp51YqgVLukI0VhdgTRrjmAp3UgKA==
X-Received: by 2002:a17:902:8504:: with SMTP id bj4mr20155789plb.200.1551105088151;
        Mon, 25 Feb 2019 06:31:28 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id k7sm23554917pgr.28.2019.02.25.06.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:31:27 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH V2] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
Date:   Mon, 25 Feb 2019 22:31:14 +0800
Message-Id: <20190225143114.5149-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lan Tianyu <Tianyu.Lan@microsoft.com>

The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
is equal with how many entries of union hv_gpa_page_range can be populated
into the input parameter page. The origin code lacks parenthesis around
PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.

Cc: <stable@vger.kernel.org>
Fixes: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
Change since v1
	- Update change log

 arch/x86/include/asm/hyperv-tlfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 705dafc2d11a..2bdbbbcfa393 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -841,7 +841,7 @@ union hv_gpa_page_range {
  * count is equal with how many entries of union hv_gpa_page_range can
  * be populated into the input parameter page.
  */
-#define HV_MAX_FLUSH_REP_COUNT (PAGE_SIZE - 2 * sizeof(u64) /	\
+#define HV_MAX_FLUSH_REP_COUNT ((PAGE_SIZE - 2 * sizeof(u64)) /	\
 				sizeof(union hv_gpa_page_range))
 
 struct hv_guest_mapping_flush_list {
-- 
2.14.4

