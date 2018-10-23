Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A9BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4799020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="X4sjJDFA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4799020671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbeJXEph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:45:37 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53754 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeJXEoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:55 -0400
Received: by mail-wm1-f66.google.com with SMTP id f8-v6so691787wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2rgD7RkIz8RrksTmcPFlaMjrDpZ6eKiDDFJ0lLZWZXQ=;
        b=X4sjJDFAynbd9O8BW0ZnALfYUXzqRyP+mt7/l5CCldfAf1ieebi23SSA7WpxTeP7g5
         Y2bCbEHpbGidoESXsO5P2TrWFsioKjjzzyrMSAeQqSzVYhZMhh5AAxMhUbxU1aHLrROk
         reQX6I5blXzZ3AMjCpW+ggIJfUWTvAUm+IGFmXDznl/IZ0/NGXUvhQQt2GblGwu8jClM
         caaOgFyUv5JJBhlcPBY/K9c3JlF3PYtlFA1hrbWI8mL5VvU8d4ES0sf42gCpTiA6/nH4
         YEnjtd+ZwrLwofNQ3gL2zBzpmpaauqvPCfuY4YcBunU/a7Diw/RXuThZwWRrIVOX44SC
         cRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2rgD7RkIz8RrksTmcPFlaMjrDpZ6eKiDDFJ0lLZWZXQ=;
        b=Xt0eo7tlcxk/3V174xHhbELG2ygnGsLOwl6oIeKpo5GHoyRb6JqOLnP47rIbzcPnZg
         gDW48ZKnycUGeT6rDJAqx4AD1T+dXE5McjUv582z3bN0S+rayVw2lnDi7hRiCREhAprA
         M0oA1LfdIX0nCwK4O1bWVbP+r41qXHS/gLpE9wylLb/JEgJbUwsdjUSRU8V6ZFd/5x5z
         IoB+KQA05JFPBlpFx8hhCJUy8OC92hHBRGHcRnaZ3JZrP5qeQH/38tk7M0HFLzhlq4cQ
         zntBJHkjlAI3J8k9gBBvVFvV9zdvU0Aucx3Itmfdq4ejfbtm/RfaC56ZlNEMwohnV1U2
         V6ig==
X-Gm-Message-State: ABuFfog+qpz2A8ieT3xNzCtfOHeVjXBoRDzvwbxKaMgc58t6IFdyvgzM
        9m+L4sF5rGKLb0zyVRvS/B/q/Q==
X-Google-Smtp-Source: AJdET5dOnlEezDBSrlCRxBFT01dsGPmoMnL4LUxnbZXJjtMKZtVvz697LGaExXIKYvQsLfn4mTxGdg==
X-Received: by 2002:a1c:1a45:: with SMTP id a66-v6mr5327821wma.20.1540325997514;
        Tue, 23 Oct 2018 13:19:57 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id h78-v6sm3292578wmd.4.2018.10.23.13.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:19:56 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:19:56 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        viro@zeniv.linux.org.uk
Subject: [RFC][PATCH 03/10] hfsplus: use fs_umode_to_dtype() helper
Message-ID: <20181023201956.GA15701@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace if/else statements with common lookup table implementation.

Original patch written by Amir Goldstein.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 fs/hfsplus/dir.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index f37662675c3a..7b798a46c8ac 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -223,7 +223,6 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 				break;
 		} else if (type == HFSPLUS_FILE) {
 			u16 mode;
-			unsigned type = DT_UNKNOWN;
 
 			if (fd.entrylength < sizeof(struct hfsplus_cat_file)) {
 				pr_err("small file entry\n");
@@ -232,21 +231,10 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			}
 
 			mode = be16_to_cpu(entry.file.permissions.mode);
-			if (S_ISREG(mode))
-				type = DT_REG;
-			else if (S_ISLNK(mode))
-				type = DT_LNK;
-			else if (S_ISFIFO(mode))
-				type = DT_FIFO;
-			else if (S_ISCHR(mode))
-				type = DT_CHR;
-			else if (S_ISBLK(mode))
-				type = DT_BLK;
-			else if (S_ISSOCK(mode))
-				type = DT_SOCK;
 
 			if (!dir_emit(ctx, strbuf, len,
-				      be32_to_cpu(entry.file.id), type))
+				      be32_to_cpu(entry.file.id),
+				      fs_umode_to_dtype(mode)))
 				break;
 		} else {
 			pr_err("bad catalog entry type\n");
-- 
2.17.2

