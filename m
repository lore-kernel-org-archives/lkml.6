Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D6C520841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 21:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nuuu44KJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D6C520841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbeGaWnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 18:43:12 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39646 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732620AbeGaWm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 18:42:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so5851276edi.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Q3FbYtmfl1vqQHVR2kUwfLeQ0/04JuB1WDqhwp8ALM=;
        b=Nuuu44KJ/wPytEeWsZxQ1gIiuqVLo25JkXH67/PiNIRHNdLwNHLzSfAu1crG9X1tzh
         7E9k5O+4OoMGKQnGJQKvzWIPJ5PrQCRapf5ZFBmh529K95flLaqVshgqvzJQFoe5u4HL
         FVMEi4GjkkbwRxWdC3gSl9cnSsy/XgDNIHi5+zGaV2A2h2ToQzdhqV/eNXuWpE9gZWtg
         P7s69Bw/iAvv7a1kKKDxgV6x5bSu6vEywSoAeMur+KhtXTBQ7JY1CsQPAylsxgqNkZWC
         v8QnbMdXA6N/btc0jfMeUu72i0efwcMYemgHG4W/xcId+9PDWg0Cx+7A6iq2jz/MlYGg
         b9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Q3FbYtmfl1vqQHVR2kUwfLeQ0/04JuB1WDqhwp8ALM=;
        b=BujeHMon31d6iBAp+o29CGFcYWG0i2IXp7iqH4Z3C2bNFCQBdiaWXJvKXpK7UtexAa
         pgTzp0YMvzXPKl7Ky5HEoqmUGDhZ1BA+98H+xhslOdBb3lLz9+LXgj4+d9VDml3i890P
         N7H8/yjssNqk4agxAk+JCU0AmbXJu/LIZsJuaSDVMsA2pjUyrg2bm5YFaXwlqYUNggIx
         Vlh7Ss+n/bfThCeZdqXhJ21SSVnL2eWO+rsLN192w0W0ecoL+AsZuB4VprXMJ0DxDM4f
         /Vy9+uWXgTLrBwZi87pqJSyKsvJ8cren5nMK347mDXkkfsO2UPQ0pFKFMMbL9cow1C7s
         7LjA==
X-Gm-Message-State: AOUpUlGPqMRmXebV+kLelU1NG3pdQgCKOqR4Hmi89CTdy9b/gpZqYiX0
        lX7sWVo9V+fTTB6UC2Tv/xoeVOjg
X-Google-Smtp-Source: AAOMgpcGZ2sa84gh/IJDsruY/E7gcLxKkKD2L4IDPnzN/5h4QhGHB4o5eq8LoLEAifsmulxQl7z3Vw==
X-Received: by 2002:a50:bb65:: with SMTP id y92-v6mr1172733ede.10.1533070846234;
        Tue, 31 Jul 2018 14:00:46 -0700 (PDT)
Received: from localhost.localdomain ([109.77.253.253])
        by smtp.gmail.com with ESMTPSA id j42-v6sm4143373eda.2.2018.07.31.14.00.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 14:00:45 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 12/14] staging:rtl8192u: Remove unused UP2AC - Style
Date:   Tue, 31 Jul 2018 22:00:03 +0100
Message-Id: <20180731210005.17452-13-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731210005.17452-1-johnfwhitmore@gmail.com>
References: <20180731210005.17452-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The macro UP2AC is commented out of the header file so the macro and its
associated comment are removed.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 50b05ee52210..59a60f86607c 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -77,9 +77,6 @@ struct octet_string {
 	u16             length;
 };
 
-//Added by joseph
-//UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSCP
-//#define UP2AC(up)			((up<3)?((up==0)?1:0):(up>>1))
 #define IsACValid(ac)			((ac <= 7) ? true : false)
 
 #endif // #ifndef __INC_QOS_TYPE_H
-- 
2.18.0

