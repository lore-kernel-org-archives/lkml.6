Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED95C46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E81223BF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAkd8i3B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E81223BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeHJFtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:24 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45524 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727526AbeHJFtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so3817251pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5saFQ9UFIyu/P1YgI81zjvtg7Ha4HLzdbKpBYtyyMY=;
        b=iAkd8i3BU4DK7w53jkG9ENEGjBVibPKgVg7/MYkLoPlcIcsrz0+PW9yV5v1yDw/a6o
         fkQ6PiY33T3uB33yLxrNzRom8yhf8S1hEixJNkQtwJafOE/TE3dmu1Oiy1f49CO343y4
         EnitGT5OpzC4yLjhuUQO+j6emu17tle/hfq4c7SfhAX928AtFNl5NnqmaxwT3SMl8Tdt
         8+/0WVktPcyJ/eZhxOVVEhc7AMzp/VLKJ38FQ/7zLBfVd5KbBx/wRQR/dxnP7LjzvWF0
         NZ2h9DEkrwpFBV2wXDN/YlKdVhCDbQYHfqPtMlYvMszLOa0UWIv2iM+qPIAWnUZhz6NM
         9qLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5saFQ9UFIyu/P1YgI81zjvtg7Ha4HLzdbKpBYtyyMY=;
        b=SIpn+yFOVXdZTd1IfnYeDPrpYYocS+t1PwYzP9n1KdQu+UgGAYbcbXdQ8/R/XDpbTS
         t/h2xIS3Od7t7d+QpCrlSiP+r6KHcYAPvXm7S8VX5L47eJr5IooCRDk2cnCFb+hTZ73f
         Q0bMJE4+pPgv6Z/v+j/0Ni6UH18fdW65aJ5DQJXINsdrPko7cUGyoK7bxjwy2hCZxywy
         bSzMxPcNjWJWojL0zI2KGtt5v1FDsbUvtOxu8xKZjxAvJI2pWLBk7SVtHEQ/3WpEk4aT
         86AOka4q+eswL32l8bePHjJ6c8D7UPYYhPHS1W9wLKNFlBqBJ/+doR6Bd8NBSYKDRyKz
         9MjQ==
X-Gm-Message-State: AOUpUlF4tw9hXhkHo9l1E8dVcLwUQARIGxrit3msdolQUYocK4/nsspH
        FlY/Odzx8Hr4UUDa9ZSfmOc=
X-Google-Smtp-Source: AA+uWPx9nf5nuR2x+yn57PTJFLJrsnQTedYO9fVwC/HDlw9hsoQ5Bv08OApnTM5C5LR0qfTWy5DUrQ==
X-Received: by 2002:a62:e218:: with SMTP id a24-v6mr5132790pfi.75.1533871291000;
        Thu, 09 Aug 2018 20:21:31 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:30 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/16] staging: gasket: page table: use dma_mapping_error for error detection
Date:   Thu,  9 Aug 2018 20:21:03 -0700
Message-Id: <20180810032111.197743-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

gasket_perform_mapping() call dma_mapping_error() to determine if
mapping failed.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_page_table.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/gasket/gasket_page_table.c b/drivers/staging/gasket/gasket_page_table.c
index bd921dc6094de..4d2499269499b 100644
--- a/drivers/staging/gasket/gasket_page_table.c
+++ b/drivers/staging/gasket/gasket_page_table.c
@@ -493,7 +493,8 @@ static int gasket_perform_mapping(struct gasket_page_table *pg_tbl,
 				(void *)page_to_pfn(page),
 				(unsigned long long)ptes[i].dma_addr);
 
-			if (ptes[i].dma_addr == -1) {
+			if (dma_mapping_error(pg_tbl->device,
+					      ptes[i].dma_addr)) {
 				dev_dbg(pg_tbl->device,
 					"%s i %d -> fail to map page %llx "
 					"[pfn %p ohys %p]\n",
-- 
2.18.0.597.ga71716f1ad-goog

