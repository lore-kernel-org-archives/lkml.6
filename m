Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595B7C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA4D214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="bMSAqmUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA4D214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbeJISaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:30:25 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37433 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbeJISaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:30:24 -0400
Received: by mail-pg1-f194.google.com with SMTP id c10-v6so656261pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 04:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za4Y72BEkXJj94YsM5hC3DnhnjHo4C1yahUZVfD4hOw=;
        b=bMSAqmUBP2fQEmgHs/tS4sBpa7VSWrgX877c/KUooe3LhuhwHPuEwAnJV6xF0Ae8LE
         h9ngSVsXT6PqAEDEM7q4BjPAQlu9JGNlVx1V2kKK/fkx978duJqCt0mGa0FRg7zVJXFZ
         DQhgd4MjPNR3WzbKJAGHymDdDqCw2WQPzqg4NBfWVDdzp/OXEqB3v6TeaUCW4MNceaud
         a/0B6Ikn/RuJm6rd8AUfCbZsXRWkaJv3Om7Tz9aNu9yMNHpYj0ixbGEIYdW4EBtLhB0C
         nEB9U9ro4D9VrCeq+EbFDIiOSGYp7eYt0UNUA32A41by8Z1otbHvT5NJ4GFZGqdwyr8R
         fp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za4Y72BEkXJj94YsM5hC3DnhnjHo4C1yahUZVfD4hOw=;
        b=a9LSiEbcCyNMcMad+5Ig4i1oLTr8Lem4lqq5l/KmjloYvLSMbrD+u4CiVk1oto4Ay7
         JZGZn4/oisYd+kw2W4y4GTEXLJWYCNbyBMpH8DDENYB5BpGkEQUEgm3adV+auIFucRXq
         fOSCjPZg6TjO5a9l6lQcAXvOarhrzjSLjVTB4XnQu5Prm0K9LFAbAWm+uJRmqe43WpEi
         aqg8CLYC1HGx1hjS6KV47FJPubuKF+hTfsqeTLHVWnpGgaF4duL6VtX7KnNTLk5K3IKc
         KbXLOjOEf3qYwStJXbJANLPBqXFlBMcnX727Ulwr0a8kGObD32hawdHfarjrfC+sBL7+
         ImbQ==
X-Gm-Message-State: ABuFfoicewpAJlYcaLHKtI3r88/newIF2M9XDSaNaEU5LRQ+OokfROvv
        ekL2JkS1cJn/dJo3ZL1IuQ2iXw==
X-Google-Smtp-Source: ACcGV63mVW/4qA7EurA6sDJd3FLuHwYXQz84ReIepFqRbpgQn6cbqudb7FkMtWXZguZ2VvEwhXnAvA==
X-Received: by 2002:a63:b04f:: with SMTP id z15-v6mr23479773pgo.442.1539083637601;
        Tue, 09 Oct 2018 04:13:57 -0700 (PDT)
Received: from skyninja.hgst.com (rap-us.hgst.com. [199.255.44.250])
        by smtp.gmail.com with ESMTPSA id p1-v6sm25342380pff.128.2018.10.09.04.13.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 04:13:56 -0700 (PDT)
From:   =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
To:     axboe@fb.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>
Subject: [GIT PULL 13/45] lightnvm: pblk: fix comment typo
Date:   Tue,  9 Oct 2018 13:11:43 +0200
Message-Id: <20181009111215.7653-14-mb@lightnvm.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181009111215.7653-1-mb@lightnvm.io>
References: <20181009111215.7653-1-mb@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier González <javier@javigon.com>

Fix comment typo Decrese -> Decrease

Signed-off-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
---
 drivers/lightnvm/pblk-write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/pblk-write.c b/drivers/lightnvm/pblk-write.c
index c23b65aaa27b..625ed5a3a020 100644
--- a/drivers/lightnvm/pblk-write.c
+++ b/drivers/lightnvm/pblk-write.c
@@ -168,7 +168,7 @@ static void pblk_prepare_resubmit(struct pblk *pblk, unsigned int sentry,
 		/* Release flags on write context. Protect from writes */
 		smp_store_release(&w_ctx->flags, flags);
 
-		/* Decrese the reference count to the line as we will
+		/* Decrease the reference count to the line as we will
 		 * re-map these entries
 		 */
 		line = pblk_ppa_to_line(pblk, w_ctx->ppa);
-- 
2.17.1

