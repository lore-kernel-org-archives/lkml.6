Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CBA8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5B8020896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KBkEwt4x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B8020896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936339AbeFOR21 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:28:27 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41414 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936136AbeFOR20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:28:26 -0400
Received: by mail-pf0-f193.google.com with SMTP id a11-v6so5172879pff.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MOu+hg0kC0/LmbXOgXK+4B7f3LeOOGkdlGyiI8CVpjw=;
        b=KBkEwt4xuLR+b36Tq969jT7E6pYuJQRGIrJe3Io7C1ArFkyAMQuYAo68SEL1mLRKG3
         6D/KVwa9hdoyWvjckfELnAP3qnuoY01lGrZZRBZ/RtEpy8GM83QgGln3LQCS/z8M9gkt
         wEfA30SrvFnILaG+VVJkzmkj8Dj0IPwZsNU4XHv/ZGo1gyuGhzcRRemMawCCpNqno9Uz
         HU1z3zuVY6TQL/eLaEnA7jyAeF6sJOZ6SSmdHQV2dEHWMetBWB1KV7kQD4IiqZTBxxdK
         6zhoUEDOYGXSaqNxgCJ0KBpC0vwIxyyZMXBYTLv+8urqpduiMgLxAbb6GXjn5F4ShPGY
         BI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MOu+hg0kC0/LmbXOgXK+4B7f3LeOOGkdlGyiI8CVpjw=;
        b=FizuQtHnZFwrGu5TuOUSOMMzU44FN4dnreoSyBsNI9pQ8WtZTeWJ7DOu2SiYjd2zp7
         iCp47Dxa3C+cMoPVOhew3eS2Ku1NfOoHyYxQV0idXx6Xl59mneuLCRxvzUN+8QjrjjPD
         YfvTO3uOiELoIUD/i5K+I939c3LeElB/pFyodG939oMirO+/AFedV7QcO9zpaosTBLZ9
         5r55gAa8XMJsmE8STgByN2hIeSDXGNGBp1EuV09gjIOK9d36SM8o6xz0WoASrTuNxV7f
         AqB573w1xxSSKJP4yNtF3dwC1MRrRYv6xinjJ1CfNMb31M3Bi2sL7QgBzVOFvfWFJDJW
         uLBA==
X-Gm-Message-State: APt69E1QpnLhvGe9mMThYvO0XwIjnDvbH+yhUg0pssXUXWV9c8H/tDvM
        qheC5qJE7BmbC1tZ6JNXo/g=
X-Google-Smtp-Source: ADUXVKJ6/L3Ef2uROAibbNI3UWWlMlzvD6rD35m6CIQGOvmd3iTU2T9Hzg85nFCbuYv2rCrWQQ2RRw==
X-Received: by 2002:a62:fd0b:: with SMTP id p11-v6mr2959877pfh.52.1529083706112;
        Fri, 15 Jun 2018 10:28:26 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id o77-v6sm16678348pfj.0.2018.06.15.10.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:28:25 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: rtl8192u: add error handling for usb_alloc_urb
Date:   Sat, 16 Jun 2018 01:28:16 +0800
Message-Id: <1529083699-59319-1-git-send-email-jiazhouyang09@gmail.com>
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

This patch adds error-handling code after calling usb_alloc_urb.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Fix memory leak.
v2->v3:
- Release memory in error path.
---
 drivers/staging/rtl8192u/r8192U_core.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7a0dbc0..1c980e9 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1649,12 +1649,12 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 	for (i = 0; i < (MAX_RX_URB + 1); i++) {
 		priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
 		if (!priv->rx_urb[i])
-			return -ENOMEM;
+			goto out_release_mem;
 
 		priv->rx_urb[i]->transfer_buffer =
 			kmalloc(RX_URB_SIZE, GFP_KERNEL);
 		if (!priv->rx_urb[i]->transfer_buffer)
-			return -ENOMEM;
+			goto out_release_mem;
 
 		priv->rx_urb[i]->transfer_buffer_length = RX_URB_SIZE;
 	}
@@ -1666,9 +1666,13 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 		void *oldaddr, *newaddr;
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!priv->rx_urb[16])
+			goto out_release_mem;
+
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
 		if (!priv->oldaddr)
-			return -ENOMEM;
+			goto out_release_mem;
+
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
@@ -1686,17 +1690,19 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
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
+		goto out_release_mem;
 	}
 
 	netdev_dbg(dev, "End of initendpoints\n");
 	return 0;
+
+out_release_mem:
+	for (i = 0; i < (MAX_RX_URB + 1); i++)
+		kfree(priv->rx_urb[i]);
+	kfree(priv->rx_urb);
+	priv->rx_urb = NULL;
+	return -ENOMEM;
 }
 
 #ifdef THOMAS_BEACON
-- 
2.7.4

