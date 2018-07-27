Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C9C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED6F8208B4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+lbkOgW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6F8208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389415AbeG0SzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:55:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45127 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388951AbeG0SzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:55:01 -0400
Received: by mail-wr1-f66.google.com with SMTP id t13-v6so5791926wrv.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S/mH10gOqvOaVJXu+pBbWWWVxx9HQaypLr0KM4PKe2o=;
        b=E+lbkOgW+ERc0tAazLRVAspjBoK84KwrZQEMIrhB4S5a6xPC0xU/HQQ8GiRtonaRi/
         kAwH3mdKUM7sOdEPzzRykEkUHU1a+GdMoB5OrLEv5GgcKZC9oGfz4lZDLiGRGuxXuqJT
         kXSZpfO1OF0NzoRrNlJDnOQuhEm917ay4wG1ksHqT5cCRBiuRIdCsmxEEyKkFLQMo4Fk
         7P6gYWmCvcqNSDPtiI+qnxMcOMl7u0l0eoX69q1KSW7OILfGbhyGdypok6MQImqA5fxJ
         LEnGKn7RDL571qQDO+eiZuMj+QQqxQuN5lt9Xr300T/fuWwVkppfNTkO70FFhyPSlmeF
         bcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S/mH10gOqvOaVJXu+pBbWWWVxx9HQaypLr0KM4PKe2o=;
        b=RVDQG6eKEe8qhN32x4B+3BCDgaaVf+TVYX5+0g18HsI+iO4sf9lHakB7F/mSyXyJjp
         2VpVpl+YtMx8MnzFuMfvlIdDBLjrKVeAnKTKq3nkJEX9Mqo+6Kcgrun9X7Pw/zt5GssQ
         T9QA2Fi/nWfymfJs4ByYJ9N1Mte/ntJ4mOs8UVzrjDwqwAwdFv9KU1dzH1YkWlCqIeyy
         jFLrXQy0fgGweF3wi/kRlqIrcKuhLS9wDbMrD/3ENc5kTlC776Kt/TT9YQFBzvQVmyZP
         atS/Up7VBwdqtG6VSLASb8hS5PlrlnD28yzT+GAB25HXml38Il6ZKmLoz21zoxZeWJG3
         UH7A==
X-Gm-Message-State: AOUpUlE7nM1EbEhKdFbIOYw0QpyhEx74OA32yjQRFMX6ys3NxHO7F27c
        jkvzvY4JlxpB/2W1q0jURI/r+ox/4nA=
X-Google-Smtp-Source: AAOMgpcYnOxN+e07KPXmjE3LT7WXdOWLeFImZzdiBCfiRJrUFcpge88Pgnbh4EkzGElmhgFFd1NO/w==
X-Received: by 2002:adf:8276:: with SMTP id 109-v6mr5836800wrb.127.1532712727139;
        Fri, 27 Jul 2018 10:32:07 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.32.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:32:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 19/20] staging:rtl8192u: Rename RxLastFragNum - Style
Date:   Fri, 27 Jul 2018 18:31:22 +0100
Message-Id: <20180727173123.27391-20-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727173123.27391-1-johnfwhitmore@gmail.com>
References: <20180727173123.27391-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable RxLastFragNum to rx_last_frag_num. This
change clears the checkpatch issue with CamelCase naming.

The resulting edits are all coding style changes which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h   | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index c0c746bfd390..28cae82d795c 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -1028,15 +1028,15 @@ int ieee80211_rx(struct ieee80211_device *ieee, struct sk_buff *skb,
 				true))
 		{
 
-		//	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->RxLastFragNum is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pRxTS->RxLastFragNum,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
+		//	IEEE80211_DEBUG(IEEE80211_DL_REORDER,"%s(): pRxTS->rx_last_frag_num is %d,frag is %d,pRxTS->rx_last_seq_num is %d,seq is %d\n",__func__,pRxTS->rx_last_frag_num,frag,pRxTS->rx_last_seq_num,WLAN_GET_SEQ_SEQ(sc));
 			if ((fc & (1<<11)) &&
-			    (frag == pRxTS->RxLastFragNum) &&
+			    (frag == pRxTS->rx_last_frag_num) &&
 			    (WLAN_GET_SEQ_SEQ(sc) == pRxTS->rx_last_seq_num)) {
 				goto rx_dropped;
 			}
 			else
 			{
-				pRxTS->RxLastFragNum = frag;
+				pRxTS->rx_last_frag_num = frag;
 				pRxTS->rx_last_seq_num = WLAN_GET_SEQ_SEQ(sc);
 			}
 		}
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
index 0bf877162a8f..aaed1dab7100 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
@@ -45,7 +45,7 @@ struct rx_ts_record {
 	struct timer_list		rx_pkt_pending_timer;
 	BA_RECORD			rx_admitted_ba_record;	 /*  For BA Recipient */
 	u16				rx_last_seq_num;
-	u8				RxLastFragNum;
+	u8				rx_last_frag_num;
 	u8				num;
 };
 
-- 
2.18.0

