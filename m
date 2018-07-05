Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC89C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740592417D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 06:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="b4fM+PVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740592417D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753455AbeGEGAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 02:00:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38250 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbeGEF7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 01:59:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id j33-v6so526113wrj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 22:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=boSpCsWD5M4fdfFWKH0uKGuYtbkzbgBGuWrph4KF9sQ=;
        b=b4fM+PVWpWLH18iAXljEmWuc+GawvU23F8VVDm77jc2a/GZ7IXP5sDVYew+sJMn5Y6
         LCmRYoVZ1CgmFXwTVbamf8MVxb52CkfWjNmKiNuwt0jYMfC4aQ1d91W8YigxrFU4X2q1
         YMHNblEQK87JkO9omHHoU0H65a2sc2kwLkVpIk4Aqd6UIsvNqfTrgVhQMgmNLZC7xYA0
         3AbvycJXQpyqXZ9iCspiGh2EHHlOd/sw5olX4D75gJkg/5FuofbF4ozldEoAGqmXXFuS
         1wOL2zYyZM6xGmBIho+SfJ6SAUFh8CWKAH+Ng0Eak7d5LG76nWgKVmm3eDaZ9aRfEz0I
         TGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=boSpCsWD5M4fdfFWKH0uKGuYtbkzbgBGuWrph4KF9sQ=;
        b=lnvwqHtDO/gGFMDmestadnoRDAWsWHldM7nVlK7srTk3IsZVgijFw7dJSQkG/QpZ7A
         25+Mg6upW59oi/E863+0MRN/haEipugAO7A7g0dV27oBvmvzputDvVqVSbiYj7ldE9Ax
         /L2f/1P+bhAG89NdnXP1M4tRvqFWjFM+t6+o50vDefudqu7GegMCMdfbl5F/hpv/aSaF
         inhNhD2HAlvmIcKLFGjw6mhn9KsAl0501tHWl/Vd2aB6ADGSZP6KkT9QReFE8DieEfBC
         5ZkTLA0hzyTHhUNskgL4JzhNIyBgDmMGtd5SwCRnbieRJhwziVUy0ww3aizOm+lpqb1W
         UeOA==
X-Gm-Message-State: APt69E1jcum/57eOjjy77OJmRUEcY0XX9yWDNxkYeSMwB5LdztQXvSXh
        o7hDkHLSQjpTip3e5k+3j0G8omEiRCJCew==
X-Google-Smtp-Source: AAOMgpe5ktUO5dBn3V6IawTv2GIlUOwyFNzptmD0A6JLqz1JwuYB3n6V4LDUcVcILd+UCq6Vv7ABGw==
X-Received: by 2002:adf:b60d:: with SMTP id f13-v6mr3249515wre.186.1530770385194;
        Wed, 04 Jul 2018 22:59:45 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C4E0002E4725E865D6E031.dip0.t-ipconnect.de. [2003:d9:93c4:e000:2e47:25e8:65d6:e031])
        by smtp.googlemail.com with ESMTPSA id h40-v6sm7452689wrf.40.2018.07.04.22.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 22:59:44 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 6/6] ipc/util.c: correct comment in ipc_obtain_object_check
Date:   Thu,  5 Jul 2018 07:59:20 +0200
Message-Id: <20180705055920.19611-7-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180705055920.19611-1-manfred@colorfullife.com>
References: <20180705055920.19611-1-manfred@colorfullife.com>
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
---
 ipc/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index 4f2db913acf9..776a9ce2905f 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -646,8 +646,8 @@ struct kern_ipc_perm *ipc_lock_idr(struct ipc_ids *ids, int id)
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

