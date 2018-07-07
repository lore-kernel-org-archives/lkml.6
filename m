Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E49C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A04420862
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 14:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTdRhZ+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A04420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754180AbeGGOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 10:55:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40326 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753173AbeGGOzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 10:55:40 -0400
Received: by mail-wr1-f65.google.com with SMTP id t6-v6so6736007wrn.7
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 07:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=02mdg6x36hy1hfZdBTswhIH6/17rF6JIm+CYwoHnrIg=;
        b=OTdRhZ+FB3HNyZjFe+pKG4ol1xzTxVV5bJKhFiqWWKq77lNYdgnNIrI8DS3gjLHPWV
         GefGIoM70xRvHWj5w33+RTwpacqFUOqmgAJqbORYVTuu16nyus7YvXinOWhYMKpPOVK3
         6oWYppdQRJAMx4Lt2a+Ak9GCcOrPDa8t6jKUr0tQsrTPErq+W/669mSnrFXY6sFmaB1S
         iju/KKJYGeLARgfZR+BQnl5JffZGBCzNYOUqL6VAKUCa1L/hdSrPYKsCAk29SXz/Sflp
         ry4xXwzoCXxOMClLGzy00ZG1W/JGATKMyja95C8SZaoT5R/D/hjcKhBEbd4S7esHULpB
         019A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=02mdg6x36hy1hfZdBTswhIH6/17rF6JIm+CYwoHnrIg=;
        b=bDenXBjSATz3miaNXa0fFOa7Wb4dW/U6FIpkJxpZ8aZzYSL5uDchmQ/LvmxWVlZ4I3
         qUo6dJ1xFBch7eVCeAsLHnzbgqzS+Nd4cLrTwuh0iZ3AhCDY8pISyu7YTJVlo2bTIn9e
         cKtrnQHKd9WVQlRurHVcdXOQuYzFyHiCauO5gEM/I+x4quEnQ2hWyx8QFhgAMz4kvTUl
         ihDal4hq0iedVkaWjhoBdGhPD1ZKZ3Q8hKjZvwAGTvd4oLZX3QTxg+EAPSv1lVUZ3RYg
         UGfSZCuCyMZ1KRM2Bd6x1Yb/UAhfPfiUvnlT/1j3yHhV22JwLVPzZugvXIsct1ia1iEB
         bkwQ==
X-Gm-Message-State: APt69E3Yyrm60X/cC7+K15kVbF8HFPOXIo5f8CQ8dOArZzJGCXifv7GS
        qmpRRJahGhDMhLJREYrcJu2GWA==
X-Google-Smtp-Source: AAOMgpc7SndJg0v3vsiAtuTWu7gEz7LEu+wS3ssiz+Z2QbC4BDnxWIlwz6Dxj5pugn6aKKyCwtD/WQ==
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr9832494wrs.276.1530975339111;
        Sat, 07 Jul 2018 07:55:39 -0700 (PDT)
Received: from localhost.localdomain (host81-152-164-58.range81-152.btcentralplus.com. [81.152.164.58])
        by smtp.gmail.com with ESMTPSA id 131-v6sm20714923wmm.31.2018.07.07.07.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 07:55:38 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/12] staging:rtl8192u: Remove prohibited spaces - Coding Style
Date:   Sat,  7 Jul 2018 15:55:09 +0100
Message-Id: <20180707145513.15325-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180707145513.15325-1-johnfwhitmore@gmail.com>
References: <20180707145513.15325-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple removal of spaces prohibited by the coding standard.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 429b8140d3ef..6d62fc1b249c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -1073,7 +1073,7 @@ ieee80211_association_req(struct ieee80211_network *beacon,
 		// CCX1 spec V1.13, A01.1 CKIP Negotiation (page23):
 		// "The CKIP negotiation is started with the associate request from the client to the access point,
 		//  containing an Aironet element with both the MIC and KP bits set."
-		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |=  (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC) ;
+		osCcxAironetIE.Octet[IE_CISCO_FLAG_POSITION] |= (SUPPORT_CKIP_PK | SUPPORT_CKIP_MIC);
 		tag = skb_put(skb, ckip_ie_len);
 		*tag++ = MFIE_TYPE_AIRONET;
 		*tag++ = osCcxAironetIE.Length;
@@ -1202,7 +1202,7 @@ static void ieee80211_associate_step1(struct ieee80211_device *ieee)
 	if (!skb) {
 		ieee80211_associate_abort(ieee);
 	} else {
-		ieee->state = IEEE80211_ASSOCIATING_AUTHENTICATING ;
+		ieee->state = IEEE80211_ASSOCIATING_AUTHENTICATING;
 		IEEE80211_DEBUG_MGMT("Sending authentication request\n");
 		softmac_mgmt_xmit(skb, ieee);
 		//BUGON when you try to add_timer twice, using mod_timer may be better, john0709
@@ -1796,7 +1796,7 @@ static void ieee80211_process_action(struct ieee80211_device *ieee,
 		return;
 	}
 	tmp = *act;
-	act ++;
+	act++;
 	switch (tmp) {
 	case ACT_CAT_BA:
 		if (*act == ACT_ADDBAREQ)
@@ -2115,7 +2115,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 	struct rtl_80211_hdr_3addr  *header;
 
 	spin_lock_irqsave(&ieee->lock, flags);
-	if (! ieee->queue_stop) goto exit;
+	if (!ieee->queue_stop) goto exit;
 
 	ieee->queue_stop = 0;
 
@@ -2141,7 +2141,7 @@ void ieee80211_wake_queue(struct ieee80211_device *ieee)
 		ieee->softmac_stats.swtxawake++;
 		netif_wake_queue(ieee->dev);
 	}
-exit :
+exit:
 	spin_unlock_irqrestore(&ieee->lock, flags);
 }
 EXPORT_SYMBOL(ieee80211_wake_queue);
@@ -2315,7 +2315,7 @@ void ieee80211_start_bss(struct ieee80211_device *ieee)
 	// STA shall not start a BSS unless properly formed Beacon frame including a Country IE.
 	//
 	if (IS_DOT11D_ENABLE(ieee) && !IS_COUNTRY_IE_VALID(ieee)) {
-		if (! ieee->bGlobalDomain)
+		if (!ieee->bGlobalDomain)
 			return;
 	}
 	/* check if we have already found the net we
-- 
2.18.0

