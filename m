Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C9DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1579120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:48:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1579120825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbeKFHJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:09:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40325 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbeKFHJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:09:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id z10so2947204pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 13:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o3CM4YZGbeVa4lJAvweUDWyFM3R2sBCQInSXdiEIHUw=;
        b=PwnPErviw4Nxyr9EnoGwP8d5IxPG1zba+ZJX0oUrBuTY1Q0PVy29ZYQqtNwqYj2/3C
         KDqg+mSzkywx/wBgbBQ3wtmLIjafW7/VCJk4zREK3sjcrqqefDakUhdGZYYciSCi4+qH
         GC6pr3DjL2JuinjfMl9c2cPPTsJ90uzwPo5Dq0sMk9SFUwnYQsyd8NWAWhmeTi41J32y
         3t4G0HY9M3mhuE1e1Eg5ScwRhjOJYnm5Nmo9mif1hVQKDLLHDoMJ8+ty88Wfjg+cUwuW
         /OpAQfnxJ3zHPfSYHbkCbl0/IuGV4DFb8EiPfXIMrZID2PA2TBhrBuJjYnC5MaSRIrzf
         /PYQ==
X-Gm-Message-State: AGRZ1gJqZQkyOrEScEiJsR2XBKVMV1FwM58E+ODZKGGi0IBsVfz3VWee
        WmjspSy/BzTrQl48T/NNYXo=
X-Google-Smtp-Source: AJdET5dl/G4ri+3VU40GDj9sOuSfq5+kuM7NoOuS2EvAvkRVDHF/NU8p4kY0wgf4B7Z8UX7OJy82pA==
X-Received: by 2002:a63:fd53:: with SMTP id m19mr2634821pgj.340.1541454491911;
        Mon, 05 Nov 2018 13:48:11 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id 7-v6sm45634768pgk.31.2018.11.05.13.48.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 13:48:11 -0800 (PST)
Message-ID: <1541454489.196084.157.camel@acm.org>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   Bart Van Assche <bvanassche@acm.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Date:   Mon, 05 Nov 2018 13:48:09 -0800
In-Reply-To: <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
References: <20181105204000.129023-1-bvanassche@acm.org>
         <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 13:13 -0800, Andrew Morton wrote:
+AD4 On Mon,  5 Nov 2018 12:40:00 -0800 Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 
+AD4 +AD4 This patch suppresses the following sparse warning:
+AD4 +AD4 
+AD4 +AD4 ./include/linux/slab.h:332:43: warning: dubious: x +ACY +ACE-y
+AD4 +AD4 
+AD4 +AD4 ...
+AD4 +AD4 
+AD4 +AD4 --- a/include/linux/slab.h
+AD4 +AD4 +-+-+- b/include/linux/slab.h
+AD4 +AD4 +AEAAQA -329,7 +-329,7 +AEAAQA static +AF8AXw-always+AF8-inline enum kmalloc+AF8-cache+AF8-type kmalloc+AF8-type(gfp+AF8-t flags)
+AD4 +AD4  	 +ACo If an allocation is both +AF8AXw-GFP+AF8-DMA and +AF8AXw-GFP+AF8-RECLAIMABLE, return
+AD4 +AD4  	 +ACo KMALLOC+AF8-DMA and effectively ignore +AF8AXw-GFP+AF8-RECLAIMABLE
+AD4 +AD4  	 +ACo-/
+AD4 +AD4 -	return type+AF8-dma +- (is+AF8-reclaimable +ACY +ACE-is+AF8-dma) +ACo KMALLOC+AF8-RECLAIM+ADs
+AD4 +AD4 +-	return type+AF8-dma +- is+AF8-reclaimable +ACo +ACE-is+AF8-dma +ACo KMALLOC+AF8-RECLAIM+ADs
+AD4 +AD4  +AH0
+AD4 +AD4  
+AD4 +AD4  /+ACo
+AD4 
+AD4 I suppose so.
+AD4 
+AD4 That function seems too clever for its own good :(.  I wonder if these
+AD4 branch-avoiding tricks are really worthwhile.

From what I have seen in gcc disassembly it seems to me like gcc uses the
cmov instruction to implement e.g. the ternary operator (?:). So I think none
of the cleverness in kmalloc+AF8-type() is really necessary to avoid conditional
branches. I think this function would become much more readable when using a
switch statement or when rewriting it as follows (untested):

 static +AF8AXw-always+AF8-inline enum kmalloc+AF8-cache+AF8-type kmalloc+AF8-type(gfp+AF8-t flags)
 +AHs
-	int is+AF8-dma +AD0 0+ADs
-	int type+AF8-dma +AD0 0+ADs
-	int is+AF8-reclaimable+ADs
-
-+ACM-ifdef CONFIG+AF8-ZONE+AF8-DMA
-	is+AF8-dma +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA)+ADs
-	type+AF8-dma +AD0 is+AF8-dma +ACo KMALLOC+AF8-DMA+ADs
-+ACM-endif
-
-	is+AF8-reclaimable +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
-
 	/+ACo
 	 +ACo If an allocation is both +AF8AXw-GFP+AF8-DMA and +AF8AXw-GFP+AF8-RECLAIMABLE, return
 	 +ACo KMALLOC+AF8-DMA and effectively ignore +AF8AXw-GFP+AF8-RECLAIMABLE
 	 +ACo-/
-	return type+AF8-dma +- (is+AF8-reclaimable +ACY +ACE-is+AF8-dma) +ACo KMALLOC+AF8-RECLAIM+ADs
+-	static const enum kmalloc+AF8-cache+AF8-type flags+AF8-to+AF8-type+AFs-2+AF0AWw-2+AF0 +AD0 +AHs
+-		+AHs 0,		KMALLOC+AF8-RECLAIM +AH0,
+-		+AHs KMALLOC+AF8-DMA,	KMALLOC+AF8-DMA +AH0,
+-	+AH0AOw
+-+ACM-ifdef CONFIG+AF8-ZONE+AF8-DMA
+-	bool is+AF8-dma +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA)+ADs
+-+ACM-endif
+-	bool is+AF8-reclaimable +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
+-
+-	return flags+AF8-to+AF8-type+AFs-is+AF8-dma+AF0AWw-is+AF8-reclaimable+AF0AOw
 +AH0

