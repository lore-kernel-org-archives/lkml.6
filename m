Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBECEC3117
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27212124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="B/uNCdU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27212124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=colorfullife.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeGLTEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 15:04:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34460 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbeGLTEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 15:04:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so22677143wrt.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JKhNjtSAaGH7H2rmz0Zl3PymPdxxLi/JZsA2Os9fvJU=;
        b=B/uNCdU6Ka5mxo78UVsxqDrSpRCZ2A3sfD5eoRXlAxNmHuNpNBBwPiVHjPrMEWa1x7
         QZNjRqXsfY6/AFnf4vgF/UnkjZiTCKXjRPZMO6EwYYbX9+XORCBDBVub0OZSGhNF+MH/
         7JKh3aAnL7WwmTe7nkXTaC6nvhIM3YXkNTHsHCPIOWj85gVRpcIgmUixURRzOhtK575j
         RQi5j3fZtAzu/KL9r0aQaYBzpmRVItbmr7Y5ntzNuEWLJlRwhFmkiEKaxiDbN0gMCSqM
         oLCXB5qr7e36d2Bd1RIeX2nsmTMlqKQ3gsLz8eR30/KOC1R3un5NBvUvfgyEWx8Frmjw
         P3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JKhNjtSAaGH7H2rmz0Zl3PymPdxxLi/JZsA2Os9fvJU=;
        b=i1qIeVTix/b7ONRdsd4Ubb3I0lLh1e88jz6gwodXNXoYhL2hNj66/0HwAzgWXanQTx
         SOsr+G0N/F24CY3NX4gWpIA1vPPDYEJzeB1v+wZvFfd9zcBWYNEXjKwW8hnTyU3xn+4r
         aYKCXuejjlgC6Ocw/OTFtGwkPnq39ELzUxA6BxQEVEbr2sSDUU5wnF9wmzFeNtDedfx1
         N2ipBqEyZJWnJTkUdKX1nboXSrQj9yJMjwVKrqdT28kmwuLR2I9EjtD9w65KCCzmHeMy
         8sqb5fWfyDi3YTSs2V3P54RXzEp9xbebrin+FpGPIyOkyBpwaWuYlsYaM5jmB0qW44aX
         SeKQ==
X-Gm-Message-State: AOUpUlFdBlK1UH/xs7bc9RXKCYsgjMAwCZHTSzt6IRbEtpP6Lf/CJs+b
        kZlhRlZUcTmN7Iq6MQWEcbAJqg==
X-Google-Smtp-Source: AAOMgpeY6Pr5I8aHOUcq8tnHeQz4H5ZK23dOU7yi+X9y257g1XXqz4xY9qpZsKqjfpkMyzNreixK9w==
X-Received: by 2002:adf:820a:: with SMTP id 10-v6mr2563731wrb.144.1531421591217;
        Thu, 12 Jul 2018 11:53:11 -0700 (PDT)
Received: from localhost.localdomain (p200300D993C98700CB5FA3798C189FE1.dip0.t-ipconnect.de. [2003:d9:93c9:8700:cb5f:a379:8c18:9fe1])
        by smtp.googlemail.com with ESMTPSA id h5-v6sm13557841wrr.19.2018.07.12.11.53.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 11:53:10 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, 1vier1@web.de,
        Kees Cook <keescook@chromium.org>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 05/12] ipc/util.c: correct comment in ipc_obtain_object_check
Date:   Thu, 12 Jul 2018 20:52:34 +0200
Message-Id: <20180712185241.4017-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180712185241.4017-1-manfred@colorfullife.com>
References: <20180712185241.4017-1-manfred@colorfullife.com>
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
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
---
 ipc/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ipc/util.c b/ipc/util.c
index cffd12240f67..5cc37066e659 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -628,8 +628,8 @@ struct kern_ipc_perm *ipc_lock(struct ipc_ids *ids, int id)
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

