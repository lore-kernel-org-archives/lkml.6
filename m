Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A72E6C43A1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE6B20C10
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 23:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFNVx705"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE6B20C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbeGKXuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 19:50:39 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43033 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388049AbeGKXuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 19:50:39 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so9830491plj.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 16:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=wf0GSaau/FonDnaRqSCZ0F/n9UQ08k45HSngN1T6fDE=;
        b=AFNVx705ar4ZPUBR7/kxgAhOTwEbCKEPfebc64zq7bx5iOotJODfGbvr2OfZUwbBnG
         G08VHcxcCQc6ZvRkHCXpwbyYe3+LL8RYTTEz/dyWZ7atBguuxSRrZxGxyCn6Hp9DwLr6
         7acxL78w22F1mTLg49qbomNWaNVrH2cLdjMn/xbzpEDrfW0cxiAqIIq27F2clBprDu5r
         aGcAeOMfRJGazN2iTdTObc1RJUACnkMcaz7EvR38GK7lVcvyvuUN4iLI2FBXNAZTs7Vl
         HDYbC+yHu+pxPBfcMxRkxQqMWuDAQj207zbvONvIGMiP1skDyWcFb2MY6ExvH0XcbACP
         +FHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=wf0GSaau/FonDnaRqSCZ0F/n9UQ08k45HSngN1T6fDE=;
        b=flR41P3zgRp4CITqwODtg6/VBTFr0M5D6ZfnZq+6LnFjqvmMwCaUMeicrE+99aBCci
         7xt3fOTfKCqRakMDGoQl6/TFn/jS3/XGKBIPkDInY9u3NLRDNuD+LASRehcudyJGR33D
         52qwjLsPYrksyR0HV1lYGvzbGVe8njXQY/79Ft6E/H4u7XZFmwthkAG13v/bK9SOGvWk
         tgZAYqmK/Ivvmmmgh5CPvqTXL1MCXX/kc8pSXJWKbew4vOlOqlCdvJuXrjhasvs2G9/Z
         q2WwAvLgclYC30/fTEp860beSNGTkIZyiUjUhCmT1zUy8nud1qUd6buhA1DtxXDSAsL5
         HUwQ==
X-Gm-Message-State: AOUpUlEOVf1WDDk9qAWac/EeUX+0+9If1CdXubtmkYVdSuOJwZN5AnyQ
        gdQqTgrdQKiuqPCrHTpD9cwTBg==
X-Google-Smtp-Source: AAOMgpcqqbR4WZxxvg0GKTsUe+L5dMN5IpoAiYOtYR01N/NwnOyMALFgBNkkv05VzGJ19itttGS/sQ==
X-Received: by 2002:a17:902:981:: with SMTP id 1-v6mr595007pln.11.1531352635852;
        Wed, 11 Jul 2018 16:43:55 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id y69-v6sm45684669pfd.36.2018.07.11.16.43.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 16:43:55 -0700 (PDT)
Date:   Wed, 11 Jul 2018 16:43:54 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch] mm, vmacache: hash addresses based on pmd
In-Reply-To: <20180711161030.b5ae2f5b1210150c13b1a832@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1807111637050.254865@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1807091749150.114630@chino.kir.corp.google.com> <20180709180841.ebfb6cf70bd8dc08b269c0d9@linux-foundation.org> <alpine.DEB.2.21.1807091822460.130281@chino.kir.corp.google.com>
 <20180711161030.b5ae2f5b1210150c13b1a832@linux-foundation.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018, Andrew Morton wrote:

> > > Did you consider LRU-sorting the array instead?
> > > 
> > 
> > It adds 40 bytes to struct task_struct,
> 
> What does?  LRU sort?  It's a 4-entry array, just do it in place, like
> bh_lru_install(). Confused.
> 

I was imagining an optimized sort rather than adding an iteration to 
vmacache_update() of the same form that causes vmacache_find() to show up 
on my perf reports in the first place.

> > but I'm not sure the least 
> > recently used is the first preferred check.  If I do 
> > madvise(MADV_DONTNEED) from a malloc implementation where I don't control 
> > what is free()'d and I'm constantly freeing back to the same hugepages, 
> > for example, I may always get first slot cache hits with this patch as 
> > opposed to the 25% chance that the current implementation has (and perhaps 
> > an lru would as well).
> > 
> > I'm sure that I could construct a workload where LRU would be better and 
> > could show that the added footprint were worthwhile, but I could also 
> > construct a workload where the current implementation based on pfn would 
> > outperform all of these.  It simply turns out that on the user-controlled 
> > workloads that I was profiling that hashing based on pmd was the win.
> 
> That leaves us nowhere to go.  Zapping the WARN_ON seems a no-brainer
> though?
> 

I would suggest it goes under CONFIG_DEBUG_VM_VMACACHE.

My implementation for the optimized vmacache_find() is based on the 
premise that spatial locality matters, and in practice on random 
user-controlled workloads this yields a faster lookup than the current 
implementation.  Of course, any caching technique can be defeated by 
workloads, artifical or otherwise, but I suggest that as a general 
principle caching based on PMD_SHIFT rather than pfn has a greater 
likelihood of avoiding the iteration in vmacache_find() because of spatial 
locality for anything that iterates over a range of memory.
