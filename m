Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 85253C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C25208AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 03:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga+g06lV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C25208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeFLD0H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 23:26:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36645 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932650AbeFLD0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 23:26:06 -0400
Received: by mail-pf0-f195.google.com with SMTP id a12-v6so11333581pfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=117ZWbFI1Na+M2u1QTj6v+FqnE4w0SNp8iGHTy7Pcqo=;
        b=Ga+g06lVeT6s1gEDqOHaotB1PnF8uyAtsIF9ilqCJBgMYioGIVuMo/f6nzZxMCthft
         ItZS6+fYbvG4He28N+9ZACThi5R7HH42RHZfMB9hjljk5ByX3c4Os5fNyJDbqoOn0cHV
         RwM8m+u6QCaullHK9UCzGM/HZPUVWzGQm27Pe3FQK1NNp+cM8cb9A5hSz2+zcTSFZ3Ah
         sgcdC5j2Pf6QUvyGsbVWiZEleUOZeFfSc53aU5BscTz5DqGbEn4rQVe0O//uQVOtZv/0
         ON8idnEhw2+K37VO3TKDduJFenpx/RAjmg/4Si8tjUZ4CESV8ReiKiC7bQBw87Cj2/BK
         gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=117ZWbFI1Na+M2u1QTj6v+FqnE4w0SNp8iGHTy7Pcqo=;
        b=Ee8L5OFBZojyxjML0g3HQ3lMWy/qr2TZZaZUvcchUqUhbJu83fJgfte/Vdn11Bq98h
         pI+0idec4dKx6PzF2GgKn/DJ+eHnLB1Z+0L9hqYMooZzBh/ryWbWe94DcoP470M5QhUQ
         Gck0SZ+4nqsTdpM/djb0si0JOwBcFAzDkHH02UJVPbT0HqKc1r5qtFCOTADrDjJ/XqIh
         6nTXH7RM3+raXssQ3FZXXmTZXvoNnTlVwOcP7nfydg9FvFRVxB6Vzd4Qu2Ye1auVDPRw
         5eoRP5fqJaaT0nET8Fmm8XlwXHzIlQDbre/BanKjjbcIHB2fIKyJggWaA0y5w8sFLRU0
         czJA==
X-Gm-Message-State: APt69E0iJV6uFjHTwpoR30iSzIspsRbRBUJebNsBjOu4TCAYT3I/YWXy
        6U9raGKOEhP5lxHJZ/cjXDg=
X-Google-Smtp-Source: ADUXVKLolS+HLb06LZXtMPUhgX+tk8Dq7YLb8YbBw+cyPnkotziuckztvcwQo01a1/lYoiqZlYHm8w==
X-Received: by 2002:a62:3a59:: with SMTP id h86-v6mr1888815pfa.209.1528773965916;
        Mon, 11 Jun 2018 20:26:05 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id e16-v6sm32587997pff.185.2018.06.11.20.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:26:05 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: comedi: add error handling for vmap
Date:   Tue, 12 Jun 2018 11:25:35 +0800
Message-Id: <1528773937-38106-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vmap fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling vmap.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/staging/comedi/comedi_buf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/comedi/comedi_buf.c b/drivers/staging/comedi/comedi_buf.c
index f693c2c..5e48693 100644
--- a/drivers/staging/comedi/comedi_buf.c
+++ b/drivers/staging/comedi/comedi_buf.c
@@ -132,9 +132,12 @@ static void __comedi_buf_alloc(struct comedi_device *dev,
 	spin_unlock_irqrestore(&s->spin_lock, flags);
 
 	/* vmap the prealloc_buf if all the pages were allocated */
-	if (i == n_pages)
+	if (i == n_pages) {
 		async->prealloc_buf = vmap(pages, n_pages, VM_MAP,
 					   COMEDI_PAGE_PROTECTION);
+		if (!async->prealloc_buf)
+			dev_err(dev->class_dev, "failed to vmap pages\n");
+	}
 
 	vfree(pages);
 }
-- 
2.7.4

