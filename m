Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD00C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E87C20874
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMaXhdA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391878AbfAKPEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:04:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42766 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391771AbfAKPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:04:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so7061688pfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
        b=SMaXhdA8Q7nrM9qGUNh1kXzTtWH3gVpEoGrrBwY0qxY14/6qIrIZLV5RIbHD4KieFg
         uMMs3JSQnImublU4VhMlU8lpOUNf2T+DQ1ruR+6UTCQVwyJEqccZa5+mnpsFhDKrFHy5
         02c65ESvjA43b3Q3wXtts81HrN/V4kc0SPTdigGT9Sgqw4BqeszJJTCwc+gBM1vxQzTN
         DHTmwg24rP7PK2YUNwW+2JaRT5FNu8YihWMNxmwMPbZTqtN5VeHCCTywejrfNHHFyh5z
         OaZ/UtkiIR/jd52gMYtkRUHgi4X2dctsgtWFTEfHBzP1UaGCggVU6qAB+PrqACCOkVwX
         Bv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
        b=V+jYl/7psM4KMVv4JKCk0nYhF408QwpTlHhRZFw9Tj/M/ZwY49gAzAXIvTk23rP6BS
         PzPTnd8sy4NDTYqO2z5MGrk4qu4ze3UYX38Lk+9SQaeFxiOWBI99UYQ2nAKBEAHRJwwO
         hxd+w7EKrUvCDa+tZplmDKhMxTY1dPfYnSq0CZJe5S59PMFRwrmJeYGb0S3AOOf5c3JP
         gJiO/WO9p4gf3ys39kLn6YJE8VfMOTQX0oOA2kulrbT7B8ApmB4GekjLiCMZ0cUKjCYq
         IUNDF6B/rUXGti9PlAYUDSyZAUI4q4ra3/Sx46syYIKlX14IhHgVbMcuDe6cTWKDa4Us
         AvDg==
X-Gm-Message-State: AJcUukcqqRwHS9anm+TMg3dvIxagn818BVfs9bFt7JRUUYTM3TJd+1bG
        N+ZHMU7xSUgDTuARw8N56Aw=
X-Google-Smtp-Source: ALg8bN5euVDCQBAFkwT8uFKwwThbROCLZs0KfIkBUValIFAmJazBRAFlZV0vDYopnVamFPnq3w74KQ==
X-Received: by 2002:a62:b24a:: with SMTP id x71mr15274522pfe.148.1547219073889;
        Fri, 11 Jan 2019 07:04:33 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id 125sm131459879pfd.124.2019.01.11.07.04.32
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:04:33 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:38:34 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
Message-ID: <20190111150834.GA2744@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range_buggy to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _buggy suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..99a6582 100644
--- a/drivers/firewire/core-iso.c
+++ b/drivers/firewire/core-iso.c
@@ -107,19 +107,8 @@ int fw_iso_buffer_init(struct fw_iso_buffer *buffer, struct fw_card *card,
 int fw_iso_buffer_map_vma(struct fw_iso_buffer *buffer,
 			  struct vm_area_struct *vma)
 {
-	unsigned long uaddr;
-	int i, err;
-
-	uaddr = vma->vm_start;
-	for (i = 0; i < buffer->page_count; i++) {
-		err = vm_insert_page(vma, uaddr, buffer->pages[i]);
-		if (err)
-			return err;
-
-		uaddr += PAGE_SIZE;
-	}
-
-	return 0;
+	return vm_insert_range_buggy(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

