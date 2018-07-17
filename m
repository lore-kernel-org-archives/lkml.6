Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA41ECDFAA
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D4820C03
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 02:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siam8p0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D4820C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732153AbeGQCki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 22:40:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36394 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732101AbeGQCkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 22:40:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id e11-v6so3136965plb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 19:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ShF9M7+IG3KXle49yG8Ipt9ujDPvR/N50b9+CVqOfgA=;
        b=siam8p0dccBwtKoYCVXvisOpWehP9M2dFLSZMsTfotx6+tn3v0T2yoYNvAx7/DuFyA
         pZ+4YgMZ6IY7lvWlmszG+Ck6HFxqbYWVglHIG+Wf5ny0+Zt/lgVphPnbPXjqeTbQdlVJ
         PE5vg3eJJMiT6B70BWR77eof4CalXtp7NwoBuCBqQCrj2dhPACdgS7gI4iRGl7kMhD2O
         Jhxk0Evcc/TO8cFaUAH05Kdl/lvN1AIrokE/0ESJwALunBv9kxN78WFuL2/7vSC85bkG
         7Gg1eGgu4RMzjcsLnQrkRgSfKNOVgLS1LDwK72cBlvtgDWLTmjrAYsHHrtZnb6XWNqAy
         CJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ShF9M7+IG3KXle49yG8Ipt9ujDPvR/N50b9+CVqOfgA=;
        b=d8Os07tzEKvcUyV8wBZ+cY9jI+oBEkPRLYHoohEyqwQDBKdSqtHMX6CfkM8FcPpdbp
         ikxJE6Jk99mamsKPnJLR4bW8euGkcSQ2lXqrMEEb44ewatflpBQynITHR//CyIKM5h8C
         RgLYRJ0u4tK7ILKj59fUfcXuW1g7P160XwDphDOKuCA0F/oDs25FT/wdOVMFwJ/aOj83
         fjwPZEHKWENbZHFvafPjgwpPhyHC1BU408+Ya5wsxNJnL6D/8x4xI8z1Y2J/EN3fSnX+
         hRVI1ubY0yqUlsWFBE+oeNM+QWtOSqAjtuLbHmd/LPvdCpKqrNWuFoj+SatmIRJiXqyy
         I+cQ==
X-Gm-Message-State: AOUpUlGvLIp3WfALUBOP/fGEVHr5M+iHZyLujufK0xmySBWs6EO6rnDH
        qEsu3Lb301anBQ3kY+3Wamk=
X-Google-Smtp-Source: AAOMgpciAd31uKWWFsc3coIgqY5afND1Rti0cDGISp5RM98BJTnxHDX8oUpHSkmQ5zxTBALHlA2j1A==
X-Received: by 2002:a17:902:8e86:: with SMTP id bg6-v6mr3495491plb.108.1531793427738;
        Mon, 16 Jul 2018 19:10:27 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id i20-v6sm41597152pfj.82.2018.07.16.19.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 19:10:27 -0700 (PDT)
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
Date:   Mon, 16 Jul 2018 19:09:23 -0700
Message-Id: <20180717020926.176408-30-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
In-Reply-To: <20180717020926.176408-1-toddpoynor@gmail.com>
References: <20180717020926.176408-1-toddpoynor@gmail.com>
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
index 080bf78c22c3b..9283dbef20ec9 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -1640,7 +1640,7 @@ int gasket_alloc_coherent_memory(struct gasket_dev *gasket_dev, u64 size,
 	dma_addr_t handle;
 	void *mem;
 	int j;
-	unsigned int num_pages = (size + PAGE_SIZE - 1) / (PAGE_SIZE);
+	unsigned int num_pages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
 	const struct gasket_driver_desc *driver_desc =
 		gasket_get_driver_desc(gasket_dev);
 
-- 
2.18.0.203.gfac676dfb9-goog

