Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AB8CC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C6320891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g98B75O9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C6320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756865AbeFPPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 11:48:05 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33698 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754184AbeFPPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 11:48:03 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so6301049plb.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 08:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QmQWerMdO8XKmMjfwUJ+qFXRhXoKD+Yz6eOAMPMLwTw=;
        b=g98B75O97cyTD2fBcwyXFAzZt0WzLiOR7goQHZmA/SYOU2l4CiXApk8wLduSnH/Htb
         xlhJrwRig1QM6M6PcMH0w4Tm8CD8G45UNzfuxSfKAnAIUs6l5gpbkz8N1D6HFez0/FT5
         /S+HbN1QxRmUObZ4LFE3Jy/Aw2VKomZY0mgXyZjduQKT1XBtCOwp+1YtzqNr2Cz69Oxx
         TCixVfNuHsCzH1YelrOxPJf8vYhtfqJke315PBrChtTpaxbJzjYYPFRJtwobmh5y77Tg
         KI8csJkDrPnCYkn4HjhRjUsuYC6nD8bg6Kl1u5/VOB98JQ+C/lM3fp7LnhW7MxPDZAQ8
         diWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QmQWerMdO8XKmMjfwUJ+qFXRhXoKD+Yz6eOAMPMLwTw=;
        b=H6RlFHlsdWkIXCjaZEBGPqraGqvvY80WOG6ie6ZF6jebBllqWD+0dR3dk4EM+tT0EX
         3h4gJCKEvlUmuIgxYmDIGIVPnubreTMPO1QuZPEWTDBTqMj1ccFK83/1e3trI6PJmd3V
         mAJpFIgJfuWH8QKIwD2oEqR+M4pMAFabxhwPdc9PIrmCI5VFAQqNOiTlcqiF5MgnWsb/
         UabGClxXucotBz90Fay5uLnaVw/GI4UjyJQE56nTUXSPeSvi/W772a2sM6DEuk94Nw4z
         VqLB3o/ye5i44jXZrKfs5M6BWES+4U4bQPOWWyaYe6eKawLH4bxmTsAETKN7H6JD7kou
         PA1w==
X-Gm-Message-State: APt69E0u+5TTQvor8dDHEIwYZkzKZXqWCgjxyKCCcyJ6ioFllueT60cH
        E1ZakLFf7LmnnQK/pOsPWwY=
X-Google-Smtp-Source: ADUXVKKdOtFYrqtVCzQcii7IfWLw1V+s+YXYc+nE6WgJIgLgCokFf6f6+4TXEpZqcf1oWKJcKHW/oQ==
X-Received: by 2002:a17:902:2f43:: with SMTP id s61-v6mr6987256plb.274.1529164083469;
        Sat, 16 Jun 2018 08:48:03 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id z28-v6sm17486091pfl.169.2018.06.16.08.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Jun 2018 08:48:02 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] staging: rtl8192u: add error handling for usb_alloc_urb
Date:   Sat, 16 Jun 2018 23:47:50 +0800
Message-Id: <1529164073-63349-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_alloc_urb fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling usb_alloc_urb,
and fixes memory leaks in error paths.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Fix memory leak.
v2->v3:
- Release memory in error path.
v3->v4:
- Use kcalloc instead of kmalloc_array.
v4->v5:
- Free priv->rx_urb[i]->transfer_buffer and priv->oldaddr.
---
 drivers/staging/rtl8192u/r8192U_core.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7a0dbc0..9413f29 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1639,8 +1639,9 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 static short rtl8192_usb_initendpoints(struct net_device *dev)
 {
 	struct r8192_priv *priv = ieee80211_priv(dev);
+	int i;
 
-	priv->rx_urb = kmalloc(sizeof(struct urb *) * (MAX_RX_URB + 1),
+	priv->rx_urb = kcalloc(MAX_RX_URB + 1, sizeof(struct urb *),
 			       GFP_KERNEL);
 	if (!priv->rx_urb)
 		return -ENOMEM;
@@ -1649,12 +1650,12 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 	for (i = 0; i < (MAX_RX_URB + 1); i++) {
 		priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!priv->rx_urb[i])
-			return -ENOMEM;
+			goto out_release_urb;
 
 		priv->rx_urb[i]->transfer_buffer =
 			kmalloc(RX_URB_SIZE, GFP_KERNEL);
 		if (!priv->rx_urb[i]->transfer_buffer)
-			return -ENOMEM;
+			goto out_release_urb;
 
 		priv->rx_urb[i]->transfer_buffer_length = RX_URB_SIZE;
 	}
@@ -1666,9 +1667,13 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 		void *oldaddr, *newaddr;
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!priv->rx_urb[16])
+			goto out_release_urb;
+
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
 		if (!priv->oldaddr)
-			return -ENOMEM;
+			goto out_release_urb;
+
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
@@ -1686,17 +1691,26 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 	priv->pp_rxskb = kcalloc(MAX_RX_URB, sizeof(struct sk_buff *),
 				 GFP_KERNEL);
 	if (!priv->pp_rxskb) {
-		kfree(priv->rx_urb);
-
-		priv->pp_rxskb = NULL;
-		priv->rx_urb = NULL;
-
 		DMESGE("Endpoint Alloc Failure");
-		return -ENOMEM;
+		goto out_release_oldaddr;
 	}
 
 	netdev_dbg(dev, "End of initendpoints\n");
 	return 0;
+
+out_release_oldaddr:
+	kfree(priv->oldaddr);
+
+out_release_urb:
+	for (i = 0; i < (MAX_RX_URB + 1); i++) {
+		if (priv->rx_urb[i]) {
+			kfree(priv->rx_urb[i]->transfer_buffer);
+			kfree(priv->rx_urb[i]);
+		}
+	}
+	kfree(priv->rx_urb);
+	priv->rx_urb = NULL;
+	return -ENOMEM;
 }
 
 #ifdef THOMAS_BEACON
-- 
2.7.4

