Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5406C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B89C206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+D8p3dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B89C206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbeILBbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:31:21 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36685 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbeILBbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:31:21 -0400
Received: by mail-pf1-f194.google.com with SMTP id b11-v6so12796744pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=F3b2Y2VOZLc0zkSH/gVvM1BNKvbXgSMpAi485ZWbFCg=;
        b=u+D8p3dreBsh6tRRbJ+j4SiGKOuHXk/r88jp6LUeZHmhVqGsw9p3DeRCbmeokPK+qv
         vvpYfkLTkedgl8G7xsmVfpjCbS1LuGtRRnxPzxrXSy/HBBx6jIoCuvo/DdzQUSfopjkQ
         AQbpBWrmA7zpt3lnMCTvKzbRMUx9p7Udmf9QMfbGf8Q4LE5fz4UH0xbtb3DRIu1M+jR5
         j0i1e+iyKmXChgxoXhl4nrb32sQVtfyZgiKHAO9te4e1Hl7Cq3xeEdxfWV7q55OeEKDw
         4Xwpl8saEFO3/7LKpQHSuKkPrOtaTRnhMnn81VdoWSC6ZkaRl7iR33KlFcAsSbucXV49
         9Mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=F3b2Y2VOZLc0zkSH/gVvM1BNKvbXgSMpAi485ZWbFCg=;
        b=m85Yh5DQEPwH596t1Ekn74apWhzjeOS6Yr3nt+hJcKwEcJNtJu8VWPOE9LCWPThU97
         D+bR75Xlt1M5EYon1FUiqmZ8gqc/sCvvVDDib3sNqv24HXHikIW6Bt8KaYWPvNZmbpK9
         45IRhFYeE1cTKN+7ctDbC+qDKxGUoXKhNJcKK0ZlTQBG1hggymaGyP0EU9GfZlrXOCSW
         7wr3CR/JJo2xj9sPP3s989L9yDGHGwS4IQSQhFvOMhsQAgWNvjtEi9wRPszG7EoGVNel
         og1umDDM5bRuJjjO6AKp3NU4qhjk7l5W0lsmwe8MG9JTSXHweSKBOv59h7JxcGgJchvS
         TKzw==
X-Gm-Message-State: APzg51Du9fFxabSindatXsBmcqrAZOnOQIvdzECzPwEItEdtFw82B+cz
        Tji7Wl6WAUfcBhCGgLK6FOQM+g==
X-Google-Smtp-Source: ANB0VdYY4qzyCaPBKD8MO14su80DzXBizv25tvg7TgtwL/P1qMcUhm14DkrDofIKEeKCqrtgQ0UlsQ==
X-Received: by 2002:a65:66d4:: with SMTP id c20-v6mr30050241pgw.55.1536697821915;
        Tue, 11 Sep 2018 13:30:21 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id 185-v6sm39516784pge.82.2018.09.11.13.30.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 13:30:21 -0700 (PDT)
Date:   Tue, 11 Sep 2018 13:30:20 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [PATCH] mm, thp: relax __GFP_THISNODE for MADV_HUGEPAGE
 mappings
In-Reply-To: <20180911115613.GR10951@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1809111319060.189563@chino.kir.corp.google.com>
References: <20180907130550.11885-1-mhocko@kernel.org> <alpine.DEB.2.21.1809101253080.177111@chino.kir.corp.google.com> <20180911115613.GR10951@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Michal Hocko wrote:

> > That's not entirely true, the remote access latency for remote thp on all 
> > of our platforms is greater than local small pages, this is especially 
> > true for remote thp that is allocated intersocket and must be accessed 
> > through the interconnect.
> > 
> > Our users of MADV_HUGEPAGE are ok with assuming the burden of increased 
> > allocation latency, but certainly not remote access latency.  There are 
> > users who remap their text segment onto transparent hugepages are fine 
> > with startup delay if they are access all of their text from local thp.  
> > Remote thp would be a significant performance degradation.
> 
> Well, it seems that expectations differ for users. It seems that kvm
> users do not really agree with your interpretation.
> 

If kvm is happy to allocate hugepages remotely, at least on a subset of 
platforms where it doesn't incur such a high remote access latency, then 
we probably shouldn't be adding lumping that together with the current 
semantics of MADV_HUGEPAGE.  Otherwise, we risk it becoming a dumping 
ground where current users may regress because they would be much more 
willing to fault local pages of the native page size and lose the ability 
to require that absent using mbind() -- and in that case they would be 
affected by the policy decision of native page sizes as well.

> > When Andrea brought this up, I suggested that the full solution would be a 
> > MPOL_F_HUGEPAGE flag that could define thp allocation policy -- the added 
> > benefit is that we could replace the thp "defrag" mode default by setting 
> > this as part of default_policy.  Right now, MADV_HUGEPAGE users are 
> > concerned about (1) getting thp when system-wide it is not default and (2) 
> > additional fault latency when direct compaction is not default.  They are 
> > not anticipating the degradation of remote access latency, so overloading 
> > the meaning of the mode is probably not a good idea.
> 
> hugepage specific MPOL flags sounds like yet another step into even more
> cluttered API and semantic, I am afraid. Why should this be any
> different from regular page allocations? You are getting off-node memory
> once your local node is full. You have to use an explicit binding to
> disallow that. THP should be similar in that regards. Once you have said
> that you _really_ want THP then you are closer to what we do for regular
> pages IMHO.
> 

Saying that we really want THP isn't an all-or-nothing decision.  We 
certainly want to try hard to fault hugepages locally especially at task 
startup when remapping our .text segment to thp, and MADV_HUGEPAGE works 
very well for that.  Remote hugepages would be a regression that we now 
have no way to avoid because the kernel doesn't provide for it, if we were 
to remove __GFP_THISNODE that this patch introduces.

On Broadwell, for example, we find 7% slower access to remote hugepages 
than local native pages.  On Naples, that becomes worse: 14% slower access 
latency for intrasocket hugepages compared to local native pages and 39% 
slower for intersocket.

> I do realize that this is a gray zone because nobody bothered to define
> the semantic since the MADV_HUGEPAGE has been introduced (a826e422420b4
> is exceptionaly short of information). So we are left with more or less
> undefined behavior and define it properly now. As we can see this might
> regress in some workloads but I strongly suspect that an explicit
> binding sounds more logical approach than a thp specific mpol mode. If
> anything this should be a more generic memory policy basically saying
> that a zone/node reclaim mode should be enabled for the particular
> allocation.

This would be quite a serious regression with no way to actually define 
that we want local hugepages but allow fallback to remote native pages if 
we cannot allocate local native pages.  So rather than causing userspace 
to regress and give them no alternative, I would suggest either hugepage 
specific mempolicies or another madvise mode to allow remotely allocated 
hugepages.
