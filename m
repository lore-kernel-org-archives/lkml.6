Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21008C43615
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C7A20E20
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuI+wbhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C7A20E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbeHURwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 13:52:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45319 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbeHURwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 13:52:23 -0400
Received: by mail-ed1-f65.google.com with SMTP id p52-v6so1183903eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 07:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Bdw/oXweRo9ZqoVDdPAjPX2cTB/s3gVRxxriYJhxr6E=;
        b=TuI+wbhONJm5SV4nMWWWhLSmndAX6F/lA93vk5/SN4zPh1985i4wSfRCy080ESXUCu
         LI7cTkSPKDDa3k4B+SRVm3e8Ne/2IIyi95ErCzSpiVW7edSVla4i+n7YREJi5jiYpOKE
         oKcuKEkSnHv3F1zCqx5zsKmMV2mzvJVDsvdgmtROYbDehnDqu40T11E92x7qqTPAZlvE
         OwDFUa6VgDgbhc8jcaPHVvCqgoF0y1AUMdn92dJ1J2cIBqp+ItZxD/e8GH9t0mLRU54d
         Q234vAnC1yIV7tm3pIWL6aVITAPm58XeJNn5nsJF69Duv/I0dyJ9vMiHyCAX0fGR1Gn9
         1wGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Bdw/oXweRo9ZqoVDdPAjPX2cTB/s3gVRxxriYJhxr6E=;
        b=BnV4EIuNcrOXaAtQ8nWNNPzgDOSK3IiT1Ns8DJrGafzwyAO4Nho7aVls9f2W2h33Wn
         OEIkqW4JDK4T0/Htpd/Mi9Li4ebaBmIr6cJeDwvdgkAVYzmBqQBsz8UoW61cIIX8iNMT
         mTDBVMYYcQXFfTlYhFdFJ6jNz2rXmzq4nPIVG0qvrTD/i6kQHmmhnB7wOsKMtayzxzKT
         1Ihmks+5jKkXsKngFBNlz+X70UWbP005TfNAcDIOR9tPl7UEoJT9ofBTqBy6o1EfrhyR
         zm+t2CjAOfXUzb6pvaaAdxbiSB9Dt0ndqosZqj3y9pHvImePKI4aiXeSt3Xn+VKf5Gkp
         iK8g==
X-Gm-Message-State: APzg51DG0hLdW2qJeasd5pGEPctGo82y+r/zzs/KIua6jaqQu7K//MpD
        0X/vq+uizK6N295FsMZ4cpQ=
X-Google-Smtp-Source: ANB0VdaV4nvAJaDVj8Nl3/VCGr8qzRluNHjvSA6LcTpvHcDrd2IfPtIhLywo3X+BjbVu/3nUC90eFA==
X-Received: by 2002:aa7:d70b:: with SMTP id t11-v6mr3554787edq.137.1534861918689;
        Tue, 21 Aug 2018 07:31:58 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id n17-v6sm6766144edq.10.2018.08.21.07.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 07:31:57 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 2/8] mtd: maps: gpio-addr-flash: Fix ioremapped size
Date:   Tue, 21 Aug 2018 16:31:46 +0200
Message-Id: <20180821143152.32293-3-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
References: <20180821143152.32293-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should only iomap the area of the chip that is memory mapped.
Otherwise we could be mapping devices beyond the memory space or that
belong to other devices.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 17be47f72973..6de16e81994c 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -234,7 +234,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->map.size);
+	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
 	if (!state->map.virt)
 		return -ENOMEM;
 
-- 
2.18.0

