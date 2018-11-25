Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0562082F
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 22:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="WpN5+ScJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C0562082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbeKZJnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 04:43:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeKZJni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 04:43:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so5228877pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Nov 2018 14:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/7jn2dY0eXpQ+H2jsLGd0VISUlAYwO5O42O0KxD/Mms=;
        b=WpN5+ScJ/QWbqhC3k8pZqkKvjC6Ixob7TBoCVCUJdk43LtXKK356ZjzXV2/q31xnTG
         6czyC99b7gpoW9AQJsNRPUbP45Fc9ESuUaULelhBe4qt41op8XrGLw0R64uOs+PVk/G8
         Bd9O0hn5VJnOVSyXMoFWHHWEFcKZBBaCc7HlT5TdgPCjfEXmtejaWAR7YPtNlbQNIt40
         JQMgxhaBbd4pYk8indEd6WqxDafT+FOTSOX+4D2OMy1Tg8zpi6wdtL8B6gIGLt/TgZNk
         ygrLNW1QeLnrIGDGmYL32+jtFsAaJqYg7RQZ0V1fw4qxa0vTc1aOw2U0qL5dXDzDLCzK
         cNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/7jn2dY0eXpQ+H2jsLGd0VISUlAYwO5O42O0KxD/Mms=;
        b=RQDX5dGEXGqZVi2xJZt54aCFQsf05skhhRfCXxjgUE0IEjnOcoNlWsNNWfTm9t8ieZ
         ZTHck4NrwWPoMDTdAv+3aHZmBXfumtdYSfWU0vz9DPInqL16qVbLtRUlZt5KoGGnBhqr
         QFDsxXvimxHt4onLrs5On4XtcMktd3JHQV3kL9Ftlu2eeQNLqtAs+LjFt90qIXb+aiPr
         TavZGaQEPtbfAHrk8D8o+Pxkyh/0zI1OUzcy++ZEGJcz8Sw5TH+OjG53J8QcD+8fUH6d
         NDLjxblqgsrwbcDfpgneeY0qNNuvtQ3eNy3sNijj2R15BWE0RDPVkFPt0wOC0Bx9wBmG
         dgVQ==
X-Gm-Message-State: AA+aEWZRv1UQDFqQZTm9Z0wYvnRvSHsNZruRwYPU71l5qvwKrplP4tSc
        KtJ5sh7LKzQ8N2RhVaAjIGko8g==
X-Google-Smtp-Source: AFSGD/XDZQWkJ6veyCV7mKE89s5QRQmxAsv1HF0l5tkl8tIB45doidcERBK3jI+wzWViwlOygrGihw==
X-Received: by 2002:a63:4456:: with SMTP id t22mr23052921pgk.0.1543186287263;
        Sun, 25 Nov 2018 14:51:27 -0800 (PST)
Received: from rip.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id u137sm88976473pfc.140.2018.11.25.14.51.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 14:51:26 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Olof Johansson <olof@lixom.net>
Subject: [PATCH] riscv: perf: fix build warning
Date:   Sun, 25 Nov 2018 14:51:21 -0800
Message-Id: <20181125225121.4454-1-olof@lixom.net>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to the -ENOENT return, the variables can't actually be used
uninitialized, but the compiler isn't smart enough in this case.

Let's just set them before returning with the error for now, it'll be
filled in once implemented.

arch/riscv/kernel/perf_event.c:166:5: warning: 'type' may be used uninitialized in this function [-Wmaybe-uninitialized]
arch/riscv/kernel/perf_event.c:166:38: warning: 'op' may be used uninitialized in this function [-Wmaybe-uninitialized]
arch/riscv/kernel/perf_event.c:167:39: warning: 'result' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Olof Johansson <olof@lixom.net>
---

I swear I posted this exact fix just last week, but can't find a reference
to it anywhere.

 arch/riscv/kernel/perf_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/perf_event.c b/arch/riscv/kernel/perf_event.c
index a243fae1c1dbb..81f3ba76f1dbc 100644
--- a/arch/riscv/kernel/perf_event.c
+++ b/arch/riscv/kernel/perf_event.c
@@ -150,6 +150,9 @@ static int riscv_map_hw_event(u64 config)
 int riscv_map_cache_decode(u64 config, unsigned int *type,
 			   unsigned int *op, unsigned int *result)
 {
+	*type = 0;
+	*op = 0;
+	*result = 0;
 	return -ENOENT;
 }
 
-- 
2.11.0

