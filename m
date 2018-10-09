Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47C8FA3753
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82274214FF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 18:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="2JpSxkRR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82274214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeJJCGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 22:06:39 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:38324 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbeJJCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 22:06:38 -0400
Received: by mail-yb1-f194.google.com with SMTP id e190-v6so1105314ybb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 11:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xqbsKb6+MsTOYxvFNkRY6HKryVHEiHLbzY5smiU/q9o=;
        b=2JpSxkRR4M31hSqYhIRpOAxAMei/UCRotaZiDLuYmqn1wzDkrYi0oaTAYG0Sma9CJP
         rrCe43lMHImNHs03pdLNqlzHCJLD1/VZ2QoXjnKpnQ9Nx1RDVgiC/0gGnd3Vlp5nmsU0
         Q20toGmCeq3Y37XWIzJXU99nCVWHFvU6V79lZWy4BVbmvSPNEsrUorMHsvCryacKMDfe
         y7fXLYsue/bduZGQWQ6cmhCrEweq0bTltnrBnDv2UN3WOY2jLwaDQVqsJ2aThf7hEOY3
         kjF+KcsjpTo4cTxKQzgoJ0ezK6qf5yDk7XI1qdClu/ELAY7FzUcUiz8leUxAA1C2tkb1
         UbOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xqbsKb6+MsTOYxvFNkRY6HKryVHEiHLbzY5smiU/q9o=;
        b=YHUke7hngpohcXDDPSSKQYhjosECG4LHW8A1dY3IVNPdeFFqOdyel8dEwFX+yDrGWi
         97AGUDgOfuI4NFzZ3/tDFvK4j7HCkWnZRKyiev7jSgC3mY0FcYmXRX43LVkuK4A5FRAP
         VhIUezqL/+MM5U46VwyLtnws2gVQLEIKhix9380lsQj8RMVE7knn0cyxqP7nqcHeb+RH
         Fr7WeSAwr+gEv23teo4iy6NdkE3an7s9gszDEVB5GAqzEnyB8RhwOyMMKrgT7vlWdmxg
         M/6sQxLYdsMsAh3pvLdJ/Ti7ekPPhjanuoiisOSZ+aCBECYrz4B1VkwrIR34gGxgfAAA
         YN4w==
X-Gm-Message-State: ABuFfoh3OiWkjIyGtyr4IrYMEoynPu5pHQo/Eenx+HpkwkiXE9MZA8oX
        UNO++dq5d51Og108+pooukritw==
X-Google-Smtp-Source: ACcGV63DSRtb2M1873wzEFbvNrF8EqbjX6+h5uKkX5MxiEsBQ8R+Dq1KsodlTZjiNTsOYEo+e332/A==
X-Received: by 2002:a25:7ec5:: with SMTP id z188-v6mr4015990ybc.250.1539110897163;
        Tue, 09 Oct 2018 11:48:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:14c5])
        by smtp.gmail.com with ESMTPSA id r8-v6sm15176282ywa.56.2018.10.09.11.48.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 11:48:16 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 2/4] mm: workingset: use cheaper __inc_lruvec_state in irqsafe node reclaim
Date:   Tue,  9 Oct 2018 14:47:31 -0400
Message-Id: <20181009184732.762-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009184732.762-1-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to use the preemption-safe lruvec state function inside the
reclaim region that has irqs disabled.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/workingset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index e5c70bc94077..f564aaa6b71d 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -493,7 +493,7 @@ static enum lru_status shadow_lru_isolate(struct list_head *item,
 	 * shadow entries we were tracking ...
 	 */
 	xas_store(&xas, NULL);
-	inc_lruvec_page_state(virt_to_page(node), WORKINGSET_NODERECLAIM);
+	__inc_lruvec_page_state(virt_to_page(node), WORKINGSET_NODERECLAIM);
 
 out_invalid:
 	xa_unlock_irq(&mapping->i_pages);
-- 
2.19.0

