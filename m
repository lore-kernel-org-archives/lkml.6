Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFDC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6315F22CA0
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="qff2RF20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6315F22CA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934807AbeGFTcz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:32:55 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:43409 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934782AbeGFTcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:32:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id y8-v6so9178321pfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 12:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oWrXkw863CtgwaYzdEUdUD8smkG4UEhz6OHrx/76WIU=;
        b=qff2RF20yCB2Ly3Yh4l44wMwkBf/r4MjbaQ6pRR9D3GnaRl/oPJ5PV2pTGJUNhMBko
         RqWWLrYMJ1JX/B3fdhodMKuz5JvL14PDNnPazMXA88K+3n6yi42M9GrPvld1GWnskOg4
         uAKxvp3yGcGTQWA2+M0mLaZkzHNpKBhDcW91Jfls2BdADl1B+eLd33gKaNRwtJNEw6MW
         AbLHcKDsqJmUo8GwNGbedTKPEVP7QJeAZx5h9Ujh8Hg1Huc5reSu3LYLaQUs5I3kg47R
         L3ykgKHhj96ThU/8ChfohLMZWuJY/ormm9llgfsvZl6DpMbl8PtjrQnQXzsCXvU/HfOr
         DTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oWrXkw863CtgwaYzdEUdUD8smkG4UEhz6OHrx/76WIU=;
        b=sEzkWcTiq5yI6d3AJ/uv8CWSzeCZ1PE7azEl0sVBIcRdTnclmzs9YksjOANloxkGoC
         TZOrTwfDVWtpqKUzk3mHLaTKwhl/NcOCQWZJMT4hwnZwrD0PoDp5d+7xvQJDYo24SlUG
         ACbnU7bE/p4FJUIpOzlKMFEMjiJGbZJvMv4giVhFgwuWPaSSWAZO8wADaIw87T7+xK4c
         MfRk8NdavO0d5Z4H0r6ExdQDw6a45pvN5UJY7xWG5u+2YFd+/2xV42i9XWmeO9t73PbV
         9NLs8ZKMsOnia/obnk32r0H6etxggwgNhrok808MG0vNasiXvoVLQpYHRkIR9wTXNZvw
         YU9g==
X-Gm-Message-State: APt69E1+OBz8i22EYM3zrWr1bhkni3ue7trW6WFxP++Mp7oRA5AGpAma
        Vr1S/PWz6M8RXvOFrcaGBgcXFMznWWk=
X-Google-Smtp-Source: AAOMgpfNKGejL1CoGvb6Z6V4u5MVE5fsQ+bItkcXYYB/NhWfxMYUlKCtRu6cWVrLSne4RwXJnIHNUg==
X-Received: by 2002:a62:ac12:: with SMTP id v18-v6mr11633220pfe.126.1530905571553;
        Fri, 06 Jul 2018 12:32:51 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::4:984e])
        by smtp.gmail.com with ESMTPSA id a11-v6sm12846162pgq.32.2018.07.06.12.32.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:32:50 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Eric Biederman <ebiederm@xmission.com>, kernel-team@fb.com
Subject: [PATCH 6/7] proc/kcore: optimize multiple page reads
Date:   Fri,  6 Jul 2018 12:32:37 -0700
Message-Id: <ed665d06dcb0bf654cff3637161d7b040cf9e4c5.1530904769.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1530904769.git.osandov@fb.com>
References: <cover.1530904769.git.osandov@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

The current code does a full search of the segment list every time for
every page. This is wasteful, since it's almost certain that the next
page will be in the same segment. Instead, check if the previous segment
covers the current page before doing the list search.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/proc/kcore.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index de225b61f34f..f1e21579cd22 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -426,10 +426,18 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
 	if ((tsz = (PAGE_SIZE - (start & ~PAGE_MASK))) > buflen)
 		tsz = buflen;
 
+	m = NULL;
 	while (buflen) {
-		list_for_each_entry(m, &kclist_head, list) {
-			if (start >= m->addr && start < (m->addr+m->size))
-				break;
+		/*
+		 * If this is the first iteration or the address is not within
+		 * the previous entry, search for a matching entry.
+		 */
+		if (!m || start < m->addr || start >= m->addr + m->size) {
+			list_for_each_entry(m, &kclist_head, list) {
+				if (start >= m->addr &&
+				    start < m->addr + m->size)
+					break;
+			}
 		}
 
 		if (&m->list == &kclist_head) {
-- 
2.18.0

