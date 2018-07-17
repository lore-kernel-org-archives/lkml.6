Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F14BECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB777208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rdy+dk2h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB777208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbeGQCka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35679 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732049AbeGQCk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so8264182pgv.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=np07gctrloF9BSfAbY6qjgu8AZhw18Wxoef8j7gLC1c=;
        b=Rdy+dk2hezTk9V29hIx2eb4luSMn4093SuiDyuVHwdkJa2KO97BnhA2km9iJMlnCtK
         bp75BADciEXZapKOmuZl8b2KjVhRO87vSUkhAS5gCsLfuO439DyGC2Yzz1EYtcemrE9k
         vtpGRTRy1SdeeiAIQLkQ5lLt4HGhciKnvcjWjl1KC7IapHYss0QpaiB33NYXmzLUVioI
         lZGcittozca37BxxmnDwLwgqCqObDfzFWZ9oyiVh2Ist7BwyXRPocxlP3vPJwFidFDw6
         O9OAerYBlG3H40WDlbdn6HkLl6Fq5Hyo0vUExAtfzBIEw3lukGHgNk1K1qPnXh0RP+Av
         eQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=np07gctrloF9BSfAbY6qjgu8AZhw18Wxoef8j7gLC1c=;
        b=BLHh7DXa+CV0Z6i2R7vQ4SQHhaI0Q7uxRPr8BgUa2XMYyBjj1qr6e1KFxuDouVjLyT
         Jh53IqRdlFKSdF5QtHaGJPscFB2/UQKLj+8+YP6q3Mhu+3zg4a0ynyXvVFCc6OZ4O7aP
         CcdxlUBeswU/JVAuU5uqS1Rlc6e32m7jy8LQvjiPLfTEyz25BC7K+qe+xpOg2rQeHOkl
         +jxM3etgVkES4u9Goqyt06DUC8vaer3704djbU8WLmUEOGHZmefKPiqOLYmy/RAma8zg
         8A+il8Xaow8TXLTm7z/NFjBBGME2Rqs3unhdg8jLbQ2O2LRWx1+GwDfu8sZ0KIdt1D3W
         jpGA==
X-Gm-Message-State: AOUpUlH2VCVKRC/xlDnjCTSMfc5NwP5A6aAuaA6E70LKBsx9UYhTSXja
        eyWvnKftHIltkFQsZwMz52o=
X-Google-Smtp-Source: AAOMgpeYzM/sehVxd5N2Cm8Jh4Mk4ROvZLKb/Pw7lzhLiVBPOh1PlRWJM2bpNM+VrxCXp0d/BulFOQ==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr20422096pfo.160.1531793418976;
        Mon, 16 Jul 2018 19:10:18 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:18 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 23/32] staging: gasket: gasket_mmap return error instead of valid BAR index
Date:   Mon, 16 Jul 2018 19:09:17 -0700
Message-Id: <20180717020926.176408-24-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

When offset to be mapped matches both a BAR region and a coherent mapped
region return an error as intended, not the BAR index.

Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index 131ae2462edc1..1d979772217bf 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -1630,7 +1630,7 @@ static int gasket_mmap(struct file *filp, struct vm_area_struct *vma)
 			"0x%lx",
 			raw_offset);
 		trace_gasket_mmap_exit(bar_index);
-		return bar_index;
+		return -EINVAL;
 	}
 
 	vma->vm_private_data = gasket_dev;
-- 
2.18.0.203.gfac676dfb9-goog

