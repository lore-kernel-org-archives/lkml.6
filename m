Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3A3ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CE3D20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 17:51:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bc3Sy6+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CE3D20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbeINXHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:07:19 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:55761 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeINXHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:07:18 -0400
Received: by mail-qt0-f201.google.com with SMTP id j9-v6so7715481qtn.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 10:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r52LMrvjvvrzNrVQzmvddGzHGTx7N/uO//CKf89crIc=;
        b=bc3Sy6+/l49UZRMN4G1KHbVhFBA8LLZAnTHOtYNagYTvWqBcDLzJvLBB1tYmzM9FFa
         lynPmO1/N0aTi9Q2z4uiipXi1GxnQp88j+WY9WJxShpXpk1wYVB4d0hg2VeuNGkxmRxh
         SAOdK/Xnayh50YWwFqc74eXj2ONySlIX8E8IEV4DsuATCakBTBxB1Ok6GmsOkWM+pxAD
         F4sZjAvrjD3HYT0VuF/s/Rztaxp3+6UVBzakp3+Et97ZoPHsGOvwksT6InvLcW6ty9mB
         t1LWZGC2Pu4mAGLRCJLBmgiSMyEUK/bKjGPzRvVPMz+MRTxppGD8WaqyYPFogQXhsJlj
         P1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r52LMrvjvvrzNrVQzmvddGzHGTx7N/uO//CKf89crIc=;
        b=GzqO9Aw7/MUrV14L04tEiZH7O2oPn09l11H3qbdPkYb1lqxjfheXiIysYUOPOa7KPu
         Ko0+WkbzK7PXEFjj41lK8y+mWeEfq8oHnTRU/rVGqsrccasvmbBc0r/njDFQsUe8qOnt
         um+1W0eYyyq2DyDl7EwB8Kuqaj+gA3gEScPvMVi4Ciya58sLLnVzSXnpT37N1eDEfEdG
         8IEkHfnQJ482nR0YqNgWeuUVT8knwd63RbIPuplyao3HG0wV6QPidyxmtJoKBhqReJby
         Fd93hGtvM+pUZ1MgwKY+IplalMjawkQaBXDbFCIQfRmKe5DYL2ycLOj3RFjAYHVmQ7vd
         UV1Q==
X-Gm-Message-State: APzg51DFQ4gsjyHiWYpD1scTPGf6pDrKbZ8J95zLxUxrsZVEecFuo+gc
        BDaJ/+l4hbXirXaVd098v7PjRSnX
X-Google-Smtp-Source: ANB0VdbQZbz3z/wd2ra0BVu8U8+TZf7dszkhjFUWnGEd7AU4Zt3QBKmsQCrv19EW0uT4oC1vHavVOxOj
X-Received: by 2002:ac8:3ff4:: with SMTP id v49-v6mr4070156qtk.21.1536947505377;
 Fri, 14 Sep 2018 10:51:45 -0700 (PDT)
Date:   Fri, 14 Sep 2018 10:51:02 -0700
Message-Id: <20180914175122.21036-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 01/21] platform: goldfish: pipe: Remove license boilerplate
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     tkjos@google.com, linux-kernel@vger.kernel.org,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The boilerplate license is not necessary when the SPDX line is
present.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe_qemu.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
index c272e11c5433..b4d78c108afd 100644
--- a/drivers/platform/goldfish/goldfish_pipe_qemu.h
+++ b/drivers/platform/goldfish/goldfish_pipe_qemu.h
@@ -1,18 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2018 Google, Inc.
- *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
 /*
  * IMPORTANT: The following constants must match the ones used and defined in
  * external/qemu/include/hw/misc/goldfish_pipe.h
-- 
2.19.0.397.gdd90340f6a-goog

