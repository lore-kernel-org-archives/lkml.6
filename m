Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DDBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5062084A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4H8lhoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED5062084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbeH2LXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:23:43 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36480 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeH2LXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:23:43 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so1947477pgo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=seB2EasrbLLttRjaVUxm8LWrqGhdTSP6c9RcfLeVRng=;
        b=f4H8lhoZtPCijF2qMsU+Q5wD39Y+Ek1cTIMbzZmzrjBuXfS5hw0K4vh9gq3O7Zal8G
         n2k3XoytMXQQFzN3OyS5YVuoNjN8gpSumik562I+YC0gcDu2SCEhNRQHfyAd89L5aFqU
         YfPDrCmDetOxZWFsmMXeVoxQPQMmmn0WnqBvwCKRU2V/ZKOQ/dt+xufjG+ulbUySVydQ
         Uhxe9AbdUUeIyuUgFLS9r5QNztGSKkCWuCTA9KEOMTwUZ4waXgN0BeXL9bsGGdnTUtoc
         nVLKLw7D796foegPJYF2eg6c2GT6wXLTQbjuyBCklYhVImBtSgOAo6IYt79tGUQ7pqiQ
         W4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=seB2EasrbLLttRjaVUxm8LWrqGhdTSP6c9RcfLeVRng=;
        b=Z1fv2BqL6NyNBxydWLQvN81d0L4J0AhdMmB1zY/uBLciSAisfGUD8xOcRBsHMjJ/kR
         818uBJp39nx/upYBR4kZtqg72kFxyCyCO8x/S6LtOzgJh36bb+6MaTg2VynhAWn84aaO
         PP65A6nP0+ZOZGix+mVApZw3WAtoqfI7X4lYaVDMRc74ry9GtzY3t679f1CTK1hl206/
         fMjY0PfeSjUCM9Pgw7Vx5ZwhBTTgIm8QDeX4cQK3PoBaiYQ/Dx5i+jP1/DqmW76lCy9c
         GI3QdFRV2HaFIrq/QXqDEOJaicPwetQQwAJcKIfJPXxsqLTnr9mz5TUD4A9YqSCzSVIc
         GP7w==
X-Gm-Message-State: APzg51AgPOAeCGKMhr/8y50HVV5E9IG95EhRkuLQ5n9m8jJg+1nbiTAf
        L2xateazkYetXzDtmYo5ydE=
X-Google-Smtp-Source: ANB0VdY8WEPLCE7cLGJ3yOtW4Th2kuEVqHR7ILMRkL3VrG5s95ApPl5APpGXkAR+QeDbJG3nP9cwsg==
X-Received: by 2002:a65:41c6:: with SMTP id b6-v6mr4651697pgq.174.1535527692511;
        Wed, 29 Aug 2018 00:28:12 -0700 (PDT)
Received: from myhostname.localdomain (M014013131161.v4.enabler.ne.jp. [14.13.131.161])
        by smtp.gmail.com with ESMTPSA id c88-v6sm5016926pfe.132.2018.08.29.00.28.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 00:28:12 -0700 (PDT)
From:   Takuya Yamamoto <tkyymmt01@gmail.com>
To:     tglx@linutronix.de
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm: Fix typo in arch/x86/mm/extable.c
Date:   Wed, 29 Aug 2018 16:27:30 +0900
Message-Id: <20180829072730.988-1-tkyymmt01@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Takuya Yamamoto <tkyymmt01@gmail.com>
---
 arch/x86/mm/extable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 45f5d6cf65ae..9ceb940334cd 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -230,7 +230,7 @@ void __init early_fixup_exception(struct pt_regs *regs, int trapnr)
 	 * result in a hard-to-debug panic.
 	 *
 	 * Keep in mind that not all vectors actually get here.  Early
-	 * fage faults, for example, are special.
+	 * page faults, for example, are special.
 	 */
 	if (fixup_exception(regs, trapnr))
 		return;
-- 
2.18.0

