Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BA2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A14218AD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550478036;
	bh=VaukHjZcktjfNr37o6tmfDPvxlo1894PBCTOca6mesg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkMIAVAU8Ww9CurT5zXJ3CAgJlFRFz03x1b2ylfKMkIVbZNuBddyfq+nmNAlN5GMN
	 7IBK1XzVFwuHSTmOwt70peuiuR+nmx1tb3i1Yu834vlx4iA5Q7lhyAg5TddGkR1T2a
	 mYn7xIzMT55H6hmQjwtRzpEfnM0WvrggZmGjsM1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfBRIUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 03:20:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41548 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfBRIUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 03:20:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id m1so8067659pgq.8;
        Mon, 18 Feb 2019 00:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=smQ3UZLScYHvuL/U/au9eTzJZ5+ZHSry0nos0pW1Ac8=;
        b=Od1xhSljbWo3lxm8juCFdcBlxaiHw1ZEjfyL0pHfxUmCLSsd1hn2KPoNWCgczS3I6w
         gWGMmNp0+ZVap4NtrZHLS1nhFeAgML7oRffvfXsLt+KSxzTgpogIKsHcYQC7Cqvn0TEC
         OOzPqI8D3Vttbqwu7wGqNJEKzU3YbpgGjgVhY7EWV2DY5lCGeBxfSEx7O309AaaohDcO
         ej859s2vNfLRttVJ5SzQs6uXmim244ihj/Rz/Bjdi/1FP2RHcC/UKCThxDmynmyF5Suo
         u450ETx3MTHnDZpcZQLopLTq2+sE4OuRyMjvdBuOCNTuMswIC4gCFksFULypR364s2k8
         GSGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=smQ3UZLScYHvuL/U/au9eTzJZ5+ZHSry0nos0pW1Ac8=;
        b=d1CtuXzaCU/b8ev4c/me1/ZeJ/UMgw02o07MCWMdHpzm7fs4l776UFxiPdi3zrUpXb
         4fS62LkbAQbATARtuKmZXwottEdB9GQbGfboC02tYEZeMBzjpcyuf3IUzO7HrFZCRZCV
         JZbjrs9OeqHSB6fFTIPY+YeRPBbTOpdISR95YHOf4IV7HaKlB5E0Ahbu51SHY1bc2ILH
         wU3hX6/Kw3EMRagbo2bOeWaA+SYeKegJErnGEpYHq1fSr2u2uBK3XE5w7mJ4bTS+aGgV
         UMHkSMLe+Q6dT5UmtUvrHtGJ9Zov0fkAnPHwJBHXV4tK+eJX/wOJujLnQ3Qd9KDZWyxq
         UUvg==
X-Gm-Message-State: AHQUAuZ/tIAK/9vQltbCinuJqfEj9L66Ep1lyb+y/TApvI5qForZzAGN
        Zv10YBGoLMy41wiEurYfJds=
X-Google-Smtp-Source: AHgI3Iav4jqBKezlgwNb3JzRYCs5r7JAWnEaRBCpeQQShzGNANjFafBIxhvWEUa4FSBUB4T5kF5I3Q==
X-Received: by 2002:a63:5964:: with SMTP id j36mr17725124pgm.210.1550478032951;
        Mon, 18 Feb 2019 00:20:32 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id q75sm20865180pfa.38.2019.02.18.00.20.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 00:20:31 -0800 (PST)
Date:   Mon, 18 Feb 2019 17:20:26 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190218082026.GA88360@google.com>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213133624.GB9460@kroah.com>
 <20190214072352.GA15820@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214072352.GA15820@google.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 04:23:52PM +0900, Minchan Kim wrote:
> On Wed, Feb 13, 2019 at 02:36:24PM +0100, Greg KH wrote:
> > On Wed, Feb 13, 2019 at 08:29:00PM +0900, Minchan Kim wrote:
> > > [1] was backported to v4.9 stable tree but it introduces pgtable
> > > memory leak because with fault retrial, preallocated pagetable
> > > could be leaked in second iteration.
> > > To fix the problem, this patch backport [2].
> > > 
> > > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> > 
> > This is really commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock
> > with writeback") which was in 4.9.152, 4.14.94, 4.19.16, and 4.20.3 as
> > well as 5.0-rc2.
> 
> Since 4.10, we has [2] so it should be okay other (tree > 4.10)
> 
> > 
> > > [2] b0b9b3df27d10, mm: stop leaking PageTables
> > 
> > This commit was in 4.10, so I am guessing that this really is just a
> > backport of that commit?
> 
> Yub.
> 
> > 
> > If so, it's not the full backport, why not take the whole thing?  Why
> > only cherry-pick one chunk of it?  Why do we not need the other parts?
> 
> Because [2] actually aims for fixing [3] which was introduced at 4.10.
> Since then, [1] relies on the chunk I sent. Thus we don't need other part
> for 4.9.
> 
> [3] 953c66c2b22a ("mm: THP page cache support for ppc64")

Hi Greg,

Any chance to look into this patch?
