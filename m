Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50684ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A55120693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 21:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcz0xnX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A55120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeGQVjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 17:39:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41412 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731756AbeGQVjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 17:39:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so963672pgu.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iy+RLPtEzwXQ5aanDTR8iyAOddaY0oYmRxctYilgugQ=;
        b=rcz0xnX+C4FCS6TSeT46Mmn+I/VOakAEcmlTWBOuP1ZqkD/Hw/6NAoKls0d7RI8Zoe
         xg7QQvlAxLcvgtxNSxkMze6ZeVWfUp/dSHY8fhB9mfwhaQVRNGNEY+7q2bZkb1t1UTrL
         mTV/EpM8lN830U8hB09lM2mhfpOykFz1NBIrplMdLnLu9gfk3hqKOEuU7bCn7UAnMFjI
         bKVSioygTCxYdp+LODaffPJHISbHOMmdx8l3qUVsKtJdZGOOHttNIxmqCwWPtE+shoWm
         5P1Vl/B+stLGY/hMQh1+Kmlx8VQg1TDiihS13v0C/dyq9/eThs5Tklr01yLysWDHbOd8
         JVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iy+RLPtEzwXQ5aanDTR8iyAOddaY0oYmRxctYilgugQ=;
        b=Vs0lzSuBwl13yWatPfxxWfLlXFSgG10hF0m7fj5426IYLzopwhXLXYWPLXJ8jFD4CE
         KE+E/7tLe7V2lZHelw5Be/HOlD0dk3DY9bF7VHdl8KJx6Q3IEphvJedchlX3gfJYebfK
         16F1uxrsY63/4mhHb3J/VwfkOctusP+VFcpEsgoZIFOqmC/KdCaCckAyqeEaL+3M1MR7
         Yl14qSUrmIPgtYNgiYmI2iM105LbsAFJJcE5jks0XfiDidBwfLH3EunA8CpG9jBl26wj
         dv+zgvdSeeyZlhsSj9hA+eCQigfk3UB1jz+wUrY56IMvl3R8jkr2gzPXMZofbW5qpxOI
         Jfjg==
X-Gm-Message-State: AOUpUlEJ/HqQ0gnMNC3sLI4qiLzyN+T1W1GWx94z+uPwd6R/UWkAe5BD
        NTd1WbG2w2ntC13LksfxA+3KEjpk
X-Google-Smtp-Source: AAOMgpd7krDJePb1WmsK0XDrq4pOJpxnpHeuEu7mgIjUf4KCQQy3w49CXne+q7YvSSQaAlPeXABJVw==
X-Received: by 2002:a63:842:: with SMTP id 63-v6mr3168456pgi.406.1531861526271;
        Tue, 17 Jul 2018 14:05:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id m86-v6sm3361487pfi.47.2018.07.17.14.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 14:05:25 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Zhongze Hu <frankhu@chromium.org>, Simon Que <sque@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 29/32] staging: gasket: remove unnecessary parens in page table code
Date:   Tue, 17 Jul 2018 13:57:09 -0700
Message-Id: <20180717205712.29495-30-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717205712.29495-1-toddpoynor@gmail.com>
References: <20180717205712.29495-1-toddpoynor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_alloc_coherent_memory() extra parentheses in statement.

Reported-by: Guenter Roeck <groeck@chromium.org>
Signed-off-by: Simon Que <sque@chromium.org>
Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index 617d602b8b447..9f8116112e0ac 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1639,7 +1639,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / (PAGE_SIZE);
+	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
-- 
2.18.0.203.gfac676dfb9-goog

