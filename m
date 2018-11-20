Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D43C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208D820851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kp5Lvw7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 208D820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbeKUAfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:35:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41695 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKUAfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:35:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so1047771plm.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x+CzQTh2nUlAR5aoA0UQeXtIkwuR4tfYukAQ6RQl2DQ=;
        b=Kp5Lvw7w7++kHXCyrEvNBEjwO7LKyER2XEe1ccYTTfMgn2g9e5nl5JvpNjH58rdXQ4
         07JUQSC4ktZWQctXH0VYL/xM1RTvg6ZpwFgnOSBlVONjp+QOiLMYLOjOP88rEiiylWTK
         la1X9AhnJnw4uf6auoZUz1iINI30LEjGcV/zv1T1JIjGwVloNHAt7lG7K9XUCra4z0rG
         YDmOUdiTL5AIw6IUTyat7vR4emwwrehnvVfBQoqrcXlfXPbsqDE6+aTz5L6FT2qjcXZO
         /PVj9FwA9V7PFre+OJf9vZlyKZWxeXJXJox21IO0R3Is7gVT5sLE2COvWeL63RGyNF88
         QJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x+CzQTh2nUlAR5aoA0UQeXtIkwuR4tfYukAQ6RQl2DQ=;
        b=GnMN6kqXaTY5D8QAZWI3qQMmJKpZzejoiYs6Czpvz3S3xBPRTPf9QMo888SZD4nQK5
         8lJ1kXOb5ZPu42vzvMCjMJXHChbr4mfWWHHCAh51kMv0fMCYN1FZJRGZGz6TG8Eq65gb
         pB8zwhRvkYKtxCGiF9yVIT1PWtbXdwNPxB/dJpNWlPZb3GUQElVt3riJPoeJjxI8trAm
         7JEIk5E3rFEAvn2il4OZM3l0BZdE4QncH//n3g2WboCFqjpW+ZalGMeJIrlgPWoc65F2
         s73lcgHcIA3tS/99wom293cWuzMQRhCxVeBv3PqDTjTiPnDiUW42KdcwDxjiqu9IelC4
         9MSQ==
X-Gm-Message-State: AA+aEWZcI2nZ2nRisqgaJyo+OvCW3OIF30I2tOynYTBIxtM2gFA2vmKM
        g0msbw5721YhM0RuVlT1AgY=
X-Google-Smtp-Source: AFSGD/UIjGT258ghFZxlE2FlN7vIyt5ypRYQjzdqUJgbsiMA/sr18EEEAAUfPSXd2CB9xcvjBxNB0Q==
X-Received: by 2002:a17:902:3181:: with SMTP id x1mr2356331plb.58.1542722771243;
        Tue, 20 Nov 2018 06:06:11 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v13sm4946189pff.20.2018.11.20.06.06.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Nov 2018 06:06:10 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     linux@armlinux.org.uk, julien.thierry@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, palmer@sifive.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] ARM: add of_node_put()
Date:   Tue, 20 Nov 2018 09:06:07 -0500
Message-Id: <20181120140607.20446-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/kernel/setup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 375b13f7e780..c20421f0078e 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -949,6 +949,7 @@ static int __init init_machine_late(void)
 					      &system_serial);
 		if (ret)
 			system_serial = NULL;
+		of_node_put(root);
 	}
 
 	if (!system_serial)
-- 
2.17.0

