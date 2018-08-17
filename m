Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F6AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421892187B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJn54qvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 421892187B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeHQVjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeHQVje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so7828512wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2LQHn5dznk712STqMyX89+N4LC7IyE2Xhg6JbNXHqPM=;
        b=uJn54qvSoQcnqIStt6dmzE3N6Nlye7yzgIl2VAFRI65WesVNx5l+emOlIPIhGGHJwa
         3EFiyW/PObRNDJQfez4HCkN4QOo81DIhhiOYGTBUfendYspqqBX/+Tb50Y9rtC5vX0t9
         AsxXzAP4ehUk7/Gmc5fAEr98TZ4HcO1vncx59lQlmQ3qVNV/8DbcUyhwUHt/uBenWf/5
         BF+TXNz8lqgHYQEl2Q8O9yVPuqTAj4llMmmnovDLm1Ym+Bn9Cs7f91nl3MaUX7Pf1WZa
         vD17MRs1+ORVGxCDHkkQ553+YGL9z4GUPSOphVisAeRD1SwAvhUhbxX1VSY6qPsyeInn
         iiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2LQHn5dznk712STqMyX89+N4LC7IyE2Xhg6JbNXHqPM=;
        b=GJJhQC1fnky70OOt0Y24w8AdOKUSXYKO9T1pXBUayWjxCzSQmrgrL+zibFEiQpLEgU
         bBvs4Qh6NJvIl4R9NAzI/MzPQ8hBvW5N5NbyRcdYH7k40mWoY0G1umr4W4mXHmfZ8Xov
         FqC6+KH+7fKkvRFmaB6eS03tXQYFbLbYSs2k0YRFQB1q9SL+h2BcvFTRbtpWkdd2loHc
         lELkd8nONqrFylwg090dXMzLiSxbWiopYL0/QXJCcpcDeTnHn32N2ASe+kr1mq//Ie4U
         H0JNbUFwfqp1rzm7Cpbe3T9k6NGJIOIQ9zu9f7mRT7BrqsyeWZqczbWy9ZPJMb5zF7XZ
         lr2w==
X-Gm-Message-State: AOUpUlHt6GL85v7ih7mfVvxnM/ka7souFKhQ9jW6lnmSQxikAXWYfoBX
        g6gftBgWuonIKxb+Vhr8+y1H08wp3Gw=
X-Google-Smtp-Source: AA+uWPxTWaBHz6dASQnMTzT4AO3FDHJv0UGSMxw4Hd1/P0wS4TAa5HEIHxKfJj/9/YQeVWunIRDmXw==
X-Received: by 2002:adf:f148:: with SMTP id y8-v6mr23830861wro.134.1534530907349;
        Fri, 17 Aug 2018 11:35:07 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:35:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/10] staging:rtl8192u: Remove unused CHHLOP_IN_PROGRESS - Style
Date:   Fri, 17 Aug 2018 19:34:44 +0100
Message-Id: <20180817183447.15993-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro CHHLOP_IN_PROGRESS is never used in code, so has been
removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 5ead032735a6..831a85bdbd2e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -44,10 +44,6 @@ typedef enum _CHNLOP {
 	CHNLOP_SWCHNL = 3, // Software Channel switching in progress
 } CHNLOP, *PCHNLOP;
 
-// Determine if the Channel Operation is in progress
-#define CHHLOP_IN_PROGRESS(_pHTInfo)	\
-		((_pHTInfo)->ChnlOp > CHNLOP_NONE) ? TRUE : FALSE
-
 /*
 typedef	union _HT_CAPABILITY{
 	u16	ShortData;
-- 
2.18.0

