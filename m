Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9DECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F6A20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpZxQo6M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F6A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbeGUO2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:28:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36408 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbeGUO2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:28:10 -0400
Received: by mail-pg1-f194.google.com with SMTP id s7-v6so5632364pgv.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h8xs1bQq2SwmT/bCv2RC44zm5PpJJ5c2rTUww61Yap8=;
        b=EpZxQo6MqQQNzN4Vf2mjAGlQyGdSMMyJu1KXZum/aKEe/hes6sLWm/TqLZom1Z0OxP
         8gVgp4OG/FrYKuUM2qjXlz21lwKQQLqCQSu9rRR/Lo0Yso4x5gRIydiMm2GxiheQWUYQ
         DnFaBajfxi65AbMSc7mkSLVe5YDPSUAPepIoA8Csh0s4AyQDUXZDqagoxBAEZ+xqLhlm
         xFlylF+iSjsfwcpR8IFEHqogyDQLKxtTPwjA+W7+P9Rd2zYWNrSK3uRZn6/hhJZNXcvR
         eJaeSDFdATkC1i2vymykTvXL2hfyQCxFXtzRSqtb13eHl8Dh86Nht4ct/cKYez6ZzkUG
         g2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h8xs1bQq2SwmT/bCv2RC44zm5PpJJ5c2rTUww61Yap8=;
        b=OgvTjicfhcpzOLlXr4r3BdnomWh7BPJRIFzqrKiB8APkdO18Dqh5ZYJZVVTfCUkw26
         zLAPtUka6/AImyzBCgPGnS3waQS7oy9+p2XBfTu43Pyp8r2blRCWRX/GgBTcs9pAEfFo
         D1yAlGosUpcGXIY6tR1dGos6IbCXgrvs4Amm8FI9d9CnnWtEgQHGJRepCXvBQW3sgR+p
         ml/sBScBWtRRdzmQ6YWFOOtk4yKWNfNj1izs0Kg/DVB3IU0WpVNlnx4eL8ENqjiFJrwX
         lq2SUtOVEMI7rqdJWHaJBKVAa0IekBucAk2JzVZS8HJsLFezbOPGs2i4jX7zOK3MQiMF
         kdfA==
X-Gm-Message-State: AOUpUlEW+P8/0J05OLupSHXP3+abnonNuaRi6xYXDgrxVenehDYRgCHt
        SY4dAMdMgv6hc7xjpR4n+KI=
X-Google-Smtp-Source: AAOMgpfgfIqyNeGC+v4QqgacXZiZatunqLq4RJ8LfyuSO/KA9ouSPtHBE4e4qFv8DQY7k6z9aFJaBg==
X-Received: by 2002:a65:660a:: with SMTP id w10-v6mr5562094pgv.366.1532180123731;
        Sat, 21 Jul 2018 06:35:23 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p26-v6sm9445023pfi.183.2018.07.21.06.35.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 06:35:23 -0700 (PDT)
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
Date:   Sat, 21 Jul 2018 06:34:57 -0700
Message-Id: <20180721133507.95599-5-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
In-Reply-To: <20180721133507.95599-1-toddpoynor@gmail.com>
References: <20180721133507.95599-1-toddpoynor@gmail.com>
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

