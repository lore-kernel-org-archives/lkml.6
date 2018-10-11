Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC04C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A195D204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 16:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buhkTyxp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A195D204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeJKXha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:37:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41062 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeJKXh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:37:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id q17-v6so4462956plr.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=S44JGOd16GctSGLVbs8mDQrUDdgxbbFAoK+5tP7b284=;
        b=buhkTyxpskAg/c7tbKI1BmQr7F1vtiJbFqX6LvXGj8L1+ZxOr/eUGoYhrngoK+XOsc
         qr44fbFQCTAAxNecGvJOen3Zwmm9I5y6ZUZdkxLgq9hq+proWY5uyL7B4HP4iMSf7tDD
         jc/ar7kWtakddFA2gV8EkDh4WNi3eMWYwOT/Uwqn44U2gW7DZt6mVU4BgIX0vlP2fMS6
         FzjY0Z8uIOcoYHG3fKYg6ObGPkUH0Ii1z3S1tHX26qMnBkPLvHqoA0DwB+xCuevAN72V
         2ZXwi3uGb/MJSkemlHo1Qtvb/srVM2UlFKindVHlHfhVj1O1YypizMMD4OQQYNAwlqFY
         q5yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=S44JGOd16GctSGLVbs8mDQrUDdgxbbFAoK+5tP7b284=;
        b=n+l2gllZDqNqLZqvPb0jx1fu9kRPTXo7ZOy8byovW5IyxnjSpo1hHPtlzCKuRnUfBh
         ulW7qCQzrcra2/f8AESTW0Qg6REuh0A5XdiOSRtrXIeUKq4Fsba0ZXxuKJfV1FbCFMIw
         MjE1OG/uLTjlOsBUPXvsqSPEIaz4x6F/5jiWoFJRSIoTYBhWC869yu01abtsI4qEHX6Y
         7hYVWku8CTHPDyk76U74nURn1inrf/tCByAjG8o4RQRFu3/LDDaiH0FyLPDYSuklXkhb
         mB4ha3w0QUWxhrcrCI+B3fHjfBao2agbc0OxaGihYe9Xden7RyDQwsVp/jmrA6EzT0W7
         SyOw==
X-Gm-Message-State: ABuFfoinVDR/w/S+EDWqTPYid3x5/5VeMkMwBpStQORCRhUB2HoOKBYE
        W5zqWHZ/rSgDqr7/fdUM4iI=
X-Google-Smtp-Source: ACcGV60TNxdnIlq4xHH1/S0LT0GCkk7rXIvQBkzBL0CP+rdnbmlt1KwDLKKdQnPXxZkaJo4K6Dhu9Q==
X-Received: by 2002:a17:902:e111:: with SMTP id cc17-v6mr2137548plb.175.1539274176814;
        Thu, 11 Oct 2018 09:09:36 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id i29-v6sm49502620pfj.82.2018.10.11.09.09.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Oct 2018 09:09:36 -0700 (PDT)
Date:   Thu, 11 Oct 2018 21:39:29 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, NeilBrown <neil@brown.name>,
        devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] staging: mt7621-mmc: Use BIT macro instead of explicit
 shifting in dbg.h
Message-ID: <20181011160925.GA4856@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace explicit shifting with BIT macro in dbg.h.
Issue found by checkpatch.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/mt7621-mmc/dbg.h | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/mt7621-mmc/dbg.h b/drivers/staging/mt7621-mmc/dbg.h
index 89acf590ed11..b0502d15b0c9 100644
--- a/drivers/staging/mt7621-mmc/dbg.h
+++ b/drivers/staging/mt7621-mmc/dbg.h
@@ -74,17 +74,17 @@ enum msdc_dbg {
 };
 
 /* Debug message event */
-#define DBG_EVT_NONE        (0)       /* No event */
-#define DBG_EVT_DMA         (1 << 0)  /* DMA related event */
-#define DBG_EVT_CMD         (1 << 1)  /* MSDC CMD related event */
-#define DBG_EVT_RSP         (1 << 2)  /* MSDC CMD RSP related event */
-#define DBG_EVT_INT         (1 << 3)  /* MSDC INT event */
-#define DBG_EVT_CFG         (1 << 4)  /* MSDC CFG event */
-#define DBG_EVT_FUC         (1 << 5)  /* Function event */
-#define DBG_EVT_OPS         (1 << 6)  /* Read/Write operation event */
-#define DBG_EVT_FIO         (1 << 7)  /* FIFO operation event */
-#define DBG_EVT_WRN         (1 << 8)  /* Warning event */
-#define DBG_EVT_PWR         (1 << 9)  /* Power event */
+#define DBG_EVT_NONE        (0)     /* No event */
+#define DBG_EVT_DMA         BIT(0)  /* DMA related event */
+#define DBG_EVT_CMD         BIT(1)  /* MSDC CMD related event */
+#define DBG_EVT_RSP         BIT(2)  /* MSDC CMD RSP related event */
+#define DBG_EVT_INT         BIT(3)  /* MSDC INT event */
+#define DBG_EVT_CFG         BIT(4)  /* MSDC CFG event */
+#define DBG_EVT_FUC         BIT(5)  /* Function event */
+#define DBG_EVT_OPS         BIT(6)  /* Read/Write operation event */
+#define DBG_EVT_FIO         BIT(7)  /* FIFO operation event */
+#define DBG_EVT_WRN         BIT(8)  /* Warning event */
+#define DBG_EVT_PWR         BIT(9)  /* Power event */
 #define DBG_EVT_ALL         (0xffffffff)
 
 #define DBG_EVT_MASK        (DBG_EVT_ALL)
-- 
2.17.1

