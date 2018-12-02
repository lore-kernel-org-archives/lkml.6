Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90894C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 555362054F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob52eAyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555362054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbeLBGSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:18:15 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbeLBGSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:18:15 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so4290279pgm.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=Ob52eAybZ+ukSyGdY8U/Z1jdhXxFQFle/dMi4Et2nQndtm7MZ2i4ONnKsVDEIcjDDz
         9W38WqOW1p9mt0J7xkQxfLmLL/jnq1/LcrLmoOqnc9m337jYRgsykPHqvssdhQ8pmZqy
         AcyrBFinNSivTuQmUI01wz1gKLQW9G1svEowGTi2+SAQF6CW3SbPSPNlOgF5HsoRXG/R
         9K9JQ52ZvaqN5BHcgkhczNdO8IQ5qGjOakvBGCY0Sm0g3u6hbovABd7E77bu2Yv2l4eb
         Ba8iBaRv7cN2h5YB8JO3+4IihJv60g16Rfz+y3KC66wo+3y0mJ60ov/ncoRJ0hAIFPOQ
         x9gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=NgQFwLnG9Ko6FBeThPYPkNz34GUMdSRpdOnuPZBPjK1BIp5U2HcW/FUzI5xAjONTQ4
         BID8lMdyapT/dOjjoAT+ORfk3bAbjEnBCDyV5STIIHgAKRHEB+9a1ErRmOLaHpDC7UMH
         HrYbTKyKAFiI+RMYeX7EIuCIuzyUe6CXUl0v2By+hf5+LJkevOoqjFfL93x56XGoTvkg
         GyI1TMQ7U4ipMYYq+VYUdtZogMKG6DPTRT0Jc2v6K/8ScshDP+g/+BP6sykkNAWDBLe9
         WnGwcNkMa+PPhbOtUWoyWPVdegaPtG6K3iT14wDG+dhGBLrEik+F/P4FGFSvaV/N2pXr
         iO4Q==
X-Gm-Message-State: AA+aEWZ2MriDlbROHwUpFq2IYiPtAmPz46n1ia7eUAuixYsIUgFaiE9i
        c775vPbYxnOd0blT88tKVP4=
X-Google-Smtp-Source: AFSGD/UHCJICHgiE0m052Ybq6CARBcS+P92LNUcrBDatOdJIiC6ahi3tnqCNt66ImpC9ArLD+LG41w==
X-Received: by 2002:a62:546:: with SMTP id 67mr11166313pff.99.1543731493182;
        Sat, 01 Dec 2018 22:18:13 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.99.148])
        by smtp.gmail.com with ESMTPSA id g15sm46055783pfj.131.2018.12.01.22.18.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 01 Dec 2018 22:18:12 -0800 (PST)
Date:   Sun, 2 Dec 2018 11:51:56 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v2 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181202062156.GA3131@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range to map range of kernel memory
to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..7bf28bb 100644
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
+	return vm_insert_range(vma, vma->vm_start, buffer->pages,
+				buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

