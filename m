Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A0BC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F8922064D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oALH8UYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8922064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbeI0BcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:32:03 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38396 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbeI0BcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:32:01 -0400
Received: by mail-ed1-f65.google.com with SMTP id x8-v6so2899321eds.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z2ICw9r4xJVXtvWYnXgNjtsMO0uXzWQIAjWzP16IuVg=;
        b=oALH8UYqSj6xOi3YKb78B8mwZDUUlE2l+z5n+nG6dpUwwsLVQMEamGS6dLkm/6FFMu
         kW5qCmaVRiLBQ4p5DDKZWQmBx8X6DOY5EIHmdl1uuLi6pSwhUp2tlLccon5LydloVDvx
         TRxaY1K6PJGZwyy9/h+4JZ0LdQcxuVsQSJ9+6eIvXc5zbFU/Mje7iTUO7LwU20l5C5am
         or6F0H+6/1GYPWTSuCyyZgLYaYP0IH6d/q/sJFigvuCroPQmssSVnZEua/duI6lX4cKO
         YMEENY4N3gb+7O9cNmM0AiA/L8z5IlebVu50FJ86Mm2spPeR8xp0WCn+tTnrA3dDd/ii
         efGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z2ICw9r4xJVXtvWYnXgNjtsMO0uXzWQIAjWzP16IuVg=;
        b=EmqX1Vr0gg4kqECcwbw+hMlivpNGA4ni+LFMtHLVsUDqBzSFLQnHyT1a3eHNP2FKma
         X7hs/SYAyDFQF9c08EWaiRvlaTxEdAc9hnptsxwHAnEncJzUtZDoPlH87I8Id/B6lMrf
         e75iQq72JqeDPP+uvJCQ8WAVzyED1ymMsM7z3YAWiLlFoaSsKTkp+DofEQ3Bi3o94ECF
         bB9MG9v1HvjVUAD8LZy/2uiw3Xp7TsYpfs6oxY5l5zC83fCvIxF8T/GpSiSkCfU40NDF
         HhTWbMKQnQlSK26oHwCQ6albMtGkrMkAZ/Xc6smRq4ishtwrGGpXmJ1ReHS99vEQqseB
         rueA==
X-Gm-Message-State: ABuFfojIyPWqztTzJQ1VgrXFonrQUUeGPTesa/xlGGe/A9lZiXgT+Ldp
        LpFvmi2O7rBb0SXJ8n4dZmOVsVgk
X-Google-Smtp-Source: ACcGV62TwUvF19yMnNN8Fvx7uW1LiGOdilTCXX7djsIjR0tkmclpNwdFAUDEr5WhP4RUNLwKHZEdUA==
X-Received: by 2002:aa7:d1d1:: with SMTP id g17-v6mr11696210edp.163.1537989454748;
        Wed, 26 Sep 2018 12:17:34 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:33 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/13] staging:rtl8192u: Remove Rsvd2 - Style
Date:   Wed, 26 Sep 2018 20:17:00 +0100
Message-Id: <20180926191704.16322-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused member variable Rsvd2 from structure.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 4154b4e27e59..0c5ded7ad98c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -50,7 +50,6 @@ struct ht_capability_ele {
 	//MAC HT parameters info
 	u8	MaxRxAMPDUFactor:2;
 	u8	MPDUDensity:3;
-	u8	Rsvd2:3;
 
 	//Supported MCS set
 	u8	MCS[16];
-- 
2.18.0

