Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63D8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8182081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ecMs/vgd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA8182081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbeKIVxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:53:45 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36073 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:53:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id h192so1174181lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kUsYFeo1kLBI3BPnBoUz9u43BAsr3XJ229Wlh0/P+5g=;
        b=ecMs/vgdR13EYHuZiFRbTrcMtf0k4CLpYY5+RpjavdlmDQe3rGtZKvs/ngWvPEfX8f
         ghfM3XTtjDK3a+bC2RgBT6BjLT7RMeGpCjXokcw+IEOW5oYKEVlREf+l2TairfnZ6JRh
         mlrI3H5Fk0UvYixfIiW0KlcqgiBV8Rg/nWfGZUUca30gWVdu8jApyOnJoEjQa1cK0uCK
         Nr04/EQSLSMkLtOvfcyvJEIKqhP2117EdM5U0/Lr76UA0ru/sWtLb0PUaDDKDCzNcQqO
         vK1ZeshFLtG6rnwTlHWQg0iXT5iG5CjJYbrL7MHDfxF1pDDpLOhgPzPihF7gDykM+5sv
         dXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kUsYFeo1kLBI3BPnBoUz9u43BAsr3XJ229Wlh0/P+5g=;
        b=pv4V9HjXWIv0tyi6IkR/txfu3y1gwpw8/EXAsOlKKRGnC2+82jRth1lHOJqDL4aMDP
         QJw+p2z2Vzo7UXf6dRKoRxgzE7eWzeBXdafeWk+EkjB58kd+ORlrYSKRcMnzIed59A+T
         pnvjdZXraoeLlIhUVDZGAMk6ZFgF7I3ubkfCToTEDYhW40VMdLfxt5C6dD/eFYwWj3wW
         9VAjXgWxJYNy6mt0+e/lAak4+e1WIaD6HCDOVabdPJnX/9ghaWyiT6jC2sv05AAtkTlx
         tWuqj0OWBt0HftZh6ReU1SbYEp2D0shUGhqXRBdm0HSyRiXqklmBYf4/NA9t9q5eIrLx
         8pGg==
X-Gm-Message-State: AGRZ1gLJvAtVXgGcybjyf4QW553Nc4/QTflLBOJNZ6uNU+k9uUatRYXS
        kl21KxujdbcFtmBdzwrwx5Qm3g==
X-Google-Smtp-Source: AJdET5fpZbsdNoGkEVALLJJlwMwnHqOadDRPC4iT+QOETylDfK2JUZugYztT//enk3STenF+1UGy8g==
X-Received: by 2002:a19:4345:: with SMTP id m5mr5193889lfj.142.1541765602016;
        Fri, 09 Nov 2018 04:13:22 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (mm-34-243-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.243.34])
        by smtp.gmail.com with ESMTPSA id 10sm1251097lff.62.2018.11.09.04.13.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 04:13:21 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E24653002A1; Fri,  9 Nov 2018 15:13:18 +0300 (+03)
Date:   Fri, 9 Nov 2018 15:13:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        aarcange@redhat.com, aneesh.kumar@linux.ibm.com,
        akpm@linux-foundation.org, jglisse@redhat.com,
        khandual@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com,
        mgorman@techsingularity.net, mhocko@kernel.org, minchan@kernel.org,
        peterz@infradead.org, rientjes@google.com, vbabka@suse.cz,
        willy@infradead.org, ying.huang@intel.com, nitingupta910@gmail.com
Subject: Re: [RFC PATCH] mm: thp: implement THP reservations for anonymous
 memory
Message-ID: <20181109121318.3f3ou56ceegrqhcp@kshutemo-mobl1>
References: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1541746138-6706-1-git-send-email-anthony.yznaga@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 10:48:58PM -0800, Anthony Yznaga wrote:
> The basic idea as outlined by Mel Gorman in [2] is:
> 
> 1) On first fault in a sufficiently sized range, allocate a huge page
>    sized and aligned block of base pages.  Map the base page
>    corresponding to the fault address and hold the rest of the pages in
>    reserve.
> 2) On subsequent faults in the range, map the pages from the reservation.
> 3) When enough pages have been mapped, promote the mapped pages and
>    remaining pages in the reservation to a huge page.
> 4) When there is memory pressure, release the unused pages from their
>    reservations.

I haven't yet read the patch in details, but I'm skeptical about the
approach in general for few reasons:

- PTE page table retracting to replace it with huge PMD entry requires
  down_write(mmap_sem). It makes the approach not practical for many
  multi-threaded workloads.

  I don't see a way to avoid exclusive lock here. I will be glad to
  be proved otherwise.

- The promotion will also require TLB flush which might be prohibitively
  slow on big machines.

- Short living processes will fail to benefit from THP with the policy,
  even with plenty of free memory in the system: no time to promote to THP
  or, with synchronous promotion, cost will overweight the benefit.

The goal to reduce memory overhead of THP is admirable, but we need to be
careful not to kill THP benefit itself. The approach will reduce number of
THP mapped in the system and/or shift their allocation to later stage of
process lifetime.

The only way I see it can be useful is if it will be possible to apply the
policy on per-VMA basis. It will be very useful for malloc()
implementations, for instance. But as a global policy it's no-go to me.

Prove me wrong with performance data. :)

-- 
 Kirill A. Shutemov
