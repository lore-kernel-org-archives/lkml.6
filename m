Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD01ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14EC520661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 20:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BApqvhm0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14EC520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731712AbeGTVL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 17:11:59 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42563 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbeGTVL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 17:11:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id e7-v6so12330927wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kAJQgyAksk2UptS1QD8nyFnxFLJlfLzXEfaUdHt22J0=;
        b=BApqvhm0zQiXAlUW7x6RZ5Sdq5POKcVsd28CVAhy8NvKE4s18aZO+Jpf1S3BzErDue
         0vuT78ZRLQSw2ZI/+TIZAPdOEdDisuskabABaBADWCo/PBaYJNpqMwJDF1zfcej/yHSA
         IokH+oC+n/4xdDza4N0+jw4MilTBu+6KLFDgnbs96/LB3tQlD0FVTdsuUxKi/J57pcas
         S5kVbXRasooIkL0TkHkCmHqbDdqVrK6UpjUvIQrLqVLmVCHwr60GBOg4C5SM9AS/JaaV
         9Ith9tFFO9IWTgrJ4GZ7DpBMMMi1BvnxRkGedFel6SsqMFapKSM02EbRZ8xC8CxXCPWT
         w9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kAJQgyAksk2UptS1QD8nyFnxFLJlfLzXEfaUdHt22J0=;
        b=EedBrSx83cLOaJwqVaWbMeE7WjF1Daef9mxq/CrdC5vYxUV4rEQqPrFlFYnLcz04hf
         aTyR8cmM2Wb9H5WFokkpqEIrOLdb1a7MZ7YYhNks8e3sUrdKvGVqOGoZwLTWLoE6dBle
         vzckl8MwyrkEuQI833cagdeobNkk7zzbsraDxPYURF20LXF/4A4wwwl1PYqX522cx7wa
         AdH/kDu5cBveX3/P22g/YYy6ejaIXMbU1dSg+1pj1IV80T9wyz6uci61j2YBzeyTQwbx
         cWrE4kUCyHoJervGtYclEYcPOdtjSaPSUOGo8wkEboisvKOP1keuwKgLErKmkxD70Vsn
         h2+w==
X-Gm-Message-State: AOUpUlHnpEYDv4C3pUtovNW89YbrL2Jm5bwpFyDcB44AN6UAA+eqHUPT
        rv+iew6Q7oaCTAxmQecRQ1wUF8qZCaE=
X-Google-Smtp-Source: AAOMgpc8dMyi+YfG+SM+StfCv+k77meaveDCnP9/0ztCSC71COtBN61N+erFPGwBDq8L+FXLoos+BQ==
X-Received: by 2002:adf:a197:: with SMTP id u23-v6mr2597211wru.50.1532118126250;
        Fri, 20 Jul 2018 13:22:06 -0700 (PDT)
Received: from localhost.localdomain (host109-151-85-76.range109-151.btcentralplus.com. [109.151.85.76])
        by smtp.gmail.com with ESMTPSA id z14-v6sm1282628wrr.71.2018.07.20.13.22.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 13:22:05 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 06/14] staging:rtl8192u: Remove typedef and rename DOT11D_STATE - Style
Date:   Fri, 20 Jul 2018 21:21:34 +0100
Message-Id: <20180720202142.26312-7-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720202142.26312-1-johnfwhitmore@gmail.com>
References: <20180720202142.26312-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove typedef from enumerated type DOT11D_STATE to clear checkpatch issue
with declaring new types.

Rename the enumertion from DOT11D_STATE to dot11d_state.

These changes are coding style changes which should not effect runtime
execution of code.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/dot11d.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/dot11d.h b/drivers/staging/rtl8192u/ieee80211/dot11d.h
index 1b377faa53e0..9402c05cb24f 100644
--- a/drivers/staging/rtl8192u/ieee80211/dot11d.h
+++ b/drivers/staging/rtl8192u/ieee80211/dot11d.h
@@ -10,11 +10,11 @@ struct chnl_txpower_triple {
 	u8  max_tx_pwr_dbm;
 };
 
-typedef enum _DOT11D_STATE {
+enum dot11d_state {
 	DOT11D_STATE_NONE = 0,
 	DOT11D_STATE_LEARNED,
 	DOT11D_STATE_DONE,
-} DOT11D_STATE;
+};
 
 typedef struct _RT_DOT11D_INFO {
 	/* DECLARE_RT_OBJECT(RT_DOT11D_INFO); */
@@ -29,7 +29,7 @@ typedef struct _RT_DOT11D_INFO {
 	u8  channel_map[MAX_CHANNEL_NUMBER+1];  /* !Value 0: Invalid, 1: Valid (active scan), 2: Valid (passive scan) */
 	u8  MaxTxPwrDbmList[MAX_CHANNEL_NUMBER+1];
 
-	DOT11D_STATE State;
+	enum dot11d_state State;
 } RT_DOT11D_INFO, *PRT_DOT11D_INFO;
 #define eqMacAddr(a, b)		(((a)[0] == (b)[0] && \
 	(a)[1] == (b)[1] && (a)[2] == (b)[2] && (a)[3] == (b)[3] && \
-- 
2.18.0

