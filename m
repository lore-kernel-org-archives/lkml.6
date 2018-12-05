Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F95C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 001F520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="ChLNC3Q4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 001F520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbeLEXTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:19:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36692 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeLEXTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:19:42 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so10807078plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 15:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E2swxDGV76YvoVIew/2XHMGOCcP7+e2yIUI04MJokIU=;
        b=ChLNC3Q4HIlqRPFLeP9FwRiaBQKRhWQ0ril7RevpYSiQSBU0CwBTNBZiktIdcWxgBy
         odAnFLl8Tz/QVW0nXS3TSlPEmHhv09eUzkDhd9QrYMu3oHySYNuxWKHYdCAvqYHphk7c
         JWcxTgcT7e8R7h3R4a50/jmGTTJbAv7ySCC+FbIWOrCuJ8NL1eLHdjk7iikrLwe6Hne+
         dkwxRSGiIAuJArrPx1UChHY9kHxtA4I/DFr65q74U2S7ZdJdiGfxnZVZlkbtvhyvY3kK
         S8keCXb8cXGo25xKVf3uSbx4QKJLSgcJzeG2vlhnX6e4s5smGn0EeyxoOXDUElsXZ9mm
         YqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E2swxDGV76YvoVIew/2XHMGOCcP7+e2yIUI04MJokIU=;
        b=IqcrFPx2j6JDHV5q8wG/VHIv8Yq/McO5QN4UYlrDNX5EYX/z/8I3XHNSSw2lbOgp46
         kjniO+eF797CQ49vulMPJDPR9KMDDkOYQBVSPWFY4s/gqHaHiFB+W+hMexVoHv8voe2e
         62NeE5w5TsywHt+9e9AxKFoIRH6TQtyt5EWLFQWewoYl0tXbK7slPuuMNvNmu4E6vJ6B
         CljaKOygurWlegZ1MOdo1zn7F0N8iYUSLxvPI1E7/Udcq7qBFNfY/1KQIiW4QhTMK47N
         WSDTRL9ZwzP2Lzgmax9vmcfBbhjcg736hHWeVcU70KaPhpn22EgnllC//HWZOnCMLrTd
         SZvg==
X-Gm-Message-State: AA+aEWYUyMNCZx3iISbowAwgfzljaY1PAgtcJEiVAm5M8SlJ79y2ZeAB
        FVkR39bvqPQbPq85vkuJy6GCK82C7jQt3g==
X-Google-Smtp-Source: AFSGD/VKc1XjOZICtGpE/lZVETSfyFFAi1YaoLjFhEr7/6zFuRNJmA/pTFJP6Tr/lhFVz09Fnmthhw==
X-Received: by 2002:a17:902:4401:: with SMTP id k1mr26211520pld.307.1544051981786;
        Wed, 05 Dec 2018 15:19:41 -0800 (PST)
Received: from ava-linux2.mtv.corp.google.com ([2620:0:1000:1601:6cc0:d41d:b970:fd7])
        by smtp.googlemail.com with ESMTPSA id p7sm51442338pfj.72.2018.12.05.15.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 15:19:41 -0800 (PST)
From:   Todd Kjos <tkjos@android.com>
X-Google-Original-From: Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, arve@android.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        maco@google.com, joel@joelfernandes.org
Cc:     kernel-team@android.com
Subject: [PATCH 3/3] binder: filter out nodes when showing binder procs
Date:   Wed,  5 Dec 2018 15:19:26 -0800
Message-Id: <20181205231926.45928-3-tkjos@google.com>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181205231926.45928-1-tkjos@google.com>
References: <20181205231926.45928-1-tkjos@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dumping out binder transactions via a debug node,
the output is too verbose if a process has many nodes.
Change the output for transaction dumps to only display
nodes with pending async transactions.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
v2: no change, just resubmitted as #3 of 3 patches instead of by itself
There is no actual dependancy on patches 1 and 2 of the series

 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 172c207fbf99d..cbaef3b0d3078 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5440,6 +5440,9 @@ static void print_binder_proc(struct seq_file *m,
 	for (n = rb_first(&proc->nodes); n != NULL; n = rb_next(n)) {
 		struct binder_node *node = rb_entry(n, struct binder_node,
 						    rb_node);
+		if (!print_all && !node->has_async_transaction)
+			continue;
+
 		/*
 		 * take a temporary reference on the node so it
 		 * survives and isn't removed from the tree
-- 
2.20.0.rc1.387.gf8505762e3-goog

