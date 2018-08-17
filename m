Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA6BC04ABF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58E121A38
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dR5rx2TV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58E121A38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbeHQVj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:39:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38607 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727661AbeHQVjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:39:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id w11-v6so5268953wrc.5
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 11:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y07Fx71rjXSBrr2aTXVuZGdSo4oJSptJlSy///szYpo=;
        b=dR5rx2TVcE75RQIjmbaRAO7t/7+gklnzSrc6F9ISaso5RoyYVkxm8yoT3/pONPGO0c
         0th9EqddNt3ry2ILq5I9hPlZMsTEgO8vp3Mx60UFrzCZqNjYkAJzrJPNS5DgeJR8KEQ8
         aLITiLSbwjIydCsBXw/spcTu1JUR4GRb/MimAxxil+ewc/a89YtCMmjauPEoKzCJErt8
         RjpK+lCkbyzucIhf9bGJABwF/0u5kBlVRwaePIC+e+CMQB9/mU16f+soUpzcCNwOcN9y
         EfhV2MsTyONjJ0WPdhf4UGpYHDBVEX+3WEdnaFT+9K1S8miq6cEK3jaPVZlxX1idrhHJ
         MViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y07Fx71rjXSBrr2aTXVuZGdSo4oJSptJlSy///szYpo=;
        b=L+l3ADS34ZkPRiOjEYPybVWF5lFoPvlY4RaKFPJYiuHkGcSrdxoDIWX9w9RuOmaeLc
         8YCr/npiWgd8Tn31fKadrVCap5Uthe5R3TUraMS8gyXL3L+vYegm585ZzN+6IC7h+cxi
         pLuC+28N93lCniqLTeXFjVxPJUggTpynYSw3AeufXUUB6OXmUHcYLgBHSX7/r8gjaAVV
         Q897AKeQP4EJfwAORof2++A8KOPLampRdx4qCWh8xaRsvIOfxalzqTuG89ThYZCRqKcn
         FZgGqyAnpPHwSFQgfgX9lTa8y1E9DCGIkPhPInuSZVc05KQtIqw+pU64ZA//inF+AfLG
         VLNw==
X-Gm-Message-State: AOUpUlHhiLGP2W3xtMEnLK9wsppgocEx6QD1VC+EqFtIZV+MXHix8nU5
        KxoqUhBcRujuJ7fhUtGkbdVhi2mdlPA=
X-Google-Smtp-Source: AA+uWPy3vEyEmpp9MOKBIx6FGLKqLiFPAqR1CJK9UI8NYsLtE9/SYciQVsDr3jUpiGeSTfgymp+45w==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr23340648wro.279.1534530897542;
        Fri, 17 Aug 2018 11:34:57 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id z141-v6sm5399291wmc.3.2018.08.17.11.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 11:34:56 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/10] staging:rtl8192u: Rename sHTCLng - Style
Date:   Fri, 17 Aug 2018 19:34:39 +0100
Message-Id: <20180817183447.15993-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817183447.15993-1-johnfwhitmore@gmail.com>
References: <20180817183447.15993-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constant sHTCLng causes a checkpatch issue, due to its use of
CamelCase naming. To correct the issue the constant has been renamed
to HTCLNG.

I'm not sure this is a good name as it communicates very little and
contradicts the block comment above its definition. MCS_LEN might
be a better name if the block comment is correct.

Additionally the block comment has been changed to the recommended
style.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c |  2 +-
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h   | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
index 28cae82d795c..5f41b41c514e 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
@@ -794,7 +794,7 @@ static u8 parse_subframe(struct sk_buff *skb,
 	}
 
 	if (rx_stats->bContainHTC) {
-		LLCOffset += sHTCLng;
+		LLCOffset += HTCLNG;
 	}
 	// Null packet, don't indicate it to upper layer
 	ChkLength = LLCOffset;/* + (Frame_WEP(frame)!=0 ?Adapter->MgntInfo.SecurityInfo.EncryptionHeadOverhead:0);*/
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
index 7d54a7cd9514..0c6d6b352497 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
@@ -12,12 +12,11 @@
 //
 #define MIMO_PS_STATIC				0
 
-//
-//	There should be 128 bits to cover all of the MCS rates. However, since
-//	8190 does not support too much rates, one integer is quite enough.
-//
-
-#define sHTCLng	4
+/*
+ * There should be 128 bits to cover all of the MCS rates. However, since
+ * 8190 does not support too much rates, one integer is quite enough.
+ */
+#define HTCLNG	4
 
 
 #define HT_SUPPORTED_MCS_1SS_BITMAP					0x000000ff
-- 
2.18.0

