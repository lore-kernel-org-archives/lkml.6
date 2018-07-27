Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E797AC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8F220673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3KAphno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D8F220673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbeG0E0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:26:54 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:34997 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0E0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:26:54 -0400
Received: by mail-pl0-f67.google.com with SMTP id w3-v6so1685324plq.2;
        Thu, 26 Jul 2018 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=I1w2fTWFH6D5/xRWuf1sz/hQSAip5UyfHVE49QGVzkg=;
        b=l3KAphnoSQ2or9bdIlsZ8TKg2YKinzsl4nlU7HbUkZnz4noNIry2aE3NkT2kEDAexU
         HljbBe5unwzg7DlJvXxGrSu/Xh02lOX6L3wFByAHGxkuzM5ubd87uv9wRR6OYgqe98or
         W/otLvbxJp4tAwppQzu3NXW6PUDQhUSKlV2ZOdjK/qIaZbcDbsFfgpG7XLvGIfIXQFq9
         zbK0bivPM5JVmAbE+Ygdd/nNnkYpqGCmdjYFb7bX8veIE/AnoRJhkGpRFf1KqFJ19Qms
         PQkg5iN7UHcqevTaJZ6S68/yrhivxTyVPA2rRIuUGR/LzBGheSAF6XZrYl2JvV+HWW4u
         Qd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=I1w2fTWFH6D5/xRWuf1sz/hQSAip5UyfHVE49QGVzkg=;
        b=qGpztErC0xD1kB6CwjyatrcHv9epuv8sV9mTcAIuexTPQf7q0k/jOpayBHHpU5uija
         lw6uqCB9ljw/1NCHLCxJf82XSHUt5sd5ZEdBOUUWje/gLkafbdsnB1+UCLrZ3ke4N4WX
         lhL2QX3jJX8CmPmTaKmKBlb9wBjfgLbpVhdrzDg9CxRJTRzavIAYVqxfpVDdIQ8mtWrs
         SztD1MsuI0G9Gf5uV04gbjgi/i79rAKfFVSGuZh+RYoFE+UcUbvmD0WEw4jLF6Dksf81
         Tk+NFW/V0xQaQ7ACkwjon/OXoXOu+El/PZJbRIBhCNZJ9UgsuBwZQiyM/q8cPHlpKhZw
         tjrA==
X-Gm-Message-State: AOUpUlE25wd7A0JO0wfcaPDmQN1XRZL/t7+zKZLRNc3AAjWVZLJfsh0H
        /+Sw7UKybEwSffvnikv1FKIa0AB/
X-Google-Smtp-Source: AAOMgpdDldc8Q7MvuHRvF2WaDOM4Ya7pjTs5f5S4i/ZTcDV0206f3nQ0n75J2DO2v0ggsNqzl6Zt+A==
X-Received: by 2002:a17:902:3124:: with SMTP id w33-v6mr4262796plb.235.1532660831484;
        Thu, 26 Jul 2018 20:07:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id e9-v6sm3543503pgu.5.2018.07.26.20.07.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:07:11 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     awalls@md.metrocast.net, mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cobalt: Replace GFP_ATOMIC with GFP_KERNEL in cobalt_probe()
Date:   Fri, 27 Jul 2018 11:07:04 +0800
Message-Id: <20180727030704.2784-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cobalt_probe() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cobalt/cobalt-driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cobalt/cobalt-driver.c b/drivers/media/pci/cobalt/cobalt-driver.c
index c8b1a6206c65..4885e833c052 100644
--- a/drivers/media/pci/cobalt/cobalt-driver.c
+++ b/drivers/media/pci/cobalt/cobalt-driver.c
@@ -670,7 +670,7 @@ static int cobalt_probe(struct pci_dev *pci_dev,
 	/* FIXME - module parameter arrays constrain max instances */
 	i = atomic_inc_return(&cobalt_instance) - 1;
 
-	cobalt = kzalloc(sizeof(struct cobalt), GFP_ATOMIC);
+	cobalt = kzalloc(sizeof(struct cobalt), GFP_KERNEL);
 	if (cobalt == NULL)
 		return -ENOMEM;
 	cobalt->pci_dev = pci_dev;
-- 
2.17.0

