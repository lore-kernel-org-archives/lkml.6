Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC7EC6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F4F2089A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="r15bFmP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9F4F2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeJHGgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37667 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id d14-v6so10658264qto.4
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FSQAyhrMeKEDG1cvhhj+2ClF8ajgoGkMbSXLaNBopAI=;
        b=r15bFmP9rXCp/ndf1CzAYz39isjrbp3vqm+cqEnOgg9OQkk0E6YnfGd/qukcN4pGxN
         t7wd805i9lYiAnKHJRbEBTKd9EGeoHGJHTvYbtf1obtje4toDUBmagJCl6T77XROR8hO
         bdde8Pd2LnTifJUpvaDjkZtheh/m34hBGDuXR9WBiOeapeBGgId05ryVHQRRnSVIKTzZ
         jldmxb5udu0LggMU95i8P8koCzl9IOTvmkPoplFYC0UOx09Pg526GbMsC6O52TTB7SFL
         VK3UqGW9G+UTnyzGU/o19Qkgxnn6wAtxD5Pkh+6sOJpq9WqBRPQ7D6bZv+utRe7p8Gpd
         amWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FSQAyhrMeKEDG1cvhhj+2ClF8ajgoGkMbSXLaNBopAI=;
        b=grQB5yvts+8sppGOzys7/9zV1TPkKYD8s5mHJXHHnyLk6L1e6qv0hsnL1Syrh6WrnD
         aAMIyeaOQs9sCta7qU3D+nVaRofCpQIbt7FJpQB2v/6zJQ63vRviTXT8EWAxvyb9HLyv
         dkdjL+UaYYvxS8UeBDtWS5Yw0EvCgiZsVK5ndwonD5YjveYQD/mKY+nQNwhD3fcPprsi
         iIC1FPfKFpVG1hE30W1vdCbcDEz4RLbH2ZME5QhAuk1nrRSmhZ5Xru5mKwarSza4HAEU
         aO/+FMmMAxCz7AfIuy3IYoWrIP2rnt/XLUpaUmEyO/ECky18RTh9nzgciK0Zqpe42ClU
         dPwg==
X-Gm-Message-State: ABuFfoihMcn3eOCQS1aFjrl2QJ8SEge3gtkKGntfMCyl+f4Ua/Zzk74f
        HNl9gTniQrjBEuKwv+AtjDfTTQ==
X-Google-Smtp-Source: ACcGV62kEAPDgatVMJMRGlUq19QjpjR+MahGH+pfUQCjCVoBlBwHzEnmTgxt20th4PVLANH6WMGnVQ==
X-Received: by 2002:aed:3729:: with SMTP id i38-v6mr17515201qtb.296.1538954874424;
        Sun, 07 Oct 2018 16:27:54 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:27:53 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 00/19] [V2] orangefs: page cache
Date:   Sun,  7 Oct 2018 23:27:17 +0000
Message-Id: <20181007232736.3780-1-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2... see https://marc.info/?l=linux-fsdevel&m=153721507330730&w=2

One important change is the following, without which an unaligned write
may end up written to the beginning of its page.  Surprisingly xfstests
did not catch this.  This was caught by an invalidate_inode_pages2 call
in read_iter (not part of this patch series) which exposed the bug.

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 34b98d2ed377..cd1263c45bb2 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -56,7 +54,7 @@ static int orangefs_writepage_locked(struct page *page,
 
 	bv.bv_page = page;
 	bv.bv_len = wlen;
-	bv.bv_offset = 0;
+	bv.bv_offset = off % PAGE_SIZE;
 	iov_iter_bvec(&iter, ITER_BVEC | WRITE, &bv, 1, wlen);
 
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, wlen,

The other big thing is an improved releasepage implementation and a
launder_page implementation.

We also size the writepages buffer based on the client core buffer.
However I'm not happy with the memory allocation in writepages.

Mike, I know you've had some trouble with the original series.  I'd like
to know if this fixes that.

Martin Brandenburg (19):
  orangefs: implement xattr cache
  orangefs: do not invalidate attributes on inode create
  orangefs: simplify orangefs_inode_getattr interface
  orangefs: update attributes rather than relying on server
  orangefs: hold i_lock during inode_getattr
  orangefs: set up and use backing_dev_info
  orangefs: let setattr write to cached inode
  orangefs: reorganize setattr functions to track attribute changes
  orangefs: remove orangefs_readpages
  orangefs: service ops done for writeback are not killable
  orangefs: migrate to generic_file_read_iter
  orangefs: implement writepage
  orangefs: skip inode writeout if nothing to write
  orangefs: write range tracking
  orangefs: avoid fsync service operation on flush
  orangefs: use kmem_cache for orangefs_write_request
  orangefs: implement writepages
  orangefs: use client-core buffer size to determine writepages count
  orangefs: do writepages_work if a single page must be written

 fs/orangefs/acl.c             |   4 +-
 fs/orangefs/file.c            | 194 +++--------
 fs/orangefs/inode.c           | 628 ++++++++++++++++++++++++++++------
 fs/orangefs/namei.c           |  41 +--
 fs/orangefs/orangefs-cache.c  |  24 +-
 fs/orangefs/orangefs-kernel.h |  56 ++-
 fs/orangefs/orangefs-mod.c    |  10 +-
 fs/orangefs/orangefs-utils.c  | 181 +++++-----
 fs/orangefs/super.c           |  38 +-
 fs/orangefs/waitqueue.c       |  18 +-
 fs/orangefs/xattr.c           | 104 ++++++
 11 files changed, 893 insertions(+), 405 deletions(-)

-- 
2.19.0

