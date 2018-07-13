Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72BEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C1B214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 03:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rrbaeh4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C1B214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbeGMDiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:38:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33384 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbeGMDiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:38:54 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so11545544plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+ZOWsLyefxrEsH6Kn8fxhHU4Bo3pLyyT1JTMbw4TZFA=;
        b=rrbaeh4B/QQ33+J8eiFobXnzQhIC0idSPKV4+JUMMRJstPTWJ60hpTxQZ3Y5DgiUaB
         CBMGQ10Xmm15Qk7TC4vF/vfRfGpgWY4qR3r6QRau1U6O87pONYpmBoBaCcII6N4G4J7w
         HwcDGOSIO70HUSELJJxgdewE0AgqqaVlVqb9H6T4lmCcwAqmSdxfvhq7AE4uE7Q/GAYW
         1ev1+qGgC+eMaCn5Ddz6wXo1kC+xhwjGl7h6EMABrvC8nwUbvuUd4+uP0nHI213ay34/
         IRHS3Rg4G6nPHhGpCQPkz4bbToKY6Ey8t9sygY6zZRLH3VwEz4/Ulw1j5sq3rZSY6/H8
         /dGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=+ZOWsLyefxrEsH6Kn8fxhHU4Bo3pLyyT1JTMbw4TZFA=;
        b=ZVvnT4jKC4yy+Rzg4rbCOtVlTfHenwH8dfwqtANyUAHCq4AXy9y3U1c/XozIjiqXka
         L94b2AqRhq5XoDIgKdYI3IPN2VZuaZBNIAqL4Q5E9Ea3/B77i3k6NokXvPFJNBRLPRBa
         552Jlc080JuSgkPAbONFjKkY3/W8mLXzNpB9h+5ES0/MBHf1XK4vwIoIcwSoU41JanpX
         6SxRp8t7Uvvmn50fZIB6RkO+FwmoT+cAQDyWD82u0GLcRLd17j65NhCX1agqWa1E0QDJ
         zCWgEe1x7eKgafG0B4dnrzcB3tfMQ+TwFJfnvtkp9Lr86ktmPe7NCPVpuRrjAhU1TjYj
         b3ww==
X-Gm-Message-State: AOUpUlGeO2cF612r6uCVV9AOj/ky/2CYUM3omGLW///xhobE66j8KZyx
        SNDNKyaxItnZkUHZ9TD6hKzL
X-Google-Smtp-Source: AAOMgpdOy4aC7fs45UBEJGfh8ftRlF6fWyYObW0VN+UPL5LYHVirjW2v83j2kMnuAALo2DdiSW2oPw==
X-Received: by 2002:a17:902:6105:: with SMTP id t5-v6mr4682133plj.92.1531452378951;
        Thu, 12 Jul 2018 20:26:18 -0700 (PDT)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id b66-v6sm8867241pgc.15.2018.07.12.20.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 20:26:17 -0700 (PDT)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        xishi.qiuxishi@alibaba-inc.com, zy.zhengyi@alibaba-inc.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] mm: soft-offline: fix race against page allocation
Date:   Fri, 13 Jul 2018 12:26:04 +0900
Message-Id: <1531452366-11661-1-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xishi recently reported the issue about race on reusing the target pages
of soft offlining.
Discussion and analysis showed that we need make sure that setting PG_hwpoison
should be done in the right place under zone->lock for soft offline.
1/2 handles free hugepage's case, and 2/2 hanldes free buddy page's case.

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (2):
      mm: fix race on soft-offlining free huge pages
      mm: soft-offline: close the race against page allocation

 include/linux/page-flags.h |  5 +++++
 include/linux/swapops.h    | 10 ----------
 mm/hugetlb.c               | 11 +++++------
 mm/memory-failure.c        | 44 +++++++++++++++++++++++++++++++++++---------
 mm/migrate.c               |  4 +---
 mm/page_alloc.c            | 29 +++++++++++++++++++++++++++++
 6 files changed, 75 insertions(+), 28 deletions(-)
