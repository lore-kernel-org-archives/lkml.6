Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FB0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90CA820869
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 09:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CA820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbeKESwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:52:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:56412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728971AbeKESwG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:52:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9B906AE28;
        Mon,  5 Nov 2018 09:33:14 +0000 (UTC)
Date:   Mon, 5 Nov 2018 10:33:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     rdunlap@infradead.org
Cc:     linux-tip-commits@vger.kernel.org, akpm@linux-foundation.org,
        peterz@infradead.org, rdunlap@infradead.org,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [tip:core/urgent] resource/docs: Fix new kernel-doc warnings
Message-ID: <20181105093307.GA12445@zn.tnic>
References: <dda2e4d8-bedd-3167-20fe-8c7d2d35b354@infradead.org>
 <tip-f75d651587f719a813ebbbfeee570e6570731d55@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tip-f75d651587f719a813ebbbfeee570e6570731d55@git.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 04, 2018 at 10:09:50PM -0800, tip-bot for Randy Dunlap wrote:
> Commit-ID:  f75d651587f719a813ebbbfeee570e6570731d55
> Gitweb:     https://git.kernel.org/tip/f75d651587f719a813ebbbfeee570e6570731d55
> Author:     Randy Dunlap <rdunlap@infradead.org>
> AuthorDate: Sun, 4 Nov 2018 18:40:14 -0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Mon, 5 Nov 2018 07:05:04 +0100
> 
> resource/docs: Fix new kernel-doc warnings
> 
> The first group of warnings is caused by a "/**" kernel-doc notation
> marker but the function comments are not in kernel-doc format.

Well, I'd prefer if we added those required parameters rather than not and
"degrading" that function documentation back.

---
From: Borislav Petkov <bp@suse.de>
Date: Mon, 5 Nov 2018 10:26:02 +0100
Subject: [PATCH] resource: Complete kernel-doc style function documentation

Add the missing kernel-doc style function parameters documentation.

Based on a patch by Randy Dunlap <rdunlap@infradead.org>.

Fixes: b69c2e20f6e4 ("resource: Clean it up a bit")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 kernel/resource.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index b3a3a1fc499e..b0fbf685c77a 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -319,16 +319,23 @@ int release_resource(struct resource *old)
 EXPORT_SYMBOL(release_resource);
 
 /**
- * Finds the lowest iomem resource that covers part of [start..end].  The
- * caller must specify start, end, flags, and desc (which may be
+ * Finds the lowest iomem resource that covers part of [@start..@end].  The
+ * caller must specify @start, @end, @flags, and @desc (which may be
  * IORES_DESC_NONE).
  *
- * If a resource is found, returns 0 and *res is overwritten with the part
- * of the resource that's within [start..end]; if none is found, returns
- * -1.
+ * If a resource is found, returns 0 and @*res is overwritten with the part
+ * of the resource that's within [@start..@end]; if none is found, returns
+ * -1 or -EINVAL for other invalid parameters.
  *
  * This function walks the whole tree and not just first level children
  * unless @first_lvl is true.
+ *
+ * @start:	start address of the resource searched for
+ * @end:	end address of same resource
+ * @flags:	flags which the resource must have
+ * @desc:	descriptor the resource must have
+ * @first_lvl:	walk only the first level children, if set
+ * @res:	return ptr, if resource found
  */
 static int find_next_iomem_res(resource_size_t start, resource_size_t end,
 			       unsigned long flags, unsigned long desc,
@@ -399,6 +406,8 @@ static int __walk_iomem_res_desc(resource_size_t start, resource_size_t end,
  * @flags: I/O resource flags
  * @start: start addr
  * @end: end addr
+ * @arg: function argument for the callback @func
+ * @func: callback function that is called for each qualifying resource area
  *
  * NOTE: For a new descriptor search, define a new IORES_DESC in
  * <linux/ioport.h> and set it in 'desc' of a target resource entry.
-- 
2.19.1

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
