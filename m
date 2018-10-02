Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CBFC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757C52089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZEn0oju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 757C52089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeJCFF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:05:56 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:39199 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:05:55 -0400
Received: by mail-ua1-f74.google.com with SMTP id t14-v6so953668uao.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qkX23LG+qmb7wQ7fAOJlXBTVW2aVqROCLdrSKayOk8A=;
        b=XZEn0ojufyIyvhJDiC5LpLWtKCG/QWA8PVohRqsWf97J9lj68ZTosekxlWISx0Lf6E
         Et6lIk7ruMmRqaLEtVSM6fjIbNUDdfKcOw71+518hFRxId1dkXhEQ9rTMhJzvFNUcyvp
         YqHJ1ZAneZjd6/R+wcQUtczWTMD6Ut5UVNSZB/0Wdq4HiIA100ysxrkJdJ2xYWKn/a2k
         MdkvlY+Pkx3JWyZ7sdNE3Z8bcJcvSFwVFu8yT4itmDcgCmmehtksXHLWzoxruQyn7Bls
         G5nWpw0KqwKdq1vHUYL+8L4DRv+UZzHYOT8jWUbQjSK6A92B/AlAUSd8sOUINcfMwh3C
         5swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qkX23LG+qmb7wQ7fAOJlXBTVW2aVqROCLdrSKayOk8A=;
        b=qCI0XDvWzzHGql7gDrvK1UI7yc7xK2sR1yN7/z0uYIvLHT2C88JKjSJQobxNzZDmbx
         F0ehDSf772zozJs+xL47fwvPjfm+41xZ7JMwrOhPB0aHbS1GwMaXdWmLE0EohwDZ1Cdd
         k34YTzDwsZgSXCCqXVZ6MHdgspUwyZS8iU4Xy0KYNk/Vwq5BysPP5D3fQXUEAzH2MyC/
         GtpdLUTAZ5Okp8U8q2ihgUHZ2UbbgMPCZ802V8/t8iqj4hwVh/pr6/IxVAdTOkeaGnLe
         O4QwKPSJg6ooM3mW5smWVZKlv2vNq4hRDo/OBpyolc762cKKs5orxv/wWcwNkqutGuqT
         vErg==
X-Gm-Message-State: ABuFfogpdNwVtNV63yUcUIN5mh7L5D1q+lmJldjWNssiSFsoz6x7hhVx
        ert9oZmzJxh+yG3PtjUMVdv8V3sH
X-Google-Smtp-Source: ACcGV62RPRstme7+w5o6glsy/1N2Tdrz640/tyxejBRHrfmWj6a/eb6V4GBk5P8+ASv4Wz2Z5GLW0e0d
X-Received: by 2002:a67:e2d3:: with SMTP id i19-v6mr17231204vsm.34.1538518820501;
 Tue, 02 Oct 2018 15:20:20 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:18:53 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-5-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 05/15] platform: goldfish: pipe: Remove redundant casting
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This casting is not required.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index c386aaf40034..bc431f04c4cf 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -925,7 +925,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel((u32)PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
+	writel(PIPE_DRIVER_VERSION, dev->base + PIPE_REG_VERSION);
 	dev->version = readl(dev->base + PIPE_REG_VERSION);
 	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
-- 
2.19.0.605.g01d371f741-goog

