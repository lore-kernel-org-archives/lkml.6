Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C3C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 656582087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="kLeV2lCG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 656582087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeJHGhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:37:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43992 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJHGhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:37:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id q41-v6so19224663qtq.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoLsM66bXjF27IaJt/0Gx0zoeAsKvJaAAO+2JPuhRiE=;
        b=kLeV2lCG7VKR4BWsF4V676rE2SrZ4n/T2Hu0MUYbu5lJbGZ9XHxis8oTbGXKnowXuk
         XcjsRUWZr/qceGohAKLskxsMrImJyi+6J72pi/6Mo7m6C7RWN/mmZ8zPF0jDK/n6NVV3
         JfSdfFmXWWmGMyQJFxPH7aIFqGg7BcgfrYFbc9pYQqaNZrhyzrxCshgr17AxdAT64sUX
         mLr5REQxK8orZWaR7CjfGsyxyLmwkASx+04E8Ey6HwvtHPmTNP3LqaWtR6Fqm1YZHJyk
         LUcBUq0a37vs3VnD9QdTblAjxWmNhIQAf1C0X8loknMrtwas5fTXaZUPjfc/b2fQ5VcE
         bdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoLsM66bXjF27IaJt/0Gx0zoeAsKvJaAAO+2JPuhRiE=;
        b=FNp/hI17X8Glm9YcZBIjGKjsbA+J0hURbMgnICkc8kXiWdJsPlLvGNMVqftee8XTC+
         a/oIJ4sNwzYtfvpaxm5jdJPOowKt4t8leaxpuZnViO361i20EVs04k8ctv43Ku508Npi
         NZqcuTNt0YRq3ISLj5aL1n4Ny0A4KNUPglmqXBjpU/gE8gEa5f3Xd6dHiwSXr4Pv88ss
         DKvGmEKzD8NTb53oS2r0cHcvRCdkmO3JaQQ6vUofN5UntPUoaAnSUlMZNVrjrL6oJkJx
         xta93cAe2xsxE6JJkLtcoQ6xIiNtmdjBpvPBrTDxGxhvU0x3k2gZAf6F6AYX/Cvs7Osf
         oVSw==
X-Gm-Message-State: ABuFfohfkHsGrkyDMAjlWbVpJ1c5/yIR7Ib0rkjdU8Smkn5zhjlYBwak
        0AIoWzlQm/HUAGkpbpS5KE81sA==
X-Google-Smtp-Source: ACcGV625KEvL2cPZgHwXk9S5jd5k03SC4AXzKiSYe+0JySs6wuph/of29kuBJqoGRB0bcnXUQnuX4w==
X-Received: by 2002:ac8:4790:: with SMTP id k16-v6mr17500797qtq.253.1538954891893;
        Sun, 07 Oct 2018 16:28:11 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:10 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 13/19] orangefs: skip inode writeout if nothing to write
Date:   Sun,  7 Oct 2018 23:27:30 +0000
Message-Id: <20181007232736.3780-14-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Would happen if an inode is dirty but whatever happened is not something
that can be written out to OrangeFS.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/orangefs-utils.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 902ebd1599e1..de63bb710e38 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -435,6 +435,11 @@ int orangefs_inode_setattr(struct inode *inode)
 	copy_attributes_from_inode(inode,
 	    &new_op->upcall.req.setattr.attributes);
 	orangefs_inode->attr_valid = 0;
+	if (!new_op->upcall.req.setattr.attributes.mask) {
+		spin_unlock(&inode->i_lock);
+		op_release(new_op);
+		return 0;
+	}
 	spin_unlock(&inode->i_lock);
 
 	ret = service_operation(new_op, __func__,
-- 
2.19.0

