Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC87C43444
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AD320866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="GniXtc0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbfAOIY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:24:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33330 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfAOIY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:24:57 -0500
Received: by mail-pl1-f194.google.com with SMTP id z23so957376plo.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 00:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=evBP+gUqkh/3ByH6MmOwERT0Raa/qT0rUXNL3TW8osc=;
        b=GniXtc0tZGzWP+BCETg+jiAaaeptD9SQyLuzkUWo/s3subYezEaUMVdXnoei4ktzqh
         iXtAwYXxj62oKwTXVrakmxs4ruox1+dOKDUSg0T7rGu2LacFqqv6SHL55yVyNsk04Vbd
         /F9yHQAyH8luvmRgHCkPvx9AtkfHdK/M8QbmW8FJLccfFen4rc4iIU1H7sFORnjYQeF9
         LYng1mpmJmUlFtuK174ho0b9hpMhyxNrG//WGF1rFAl1or4KkXXYocH9YRzMqK7a6Hit
         yCt2vjBS5lcZlblNZC/1NHE0omSe9RIJ/0PUqhQXV+JSCMBZV7zD/zda+1FVcUcAL19g
         TPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=evBP+gUqkh/3ByH6MmOwERT0Raa/qT0rUXNL3TW8osc=;
        b=PiNyRsSPxZw6mF9qWUWAr9ZoLd5ehVYdBh99Ze1bmpAMY584FDSgSgtqqvG6ATobW1
         shh84P1tmN9m6/6XZEGcDXN+fT2Do61cq+Y0aqA5zQkD7ohvy0+eZCDyI1n+8sEpcvOq
         AeEID95IsLPum8tJfhO++KCpGlzdoLevCgQUY33lKGM+YKV4kbMr9ltgyqUuSzUHiAhS
         68IfEKCsyu/OyeeQeUXhREFzUUCdSb6Kec2iwu1gJgscmJTsiFLXkn1+tyvar18reDf0
         cgdHlUnVXSl4yW/fEnuFtPTCZTXJ4jc9AC4WIg/EE8jnpp2DZAMJ9HKpbZeJ7/nTt3GY
         exqQ==
X-Gm-Message-State: AJcUukexSGQu6i3r98so4J2+Iqbe3wxvAEH329FbK1kwNU/U4AOqnX4p
        GVxWHkW3ZlYhcwUrP2mtVSvpAA==
X-Google-Smtp-Source: ALg8bN7LDGwZ3k0LU8/jLE2tRTPn4KqjgWBhQzy+rx6S58dvvYgNxd3tUfE1TXm/vbtqwDQoRq4Jww==
X-Received: by 2002:a17:902:5ac7:: with SMTP id g7mr2881940plm.212.1547540696183;
        Tue, 15 Jan 2019 00:24:56 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id m3sm3109148pgl.69.2019.01.15.00.24.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:24:55 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id D34DA30064D; Tue, 15 Jan 2019 11:24:50 +0300 (+03)
Date:   Tue, 15 Jan 2019 11:24:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux_lkml_grp@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Boaz Harrosh <boazh@netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Message-ID: <20190115082450.stl6vlrgbvikbwzq@kshutemo-mobl1>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
 <ad3a53ba-82e2-2dc7-1cd2-feef7def0bc3@oracle.com>
 <50c6abdc-b906-d16a-2f8f-8647b3d129aa@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50c6abdc-b906-d16a-2f8f-8647b3d129aa@oracle.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:54:45AM -0800, Mike Kravetz wrote:
> On 1/14/19 7:35 AM, Steven Sistare wrote:
> > On 1/11/2019 6:28 PM, Mike Kravetz wrote:
> >> On 1/11/19 1:55 PM, Kirill A. Shutemov wrote:
> >>> On Fri, Jan 11, 2019 at 08:10:03PM +0000, Mike Kravetz wrote:
> >>>> At LPC last year, Boaz Harrosh asked why he had to 'jump through hoops'
> >>>> to get an address returned by mmap() suitably aligned for THP.  It seems
> >>>> that if mmap is asking for a mapping length greater than huge page
> >>>> size, it should align the returned address to huge page size.
> > 
> > A better heuristic would be to return an aligned address if the length
> > is a multiple of the huge page size.  The gap (if any) between the end of
> > the previous VMA and the start of this VMA would be filled by subsequent
> > smaller mmap requests.  The new behavior would need to become part of the
> > mmap interface definition so apps can rely on it and omit their hoop-jumping
> > code.
> 
> Yes, the heuristic really should be 'length is a multiple of the huge page
> size'.  As you mention, this would still leave gaps.  I need to look closer
> but this may not be any worse than the trick of mapping an area with rounded
> up length and then unmapping pages at the beginning.

The question why is it any better. Virtual address space is generally
cheap, additional VMA maybe more signficiant due to find_vma() overhead.

And you don't *need* to unmap anything. Just use alinged pointer.

> 
> When I sent this out, the thought in the back of my mind was that this doesn't
> really matter unless there is some type of alignment guarantee.  Otherwise,
> user space code needs continue employing their code to check/force alignment.
> Making matters somewhat worse is that I do not believe there is C interface to
> query huge page size.  I thought there was discussion about adding one, but I
> can not find it.

We have posix_memalign(3).


-- 
 Kirill A. Shutemov
