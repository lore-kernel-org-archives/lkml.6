Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB41C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF6F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuNrLoG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391533AbfAKPJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:09:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44365 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733093AbfAKPJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:09:26 -0500
Received: by mail-pg1-f196.google.com with SMTP id t13so6411746pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=HRKqpRHmU+L58qncR6PcEXsm4g4xjV60VkG5Win5xw4=;
        b=JuNrLoG8W9qZ3wovEJ6sEuIJ29dYs5vMzRIRLtQz9SUWeNl4UjyyhYVOScTr6JHLn2
         Eakll8RWLEKrzrgsL7JiV9od8DeDB/HnCTihU+VsG+6pQMp1IYeFSVAW8ic4nAjGgwPu
         ZquG80FbhCmfchutBXtjW0YNVRdpaTlpJVOe6VTaq+Nm7rNFETfSlrUrbqVTIG45AjOX
         YcGlCzK1UZdaie9TaJRXte+oGsy8++6U7VC24my1faXZkU2RJU+HKD6DEDvFlr7rPo5p
         9hqCN38u1u8+c4OS7vN1ygZtyNLYx3RnDsPhAlpbGIdc6CloSEBGOHLU1mxZiDsPzv38
         ZPgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=HRKqpRHmU+L58qncR6PcEXsm4g4xjV60VkG5Win5xw4=;
        b=ObekQZq7EvbTdwZZ1dlobUFnRx0FvIx95dEzkaHpZrJ14VKVQ9fKBCyVO7PMISqz+C
         dEv8jbwhp0N1+RKVrlCfvK1tuRaIbo+rP94E7xLSJ51saljcAIrSe+dH7Dh9TxJm/XOc
         Sjf95Zq/w0xhrlYPqvJUF1+pV0jrBJGDSKlJdDwCdncgrNvyQGCz2hV4UVmq4u5U+Bhb
         my2UaGWMnENRMOoi0dsjMCQXxNCj1vysP5h+oMydAj64+GaqBq4FylPE5QUVTzTc+a9v
         Yj0Xo5rM/rAPualcmrW1WXwmBdYSKNBJ8dwLG+kRf6CWU5DReP0ZBfSyxWsL0UTEda4D
         3STQ==
X-Gm-Message-State: AJcUukdRV6YDQhahtv3JCf8fJprJTNxVKAFsOTFGqrSeBiur9Zs+pBhc
        jVWitQdOO+RboJ88OZT1dkg=
X-Google-Smtp-Source: ALg8bN40ZHV+TGI6LLpALtlmSgNcU7DuNE7kQ77YVrf7dr/Bp0HI7ekI92a2R/MlUhJCUqv1tRv+Kw==
X-Received: by 2002:a62:8c11:: with SMTP id m17mr14936629pfd.224.1547219366063;
        Fri, 11 Jan 2019 07:09:26 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.52.190])
        by smtp.gmail.com with ESMTPSA id j21sm109918120pfn.175.2019.01.11.07.09.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 07:09:24 -0800 (PST)
Date:   Fri, 11 Jan 2019 20:43:26 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org, willy@infradead.org, mhocko@suse.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, linux@armlinux.org.uk,
        robin.murphy@arm.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 9/9] xen/privcmd-buf.c: Convert to use vm_insert_range_buggy
Message-ID: <20190111151326.GA2853@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert to use vm_insert_range_buggy() to map range of kernel
memory to user vma.

This driver has ignored vm_pgoff. We could later "fix" these drivers
to behave according to the normal vm_pgoff offsetting simply by
removing the _buggy suffix on the function name and if that causes
regressions, it gives us an easy way to revert.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/xen/privcmd-buf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/xen/privcmd-buf.c b/drivers/xen/privcmd-buf.c
index de01a6d..a9d7e97 100644
--- a/drivers/xen/privcmd-buf.c
+++ b/drivers/xen/privcmd-buf.c
@@ -166,12 +166,8 @@ static int privcmd_buf_mmap(struct file *file, struct vm_area_struct *vma)
 	if (vma_priv->n_pages != count)
 		ret = -ENOMEM;
 	else
-		for (i = 0; i < vma_priv->n_pages; i++) {
-			ret = vm_insert_page(vma, vma->vm_start + i * PAGE_SIZE,
-					     vma_priv->pages[i]);
-			if (ret)
-				break;
-		}
+		ret = vm_insert_range_buggy(vma, vma_priv->pages,
+						vma_priv->n_pages);
 
 	if (ret)
 		privcmd_buf_vmapriv_free(vma_priv);
-- 
1.9.1

