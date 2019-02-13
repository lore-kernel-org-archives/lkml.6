Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E1CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7C2190A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHXHCXDq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390108AbfBMN7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 08:59:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38544 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390038AbfBMN7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 08:59:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1209419plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=HHXHCXDqjrbjv9vKNBt9+7oEqMLimW2KaqFOqXNr/HA7rhmmEUFkNlY/u1NnQgZNbH
         +CDaalSV78Qcw6kY5OQUhGjsfrH+by8CS5/gJGu3VNqes+WPN1dRNmLxWbGIfZdm7c8f
         15gEiqZIi9KcnTmJeiE0/uvejDFQlK3pGLnh1YPOu2dqmZ2OMrKZkGjN68Mg+yf3YDmN
         Ttkvg6nMsBdyaGH/uB7E4ipzK3thPAR0ZqymOfIw+XSoxI5PHoZerSNybOokoRu9/Y+c
         A3BYZAAsc1mpb1sa8omgtYbiZEsojeWq9nmMQjwKjC3dkqWy7hcLdNXjZUfWSeiI7qP3
         8jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=naB3KMuHNTCaDD6/Z64EGJGrk7XQ7GW1pzVQ9Q3Vf6s=;
        b=e93Z6gsnVq8WR2YsSGKLmCPk8aKsaQB4jlqkqELWuBJVPmsgPkIDgtJKGYKj/ascKM
         P1FNEbeYzwhOnC+9rYdUVe/+jTm9euXir5lejZ7ZuG/9SAKhJBiTdwtWd720QLpUxhlz
         uort+EPGFbuG3giodPFp6xKZ/cVA/ZBZMhZJ2untusnuWEb1LVGgC/gfnn/fPabR4+ZX
         leQr3IRapjcYb8kjv7mwoci7XqtY0ubVGY/MkXZCALElo7ADiTlM/tobLl8EjprdcHmN
         VNoH9T6Y0G/prLGEf48xaKqq8I9yKUDYJlH6DuubOPUteuKspjigcPjjivcW8hq+PjZv
         dh6w==
X-Gm-Message-State: AHQUAuaxjQqYwfvdjPa5zufRbEm5FVW/xs0/Qzm195w5TPXY7jDwU0Ao
        NkMjVi4lz8DP3tWaU2LRXcE=
X-Google-Smtp-Source: AHgI3IYElBePFcn4s9J3Tqwya9pPVWfxESsTKj0N4GiKgmRE7PyggN/XPQLDEGJiVcCZzaxyw7jtWA==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr673309pll.144.1550066353286;
        Wed, 13 Feb 2019 05:59:13 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.54])
        by smtp.gmail.com with ESMTPSA id a15sm24035107pgd.4.2019.02.13.05.59.11
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 05:59:12 -0800 (PST)
Date:   Wed, 13 Feb 2019 19:33:30 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        stefanr@s5r6.in-berlin.de, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux1394-devel@lists.sourceforge.net
Subject: [PATCH v3 3/9] drivers/firewire/core-iso.c: Convert to use
 vm_map_pages_zero()
Message-ID: <20190213140330.GA21993@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_map_pages_zero() to map range of kernel memory
to user vma.

This driver has ignored vm_pgoff and mapped the entire pages. We
could later "fix" these drivers to behave according to the normal
vm_pgoff offsetting simply by removing the _zero suffix on the
function name and if that causes regressions, it gives us an easy
way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/firewire/core-iso.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/firewire/core-iso.c b/drivers/firewire/core-iso.c
index 35e784c..5414eb1 100644
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
+	return vm_map_pages_zero(vma, buffer->pages,
+					buffer->page_count);
 }
 
 void fw_iso_buffer_destroy(struct fw_iso_buffer *buffer,
-- 
1.9.1

