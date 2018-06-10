Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DObqG1v1HFtHXwAAmS7hNA
	; Sun, 10 Jun 2018 09:54:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 443FC608BA; Sun, 10 Jun 2018 09:54:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW1c74Az"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BFDA460791;
	Sun, 10 Jun 2018 09:54:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFDA460791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753736AbeFJJyT (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 05:54:19 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41948 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751368AbeFJJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 05:54:18 -0400
Received: by mail-pg0-f66.google.com with SMTP id l65-v6so8358730pgl.8;
        Sun, 10 Jun 2018 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=jOn1S//3kdeoiOLI3DD4eXSbBaGE113CjTJEr1d9x/A=;
        b=PW1c74AzqypFMS9D4zckANof6ZxroziuVUyHuO9ff+r46Hd0X4VjeOcU8U+2P0+K3N
         a2JptxdkkH7moLq/sVRohrmcAlRUGAq4P90/X8QdUbT4boUxFOz3Vkja/HKCTANm74Rf
         78NZycbs45ZuHxnMvg1Sj6PliL8cEa73ZAvo6V0L8HJ/i/p1vPTeoJLdVnPbNlztcw7q
         OI/cwbZ1iPLpU58FuvVCn25LqdGkGuVLTG0CJzuRSxVc0Tt/PEQMkO+oGvllYtMw/bgw
         b8MBDEOyUgjFkQOGwZ3EdOi805Ley6xBDPtOb5M5txqWMiv2AsUtp04b/RGP6J8vRe60
         Q7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=jOn1S//3kdeoiOLI3DD4eXSbBaGE113CjTJEr1d9x/A=;
        b=q2XzDdxmzQBCOdVqZa7rlB34g2ikAbDU1Djzp7Wja9FxzYPJFosuucl3miuZMEv5pU
         JDlyRH5S1zzKSCf+cx6Rwl6V6yRGaLa/xDOjfbistURATqH5FHHVxP2x33HP5q1QxZOx
         jr6ONf0dZnIAiNJ/SKEe7C5ivnp7tTylYV17ir6uoaldVsaip/vu7Kuup+qTe5A9seJs
         qC6zEgJv+Y77gLR5cIzb9TiL/ieUA2zSPctXwaV5jdo7QYe+biXYni/bM4zce7C/aWY7
         kfbEtdIPfxa/eyr5vt/BCO1/l2O6IhZJWnrbsYENy05fIZa75F5w+qDs6ocNWpIBLlAd
         XryA==
X-Gm-Message-State: APt69E1q/zz8pvWM6Rmk7x3sRMv2NHEsHo5pYD30HwirhELqfkBWmAeP
        CWLvoHFAdK8soMGk4HcLL9Iv3Q==
X-Google-Smtp-Source: ADUXVKIKIxR/c9o8tCKzcQQyUs4pkDpCSmOGVbaIXKv/TJHeU9W9ViDtB+oOJ/CVD477kMfjNp/VwA==
X-Received: by 2002:a65:57c6:: with SMTP id q6-v6mr11103017pgr.160.1528624456953;
        Sun, 10 Jun 2018 02:54:16 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([49.205.219.149])
        by smtp.gmail.com with ESMTPSA id i4-v6sm51482453pfk.133.2018.06.10.02.54.14
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 10 Jun 2018 02:54:15 -0700 (PDT)
Date: Sun, 10 Jun 2018 15:26:40 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net
Cc: v9fs-developer@lists.sourceforge.net, willy@infradead.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: 9p: Adding new return type vm_fault_t
Message-ID: <20180610095640.GA4061@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for page_mkwrite
handler.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/9p/vfs_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 03c9e32..5f2e48d 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -533,7 +533,7 @@ int v9fs_file_fsync_dotl(struct file *filp, loff_t start, loff_t end,
 	return retval;
 }

-static int
+static vm_fault_t
 v9fs_vm_page_mkwrite(struct vm_fault *vmf)
 {
 	struct v9fs_inode *v9inode;
--
1.9.1
