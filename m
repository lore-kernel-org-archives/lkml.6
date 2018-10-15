Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F6CC7112B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC1620881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWNo8wI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CC1620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbeJOMnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 08:43:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44429 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbeJOMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 08:43:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id g2-v6so8546627pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Oct 2018 21:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oPnRwJFKW1NnSmZ+QxMSFlg9U0F9YOsxW2ZdquiQdd8=;
        b=GWNo8wI20mT/btMgs463+FmZlc/WJbxpC/pzKUC8pFuB2VmQsuORpeSlnwvmYc5xVa
         e2LcJF1kX3eXZMHL4ci3dzoMzf7WrkwreG1I0J4G09G82LkkZfAuVrm5jOOj/LHt/9LN
         QZfV3n32QiuUeDuoo23vqcW6H4o1XPNRHUC8RVKZrvPFMxwLoCHb7VHgBnmzE7KnMK4M
         K/KzJiR16wNrmrOFaVF5JXH+ZHtOwn4eryrEd1Ta7LkXHM2FEBIrrIjFkkAWgUkjcfAX
         qzLqtUb22zcZFKTb6pvqTIhGb1i8T21S4V6YKB9TEVB3pZwISqZkG2I02nNRGiq74+9U
         hZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oPnRwJFKW1NnSmZ+QxMSFlg9U0F9YOsxW2ZdquiQdd8=;
        b=CsjtXqI1Dp2meQboKINy6MgESRfph21Wj5Hm+/fTIWHcVyYVEKQSsSk9pK3gn9h6Dq
         GAJOt/on2Z/Ak1WF6DjtlhS09z4yld9ML8mC5jS464WgRZMBuTh7xZOc3s0OFbUGYuH1
         s8jelKyjGT6rwKN7XQQC6ZG1YC/FvEUyGy8ugI4okGxS8PhSR0UaaCFm7usOYRnV14uC
         LCPIz6xYp78uDAvEIafGh+NqBkXeE4VxAMz4weqkn8XtvCOPisHnfNqGE6nJ9zOHRk/h
         DKeUzi5BVqNAwcVLyTE5pBxujx1JbkEG1HIKjNVru00VMqJ/I8eJalZFsCM59gRvcULF
         zPgg==
X-Gm-Message-State: ABuFfohkPlRUvAVVb3QilNmW9SSm7UJHnyKi3mN4hbfMwDDqv3druYx9
        nXdVgkLVLX5g+A8dXf0wj9s=
X-Google-Smtp-Source: ACcGV63F2EMMOpA+uak7OqHmDOHOP8bfm/82QlaEekjwpOYMWHMs2knKGschtmUnze/1d6xFzX6+IQ==
X-Received: by 2002:a63:1302:: with SMTP id i2-v6mr14977144pgl.380.1539579596861;
        Sun, 14 Oct 2018 21:59:56 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p62-v6sm12244698pfp.111.2018.10.14.21.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 21:59:56 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 01/11] staging: gasket: core: debug log updates
Date:   Sun, 14 Oct 2018 21:59:17 -0700
Message-Id: <20181015045927.156790-2-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181015045927.156790-1-toddpoynor@gmail.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Add debug logs for device enable/disable events, remove logs for
callbacks (the called functions can generate their own logs if needed).

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.c b/drivers/staging/gasket/gasket_core.c
index f230bec76ae4e..62a7515915e59 100644
--- a/drivers/staging/gasket/gasket_core.c
+++ b/drivers/staging/gasket/gasket_core.c
@@ -109,8 +109,6 @@ check_and_invoke_callback(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 
-	dev_dbg(gasket_dev->dev, "check_and_invoke_callback %p\n",
-		cb_function);
 	if (cb_function) {
 		mutex_lock(&gasket_dev->mutex);
 		ret = cb_function(gasket_dev);
@@ -126,11 +124,8 @@ gasket_check_and_invoke_callback_nolock(struct gasket_dev *gasket_dev,
 {
 	int ret = 0;
 
-	if (cb_function) {
-		dev_dbg(gasket_dev->dev,
-			"Invoking device-specific callback.\n");
+	if (cb_function)
 		ret = cb_function(gasket_dev);
-	}
 	return ret;
 }
 
@@ -633,6 +628,7 @@ void gasket_disable_device(struct gasket_dev *gasket_dev)
 		gasket_dev->internal_desc->driver_desc;
 	int i;
 
+	dev_dbg(gasket_dev->dev, "disabling device\n");
 	/* Only delete the device if it has been successfully added. */
 	if (gasket_dev->dev_info.cdev_added)
 		cdev_del(&gasket_dev->dev_info.cdev);
@@ -1357,6 +1353,7 @@ int gasket_enable_device(struct gasket_dev *gasket_dev)
 	const struct gasket_driver_desc *driver_desc =
 		gasket_dev->internal_desc->driver_desc;
 
+	dev_dbg(gasket_dev->dev, "enabling device\n");
 	ret = gasket_interrupt_init(gasket_dev);
 	if (ret) {
 		dev_err(gasket_dev->dev,
-- 
2.19.0.605.g01d371f741-goog

