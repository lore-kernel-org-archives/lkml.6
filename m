Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30913C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6772083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 03:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRG6yWX5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB6772083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbeKFM5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 07:57:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45904 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbeKFM5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 07:57:00 -0500
Received: by mail-pl1-f195.google.com with SMTP id o19-v6so5466564pll.12;
        Mon, 05 Nov 2018 19:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/B9c0Siz2cQq+Qlpwp7SPzLyhwUuiU2x/Fb4412Cyko=;
        b=WRG6yWX5Z/OUR89dfsuuY11uJL+1J+ZsaI6bwkea2MrBNZeZwDH7T7CXcrob8AltTZ
         aTl9/kl1CdUUizyXYGp4WpwLRPZYQTHR1sJRrJBQfXw2TUBK9Y2FYt/faourJbLn/don
         fK2uHt39gPKX+UagJaOqq0DnKkOBRP4ZnHaIUi/pYlAddYU73bqkgGRq/n4HfOegnedu
         BufAGn3F8HzLACayRyNU+D+8IfAyToMr+XWbk8X4BX2jsQnfmdeRAmQMAxm/a29ALUQk
         2fiWSUO+Zqy1lpq1R8uNyw4zsxwRycz/3T/tMu81LEgacb83BdaoSw3Tx/e7m4p1yPL3
         YN9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/B9c0Siz2cQq+Qlpwp7SPzLyhwUuiU2x/Fb4412Cyko=;
        b=ZLCoM3vsA/19R7UsgSTCSLLCd3bEVGxhgKi6g6eqZnZ5amQbqbNtzY/5Gi73So8CxC
         haqW5GGA0O6DHdeswpM+SaUsyWqNVdMXY/FVEaS5Xta59SAYU2WMuNtMUbNUJ4PJUEjp
         Xa9CitLXBAIM01Cmh6nM3cX4L3H9KymP/JxDQ6RWzRwWpoGi2gDHshYZQvTRCwImLegH
         JBwYLXQl93aBfFJz0fKiKjTU139v2DbO+wzNrSQfYmYpnWqz8LHKJGvwQjs+Li8AGS8r
         MdWuzYabIHQCUUSyR35TtauK1YraAcW/ZRE2iByeOcIhwsh5Es6NdBcTFCLec1j9XiBY
         RmRg==
X-Gm-Message-State: AGRZ1gK/eDvDh0/04LGfnVvcx4x0/HD34bbTb9hW1Q1QJHdPoaHf6cCi
        ZACWJ0vm+uSCt/c00/PzIYw=
X-Google-Smtp-Source: AJdET5c8NM7ilNUKMZtcj9QYMf9VpwIJxA+CAomEca2+tNR2zo38H+oCG7vQv1JoxwNsSXg21OdCxQ==
X-Received: by 2002:a17:902:b789:: with SMTP id e9-v6mr4823856pls.338.1541475236274;
        Mon, 05 Nov 2018 19:33:56 -0800 (PST)
Received: from localhost.localdomain ([2402:f000:1:4414:1815:546f:dfdc:5850])
        by smtp.gmail.com with ESMTPSA id i88-v6sm40639651pfi.66.2018.11.05.19.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 19:33:55 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     linus.walleij@linaro.org, vkoul@kernel.org,
        dan.j.williams@intel.com
Cc:     linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] dma: coh901318: Fix a double-lock bug
Date:   Tue,  6 Nov 2018 11:33:48 +0800
Message-Id: <20181106033348.27361-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function coh901318_alloc_chan_resources() calls spin_lock_irqsave() 
before calling coh901318_config().
But coh901318_config() calls spin_lock_irqsave() again in its
definition, which may cause a double-lock bug.

Because coh901318_config() is only called by
coh901318_alloc_chan_resources(), the bug fix is to remove the
calls to spin-lock and -unlock functions in coh901318_config().

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/dma/coh901318.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index eebaba3d9e78..fd862a478738 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -1807,8 +1807,6 @@ static int coh901318_config(struct coh901318_chan *cohc,
 	int channel = cohc->id;
 	void __iomem *virtbase = cohc->base->virtbase;
 
-	spin_lock_irqsave(&cohc->lock, flags);
-
 	if (param)
 		p = param;
 	else
@@ -1828,8 +1826,6 @@ static int coh901318_config(struct coh901318_chan *cohc,
 	coh901318_set_conf(cohc, p->config);
 	coh901318_set_ctrl(cohc, p->ctrl_lli_last);
 
-	spin_unlock_irqrestore(&cohc->lock, flags);
-
 	return 0;
 }
 
-- 
2.17.0

