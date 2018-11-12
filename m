Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65AFC07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB0A222504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 20:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPp6+QzI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0A222504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbeKMGkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 01:40:20 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38617 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730458AbeKMGkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 01:40:20 -0500
Received: by mail-wm1-f66.google.com with SMTP id f2-v6so9377855wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 12:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRB6fOKqdf+FF3D/ewyCuVcuMS4RZcVMRpDoIyHn5ts=;
        b=ZPp6+QzItfaYmn6ACWaOLkeH1Fz53sUEDRrneQIYO+d85LZCt1E7uLAkn/zlDhzNsz
         siCDLhpd/EDKWLkjAISrOUN5+ApsATpFsUOVQyALsWGJsff0nSsUWygfmFxj67Xys+8J
         NJXihQ8r7Dp6a90UtSJtmsKVcIIHRfqwLGQztrRMe1BA5XSY+nQEfowhkz/00wL1M61y
         3dxZStUAIxCJqW61ii5oo53DaHF7OPUCJn+haJD+N3HsIeaWSPS+YpXpKgszyO361R7R
         rJOjQiwz8qgFSF+PRCpTtBqQmG17iEGjPp8N0K3u7VF9ptjjXXXeFbxTFR1vWpGimYI4
         3syQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRB6fOKqdf+FF3D/ewyCuVcuMS4RZcVMRpDoIyHn5ts=;
        b=ir7HJuRcDv75m5vGxaV97WtnSaB0IeLtA2UQ/92dkmGd0Ek+Q0Z/cqgRU/zxABVHgl
         3uI/uWkxZ1E0AfRdJJBjXv0qpzgpp6ExlArdy+zg/PV32h3vp8VG1G4qgwTIoqIuLc/8
         R6Fd2N900JsQdZL5m2sWM2+PXg/JRAo5M4bQL21ozuACb5qQj2IeEN61vS3YcvdsO065
         hblAYkV0QGFdleoQ+fKQbBoccVcoSfc+CrMRzGE0c+9gh6J7ESKsnjQh0C1gTDA9inU3
         +H/0SOr6+vc2KX4F/18H943WAYUIlIjbWIQnQqoyHvnGfmUWbkOcf1wcppt1JGSnhTO/
         Uiyg==
X-Gm-Message-State: AGRZ1gJG51S5+/ZP7WOLOPuvvBZcQj7hlqstITRydBtipgn2w7dqJOpn
        KiSbcS7Fo6XHVGBR7o9dgRI=
X-Google-Smtp-Source: AJdET5c3QNYYURvQxCJojjRl/qMUK9a+KTGNyc03DYghc1+5Yp6rLpc/r2r/MvPw241TvCuMyjV3VQ==
X-Received: by 2002:a1c:c902:: with SMTP id f2-v6mr1012241wmb.80.1542055524066;
        Mon, 12 Nov 2018 12:45:24 -0800 (PST)
Received: from localhost ([95.239.98.134])
        by smtp.gmail.com with ESMTPSA id a1sm1726850wrw.76.2018.11.12.12.45.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 12:45:23 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Cristian Sicilia <sicilia.cristian@gmail.com>
Subject: [PATCH 2/3] staging: erofs: unzip_vle.c: Constant in comparison on right side
Date:   Mon, 12 Nov 2018 21:43:58 +0100
Message-Id: <1542055439-24444-3-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542055439-24444-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comparisons should place the constant
on the right side of the test.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 1ffeeaa..35add4e 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -250,8 +250,8 @@ static inline bool try_to_claim_workgroup(
 retry:
 	if (grp->next == Z_EROFS_VLE_WORKGRP_NIL) {
 		/* type 1, nil workgroup */
-		if (Z_EROFS_VLE_WORKGRP_NIL != cmpxchg(&grp->next,
-			Z_EROFS_VLE_WORKGRP_NIL, *owned_head))
+		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_NIL,
+			    *owned_head) != Z_EROFS_VLE_WORKGRP_NIL)
 			goto retry;
 
 		*owned_head = grp;
@@ -262,8 +262,8 @@ static inline bool try_to_claim_workgroup(
 		 * be careful that its submission itself is governed
 		 * by the original owned chain.
 		 */
-		if (Z_EROFS_VLE_WORKGRP_TAIL != cmpxchg(&grp->next,
-			Z_EROFS_VLE_WORKGRP_TAIL, *owned_head))
+		if (cmpxchg(&grp->next, Z_EROFS_VLE_WORKGRP_TAIL,
+			    *owned_head) != Z_EROFS_VLE_WORKGRP_TAIL)
 			goto retry;
 
 		*owned_head = Z_EROFS_VLE_WORKGRP_TAIL;
-- 
2.7.4

