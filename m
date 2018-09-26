Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15299C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD82B21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as1FyHLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD82B21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbeI0BdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:33:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45162 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeI0Bbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:52 -0400
Received: by mail-ed1-f67.google.com with SMTP id h6-v6so1410634eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NCSUFJZohHLws+CYE1ij+yY7M5ODKZmuUFyNy+inoTk=;
        b=as1FyHLKB1QeC/nFLPPX5ucss5GsPNu79ByIvIicDqPj0awH04LaHIYe/IxaiHTz/X
         QK1F3wd8civ0fEDlqD73mjvLGaTNIADktsQHWRewDDH4+aMrSwHFKZOt8o7GV/i+3msW
         LfRntWJViN8aPRFr8EktvnXlKm0Zvz6FMI1hjvZ9+7iGPiB13Dm1zTaJnhHBmRlDw8oU
         /PZclQJWWo7BKBQ5n5jHDEpM4a1fBfsKEF5F6YKrXq0Cn212zLqLKtcuCZ4HID8kUeBI
         He6y3a6hv4IIVezzknUa6acjMJy6GawrUaP5OZFCfL+wVRwSv7CeH/0j+V8wcWcE1lN3
         u+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NCSUFJZohHLws+CYE1ij+yY7M5ODKZmuUFyNy+inoTk=;
        b=c1n3MfBj7t8+SPDgpAO3waq4NKni17Ac5dsxCrzkNfAUUSSSY4pUTYvotIFI22PFHi
         z71qdogRleB/fTEfyzGXf74PACO5pTXJ4AaRBixOr8llGV+nDa/Q6n9lSfa2YuXEilwG
         mO9I6pI8+EFRRdJTSAY921lpA2MS0FeYyjnsjoz0ccRyos4Apxye9Zt6XLLhIeEgy4D6
         ndnUfjm1EPfxcBcQaycws7zUZnFXpxqG8m7n29kbn2j05GMvlyLpKEq+OIH+yCKvZgCl
         FaKPzOm4X68FdQmzuDY7lJs3uXtDO0/yHHmxhvkwY5NSb6iordKLzm0PuIG/Iw5Lps0o
         tjaw==
X-Gm-Message-State: ABuFfohl8kkcGUTVVvp5AXYIRFBS1qS7xFCxtQvG1AA6fp323/MD6Jpn
        pjrwM6mlLxksREEh7j+YsTUkft0y
X-Google-Smtp-Source: ACcGV60nDPbNHC/6OPCmX6GDkehG/G6as7C/MkopekQBAK4OjAz/R59j0NzEzBcnNt7U7meu3jS8KA==
X-Received: by 2002:a50:a166:: with SMTP id 93-v6mr11699804edj.184.1537989446036;
        Wed, 26 Sep 2018 12:17:26 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:25 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/13] staging:rtl8192u: Remove definition of HTSetConnectBwMode - Style
Date:   Wed, 26 Sep 2018 20:16:54 +0100
Message-Id: <20180926191704.16322-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant declaration of the function HTSetConnectBwMode()
as it is not needed in the code. The function is already declared
in header file, multiple declarations add nothing.

This is a style change which should have no impact on runtime code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index ebe8d527a080..977a1e5c9b52 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -837,7 +837,6 @@ static u8 HTFilterMCSRate(struct ieee80211_device *ieee, u8 *pSupportMCS,
 	return true;
 }
 
-void HTSetConnectBwMode(struct ieee80211_device *ieee, enum ht_channel_width Bandwidth, enum ht_extension_chan_offset	Offset);
 void HTOnAssocRsp(struct ieee80211_device *ieee)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
-- 
2.18.0

