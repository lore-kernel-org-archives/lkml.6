Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0F0C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED82222AB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549892955;
	bh=l+4TGBvcR9MnavNN0cP/ePXN7iNo4HtFCOfd2VWaMrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ixUnbe9YBvEZ/QpPqNCyfPIdDomyIdIKsYgSE0tJzSZtAOX9LNTavZP23EnO5jsJl
	 eXFy09A4kOF+Xo8tWGsTCYWjkbJMENikWMu0iMtOe6VJkijTtiuyZfb1WcaGh74/Bt
	 30M4yEyHTqf7KNgLO7efjEAmsMRhp5lNnI8isNpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbfBKNtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:49:14 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40413 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfBKNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:49:13 -0500
Received: by mail-wm1-f67.google.com with SMTP id q21so17315032wmc.5;
        Mon, 11 Feb 2019 05:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DVtdq8fU5yzV1rrZ0aSuQ/EzU0RuehB06aN26pxAuHw=;
        b=CCK4abFGXcAfhVXmnffelYC/DDGe1Z8EpvNin5P2hc8Xjf3/+ybQ8YCd/ZRN0kZuGj
         BtJlskKem5DzyYfhdYZHmjftoWVZgmMfalk4/ALI3ebW/mobd9JROaujzQjZum/b7y+K
         4aO9OawsNAE+/uV+eQpzZbhiratfAlXETcydv2Cjd9OF7KBxn61f/7JXIq5wVHbnKJ/a
         6jNF0S8ah01tkg6wGRZ630re0KbURzsbTKQqnDZbsbfuRjt9pnWjAIqZ8AnUWLTseo+H
         Gzreb6TV39Aw3LUHelip++YXvjHQF4A2T1KXhQVutCk1MVeORaw1FV7orcBxhYLTQjHn
         enmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DVtdq8fU5yzV1rrZ0aSuQ/EzU0RuehB06aN26pxAuHw=;
        b=nTRTukQhRjsE+uMxqI5NN6P3rhIO58QzqJGkRUMlhgja5VNiDjB/XAOmmZJqhHWzMd
         p5Al5FZ7nfYX4mmtl5NSGPxKoNfGPSvjIjoXbesKH+chuzvvxQEzkEiLoOUuPwkt549o
         I2B68RrR348X3wJ2FNej5Kd4NEeY3PT8jj4bDxKcHG/mKgJt5dHXG+I7R4ZXDkouQSAR
         uSWKXZFacQQhj9OCTCC3/oNq2P9kg6oJs9LiSSGUd60ZD8DQjNUO09AmD4E+jkTA2G4o
         wTD0lGelCZHeHz/Cua5js7cfG2QvHvsGXzoZNuzPVc4ldxjCuGRtnNKTQ9vhYlBZN100
         MCiw==
X-Gm-Message-State: AHQUAuY0h5uPyvHaT6c2pM+B6Ps+P0keSkBrOm/PF3njCWMrGev2XrcZ
        /BcCLPJD3clYT5DGh3pSBAI=
X-Google-Smtp-Source: AHgI3IbnoKtqDyMN51wGAheblyAvac9xJv/j79dudDo+aSVyCoGxbXaU22La1kGx2XXQbkCFrKZ1+Q==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr9002787wme.11.1549892952343;
        Mon, 11 Feb 2019 05:49:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id n9sm7499714wrx.80.2019.02.11.05.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 05:49:11 -0800 (PST)
Date:   Mon, 11 Feb 2019 14:49:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190211134909.GA107845@gmail.com>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
 <20190125105008.GJ3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125105008.GJ3560@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 24-01-19 11:10:50, Dave Hansen wrote:
> > On 1/24/19 6:17 AM, Michal Hocko wrote:
> > > and nr_cpus set to 4. The underlying reason is tha the device is bound
> > > to node 2 which doesn't have any memory and init_cpu_to_node only
> > > initializes memory-less nodes for possible cpus which nr_cpus restrics.
> > > This in turn means that proper zonelists are not allocated and the page
> > > allocator blows up.
> > 
> > This looks OK to me.
> > 
> > Could we add a few DEBUG_VM checks that *look* for these invalid
> > zonelists?  Or, would our existing list debugging have caught this?
> 
> Currently we simply blow up because those zonelists are NULL. I do not
> think we have a way to check whether an existing zonelist is actually 
> _correct_ other thatn check it for NULL. But what would we do in the
> later case?
> 
> > Basically, is this bug also a sign that we need better debugging around
> > this?
> 
> My earlier patch had a debugging printk to display the zonelists and
> that might be worthwhile I guess. Basically something like this
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e097f336126..c30d59f803fb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
>  
>  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
>  	build_thisnode_zonelists(pgdat);
> +
> +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> +	pr_cont("\n");
>  }

Looks like this patch fell through the cracks - any update on this?

Thanks,

	Ingo
