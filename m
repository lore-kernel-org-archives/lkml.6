Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7339222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550129135;
	bh=3gOA+Ox4Fd3zRQQLfOOFghe32dgj893NP9+a7uGCb2o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzwJFVjl6eTF/3UGV4wIv1a94IL1zE4QiYbJUair+hMmPXC9CnR9iyL5E8C+zV+ia
	 x0nXyWRjNAuXxzRhHPn4IEgrtVmhUWNnao60ohPXXy9T/hu/Dh7p5JTlQKaDjSluhW
	 VYFKlh5pshbewnHVuO625mkdD0FFA0Of5xRHKcPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437174AbfBNHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 02:25:34 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43984 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394242AbfBNHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 02:25:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id f90so2670258plb.10;
        Wed, 13 Feb 2019 23:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hj2BGzvLaj4ffNSdVIGsQXgGpVC038Ikx4EcicJeqY4=;
        b=YGJvCBCUl0fjU0BhKfgExnzl104zdc+e/RJK4X3+mbXThLEbX9Ia9mJhn0meFKBXxI
         kV3uvQ2MiZODnLyNUHtUqz1KjTrVfyIX4GqR4NgJolUxHtJUABsc6/HHd9VJrXgNr/k+
         VZFCgXllq8c5Tg0ULTfaVry3jfeUhCL+QACmwYs+KnE0E9CF35TWD2ibpwvSyvl4mGLH
         1txUCeHpgnMcnm/GlUXqtLJlrKl3jUhx4WpDwtiRNBPHBEga06Tgzt0qxZ0jZOjhKDkw
         7DxwZpf9eLKyRhJZ3uzMEeNCrSlEc+IBeo/Ecav+Dxd48YEoVYuB/cAXIBOsMMBBmmaY
         a1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hj2BGzvLaj4ffNSdVIGsQXgGpVC038Ikx4EcicJeqY4=;
        b=lLVv4J4GCPveINtUnIJZ/+Adq2mP4FSQ+5fAyYF96kG3iQsxwKorw9DvZDlSVWHYCk
         eIe8N7vRV4AxnfdOKvMCRqGpp8fIf9qxxiY22TZHYn6rHNv+fX2XcGJtI+nJLpHYzwH8
         DOUeg63LN/HrDAMXTvCdGEbZVF/2WMs75PN24F36TCt6l9l1cZSTiN3q3GjH/gurrmem
         cdvX/CgrWhQ99CH1hPiFNUzAjFaczzlaebJ1GBWLWzaYwMYAJBPEXQ1n8vLyEz2QY0Bg
         0InXgNWghKIxWnTEGl3WkompDdl0yDmEeOHXclm7WoAvsVyLmGtesT9JUXPikE07Enm+
         v+Lw==
X-Gm-Message-State: AHQUAub4UTqCVs0pDBd9/eFB/geVFvt5/ybQeg7GQS2fgrOWn+G8iFyi
        rUZT4+rWOkk8vBJHVvL6j7A=
X-Google-Smtp-Source: AHgI3Ibklin6yOIfY8/mrPBnY9l5ASCnxfjmwhml0n4T3S2Vro2vAIw5PlRYIZiYok+EFJ4ODHWMfw==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8mr2652862plh.79.1550129130124;
        Wed, 13 Feb 2019 23:25:30 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id 184sm3162999pfe.106.2019.02.13.23.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 23:25:28 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:25:24 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Liu Bo <bo.liu@linux.alibaba.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Fix the pgtable leak
Message-ID: <20190214072524.GB15820@google.com>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213120330.GD4525@dhcp22.suse.cz>
 <20190213121200.GA52615@google.com>
 <20190213122458.GF4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213122458.GF4525@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:24:58PM +0100, Michal Hocko wrote:
> On Wed 13-02-19 21:12:00, Minchan Kim wrote:
> > On Wed, Feb 13, 2019 at 01:03:30PM +0100, Michal Hocko wrote:
> > > On Wed 13-02-19 20:29:00, Minchan Kim wrote:
> > > > [1] was backported to v4.9 stable tree but it introduces pgtable
> > > > memory leak because with fault retrial, preallocated pagetable
> > > > could be leaked in second iteration.
> > > > To fix the problem, this patch backport [2].
> > > > 
> > > > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> > > > [2] b0b9b3df27d10, mm: stop leaking PageTables
> > > > 
> > > > Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> > > > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > > > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > > Cc: Michal Hocko <mhocko@suse.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Hugh Dickins <hughd@google.com>
> > > > Cc: Liu Bo <bo.liu@linux.alibaba.com>
> > > > Cc: <stable@vger.kernel.org> [4.9]
> > > > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > 
> > > Thanks for catching this dependency. Do I assume it correctly that this
> > > is stable-4.9 only?
> > 
> > I have no idea how I could find it automatically that a stable patch of
> > linus tree is spread out with several stable trees(Hope Greg has an
> > answer). I just checked 4.4 longterm kernel and couldn't find it in there.
> 
> See http://lkml.kernel.org/r/20190115174036.GA24149@dhcp22.suse.cz
> 
> But my question was more about "this is a stable only thing"? It was not
> obvious from the subject so I wanted to be sure that I am not missing
> anything.

Yub, I think only 4.9 stable tree need to be fixed because Hugh's patch was
in there since v4.10. 

Thanks.
