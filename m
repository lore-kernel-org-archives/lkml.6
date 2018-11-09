Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FD1C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A962089A
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 06:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sX4Na+DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48A962089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeKIQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:27:01 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43328 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbeKIQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 11:27:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so486890plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 22:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=reMxc0zME/3qnvb1lgC8fPj6wExKKId/iU2Ws7jwufo=;
        b=sX4Na+DOIkEp8+jX1RN+XNnQhGy5F6jH9jm1540XiJ8QHjfVWTav7yF30BP24Im3eA
         VtWXF2EYY/5OnwdFfRFACh1uDZ9h6tEEPrw7UN3TXxByip33AO+cAGeA4ya8agN16JTd
         ymjkgXnVOa10zlcfD2526ggxsjZfoOGzkJpe48BZM0hNcZNLqJXUh/ZmQYE6sReI/QMc
         +A7KbCfDIhTB+uinSlk/F6oNYEWPPQBhObLkyTSEjBC+SSyGRgnm9UBm4L20YXKQOBbL
         yyrzuSut9vo+5DjD0eZ72yyIeX8Km5kLYl6Sj5HTiU/f7NefBPtQdax7RK71UmxTFTC6
         YaZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=reMxc0zME/3qnvb1lgC8fPj6wExKKId/iU2Ws7jwufo=;
        b=e+MH/6AweyxHWa+yDaFuHcn+zdASYM7sP9dkXxc6JjXSp8z2gFUAyYJMN+8/orPk9q
         kb64V+e3DHM7nmqGCqXPCu2LPp+CZhZjmq/Aj6p65/MWupZVEvoxjIVisjHHKQ90ukYb
         m9qVvuZSUrF+MigdQ6rouz1WIC+vFSbmmQlitbUBHP6WcrCVAJSnhenHT6zcAxjNnXuH
         go3gKaMM+9wSEqHDCZcumHEGLEBPqhGk/G9EhzCUypLZUw2EhRfE8M6nO8Nl4z58hAn7
         VdIyp9l3RpTbKi+Z5h3ZvYNOMK6W0IFf6tOijIdQQuBDriMJ667KTdZ7zgnB6DnTzcMn
         9c5g==
X-Gm-Message-State: AGRZ1gK1ZsRfkK7jk3Jk7Be6r2jfMd7ru5UtMb/xjzrwxWgm4KcWlXHO
        0LeAVWsd816Ha2B2ZYVeFg==
X-Google-Smtp-Source: AJdET5e2fP/t1Qu1zfXBkpc+PbootYxSvNp2FUi3S7keZeteohCfTl2hA/2vrBx+uO25u70WowANVw==
X-Received: by 2002:a17:902:443:: with SMTP id 61-v6mr7536198ple.216.1541746071478;
        Thu, 08 Nov 2018 22:47:51 -0800 (PST)
Received: from www9186uo.sakura.ne.jp (www9186uo.sakura.ne.jp. [153.121.56.200])
        by smtp.gmail.com with ESMTPSA id c70-v6sm6808355pfg.97.2018.11.08.22.47.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 22:47:50 -0800 (PST)
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        xishi.qiuxishi@alibaba-inc.com,
        Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: [RFC][PATCH v1 10/11] mm: clear PageHWPoison in memory hotremove
Date:   Fri,  9 Nov 2018 15:47:14 +0900
Message-Id: <1541746035-13408-11-git-send-email-n-horiguchi@ah.jp.nec.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
References: <1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One hopeful usecase of memory hotplug is to replace half-broken DIMMs
with new ones, so it makes sense to clear hwpoison info at the time of
memory hotremove.

I hope that this patch covers the topic discussed in
https://lkml.org/lkml/2018/1/17/1228

Signed-off-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
index 970d6ff..27826b3 100644
--- v4.19-mmotm-2018-10-30-16-08/mm/page_alloc.c
+++ v4.19-mmotm-2018-10-30-16-08_patched/mm/page_alloc.c
@@ -8139,8 +8139,9 @@ __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 		 * The HWPoisoned page may be not in buddy system, and
 		 * page_count() is not 0.
 		 */
-		if (unlikely(!PageBuddy(page) && PageHWPoison(page))) {
+		if (unlikely(!PageBuddy(page) && TestClearPageHWPoison(page))) {
 			pfn++;
+			num_poisoned_pages_dec();
 			SetPageReserved(page);
 			continue;
 		}
-- 
2.7.0

