Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E787FC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD062084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngT1s3rj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD062084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeJ2Sax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:30:53 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ2Sax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:30:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id z17-v6so3616737pgv.3;
        Mon, 29 Oct 2018 02:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dBQvLdnsYnmXkuzMfk7uNHHPlRKih1qzk67c6Ebokbg=;
        b=ngT1s3rjCJO5j/bPY47inxehLkWgdp1PmF3WJmKgaulBrMcr1+dHZ2jkpLG8r9bfqV
         qgUQ0xbmuxSJlnmqek7svKJPO7vOhLEnLGMzU7dc+5KsGWRdaGWLiT55HX3jXCKEV+bg
         rQNpojd9G6/9CozRJKCsXDYROL0zws9XIcWg6+zr3JBOnrL5cWQApYHvPN9XRIpMRGGo
         P5nmOT7zVLH+5sJsLguqk7H2qbpZx5ZFokzw3tdvqmd5wlmp8i7rUndfyRGgvhRiGXWZ
         ZqeuUAyh1LsI41E7bye7JHUktDl358teQoSLuQfLUdnfCuDSWkWRGaGj2d1Rx01z4Q1c
         3/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dBQvLdnsYnmXkuzMfk7uNHHPlRKih1qzk67c6Ebokbg=;
        b=iE5wRluba1qihzA4wDHID49mc196AO5MtyHKQUYXOqR7yjdJa8rqibi6euAfeZXa0p
         ZlqXoHiXXvgc5TeM0fcd+8iJOD3fmaxM+t15bcH0yQARgfiQvYmUaj7XGi5eF2tuIpkc
         PQngBfEcaetsXjKAuWXTakwV4Hs2+5hrQw/KXz36O1G6vg0ymjFUOdEZ0B40XsKbohLA
         QkUH2HBdPvxYrEbqKnMkL4Xh00TFeWU1XM1ZmScUHfvEVkzPhZEgwgc2hhr/MeDyY9vp
         RrBs5g68dq1yqvfxl5L+ntSu9jfJTWBZIAnbJwmrszGdLArXi3QhFk5KSDSg3A2YadZ2
         tzlw==
X-Gm-Message-State: AGRZ1gKKhS2TFN4UHn5O6SVj3w2MplCdgPhQdMoeZ3Q4eMzj156K/+EK
        uzCvP6irImM+LqZrYZ4Ro7g=
X-Google-Smtp-Source: AJdET5dXnJqLI4vivz8DNgHAiDkHfmCBj8BcyYdCgn35qxtRLmWLvCFaHK4HNEtm2LbE7qdtn5FaKQ==
X-Received: by 2002:a65:65c9:: with SMTP id y9mr13439661pgv.438.1540806179661;
        Mon, 29 Oct 2018 02:42:59 -0700 (PDT)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id p62-v6sm31727231pfp.111.2018.10.29.02.42.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 02:42:58 -0700 (PDT)
Date:   Mon, 29 Oct 2018 20:42:53 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrea Argangeli <andrea@kernel.org>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        Stefan Priebe - Profihost AG <s.priebe@profihost.ag>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: thp:  relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
Message-ID: <20181029094253.GC16399@350D>
References: <20180925120326.24392-1-mhocko@kernel.org>
 <20180925120326.24392-2-mhocko@kernel.org>
 <20181029051752.GB16399@350D>
 <20181029090035.GE32673@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029090035.GE32673@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 10:00:35AM +0100, Michal Hocko wrote:
> On Mon 29-10-18 16:17:52, Balbir Singh wrote:
> [...]
> > I wonder if alloc_pool_huge_page() should also trim out it's logic
> > of __GFP_THISNODE for the same reasons as mentioned here. I like
> > that we round robin to alloc the pool pages, but __GFP_THISNODE
> > might be an overkill for that case as well.
> 
> alloc_pool_huge_page uses __GFP_THISNODE for a different reason than
> THP. We really do want to allocated for a per-node pool. THP can
> fallback or use a different node.
> 

Not really

static int alloc_pool_huge_page(struct hstate *h, nodemask_t *nodes_allowed)
...
        gfp_t gfp_mask = htlb_alloc_mask(h) | __GFP_THISNODE;
...
        for_each_node_mask_to_alloc(h, nr_nodes, node, nodes_allowed) {
                page = alloc_fresh_huge_page(h, gfp_mask, node, nodes_allowed);
                if (page)
                        break;
        }


The code just tries to distribute the pool

> These hugetlb allocations might be disruptive and that is an expected
> behavior because this is an explicit requirement from an admin to
> pre-allocate large pages for the future use. __GFP_RETRY_MAYFAIL just
> underlines that requirement.

Yes, but in the absence of a particular node, for example via sysctl
(as the compaction does), I don't think it is a hard requirement to get
a page from a particular node. I agree we need __GFP_RETRY_FAIL, in any
case the real root cause for me is should_reclaim_continue() which keeps
the task looping without making forward progress.

The __GFP_THISNODE was again an example of mis-leading the allocator
in this case, IMHO.

> 
> Maybe the compaction logic could be improved and that might be a shared
> goal with future changes though.

I'll also send my RFC once my testing is done, assuming I get it to reproduce
with a desired frequency.

Balbir Singh.
