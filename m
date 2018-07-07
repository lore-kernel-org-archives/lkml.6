Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F7C6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46A421A2E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 10:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzM0Q4pA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46A421A2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeGGK2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 06:28:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43892 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752861AbeGGK2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 06:28:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id v13-v6so470969pgr.10;
        Sat, 07 Jul 2018 03:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=wSbYDV6quv2Vhf1fW2QO4G6vyIiIB/azCXYcTGX3Blc=;
        b=FzM0Q4pA6tzYg+4Q9eRvaZKWIE5AFVF/GqKnp88IuruW+TXSD51d8ZwRrfZFXvykDn
         hJD40rOEuPvD5UYA+DWa5CjBJMqYh+T/DXB5znsCRC3SMfiuW4gHnzS1ZxRRBA7LxPBp
         UItuApE5S6ybnOXJv0eAuUWAhW/j5xeTYAnGmr/WacxKroOfzV+kprKN9G02Sf7S+qx8
         +EriNWCu4M3OhVcNsomzF+wTgQ4j+jmVa+gwHmmqE88piyN91ShCzoHhAKv/jhHZvxOu
         0WyJBPmnv+vzGGUSAc2VIdFPEPgsNf3Yzp/o7+u10s84eJr8HsvE8E45BH6kS0kl5mEp
         8k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wSbYDV6quv2Vhf1fW2QO4G6vyIiIB/azCXYcTGX3Blc=;
        b=hG9iVTouTQHU37dIK8kZeYjJUL74pSlQ8jTPfYS5VYWRQRecX9mmpbfxp6RiD0RLtV
         BgiTvTT7Wo/yvdd+s3CrJX9sezgq+BR7ph4QoMBAHE3lz45HIdSF7J6Wl1nA7FcXPIvW
         FUVtJX3armPu20d3t03ULpmpK6kJ35ZLsKf7K28eOh5IHdf+UyfjkooIt3dCsb2M9wMv
         LhhG3K0lgioY7wY77fWbITK1VqhT9BjzwHON79WAKFZsIRJ3hv/+wRuH8Dg9wQDVZm+B
         frYxWYzvFM/oT9ih5REFAmt1f+lXkhh0+VU9b0iOcIWaTnKicN+i7sDsWl7a7EQtcLWi
         UOmw==
X-Gm-Message-State: APt69E34yxPCIDcxoLrHQgUuUgbcANbcOdtM/yq4wWUj0jINAk9JFljv
        +IHZogiwzO+734apdV1T1CAduQ==
X-Google-Smtp-Source: AAOMgpdnfGfwqtNZy1XeuafUHkBNhO686jic28jbPAiBmtzeEYGWvY2dDhHgo3/5XKhszwO+4+vuww==
X-Received: by 2002:a63:67c3:: with SMTP id b186-v6mr12346513pgc.5.1530959284956;
        Sat, 07 Jul 2018 03:28:04 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC ([183.82.17.53])
        by smtp.gmail.com with ESMTPSA id s6-v6sm23475180pfs.115.2018.07.07.03.28.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 07 Jul 2018 03:28:02 -0700 (PDT)
Date:   Sat, 7 Jul 2018 16:00:30 +0530
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, willy@infradead.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: ext4: use new return type vm_fault_t
Message-ID: <20180707103029.GA13365@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new return type vm_fault_t for fault handler
ext4_filemap_fault.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/ext4/ext4.h  | 2 +-
 fs/ext4/inode.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 0b12785..aec0010 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2470,7 +2470,7 @@ int do_journal_get_write_access(handle_t *handle,
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
 			     loff_t lstart, loff_t lend);
 extern int ext4_page_mkwrite(struct vm_fault *vmf);
-extern int ext4_filemap_fault(struct vm_fault *vmf);
+extern vm_fault_t ext4_filemap_fault(struct vm_fault *vmf);
 extern qsize_t *ext4_get_reserved_space(struct inode *inode);
 extern int ext4_get_projid(struct inode *inode, kprojid_t *projid);
 extern void ext4_da_update_reserve_space(struct inode *inode,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 2ea07ef..03ac322 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6205,14 +6205,14 @@ int ext4_page_mkwrite(struct vm_fault *vmf)
 	return ret;
 }
 
-int ext4_filemap_fault(struct vm_fault *vmf)
+vm_fault_t ext4_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
-	int err;
+	vm_fault_t ret;
 
 	down_read(&EXT4_I(inode)->i_mmap_sem);
-	err = filemap_fault(vmf);
+	ret = filemap_fault(vmf);
 	up_read(&EXT4_I(inode)->i_mmap_sem);
 
-	return err;
+	return ret;
 }
-- 
1.9.1

