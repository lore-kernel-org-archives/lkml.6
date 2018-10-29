Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB6AECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C4120657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Euwd+xGS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C4120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbeJ3B1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 21:27:16 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52823 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbeJ3B1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 21:27:16 -0400
Received: by mail-it1-f193.google.com with SMTP id r5-v6so8325745ith.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ibssz+RTYOgnABH8iblTDxiQJXKqVGK071Agvxpp/w8=;
        b=Euwd+xGSRZSC+Jh6OV9lsCHuG6H4fzJeU0B8PY06fsrW/ClKm3j1ZubHWn/hbqk+MX
         i9O7SucqpPAUU6rGYbR3uKT3JjhuS5fzzmycCZmcZNo59RLfAcvLQDChoU48oCaEm6g3
         sNDmMCiAJPp4xKZzvupi6Zd5W11NpbFBnzQeNP+gIg46fSti73Qm2nENXuzAwE/HCJWm
         HIPaIiZAnm/JBHPN9+K88/zdPiR/BwsYmV3mmkrO3SVjY1soX1ooT4mTEvpkxs2+bnQv
         ChVrII9kfhvhl+IKVfmmeb3vt4M17tjvqH6/xVPDodP169qoLWGmSLPTvIB6jvp6hcjP
         cqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ibssz+RTYOgnABH8iblTDxiQJXKqVGK071Agvxpp/w8=;
        b=A08wpgfJ4IdkK0h1aXFPQ+O5hB+fHVKt765qSKpF7v+nZYKyx6bA/W/dB7fEXOzKYH
         oKm+nLzK6moUdxek5XF+Nn5O2Qii2It7bH0MJgZJS9CefYwXQZXTuJ6SIeFwUY6C8KfD
         bOzX24eXhgD2MXrvL9RgW8NqmuioFp+VmCJQeQEkGZjZhOOZAYH5UoldnSxT9pMqlyHD
         KqFMIQzuOd1r8Y/xzld+uuj3ydJY2sOStlLCnu/823USwYYD9i9nEUJ3kFbGL0dqaYea
         OEm6OHt9bkmsi/bCT5bDPfkLGN4NOgipGoZlR6a17SDRcP3s2PPnqcdHdNV4/Y2DS9nY
         w4aQ==
X-Gm-Message-State: AGRZ1gJZZza/sI9COlZr0Kse9FG2gmx1oeFuuSvsF9BOoIRU6t9UIQma
        3spVcfIod1SEnwX0ITNvPA/uaA==
X-Google-Smtp-Source: AJdET5faGUrC0AwyueMFKr4H1ego6W+WoFGqiU8vFsgz6fuMjIPXRnSB/jMgScRdMdmN+lzkCuIJlA==
X-Received: by 2002:a24:b341:: with SMTP id z1-v6mr11211615iti.62.1540831074546;
        Mon, 29 Oct 2018 09:37:54 -0700 (PDT)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id q15-v6sm3367019itc.38.2018.10.29.09.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 09:37:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 06/14] blk-mq: add 'type' attribute to the sysfs hctx directory
Date:   Mon, 29 Oct 2018 10:37:30 -0600
Message-Id: <20181029163738.10172-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181029163738.10172-1-axboe@kernel.dk>
References: <20181029163738.10172-1-axboe@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be useful for a user to verify what type a given hardware
queue is, expose this information in sysfs.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq-sysfs.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index aafb44224c89..2d737f9e7ba7 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -161,6 +161,11 @@ static ssize_t blk_mq_hw_sysfs_cpus_show(struct blk_mq_hw_ctx *hctx, char *page)
 	return ret;
 }
 
+static ssize_t blk_mq_hw_sysfs_type_show(struct blk_mq_hw_ctx *hctx, char *page)
+{
+	return sprintf(page, "%u\n", hctx->type);
+}
+
 static struct attribute *default_ctx_attrs[] = {
 	NULL,
 };
@@ -177,11 +182,16 @@ static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_cpus = {
 	.attr = {.name = "cpu_list", .mode = 0444 },
 	.show = blk_mq_hw_sysfs_cpus_show,
 };
+static struct blk_mq_hw_ctx_sysfs_entry blk_mq_hw_sysfs_type = {
+	.attr = {.name = "type", .mode = 0444 },
+	.show = blk_mq_hw_sysfs_type_show,
+};
 
 static struct attribute *default_hw_ctx_attrs[] = {
 	&blk_mq_hw_sysfs_nr_tags.attr,
 	&blk_mq_hw_sysfs_nr_reserved_tags.attr,
 	&blk_mq_hw_sysfs_cpus.attr,
+	&blk_mq_hw_sysfs_type.attr,
 	NULL,
 };
 
-- 
2.17.1

