Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E72C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28CD20843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dNw1lwGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28CD20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbeGYXwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:52:23 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45310 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731325AbeGYXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:52:23 -0400
Received: by mail-pg1-f196.google.com with SMTP id f1-v6so6200774pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=oxY++LSQOfleh6kuZ6Nnmu39HCHVekdNBgalBw0zoSQ=;
        b=dNw1lwGRgCROauGjwQ4GoQAxHZzBADqcxn2rXvCFmB0EStqG1axxxJ402+bbVMHvlM
         uU2rrDj+5wqSAPa3FOCCAyc+wz4CdCa8rLyTGrJWfDevP34w6rbhJnVku+ub9ftF1E3J
         +XlHPoRn9gxLtUmiEmjSfKndNLpVwNIfzYJ3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=oxY++LSQOfleh6kuZ6Nnmu39HCHVekdNBgalBw0zoSQ=;
        b=jD2LgcOsowESVXx7SktULeKkcyt71Qzje76bVLDNfzoUET04IPNnVhTI6eebsMWKdb
         3wSBah5sZCAi51r7JpjOQRcvBqqBVrRAfbwkHeONrnP47AfKqrzGZVYuPiplEPqE85ma
         MJL8+AtP0jHzqNwhnyY6viN9OVUpfrmrUVDwle4tD+NfeHJO8wqLe8lhABVHJtL0PfZL
         2LnaaMK6IO+EsCYO3b0lCyjItNBEVLVaGitVogfe1cjmSL10LBZrY+mnnBHSYcsRS5v+
         32ElhoHTdFNezLZozHcbG3jSbLZMeL5e3GASMwdWKzRPg2mXeb2cdb/+H1yR/oT11PDJ
         yzWg==
X-Gm-Message-State: AOUpUlHZp9Ie8QOJ9p3FDaEJLGOb357YCGFOXOq7oIfIvOPgvP+KduPb
        Yasw1vZl5U+prHTnJ29Vg3U1Aw==
X-Google-Smtp-Source: AAOMgpc44xQ1r3QIZ4JTE3F4cmZcxLppeXn7MLZLY4/bVR9cxKfCFWH3+QfUHLuhKFk8EL2KY0oMPg==
X-Received: by 2002:a62:57dc:: with SMTP id i89-v6mr23972397pfj.65.1532558315208;
        Wed, 25 Jul 2018 15:38:35 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r83-v6sm18241486pgr.8.2018.07.25.15.38.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 15:38:33 -0700 (PDT)
Date:   Wed, 25 Jul 2018 15:38:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Clarify CONFIG_PAGE_POISONING and usage
Message-ID: <20180725223832.GA43733@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Kconfig text for CONFIG_PAGE_POISONING doesn't mention that it has to
be enabled explicitly. This updates the documentation for that and adds
a note about CONFIG_PAGE_POISONING to the "page_poison" command line docs.
While here, change description of CONFIG_PAGE_POISONING_ZERO too, as it's
not "random" data, but rather the fixed debugging value that would be used
when not zeroing. Additionally removes a stray "bool" in the Kconfig.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++--
 mm/Kconfig.debug                                | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c68970..f8a81b929089 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2933,8 +2933,9 @@
 			on: enable the feature
 
 	page_poison=	[KNL] Boot-time parameter changing the state of
-			poisoning on the buddy allocator.
-			off: turn off poisoning
+			poisoning on the buddy allocator, available with
+			CONFIG_PAGE_POISONING=y.
+			off: turn off poisoning (default)
 			on: turn on poisoning
 
 	panic=		[KNL] Kernel behaviour on panic: delay <timeout>
diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index e5e606ee5f71..9a7b8b049d04 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -46,7 +46,8 @@ config PAGE_POISONING
 	  Fill the pages with poison patterns after free_pages() and verify
 	  the patterns before alloc_pages. The filling of the memory helps
 	  reduce the risk of information leaks from freed data. This does
-	  have a potential performance impact.
+	  have a potential performance impact if enabled with the
+	  "page_poison=1" kernel boot option.
 
 	  Note that "poison" here is not the same thing as the "HWPoison"
 	  for CONFIG_MEMORY_FAILURE. This is software poisoning only.
@@ -65,7 +66,7 @@ config PAGE_POISONING_NO_SANITY
 	   say N.
 
 config PAGE_POISONING_ZERO
-	bool "Use zero for poisoning instead of random data"
+	bool "Use zero for poisoning instead of debugging value"
 	depends on PAGE_POISONING
 	---help---
 	   Instead of using the existing poison value, fill the pages with
@@ -75,7 +76,6 @@ config PAGE_POISONING_ZERO
 	   allocation.
 
 	   If unsure, say N
-	bool
 
 config DEBUG_PAGE_REF
 	bool "Enable tracepoint to track down page reference manipulation"
-- 
2.17.1


-- 
Kees Cook
Pixel Security
