Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F9C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90042083D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E90042083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeKFJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:23:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41128 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:23:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so5202345pfn.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:01:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RN2Z+ghOIUZjz/WUJfzQ1MAYhSjp9FI+qB9529Z/Rxs=;
        b=PnjBr9mr3AVEjcp/8/Cv9Me2hraw+6dUOpQ6t3IQe8efclrOZolr7wEV3/F5xf3SYU
         Ny3q6pW8+Et/vH2pJ1Pp6qarQB4UxumCJrPvau++lnotdsZyex8U8uRPfBCc+grtmFhe
         GPTM68fP/Toi3Lc2V8NU2LGhxK/aTYuenHYvAsizNENvyWAdoF/bjySrPp7fXi59kcRE
         X+7mcAGaeUNnFlzR7+8D8F16HTgFJzNQ2/pgVM+51owlMTLkpDHBsh14rLBwdV6Jzx0I
         7XpmHZHSL/EMBLmv5Ox92+CkU0n6FgadvZNXkiU1qzqsi4XBvngBOoMH0rs8BgMCG58a
         n/ww==
X-Gm-Message-State: AGRZ1gJ7RkLkzsqKYLq0PBSDdOIv4SpR9JiYY7aU8jNA2EDAPN1wujTJ
        4/UC+JzZncDI77desyZhHSc=
X-Google-Smtp-Source: AJdET5fglG4KiUDrMFRvm0UxXy540+hzW6J+tVVnfPxHfTngZAO0/2raaXY1ilLxgw3JRVhBdycGHA==
X-Received: by 2002:a63:ce56:: with SMTP id r22-v6mr21634584pgi.217.1541462469022;
        Mon, 05 Nov 2018 16:01:09 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id f18-v6sm82813247pfh.0.2018.11.05.16.01.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 16:01:07 -0800 (PST)
Message-ID: <1541462466.196084.163.camel@acm.org>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, guro@fb.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>
Date:   Mon, 05 Nov 2018 16:01:06 -0800
In-Reply-To: <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
         <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
         <1541454489.196084.157.camel@acm.org>
         <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
         <1541457654.196084.159.camel@acm.org>
         <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 14:48 -0800, Alexander Duyck wrote:
+AD4 On Mon, Nov 5, 2018 at 2:41 PM Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4 wrote:
+AD4 +AD4 How about this version, still untested? My compiler is able to evaluate
+AD4 +AD4 the switch expression if the argument is constant.
+AD4 +AD4 
+AD4 +AD4  static +AF8AXw-always+AF8-inline enum kmalloc+AF8-cache+AF8-type kmalloc+AF8-type(gfp+AF8-t flags)
+AD4 +AD4  +AHs
+AD4 +AD4 -       int is+AF8-dma +AD0 0+ADs
+AD4 +AD4 -       int type+AF8-dma +AD0 0+ADs
+AD4 +AD4 -       int is+AF8-reclaimable+ADs
+AD4 +AD4 +-       unsigned int dr +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
+AD4 +AD4 
+AD4 +AD4  +ACM-ifdef CONFIG+AF8-ZONE+AF8-DMA
+AD4 +AD4 -       is+AF8-dma +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA)+ADs
+AD4 +AD4 -       type+AF8-dma +AD0 is+AF8-dma +ACo KMALLOC+AF8-DMA+ADs
+AD4 +AD4 +-       dr +AHwAPQ +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-DMA) +ADwAPA 1+ADs
+AD4 +AD4  +ACM-endif
+AD4 +AD4 
+AD4 +AD4 -       is+AF8-reclaimable +AD0 +ACEAIQ(flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE)+ADs
+AD4 +AD4 -
+AD4 +AD4         /+ACo
+AD4 +AD4          +ACo If an allocation is both +AF8AXw-GFP+AF8-DMA and +AF8AXw-GFP+AF8-RECLAIMABLE, return
+AD4 +AD4          +ACo KMALLOC+AF8-DMA and effectively ignore +AF8AXw-GFP+AF8-RECLAIMABLE
+AD4 +AD4          +ACo-/
+AD4 +AD4 -       return type+AF8-dma +- (is+AF8-reclaimable +ACY +ACE-is+AF8-dma) +ACo KMALLOC+AF8-RECLAIM+ADs
+AD4 +AD4 +-       switch (dr) +AHs
+AD4 +AD4 +-       default:
+AD4 +AD4 +-       case 0:
+AD4 +AD4 +-               return 0+ADs
+AD4 +AD4 +-       case 1:
+AD4 +AD4 +-               return KMALLOC+AF8-RECLAIM+ADs
+AD4 +AD4 +-       case 2:
+AD4 +AD4 +-       case 3:
+AD4 +AD4 +-               return KMALLOC+AF8-DMA+ADs
+AD4 +AD4 +-       +AH0
+AD4 +AD4  +AH0
+AD4
+AD4 Doesn't this defeat the whole point of the code which I thought was to
+AD4 avoid conditional jumps and branches? Also why would you bother with
+AD4 the +ACI-dr+ACI value when you could just mask the flags value and switch on
+AD4 that directly?

Storing the relevant bits of 'flags' in the 'dr' variable avoids that the
bit selection expressions have to be repeated and allows to use a switch
statement instead of multiple if / else statements.

Most kmalloc() calls pass a constant to the gfp argument. That allows the
compiler to evaluate kmalloc+AF8-type() at compile time. So the conditional jumps
and branches only appear when the gfp argument is not a constant. What makes
you think it is important to optimize for that case?

Bart.
