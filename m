Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E2DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8A02087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j+JGx/ZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfARNia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:38:30 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52369 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfARNia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:38:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so4533866wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VgAxxxrE6pIe5JTLS0o6AyfzRnkrf0ffQkkxm2skhIs=;
        b=j+JGx/ZIPUcCEFjierqfypF1xaMc/u05Jz3z4kO2rueBKroWLfktm2dbE6fyi44N9l
         whhY6cgkyHPMJ9d0oBQsY6R8kZaGFvsb7QgHPd7zuWcL+AxrSrzULVmz8sElN8+NR3vz
         q9mIG+CW2L5HQAy+/ESKR9VtAiWToF/1IQnUvS1MXHaIpIJHAUfTU70cTXJ9FE+FVNkk
         eTH+BzBmRNnC6gibDbCbD1f4kAChh+JWnLUHUS1OWL/h0JmBqn/8pcsbdEG3hCsETVRC
         OXbA57xfWoLRahTr4CN4kRNIeMXfF3QQSApqgm/RkAk+7+xnY4WIJ/OxmPZe0WZRjxhy
         Q6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VgAxxxrE6pIe5JTLS0o6AyfzRnkrf0ffQkkxm2skhIs=;
        b=V9N85fLba+bs/zexmDPWzYLqOb8x1R6yPEWYGSo9acYoYIYS7m3Bdt1X1vhfD5ekgk
         PHd3aTvTPILT8gBON2BDM9DmkRkFWPCCol1GBglTZbU4WgVQjrPpsXcn0C5vmL2bIAnG
         Dj60MHDa5oZaemx4DZr5xJ4ZXGHbvRcdcpMlwXX5e8194EQCG1hB4/gP+gXK711Xv8gt
         d2ZcbA8jf1unnmL+lDu44SNHZcFdpbUijF8o50UEUbHBToqCNShY2V+FCp/e9EdeOHfn
         22DLkhVOeq3qOBxIAV8GFLMHqXA7p/WwU3eyipXtLEdZJZKuapib6DCKIEVyq8UCiWiE
         O5kg==
X-Gm-Message-State: AJcUukfm8yyzSzyfYQV+nO83DtmzLIQEjk7+JWI+u57sgZq6qbrNDPTg
        9YUeseg0rzTi+gCH8jxBF3xouA6jmT8=
X-Google-Smtp-Source: ALg8bN4nyD2T6zQMNgtL4W8BL1pVd0S3wpHD2PAgGqsQj2Jddccq+pQoiit13O0Qe7Uu62vSOHCN/A==
X-Received: by 2002:a1c:f71a:: with SMTP id v26mr14743094wmh.131.1547818708127;
        Fri, 18 Jan 2019 05:38:28 -0800 (PST)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id b7sm77748826wrs.47.2019.01.18.05.38.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Jan 2019 05:38:27 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] Documentation: DMA-API: fix two typos
Date:   Fri, 18 Jan 2019 13:38:22 +0000
Message-Id: <1547818702-40035-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two typos, a missing "e" and dma-api/driver_filter was
incorrectly typed dma-api/driver-filter.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 Documentation/DMA-API.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/DMA-API.txt b/Documentation/DMA-API.txt
index 78114ee63057..bd009f3069f8 100644
--- a/Documentation/DMA-API.txt
+++ b/Documentation/DMA-API.txt
@@ -531,7 +531,7 @@ that simply cannot make consistent memory.
 		       dma_addr_t dma_handle, unsigned long attrs)
 
 Free memory allocated by the dma_alloc_attrs().  All parameters common
-parameters must identical to those otherwise passed to dma_fre_coherent,
+parameters must identical to those otherwise passed to dma_free_coherent,
 and the attrs argument must be identical to the attrs passed to
 dma_alloc_attrs().
 
@@ -720,7 +720,7 @@ dma-api/num_free_entries	The current number of free dma_debug_entries
 dma-api/nr_total_entries	The total number of dma_debug_entries in the
 				allocator, both free and used.
 
-dma-api/driver-filter		You can write a name of a driver into this file
+dma-api/driver_filter		You can write a name of a driver into this file
 				to limit the debug output to requests from that
 				particular driver. Write an empty string to
 				that file to disable the filter and see
-- 
2.19.2

