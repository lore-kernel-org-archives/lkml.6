Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5ACECDFBB
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA89220864
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl4I4TEl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA89220864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbeGUNuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:50:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36773 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbeGUNuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:50:19 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so6330668plb.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h8xs1bQq2SwmT/bCv2RC44zm5PpJJ5c2rTUww61Yap8=;
        b=Yl4I4TElqeK5NbqoSyqtbc6+L7H+2Rkro49rsQe2Yg7sjdonmUo7XjoLnhjAK4qFuX
         yYDigAVHgHsy/p2xSLX7YKdz7FdwgPq4EeycaDr9/DmcBvfMknAWVxkRShpiWtZvg4Xd
         oEIR53et7N7A2RegLS3hLvNke2+rGc3rG3lWRTRfuCDnVXPdpCzHucLc3S7FCS6tiaW8
         kUvtV7lzCNsM+3IcSmvyq140O7fJ8CDRBDouKCQzG9GZPDzmwPzxmfVqjZ2Dk1743Oyf
         5KmfojK+QxQkcOk39nUKBkOG6rLtDmXMh/qWAdeim6OOJuDwSob6h1QRkjc76oD4qCEE
         fVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h8xs1bQq2SwmT/bCv2RC44zm5PpJJ5c2rTUww61Yap8=;
        b=WLms+/Oy9uzg2e/DZun6Xm8140soNgY2Jdw5WclxJ/hmPal8EkWhvBJoJwie6Ok5LG
         yzldYVgAMgd2Fhy7T1/685BDrBfiRgOOoYCr/4SounlbW56I+laHpVik/uNtfxfGhJ5w
         goisGK4V5gQktZOs4X3FVGtvHJBd1svutyv/+vop1tnXMzjgV+7u8ZRsUzdzhi1HmTlI
         ejKe5cSqq1nde9kKMbUTTcrpon+VcW3bOKjMw+I6vpiPjA6U+AEnSRAEPVSBIWl7bE2g
         iPIztOjERWSMAVJa9FJJtSCApBxXJuPQiwz3LkyzpMc+BKKDARbrDBMeeuYisptG7UeI
         glJw==
X-Gm-Message-State: AOUpUlFt70bmQmU48PfWHmdS57iCPGSzAFJSRTL8Oe5pa/0Y3Ejc6ctL
        lbSj2YRm1fb+IwrZjcrFHww=
X-Google-Smtp-Source: AAOMgpe0td1qUtYb5ZZLow/m5VHfNIkKDVafaHmSz2yykcw610fycQipRQWFs7lpen1e5sb4oAgm5A==
X-Received: by 2002:a17:902:8486:: with SMTP id c6-v6mr5691831plo.283.1532177859602;
        Sat, 21 Jul 2018 05:57:39 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id d19-v6sm1072542pfe.42.2018.07.21.05.57.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:57:39 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 04/14] staging: gasket: avoid copy to user on error in coherent alloc config
Date:   Sat, 21 Jul 2018 05:56:46 -0700
Message-Id: <20180721125713.88501-8-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721125713.88501-1-toddpoynor@gmail.com>
References: <20180721125713.88501-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_config_coherent_allocator() on error return the error to caller
without copying a possibly-update DMA address back to userspace.

Reported-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_ioctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
index 1b164ac7a0496..8cf094b90cdb0 100644
--- a/drivers/staging/gasket/gasket_ioctl.c
+++ b/drivers/staging/gasket/gasket_ioctl.c
@@ -441,8 +441,10 @@ static int gasket_config_coherent_allocator(
 			gasket_dev, ibuf.size, &ibuf.dma_address,
 			ibuf.page_table_index);
 	}
+	if (ret)
+		return ret;
 	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
 		return -EFAULT;
 
-	return ret;
+	return 0;
 }
-- 
2.18.0.233.g985f88cf7e-goog

