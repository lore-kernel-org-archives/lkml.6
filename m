Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A58C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CFBC2082F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 18:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="WcPd3C/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFBC2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLDSQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 13:16:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36329 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLDSP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 13:15:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so10371468wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 10:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1dmBx0JVfBSs7y6AKVDKRrwdua0x+fx/5T+3iUjrVo=;
        b=WcPd3C/Ms/aqjxaGAybTHDJuP+iNNidQGOL0EbuUBC9gaUvU9MTx7gs+m0ihKk8vjO
         qIcVs2CFArvgy7chhCudrMgKTKYP9LZr9uStpavFqCUtggajksz1jBl+JbAqfuJ2kPzS
         d8u46XHHVBe7XnR0TtEQK/FhRcp0TzXR8ogfPZiWeo026+U1fzFbnWm1nFPZEHCspInX
         QxGa1ys3hNVSb4yAsQwSCKAx8QL68/lVe11v5XdXO8SU0z1WbtEW9veTj719JIoYCej5
         ZYieL+DH5LlDk2xh30kwyJXQeMPCqKDOY/w0zDhpk9MF4jDSS/nHEUPFAXrBoDkVtQZX
         ecMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1dmBx0JVfBSs7y6AKVDKRrwdua0x+fx/5T+3iUjrVo=;
        b=uOWt5MTiEC2tRF9PJdmAEXZJWUR3jDNCLm7OrqI2921aoqctoD40P9C0opFhFhKgca
         zxlvxab/sd9FVxwSnIdIIHjxXNJziQEMh3v/5lfKJpxjEWw6t3dtUtu9v/zVRH5RKGze
         OTc8iEkOV3rpMp1d6udXZ25BuBzRhXVVHdzetFme6vEksox2Qdd19J+muju2YWjcxgWF
         5AEoz3Dw8HxuM4X3a4qVuqUVR+cspTLgsFOg5xEr0PB235WDOjX7vM0x/19IYD3zm+rs
         XxfFhkcSk9yNjqzUyREY5jZBmMmn5FdyuXGAhiK+bjBUTfJJrGljucuM0l26RgS5X2V2
         NmnQ==
X-Gm-Message-State: AA+aEWZPYE0J6aXxenXqteitB5uRius6NnemxggOffQmgeeCJ5CDeYwv
        yZAB+dk/FCiQ3123WqARyvqDTn3334A=
X-Google-Smtp-Source: AFSGD/UxOUsn52W/F2NAawJMU8CQtduSUCpfgkeD53xHY3UAeZt4/iLQlFk1CH0kFFPmf0jERMwuNA==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr12905670wmj.127.1543947357528;
        Tue, 04 Dec 2018 10:15:57 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm37942897wrb.93.2018.12.04.10.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 10:15:57 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/1] regmap: irq: handle HW using separate mask bits for edges
Date:   Tue,  4 Dec 2018 19:15:50 +0100
Message-Id: <20181204181550.29122-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204181550.29122-1-brgl@bgdev.pl>
References: <20181204181550.29122-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Some interrupt controllers use separate bits for controlling rising
and falling edge interrupts in the mask register.

Let's reuse the existing type fields in struct regmap_irq to make
regmap_irq_chip available to such HW.

If the type_base and mask_base offsets are the same - assume there
are separate bits for falling and rising edge interrupts and use
the value previously written to the type buffer by the set_type()
callback instead of the entire mask specified for this interrupt
so that we only enable the requested edge interrupts.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/base/regmap/regmap-irq.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 429ca8ed7e51..109ae353c526 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -194,8 +194,24 @@ static void regmap_irq_enable(struct irq_data *data)
 	struct regmap_irq_chip_data *d = irq_data_get_irq_chip_data(data);
 	struct regmap *map = d->map;
 	const struct regmap_irq *irq_data = irq_to_regmap_irq(d, data->hwirq);
+	unsigned int mask;
 
-	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~irq_data->mask;
+	/*
+	 * If the type_base and mask_base addresses are the same, then
+	 * the underlying hardware uses separate mask bits for rising and
+	 * falling edge interrupts, but we want to make them into a single
+	 * virtual interrupt with configurable edge.
+	 *
+	 * Instead of using the regular mask bits for this interrupt, use
+	 * the value previously written to the type buffer at the
+	 * corresponding offset in regmap_irq_set_type().
+	 */
+	if (unlikely(d->chip->type_base == d->chip->mask_base))
+		mask = d->type_buf[irq_data->reg_offset / map->reg_stride];
+	else
+		mask = irq_data->mask;
+
+	d->mask_buf[irq_data->reg_offset / map->reg_stride] &= ~mask;
 }
 
 static void regmap_irq_disable(struct irq_data *data)
-- 
2.19.1

