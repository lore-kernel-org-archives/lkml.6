Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4210AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF413208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrJR0ktv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF413208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933905AbeGJPHD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:07:03 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38453 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933445AbeGJPF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:05:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so2222360edr.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4WCt2k8gz2kpRM+pL+yf/yDI3vrKy/0LNv3D/4aMqKQ=;
        b=QrJR0ktvCP0mbgoFmSI0ckL/5IoxbeNGZzJv7O4SkdZaZeT1eSK2rcZrKI1T0vDIeB
         shxWk2LNmKvJcIXuDE2x3vDVv9RfuRDVY3J3hPHTu1bk3KQUy5VHaA5IYCKm4Db9qZmY
         wxOhiwtACwUMHDqe7yETHb7zeAbYS3jBjYK+UtY/lxklZfTvXIj3pjcf9osaVChidnJm
         iIw7bgtXbOyMC+qbzunWM9M714O451FdQAiD1JmO0IQZnwfNh+9Wj36k5q1SK9oNL0z8
         vXm46Yt8n1oWV3cyskYhTWNWcDK2Z5j99dp49z+iffgRLTz0Yq6KXGlajWztvcspAzHz
         3ztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4WCt2k8gz2kpRM+pL+yf/yDI3vrKy/0LNv3D/4aMqKQ=;
        b=kWjWTs7xi+cFjxbGjhRCH11tPinci33u4AZXiMYxwycj2FdOtXZQDLpqtqld89Nx2u
         I6dnXwUfGnnSGDn0PSfRXn7VAbTvfPmQb3E3fJHaXcdanV6vFXQbz8lKOaTwyjHzBjry
         kEav6mOf0doCrZ2RLyKm0nKxfY8Kg47lovY0P+6pZ4UDJ9DhgLt9/Mmm5trG1ClWX7Nt
         hg313tP+DzvbmViRAIF4vAv8lkQ0YEuFvWMmyR67tgNGag+SqFtS3GBgYqQHpAP9cxI3
         gB2OCsriT30D46h7UN4eHcJ+IYNm0Zb0Ab5BwSm+YJfoH/voNNBBEEzWAFmM6E5NagIH
         t0Nw==
X-Gm-Message-State: APt69E0B86y2hzC4pW5pKu0UBlUmDmoSxYXTdx9aVaaEjHXTV7EzOQ/S
        m611mul9mm2uNBxkl0lPPn8JTwpy
X-Google-Smtp-Source: AAOMgpewO8NjkSJKccomMz9JJI4T3bqBz+2GPdjqrI3Ypp2883HuEV1H8XL4rLFWGdqrnjevoGKOzA==
X-Received: by 2002:a50:8ee4:: with SMTP id x33-v6mr26261087edx.175.1531235156738;
        Tue, 10 Jul 2018 08:05:56 -0700 (PDT)
Received: from localhost.localdomain ([109.76.156.5])
        by smtp.gmail.com with ESMTPSA id s19-v6sm1895389edd.53.2018.07.10.08.05.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:05:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        aastha.gupta4104@gmail.com, keescook@chromium.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 4/8] staging:rtl8192u: Remove prohibited spaces - Coding Style
Date:   Tue, 10 Jul 2018 16:05:19 +0100
Message-Id: <20180710150523.17384-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710150523.17384-1-johnfwhitmore@gmail.com>
References: <20180710150523.17384-1-johnfwhitmore@gmail.com>
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
index 7bec24d0a234..64d7980e7e13 100644
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

