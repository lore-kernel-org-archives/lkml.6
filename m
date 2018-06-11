Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tswlNN9hHlvwRwAAmS7hNA
	; Mon, 11 Jun 2018 11:53:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B50BF608CA; Mon, 11 Jun 2018 11:53:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZ6yGr9S"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 03BF460925;
	Mon, 11 Jun 2018 11:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03BF460925
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933257AbeFKLxk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:53:40 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34187 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933218AbeFKLxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:53:33 -0400
Received: by mail-lf0-f66.google.com with SMTP id o9-v6so30097885lfk.1;
        Mon, 11 Jun 2018 04:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utvlKr+GsMUiRb4OuyoSk93yEgbuvjN47382oztA60g=;
        b=YZ6yGr9SoxJt+rElISbeN51bBO8V7oC6Yo64Ya2SRopcNrgF3mQbgwo0nZn3wGXiAn
         TNaQN8ZnPf2KBphPrYSOP4EXmpcEEIV9LP+x5HmFjRBls//4MBaGgopo5oYhdWqIDWpl
         LV9zk0/qNIWAu9hzrL35vBCqxvo6gyZPHTpZAjbO661hY+s3w0TYymoqs09JHiqGSBw2
         AekGE/JFFSki58W514ijYeaBMWFO/iu9HoH+UnUdW8ib5Smi+ffGAFavy2PRXsfgEjaz
         zFnNurt3PP4P6pfCQbEgtGbTOTucv2NAqLu6rt45bTqVICMPxm33QpN308s5GjiDltO4
         8iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utvlKr+GsMUiRb4OuyoSk93yEgbuvjN47382oztA60g=;
        b=MqqS08bSW7az6nt5m7EHLOFx78urtTmjvd9rfps3dPghAK4WKOR2/sl8cOQ1Tb5iU7
         Ah3Q/9RQ5LBOjZ1GLz4h51qR3VoHHuxh0O+16RPpIYuMz3BS30y3DeS9rP9y3+4ZokGQ
         lmOPYlNTyIC2vSO2K/bL4q+N+lgDELgPoprQZONFz245V1NEMhL9XaA0P0DyHJBv/B7J
         hGO78Qf06+/eXOj8LuOFkrxPu1vwP2S19LgL5weTtE9tfd0RnlprUdqsUYSvjPU28TqN
         cbiulbgQwNUwOdNJbKge4IM89ovOikFlm34Ylc9WC/GI1FA5ZWOWoTLqkq3/vBFHhp6r
         mHIw==
X-Gm-Message-State: APt69E1JxLXd5YkwzQcEhV+35tegaArc88UhjVWGws8iCP7ilg2ahfxh
        7SjVqQXwZIWxpjB48ue/Wg9fsE3B
X-Google-Smtp-Source: ADUXVKIOUMWB0ufbN8YWUOp9/XOytKAEoqFdhfkH75vFPSAmebjS7ryQr36Afh43Tlv4lESmEZ0BiA==
X-Received: by 2002:a2e:9ed3:: with SMTP id h19-v6mr782858ljk.88.1528718012176;
        Mon, 11 Jun 2018 04:53:32 -0700 (PDT)
Received: from neopili.qtec.com (cpe.xe-3-0-1-778.vbrnqe10.dk.customer.tdc.net. [80.197.57.18])
        by smtp.gmail.com with ESMTPSA id h90-v6sm8332849ljf.65.2018.06.11.04.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:53:31 -0700 (PDT)
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v2 22/24] serdev: Replace IDA functions with IDR
Date: Mon, 11 Jun 2018 13:52:38 +0200
Message-Id: <20180611115240.32606-23-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IDR functions support associating an ID with a pointer. This is required
if we need to access the controllers based on their ID.

Cc: Rob Herring <robh@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/tty/serdev/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index 3084b6d10179..6b24b0a74fbf 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 static bool is_registered;
-static DEFINE_IDA(ctrl_ida);
+static DEFINE_IDR(ctrl_idr);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -81,7 +81,7 @@ static bool is_serdev_device(const struct device *dev)
 static void serdev_ctrl_release(struct device *dev)
 {
 	struct serdev_controller *ctrl = to_serdev_controller(dev);
-	ida_simple_remove(&ctrl_ida, ctrl->nr);
+	idr_remove(&ctrl_idr, ctrl->nr);
 	kfree(ctrl);
 }
 
@@ -500,7 +500,7 @@ struct serdev_controller *serdev_controller_alloc(struct device *parent,
 	if (!ctrl)
 		return NULL;
 
-	id = ida_simple_get(&ctrl_ida, 0, 0, GFP_KERNEL);
+	id = idr_alloc(&ctrl_idr, ctrl, 0, 0, GFP_KERNEL);
 	if (id < 0) {
 		dev_err(parent,
 			"unable to allocate serdev controller identifier.\n");
-- 
2.17.1
