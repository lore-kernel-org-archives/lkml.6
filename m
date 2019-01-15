Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F0AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34AE20645
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuNfJG9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbfAOQ7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:59:40 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40387 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732240AbfAOQjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:39:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id f188so3874143wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gBdhP/F6tENpfrwNc6W2O2/xywYNrpubGrYgZa17ko=;
        b=YuNfJG9st8Ieyn8x4VnYFdk/bK+6le8XIJttkWGPla5zX5yMENXC4uMPXNrlc77RI0
         w+B/Glh9zopoYLlbFy0SrmqjyT+hTtZxiNNwxuaAOqIOy6yZebcPK/Q096Gi25AmPpDC
         WI1W4w8OxIacSN8IIU9DE77jcd/LReR/TwUiqPNzm5s9p/d2sytbXUVjM91bYRN/k9nR
         8gBw/DLTunBP26BThbnZuawWNYs/Siryt84SjLJdFxCIzUZyQaUvDeYTmnOMvQEv2Vmo
         WIEpsAwUHZ1TpXy5QXnywQcaZW5b3+YoY7BsxhVtkRuFSXrlhotCyQ6IYA3Vw3SWBPJo
         3vWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gBdhP/F6tENpfrwNc6W2O2/xywYNrpubGrYgZa17ko=;
        b=KkjyaXmANEQKznObp8eXH5BIomBGLGV4q4o1Jxrk4javrw+wCoospNxtRihC0fAnQt
         cJpXPhvURDdRJfxjla9JJ1LBVELiqUZgfgp+P+W5WnARCsUZJaYRLyx5MWJhxfF334xw
         ptBus3wx+pD0Wr0X6L0+2IwePntgzl7sm7Y8yFBWCAVr5YjpVqMBGSno3BGhYpCt08S2
         gVhWoaIY1u+5omeZK5TlLVb0a9ky5kVg0sWg698dWXAvLEgn4/SOCBVwPFFWEoiI/aLj
         zTTeoO5IFKlSY+pAB3iueR64mDzgqFgfirh2d7ilMJdxzpGE0/Gbsj16fkmNREv8E5/d
         GOTQ==
X-Gm-Message-State: AJcUukcNmBxH5Tw18UPWKJfvZaOWTf/gr3NMCR5VEl9y8ZRHgbVfD5cA
        6NU+ZsM5dyxbDSpzWW1OHzo=
X-Google-Smtp-Source: ALg8bN7AGN8jdff3B6IhiFdFYX58E0wlq8SWHXc/vI93D9z1eSa53vkJnse0pxiLDRGX+5qjPDRB7w==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr4071777wma.109.1547570342633;
        Tue, 15 Jan 2019 08:39:02 -0800 (PST)
Received: from localhost.localdomain (ip1f12f8bc.dynamic.kabel-deutschland.de. [31.18.248.188])
        by smtp.gmail.com with ESMTPSA id c65sm32973558wma.24.2019.01.15.08.39.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 08:39:01 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 2/2] staging: rtl8188eu: add spaces around operators in os_intfs.c
Date:   Tue, 15 Jan 2019 17:36:40 +0100
Message-Id: <20190115163640.2598-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115163640.2598-1-straube.linux@gmail.com>
References: <20190115163640.2598-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '+', '<<' and '*' to follow kernel coding style.
Reported by checkpatch.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index 6ed4a06a0796..dfba6b725790 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -267,11 +267,11 @@ u16 rtw_recv_select_queue(struct sk_buff *skb)
 	u32 priority;
 	u8 *pdata = skb->data;
 
-	memcpy(&eth_type, pdata+(ETH_ALEN<<1), 2);
+	memcpy(&eth_type, pdata + (ETH_ALEN << 1), 2);
 
 	switch (eth_type) {
 	case htons(ETH_P_IP):
-		piphdr = (struct iphdr *)(pdata+ETH_HLEN);
+		piphdr = (struct iphdr *)(pdata + ETH_HLEN);
 		dscp = piphdr->tos & 0xfc;
 		priority = dscp >> 5;
 		break;
@@ -323,7 +323,7 @@ struct net_device *rtw_init_netdev(struct adapter *old_padapter)
 	padapter->pnetdev = pnetdev;
 	DBG_88E("register rtw_netdev_ops to netdev_ops\n");
 	pnetdev->netdev_ops = &rtw_netdev_ops;
-	pnetdev->watchdog_timeo = HZ*3; /* 3 second timeout */
+	pnetdev->watchdog_timeo = HZ * 3; /* 3 second timeout */
 	pnetdev->wireless_handlers = (struct iw_handler_def *)&rtw_handlers_def;
 
 	loadparam(padapter, pnetdev);
-- 
2.20.1

