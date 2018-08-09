Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1DFC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E0421F45
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 18:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg6qQzJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E0421F45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=elisp.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHIUc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 16:32:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37896 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeHIUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 16:32:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so3214218pfh.5;
        Thu, 09 Aug 2018 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ChTqGWd0FnLHcIJZTe8utKIqzM+B07AfIKDdN92DwrY=;
        b=Mg6qQzJl/zTwwW9qoJFFSeY0HfPhnA/cXjCEYT13aSubDrS6HfICYuV1PRpP4ZLbpN
         wEnF5PyCOKFOZV1iFo4kmuWMbshLdJYhdGjknG4IhDqlVOnVxCkB2mcuVBhrtVbC3TTx
         T+gIztYProfNCwxbzpIGqYLX5Nd87kPbv2o900L/MooVN8ab/ZogVSLAaRkHaXCn6EJq
         uMUC7qBKjtrXTXSR4kiYn44b1R9pAQ3GjagfE+2dspxIQ8dMt8H/gfT35pI3dSIApKig
         SlZ47XIYpnlurBIsHZIcKGuxZCu30o8iQSa+Km7kCWZ334fRcnj2uYNj7Go70pVQni2c
         sU8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=ChTqGWd0FnLHcIJZTe8utKIqzM+B07AfIKDdN92DwrY=;
        b=jReKDLq2AyLvfpbC/6zjfF7KYjC3OxIy1fjXuopZ5MvxzydEzjR/qcGlsKlFvy6+mx
         ghtTahcixjDMK7hQp0WWqec93tYR+KZjtg2EBikf5gELnMwdnsM43Hq/wV/UrsqqE0w+
         5fus+y6QPS37aklTilLo5JxjhbHYt7aa1tY5Zmcq1qwRP0gwlxjKlCc9edWU22Kfe9Ln
         +AWPkxUYa8qnMv+adXQ4g176QvQTayVAIcyp0OasbSL2kWfM5i2rvaZuZhINI527fQvq
         CFJbitkhjhMYhCp4Vti3AuoayEv/osxPdMAWfWxXxptaIAlB4lZsRz2JD13FAsXb07SR
         14SA==
X-Gm-Message-State: AOUpUlEnZee2WSW6PGg26Rb/5i7x7bG6pG4s4S8OgxrNk128C2LH8SRi
        6Mlv++846x3G16hn3PHNQA0=
X-Google-Smtp-Source: AA+uWPxm631VIvu5pF2Vb2hKbDADufIA+SZp49DxfsUr5/PnRh5WMyShBrD86yv8lm5YLw7V3KU6Tw==
X-Received: by 2002:a63:121a:: with SMTP id h26-v6mr3210726pgl.316.1533837987318;
        Thu, 09 Aug 2018 11:06:27 -0700 (PDT)
Received: from localhost (h101-111-148-072.catv02.itscom.jp. [101.111.148.72])
        by smtp.gmail.com with ESMTPSA id r1-v6sm22464908pfi.17.2018.08.09.11.06.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 11:06:26 -0700 (PDT)
From:   Naohiro Aota <naota@elisp.net>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <jbacik@fb.com>,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Matias Bjorling <mb@lightnvm.io>,
        Naohiro Aota <naota@elisp.net>
Subject: [RFC PATCH 16/17] btrfs: wait existing extents before truncating
Date:   Fri, 10 Aug 2018 03:04:49 +0900
Message-Id: <20180809180450.5091-17-naota@elisp.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180809180450.5091-1-naota@elisp.net>
References: <20180809180450.5091-1-naota@elisp.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When truncating a file, file buffers which have already been allocated but
not yet written may be truncated.  Truncating these buffers could cause
breakage of a sequential write pattern in a block group if the truncated
blocks are for example followed by blocks allocated to another file. To
avoid this problem, always wait for write out of all unwritten buffers
before proceeding with the truncate execution.

Signed-off-by: Naohiro Aota <naota@elisp.net>
---
 fs/btrfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 05f5e05ccf37..d3f35f81834f 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5193,6 +5193,17 @@ static int btrfs_setsize(struct inode *inode, struct iattr *attr)
 		btrfs_end_write_no_snapshotting(root);
 		btrfs_end_transaction(trans);
 	} else {
+		struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
+
+		if (btrfs_fs_incompat(fs_info, HMZONED)) {
+			u64 sectormask = fs_info->sectorsize - 1;
+
+			ret = btrfs_wait_ordered_range(inode,
+						       newsize & (~sectormask),
+						       (u64)-1);
+			if (ret)
+				return ret;
+		}
 
 		/*
 		 * We're truncating a file that used to have good data down to
-- 
2.18.0

