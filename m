Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2564C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D02C2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 11:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550057602;
	bh=+jioOy0azxh/2zqDr9FIb7eSsQrlWWVBb3lyQ9121R4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wyU8OtYQEjM+rRr32liippZhd/Puj82ZfP+XjC1lJiH/jF+ey8Axix38wtObAh1IC
	 Er5xIzbxN8fGutVsL0vY7jKg8teMGItGaK+luu2mw0fK0RS5p1I7FGaqz4Ll0HstOp
	 AnkBv9Alx5jqMaUyXf+O9GXBVbiNf8vbZN4hRzrk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403929AbfBMLdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 06:33:21 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35979 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfBMLdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 06:33:20 -0500
Received: by mail-it1-f194.google.com with SMTP id h6so3714988itl.1;
        Wed, 13 Feb 2019 03:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gdIwE2aBy/rd4nMZfHWmtIjw8GVWglWwxpfhXIWlMCc=;
        b=I72evs5DmhA/IkqhBTn3SfCPZeRF44Zs9eI4QXeKRbAp/XMivxySnEY+AVra3YHelk
         4aAAZIjJyYBdCd80BK058Cv/TU/cPa1eTldyk5WNgwjTspp9YPoR4t+2DY2fqgLZ2mIS
         bR0baOHsM/las67jgmo7vKyr/i6wCBw0aLCiMznGEhiMT7z/tGSTrSRdlFddmJxXdJnt
         dFcMwgAgBBO8WvLUxB0yS/0hgHjvqKIqqM86qz6+3hNtqyctHXxlLZBkdP179a4naxga
         mDzumdjxp3lFWYKeN02zMYjabvPf09NDfLscjQFWWAfjF3FsncUH94oroQYLOR/++Fto
         ZOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gdIwE2aBy/rd4nMZfHWmtIjw8GVWglWwxpfhXIWlMCc=;
        b=BOwujf7v46ddGfTH5udTkl/+s4Qhqp9AjfBooKnj0aAsndDCmdQ40bRJ246LR28uln
         BEHvfNiEU9kvJTWuzSyMmL7FL5+2BhWRFzzSfLsyqhpw1ABM71f8bwNtEGfttrrVICdL
         NkENU28rC7PxPcVg+KSczH5TFXJ+ICArF0I4OgRbnWUYbvykLDoILCplQ7tmr//MXVU5
         zCPlVFH21vDxU4PAt711R38KSMPJau2jzDiooQ0we8bzHRK3IZ6KRmJ017wbmA5wQjtb
         VBh0B7/VNevkzxG4krBR3BR+qQ4nuRKAwlbh6SnNetkdrL72kHrH2cX/Jhn0cVkU6c9w
         7Taw==
X-Gm-Message-State: AHQUAuYHgcGo1ABrEOdjzr4ZfDfaIIvYLXGwd6FjxkhbcegmhjHtLrLc
        aDx11TRk5AoXapLL0TsEz6I=
X-Google-Smtp-Source: AHgI3IZLa6ZrZ3frPClxSclZ9XAR+2Ge7zfdXLzhOnpOJ2ueM396dqtnJMqSnq3bNGfHt/TMWjkdhg==
X-Received: by 2002:a6b:b4cf:: with SMTP id d198mr17658iof.96.1550057599322;
        Wed, 13 Feb 2019 03:33:19 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id y184sm3268683ity.27.2019.02.13.03.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 03:33:17 -0800 (PST)
Date:   Wed, 13 Feb 2019 20:33:12 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org,
        Martin Liu <liumartin@google.com>
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190213113312.GA34988@google.com>
References: <20190213112900.33963-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213112900.33963-1-minchan@kernel.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:29:00PM +0900, Minchan Kim wrote:
> [1] was backported to v4.9 stable tree but it introduces pgtable
> memory leak because with fault retrial, preallocated pagetable
> could be leaked in second iteration.
> To fix the problem, this patch backport [2].
> 
> [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> [2] b0b9b3df27d10, mm: stop leaking PageTables
> 
> Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Liu Bo <bo.liu@linux.alibaba.com>
> Cc: <stable@vger.kernel.org> [4.9]
> Signed-off-by: Minchan Kim <minchan@kernel.org>
Reported-by: Martin Liu <liumartin@google.com>

