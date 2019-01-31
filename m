Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24538C282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5674218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 03:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGxAv8qA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfAaDF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 22:05:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAaDF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 22:05:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so799845pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 19:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
        b=bGxAv8qAAnGE4/0/1ZNjA6WdKrdCJaWxsds6XkiT0j20gD9HiazNhxVH3jQ2NfE954
         f6lyd0VtxLMs3+6FRXMX72RP0MLcU8kSYzRvCqc36bVeBoEUUt4cCcRzjKrr0DUHj74D
         j9qcNWRhCCVd5JaqHz54fuG71h5sJjppg+vqkXnF8LAbrY3kiad+ZfgzV4/6MNqMsgT2
         ZdjbvtewujSzC1z2S0F736u8ktEFvbNL5pp3ja1qicUK+TfG8FpcL2gTM5p9xmuJpln+
         kGpZMAgm4fZkYZ+MMSQgvJ3NwtoLooCY/h1XB4GQShk+odi8bnChiBHfA0/ewbRogLEq
         bdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3XbEqy88Jb4MHLdqNBAQMVZdhzSqLBYAliAQZ38QAz0=;
        b=rJbiDVzrTeeyudrAngBtM7ir6RciJrzEgRt7PSWjn4kGu8xLtvRrAcON7D9UN5+AYW
         zFgIPs2w+dvALK2Vr0+2NTfxoeKKpSyQ6x6cPw5jsDc+wRhzao8DpmQXEW2hwtNTUL/e
         KfU68yMyn6U9xGD28mD5gGTkm4/42d3yq1ZTyNLdm+GO8NCyUosNUvEHVmjqxnkJAMXc
         LGR9Vk+/AS8SxBE0cpAx0LRaE8gBxAGWsOlaxu8nXqh/MoQ2RGZBH75SVOsgoYsFxZMY
         aAeH54fI4+wYL+E5wOEjD8MvGiHCZKOz+kBVeRbwQ6A8KlQZhPDSD3N6mC72a5wdWsi1
         GXMQ==
X-Gm-Message-State: AJcUukcEuKpXRGVITV5K2K5J6z5+FH3eMBpjqR4slMMfizaGQjpk47Zo
        LZTKO/5tL2kOTOe5U4jCzGE=
X-Google-Smtp-Source: ALg8bN7ndYdcd0KZwye/sDZozNTEEaoNSd0U+GQ1UnkHVLNJBfYQ4gj/bRKSiWuZTWLYRspxbFj3zA==
X-Received: by 2002:a17:902:8306:: with SMTP id bd6mr33281522plb.217.1548903927316;
        Wed, 30 Jan 2019 19:05:27 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([106.51.20.103])
        by smtp.gmail.com with ESMTPSA id a15sm3835392pgb.1.2019.01.30.19.05.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Jan 2019 19:05:26 -0800 (PST)
Date:   Thu, 31 Jan 2019 08:39:40 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCHv2 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_insert_range_buggy
Message-ID: <20190131030940.GA2305@jordon-HP-15-Notebook-PC>
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

