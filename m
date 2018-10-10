Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86D6C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B2DE20644
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Bs4xG5oH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B2DE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJJW2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:28:02 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:38647 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJW2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:28:02 -0400
Received: by mail-yb1-f195.google.com with SMTP id e190-v6so2330116ybb.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 08:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DYfBSvRLWiHjPMJwqQOe3zF+n7IIOPPxHSu7VOnpN7E=;
        b=Bs4xG5oHaNKaUz0/GJRq1kak3ZweU/shExSAVB1Nkyh/BeoDmF1TfrQcu+luH9YvYE
         QgVVUs/wV0dfamesUXf4EGOPCb4Vhd/8GuGlOXjSoiEML0WkwMa3dZjTrKOkAiqrI3qP
         paFMqvS6aeg1cvRpxIJYthJcse9YIwETywTEnGnhi2PD4RFrKzv2W8Hw9lWIcncVw3J3
         I6S9PbqIfbXBEvDVwrD3jeppo0r0qXr35W2VVxTBBOg9Wq0DHBbswnCWBNEYmBJVsWrB
         52xCuONiAWY25P78rIjvEmE1vvRljBSpV0kdQvB+jsVf14Qy7lRXOsvzzbTjZG3hoi9J
         hszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DYfBSvRLWiHjPMJwqQOe3zF+n7IIOPPxHSu7VOnpN7E=;
        b=G5RM/7cYtpMKZQo5z23Bn0zxMNS9T6jF+BfNwJ+8NqalMLqR9qXkjbatZpeXqI23vH
         4DMiRXIVoqm6J87V0vrVYvYOW+tSLJEnMNvfZxuQgSfqP3MBHLRFH/EWd1gN1Dt6v/0r
         6W8HXuHt2OMUp8SkgheIwDIy54bOYi+e6mzcFSEB8p2lnfCxiRIYngU4Aff2afXEtbES
         7b6Wy1LeCXHbRpKuJ3I+Sfg3G1ze8bWXePmpEwbk1cz7dHEyPhR9E6wRXSwFrPjDeNKk
         xZ31pZakundjFWFG7/DRoCeeaZvbsKKQj0eaGEtdkm5YGxTZ/0hPbn5yN5zMF5oLuADT
         mmvA==
X-Gm-Message-State: ABuFfohx6neX2bF7MqrfvyEuHhQOF9fjD7ZYtnrib/sjW9on//m84Usc
        b3NBth+cI5gYBOcPH0fqM1BPCw==
X-Google-Smtp-Source: ACcGV60riX7lqffFT64ZkYLP80HoFqHxQbfqg9wk6nvOEfmY7/zeEppbQK5ZbxdDEabAUk383mY8LA==
X-Received: by 2002:a25:640a:: with SMTP id y10-v6mr19380580ybb.421.1539183926337;
        Wed, 10 Oct 2018 08:05:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::6:4a04])
        by smtp.gmail.com with ESMTPSA id f63-v6sm10227650ywc.21.2018.10.10.08.05.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 08:05:25 -0700 (PDT)
Date:   Wed, 10 Oct 2018 11:05:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Message-ID: <20181010150524.GB2527@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
 <20181009184732.762-4-hannes@cmpxchg.org>
 <20181009150845.8656eb8ede045ca5f4cc4b21@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181009150845.8656eb8ede045ca5f4cc4b21@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 03:08:45PM -0700, Andrew Morton wrote:
> On Tue,  9 Oct 2018 14:47:32 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > --- a/mm/workingset.c
> > +++ b/mm/workingset.c
> > @@ -378,11 +378,17 @@ void workingset_update_node(struct xa_node *node)
> >  	 * as node->private_list is protected by the i_pages lock.
> >  	 */
> >  	if (node->count && node->count == node->nr_values) {
> > -		if (list_empty(&node->private_list))
> > +		if (list_empty(&node->private_list)) {
> >  			list_lru_add(&shadow_nodes, &node->private_list);
> > +			__inc_lruvec_page_state(virt_to_page(node),
> > +						WORKINGSET_NODES);
> > +		}
> >  	} else {
> > -		if (!list_empty(&node->private_list))
> > +		if (!list_empty(&node->private_list)) {
> >  			list_lru_del(&shadow_nodes, &node->private_list);
> > +			__dec_lruvec_page_state(virt_to_page(node),
> > +						WORKINGSET_NODES);
> > +		}
> >  	}
> >  }
> 
> A bit worried that we're depending on the caller's caller to have
> disabled interrupts to avoid subtle and rare errors.
> 
> Can we do this?

I'm not opposed to it, but the i_pages lock is guaranteed to be held
during the tree update, and that lock is also taken from the io
completion irq to maintain the tree's dirty/writeback state. It seems
like a robust assumption that interrupts will be disabled here.

But all that isn't very obvious from the code at hand, so I wouldn't
mind adding the check for documentation purposes.

It's not a super hot path, but maybe VM_WARN_ON_ONCE()?

> --- a/mm/workingset.c~mm-workingset-add-vmstat-counter-for-shadow-nodes-fix
> +++ a/mm/workingset.c
> @@ -377,6 +377,8 @@ void workingset_update_node(struct radix
>  	 * already where they should be. The list_empty() test is safe
>  	 * as node->private_list is protected by the i_pages lock.
>  	 */
> +	WARN_ON_ONCE(!irqs_disabled());	/* For __inc_lruvec_page_state */
> +
>  	if (node->count && node->count == node->exceptional) {
>  		if (list_empty(&node->private_list)) {
>  			list_lru_add(&shadow_nodes, &node->private_list);
> _
