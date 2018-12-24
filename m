Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D547C43612
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D31C21850
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TD45kp+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLXNSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:18:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38675 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeLXNSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:18:32 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so5594997plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 05:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=TD45kp+Toiz0zyzHxRUMulEByoStvt6ALI4SRmA3r7+UR6vf1Fv9a5JZlAX5TD1VXN
         uySrs+KKlKj6AILhcxkzINzdziuX5bcL2X/eIZv1ApoknaBxtC0iQ+dScI6QyWwvgG9A
         KWU48g1Gzfc82fpG+paZm07hduVR+l1LiSnXUyIrBafxPSynW7LPdl8bhdzMYq/4AeCK
         OdyaoSSvevrLr/uRnMFcP5ABeJIURBQ3dcRXX9+4yECKcyCXvhymfBQVwrUDrubsv/sn
         T+AXjPEGV5m+ZsjztLaTPuh8na33XnafrsLskOheO2KRZnyIBRfgSSuM6Pn95LfGvPeR
         06SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=pFA19XQqRIOonXczeaJc1JMDfCxsc2SPHw+vTN0jttk=;
        b=GrXjc3Ne6eXE3v/fIxObsh4mXMsTKpG27HkDfXpa+sAWf8wYfmQlq4wM48T6OB5u/1
         /48GeDFw/K63ZS7FinHUOooxbv4nYbOP4MXVjgZ66aMGQyutjYLFmclPyVHPG0NNfhFV
         IFFkDnGaOiBXggRoBElw050FYZDtHGyhTQ4jgAWYiJIkwz3z60dF9UmotrSAa+GWSoAk
         9dBC/9AreRPLo8Xsg49iv3hg9RAVqf1S8w/E/HHLSkWpk1iLd62aB9R1dM6rPK8pTbm9
         1XTw0eTed084sWmPTz20LA3IEQv/hyW1i20lUYFOmI5+GpQeSfO83OgnoF6R0EfQzOjo
         XpvA==
X-Gm-Message-State: AJcUukckMYviUZ9BYv+Um3tU1iRWStvv0aW85ReqaEesczSkShCOW8y4
        X0cxDfyNU8z3l8fUhr+ytOQ=
X-Google-Smtp-Source: ALg8bN4XK5L89IhWFZWeXxyCo+XDDhmG6v7dUoEX5qNfkascP5MGDznUdyua+AHQOE+3TD6j5/G3fA==
X-Received: by 2002:a17:902:8ec8:: with SMTP id x8mr13070446plo.210.1545657511512;
        Mon, 24 Dec 2018 05:18:31 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.18.181])
        by smtp.gmail.com with ESMTPSA id k14sm58126547pgs.52.2018.12.24.05.18.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Dec 2018 05:18:30 -0800 (PST)
Date:   Mon, 24 Dec 2018 18:52:27 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v5 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range
Message-ID: <20181224132227.GA22096@jordon-HP-15-Notebook-PC>
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

