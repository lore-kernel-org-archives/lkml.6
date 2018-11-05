Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF1CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B5D20700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B5D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388211AbeKFIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:09:15 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42039 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbeKFIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:09:14 -0500
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so5118348pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:47:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiqoocSfYqtwTjMheZJvjB4bRjcTx6Up2mHhgWKrdjE=;
        b=Bu37F46tFQQhtyTe9w9/aPF05RmLVg7jFLYMNWKVWrd0a7zvrP30bpFT9QYR+fY7mk
         DqNw5FUiejvLbm2MrrkGTvmGbjARRnUuwy47fZgPuIvru+EgGvNc1CuKoAK9yf5V0MX0
         CU6Osny2WCECYb+xmxsSrM/25GwBttuusJqRhrSx4JKqlPTbFYqdKn3RLEQPQ6cuRM3J
         lqwfJHt6zWQ32uFbLZ2Wyq5s7y8aO0EHKdhQtDcvuOMnKcabVr7e2bt6Q3PsQTCgLrye
         WtKJUPjeP3g5MPw/IvWmjYL5BvscmspTzIaK22bGxTlYyrsnT5cLtblKBZ2Kpj2pb3p9
         3wuQ==
X-Gm-Message-State: AGRZ1gIzXdTg4ZniOr77EXRzQYIEsn0gvtDpU6NQ2kEYNB6BLD9mS+Rn
        4xijE8G1gkHT7TTQJz34C3k=
X-Google-Smtp-Source: AJdET5diG2uOmflekKPDDpICBGXuJ3m1AIt1pTS/n6IyNZHQTT3TxbvsazQhC9UPgMG6aT8A/n4Xmg==
X-Received: by 2002:a62:704a:: with SMTP id l71-v6mr9133647pfc.68.1541457657531;
        Mon, 05 Nov 2018 14:40:57 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p14-v6sm51529998pgn.45.2018.11.05.14.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 14:40:56 -0800 (PST)
Message-ID: <1541457654.196084.159.camel@acm.org>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   Bart Van Assche <bvanassche@acm.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org
Date:   Mon, 05 Nov 2018 14:40:54 -0800
In-Reply-To: <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
References: <20181105204000.129023-1-bvanassche@acm.org>
         <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
         <1541454489.196084.157.camel@acm.org>
         <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 23:14 +-0100, Rasmus Villemoes wrote:
+AD4 Won't that pessimize the cases where gfp is a constant to actually do
+AD4 the table lookup, and add 16 bytes to every translation unit?
+AD4 
+AD4 Another option is to add a fake KMALLOC+AF8-DMA+AF8-RECLAIM so the
+AD4 kmalloc+AF8-caches+AFsAXQ array has size 4, then assign the same dma
+AD4 kmalloc+AF8-cache pointer to +AFs-2+AF0AWw-i+AF0 and +AFs-3+AF0AWw-i+AF0 (so that costs perhaps a
+AD4 dozen pointers in .data), and then just compute kmalloc+AF8-type() as
+AD4 
+AD4 ((flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE) +AD4APg someshift) +AHw ((flags +ACY +AF8AXw-GFP+AF8-DMA) +AD4APg
+AD4 someothershift).
+AD4 
+AD4 Perhaps one could even shuffle the GFP flags so the two shifts are the same.

How about this version, still untested? My compiler is able to evaluate
the switch expression if the argument is constant.

 static +AF8AXw-always+AF8-inline enum kmalloc+AF8-cache+AF8-type kmalloc+AF8-type(gfp+AF8-t flags)
 +AHs
-	int is+AF8-dma +AD0 0+ADs
-	int type+AF8-dma +AD0 0+ADs
-	int is+AF8-reclaimable+ADs
+-	unsigned int dr +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
 
 +ACM-ifdef CONFIG+AF8-ZONE+AF8-DMA
-	is+AF8-dma +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA)+ADs
-	type+AF8-dma +AD0 is+AF8-dma +ACo KMALLOC+AF8-DMA+ADs
+-	dr +AHwAPQ +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA) +ADwAPA 1+ADs
 +ACM-endif
 
-	is+AF8-reclaimable +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
-
 	/+ACo
 	 +ACo If an allocation is both +AF8AXw-GFP+AF8-DMA and +AF8AXw-GFP+AF8-RECLAIMABLE, return
 	 +ACo KMALLOC+AF8-DMA and effectively ignore +AF8AXw-GFP+AF8-RECLAIMABLE
 	 +ACo-/
-	return type+AF8-dma +- (is+AF8-reclaimable +ACY +ACE-is+AF8-dma) +ACo KMALLOC+AF8-RECLAIM+ADs
+-	switch (dr) +AHs
+-	default:
+-	case 0:
+-		return 0+ADs
+-	case 1:
+-		return KMALLOC+AF8-RECLAIM+ADs
+-	case 2:
+-	case 3:
+-		return KMALLOC+AF8-DMA+ADs
+-	+AH0
 +AH0
 
Bart.
