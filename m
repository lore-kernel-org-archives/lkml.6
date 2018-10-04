Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CFC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD1A52084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzK6udkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD1A52084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbeJDTyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:54:45 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39232 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJDTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:54:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id w21-v6so6707556lff.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=TzK6udkx40T+yB4Jkdo3zG+dO3MlND4TaMmjCwny6HA9wgto/bQwMu7PEj/az/SB0Y
         cPV0NWqbGj37xNVZSpgpxPkKtoWihf2BP6Ds1ZZGD9xH91Z7KeRR+J1JUlvNim6qyr8f
         uIF79i81cN+917iD+EIthwt0dqJd70JVVaF4hKpxZaSqxSYvvlRG7TovePFISdJWPn1z
         Vj1NonbiUNPvzFssshuDlhcaovLZkcMDlCnbAiNcTVcIS/zf8OmmcHSgQjJ9jJaI1q0O
         ooWl6rv9BFyWrv+FeiPBVXnWMzFeh2PcyBYcSfdzfNyAj8V8l3vxqvjPRuabE+4apQUB
         t5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZUbn50UsHuR5ct+6gyJtPRAN067Ky0FADOBnmfRKwk=;
        b=tXfD637XCL8pIjMtfebRJNnOrOTYMmCYBhlrzP2IX8nkXYcjzRFC6gJPrnRlTpkDDE
         EIwSGmYRe+j0blBWp8Lwj7K/JyJMzvVIYvUaURWVKgm30fcdtSfKsMEbLfTuyzkDN2Uf
         b6Tmn1ToqFw+JHRjThVXmj7abhC9rv6zGwfoPjFx6KqEFEsTaquVBnMVMqB25uLv0yol
         DU9BmAfXHX1fdbfP96xI7KnjmEmKIONEt/cj6/QICzUjTo161Udc7ahLoXVwVMK736Z+
         bhmsPJR73tAw5fP2CS0IdK/GzxADI6QWU82SxX5da0ndcNc9w2r2iAu27Iq0gC90E7Ja
         bJOA==
X-Gm-Message-State: ABuFfohPI38zW3ktiGfV3uTuZMPu25TueJsQGiAaKbHKGViTpy7dwuRA
        sXbfLFGsSiQ/K8gjykGKbZ3zVdTg
X-Google-Smtp-Source: ACcGV62EXxBxEjJhkLlaL9KwOnTOCd06JwT+hbfkdE0xbcZ1ii6X/Y/CEBWq83IWgObXCoRMYusoaw==
X-Received: by 2002:a19:a686:: with SMTP id p128-v6mr3742306lfe.42.1538658090417;
        Thu, 04 Oct 2018 06:01:30 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id a1-v6sm421415lfk.63.2018.10.04.06.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:01:28 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v6 05/10] mtd: maps: gpio-addr-flash: Use devm_* functions
Date:   Thu,  4 Oct 2018 15:01:05 +0200
Message-Id: <20181004130110.8496-5-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
References: <20181004130110.8496-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using devm functions we can make the code cleaner.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/mtd/maps/gpio-addr-flash.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/mtd/maps/gpio-addr-flash.c b/drivers/mtd/maps/gpio-addr-flash.c
index 6de16e81994c..84404dcc7824 100644
--- a/drivers/mtd/maps/gpio-addr-flash.c
+++ b/drivers/mtd/maps/gpio-addr-flash.c
@@ -213,7 +213,7 @@ static int gpio_flash_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	arr_size = sizeof(int) * gpios->end;
-	state = kzalloc(sizeof(*state) + arr_size, GFP_KERNEL);
+	state = devm_kzalloc(&pdev->dev, sizeof(*state) + arr_size, GFP_KERNEL);
 	if (!state)
 		return -ENOMEM;
 
@@ -234,9 +234,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	state->map.copy_to    = gf_copy_to;
 	state->map.bankwidth  = pdata->width;
 	state->map.size       = state->win_size * (1 << state->gpio_count);
-	state->map.virt       = ioremap_nocache(memory->start, state->win_size);
-	if (!state->map.virt)
-		return -ENOMEM;
+	state->map.virt	      = devm_ioremap_resource(&pdev->dev, memory);
+	if (IS_ERR(state->map.virt))
+		return PTR_ERR(state->map.virt);
 
 	state->map.phys       = NO_XIP;
 	state->map.map_priv_1 = (unsigned long)state;
@@ -245,12 +245,10 @@ static int gpio_flash_probe(struct platform_device *pdev)
 
 	i = 0;
 	do {
-		if (gpio_request(state->gpio_addrs[i], DRIVER_NAME)) {
+		if (devm_gpio_request(&pdev->dev, state->gpio_addrs[i],
+				      DRIVER_NAME)) {
 			dev_err(&pdev->dev, "failed to request gpio %d\n",
 				state->gpio_addrs[i]);
-			while (i--)
-				gpio_free(state->gpio_addrs[i]);
-			kfree(state);
 			return -EBUSY;
 		}
 		gpio_direction_output(state->gpio_addrs[i], 0);
@@ -259,12 +257,8 @@ static int gpio_flash_probe(struct platform_device *pdev)
 	dev_notice(&pdev->dev, "probing %d-bit flash bus\n",
 		   state->map.bankwidth * 8);
 	state->mtd = do_map_probe(memory->name, &state->map);
-	if (!state->mtd) {
-		for (i = 0; i < state->gpio_count; ++i)
-			gpio_free(state->gpio_addrs[i]);
-		kfree(state);
+	if (!state->mtd)
 		return -ENXIO;
-	}
 	state->mtd->dev.parent = &pdev->dev;
 
 	mtd_device_parse_register(state->mtd, part_probe_types, NULL,
@@ -276,13 +270,9 @@ static int gpio_flash_probe(struct platform_device *pdev)
 static int gpio_flash_remove(struct platform_device *pdev)
 {
 	struct async_state *state = platform_get_drvdata(pdev);
-	size_t i = 0;
-	do {
-		gpio_free(state->gpio_addrs[i]);
-	} while (++i < state->gpio_count);
+
 	mtd_device_unregister(state->mtd);
 	map_destroy(state->mtd);
-	kfree(state);
 	return 0;
 }
 
-- 
2.19.0

