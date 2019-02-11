Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19C8C4151A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0129218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFKeaZqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfBKWAB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:00:01 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39329 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBKWAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:00:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so475157wra.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9j6arYV5oPSo1evTW/g+5CNWYkpQXSJzF8KLWrEz4EM=;
        b=JFKeaZqsMP57hGgCzSjlriqO35PCARns0ukYHF1y5+qHvNLziRjGrLCrCwec01pHNW
         Dzdqsf0x4PEEUKcVnlTMCn7cV3pkYgummcAFb5GfsPOAN1Heowb+dH4ORiY4e+JJs3w7
         lvLJtgGHHfYTSumoIvdcrXeT4sjVB3y9ORC2mVOJTEu5L0C7NzMUUJu5K/BZ6pRbOvmb
         SP7AcUJnm0bDvRyulxNZdYwDcOUu+CeX0rI9rvf+0dRCBOf9e8rbQHD30nTmdjOWqhNu
         Nhs8zlXsbvi7bMSq4wzk/hg5HJcDqKTdlguoHFLPbCXdN8mjrCUVxzpbx6wopB3Aguzl
         8jaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9j6arYV5oPSo1evTW/g+5CNWYkpQXSJzF8KLWrEz4EM=;
        b=JvlmdPGCVk796BIG23FoeO4c1PL+Xn7+G0VDmd6TxmFnJU5FXOMfsA5BrYjcIWI7wo
         91rDVPwZWO0SX6CwII+Di2dDR+1ucG6cvePVMdtsgsB0AOI5GYgAcOgDvI3iLmaEmMUj
         FiWL/p/B7ZIGMmwnySDVQuuzFbsXzpwG1I46PLOqS4FvCHbBfjxX5yHeEDsZRQIvt56I
         fz6JupWHlnBA0LsRgN7HhTM4qHnimMA5pW3TIn/ovnruItJlcx+Uu5IR6kQV9yO8PHNm
         gFO6RJyWp5UBNwiyh9wgtsgwF3Y7lSbz4SAaJmfNZGZWs5fPQpX5N6XB9le+DhJgg6Cb
         a3dg==
X-Gm-Message-State: AHQUAuYeEYjdGcx9v5zAqjYWlx1cnRhqcmjEmxH+4MGSbfkd65VFxV3e
        4yyKLYDVQ3dVDXZylUJs8e6CTw==
X-Google-Smtp-Source: AHgI3Ib0EaVpTVNKKkwVXXzcVygK8gOvWKEzBVqt3UqLkErRFV5ycOKGB6j6GwVyXsxz1AhNvWfs7Q==
X-Received: by 2002:adf:e548:: with SMTP id z8mr315108wrm.52.1549922398596;
        Mon, 11 Feb 2019 13:59:58 -0800 (PST)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:13:8ce:d7fa:9f4c:492])
        by smtp.gmail.com with ESMTPSA id c186sm762685wmf.34.2019.02.11.13.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:59:57 -0800 (PST)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 0/5] kasan: more tag based mode fixes
Date:   Mon, 11 Feb 2019 22:59:49 +0100
Message-Id: <cover.1549921721.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Konovalov (5):
  kasan: fix assigning tags twice
  kasan, kmemleak: pass tagged pointers to kmemleak
  kmemleak: account for tagged pointers when calculating pointer range
  kasan, slub: move kasan_poison_slab hook before page_address
  kasan, slub: fix conflicts with CONFIG_SLAB_FREELIST_HARDENED

 mm/kasan/common.c | 29 +++++++++++++++++------------
 mm/kmemleak.c     | 10 +++++++---
 mm/slab.h         |  6 ++----
 mm/slab_common.c  |  2 +-
 mm/slub.c         | 32 +++++++++++++++-----------------
 5 files changed, 42 insertions(+), 37 deletions(-)

-- 
2.20.1.791.gb4d0f1c61a-goog

