Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD57C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A613E206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AKGPf6gZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbfAIQPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:15:19 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45816 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbfAIQPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:15:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id g62so3856863pfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tcCiJRtOYCpxUZfccav15M1Zu+fheGpFRE81Ukk7nJo=;
        b=AKGPf6gZYCcjWTKRrDu/996b7ktn7e/9ECkuaKVua1Z1IZ8xbjNK8VHLSTRdJtABVg
         fmhnaUcqKbcb+2ACwaPsk9XhHc56vXTT2F3brjelP8jli/7KFkl3SZgQEGBE9cjcLebW
         NHWCgulRmgxopPelt/3zZ/K2F3XlbgPN5WQ8s2jN59w1vv14HdwbpOc03rpa58u2c0qq
         waXMClOuEXPRSaTNDFn6WTjN5L99zC69fHDAmJiAY5YZnyT6QWZbSfspBbRu1lB7C1TQ
         SuezrHY1IE5s8QVTdpVG6EiO35enzCesjTQRcPEsJvHp+GUClkr0T1JIfxaBI7necwuV
         KpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tcCiJRtOYCpxUZfccav15M1Zu+fheGpFRE81Ukk7nJo=;
        b=KqaFK9bV1GLROKYTceh/Adsbo0zY7jljdwbnQHTKeaM08oocynFJya2caHHURsxhg9
         A4zSGNS34seymW11pfSY4tWn8/UKtybyuJWtKiU+h3t9ZoSAjtrvFiFov0MuJrDArteV
         NDNk2eCLP55K9M+lfjXz6FID52Dnxh82G8hErCy5tNXMTXR7y+8R+JrXB3G3ffSTIMDq
         PFHGGLrv69LUqtS/hNv0785dRXlyj+/8F/liWPMsS6lH/Am6beYIl4tEprk+BAloZ8Td
         r5D8gM45KLD6Qhv82sCwolsWrxgpm+qGF6btub9lK2nMYm+ighJwW0gbkvZMTN+OgzcE
         iDNw==
X-Gm-Message-State: AJcUukeOqCHn+Rf/xJRQdQLHPZ33ARmITspBkSbSIjg4AVhbTEmTroeN
        oSXMXeRay+2cdRxVoUeLxcx5gL34
X-Google-Smtp-Source: ALg8bN6PQvM0O9XKmqd4X9VDjlWmYj8deO/uUR4dYTIeDb6rp8kUfPJnzePTIn20Bpgpn7+4LoSyig==
X-Received: by 2002:a62:130c:: with SMTP id b12mr6557141pfj.247.1547050518871;
        Wed, 09 Jan 2019 08:15:18 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.49.233])
        by smtp.gmail.com with ESMTPSA id y29sm94420609pga.59.2019.01.09.08.15.16
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 09 Jan 2019 08:15:17 -0800 (PST)
Date:   Wed, 9 Jan 2019 21:49:17 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jglisse@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        dan.j.williams@intel.com
Subject: [PATCH] include/linux/hmm.h: Convert to use vm_fault_t
Message-ID: <20190109161916.GA23410@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

convert to use vm_fault_t type as return type for
fault handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 include/linux/hmm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 66f9ebb..7c5ace3 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -468,7 +468,7 @@ struct hmm_devmem_ops {
 	 * Note that mmap semaphore is held in read mode at least when this
 	 * callback occurs, hence the vma is valid upon callback entry.
 	 */
-	int (*fault)(struct hmm_devmem *devmem,
+	vm_fault_t (*fault)(struct hmm_devmem *devmem,
 		     struct vm_area_struct *vma,
 		     unsigned long addr,
 		     const struct page *page,
-- 
1.9.1

