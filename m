Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4E5C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35E8327A79
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:49:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxOAYW97"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E8327A79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967014AbeF1Xtl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:49:41 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33060 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935342AbeF1Xtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:49:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id k7-v6so3601366wrq.0;
        Thu, 28 Jun 2018 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=gxOAYW97Y7ahv9sWDXQbUZw5eqMUHTHPA5OwJM9ZMtbYXBHKk0MOo+LIHr6NCovYQI
         EtAOp9LxdhE6/fNTPz6A0uWY3R1+6HGYESfZxRgq1krWtGwH7s8Z1avcBstKyrrHcUdK
         r8RwEcdFgJVo89iW9m8zeC/CBKtum/n4eAMXD4ir1PuNSX/foAKFpC0X9+Vfbnm/H5pt
         HZczpYxlTserATpAFMCIDMpHVd4Ciec9djo9ZQu/XWjXlA38mRgvwjtluCNMenRP8Jx6
         BL+AtYlZrAEt2kj2KACj/dmEGxziYIaeM9ycU5XEu/noiFIoSKR6okg+u4544JSySDl9
         m0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jJ0HvTuii/tj87M4Greg6e4RuT0tIJ3zCHzr8ED8vI8=;
        b=br7KBP/qQ2rqoiAtp5xzoz+hS28L4pISkm5PgHyFQBZvBWmnnE+O/42XiAEMCTtXOU
         10MYHmwpMOx479yFjLU2g9nvKaJ/ykulXgGe3dXLcS8OrFkB8jMoOsxNbd9yX50/MaVK
         IunyiGm/IADdLtVKxG8kb3QeZqqEdv6X8g2lYc6GXJMZwaZIZwsagnBzTaTh2Axmtax6
         HaTQA/lyzDaKBZ3dxs0i8+ILTHWYNaBKrhVe9hri9uly4xPznoPg+iTmlVREwjIYzoDE
         yfztH3mjvK2//on0NSus8nm35rkRkRSDb1BUtTNn+4VcDT9JRxaTkodB+NAyA2qEXSHF
         NRAQ==
X-Gm-Message-State: APt69E3K4vF8iim8o4B2KYrn5xgsrHm4Whl46AMJez4KO/0gQmJYbut6
        cfYfRONKJ+dRT7qJ2CjZyXo=
X-Google-Smtp-Source: AAOMgpfXhAHMKkdfqCiCDCTZm0pmWbox394q/V3kuEdMr8jEmJSo3ts+oW6FqJ0XKowg4kB4654C+g==
X-Received: by 2002:a5d:4b0a:: with SMTP id v10-v6mr4396167wrq.87.1530229778661;
        Thu, 28 Jun 2018 16:49:38 -0700 (PDT)
Received: from localhost.localdomain ([156.219.234.99])
        by smtp.gmail.com with ESMTPSA id t124-v6sm78214wmt.29.2018.06.28.16.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 16:49:37 -0700 (PDT)
From:   Karim Eshapa <karim.eshapa@gmail.com>
To:     lars@metafoo.de
Cc:     Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH 4/4] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt handler
Date:   Fri, 29 Jun 2018 01:49:28 +0200
Message-Id: <20180628234928.4205-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
as GFP_KERNEL may sleep according to slab allocator.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index b736275c10f5..25c4fbc303f7 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -692,7 +692,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	unsigned int *channels;
 	int i, ret;
 
-	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
+	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_ATOMIC);
 	if (!channels)
 		return IRQ_HANDLED;
 
-- 
2.17.1

