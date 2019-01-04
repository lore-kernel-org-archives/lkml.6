Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39698C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033952087F
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 19:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKGO02dm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfADT0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 14:26:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfADT0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 14:26:30 -0500
Received: by mail-pf1-f194.google.com with SMTP id b7so18724237pfi.8;
        Fri, 04 Jan 2019 11:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sS3q+BjVTpnZiKZNEESK2qULkkdiQIaE9iZqlAT6IQQ=;
        b=fKGO02dm+QM78/mNU0jy0s/Yh+5HpZcR45uvZaHDn1XWm1eoqpzmy/36D2U+fItFv6
         28v349gpUQN2ZBzTd9PAUoybJYUfg+ucNUxR+5nbuPsK9vPKXVMak6sKFREXgmWKNgw4
         tYTTLevOdkGDYzEqdb/DbgETRXCvMgHLJJ73uzADBp9GzyI3GuiPY/zwm3cp/gWkp+pq
         G8VBpCEGfuP6B1WfyVv5OgfdfZT6MwhLn/r0vA9eNFLxX313kowNPYZSP0CreJwxePi6
         JtU5TYqi9xxSvgWTx7woz7IgFR/Q9oXLHtBGqZVdoMHhv7/26oVDYtzyzeqjCnwDNjcd
         q1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sS3q+BjVTpnZiKZNEESK2qULkkdiQIaE9iZqlAT6IQQ=;
        b=VczXt/dFju14lNbTXwr0Qe8EfDCdzuS2U5FYFPXLsU1FGQp7FzOMajuF51yYng3TrI
         stSEBvdY1OQyRvi0AIS9tc1u+oaiLLcsywlOhJ8RNTj2zixvauLXTICLNFjwcQd6TiYb
         4liqh67Jm4jf5gyVohr+3JmfVY6hu9spkl4VcXnjlJicvPx9XlXMW+KgeR7xDc9OvQyK
         ye2bnn0G0NGMXpzf4YbG136ZlwjuRd9MlTxi8MFLCT9SGoFIktIMXijqFUXU8hXAm8sD
         GxTXYSPGvO9Fpy8W7t2GbwLopcbljY6qbGNGHOKM3JAzOog7PNuAW3pNuuB6gRXNu/vT
         +owQ==
X-Gm-Message-State: AJcUukcPW1h0k6cYVOaAMzM+/rXs/iCN3PpNTDqFfdaQRGN+FvbiRUHS
        /vA+Fn4CnsB3gz/YzD/HRAA=
X-Google-Smtp-Source: ALg8bN5YjTZlYlzGY3iXrIz6W0FysVnl1VWxGPI6gw6TeLBlesK6qM55eYIOHnpJcKt/I3x03LQiIg==
X-Received: by 2002:a63:78cd:: with SMTP id t196mr2699725pgc.62.1546629989972;
        Fri, 04 Jan 2019 11:26:29 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([49.207.48.173])
        by smtp.gmail.com with ESMTPSA id o7sm79212112pfb.34.2019.01.04.11.26.28
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 04 Jan 2019 11:26:29 -0800 (PST)
Date:   Sat, 5 Jan 2019 01:00:29 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH] fs/ceph/addr.c: Convert to use vmf_error()
Message-ID: <20190104193029.GA15903@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is converted to use vmf_error().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/ceph/addr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8eade7a..fa2a85d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1495,10 +1495,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		if (err < 0 || off >= i_size_read(inode)) {
 			unlock_page(page);
 			put_page(page);
-			if (err == -ENOMEM)
-				ret = VM_FAULT_OOM;
-			else
-				ret = VM_FAULT_SIGBUS;
+			ret = vmf_error(err);
 			goto out_inline;
 		}
 		if (err < PAGE_SIZE)
-- 
1.9.1

