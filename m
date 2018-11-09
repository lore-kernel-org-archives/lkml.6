Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51E8C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4C420825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO2pNtLC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4C420825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbeKIUdE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:33:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40145 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbeKIUdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:33:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id q19-v6so789287pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 02:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rL8v/LvROlSKem8FDX3J+LREw8VykS3KF8XCvW2PKeY=;
        b=WO2pNtLCGa/s1z0cme4MYKVM087TgaPILs0UhxCDQDBYctc9/LnXdobLvQ/Njzgnf+
         RyBYWvnNbtZnSGRTDbU48HZ6q4OIUIgAwPJLP4ivfhwWQOFrIyZbmt3QBTeTqzXapNvF
         9klZfn5en1gkeWc7eTTmvs+2ISn4/B88XWOgZrEXX5dApyaUcqbyT3kE9F5YIQnLbWqG
         kH90rIdeTbTN19JaI2HR9HdO57J1egzBobfp4Jv/i0OQ686IsZN9RwndKZoflaJjTLFx
         8Z3jxl8cwx3N0dUcyXdHbNvYIIIssdof4kkgXWf1H8xhZTuwDfO7vWeBn8ovzaRM4Are
         ZLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rL8v/LvROlSKem8FDX3J+LREw8VykS3KF8XCvW2PKeY=;
        b=FG9uGGdAJhojnRzBBQwg2fYx6guAfWfIKdcS7Yc8Lqn6DA5B7xx4J3ZHVYGcAn0k0B
         Dfh99eooQGW8PYjyjY1APsmBbolYh4TZPxZIyBxFmmjo04Nm8/dwntfwqzqZhOUb8lht
         6k5ra675irEDRUxPSl5aBCm8ERjy0qLKNJh6Mhqgm+aOzjBet1Ix1uD3sCj3idoGDhzW
         wvCY8RbOd8P7xo+AEGCjjh6VjJIaLzYdDcqS4LXFn9OiVsAWKitQWC0u6QpdQ+crs97t
         J1NQHNs+yyf/litrbbK/kTTi35vWn3otBcQbmE537VYn6ro0EwF4FP3rv/PPbCIitc8s
         IrCA==
X-Gm-Message-State: AGRZ1gLWjjh847f68KXrIDhO+nTElE2n//ntsCxcrkIfbzaIB3y3ujzP
        zTqBH1aOrhqez9VUUs15gNg=
X-Google-Smtp-Source: AJdET5cID7S5SDzzw4aCKOs+nzs0hkFhXlE8XEds6dN5AsoDcaLkEI16y8CzVMzQWMfYx4t0Tp4aEg==
X-Received: by 2002:a17:902:28a8:: with SMTP id f37-v6mr8493555plb.264.1541760778997;
        Fri, 09 Nov 2018 02:52:58 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id 64-v6sm15623921pfa.120.2018.11.09.02.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 02:52:58 -0800 (PST)
Date:   Fri, 9 Nov 2018 21:52:55 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Kyungtae Kim <kt0755@gmail.com>, akpm@linux-foundation.org,
        pavel.tatashin@microsoft.com, vbabka@suse.cz, osalvador@suse.de,
        rppt@linux.vnet.ibm.com, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, alexander.h.duyck@linux.intel.com,
        mgorman@techsingularity.net, lifeasageek@gmail.com,
        threeearcat@gmail.com, syzkaller@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: Re: UBSAN: Undefined behaviour in mm/page_alloc.c
Message-ID: <20181109105255.GF9042@350D>
References: <CAEAjamseRRHu+TaTkd1TwpLNm8mtDGP=2K0WKLF0wH-3iLcW_w@mail.gmail.com>
 <20181109084353.GA5321@dhcp22.suse.cz>
 <b51aae15-eb5d-47f0-1222-bfc1ef21e06c@I-love.SAKURA.ne.jp>
 <20181109095604.GC5321@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109095604.GC5321@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:56:04AM +0100, Michal Hocko wrote:
> On Fri 09-11-18 18:41:53, Tetsuo Handa wrote:
> > On 2018/11/09 17:43, Michal Hocko wrote:
> > > @@ -4364,6 +4353,17 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
> > >  	gfp_t alloc_mask; /* The gfp_t that was actually used for allocation */
> > >  	struct alloc_context ac = { };
> > >  
> > > +	/*
> > > +	 * In the slowpath, we sanity check order to avoid ever trying to
> > 
> > Please keep the comment up to dated.
> 
> Does this following look better?
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9fc10a1029cf..bf9aecba4222 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4354,10 +4354,8 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	struct alloc_context ac = { };
>  
>  	/*
> -	 * In the slowpath, we sanity check order to avoid ever trying to
> -	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> -	 * be using allocators in order of preference for an area that is
> -	 * too large.
> +	 * There are several places where we assume that the order value is sane
> +	 * so bail out early if the request is out of bound.
>  	 */
>  	if (order >= MAX_ORDER) {
>  		WARN_ON_ONCE(!(gfp_mask & __GFP_NOWARN));

if (unlikely()) might help

> 
> > I don't like that comments in OOM code is outdated.
> > 
> > > +	 * reclaim >= MAX_ORDER areas which will never succeed. Callers may
> > > +	 * be using allocators in order of preference for an area that is
> > > +	 * too large.
> > > +	 */
> > > +	if (order >= MAX_ORDER) {
> > 
> > Also, why not to add BUG_ON(gfp_mask & __GFP_NOFAIL); here?
> 
> Because we do not want to blow up the kernel just because of a stupid
> usage of the allocator. Can you think of an example where it would
> actually make any sense?
> 
> I would argue that such a theoretical abuse would blow up on an
> unchecked NULL ptr access. Isn't that enough?
> -- 

Balbir Singh.
