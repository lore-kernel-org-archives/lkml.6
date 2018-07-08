Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B02C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D925F208AF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QkgNPYI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D925F208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933314AbeGHVFj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 17:05:39 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46515 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933241AbeGHVFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 17:05:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so694705pgv.13;
        Sun, 08 Jul 2018 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YStFHdlOjG+PYR2LhESu+DHYn4LbE5MdZTCdHrP+WaE=;
        b=QkgNPYI8IeYriOzamc9o/ptPVcK4tABQO97AXQTCglLOBBFUOh6C5CtN2Uu+QowYjy
         ntxl872eIsU+nbwaOLfb2/4bmp/kofPFqsRFJPlMR4ewDExbJzQ6/xzisLVJLHJkeBfQ
         oF1NZD/ed8jP0sSHZ1mtnM3ORAADFXhXFT3iMdiMD6y8YOtCrKZLjuPFMh8VHfe4dG4q
         MzUxqWLE5GqtTtF+KrHV+4Iz+6VCqm6FPu2OT6/Np/Ft+ljeDhk7WGcyFXPSoWRsDLlv
         tqJJ7OVaQ5edmk8Xqyh3HUY2BRy9cA2eaQCN/mF9QYs8Ztnb9X2DVMeIKyCMHYVU8Uvm
         jDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YStFHdlOjG+PYR2LhESu+DHYn4LbE5MdZTCdHrP+WaE=;
        b=T6bbHfl6pDRj6dizePhCR/6bR9/iuive3DzY8HxJRsZDE5GWhcef4V6SxKlBrrdbN6
         oLWj20Dlcw4PgW9e1vPTLvUxkUkPI7MFHHC80tsArrxbp9s7EwzKVU8w+XrO9aXTW0Hv
         q99vOMCA94YoMiE9S1+nN9I7LRu8d9qE6ZDRlPL0LZcBmMNsidWzRtQbdH9Bkmv0lW/8
         sqCvTx7vl8xKcnC+28n/IlcnV4X61PCG+eyfLMNHMaLbiAIZhpJD8Nn4J8TROGnjw5Qu
         D9jZqcHFUa9juWs4Z9W6DTnbSfEgd0miRdx4zc+3hNUA+xRozQIZyRZ+p+XO7ERMhP3j
         tOoA==
X-Gm-Message-State: APt69E1No2LsrCuhmVFqE//SHIVYTGEIuemyTM0RxY8dcz/oNi5g8laq
        CQCQ+BdZdcqNQlc7Ba/MvWu2tli7
X-Google-Smtp-Source: AAOMgpemsEUVmMloaTxv/2Z45l9JKuJZNSiV+m1Rz/6GyqnAOKwdTMpQ3Nk6suaj8I7LtFoJm9BISw==
X-Received: by 2002:a63:b256:: with SMTP id t22-v6mr17029125pgo.101.1531083936179;
        Sun, 08 Jul 2018 14:05:36 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id x68-v6sm23355681pfb.138.2018.07.08.14.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 14:05:35 -0700 (PDT)
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [PATCH 04/18] fs_context: fix fs_context leak in simple_pin_fs()
Date:   Sun,  8 Jul 2018 14:01:40 -0700
Message-Id: <20180708210154.10423-5-ebiggers3@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Fixes: 8a2e54b8af88 ("vfs: Implement a filesystem superblock creation/configuration context")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/libfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 823f0510e43da..d9a5d883dc3f5 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -588,8 +588,10 @@ int simple_pin_fs(struct file_system_type *type, struct vfsmount **mount, int *c
 			return PTR_ERR(fc);
 
 		ret = vfs_get_tree(fc);
-		if (ret < 0)
+		if (ret < 0) {
+			put_fs_context(fc);
 			return ret;
+		}
 
 		mnt = vfs_create_mount(fc, 0);
 		put_fs_context(fc);
-- 
2.18.0

