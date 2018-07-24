Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86C2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6404C20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 06:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gjx6vY7E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6404C20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388483AbeGXICu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:02:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388331AbeGXICt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:02:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id a26-v6so623643pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 23:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qX+9ZLjYleTqiYTR/9AsWjndzTTMAgGfRwkaazjqic0=;
        b=Gjx6vY7EwRTKIrVY9J55sUQ34HHFlTe4FmpRadgter9yKeBuzeehOo01GQ1nzj7rQx
         IZZnGZQGxgEy+Nyb24xy4H0OmFFN3qMUY2CgDgPuxd6PM27plx5Ier0qF4WBMg74Y3nR
         3/P+rUjJOAnix3Ymmp41EkC6E95ZGNa/i+SuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qX+9ZLjYleTqiYTR/9AsWjndzTTMAgGfRwkaazjqic0=;
        b=H8gOE+UDUEPkebKkDxPGu1I9PRHT355o8UB0uXpSRMxsUSqW86lgFsKWqp9+/4Z6oc
         QzyvR5Tr7AHl1mH9cAsJjRzCDgxVq3Uf4x2zL3omL+IhE6k+huWskgJCfVjdaVy3iKG5
         8FgcZxtL8BlNK5a59ZFaHDXnFhDdZQJAnQPKMpNjRNzMGQ8HxARvaPCtfPflXyndYW/s
         JBXFc73noE1hQaxKZhQw9EhW7YONgS4oGNYhU2gGfoSL6YU4aN/YMYRAQEj7We+kG3f+
         zWuabaYboxNWnVlbAJCQbLmXpeurejA00xOxZHkWoWffztkAAOaHBzg9qnXBDBYPZrQ/
         srVw==
X-Gm-Message-State: AOUpUlGuNTzzUJgxy7lur3h2VNo3F0fsz4d3J5XZSBvR+bpzZegiUSkM
        CHNPosDCiqt0WbI9gZNsapkIGQ==
X-Google-Smtp-Source: AAOMgpcwmDaP8xLQtGFckK/ZRQpKdN3DRNQMvSg+7bcNGgWpnLXaKTUCf/2WglReEBbUlrEb8a4cew==
X-Received: by 2002:a63:f756:: with SMTP id f22-v6mr14890781pgk.289.1532415472243;
        Mon, 23 Jul 2018 23:57:52 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id u185-v6sm16092326pfu.134.2018.07.23.23.57.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 23:57:51 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com, dhowells@redhat.com,
        vgoyal@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, dyoung@redhat.com, bhe@redhat.com,
        arnd@arndb.de, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Cc:     ard.biesheuvel@linaro.org, james.morse@arm.com,
        bhsharma@redhat.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v12 05/16] kexec_file: kexec_walk_memblock() only walks a dedicated region at kdump
Date:   Tue, 24 Jul 2018 15:57:48 +0900
Message-Id: <20180724065759.19186-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180724065759.19186-1-takahiro.akashi@linaro.org>
References: <20180724065759.19186-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In kdump case, there exists only one dedicated memblock region as usable
memory (crashk_res). With this patch, kexec_walk_memblock() runs a given
callback function on this region.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 2f0691b0f8ad..bb23f9280a7a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -511,6 +511,9 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 	phys_addr_t mstart, mend;
 	struct resource res = { };
 
+	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+		return func(&crashk_res, kbuf);
+
 	if (kbuf->top_down) {
 		for_each_free_mem_range_reverse(i, NUMA_NO_NODE, 0,
 						&mstart, &mend, NULL) {
-- 
2.18.0

