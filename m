Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AE6C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0886520858
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DCrTJoaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0886520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387996AbeGVXJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33573 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387891AbeGVXJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so1767588wmh.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ln/5oSGM+PTmrsaPjEpxQvY7YVL1GBUAKahfckUarCM=;
        b=DCrTJoaaqrM/4cm70uXrn0Mqi8SzLnRTx6Q8ergmx7licCOXsGOnjT2nrZ2AM+c++b
         mVDC0AozZ4Kuexe4ufVvO9/4YEK7PUI1tMl8hwthQTh2ldRXNdC/ldu4efe4E64srn2L
         kC1dOZiA1bzseFJVJeBjQgD7UbFqc0Q4LvY1EERJoXyuAuis6Rr84sUv8KJsMSl7cpxK
         +Jx0BDJg8Vl1cvDnzxwCGCunEqRdHyOGA4tV/1sdBZHIQVMB5sldX2mT2pxraYXFogI7
         UhkMbatNlQmB9jLgLJOnOgkWRoZKSckzhJURLmoxXvcq0In9ehe6XxoFdsCmSq4Jmm8G
         TM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ln/5oSGM+PTmrsaPjEpxQvY7YVL1GBUAKahfckUarCM=;
        b=mFKHEJ4jCLOclluCziNBRESFv/RvmPgv1ucfMZHnIBDMb1TAQ4+/h2qVq6MJj95vwn
         PSuBO14P14BLVOcUwtDzGfeUHHvCmpwoDb4yNIfpN1fwciajuxPAotgXJFZCot1V3sT8
         mzJF4uqMVfmS2RRSa2f1x6f12TtR5CQZJJTLRKgVGl53cRpeijWDuj54QB/KvUBwxPX8
         vr7mgLBjPd2YZTCq+0WbE0JgrivyD5PCXl+oZK/cVph+/0yoLyvCUIiLwcVZIjcYLk3N
         bY2watGigWa8UDR6m3CIdYyu9Q4Kg48G3rsRjNkaZdDvmVueqMGg71PHgAt1y6EiK1YN
         rPPg==
X-Gm-Message-State: AOUpUlHy/jI6PfdWrGDWmEpC78cxFtBhMgOUyQzhgvuIk/F5xMRf/Tx8
        RHmMZa4eD2jpwyEvYc5Majl/9L7LPuU=
X-Google-Smtp-Source: AAOMgpc8fWrOYbgxHEGDFW+sLS35iMv285J4cIIp71Rc5VaWx9ctvCZsLUbIIiPOGuJMdBxRZ2+CQg==
X-Received: by 2002:a1c:7408:: with SMTP id p8-v6mr5811904wmc.118.1532297474963;
        Sun, 22 Jul 2018 15:11:14 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 17/20] staging:rtl8192u: Remove unused Rx Pseduo noise Bit Mask defs - Style
Date:   Sun, 22 Jul 2018 23:10:32 +0100
Message-Id: <20180722221035.14453-18-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'Rx Pseduo noise' Bit Mask definitions. These
definitions will fail the checkpatch CamelCase naming test. Since
the definitions are unused in code they have simply been removed,
rather then renaming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 93be2b2cf899..b3f9f7e65073 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -126,17 +126,6 @@
 /* page e */
 #define bTxAGCRateCCK			0x7f00
 
-/* Rx Pseduo noise */
-#define bRxPesudoNoiseOn         0x20000000
-#define bRxPesudoNoise_A         0xff
-#define bRxPesudoNoise_B         0xff00
-#define bRxPesudoNoise_C         0xff0000
-#define bRxPesudoNoise_D         0xff000000
-#define bPesudoNoiseState_A      0xffff
-#define bPesudoNoiseState_B      0xffff0000
-#define bPesudoNoiseState_C      0xffff
-#define bPesudoNoiseState_D      0xffff0000
-
 /* RF
  * Zebra1
  */
-- 
2.18.0

