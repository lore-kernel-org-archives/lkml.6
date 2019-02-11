Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF26C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA8121479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 06:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vexrQKj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbfBKGeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 01:34:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:37384 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKGeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 01:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yxRrm7VICj3zaCZA5XwcFN8ealtHYWBMkDEcG+Ng+Sw=; b=vexrQKj7oP9VA079ZN7V1ZL0vC
        h6x359EpmPAavgXZYDHFfPC6R6pbEk/HLl1hhN/D8LO/DFo6HCJgtTEhtMGj+xE5GqtBknVhZ+jgq
        ZfA4wLbRXskVPghHiX5BIiXar5acy4VqhfmqrplcMbT1xaNq1C01J0sjKqLv7zKW3kTKGnH4Cp4bv
        fTAvwZrGtQGhKY707UaXUWip/WzuLTQOdYficN1dtqRvy02d23VE1wlfY4q6DWl9wr26dd7ku/JbX
        cMCBjZ8tec+cAl0goSi1vvIXTHnkRymPt88vlSJcEWAz6VaySK/0xsvp+cONHsmRu9RrQujqszc4g
        sJ6OgjuQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gt5AT-0004CC-Lj; Mon, 11 Feb 2019 06:34:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix vm/slub.rst warning
Message-ID: <1e992162-c4ac-fe4e-f1b0-d8a16a51d5e7@infradead.org>
Date:   Sun, 10 Feb 2019 22:34:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix markup warning by quoting the '*' character with a backslash.

Documentation/vm/slub.rst:71: WARNING: Inline emphasis start-string without end-string.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 Documentation/vm/slub.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-50-rc6.orig/Documentation/vm/slub.rst
+++ lnx-50-rc6/Documentation/vm/slub.rst
@@ -68,7 +68,7 @@ end of the slab name, in order to cover
 example, here's how you can poison the dentry cache as well as all kmalloc
 slabs:
 
-	slub_debug=P,kmalloc-*,dentry
+	slub_debug=P,kmalloc-\*,dentry
 
 Red zoning and tracking may realign the slab.  We can just apply sanity checks
 to the dentry cache with::


