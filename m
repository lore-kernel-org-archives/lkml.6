Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F89C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5980217B9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoAw33lp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5980217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeHUUgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:36:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34427 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeHUUgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:36:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so6459830wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rcg48aX1+Fj0VIgTLyQixGMjvy6fvYD6IXVAuvOvZdw=;
        b=RoAw33lpOyamMarkJhSWqBnCn/+gICwbmwoZ/aIGaBVm5DLXEBZA7E1nYcBb0ePw6k
         cq4kWVqFZfNwA1igHNsJ14XLqH5zkHnfdHiK/8Ily9NrOSS/i4KNfx+aym1v62KPVEhY
         xuYkRQZSk2EJj4zRkbiWAqR423hksOpnBnJrNdBnaNaNXytm3C+IKXescBuswnCr3xpD
         jy6b99BJJGt9I3n1Ui4EVPa+g1WlTvmN9zBZHaW+XeebOxTD9fgYWPHh9NNr7Clxq8t/
         VEcAhpIG9fw/TkXu7DE99JFFxzl9/yXAVoZY4GwvBQ8tODJhr4IRyXoHaEKUls1cgBv7
         FwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rcg48aX1+Fj0VIgTLyQixGMjvy6fvYD6IXVAuvOvZdw=;
        b=txCtGwndFLraGjK/WcgvJRMZYjNIIbSHO+JPUF+D8uYwsAfsALjtPt71kLxmrBAL3W
         ibQiBsMwokC57Udunc5waL8z4cTiz7jZE3fVYrAUUhKV8itRKMGGdhUgF7ZUu/aLRhpf
         IsYy1Nf9IcL4/wUdRGOFjo8SJlsUGqNzef+fyTh8oYcPtFwq9G+FwyVksrdfbJXyiasb
         +cpxeMykGVk2U6ICywJN3nmiNlkWU+uuzAvMcKDyilGHQSKZO4r/XE9petRCY5ecuOng
         VzwaKrAw/fZcT8TBC1JkqUHMxeSo972pQf+LQ1Rrv7zqO7flfByxYVPoX5uNWmMNewif
         LZTA==
X-Gm-Message-State: APzg51BbU4Smo7eQZjYi5I2Ikc9CAcIXn8cEJj/HaYq9R73eSZt2xMqs
        G9MJmqvxs5wgVzFZY+nh8OKWx7Ol4Rc=
X-Google-Smtp-Source: ANB0Vdb/4zpjQEYXNIkfn6UN8bSSc/7Van2CdL9l7KmE98Vbj6qAVy7z0nASDwAkaiBKQGKHXP4JXw==
X-Received: by 2002:adf:ed88:: with SMTP id c8-v6mr6290149wro.264.1534871745293;
        Tue, 21 Aug 2018 10:15:45 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id 88-v6sm7564292wrf.95.2018.08.21.10.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 10:15:44 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/17] staging:rtl8192u: Rename ShortData - Style
Date:   Tue, 21 Aug 2018 18:15:23 +0100
Message-Id: <20180821171537.9330-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821171537.9330-1-johnfwhitmore@gmail.com>
References: <20180821171537.9330-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the ShortData member variable to short_data. This clears a
checkpatch issue with CamelCase naming.

This is a coding style change which should not impact runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h     | 2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
index 446de58f1849..ec9bbddca3de 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
@@ -23,7 +23,7 @@ struct ieee80211_ADDBA_Req{
 */
 //Is this need?I put here just to make it easier to define structure BA_RECORD //WB
 union sequence_control {
-	u16 ShortData;
+	u16 short_data;
 	struct {
 		u16	FragNum:4;
 		u16	SeqNum:12;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
index c1fe42e0893c..6a95b47aa595 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
@@ -93,7 +93,7 @@ void ResetBaEntry(PBA_RECORD pBA)
 	pBA->BaParamSet.shortData	= 0;
 	pBA->BaTimeoutValue		= 0;
 	pBA->DialogToken		= 0;
-	pBA->BaStartSeqCtrl.ShortData	= 0;
+	pBA->BaStartSeqCtrl.short_data	= 0;
 }
 //These functions need porting here or not?
 /*******************************************************************************************************************************
-- 
2.18.0

