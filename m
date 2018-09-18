Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8180C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C58E21471
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk91i5x+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58E21471
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbeIRU3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:29:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39229 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRU3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:29:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id i190-v6so1169672pgc.6;
        Tue, 18 Sep 2018 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FKweYO7fZdKSAU3XQSy4ZysbS9vlz1ltI7XFyATohRI=;
        b=qk91i5x+A8T5lWEufl0tAZzj5k5vfbkX5k+cGDBZYys+szGpV5Nw+I2dmPGHH9uw+B
         3ts6zYRTSVKHZzhrCedFuW6w+V/iHnlX+cs6M9b4EEB6j+m308iDFKJm5E3/rfd7Waed
         tMZ6EVBuXVrAPq9f35jsEJA7qpgtPPw47RvLsYnPtRM4E1oM5Re4W7BOTDlk/WQCjqSJ
         sV2ikuS09ka/ekK0wug9UNRcCpvAi7px0sg+a17DCwAINhE1To9KjVyZVezhkciRYZJv
         O2nYNkekrEQU+EW8KCc582QoXahLwNn73QWJFEqP9MimpS8wK+EGJEy14hFfKB74wLDk
         bvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FKweYO7fZdKSAU3XQSy4ZysbS9vlz1ltI7XFyATohRI=;
        b=Zs/sH24TP9vGiKDmEoNKH4OtbZrlQu916pXcuUfLHZSD4BoGNyFXaZleMoIx8859lX
         JftyfH4MNkeqaxaVst+5hawGfa63HlcZm9xQGOXxgsiULk1akV3z/9OW+TsW1GF32XB6
         RHJI7SPSQdELiBXUKYiDyjuYKpa81DYeIHsib0UYTK3o1lKynO17Zx4EQJDvn6nqZrAX
         rj4lHOR/CCudm0gTeAUdJRmeOLFqM7jlzmJxmLtOYETiOknbcS/2Mg3Yn4MgmBfoOZ2r
         Gods1uTuXXwolU+z/llu4tbRzXV9Ps3DhR22NLyeb4Belyeg1wBBmIHYoSpw6NmXNMc0
         vvQA==
X-Gm-Message-State: APzg51CTF43VXatj6Mr2ZXctP3C8tJEvXpRmr+sAAcg/EYJ5goNOdPSd
        W/GwygR2wx5grpFTl3O/qrUGwj1w
X-Google-Smtp-Source: ANB0Vdbw+cjAL4nldXA2LjpXeFLwLSdlTkJQtE55CrD4VYF3efDVP6f2NgHP/qxd24YPvfyFGbmOVQ==
X-Received: by 2002:a62:219b:: with SMTP id o27-v6mr31184741pfj.235.1537282596532;
        Tue, 18 Sep 2018 07:56:36 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.36])
        by smtp.gmail.com with ESMTPSA id u184-v6sm35677292pgd.46.2018.09.18.07.56.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Sep 2018 07:56:35 -0700 (PDT)
Date:   Tue, 18 Sep 2018 20:29:46 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     adobriyan@gmail.com, ganeshgr@chelsio.com,
        rahul.lakkireddy@chelsio.com, davem@davemloft.net,
        akpm@linux-foundation.org, arnd@arndb.de, willy@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/proc/vmcore.c: Convert to use vmf_error()
Message-ID: <20180918145945.GA11392@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code can be replaced with vmf_error() inline function.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/proc/vmcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index cbde728..89c6f94 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -401,7 +401,7 @@ static vm_fault_t mmap_vmcore_fault(struct vm_fault *vmf)
 		if (rc < 0) {
 			unlock_page(page);
 			put_page(page);
-			return (rc == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
+			return vmf_error(rc);
 		}
 		SetPageUptodate(page);
 	}
-- 
1.9.1

