Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285C0C10F00
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E932E20818
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqATnabA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbfBVKs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:48:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40128 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfBVKs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:48:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so937471plb.7;
        Fri, 22 Feb 2019 02:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fAdmP+5W2W/Twor/fTlS5H793IUgC5hKNOYFaD43O34=;
        b=FqATnabAuhdjzOFmA7muuqFvjvMujtxYxRjpDFEAxLf11ADpWVnIZj3iVGNrpVkQBx
         RytuZrK9JgZqSTPsAwCeWohP3xkqhk+RNLPJ1b9VKX2VhgJRYmMtyxdaGlX8MsR/l6DF
         CvKXofCbGDPSXM5EtCtrsZiMaS1QQyT+K7PxFwgTE3QOkAnPCRMlDwFwQMuVUkoRTQan
         k10yCDtu5ThjFk+Aeutpv5bY8WZIx0MIJpZttJOv3c5lZBHHKYgpqdREZVXvmxXO7yYc
         u7E9XBAKpGtBDWREuWjgv6/LMJg977Xq5miaMoz9WHpbLHajNXqDDbFwY8pIrLTwNY5v
         GIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fAdmP+5W2W/Twor/fTlS5H793IUgC5hKNOYFaD43O34=;
        b=kL6X3tcYwKKAv/DqdjuEGbG5oKDYL+/LPoIQysa+/knmS4KqrM1HezPQeQI1RW5U4K
         UVui9m2lqSaXkzTqNfv8pyGFGuxcI9OiWG+eebyW5TNecjRloQWbZdokmswRfHTFSR8y
         JAnsQv9N7bnP7BHFV9y7U8wVmg+2BBjvTHr88kVu07i5LVSKuBRAP6M7IRiR0xn07rC/
         nY8H8BcZ1+tDxxHqrKBenpPPJr7TGIxaTSvRZXigXSKVocopi93mHAblIBUc4NsSO3u/
         CYbs4GRQMz6A/Kd/slsSw81lja4fMoBli6tYXqwvfgxIGIUTit1YxhZi3xkQe8s0INXz
         zKsQ==
X-Gm-Message-State: AHQUAuYgN81azBHTKdAoYj4Y2ntvWpgXnM2OpXGoSNe4S480IFAxOLQ7
        fcMUP9BjlCc6guuJbylQpfM=
X-Google-Smtp-Source: AHgI3IaWjASUkU76oUdbWtkNzBsHKRTATh6auh3QEUS7vFmP2A0HufUijwD4ASth6YBG5heidDYPPw==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr3570610ply.65.1550832538475;
        Fri, 22 Feb 2019 02:48:58 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.67])
        by smtp.googlemail.com with ESMTPSA id t71sm1537822pgd.15.2019.02.22.02.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 02:48:57 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
Cc:     Lan Tianyu <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, sashal@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, michael.h.kelley@microsoft.com,
        vkuznets@redhat.com, stable@vger.kernel.org
Subject: [PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
Date:   Fri, 22 Feb 2019 18:48:44 +0800
Message-Id: <20190222104844.1847-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.4
To:     unlisted-recipients:; (no To-header on input)
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
Fixs: cc4edae4b9(x86/hyper-v: Add HvFlushGuestAddressList hypercall support)
Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
---
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

