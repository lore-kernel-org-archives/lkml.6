Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3552EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CA32083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR9Q/yvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA32083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbeIADNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:13:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36247 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbeIADNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:13:09 -0400
Received: by mail-wr1-f65.google.com with SMTP id m27-v6so12537702wrf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 16:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mRLHLJRHrF3x1qioDTkWXjyqkRSjVQoseXgAsuIYQ1U=;
        b=PR9Q/yvJ+YkKsarD3KRhjuGe0/TjMRH9GHjX1ygeJL1iC6xzS2XUGFOUnZEBHkzq3k
         ACqzYKqeBKwR/MDreufqv9e+qX+XbaXivYRAwlS5K2nPZQhmsd9NFQs2ExzE8m/k1uti
         UXNp1hEAEeqK39C+G57XNg4janzqBAgamCGqI2zHqoo8mIPrG5bz24cJOHb7FFdKhTvw
         yY9gPH3zx9HvXMPS2W1aNZrDXgzmb8++5xFkA3/U76F2kbh7q+iMR0tYGscSp8rllufe
         Utv4XTn3oo0Q7nuOdWSmLA6Zm6fQ2lMwEwTEsFnWhxfoFEHyHWOPb+oJ9ElYiiZjt6qT
         yhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mRLHLJRHrF3x1qioDTkWXjyqkRSjVQoseXgAsuIYQ1U=;
        b=HjPEHxkp8QBgvdhecKYI/ciOBKzNct9NR4z3i9NXfeQVT4okooxbMTNpe7XZJKF0b+
         fUUssUcXyovMVf409xvHeQfe8CZL0W0ouz9eEvJvi4vHGI3g6MsxjqwxbZO5lLjPxRex
         xkps9VI6Of+NHY5rioVruzGamktywlgzWsLLDPmqASz7A23cmzWErJr9oXPzQePwlKfZ
         CiMQPYHXxzbBUvYRrrt4nwMilkZ1u2wItQS4QgsEFY3Omt9EnStCd4IHsg4tr2PPzDI1
         iHi5IIZhJ8OcXltGb7b0AQlzP/SR7Iqp8KsYPVDfnNT51LHkQTnJcKFKB7NBbuQ9l1F6
         egjg==
X-Gm-Message-State: APzg51CkB/PobcS36d4pAO0PJLZ6MnyEmTWnXY6dASY32M1irBZ7CFyB
        wF2xlg9wkhPtnt3VvZFmIQFOyhdNUQY=
X-Google-Smtp-Source: ANB0VdavzVSvZ7d1DKGGVf4yCdNrM5mjFdN7+BioW9t0XUQEX/CYzH86c6+5BDdDsMzAOHOJWRZMcw==
X-Received: by 2002:adf:9ccb:: with SMTP id h11-v6mr12244945wre.11.1535756606810;
        Fri, 31 Aug 2018 16:03:26 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id o19-v6sm14562267wro.50.2018.08.31.16.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:03:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 20/20] staging:rtl8192u: Rename OWN - Style
Date:   Sat,  1 Sep 2018 00:02:50 +0100
Message-Id: <20180831230250.16810-21-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180831230250.16810-1-johnfwhitmore@gmail.com>
References: <20180831230250.16810-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variable 'OWN' to 'own', this is to comply with the
coding standard, where variables are named in lowercase.

This is a simple coding style change which should have no impact on
runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r8192U.h      | 2 +-
 drivers/staging/rtl8192u/r8192U_core.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
index 68e82b32a88e..f963b664e221 100644
--- a/drivers/staging/rtl8192u/r8192U.h
+++ b/drivers/staging/rtl8192u/r8192U.h
@@ -165,7 +165,7 @@ struct tx_desc_819x_usb {
 	u8	last_seg:1;
 	u8	first_seg:1;
 	u8	linip:1;
-	u8	OWN:1;
+	u8	own:1;
 
 	/* DWORD 1 */
 	u8	TxFWInfoSize;
diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
index 911d0214b48a..4d0f70ec31ac 100644
--- a/drivers/staging/rtl8192u/r8192U_core.c
+++ b/drivers/staging/rtl8192u/r8192U_core.c
@@ -1558,7 +1558,7 @@ short rtl8192_tx(struct net_device *dev, struct sk_buff *skb)
 	/* DWORD 0 */
 	tx_desc->first_seg = 1;
 	tx_desc->last_seg = 1;
-	tx_desc->OWN = 1;
+	tx_desc->own = 1;
 
 	/* DWORD 2 */
 	tx_desc->TxBufferSize = (u32)(skb->len - USB_HWDESC_HEADER_LEN);
-- 
2.18.0

