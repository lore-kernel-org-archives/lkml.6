Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4866C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA92223E7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ai7V+7zL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA92223E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933878AbeFUV26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:28:58 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41716 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933731AbeFUV24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/q2pwDos/ZqUD2M28EO7v4xmpqRARdWtpvnvzmCb13s=; b=Ai7V+7zLpKx7ds5UWAmjNQkw7
        3LnGtraUUzYkADPHAfuCjY97xok4uM8BiSLkPGY1z7U/+yjH0ijoLnly2niImlYOYcwf+9G9wEDmb
        TTfWQYrTTNhzMLvJrCQLlKv5nhspuPlnOWMg702RFWsjZLmsmZ46C/Ys4vj3XW+vsaN0ptD+1ubfv
        kO2VkUBtP4WJih0ZMFcfJlNVAfmUWrOz51QUJLYbHnXsw+sK8zN40NMIV18AdkAS7jsCGirlQvWwo
        MiJUP0ZMC7ARCt3qcRO9EwI2L7cILFyglDEIYCAG28BvsWRoix08Kv0EFefx3wcuWq7B5ZWYKmw6E
        sX5F1khRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78S-0001ZI-BI; Thu, 21 Jun 2018 21:28:56 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 01/26] radix tree test suite: fix build
Date:   Thu, 21 Jun 2018 14:28:10 -0700
Message-Id: <20180621212835.5636-2-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that idr.c includes xarray.h, we need to have an xarray.h to include
in the test suite.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 tools/testing/radix-tree/linux/xarray.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/testing/radix-tree/linux/xarray.h

diff --git a/tools/testing/radix-tree/linux/xarray.h b/tools/testing/radix-tree/linux/xarray.h
new file mode 100644
index 000000000000..df3812cda376
--- /dev/null
+++ b/tools/testing/radix-tree/linux/xarray.h
@@ -0,0 +1,2 @@
+#include "generated/map-shift.h"
+#include "../../../../include/linux/xarray.h"
-- 
2.17.1

