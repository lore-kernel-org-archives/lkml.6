Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE799C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E89208C2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYxOksfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E89208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934535AbeGDMAp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:00:45 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46639 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbeGDL76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:59:58 -0400
Received: by mail-wr0-f195.google.com with SMTP id s11-v6so5064731wra.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+JJ/pcWypEpbWkjxTf5mb7l/3uw2Md6gxrVoEyh/RHM=;
        b=jYxOksfvD2zGD6rBBYYpoUBo2LciScFAo9sOobSjHMDaHMY8a6YguSyZTOAyhAtfs8
         eygrafA5RTy11UTkgIsblYBEToVWg9KomowQTb1R+ftgaY1t1OUc89mO/hvs46d/mbNz
         9sVMl/Zp0r7JdPiK2bpQ03Ydfs128+4VQTfqdM4Rc3mH7ldeccE2AZiwZbeFQo1miipR
         JLzHvZuEk7hlsgZNBt9rDoNRitZTlqvhRq0CO6LKvRuNgwZG6d2Pta/ok8EGd6tOV4OE
         QB1TSlMyhPJ7l1+yLtoTDqjaCMo1nRI2UCVeyMR3ZKxRRGJhBCgQ+P/CsFwGoxvmZOx6
         /y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+JJ/pcWypEpbWkjxTf5mb7l/3uw2Md6gxrVoEyh/RHM=;
        b=Rexj9I3+WhcieBTi+haRf30Au6ob/xcGL/+05u7TgzqdcBHE39RNaqx7hhITxMd0AW
         USLdd5t5DgvDpO+wm6kRyXEsaWofLLMOXeMnXMtOuOtIj+bA/X64CNQcneNaakmLCqc8
         wGSIk+X0Ym1wa1lqfg1ma9fuR5LG5jhAb3fO0sRWD77sX3Lcdk58KjHSEW5Z15yXKtnQ
         0t6eOCXXpQgNR1SxFfnguAhUFdOA4EKjkOAyPZNOXSuay5WOF0EV9LW3+so6NbTyYoYw
         fASCbESEYH548VWycjJ7P3uyAOfv6hDVyEnVY1SjFqVLdNayr3BxsPnjrUMAk9O5g6mh
         SilQ==
X-Gm-Message-State: APt69E1z/I0Xp55IKqQJzDtzn2nIgRFcyzySxTD5bIz1CpCOeOndSlqP
        4ZHNBlUMmMlwc1YC1GS3IxKEQm2v
X-Google-Smtp-Source: AAOMgpc1CXaLqao0GUSp06+QqgNvQQkwjn6B1Kbx3TMfZMqlEFToEesy0ehvaIfQFShHk0UX8Hvmag==
X-Received: by 2002:adf:b60d:: with SMTP id f13-v6mr1373840wre.186.1530705596861;
        Wed, 04 Jul 2018 04:59:56 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 125-v6sm6893985wmw.9.2018.07.04.04.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 04:59:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 2/5] staging: rtl8192u: Use memset to initialize memory, instead of loop.
Date:   Wed,  4 Jul 2018 12:59:22 +0100
Message-Id: <20180704115925.28024-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704115925.28024-1-johnfwhitmore@gmail.com>
References: <20180704115925.28024-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced memory initialising loop with memset instead.

Suggested-by: Andy Shevchenko
Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index a549d9678214..327557176625 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -777,8 +777,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for (i = 0; i <= 15; i++)
-			pOperateMCS[i] = 0;
+		memset(pOperateMCS, 0, 16);
 		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
-- 
2.17.1

