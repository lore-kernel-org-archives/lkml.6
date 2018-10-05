Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8427EC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B15A2064A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 20:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T06XpNmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B15A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbeJFD5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 23:57:08 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:35337 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeJFD5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 23:57:08 -0400
Received: by mail-pf1-f174.google.com with SMTP id l17-v6so1242317pff.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Oct 2018 13:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=oiH6WIJw0SwIaQ642BGhkhzmy8npNh3I5SKlNrttZb8=;
        b=T06XpNmg1OF6WHIa+WzJF87opaefEhN468qSSzH/3KuVmLQ5dBOPeHyFsIAdEZoBax
         6IV4Zk1OLzLw4YNYpZz0um5BQfj2aFr0SRDiCm3ZuB/i6FXryKZ8hNC7hNhhsd8BbmH/
         6TYfCBTAwxKML3O0CisTnByuSo22etuJsxv+0wBZ2TQWlHtEpQZ+5FWCULCMBK68zz8e
         YZ0eipeZYG3sSIovrM2dBkX1XXwIg3RYQaMsRbO+ee4JHH/Vk2lD4JSrzhRUxwfLYpj1
         NjfkLiVjDBS8BkUSM3OE2j/xFWfkpxc9S8ofFo1Dz7JEwt2hc9THpnNLn+rQQwLH7nFj
         ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=oiH6WIJw0SwIaQ642BGhkhzmy8npNh3I5SKlNrttZb8=;
        b=XsfCZFcfKiuGhZtAVP78EQ8Arbrh+2AYT4XBget6Gavj8qxINen5a5xke+BeV/f8la
         Wxv4U/s7YOgmtrOJomoBi41NeEw/Tgzoc7DP6vGnDWUmRKdSaAEk57l6W+pU8JLxx8oZ
         Y85P+aKKTEltYAJgXeNgif26nwVv1s1GIy/bcz8YDXo7/QM7Xres4B8pshquFQjKf84k
         imtAAuK1B1AxnTCmjkv23JZe7ptduzp5hNgVjgzKP0vRwAxxzICZl7ohpE3p24Oi1cFj
         mb3GVXquWZbBQC3Aipc/pFoAMz1h3VnQJTQhISvAq9AZ3Y0dDPCY7VJ7BrnBTaODMx0i
         8HiQ==
X-Gm-Message-State: ABuFfoj4fDe8HGbfUU0GUgfEk8tcSuc8SDqgY/uslxZxMX4wn6OTTwOE
        lhdfgmFDPg24yTVzeJqxkA3cEg==
X-Google-Smtp-Source: ACcGV619YX13bDKtqM5DanIAO4/T2lFv4l52x/SVJQ98Nl4CnYd3/FJ+xwUTb8wUiaEFx4/71ss/Tg==
X-Received: by 2002:a62:d582:: with SMTP id d124-v6mr13662157pfg.31.1538773001116;
        Fri, 05 Oct 2018 13:56:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id o12-v6sm13654542pfh.20.2018.10.05.13.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 13:56:40 -0700 (PDT)
Date:   Fri, 5 Oct 2018 13:56:39 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [patch] mm, page_alloc: set num_movable in move_freepages()
Message-ID: <alpine.DEB.2.21.1810051355490.212229@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If move_freepages() returns 0 because zone_spans_pfn(), *num_movable can
hold the value from the stack because it does not get initialized in
move_freepages().

Move the initialization to move_freepages_block() to guarantee the value
actually makes sense.

This currently doesn't affect its only caller where num_movable != NULL,
so no bug fix, but just more robust.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/page_alloc.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2015,10 +2015,6 @@ static int move_freepages(struct zone *zone,
 	          pfn_valid(page_to_pfn(end_page)) &&
 	          page_zone(start_page) != page_zone(end_page));
 #endif
-
-	if (num_movable)
-		*num_movable = 0;
-
 	for (page = start_page; page <= end_page;) {
 		if (!pfn_valid_within(page_to_pfn(page))) {
 			page++;
@@ -2058,6 +2054,9 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	unsigned long start_pfn, end_pfn;
 	struct page *start_page, *end_page;
 
+	if (num_movable)
+		*num_movable = 0;
+
 	start_pfn = page_to_pfn(page);
 	start_pfn = start_pfn & ~(pageblock_nr_pages-1);
 	start_page = pfn_to_page(start_pfn);
