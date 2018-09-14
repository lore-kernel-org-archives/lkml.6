Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00072ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF1120853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1JkZirL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAF1120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeINXHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:40 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:56527 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINXHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:40 -0400
Received: by mail-qt0-f201.google.com with SMTP id k21-v6so7777215qtj.23
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pHzlCLIDpCjZn0N3GDNA4J2+mscQ1w81IHiYlIcF9zY=;
        b=V1JkZirLExKvk3tdEJ2bRlRVLZ/lyErhD7ft1UH88RlyOrfn5aDj0PTbIs0bc9zPA2
         08NZtdGR3P75SVoZHvqYXZyFygN/9Rbe+S41L9XOybuP0GOZAjJPBFEUt75wDLrzR9cI
         2UW0bcT8bZGCmufg1ms2gIfC74sO+aylblv1tDlV5wcf/28pAHOBwsHU6R+SHLzlQV7T
         +/6GKnbpvcDzEoGovuvMUQvPBtefp0LkenYascEm5bWMIElPjKkDGXROZNCQr+ibU4Xp
         dlsvxoXHPenOpbX+A83CFNN6n7S511INpFcagxJaU7du/1sPFMJkqshjlVERZ1m+fnpm
         2Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pHzlCLIDpCjZn0N3GDNA4J2+mscQ1w81IHiYlIcF9zY=;
        b=OMLOgthCuz2rGbFQoACVWj/nZ0fz86rat4skUMs6dZo3k0E9V2wqP1r7Aw9eBwLBS7
         vXuNm1ihi9ojnGU9/ofz9qSl9QU+m+UTwutXkRn09EJpZD/oVg/JhNPF0zJv39Rc5Gx0
         kB2fqy5wF77xb3ZB9aRQ0acPYwK2+9RUvfq66Ei4DFofVNkD/WsggRd33XnG/Va/U2M2
         XgMrsHjrBZ1SxAmGSv44McFcewcm9LwGHpkSEOh6CKrx/oRzVW8bhsHNeaFtLrJgoFT9
         We8X8EVwJJ7n7FdmWWq6LeKoX7OeN0ElX7n99vqinQS8OoOiOqEBwgWbB73aW6/cAcZS
         QlZQ==
X-Gm-Message-State: APzg51A0UhxeqbrHGIT05egiPE0F8Hc+boRdQPDohLtOQ1ctVTCcn9C9
        OJY5bUj4/sMSHUC/cbsHabg4HWDq
X-Google-Smtp-Source: ANB0VdYBn2SWxkVPMcMRNzi8gr4hRAb/AmQ2unCv20ZVuzHp2bYdYetnbdYSTCEDK0vl5mNyduOmYA6T
X-Received: by 2002:ac8:3026:: with SMTP id f35-v6mr4392034qte.34.1536947526584;
 Fri, 14 Sep 2018 10:52:06 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:06 -0700
In-Reply-To: <20180914175122.21036-1-rkir@google.com>
Message-Id: <20180914175122.21036-5-rkir@google.com>
Mime-Version: 1.0
References: <20180914175122.21036-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 05/21] platform: goldfish: pipe: Remove redundant header include
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

No symbols were used from this header.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 6b21671c75ee..fe01ef88ddfb 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -59,7 +59,6 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <linux/goldfish.h>
 #include <linux/dma-mapping.h>
 #include <linux/mm.h>
 #include <linux/acpi.h>
-- 
2.19.0.397.gdd90340f6a-goog

