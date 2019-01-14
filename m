Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F00C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6A020659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gakNJDTE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbfANUjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 15:39:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55866 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfANUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 15:39:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so1025456wmc.5;
        Mon, 14 Jan 2019 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NM/4viaTmeN4XjhQJCBlN74QYdqy2qWrUzvxYQnrOSI=;
        b=gakNJDTEu6bIA/xXNRBqrUaeKBoEQq+UZpRUdM2SuUVWpgVId6lgI9U/fpZ/ppCVVi
         tup0IDQ4rf+7JR69N/omQ1VQGu/eqeu4IAo8/aT83+BDDSbuIPCIntEGYJ4DPwmW0gB0
         D7/iey2iWFsHAI32UMKXCi+geYWTDTSj//cAMbD+sGpe/T/BhyNqQXFNR9t896R6Xs8P
         x/NvEPtCtDbubGTJA8hLy07Nu4wSGCAnGXRuABr+IU8ezUcQuw+tBte9QyhNmGZjpSdR
         Ela/5/oejT2wCOuEIOU5hb8zI6onu8CDx0J2Vj9kAR+P9sNCbr/O+boqJigukZMACekU
         ShWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NM/4viaTmeN4XjhQJCBlN74QYdqy2qWrUzvxYQnrOSI=;
        b=lmGMgyfojLjZkQjKgJt/CuPZoyvXsfbehVXkAeTbXNfI3YtQVU91VfMPDHzVtJP/K6
         xNHg43V3XmoIiZJq58GdCOZja7v4X/tGgdfIeR89HDuSfV/hQaUKGp7WiVPVOtGxPDM9
         wrRX7i1S8fu3+62sBW1p8Czcc4OrIyBcIQVEr0Xos5jmgfxmO9158nKZnOlC3kno0aYv
         nqty5XhnBSQyVyUK6DgUce5PXq7RybQDbf4y3tuSFLOmTQ5dOBXgl+t9R7JnvvRh9euR
         p3GVDP7pZsia6NDgWdiimfLKVavFc3YljBK8z+cMsx0HwEf8L07LrR6elKjRn1qE8CRw
         gVMw==
X-Gm-Message-State: AJcUukckpCcvGNY5zWcylLaZwM/ddQlkWflhWvwk7FDtknaLdQyzHG6S
        J5p1u5jhQpypY8blnwkatMM=
X-Google-Smtp-Source: ALg8bN7nvN5GYdcmbVVYWszv8RTChdwTD4S3po0oQ1vPYpY+SXZWL72ct56sqRUi7f4ZcTm+CUy8xA==
X-Received: by 2002:a7b:c5cc:: with SMTP id n12mr648533wmk.149.1547498345481;
        Mon, 14 Jan 2019 12:39:05 -0800 (PST)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net. [78.225.224.134])
        by smtp.gmail.com with ESMTPSA id s1sm106867403wro.9.2019.01.14.12.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 12:39:04 -0800 (PST)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id DFE2811422AD; Mon, 14 Jan 2019 21:39:03 +0100 (CET)
From:   Mathieu Malaterre <malat@debian.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] fs: annotate implicit fall throughs
Date:   Mon, 14 Jan 2019 21:38:56 +0100
Message-Id: <20190114203859.19875-1-malat@debian.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a plan to build the kernel with -Wimplicit-fallthrough and
these places in the code produced warnings (W=1). Fix them up.

This commit remove the following warnings:

  fs/libfs.c:148:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
  fs/libfs.c:150:7: warning: this statement may fall through [-Wimplicit-fallthrough=]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 fs/libfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 0fb590d79f30..9efb647917e0 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -146,9 +146,11 @@ loff_t dcache_dir_lseek(struct file *file, loff_t offset, int whence)
 	switch (whence) {
 		case 1:
 			offset += file->f_pos;
+			/* fall through */
 		case 0:
 			if (offset >= 0)
 				break;
+			/* fall through */
 		default:
 			return -EINVAL;
 	}
-- 
2.19.2

