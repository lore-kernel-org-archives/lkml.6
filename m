Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B053C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1EB206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zth6gea4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD1EB206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbeG0Eii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:38:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37484 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbeG0Eih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:38:37 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so1694763plc.4;
        Thu, 26 Jul 2018 20:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7JHcoVtv3vpJOLT8i/RMWv2XTRNqVoAtxb2rmXVnunc=;
        b=Zth6gea4fNnWzaOaNJL+1KtYZAocWufDM4qQDT+nF+HlYEf5gC4wpi39t9ZP0daaIA
         1t/F9ui9QtZqQrjsaP4Boz4kexe8t6zI7RSW+QCvh5nAVQOyVuJEHfm6jlO/rmZT6Zda
         LQEql9DlQuMbZl+K4Aa1QLpmJ6o+OTmRtA2VFE750RYKcLFyje368yPChH9jzEZ9E8KB
         zVwcDziMHt4fNSfVPeCgGwpnvsjRp46qh/ECSQY7Y0fQh1XAztxX95H7DFs/Mbv7jl7D
         JahwrZ2RAIj6VRjcCqEjgmA3PQiwAMsiV+eXoTi8muUbaWAK14GPU3Ub4v2ErrNM/ksr
         FkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7JHcoVtv3vpJOLT8i/RMWv2XTRNqVoAtxb2rmXVnunc=;
        b=Ve7+rniJ9wEHCmZqsyXba5k0N+SI3P/hb4/wpK5DcF83wpm2mSbn+hl9IV2IBEDSNp
         L3PP+COm+Jlr+ljp2jMkuspIl/i9bnmplnf4xt0fAqDQVxq88/mfwtHfWfMcyytIFpBP
         i7NI77VZh0x20e2mfCpxHEN4l/EKey6krFo7azNZp0x5XaKCIiPnJSKGiUJGTYuMPkiN
         qdfx+tqdIl6S9v9nVA9z/KZNd591k1m3naqIC5lT7WlvV0kas57ujrnQCQiqrmbAcb3N
         XnCLNMlIW3bYcLwmo2QSk1nCaI/t9WQc/DdVHllaR82ZTtriJtqDbd/wGxKl58Ne16uQ
         MRUg==
X-Gm-Message-State: AOUpUlGAuW78uoBTTBpBaMnmmrlkVu9a0cQUHh8g7QTsee/KObA9/6b4
        XQeXPULAjvsanxK8ZWqAj0s=
X-Google-Smtp-Source: AAOMgpc3wfkQg4wdesGhsNwUQfv3jfmcf0NvFadigo8Mf/sWqJsZx1zz5sMXrzre2G9xSpFFMDIAjQ==
X-Received: by 2002:a17:902:22:: with SMTP id 31-v6mr4397189pla.190.1532661532443;
        Thu, 26 Jul 2018 20:18:52 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id r81-v6sm5511371pfa.18.2018.07.26.20.18.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:18:52 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, brad@nextdimension.cc, hverkuil@xs4all.nl,
        arvind.yadav.cs@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cx23885: Replace mdelay() with msleep() in cx23885_reset()
Date:   Fri, 27 Jul 2018 11:18:46 +0800
Message-Id: <20180727031846.3157-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cx23885_reset() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx23885/cx23885-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/cx23885/cx23885-core.c b/drivers/media/pci/cx23885/cx23885-core.c
index 019fac49db5b..9c08d3a9716f 100644
--- a/drivers/media/pci/cx23885/cx23885-core.c
+++ b/drivers/media/pci/cx23885/cx23885-core.c
@@ -635,7 +635,7 @@ static void cx23885_reset(struct cx23885_dev *dev)
 	cx_write(CLK_DELAY, cx_read(CLK_DELAY) & 0x80000000);
 	cx_write(PAD_CTRL, 0x00500300);
 
-	mdelay(100);
+	msleep(100);
 
 	cx23885_sram_channel_setup(dev, &dev->sram_channels[SRAM_CH01],
 		720*4, 0);
-- 
2.17.0

