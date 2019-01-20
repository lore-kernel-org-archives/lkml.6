Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5526C61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938BC2084A
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 08:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OD3yXsWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfATIOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 03:14:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40838 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbfATIOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 03:14:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so19800156wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6TueSK0t2mbCzrUTvwto9p+ZPwhPUJQ8fKD3EecXO7w=;
        b=OD3yXsWDmwKt0s2/30zZ9wHAQvNxYe25MlTSBacU8H1lyh5DtbY3iagvPhgHl0wR7m
         0KZd0x/QursI2cOZQvqTzHH5hh1lXqzSpFpLRi+fOgTkC8RSKWF26YwYhyTRRT+sTIRi
         1p3hrY761Ep9sZdVFk1w6WbzPf9NWCQ0LkKeu4ZrqngaVhZ/7aWWOs+GYhqsP3X+UTxV
         g+jD0JLltHhn1zIVCetbwj4qR+eNe3oLFY3HtbC+/IMkhmSBDfOeCEhoZOzh3WM86usT
         uuLWYhI2YuUAtynTFX7jGy9fb41rIP+TsKHMUCCBHh6wXcJLJ+y+Q+AcEysiGYj5s0aT
         0a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6TueSK0t2mbCzrUTvwto9p+ZPwhPUJQ8fKD3EecXO7w=;
        b=MYEHh9fMlGq4wl4x0dFIrsO8acHltjArO0bqbdR00c3XQJc3eAYl7hwUlZuvbDozxe
         /2oO7e7RGdGjg/SMU+ulkBTxGSWXrPmfRKpCMyamBnJ4Mh+7tN10AuDuDwiFrjqajnwp
         lBe4VxseGxw185lS6mM5dzXqa3kkhaC5A2ZxF5FQvl61BBsd543vGBuVBFw466LuSSh6
         bp2fQqNbvzUCYY/2ltyNG+43QZ74WE79XjD6fzRjc7Gd+xz6hYkXX1OA9PEG5ga9Tw9q
         SuvWafVpRVN1TklDOhwXvNIXf46y5HPhLKdSqHpIzfCs+hBJzuRkyFoQUtm3t7Aei54R
         1z1A==
X-Gm-Message-State: AJcUukezLVh2z1Djqm5ilP5M9Mtu8oyY2p0JXsetXkvaFBS63lqiEShs
        7ETLsV3dpAGtzVZcW/z7N1A=
X-Google-Smtp-Source: ALg8bN4g15eyxfr6tSx564o9SKGT8PDY3+OtAhMoPjlRoT7TC6utLS7k15Ha8yOLXndfJB/2N9NhEA==
X-Received: by 2002:a5d:63c3:: with SMTP id c3mr22954222wrw.215.1547972059060;
        Sun, 20 Jan 2019 00:14:19 -0800 (PST)
Received: from localhost ([2a01:4f8:1c1c:6057::1])
        by smtp.gmail.com with ESMTPSA id k19sm142925012wre.5.2019.01.20.00.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 00:14:18 -0800 (PST)
From:   Yang Fan <nullptr.cpp@gmail.com>
To:     akpm@linux-foundation.org, will.deacon@arm.com
Cc:     Yang Fan <nullptr.cpp@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm/mmap.c: Remove redundant const qualifier of the no-pointer parameters
Date:   Sun, 20 Jan 2019 09:13:45 +0100
Message-Id: <a1ef2a2113cd8847002f0064f198aa4afe465548.1547966629.git.nullptr.cpp@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547966629.git.nullptr.cpp@gmail.com>
References: <cover.1547966629.git.nullptr.cpp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In according with other functions, remove the const qualifier of the 
no-pointer parameters in function arch_get_unmapped_area_topdown().

Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>
---
 mm/mmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f2d163ac827a..84cdde125d4d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2127,8 +2127,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 #ifndef HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
 unsigned long
 arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
-			  const unsigned long len, const unsigned long pgoff,
-			  const unsigned long flags)
+			  unsigned long len, unsigned long pgoff,
+			  unsigned long flags)
 {
 	struct vm_area_struct *vma, *prev;
 	struct mm_struct *mm = current->mm;
-- 
2.17.1

