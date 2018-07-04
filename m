Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A58C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB3B023E10
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 14:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n754yEDX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3B023E10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeGDOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 10:21:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54902 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeGDOVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 10:21:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so5996309wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 07:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UKtYOQlQmL8iVDgT7N7zbb37UHgWuweAbm/4SqPFP9E=;
        b=n754yEDX9LCatet1VDEfzW1+Xwt0xh5DZ06xzEEJHLQ/AmoXPmMSLWvXPsERuCHd+q
         LmXvls3R5TRoNr4jlwp4x8WYQ+gCak9sNXh9873rV1N3Na8Z3PULaco8HtoxLV7p+UAn
         5omTjF7naawYfG5mVMPMvIw7n3piexJUyPeR4dV/h6iWffsmppYwZ20EhwD882730HFn
         6wWMhcizsOIj0kGh+1g4dPwf3ynBhhc1x/Oq8A/ntHlE67FVnqTNAocfCqXvsSHq36TE
         WpcwCQUjglwtt2lszJ1dRCLixhYlHp6tBKgnkL6KEIiov7/nWyrSm3xqixM2nVLMH2Nk
         aiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UKtYOQlQmL8iVDgT7N7zbb37UHgWuweAbm/4SqPFP9E=;
        b=bcMjWqGmPVGRyr/JfdCYTGfAwh4bItFspJeFHMfhjsSKlpV5xFRpPJ6b57lQXYxY0x
         1zmQoG4tUFPdxTcis2qeONRT4OpGcV7oZ31bPfsSiFqOMnYUZK6a3hdIIwtuDcJElg9d
         sFfTDCZ0cDb9b+pq949L/4+7C+wRmSt3YQT5F0c7rDJucuIUvh09Ak3QSOzRYWC/I14A
         F0n1uWmLv8ciivQhX3uZ+4d+qtwY9ZDteBtsw0ETzUBp/SgG3jEgymiIMGF8/N3P6mYF
         8DMC1yAmQnwbnBkXNuJq7EHWnF9jzg4k0w+KfQpY2zmx6PnmL/1QdHjokXv9gg71dWFa
         5Ugw==
X-Gm-Message-State: APt69E28xvPZQ+fOqyobu5CnyR4ClO1xWM1TqDwJo7X58JAEgEUZ5xZk
        qKBQxG/P5wqMQ2dTVfCH7radLB3c
X-Google-Smtp-Source: AAOMgpeKpUkZ9QetmyZZVYaAF52tLANfup7urqVoULUcotlJcjnxc2p6sOJqf90cDLrxuLS21CiLbQ==
X-Received: by 2002:adf:e749:: with SMTP id c9-v6mr1799834wrn.143.1530714068054;
        Wed, 04 Jul 2018 07:21:08 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id s41-v6sm7109142wrc.5.2018.07.04.07.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:21:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, insafonov@gmail.com,
        baijiaju1990@gmail.com, keescook@chromium.org, joe@perches.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 2/9] staging: rtl8192u: Use memset to initialize memory, instead of loop.
Date:   Wed,  4 Jul 2018 15:20:49 +0100
Message-Id: <20180704142056.2179-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180704142056.2179-1-johnfwhitmore@gmail.com>
References: <20180704142056.2179-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replaced memory initialising loop with memset instead.

Suggested-by: Andy Shevchenko
Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index a549d9678214..abf55877331e 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -761,8 +761,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
  */
 static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 {
-	u8					i;
-
 	if (!pOperateMCS) {
 		IEEE80211_DEBUG(IEEE80211_DL_ERR,
 				"pOperateMCS can't be null in %s\n",
@@ -777,8 +775,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
 		//legacy rate routine handled at selectedrate
 
 		//no MCS rate
-		for (i = 0; i <= 15; i++)
-			pOperateMCS[i] = 0;
+		memset(pOperateMCS, 0, 16);
 		break;
 
 	case IEEE_N_24G:	//assume CCK rate ok
-- 
2.17.1

