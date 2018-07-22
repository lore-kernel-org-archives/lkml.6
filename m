Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41565ECDFB8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAACF20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0UWYW7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAACF20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbeGVXJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:09:26 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55859 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbeGVXJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:09:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id f21-v6so14079810wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jul 2018 15:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NL+J570fA68ewsBPoAxWuHKAxvLB4R8T0ncHDxO5OIw=;
        b=p0UWYW7T9t8M+JRcjKFxRDlYVKK5cce0ww4SLcyH5kSA0xlnCA+3tIZaB2v0SKGrYP
         oQB6pesAsjI19FQ/GKFyG3HHBMHUEzmnY3RSUqooeAtyFmKlrrvwY8fpMcatZ5g5ZAQs
         UdtApG1n8/W09wJD0B0pcl1gzDDzd3GI/ohk0SQsp9ZCr5uJnuwgI4sV8F3iRdLB2iCx
         ZrwiMiOkupPYPWwrWb1PQoIwXBqcifuYij3zsQSDwf0M2bUZ3yRJWf2gf65TAF0OdYIM
         FC9LcoaYFWsluOh6cDJM1N64zSnCOQT6CnZNdSBEemjHa2X54VS5+wRWA3gscackmAi2
         2doA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NL+J570fA68ewsBPoAxWuHKAxvLB4R8T0ncHDxO5OIw=;
        b=eenSgmhtn0jRPYGSJpP6blz/pGY5DFxfigldNP8QQflUI7J0mN7v4YAi7aOuEDtvhW
         UouKNAm4MrvoikQgaI2vWj/A7lIlW1ljtu9EkPSP2PjmzkxdAPa7sTUX35G95+R6ffcZ
         PkSDAPvWxust0XgWjYGMuotzxNc95DMnDVp+0uLU/fZinc2n3fM2eJwBdWnHpttg5PFs
         qZeek/LZqduogekhtwM12ei86ISCEb9Nh2AwpPl9RqN9WenYLgaZrRoKpD6xgRKu83JO
         IGwrtrtfXM4hLn0MkWf2Q0iCmSKEpqpFr+W4VKfAzWEcNXcCUIge2QgVCpgnFyhGVXlr
         OA6Q==
X-Gm-Message-State: AOUpUlF8qSI4EcZY5AbgdeTTjCpwSp8Ft0JrtVhBTmHY2X0IUtMDgf8Y
        kDFlfHY9wrOVgNUdxt1yEkFHnp0Ayic=
X-Google-Smtp-Source: AAOMgpddAwaR1lUPudTDskycDnYYimGzda9E6m7EBb+gKCPy8Hx7FLX7ZU8nX4ma5tvh45s9yG8vDA==
X-Received: by 2002:a7b:c058:: with SMTP id u24-v6mr1348627wmc.136.1532297473491;
        Sun, 22 Jul 2018 15:11:13 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id e12-v6sm5870824wrt.29.2018.07.22.15.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 15:11:12 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 16/20] staging:rtl8192u: Remove unused page e Bit Mask definitions - Style
Date:   Sun, 22 Jul 2018 23:10:31 +0100
Message-Id: <20180722221035.14453-17-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180722221035.14453-1-johnfwhitmore@gmail.com>
References: <20180722221035.14453-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused 'page e' Bit Mask definitions. These definitions will
fail the checkpatch CamelCase naming tests. As they are unused in code they
have simply been removed rather then renaming.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phyreg.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phyreg.h b/drivers/staging/rtl8192u/r819xU_phyreg.h
index 671fd35297d5..93be2b2cf899 100644
--- a/drivers/staging/rtl8192u/r819xU_phyreg.h
+++ b/drivers/staging/rtl8192u/r819xU_phyreg.h
@@ -124,15 +124,7 @@
 #define bCCKSideBand				0x10
 
 /* page e */
-#define bTxAGCRate18_06			0x7f7f7f7f
-#define bTxAGCRate54_24			0x7f7f7f7f
-#define bTxAGCRateMCS32		0x7f
 #define bTxAGCRateCCK			0x7f00
-#define bTxAGCRateMCS3_MCS0	0x7f7f7f7f
-#define bTxAGCRateMCS7_MCS4	0x7f7f7f7f
-#define bTxAGCRateMCS11_MCS8	0x7f7f7f7f
-#define bTxAGCRateMCS15_MCS12	0x7f7f7f7f
-
 
 /* Rx Pseduo noise */
 #define bRxPesudoNoiseOn         0x20000000
-- 
2.18.0

