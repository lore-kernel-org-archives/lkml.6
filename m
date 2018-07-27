Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DB2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941DC208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKP3lRVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941DC208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbeG0SzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33131 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388886AbeG0SzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so5812010wrp.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4y4cABAORtbftN/zU/G1hhIjCxvy9hXquTavdOt4Bm8=;
        b=FKP3lRVF7GX8TCbFiXWNxcMmHw9IDUJS1CsVTgKAOD9PpcO03xfc6TMQM6rj13fqub
         N0iDGHgkf0OkHFf16E/y8LpOJ33tr323Dx6nZDi9r/N3aRsJNG/e5cW5X+JGpgOFmPEF
         xsOmxFclN0Byvxd2UsNdWUg66Uw/+nCDbzAlZQwwRCb4Xj5P6hIr9w3bXM2Y/TDjaECJ
         dauKHmt6la36i61CIcxh0+B6D61cCRrtoLhzNNJ/krjP52VJ6SdiNJSYZXwLSffCJKq/
         sbQ+uV6UuP49pGUiKAvVSjYpMGub1vpJv7wdBXkBeFeJ7ukiRrfzYwwpreJ/NmssxvQQ
         mcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4y4cABAORtbftN/zU/G1hhIjCxvy9hXquTavdOt4Bm8=;
        b=dO0Qd3XH1u00qItEumVk1vvhyRCC4Y30TbpgszrX7pvXDmf52G3ccS/UAX1dw4w81a
         q7cBbdYszE7CFL6sxayi9D/AAc8h9UoKQ+06Ex4tGMKebwzYzKSqipiBsMCB03AXg/zN
         FlnnzhY1q8X3kJm/2aozRjHYKkheTYa/y21/kFdqCr+hYBuxn4cd57uVttL6P3WosdYn
         xd0ykxJE1pm6/UmOuxkwaZPK4wnDC6SdcBnBDIYY2NjjsSmSOw+qyQ5VNGXrDj9wbhBX
         RfDOkhWSRni7HnD1CYKFjXoSI9bivUY+gc+c8jDKWkf2LW5GlcL1qrEcaM0GNER8DmLb
         EwyQ==
X-Gm-Message-State: AOUpUlEmFicbvLmkqm7BRejd2HOPirBlGerfS9lc1V4wLGFkoeL2ABPH
        nyHJzIXpSWAJ+QcHjnYt8xCSZvBPbeU=
X-Google-Smtp-Source: AAOMgpdV5tBMQHftZ2v02kGSahSdbrFAqyEfyAQfd2UuzhbCxq7z6484xZNu18vAsSjhskI3E2NzdA==
X-Received: by 2002:adf:fc86:: with SMTP id g6-v6mr5599949wrr.216.1532712728481;
        Fri, 27 Jul 2018 10:32:08 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 20/20] staging:rtl8192u: Remove blank line - Style
Date:   Fri, 27 Jul 2018 18:31:23 +0100
Message-Id: <20180727173123.27391-21-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a blank line to clear the checkpatch issue with use of multiple
blank lines.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index aaed1dab7100..f5e79853fe9c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -49,5 +49,4 @@ struct rx_ts_record {
 	u8				num;
 };
 
-
 #endif
-- 
2.18.0

