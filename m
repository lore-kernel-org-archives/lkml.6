Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2114C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870592082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnNn+MAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870592082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJXXe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:34:26 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36752 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbeJXXeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 19:34:25 -0400
Received: by mail-wr1-f66.google.com with SMTP id y16so6002264wrw.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 08:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ol38AcypG0XHnL+BLcdwn9BhH113PECyNrBUMEWjyZs=;
        b=KnNn+MAawBioiNA8jRu3Nfk39I8werT6GevLIKKbwl8AgJULLNVgBpcKguPMMMuk7K
         B6P1IRrio/4Xs7tuVQ86SoCtyrLUYH9sA9yQXar2VDh3G9FJwMFUW1Sy5cGOIp6WJrV4
         xP5c1+gGpB+YwSxBV2mnj4UFRqP1PTRaFqC9eBnqZOpZ0N1IyMZrSQpj4kSZbD87WJjh
         14WdQ84PLfng6YrYZFsteXjhqyFX0JZXVSZAhaPeKyOI0rv83NS+L6hVqRuEiA6w2uSH
         D7oGmNhB4HCHPFtggGcX2KR+kSOwQIgCVEYWdJYRjmmmebLuWeeCbkmxw2IRY3I90KqY
         V9/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ol38AcypG0XHnL+BLcdwn9BhH113PECyNrBUMEWjyZs=;
        b=OhtKepXOyxVs87DO2vG9cp3arq/YCF9/4FcLmEjz4EWcSIHk4L+5JElpgsIcqfFZie
         kgsxNKN/7YHcBv8QqXI/7HvgYFUik/GZC7rh3LVdm9+NNGqsa3gvm9DDfaUvhDP7DIgR
         STANZ9Db4TrM7NLJLBad/7jXvsfj6HszaTXJp9HQBoePp8wd7bR16O5AT1ydKjOG31PT
         ipHc9jyAFwr6oHP03YMRNBcXkis6HTGPKwdv2QK94zb7XXAxYOGzP5X8HyyNivEC0u9Z
         yltRPqGqVy1rN0Jvqdr8xDvVuvvSkIjlMgz1uyDw02/8SCKKiSV7O6J3+Pc0xxuwRyhj
         p6lA==
X-Gm-Message-State: AGRZ1gI6ZZk4rFnd39tSrdwB0HYoM8VF/nANT6z60ynqgPwKTEWlSghS
        Mnp882MP9DwZMtgIcW4lWJE8pnOJ4OQ=
X-Google-Smtp-Source: AJdET5fd8z84BRfh2g7bsDrUE7LxG8HAyLStbL/QdLUrHc5/JILoGVBFX/6wZAxRxMsSfyijZDdc/g==
X-Received: by 2002:a5d:4c84:: with SMTP id z4-v6mr129976wrs.75.1540393555676;
        Wed, 24 Oct 2018 08:05:55 -0700 (PDT)
Received: from zdravcePC (cable-178-149-91-180.dynamic.sbb.rs. [178.149.91.180])
        by smtp.gmail.com with ESMTPSA id p1-v6sm4518369wrw.12.2018.10.24.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 08:05:55 -0700 (PDT)
Date:   Wed, 24 Oct 2018 17:05:53 +0200
From:   Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: Fix line over 80 characters error
Message-ID: <20181024150550.GA5150@zdravcePC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch.pl warning:

WARNING: line over 80 characters
+			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :

Signed-off-by: Aleksa Zdravkovic <alex.zdravkovic98@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index c18bf31f55b6..2f609712f507 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -482,10 +482,10 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		spin_lock_irq(&fifo->write_queue_lock);
 		ret = wait_event_interruptible_lock_irq_timeout
 			(fifo->write_queue,
-			 ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
+			ioread32(fifo->base_addr + XLLF_TDFV_OFFSET)
 				>= words_to_write,
-			 fifo->write_queue_lock,
-			 (write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
+			fifo->write_queue_lock,
+			(write_timeout >= 0) ? msecs_to_jiffies(write_timeout) :
 				MAX_SCHEDULE_TIMEOUT);
 		spin_unlock_irq(&fifo->write_queue_lock);
 
-- 
2.19.1

