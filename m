Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DD9FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A261020873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOjlUOCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A261020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeG3PSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:18:07 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35631 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeG3PSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:18:07 -0400
Received: by mail-pl0-f65.google.com with SMTP id w3-v6so5579316plq.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DNdnE/kZ/XuUmtH5Z/dUaoBqpi0bBVl9FJ0FK1kRdbA=;
        b=iOjlUOCgmLzk0fekyO/1D4wIKuJYdycSmAuHY2lpYgcrpFkkDl84aeAO/kwHHj2UC2
         JU574Bc1LylQSS1/HlyTXgBYQbUXMPqgP9fmMTDkHyjaabVeKokDYh2K9Q11ho1pW+43
         eBlyAUkZtYPseF91U8T20i75Trejz0HUSf3CeIRtvcQeMXbyavja9HFKDABSNGM8bj/j
         bRrnAGix6mVejCg1jiu8HZSiSg2Qxk8+QI47RXgIPlNMrl5tC6lnY9+nPrqY2apFqLYm
         CpmYTgcWBBPWMjRpcTOdJeCp+AWELk97ksb/mmxklxkdvAgWrqTivl45E1rmYsk+X1mj
         6rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DNdnE/kZ/XuUmtH5Z/dUaoBqpi0bBVl9FJ0FK1kRdbA=;
        b=X4rITC/ySC+f54RCb+F8hdqQD7PtOaoB7qL0H7HsH0HDMMUZrCrGkkWGauXzw/lYyX
         8SnQhSKOua4Fvmy2FRiRLGTg1wv6eSM/zSDHW213m5LBQobI3dkIX1DEu4zeKiGIeVeN
         P+m1iNL9ni/KHGbEbmRVbQzDn6A6rK6ELYoJ1uXOMmDJYkPFThEK6LMjLHhD8Kb5PvsQ
         JalMCt5M7V3lGj4C4APF2du3wrSK4tGABwgsTHRB3T+gkGTjklCYY2DAXh8+POYAWilr
         eAG0slhjoNyKSVhU50gD7sCh0uIIbfkLNG7ge1L5CxjUBGdAx64GPaQRkriifSnX3A1C
         96xA==
X-Gm-Message-State: AOUpUlFVRxN6B8nCh0dj7HboKy1l6TlZYqgqcXvVdcSQyzf0S9dznUtP
        PpXaTCxcRxpEUrxWOPcz6w8+9D8f
X-Google-Smtp-Source: AAOMgpdMzHTGvGWHbNpAq+LS8ZJkOdcXZeMJKiwGPEZQOFcjHhu/WPoXWLUF1woJ529ukLObnrxgNQ==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9-v6mr16733920plb.245.1532958183353;
        Mon, 30 Jul 2018 06:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:4550:ab75:cee3:d6c1])
        by smtp.gmail.com with ESMTPSA id f23-v6sm12397577pgl.5.2018.07.30.06.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 06:43:02 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     linux@dominikbrodowski.net
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] pcmcia: pcmcia_resource: Replace mdelay() with msleep()
Date:   Mon, 30 Jul 2018 21:42:56 +0800
Message-Id: <20180730134256.8901-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pcmcia_fixup_iowidth() and pcmcia_enable_device() are 
never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/pcmcia/pcmcia_resource.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pcmcia/pcmcia_resource.c b/drivers/pcmcia/pcmcia_resource.c
index 34aad895a239..8129dd8094cd 100644
--- a/drivers/pcmcia/pcmcia_resource.c
+++ b/drivers/pcmcia/pcmcia_resource.c
@@ -284,7 +284,7 @@ int pcmcia_fixup_iowidth(struct pcmcia_device *p_dev)
 		io_on.stop = s->io[i].res->end;
 
 		s->ops->set_io_map(s, &io_off);
-		mdelay(40);
+		msleep(40);
 		s->ops->set_io_map(s, &io_on);
 	}
 unlock:
@@ -567,7 +567,7 @@ int pcmcia_enable_device(struct pcmcia_device *p_dev)
 			!(flags & CONF_ENABLE_PULSE_IRQ))
 			option |= COR_LEVEL_REQ;
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_COR)>>1, 1, &option);
-		mdelay(40);
+		msleep(40);
 	}
 	if (p_dev->config_regs & PRESENT_STATUS)
 		pcmcia_write_cis_mem(s, 1, (base + CISREG_CCSR)>>1, 1, &status);
-- 
2.17.0

