Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97114C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4195720891
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 02:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/uLxUpX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4195720891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753879AbeFPCBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 22:01:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36209 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbeFPCBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 22:01:31 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so6214058plp.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HrpNYrqFxxT8IA1rBbyF3mTf3I6JDal1GKiG4Kh1HVI=;
        b=b/uLxUpXd3pi5zrtL5xsG9eToU1TWY3/7E1E/26b9xOGwQqajvJKQ+YAQtTIM2Xn0z
         H3GsL1SRasMrj5/qqJ1O7RjsTp9Agu7OVTjlnK31x052NPMQvW1DPXBJerXemDziRneR
         uBTZhaN1HNfXTcRKQfrKUZh20zSTbSK2G/eQIihSvgyNCl/mbndq2b/JFQMW6mxR6n+N
         qHl5RrrRQoYM7GArJp04Ini+y1J9mKh/wm55jLhAIlx/57MgFyk48zRFyaaes5kYalED
         E1tl9hY7arRn6KvZfmDUBGJh8Y614Z591wFAg76paEbuOQ+gJMmoWkJ4kZZ61t5DjR3R
         HN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HrpNYrqFxxT8IA1rBbyF3mTf3I6JDal1GKiG4Kh1HVI=;
        b=CpYZsoBL74Jv0OFNRMAD4Dn2isLbe4yaQItacEskqSK5IX/kVQh2vQBt0icYLgBqAF
         ovC1H9sGmc++T319dtOYW4QhWqSrfcJZLx9whr2bzBFxIQwbA9F0UhuEMXnC3dgAsyRQ
         lnz81UYQxHYOiDItVNLQ3qm3AHtGBnOFa2B1pK/kULsw599gYnOSX8SgYhz79rrlDx5o
         RN9PgzSaWen/LIA7pMC8ZJHLqZDkMq+2PFYVRUpOluob6mQ+k81KDHGOVGVZu/VZ9Zgc
         QYVSXXLYnviuV1zdsSPRr6m5JtdkSp3hueulmtD/WAdqq0KbgEBTOtvnxgeQWr3f0n+b
         6ntw==
X-Gm-Message-State: APt69E3vt+sUfd2/LzhKpEifMt2Yhc86vd9RyNQ+Q3y86h4jHsqmtB6s
        x56SffB3uO507CuNFNZBn5E=
X-Google-Smtp-Source: ADUXVKLv9ROTJHSIr/geWDWU6X1zTIe1I6qKM6iryCC/Q2vnfisowUon7UePK+F6OAIYgMnEgnqwjw==
X-Received: by 2002:a17:902:bd42:: with SMTP id b2-v6mr4678201plx.23.1529114491179;
        Fri, 15 Jun 2018 19:01:31 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id l62-v6sm13024702pga.21.2018.06.15.19.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 19:01:30 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: rtl8192u: add error handling for usb_alloc_urb
Date:   Sat, 16 Jun 2018 10:01:22 +0800
Message-Id: <1529114485-60684-1-git-send-email-jiazhouyang09@gmail.com>
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
v3->v4:
- Use kcalloc instead of kmalloc_array.
---
 drivers/staging/rtl8192u/r8192U_core.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7a0dbc0..d15ee4f 100644
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
+			goto out_release_mem;
 
 		priv->rx_urb[i]->transfer_buffer =
 			kmalloc(RX_URB_SIZE, GFP_KERNEL);
 		if (!priv->rx_urb[i]->transfer_buffer)
-			return -ENOMEM;
+			goto out_release_mem;
 
 		priv->rx_urb[i]->transfer_buffer_length = RX_URB_SIZE;
 	}
@@ -1666,9 +1667,13 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
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
@@ -1686,17 +1691,19 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
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

