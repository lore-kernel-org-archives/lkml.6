Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FB7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD3921533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDX8WRia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DD3921533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI0Bbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:31:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45158 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbeI0Bbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:31:51 -0400
Received: by mail-ed1-f66.google.com with SMTP id h6-v6so1410561eds.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DXZEF5FxIFMbB5YRdkM+tEUB8L3RNw3yDhszAEdona8=;
        b=MDX8WRiaMl643Ipz9+bdrZ4Jv0RT3536yXn341CsN6rEL49jmouYm3ha9ywrITYWCq
         1Us5LdImCfB+D2U5Mt5GAs2w0Gtl32mCrfun6NUgFtjPJajzETamOOfVfh86Ya8sroXO
         T+PxNBVjG/1b7tLP01DjDLuP6jwZnCJuDl8L84HxIOiA4eNFhKQQyPq7XNfp+MrRihj+
         OQt2WP/XMFyeNlVVmfn6mF18MiUzSxq6sc5zI0NXrTQlfMr3tQZ5h+9rcxU/3iRUJzIr
         XcuWXb2sLnKRBPAbiXv9BGP34u1xapxYnlY2MLZLkqQwQdj2lSTg0JIDwlhmtLoQUU3u
         P4qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DXZEF5FxIFMbB5YRdkM+tEUB8L3RNw3yDhszAEdona8=;
        b=gj+3m+XaZXVmBU51fJqh/93nIR1A05yFfAIZVuN37sTtgmCC/tXTKzjmC1RP8X4ky2
         keRp1BMeO4dBS3jGK1Zs5jjdSQpzz4vbeHYW8o3QJzUS2qI11teHiMKSw6tpnHuxZVf0
         5WVtFOPxrZ2FNec6ytfDyr+UN6Jiziec+A5Oh77t1TnMAYI2BOiCTaYzGYuT+cMzOYuz
         GLJcyXzi/FIyzuJdDMdD8OrjNb2H/1iR+DyyDTUNIM+N7B2IcSroS9fknXgojPM3XVVv
         cJcmNh6RtJu4+uD7IaCqpdD6RzGnZChlSQqUY0MPMLrSSvvHaCLDArdiBgFW2gmwr66q
         lWvg==
X-Gm-Message-State: ABuFfohlNxYCPCtOm7FAKvTIEA+KLHUMWRZZ6TxXOMfrv2pu+5HutjBD
        dg6I1ZbNrrwwmDQrweYC3675mCO0
X-Google-Smtp-Source: ACcGV62JjoK+YTdQTUhX3GjOswRCaYuMqpIX6124zWkAIsgMWTTXO00TDhxuiiG49WrRYOF7naCHvQ==
X-Received: by 2002:a50:f5e1:: with SMTP id x30-v6mr12181681edm.132.1537989444579;
        Wed, 26 Sep 2018 12:17:24 -0700 (PDT)
Received: from localhost.localdomain ([109.78.196.57])
        by smtp.gmail.com with ESMTPSA id k13-v6sm91417eda.72.2018.09.26.12.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 12:17:23 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/13] staging:rtl8192u: Make HTMcsToDataRate static - Style
Date:   Wed, 26 Sep 2018 20:16:53 +0100
Message-Id: <20180926191704.16322-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180926191704.16322-1-johnfwhitmore@gmail.com>
References: <20180926191704.16322-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function HTMcsToDataRate() is not used outside the file in which
it is defined, so has been declared as 'static' and the prototype
removed from the header file.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211.h      | 1 -
 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
index cc694e567040..8c91cb29fc9d 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
@@ -2382,7 +2382,6 @@ u8 HTCCheck(struct ieee80211_device *ieee, u8 *pFrame);
 //extern void HTSetConnectBwModeCallback(unsigned long data);
 void HTResetIOTSetting(PRT_HIGH_THROUGHPUT pHTInfo);
 bool IsHTHalfNmodeAPs(struct ieee80211_device *ieee);
-u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate);
 u16 TxCountToDataRate(struct ieee80211_device *ieee, u8 nDataRate);
 //function in BAPROC.c
 int ieee80211_rx_ADDBAReq(struct ieee80211_device *ieee, struct sk_buff *skb);
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
index ea1261e33a68..ebe8d527a080 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
@@ -216,7 +216,7 @@ void HTDebugHTInfo(u8 *InfoIE, u8 *TitleString)
 				pHTInfoEle->BasicMSC[1], pHTInfoEle->BasicMSC[2], pHTInfoEle->BasicMSC[3], pHTInfoEle->BasicMSC[4]);
 }
 
-u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
+static u16 HTMcsToDataRate(struct ieee80211_device *ieee, u8 nMcsRate)
 {
 	PRT_HIGH_THROUGHPUT	pHTInfo = ieee->pHTInfo;
 
-- 
2.18.0

