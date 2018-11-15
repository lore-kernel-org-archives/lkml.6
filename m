Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7ADC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D946F2245E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 15:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inoihOzV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D946F2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbeKPB5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 20:57:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34508 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387922AbeKPB5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 20:57:04 -0500
Received: by mail-pf1-f193.google.com with SMTP id h3so3339843pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oOYDPl7I11jBlyi0EH4ySGobxWcMxdpKNBu+OKkydwU=;
        b=inoihOzVvauWHLvinRNbPtuEK6bN3+FQjdHdAI6xnemcLobPU0Xt6Ugh9wMw8hy+rs
         SOOfP9IJWbgvb3W6nI6Vu/Ctq16+fij7Hf5bE9+b2zmCxmJgqSyAiDDy1MisrdVm1oJP
         HiYJF6PEIMeekVPyyUZs2rrfC/13Ml+iDvdsOlZIgYkCH/4ILc2Xy/vGY1bNwte/mJp3
         A3JcWZ7VJduEIzQ/vGk77Gd8mfS3EUtNGkFSc5B6qUpWwGsTGf1W1Ptu/h9scnpbIm0/
         dkkTPFv3gU6AJIK9HYZuzsg45rCpYszyCjUkQGTMFgGNAUHkMJeJ7XErWJR4PEsddndp
         roHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oOYDPl7I11jBlyi0EH4ySGobxWcMxdpKNBu+OKkydwU=;
        b=aiPEQS4CL3JCsw0vtZhwHQRChfZakgh14QhzkXf2P2GvNL4gMXsF1PNBa5bnJn0ltK
         xi3zDkh9rIv0H/cVGL/4i5SovMcJuwoDXoeCteAioBF8TjWHz+3bvTtExq7wSQbr5CHE
         SnILeqA7QyiJu608BwcjnDoz+BCWHUTqwi/7Nf3CbPTb9XEakM+EKjfNzppvOKRuHsUD
         hBuwb04UJS18z6PGTLs8bPmmUVSPEWCN4pN3S0JgtcacMbsAEMuiLFc8rawwSRvPH/DK
         A1GnDzJlw/QSpCMsDZa7WlNssnl8C4/9MMmhW2J7dxm3DqFdshpXy6LetkHfJbG0n9z5
         BpQA==
X-Gm-Message-State: AGRZ1gKYpdHXEkkNZletSs1wEhKgtFpzi8MIuTg9TDwJnMecXX65bK7t
        8u/QD50uErswLo1CON3rATNoZ57S
X-Google-Smtp-Source: AJdET5c287Ctegge8urpXjRpkwaEtQ9te3hfg5O2h3PwVJmQ1DKCM7oivVkSw2SZUVl3XEpvWdPufg==
X-Received: by 2002:a63:c746:: with SMTP id v6-v6mr6404071pgg.108.1542296921906;
        Thu, 15 Nov 2018 07:48:41 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([103.227.97.233])
        by smtp.gmail.com with ESMTPSA id w66-v6sm30499900pfb.51.2018.11.15.07.48.40
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 07:48:41 -0800 (PST)
Date:   Thu, 15 Nov 2018 21:22:17 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range
Message-ID: <20181115155217.GA28043@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range() to map range of kernel
memory to user vma.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <willy@infradead.org>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index df1ed37..8d8255b 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -180,12 +180,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range(vma, vma->vm_start, vma_priv->pages,
+				vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

