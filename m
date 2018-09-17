Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A037EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594F22147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="LHIBiNKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594F22147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeIRBkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:17 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43838 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbeIRBkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130-v6so9726576qkd.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GoLsM66bXjF27IaJt/0Gx0zoeAsKvJaAAO+2JPuhRiE=;
        b=LHIBiNKW74vuUNb+OAlixL6C52gdUSR7/hvKTORPwXPhiw+G2Y5TMfSf311WRSAhSf
         Tg/wjGvREHgCle98XdaCANhDcj9CxCD7Xz5oN0N75rJs0WS7fSqq4byPLGaCjs1blDea
         dQedDM9IBWHF+A0pNmXoSpmTYvFe2AiINsIo7wC0wmZJd2pBqx49LkuYbD/bwkq00iQO
         b9jmlgwRH1d3zi/FoF/L/liYNC7Lhx2/snBWm3SB+pfR/kIeeIpligsNp/uXOv0m3K8z
         f3oeO+XwC7dI74a1qbNay9cHiOOstay2lvlHg1cqnAX9D+XNf4qaUzeBI8NV/4luKvVx
         5Eaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GoLsM66bXjF27IaJt/0Gx0zoeAsKvJaAAO+2JPuhRiE=;
        b=tIxamaNHC2I9bCwx48uEpblJnEu5cTDsDcl5a/jEB/0d1mAlXKPQqxJ2DutvLQLRk+
         ST/lEBK1VmFIEh2DSGZMHVHejPOm4A9xPgEQP1vT0OKEVDJIZChYpF3nFo/DPSx8maGV
         59ZtQJuTi1wUEoACONs525UvumW1GNmtF1f/2c2Zez4yk0e+oFwNf+nbyKWTPw7Re+kO
         SLy2bPou0nV7AVpGhTdFiupput6pjjMPCM/K7OZ0PHzWynABSRsIXgZs0LadB/QshUm0
         /WjCM39uM3QOXEk0pn0QI0w/UFFyq2xH7BUxHAGiIzknBU6nxf2bW9utDYb4TWCnv+Q+
         cAqg==
X-Gm-Message-State: APzg51DWf2as/GDKbUZZY+fdHSyrLCReESylkpIsArejlOSVqWC9g958
        yzi66rRN97LuXxqi8V96QPn1M+EZxyaeSDyo
X-Google-Smtp-Source: ANB0VdZx6v9F63/P4opVcTJrokSNua1vsjaoeaz6Lr6mcKsT+K+QT6LOsEnOI89Yp+hHHwaAWM7kZg==
X-Received: by 2002:ae9:e8d8:: with SMTP id a207-v6mr18651287qkg.235.1537215084723;
        Mon, 17 Sep 2018 13:11:24 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:23 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 13/17] orangefs: skip inode writeout if nothing to write
Date:   Mon, 17 Sep 2018 20:10:50 +0000
Message-Id: <20180917201054.3530-14-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
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

