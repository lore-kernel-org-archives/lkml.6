Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZtGCBVYzHlvrAQAAmS7hNA
	; Mon, 11 Jun 2018 08:31:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BF6E4607A4; Mon, 11 Jun 2018 08:31:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ7MemIc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 504EC605A5;
	Mon, 11 Jun 2018 08:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 504EC605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFKIb0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:31:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33194 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754010AbeFKIbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:31:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id b17-v6so9844677pfi.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DZn0cvxZYBKzPVqxEZkVRGav/8WAngKpc5Ezz31M+PM=;
        b=HZ7MemIcIx29yjJcnCrRedFHvdnaQ9o+vYCNk5V5EAia7W4Zb4O/rLgh2cmA/nlXfG
         bBROHSCcvADDOgTc77se+Uk/ebZXVvgRfUMOnt1EpDSQrKu5fwDU1B972zQ8pqoUEOBU
         St6/7J+fvBBjBrUdavgrIM9BPjK/sJYC8lHMRvgR7HPat/DkeIEJpqBm7ji6cVjS9tUn
         k3WU61LKH8c3OteupNK5jSH6L3z5UbLbhaqGCK7LrIbb4rqKtBiTdG0HTOSYsoO+18Vj
         A9CWaVlgnKpYtCQjOSa/iDyNCuxxmR5b4pylgeKQUxxFNEQzueFjZOuqzuNp9vWz7NO6
         RrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DZn0cvxZYBKzPVqxEZkVRGav/8WAngKpc5Ezz31M+PM=;
        b=VKk8eyERvmHyW/UnGV3BnvB20cDPMkrq43Z7kYqYDpCenh5QTYKD5DNwMd2+393Npy
         N29lStAyZtFdQJIRvT0f7YJwRO8SJlzHVFdq5aADpqT/H0EKs6sn63LFISxn9VifoT3f
         ursbUSUSilP2xbSe3nfKhAVNIGwpmBEH7ouKi+dUOAbPLQcaj4LtYCJtmMCV1BIwgTPN
         YZuK/Mue4ykqqETZ4niFZabdLYD3fRDXbhI4QUhndc/8GPpQV5gYajrO/GYKlqhmAPDi
         loW6K7SoqBOpEVVvQBCgxvOSUJXrxTQDJH8cndaMOV+b6KjXHUKWMRO8M8rbZUD+pdCn
         pZ1A==
X-Gm-Message-State: APt69E0AEXSjOzcX5eQPCescW9FT7rbGq1HB2QBQXuY1VIaubZC6OJfX
        EqP9vweGElQuFqIk+4ou37w=
X-Google-Smtp-Source: ADUXVKI8+Qb3+RDvBhSsbidZcvy+lyEZ0s1HR/sqzKnDDUIIfaDY8hZc14Ozad3H5PxPnzY/5G8Mog==
X-Received: by 2002:a63:af50:: with SMTP id s16-v6mr14168594pgo.263.1528705884891;
        Mon, 11 Jun 2018 01:31:24 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id w1-v6sm81876177pgp.3.2018.06.11.01.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:31:24 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192u: add error handling for usb_alloc_urb
Date: Mon, 11 Jun 2018 16:31:11 +0800
Message-Id: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When usb_alloc_urb fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling usb_alloc_urb.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 7a0dbc0..3f09615 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1666,6 +1666,9 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
 		void *oldaddr, *newaddr;
 
 		priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
+		if (!priv->rx_urb[16])
+			return -ENOMEM;
+
 		priv->oldaddr = kmalloc(16, GFP_KERNEL);
 		if (!priv->oldaddr)
 			return -ENOMEM;
-- 
2.7.4
