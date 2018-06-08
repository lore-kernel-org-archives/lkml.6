Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ib5wAwnVGlvXKAAAmS7hNA
	; Fri, 08 Jun 2018 19:12:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id CEF8B607DC; Fri,  8 Jun 2018 19:12:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="DyH8beMd"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id AFB7A60275;
	Fri,  8 Jun 2018 19:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFB7A60275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752764AbeFHTMj (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:12:39 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:44524 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751719AbeFHTMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:12:37 -0400
Received: by mail-wr0-f195.google.com with SMTP id x4-v6so6235730wro.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=3VOUFDRzVTPPkHKgia+ybV0nS68P2ApEyakeGkhWYfk=;
        b=DyH8beMd3s8qQ6mvX8lQQ9yTjTuHwxrUih2H/601ljuPYk1lInoAVyzdlpnUpzSMIr
         ysMKADvI003spMgGuAPrADxSKZhgXMz3D/caeSC5P8nztRsTHNHfuTGO2EAUapwIakDo
         4OJ69vH6Z5GYdjRwbRdRkiCR8kGtB44oPzLPRjtDgT89fJ8OBWb1K9oTMEmE10YicUPJ
         fe2u6FXlDclmJfSs6UYGYhDooMeEUShudncESnrZVt2t8sZDmmINzYVemyeA7JxuLSc9
         Y/VlTPIZ0Xh56ut5eDAfdbyNXNo99GIub5PXbHMfMRYuw8uYf0gRu5HCDbopSvItp18B
         jRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3VOUFDRzVTPPkHKgia+ybV0nS68P2ApEyakeGkhWYfk=;
        b=k2d3/sHSSXAAHf/+aiNGiyhMkTPLuacrCB3zkAPk56z0SI3bolYRvdB9MDFKARnZSk
         eYG4JfPE48BDqiWurRSzMhMPWvAleKHqAj45bYepEhNWsbOyzHFBbLPNml80AXBCfDiT
         p3ABPkxSQcKQp3HZPgF7kwrI2kygfAg+P/Jt+9S40qojZ55FBfY05lcV14FuJtMntecV
         6x81YqD2AhCAtWFJDnbbLXKEc80pGXIUaxTLivdD5G8dQ0RMuik7XeIg9iCuOMFV2Vwi
         96P28bh2ZKqHFfS5WAEAPUkdDV7P0HQlrHq4BYHI+4knphhU8j5QAcxTtI5NCa0Vghpn
         saYw==
X-Gm-Message-State: APt69E0CjTYUmJu4+QUJtBT9mMU3VJFJ6Jk7I4PzpAZ5xecIZ89PNGcq
        wZmh9GWXduDEZWteu9H9MINdNw==
X-Google-Smtp-Source: ADUXVKL/ZYPY0ezstnxRnXQk08ZkAc/+Q81zXEGT95Rb57cz/HudqMGxnDB2sj9V44aTe1B/NGvoGQ==
X-Received: by 2002:adf:9aa5:: with SMTP id a34-v6mr6366777wrc.50.1528485156481;
        Fri, 08 Jun 2018 12:12:36 -0700 (PDT)
Received: from avi.cloudius-systems.com (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id u7-v6sm40715117wrp.44.2018.06.08.12.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 12:12:35 -0700 (PDT)
From: Avi Kivity <avi@scylladb.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: hch@lst.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] eventfd: only return events requested in poll_mask()
Date: Fri,  8 Jun 2018 22:12:32 +0300
Message-Id: <20180608191232.4758-1-avi@scylladb.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->poll_mask() operation has a mask of events that the caller
is interested in, but we're returning all events regardless.

Change to return only the events the caller is interested in. This
fixes aio IO_CMD_POLL returning immediately when called with POLLIN
on an eventfd, since an eventfd is almost always ready for a write.

Signed-off-by: Avi Kivity <avi@scylladb.com>
---
 fs/eventfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 61c9514da5e9..ceb1031f1cac 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -154,15 +154,15 @@ static __poll_t eventfd_poll_mask(struct file *file, __poll_t eventmask)
 	 *     eventfd_poll returns 0
 	 */
 	count = READ_ONCE(ctx->count);
 
 	if (count > 0)
-		events |= EPOLLIN;
+		events |= (EPOLLIN & eventmask);
 	if (count == ULLONG_MAX)
 		events |= EPOLLERR;
 	if (ULLONG_MAX - 1 > count)
-		events |= EPOLLOUT;
+		events |= (EPOLLOUT & eventmask);
 
 	return events;
 }
 
 static void eventfd_ctx_do_read(struct eventfd_ctx *ctx, __u64 *cnt)
-- 
2.14.4
