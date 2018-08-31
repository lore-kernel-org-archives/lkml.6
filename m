Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3013EC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF222083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERcBvEs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDF222083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeIADMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:12:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50650 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbeIADMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:12:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id s12-v6so6534726wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bLEMW4E9I6Bj6oEzTvezv+N1GmIvRFJ4RBup0zti1U0=;
        b=ERcBvEs8TUOn+BGS27dQ+3Sm2B78jAjDZT/RTy6W6pxqG0gzaFc9E5wazKxC5tUIkb
         AXY3FDWthPTCjX7QKWB95uAfauMgO6xvy21LxLw+jMuJCx69g9HrrI3bwZtcracmRN8e
         nvM1FGkkquEua9UxTl3XnIpEZQrfbbQnVS1M8TWL6XSqcA361HfyksBGzFoVox12qnLh
         ZgVLQbTNncyprugY1gmNHzX01Lpgem1BYFg0Ng+IQLhXbbzQYuZ4GPQPxg9gX0Bmjlcl
         8ML18KWRfWBXJalcHo3LZZlLyElpCMmbVIjKlPm2xN1gmFktRXMd2arSGH0Ji7Nesa/p
         d5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bLEMW4E9I6Bj6oEzTvezv+N1GmIvRFJ4RBup0zti1U0=;
        b=pDKOSU6GTWL3mnJZqne+5f8U5G/hlE5I6eoTnCXX9v80h6p4PXIXFVdCTHfRtfov/C
         CtaTlzHuTzttfxj8nETGO+I+O64v77bwezFpyqa1VJaoiMFGse1X/E+/+PzlhZmDq+5F
         Npnktkegn/f/GMEJ7W3wtwMNkD00NDwEZEMOlTl7ZrixCT1vDqBHpv+Iutt0hmiSI2bp
         FngxZy/3PFeTYHT7TiqYp7d+pzL/ndPWT+8x/AdMZ7D834XVw+XY11oX0lct4iEkX19V
         1AZHiBmJOrfB4lvJvITYc3qByRRs6vslpI6p5MBGvoIOsk3AvRXp9IAHJ5LdWAKUYx9D
         JHcQ==
X-Gm-Message-State: APzg51C/gKFKOvR2c+CUrilTSk9kjPnEqITMsloh0A+ZPQUed8DB0yzG
        eiYfCTtzlkXFDivfUKQy2a/MqVNtWN0=
X-Google-Smtp-Source: ANB0VdZmA4OqicF1apPmbOkET0Hvczp0VFw8ll3hkjf1ZSHKK1ApKyyJoSg7TO5+WdFbOsspv5BEsg==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr6170038wmd.92.1535756587755;
        Fri, 31 Aug 2018 16:03:07 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/20] staging:rtl8192u: Fix space characters - Style
Date:   Sat,  1 Sep 2018 00:02:38 +0100
Message-Id: <20180831230250.16810-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the spacing issues, remove space after cast operation, and replace
spaces at start of line with tab.

These changes are purely coding style changes to resolve checkpatch
issues. There should be no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index c613894a6088..e65a893fd084 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -112,7 +112,7 @@ extern u32 rt_global_debug_component;
 	do {								\
 		if ((rt_global_debug_component & (level)) == (level)) {	\
 			int i;						\
-			u8 *pdata = (u8 *) data;			\
+			u8 *pdata = (u8 *)data;				\
 			pr_debug("RTL8192U: %s()\n", __func__);		\
 			for (i = 0; i < (int)(datalen); i++) {		\
 				printk("%2x ", pdata[i]);               \
@@ -877,9 +877,9 @@ typedef struct r8192_priv {
 	int     rx_inx;
 #endif
 
-       struct sk_buff_head rx_queue;
-       struct sk_buff_head skb_queue;
-       struct work_struct qos_activate;
+	struct sk_buff_head rx_queue;
+	struct sk_buff_head skb_queue;
+	struct work_struct qos_activate;
 	short  tx_urb_index;
 	atomic_t tx_pending[0x10]; /* UART_PRIORITY + 1 */
 
@@ -1027,7 +1027,7 @@ typedef struct r8192_priv {
 	u8	nrxAMPDU_aggr_num;
 
 	/* For gpio */
-	 bool bHwRadioOff;
+	bool bHwRadioOff;
 
 	u32 reset_count;
 	bool bpbc_pressed;
-- 
2.18.0

