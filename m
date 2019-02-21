Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D792CC00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6049214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 04:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slI1ohXT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfBUEB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:01:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43405 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfBUEBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 23:01:54 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so13061090pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 20:01:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auu7sPoqnYOjV0cCzT/qrL11WOBRgRd5ITVHRQ8h3zo=;
        b=slI1ohXTh/xsmYYMHV64QPy2RBdZPwCB45eg01Tz1FkJAN29lre1/lsTzcrkb92T65
         +wN+B+xAtPBmjvKmPtn8RZnqjZU1Ue/17qeS9TE9kek7EevHqrfDe76Eb21R5bz5wUbq
         ie9/0tvopdsyVxM1i6bL4K2VIVg8nz2eEBuh0TlcMGrOeRPwtnTCmp4boIdLcZNkGUm1
         j3Ssg+jLJv20L1pt61eLU00ewLRDe8uQVArMMd0nKuyX0jgDJdXye1k2XN4wXm5lJwAA
         ha4aLfpajRtPmDrt5dXHzBazCywIZ5Wln5bWPOnvu54k0mTNxoikfb557RYnFDEz0PTA
         Qc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auu7sPoqnYOjV0cCzT/qrL11WOBRgRd5ITVHRQ8h3zo=;
        b=OrtMWOfUV3hTTJhehr/fJf+JzTXyG2stBR7VmthkwcoIvdydKCPTGk0VzJXSr9hNzV
         BnXN9obzxHD8lMzHxW8PZxXOsNTpnG8gwQ9cmvsXicW9WpAaGInclGp7apYFleAKsnrw
         I7zaYC2uk0HugXbusWVV06tn4a++o+u5BPvkx/4VFmMihzGtFc0xr8cJE+JpMUqLW2M4
         7qMgLOaIa/WGBYV3x864kkaGYF0Bonwrsd+JChhgkh1WAfOtE1DmrvDkHA9KV74Iw1gu
         jnBMNxMpr8K09A8ElQbVuxbBcw8aCcq4VLReseRa0cljUrHLrxZVf0TE8CvONiBkj+Jo
         cIvg==
X-Gm-Message-State: AHQUAuYtFQWI2yLnfAKVcX9QiyL9yJaP5301DTXRmSyprA6Frf/sXTQJ
        4G8l6pfOGzmkrpe5bWY4Jls=
X-Google-Smtp-Source: AHgI3IZ4AFFJXmbpIjIrZunHa4CkehfYlISghECHg2aZiI6bpwojNPXg4a6uU19VtC2ztipHnekhVA==
X-Received: by 2002:a62:a9b:: with SMTP id 27mr38021830pfk.223.1550721714199;
        Wed, 20 Feb 2019 20:01:54 -0800 (PST)
Received: from huyue2.ccdomain.com ([218.189.10.173])
        by smtp.gmail.com with ESMTPSA id e9sm48836730pfb.52.2019.02.20.20.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 20:01:53 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, rientjes@google.com,
        joe@perches.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, huyue2@yulong.com
Subject: [PATCH] mm/cma_debug: Check for null tmp in cma_debugfs_add_one()
Date:   Thu, 21 Feb 2019 12:01:30 +0800
Message-Id: <20190221040130.8940-2-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
In-Reply-To: <20190221040130.8940-1-zbestahu@gmail.com>
References: <20190221040130.8940-1-zbestahu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

If debugfs_create_dir() failed, the following debugfs_create_file()
will be meanless since it depends on non-NULL tmp dentry and it will
only waste CPU resource.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 mm/cma_debug.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/cma_debug.c b/mm/cma_debug.c
index 2c2c869..3e9d984 100644
--- a/mm/cma_debug.c
+++ b/mm/cma_debug.c
@@ -169,6 +169,8 @@ static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
 	scnprintf(name, sizeof(name), "cma-%s", cma->name);
 
 	tmp = debugfs_create_dir(name, root_dentry);
+	if (!tmp)
+		return;
 
 	debugfs_create_file("alloc", 0200, tmp, cma, &cma_alloc_fops);
 	debugfs_create_file("free", 0200, tmp, cma, &cma_free_fops);
-- 
1.9.1

