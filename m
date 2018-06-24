Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3570CC43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8129251EE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 16:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8cCGajw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8129251EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeFXQIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 12:08:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:32904 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755027AbeFXPgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:36:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id z6-v6so10330517wma.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MT2uFqBXz6lD5/6nAK7r+pYbCGG3WuvJ0V3hIZDp6iI=;
        b=R8cCGajwyhRvFdNVxMtM8mZuV9iPjsS1Yp/KcLNgHYtIQ9UI5oaeuOsiSVA4EwsE96
         8miTrhFvwQsExGzv8NC/NGZhraP/zc2N2WPz63j76POS+rSYwZqwPE8c/4PEvS6v8acX
         E//0yV6uMYrzQivfpKvxMG8+k9pTn7zjWHlz751XCwry4MbozehNBhslm7KMoNfvwwvG
         0dfUifCN61lqKaQZy7eivlKKjiQ2cRLKLChhUGl0Qy/95uJUD48GAW6zd6ZqLOkTETN7
         iInr+hUzpXfVwNaSfgTRfTxPS1ZM86lMV1QzLdrQU1q5q5CJ6UkwIiCqiW6BxmOHBP5V
         R56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MT2uFqBXz6lD5/6nAK7r+pYbCGG3WuvJ0V3hIZDp6iI=;
        b=F8w4z4LRU1W57nA996MNHaPsERfG2bjnLxEAVxf3UCpRZyFTcK1HE5Yqsi8gcj4NcJ
         gF+zBYSJ7LdBTNO2A4UbDb2IRSBrxQtsFAO8YPsHMfKbHpagFaBbvM6HArZlrkr+XoU4
         U6fqiDKHYwZn2RWBAlI60Rh50RKa0J1TStE5zkAo16lfEHsZVdXzqQ4QhYasAPzdVRvS
         LweoZS75mTuFZoVqtHLXBviFY3aJrDi/6DscEYEuRh9RoBlyi93W9hSRox0fhPbdFJpG
         /CFzpLk7YdH9ZvbFb2J64yu+3DP1P8nh13jsNW6OLAGkpquboC6kXx8CpczitAdQ666D
         2TmA==
X-Gm-Message-State: APt69E3w/1nQ2XMYRg2IMRJQpER2l/wDOJwinDQA5yfn6z2fnNViwAtN
        2aXx58IoM83m6dosj/7RqJYGPj4u
X-Google-Smtp-Source: ADUXVKJ+99YhkTD/cT4V4AiYXZsNm9VkUIDHcwQuqViQ9r8S6HNQptveZ1RaTrRceYGrwXACQnr3rg==
X-Received: by 2002:a1c:3544:: with SMTP id c65-v6mr3602281wma.32.1529854569430;
        Sun, 24 Jun 2018 08:36:09 -0700 (PDT)
Received: from localhost.localdomain (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j10-v6sm1505813wro.53.2018.06.24.08.36.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jun 2018 08:36:08 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v3 8/8] staging: rtl8192u: Correction of spelling mistake in  comment.
Date:   Sun, 24 Jun 2018 16:34:54 +0100
Message-Id: <20180624153454.27356-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180624153454.27356-1-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple spelling correction.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index 07259f108ee5..a54688b3d674 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -866,7 +866,7 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	/*
 	 * TODO: fill suggested rate adaptive rate index and give firmware info
 	 * using Tx command packet we also shall suggested the first start rate
-	 * set according to our singal strength
+	 * set according to our signal strength
 	 */
 	HT_PickMCSRate(ieee, pOperateMCS);
 
-- 
2.17.1

