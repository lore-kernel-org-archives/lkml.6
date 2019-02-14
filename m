Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B70C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65013222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550129042;
	bh=F4sYpJULutc1o9xjy4x3TXNtVvQl5isz3LlX+8TOs4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+b6TWAkZlGuwRcFpwj5oZrAlI6Ij3kvssYhLWkcdX0Fq6sPYfWOCNdylgGt4Z8lr
	 nGhiTfBg6g8soHfxek72LUvwtSFPjAX7nBJ5yunTCTzI+aUN0nyZ6JDrTZVMiNhVrL
	 PW17sMXJulxkfc5pHOUJn8cFFY3vwH+YBXAWBYPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437227AbfBNHYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:24:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43833 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfBNHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:24:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so2668304plb.10;
        Wed, 13 Feb 2019 23:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F1jQFRomg8z6bxckYaWujgYc61Y06VR9mkChwxkXyb4=;
        b=oB/EkNRV7wtskWebNYJO0rEUXLmYt3qpmvoN41PBK6t8sKWqXx6jSW1VR4J1iLyGMP
         9CULoepcjufhlptggR7+90kbRVA0uAY8vPk62ZzURncg8h9d60MT9zDPFIVdRU02DYEU
         LppCmecyETZOBzG4Qa3jV739E4+1ChQRsnBTvXzPsnDAdg6DFchxDZAt6MAIQk3BqGXZ
         2DVXJcmz5sWbHLcQ9jVvOVpE0r+5eg0t0kp+p+oCK0uNimtznFIKbKskxXMoyCxF5j8h
         E9VJtJKSP1J4GcmL3wqMq1dueL5zsHdvcVnUjhYVSu2JFNbKA2zoMwhNq0kW0oNL9Vmc
         i0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F1jQFRomg8z6bxckYaWujgYc61Y06VR9mkChwxkXyb4=;
        b=ly4LvvSXm4nmXROFJq1b9uKkGSeEO1IGNFQZa6toqg91CvNGroeaTPNNP0SAgmYWmN
         /xFVwKB8xl6C82z12U3ck3rT3VVOdPgO4DcgTFkQiz11M1ACCjcz5x3WYMN6S4/m0yky
         c4CBanMrITMUVRZ2O2eTTmCPi7QmF37vRju6WkboFTks8AviyQZ9U7DG9nrE5psXU9gZ
         T6C4fHNsPXvvAqjZsx6E6x7iaw8gjlTKJ77P0zJRg6bSIwwSnWRGwxqEesP7yis3c6Zv
         nLPKp5aOZ7lCGCshmwp+VF/bQ6FCvv79imDSN3FAXah20BZ+z657pbvTwN82O7Dnzen1
         b1Wg==
X-Gm-Message-State: AHQUAuYXPlS5GxYFhFg0BGjkPJ9xlMrT0bdRkHZvSrTwNrHMSWmNQrKh
        CvzHl1UB1o47sX07Ns3IdE4=
X-Google-Smtp-Source: AHgI3IZ5GAcPKn68oH218XOBZwhFpm72LeTU46aBVqGZ909TCPLgBRuWEr8G9dVaVamxXwJhFNUcdA==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr2655060plf.233.1550129039481;
        Wed, 13 Feb 2019 23:23:59 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id g10sm1762487pgo.64.2019.02.13.23.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:23:57 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:23:52 +0900
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
Message-ID: <20190214072352.GA15820@google.com>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213133624.GB9460@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213133624.GB9460@kroah.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 02:36:24PM +0100, Greg KH wrote:
> On Wed, Feb 13, 2019 at 08:29:00PM +0900, Minchan Kim wrote:
> > [1] was backported to v4.9 stable tree but it introduces pgtable
> > memory leak because with fault retrial, preallocated pagetable
> > could be leaked in second iteration.
> > To fix the problem, this patch backport [2].
> > 
> > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> 
> This is really commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock
> with writeback") which was in 4.9.152, 4.14.94, 4.19.16, and 4.20.3 as
> well as 5.0-rc2.

Since 4.10, we has [2] so it should be okay other (tree > 4.10)

> 
> > [2] b0b9b3df27d10, mm: stop leaking PageTables
> 
> This commit was in 4.10, so I am guessing that this really is just a
> backport of that commit?

Yub.

> 
> If so, it's not the full backport, why not take the whole thing?  Why
> only cherry-pick one chunk of it?  Why do we not need the other parts?

Because [2] actually aims for fixing [3] which was introduced at 4.10.
Since then, [1] relies on the chunk I sent. Thus we don't need other part
for 4.9.

[3] 953c66c2b22a ("mm: THP page cache support for ppc64")

Thanks.
