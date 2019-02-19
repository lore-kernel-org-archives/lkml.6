Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A3FC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434782173C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 05:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IFdYJ03B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfBSF05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 00:26:57 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39545 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfBSF05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 00:26:57 -0500
Received: by mail-ot1-f66.google.com with SMTP id n8so32227382otl.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 21:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=Nn7jvN56Aij59rB16XbFytNtDnwP8hvfDgxfVmhsN+4=;
        b=IFdYJ03BUDOzKwP2gwBMlbooLzhGcLWZDVHmjwf9ZDSeSb+YuYEGtkaLmxWFwwlZPR
         zwVwFZ+IOC7/n4lzvQakHGbrUJk89//jhxZ0sQaWVSlZhVBNAOhSG6DECh90OQzP4/eC
         XCIE1bIk3WjqwBojZ+FBcre0vLgYdYQgXFbYLXYDQICZM1QP+f1Q+H7FIqmERzIYSZfP
         lahbNq61TkIsedWlXZ5jxkvapFFvMNzxamYa/bvUX8WDx1GEObw32T4lymRSlWFSGNno
         cz2TeQ4ajPJDc3Mi91VFPnu5xz6A8FY1AY0DY0TRCpexK5I0DDXZXvwIKPLM9/Fk6+i4
         8GOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=Nn7jvN56Aij59rB16XbFytNtDnwP8hvfDgxfVmhsN+4=;
        b=cobXRtPdLz6hBQVqX2Cp1oW7tMhthbRNYO84ySeMp2mx1dsBHBW668RHy5qb1GDKdX
         lg3Nn8Zbc+ZSgNA6IAbjvtL2Ey/Q2VC9UiMW0u6mUfC8fhdm94huV/v/SgczpVWkMLfh
         RSSIQXJV4tSHkdgvUBAWJH0XiW9wTzUNmpILSuAgWbNy8Eel5PthQ5SwZUVAcC4A81Dr
         isNKLTgpJFOysW092JXaE4yVYChEW6++4Y+EfjlEW3Af3Qnmd+hc1ChYtpPOb4foHAGD
         Pe2KMmsaEnalcEz84KolnD0gE2MBnJhKSoTVSYOpVdgCGQK2lDloaukjr19BLD/Zr6UY
         /Gaw==
X-Gm-Message-State: AHQUAubb93O5XeeE2Qknh7AmPHt0Rh3TSVX2ZXVxH+ZnoKsCQz0T9Im3
        UFp7homx8f1n+BvT/WD9i4jpjg==
X-Google-Smtp-Source: AHgI3IZP4FYhFOb0TC+x7B0bKWbbezKsrPAqVG/zOjPc10LzdCDMZ0Y8xraBhpTywalhPMH/5SBlUg==
X-Received: by 2002:aca:33d5:: with SMTP id z204mr1399324oiz.61.1550554015453;
        Mon, 18 Feb 2019 21:26:55 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id y137sm2154861oia.9.2019.02.18.21.26.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 21:26:54 -0800 (PST)
Date:   Mon, 18 Feb 2019 21:26:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>, ktkhai@virtuozzo.com,
        jhubbard@nvidia.com, hughd@google.com, aarcange@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH mmotm] mm: ksm: do not block on page lock when searching
 stable tree fix
Message-ID: <alpine.LSU.2.11.1902182122280.6914@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the kernel BUG at mm/ksm.c:809! quite easily under KSM swapping
load.  That's the BUG_ON(age > 1) in remove_rmap_item_from_tree().

There is a comment above it, but explaining in more detail: KSM saves
effort by not fully maintaining the unstable tree like a proper RB
tree throughout, but at the start of each pass forgetting the old tree
and rebuilding anew from scratch. But that means that whenever it looks
like we need to remove an item from the unstable tree, we have to check
whether it has already been linked into the new tree this time around
(hence rb_erase needed), or it's just a free-floating leftover from the
previous tree.

"age" 0 or 1 says which: but if it's more than 1, then something has
gone wrong: cmp_and_merge_page() was forgetting to remove the item
in the new EBUSY case.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
Fix to fold into
mm-ksm-do-not-block-on-page-lock-when-searching-stable-tree.patch

I like that patch better now it has the mods suggested by John Hubbard;
but what I'd still really prefer to do is to make the patch unnecessary,
by reworking that window of KSM page migration so that there's just no
need for stable_tree_search() to take page lock.  We would all prefer
that.  However, each time I've gone to do so, it's turned out to need
more care than I expected, and I run out of time.  So, let's go with
what we have, and one day I might perhaps get back to it.

 mm/ksm.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- mmotm/mm/ksm.c	2019-02-14 15:16:13.000000000 -0800
+++ linux/mm/ksm.c	2019-02-18 20:36:44.707310427 -0800
@@ -2082,10 +2082,6 @@ static void cmp_and_merge_page(struct pa
 
 	/* We first start with searching the page inside the stable tree */
 	kpage = stable_tree_search(page);
-
-	if (PTR_ERR(kpage) == -EBUSY)
-		return;
-
 	if (kpage == page && rmap_item->head == stable_node) {
 		put_page(kpage);
 		return;
@@ -2094,6 +2090,9 @@ static void cmp_and_merge_page(struct pa
 	remove_rmap_item_from_tree(rmap_item);
 
 	if (kpage) {
+		if (PTR_ERR(kpage) == -EBUSY)
+			return;
+
 		err = try_to_merge_with_ksm_page(rmap_item, page, kpage);
 		if (!err) {
 			/*
