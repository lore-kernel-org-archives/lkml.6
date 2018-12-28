Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89DDC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB4C20675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 19:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="cpqEPuMA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387688AbeL1T06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 14:26:58 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:33696 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732069AbeL1T06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 14:26:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 7785BCD2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 19:26:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yclYYqxgmLLi for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 13:26:56 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 44ED6CD7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 13:26:56 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id p21so24482280itb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VldzEkSUwU4quRySA+++63MArOsxjr3CwLUopnEh27M=;
        b=cpqEPuMAl6CJjvPu2HuEkO9Sy8JW7fgHSzGkrpRQXShAhhO5F4saDjRvdHaT4vSUFA
         RsB9TAbB/JO3z6tFTe8EByLMc5ywmWInpA0y0jdp7RMNu1ZClYIeob0NQI+KuIzrhVmj
         NPW/cjf+Qzv4VDQsZdYFR4q/nXgX+D0Zs+zsTkoWdSTOk/UP6popli8UgGWPw32VbhmV
         96EeN8pYvE0dTwR4te0PmBm8DvMtsVsCvWQvTz7R36y3XuRG2uTST+rzLQKZAlIsF3ww
         TPZOpV0bznJq0+A7aZC3dYfewhmXXcnDvzxgmMgKzWu0kCk0BpMRWJlstTf4ZRzzfGiN
         63gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VldzEkSUwU4quRySA+++63MArOsxjr3CwLUopnEh27M=;
        b=YIg8POz3ocaX8QLyAVoFQ7wxCkbhkNxqKVCoMLk5O2nfHQT2GVpQHqwXr5C7OXvkdd
         tYsvrmXgm8C1yfYf6dm+Lseg2fwg0HbpXLZNagG5yZ5tfMXyVPssRqqC3e/7H1orvip5
         0LlULB8HVtnbstTsjW4EMa0VTysRYuBLtjwj+KXWwuXQ4IytAwHxkXeAm8hmdpZukR87
         V9Pq/BzPgaZtz38LzYskK1ucXt5Fnw00NVxTqYbfXF+tNq4wyxgycvP9EfKIdTnnxt9E
         YMBrQQgfWT852nxxJ6Ys1go/XSkmWW3mdQY3RVnENqeniIbM+ChqcgL+WDRg03nB989G
         CK7g==
X-Gm-Message-State: AJcUukdMWyzm2sXwSLwSLcBXHM2seXotdb8Ne5hI+oq8GEkS0Z2hFrsv
        zLBQK7yyevVPOUWIVnFQwy2WS03rZfx66r0YhFQxU2E8iX2CYxjsnOCPzk6LNrWTCQBz131fMjJ
        Qb7PEP7WRJWbtLYE4xfIkPta+0Cp1
X-Received: by 2002:a5d:84c1:: with SMTP id z1mr18737955ior.277.1546025215857;
        Fri, 28 Dec 2018 11:26:55 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4TuBzvxsakZv63tseX+zsnpda+aJweOk90qpQSAjwyv9hnzhA3FbCpOZCwOdvCUbgP8lX/Pg==
X-Received: by 2002:a5d:84c1:: with SMTP id z1mr18737939ior.277.1546025215632;
        Fri, 28 Dec 2018 11:26:55 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m18sm1020267ion.78.2018.12.28.11.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:26:55 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: stm32-mdma: Add a check on read_u32_array
Date:   Fri, 28 Dec 2018 13:26:41 -0600
Message-Id: <20181228192641.9713-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stm32_mdma_probe, after reading the property "st,ahb-addr-masks", the
second call is not checked for failure. This time of check to time of use
case of "count" error is sent upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/dma/stm32-mdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index 390e4cae0e1a..485dea177704 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -1579,9 +1579,11 @@ static int stm32_mdma_probe(struct platform_device *pdev)
 
 	dmadev->nr_channels = nr_channels;
 	dmadev->nr_requests = nr_requests;
-	device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
+	ret = device_property_read_u32_array(&pdev->dev, "st,ahb-addr-masks",
 				       dmadev->ahb_addr_masks,
 				       count);
+	if (ret)
+		return ret;
 	dmadev->nr_ahb_addr_masks = count;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.17.1

