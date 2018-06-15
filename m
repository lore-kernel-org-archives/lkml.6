Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E0AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A65208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 16:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPw8XZYn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A65208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966030AbeFOQZq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 12:25:46 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37637 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966009AbeFOQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 12:25:45 -0400
Received: by mail-pf0-f193.google.com with SMTP id y5-v6so5108291pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7OM7+QLbGlCqxjx0ZYq68xNddQKGNGGcB3U9nffnPvo=;
        b=HPw8XZYnXwzhKPuj8+H+LmxflSdfST2EXZoCOVv1ZSBbbl4OVqS6x9rHfvT+AX4cPf
         c/ly5uxNVMxHrdwSUbAQYpXpuTCLPf5Kn/jHs0jQbTObQHvNGJLA9MrblX6lKkWeSwHn
         STYSaXmPG+0qNQDPLQwonHOmLbyfmxhpULAoXmGDiy8vWUczJpO+UznGiuCR9K4WiabO
         AHcdveoAQbpqCuM3nQiS2Vn9kRbzIdJD4IcMo08hSoClOYmm3X2IKG0gkxaf3uHOHYTn
         XlkgOXm2dyMT+BLzbbR3r30bJwFZH3BKvAaTCsNkBkOquTG//kqc4hrmwczZ6zgSgCxM
         xvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7OM7+QLbGlCqxjx0ZYq68xNddQKGNGGcB3U9nffnPvo=;
        b=PnGDrhzInbiiGz4LdvBKLaFdNzUtk68I2CmuJnXHpQSYxm4o1KYK9dmcrVW30AObiI
         H2y4Z7Sr4ht25DmeZ7Qz91UE1OPQchMa/TncVAd+TWPDBB33CZRV3W5CyB9wQqwph69k
         40K8opRSraNavKbKnfzk5KJ79+Yg+EMTo1kNyNqIqtWbtKirk2e0IjJIQEgSeUo7ZHeo
         vcw2FhkinuQbzEpE4MHlh9lYk9VuANGKDOnELyDTH0AgVyBP6tV/e1tJTkK6VkawdYL2
         Mxo0CYblc+uR7FDyaDgkoikpf4ZApHu5jiKN//yBsYY6mM32ER9yabBJ0eVnEQJ0nlpX
         qQhQ==
X-Gm-Message-State: APt69E1loTkE2s4we3Cb2VvWE5spnV2RY+Te5m7kXEGKXZT/P2BmCyk0
        QdwLSTNn9klz6O7tW9mxzUk=
X-Google-Smtp-Source: ADUXVKJChj03nxTAIvBczWSDkBfV/2A3CLIw29QmXtkkvvEusJg046B/obEpN87fAa57jI7G4Js8Pg==
X-Received: by 2002:a65:6604:: with SMTP id w4-v6mr2229559pgv.346.1529079944586;
        Fri, 15 Jun 2018 09:25:44 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id l85-v6sm15218208pfk.79.2018.06.15.09.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 09:25:43 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Kees Cook <keescook@chromium.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8192u: add error handling for usb_alloc_urb
Date:   Sat, 16 Jun 2018 00:25:23 +0800
Message-Id: <1529079930-58587-1-git-send-email-jiazhouyang09@gmail.com>
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
---
 drivers/staging/rtl8192u/r8192U_core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7a0dbc0..6afab4e 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1648,13 +1648,17 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 #ifndef JACKSON_NEW_RX
 	for (i = 0; i < (MAX_RX_URB + 1); i++) {
 		priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
-		if (!priv->rx_urb[i])
+		if (!priv->rx_urb[i]) {
+			kfree(priv->rx_urb);
 			return -ENOMEM;
+		}
 
 		priv->rx_urb[i]->transfer_buffer =
 			kmalloc(RX_URB_SIZE, GFP_KERNEL);
-		if (!priv->rx_urb[i]->transfer_buffer)
+		if (!priv->rx_urb[i]->transfer_buffer) {
+			kfree(priv->rx_urb);
 			return -ENOMEM;
+		}
 
 		priv->rx_urb[i]->transfer_buffer_length = RX_URB_SIZE;
 	}
@@ -1666,9 +1670,17 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 		void *oldaddr, *newaddr;
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!priv->rx_urb[16]) {
+			kfree(priv->rx_urb);
+			return -ENOMEM;
+		}
+
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
-		if (!priv->oldaddr)
+		if (!priv->oldaddr) {
+			kfree(priv->rx_urb);
 			return -ENOMEM;
+		}
+
 		oldaddr = priv->oldaddr;
 		align = ((long)oldaddr) & 3;
 		if (align) {
-- 
2.7.4

