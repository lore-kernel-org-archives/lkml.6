Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79443C43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4031A2070D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k93Nd6NY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731596AbfACQvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 11:51:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42757 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730564AbfACQvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 11:51:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so16929902pfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jrwHgtkCQwF2rPUZYzIejxvjNx1vb9TnxizkWLytHK4=;
        b=k93Nd6NY1GIOKIuAhowyBF82KFzV4pay5TAhMnRBU3s4BW7Ejd3kdsi87oy87mZL0a
         iWlUxmNV0rSXF3hYhmpV8TMAqNwp6IB99xqi4sQBnaAJ+0Psbj8TL1bilUhVWg/9eg8j
         CKKKmt7xkxkMTP20Rv+5SHWWuxouv051IjBIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jrwHgtkCQwF2rPUZYzIejxvjNx1vb9TnxizkWLytHK4=;
        b=MOBWWBbNGgCm7Cx3noxRDKNv0aQGSHIXm9YsiYuCE+UkJ6ggDW74s9OB3z8j/Tw+Ek
         Bcva6tHGHGJB24iT4BfJFX1tiA/xr8prwNXdN+SGWfvA4ZBoX9S+rM1wNr5D65o4LcgH
         2sBtw/XnhmIKJwF5RFbBc6NkCDY/wF7Dc4sk8Rlbf1NuIWZO23mhFMjpv5Cv/5YlwRZv
         4C/VfD5XTHLi3PRQoqnu9GmUjn0GvVhNmahkBrdbJsDjOpMx8/J0C/1NDqHUR7FhiUAO
         3fXggl5jCnT6lHEOraovvFJmoaeXYnlGTCMBFsY2f+hJko6ly9dkx6ao0sIejrJ98PEc
         DlPQ==
X-Gm-Message-State: AJcUukexlVztsBQ8zCKiCj1RQummesvLXAOmuDPwao0SjeLBLUMM/wVC
        0zvQH3u7RF5B8e/H7HfZv7S+mw==
X-Google-Smtp-Source: ALg8bN4SYo4uj5LQhpGJY4hD/Ku+zio0bIXRIhltsvthmocre8JSoGpptJx0AapRY+iLB3iLzp7tog==
X-Received: by 2002:a63:de46:: with SMTP id y6mr17603516pgi.198.1546534312808;
        Thu, 03 Jan 2019 08:51:52 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 202sm112423708pfy.87.2019.01.03.08.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 08:51:52 -0800 (PST)
Date:   Thu, 3 Jan 2019 08:51:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] usercopy: Improve comments after reorder
Message-ID: <20190103165151.GA32845@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the comments to better reflect the order and purpose of
the checks.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index e9e9325f7638..726e570c9b9e 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -243,7 +243,8 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 /*
  * Validates that the given object is:
  * - not bogus address
- * - known-safe heap or stack object
+ * - fully contained by stack (or stack frame, when available)
+ * - fully within SLAB object (or object whitelist area, when available)
  * - not in kernel text
  */
 void __check_object_size(const void *ptr, unsigned long n, bool to_user)

-- 
Kees Cook
