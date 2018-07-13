Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF11ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2422087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iY6pv+eZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2422087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730601AbeGMPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:51:59 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:38828 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbeGMPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:51:59 -0400
Received: by mail-pf0-f193.google.com with SMTP id v15-v6so2840104pff.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=MuADYTMNLt5+xazWfi4yAAyuJ9Uan8dEXsYBVeF/Okk=;
        b=iY6pv+eZs2i1ReCl7s9uVzaAMLEA7t/2m4YAaeGCxXXHi6Ts8xKWTP5RX9pvHONjUq
         d6AJB2gFuliwXGF5SLUzkYqeYnt46fuaB2u4IcVagJgSPl9gJac32VFJ8jwYlLwipyqJ
         iE7cAOude2NA8FjCfYci32yW+b2kjZ8sWbLGmwKTgXY9dNJy2UgQB7vbHCqz0m9rRKtZ
         H8lIB7D20wvNu4KCzI0v3GfUGLRMSwHe5Xa1STHlGYS8N2CLYTyBl/wZaDE3u+V3unlp
         yRvGlg01N+jGUWy6N+FPxvZZPVbouMuGwhlB7Q5Hjhg6ARl+taC9B77jRYGBXVrNKqeG
         4uBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=MuADYTMNLt5+xazWfi4yAAyuJ9Uan8dEXsYBVeF/Okk=;
        b=EInASMp0i76bxICRZTx3tdxinQpGUcvyJXwgfYGXaOjkwirGJkD1fRuFA2yn0womMY
         LjI7Z7tkEh9W+4iw0scJWcCe/hJrqRfhbUL/QxTwO0bDCX/rlRZqlbgOELunXK1Kijze
         8/+SsUqj0lJMysaiWQewhDP86R//3q2+tFoIOeLDf6EseqHPiUe/B5zGGFbJ3ceLkBtX
         yB+BzajecO30PmFjWAx8+V79O9+ZcV6/jvtwt/c99EXjhyPaUicz2W9Ojnxf0wW0Gw/q
         qwQeoV5o4lWMk/ZXXGS6lHtkW0RnBVAHi6nh/vnef7FRDz+FjXfAElIRLe/IGBfsLn2j
         5lfw==
X-Gm-Message-State: AOUpUlGvy4cMzAEt3+qr6XMPkIu8k2nVEfNeWANezmGpG/8du/oulHFz
        DZlevh7N4vGwq/mdPO42++GYmA==
X-Google-Smtp-Source: AAOMgpec95gMRCKfUVi7whB8Iax2ssbO16XrtyUsKa6d1Ne3XLkcLPnHuRNvoNpSyxxVafjxmfMGZw==
X-Received: by 2002:a62:dc1d:: with SMTP id t29-v6mr7677763pfg.244.1531496211285;
        Fri, 13 Jul 2018 08:36:51 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.16.217])
        by smtp.gmail.com with ESMTPSA id z184-v6sm20702927pgd.83.2018.07.13.08.36.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:36:49 -0700 (PDT)
Date:   Fri, 13 Jul 2018 21:09:25 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     airlied@linux.ie, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Subject: [PATCH] char: agp: Change return type to vm_fault_t
Message-ID: <20180713153924.GA3100@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler. For now,
this is just documenting that the function returns a
VM_FAULT value rather than an errno. Once all instances are
converted, vm_fault_t will become a distinct type.

Ref-> commit 1c8f422059ae ("mm: change return type to
vm_fault_t") was added in 4.17-rc1 to introduce the new
typedef vm_fault_t. Currently we are making change to all
drivers to return vm_fault_t for page fault handlers. As
part of that char/agp driver is also getting changed to
return vm_fault_t type from fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 drivers/char/agp/alpha-agp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index 53fe633..c9bf2c2 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -11,7 +11,7 @@
 
 #include "agp.h"
 
-static int alpha_core_agp_vm_fault(struct vm_fault *vmf)
+static vm_fault_t alpha_core_agp_vm_fault(struct vm_fault *vmf)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
 	dma_addr_t dma_addr;
-- 
1.9.1

