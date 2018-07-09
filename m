Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF046C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FA32086A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="slAPETms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89FA32086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933459AbeGIPKq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:10:46 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40171 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933385AbeGIPKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:10:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so21137876wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 08:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5hh9CLwAh3q9is7L4jGzz8ZSli3UwF4edqEnPO2wzag=;
        b=slAPETms32PPWztG4gZM1vS5Hcbvohg6/MKpyahXvdRmHmDoatZivgpYs51NUGX5Sb
         I7twtDuoVm5TMGf94jU7qn+MD23l17vg8/4C1uKPf8+Po966tiNaIKNLglqGTMcrqPEF
         /aOaz8C4Iptow652RnHFgCGRoAERAI6yvACm0pfs7/I9rIZIA5LJVvjoBhuBpBhD3IYW
         YsKue2eJMF41TGJlneB71vheofVg87omlWG6+pyPojuuDlFdtj9q8fwPpGmFclyhxIjs
         wDmf10KAWpoHmGvsJ3lOP4rUuSBuiawPCkNQPPG2hC8utScZiDe+NdMktuEXygyV5YN1
         AxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5hh9CLwAh3q9is7L4jGzz8ZSli3UwF4edqEnPO2wzag=;
        b=jExpC60TvN+jzcXnHtEm2wCCVKMDEdMHq6hS3Qy1uB5n8QU8VR+UZmUlwn59SjusvD
         kTWL/poc3gL1lEnsymVM+m8qLKCmzbNSdu5njsEAnGZ5DyeCg/BSZtIdItS/0kp7/X+C
         7Fag2yPAXMybzF3gzDD/NHQ1osPg6RKCI2FlivEL5IdxH9+Zyy5ZZ7YW6CKfHKEV9LC5
         Bv9fDZOSWrmC65t2/CSywL7+Lu4VAzXxVtFqAxfm42m979AnfXmCJPPUVx6NSbb8V14A
         5eWxTJMkZ2FoqC2wwxqCi/QXIiS5xdFUwZyhWl7LdWnAmzXWN9Vs64fPB03U4v6wMy4v
         5LTA==
X-Gm-Message-State: APt69E0+apUvc29S7ofo8gJWOTGa+aEWedog8hiv3ZTKzOw5EVIgY1Or
        kbp5sRwMQnHuzZrUAEtZadgcGqCY
X-Google-Smtp-Source: AAOMgpfTDmObZAfFjxp48W8ZZJGNl1tRtZ2y9aLc/+1Ei8rDB4cKzeCu+YB/q/PbRS211n4OcBKUvw==
X-Received: by 2002:a1c:2d54:: with SMTP id t81-v6mr13907358wmt.31.1531149035935;
        Mon, 09 Jul 2018 08:10:35 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C227000209466FFA2F090C.dip0.t-ipconnect.de. [2003:d9:93c2:2700:209:466f:fa2f:90c])
        by smtp.googlemail.com with ESMTPSA id u124-v6sm7817330wme.26.2018.07.09.08.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 08:10:35 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 05/12] ipc/util.c: correct comment in ipc_obtain_object_check
Date:   Mon,  9 Jul 2018 17:10:12 +0200
Message-Id: <20180709151019.1336-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180709151019.1336-1-manfred@colorfullife.com>
References: <20180709151019.1336-1-manfred@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment that explains ipc_obtain_object_check is wrong:
The function checks the sequence number, not the reference
counter.
Note that checking the reference counter would be meaningless:
The reference counter is decreased without holding any locks,
thus an object with kern_ipc_perm.deleted=true may disappear at
the end of the next rcu grace period.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
---
 ipc/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index bbb1ce212a0d..8133f10832a9 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -644,8 +644,8 @@ struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
  * @ids: ipc identifier set
  * @id: ipc id to look for
  *
- * Similar to ipc_obtain_object_idr() but also checks
- * the ipc object reference counter.
+ * Similar to ipc_obtain_object_idr() but also checks the ipc object
+ * sequence number.
  *
  * Call inside the RCU critical section.
  * The ipc object is *not* locked on exit.
-- 
2.17.1

