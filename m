Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B49C71130
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A7D320895
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 21:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsorY79+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7D320895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJHEsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 00:48:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39200 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJHEsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 00:48:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id 61-v6so17964785wrb.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnSGyQbUBl5hbFg31Rz58thdOArPqhDlzwLf7wwhXnc=;
        b=dsorY79++5reLTc5YWHb40kRkx7iSISqcogj2dqatdVByVUVJgTLlO0W9F45vID6O6
         6UUbhU49tzQmzRwRjibysR3HfvX31umqeqixnsQbpKdRIQTX2hX2VUl9u3nKpJD5qgYt
         mR+ruPWWxLSfk4eXqjuFDsH15amZ9g21XkWVyLFcFJGR6CryODE4xB2d8BZQcf8cYAwG
         Lu6PCfAYTlxQrSXm+lhd1lHpgfyiDsoKKG2uQcTA9Fsc4AxiwS9k+WDShWCOEVdcvNYS
         EzL/lJvS6h9OC4a/TA4OU4W83T05bcbPZd8GvJL2PxrF/MHMt6QxBTfpdsNmWdnknSoA
         /jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnSGyQbUBl5hbFg31Rz58thdOArPqhDlzwLf7wwhXnc=;
        b=r5nKB/BAf6eCsqgkHH2ouvTAGWFAB0qGRcor+1Stv0o6A4lC0qjrGAUTqf3fGcZ+6w
         tw+4X1sjp5ssh5q9rRwN+BMOnjzT1OfrbeUssxhCSeAOJEJDcYHP2ZMNNUf1r5nuDJNU
         NB+qI/mjQhdfGF7ZUfAxDw+AfDJXWKr/MsaI5SkMQefP9SZLXltw0b2aPdOPOrBi9WZq
         S0aV5ijAlhOHxa01efHz5MWLNZkSnzYheNyhmS5Fc6wHTeZJ4q6ZSZfvf4FChaM8QO4t
         GXppsBruovBGd6Wgn/r54CsLCTnNvd3VJfi17iiX8pIaVOIlX0AlS0tsMUt7clu26N1g
         iPlg==
X-Gm-Message-State: ABuFfojiyxOf2wnFfTDueg+OhIONS9MsVwz+mxaPk5EASVc3Q8v1tGpg
        MGaj9fx8ehH6YnQejjJHnWlXys3w
X-Google-Smtp-Source: ACcGV6075ETmZyLSxhCgRYSmCD9t+cpt5qRjIFNL7fWlmCbU+1HWKPxeCjPrUH2IMxJSa+grfUF0Rg==
X-Received: by 2002:a5d:4d09:: with SMTP id z9-v6mr9628237wrt.298.1538948408481;
        Sun, 07 Oct 2018 14:40:08 -0700 (PDT)
Received: from localhost.localdomain (host86-169-110-130.range86-169.btcentralplus.com. [86.169.110.130])
        by smtp.gmail.com with ESMTPSA id i7-v6sm7758097wmd.41.2018.10.07.14.40.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 14:40:07 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/11] staging:rtl8192u: Add missing SPDX-License-Identifier - Style
Date:   Sun,  7 Oct 2018 22:40:15 +0100
Message-Id: <20181007214025.25469-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007214025.25469-1-johnfwhitmore@gmail.com>
References: <20181007214025.25469-1-johnfwhitmore@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX-License-Identifier tag to file to clear the
checkpatch issue.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
index 90a097f2cd4e..5f8229f2c757 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*******************************************************************************
  *
  *  Copyright(c) 2004 Intel Corporation. All rights reserved.
-- 
2.19.0

