Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE48FC32788
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA43213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="nIS7eySy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFA43213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbeKUAq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 19:46:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44914 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeKUAq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 19:46:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so1053118pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtSfedqgA3D4cYf3BEfvJf2SYBcycZEfPER9XYqbV5c=;
        b=nIS7eySyj57zWdEsY8suKs1PWdALqlrD+Ec2W+2Lva+Wxu2v1/YWBDfDOg6vPOua/5
         lzZruu1uRw4FW5XuvINAH/pUHF2sZnLvqyE9o5xYVVtIWwiA6JV1wjPpMIlF14+0pbf4
         gVYAsvgPYvsi0kXOj1wnpQzAE3QhPOxytIHNAiZW+UEAyx4GYFSuFUd4PU8SHZto78kY
         DRwekK3cTqeGwt+HmhinRarndUlwCKp5pc5AomqXwnpmTJGOkLn2XMZIhSRTKvE2j4Ut
         5Yj1wAAUz/FgQ+2az5S4fjAArgvUjfk6qGvvFVDFFxtivL9nE1XJ/rOtFkEqwPQ1r/cA
         Hkog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtSfedqgA3D4cYf3BEfvJf2SYBcycZEfPER9XYqbV5c=;
        b=s1TsIFVg4vk5Py9zL8Vf1bdFfqPFneBZBOqxY2MOwyoN5tTAVzIM+2MCBaJWqIr1hy
         14TRS5WTFfuYCHmRr6BH5pXhksbz/kndB8hSDMwIpzlA/hmkZhITvCdCM/wY0Bo7qRVO
         G+Vs4/q5DABzp8DyEJeSPXYl+vL3PQbzIJDg/01ozcTYqQ+DeqaX+HnJjtHiTuGTt3eZ
         8+byvJCeclzmAZwEoHPDfj1x7I5fPWxgfRqixfqXnBDPlmdjPNM9KJgYBgFZbyzRsrYu
         m/HJGqiFpvUlZ9OWBrG2GPYI4jv+Dvktzb8hm45tZ9OdnVFpecmPwGk9YZROV0huh6Jb
         eT6Q==
X-Gm-Message-State: AGRZ1gKfGVpGquGcUnGRIjUeK+R3lWxUad4VH83tV5w2GzRnmX0BR+aV
        6+yT/emLh91W8RGP7h/4UDEHbg==
X-Google-Smtp-Source: AJdET5cJ5ODrviO+Qz+gnQsJiNVd8TyDFXrtLA4YV5zRjOvcKvSOkE0sYtAh78hA0AvrFVhTC3TPLw==
X-Received: by 2002:a62:2606:: with SMTP id m6mr2278092pfm.133.1542723425436;
        Tue, 20 Nov 2018 06:17:05 -0800 (PST)
Received: from kshutemo-mobl1.localdomain (fmdmzpr04-ext.fm.intel.com. [192.55.54.39])
        by smtp.gmail.com with ESMTPSA id t2sm29708521pfm.32.2018.11.20.06.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 06:17:04 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id E2C96302653; Tue, 20 Nov 2018 17:17:00 +0300 (+03)
Date:   Tue, 20 Nov 2018 17:17:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <OSalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, fault_around: do not take a reference to a
 locked page
Message-ID: <20181120141700.pwoaxatx3v5xnwos@kshutemo-mobl1>
References: <20181120134323.13007-1-mhocko@kernel.org>
 <20181120134323.13007-4-mhocko@kernel.org>
 <20181120140715.mouc7okin3ht5krr@kshutemo-mobl1>
 <20181120141207.GK22247@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120141207.GK22247@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 03:12:07PM +0100, Michal Hocko wrote:
> On Tue 20-11-18 17:07:15, Kirill A. Shutemov wrote:
> > On Tue, Nov 20, 2018 at 02:43:23PM +0100, Michal Hocko wrote:
> > > From: Michal Hocko <mhocko@suse.com>
> > > 
> > > filemap_map_pages takes a speculative reference to each page in the
> > > range before it tries to lock that page. While this is correct it
> > > also can influence page migration which will bail out when seeing
> > > an elevated reference count. The faultaround code would bail on
> > > seeing a locked page so we can pro-actively check the PageLocked
> > > bit before page_cache_get_speculative and prevent from pointless
> > > reference count churn.
> > 
> > Looks fine to me.
> 
> Thanks for the review.
> 
> > But please drop a line of comment in the code. As is it might be confusing
> > for a reader.
> 
> This?

Yep.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index c76d6a251770..7c4e439a2e85 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2554,6 +2554,10 @@ void filemap_map_pages(struct vm_fault *vmf,
>  
>  		head = compound_head(page);
>  
> +		/*
> +		 * Check the locked pages before taking a reference to not
> +		 * go in the way of migration.
> +		 */
>  		if (PageLocked(head))
>  			goto next;
>  		if (!page_cache_get_speculative(head))
> -- 
> Michal Hocko
> SUSE Labs

-- 
 Kirill A. Shutemov
