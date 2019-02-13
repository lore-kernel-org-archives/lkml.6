Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBAC282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEA2222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550059930;
	bh=Wxm1bHfY1YZqD4W5r4EsO4a10bWMzKNg+6SqdpL2Emc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GkUqNCz1eG2pRbSZZ/AMQoLVgozWu5/XtS2+E+lvvMZETvRC9VcQzk1covAZRXJXI
	 FWBsJ23+/tdxVrc56BAk8F0GxZWEyOMV5uA58CdH/c6EtO2m3OS7LHhae9t8kv9m+j
	 lLzFEvfDrP5uoYHMHN5hxgKw8hFiFBx1pYQC/si8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392035AbfBMMMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:12:08 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33440 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfBMMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:12:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id z11so1061041pgu.0;
        Wed, 13 Feb 2019 04:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1OM8g/NX/UZBg3UJqR2J9FLZx57Ly7BOAmEDV2K7uhY=;
        b=bCsoIO+W9IVxnutoTPEN/oRIhliKyeo6O09HLO5LT2wgmpMxrLpdlAlNGnyfqWVttb
         WRrAd4Op7rx8uyEcrj99cVKq9ZNkl1KcNrbHupj7rdHdVLTeHhnRGabPSroasWUjauxp
         oNdtSGYJx8ocvFN1UGgNhkHGAmIwcaODVMDFMuSi6MDC4lqJUNTP4gTUuj/nHZ/cQTcb
         u4XaqoEw8neWGBtPXzW063ntW5Rbo2vkJfxeLqAPoul2vPo31U+gSK18wmR31ftv/lqa
         ZPi9edi/YcsHQ8HdVg7RBeMjRzs2+t6X6UF9kGArpJb2qAd8pBKVDNv5TuHX8D0V2Wkg
         vcBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1OM8g/NX/UZBg3UJqR2J9FLZx57Ly7BOAmEDV2K7uhY=;
        b=KzRaRWGYdJyMOSE65G9bCDeoPqxZIShbcyKgOVLsaE2jbbNRz8yk+aZ8i3V1GIu6kK
         AQauDMLN5yv49KuRRA8iqNUFQQgpEo63LVqnmr2JeZQMH+NvXsvMXuZTBMC9JeTbXbfV
         9g3bR1bTQrbiFqWRp3EjFxSB/7pN3g3wM5Q4Tb/C4VbYPbOm9h/qZNhYEX9m40AYPm07
         ria7ch4/DKITF0QTzj8+Tf/HeUjCrQadMmfs0GG8h5ieyZTWujiV8Zs0H5q6yQeTLbzp
         WZh3dq0ebjo2FqIfxTHgrn0bvYggQnsoSxZHcSn5nCt2LxRLHgWjXZLhyXtdUZqxTpCb
         Tshg==
X-Gm-Message-State: AHQUAubMMldoMCgaw0kT58yXOrLrIujkZ591mprSSq1pCJkq40DuhbZv
        HusL7Jx1NeArWbkhEJR9du4=
X-Google-Smtp-Source: AHgI3IZGp/7T2ZjzKZOFr0mllbEWlNI/Wg/mSYl7woG4cC/jww2Wcp/Jh9R9HpnmO4AroPzsWODNzA==
X-Received: by 2002:a63:da42:: with SMTP id l2mr141927pgj.403.1550059926786;
        Wed, 13 Feb 2019 04:12:06 -0800 (PST)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id r80sm23435460pfa.111.2019.02.13.04.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:12:05 -0800 (PST)
Date:   Wed, 13 Feb 2019 21:12:00 +0900
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
Message-ID: <20190213121200.GA52615@google.com>
References: <20190213112900.33963-1-minchan@kernel.org>
 <20190213120330.GD4525@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213120330.GD4525@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:03:30PM +0100, Michal Hocko wrote:
> On Wed 13-02-19 20:29:00, Minchan Kim wrote:
> > [1] was backported to v4.9 stable tree but it introduces pgtable
> > memory leak because with fault retrial, preallocated pagetable
> > could be leaked in second iteration.
> > To fix the problem, this patch backport [2].
> > 
> > [1] 5cf3e5ff95876, mm, memcg: fix reclaim deadlock with writeback
> > [2] b0b9b3df27d10, mm: stop leaking PageTables
> > 
> > Fixes: 5cf3e5ff95876 ("mm, memcg: fix reclaim deadlock with writeback")
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: Liu Bo <bo.liu@linux.alibaba.com>
> > Cc: <stable@vger.kernel.org> [4.9]
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> 
> Thanks for catching this dependency. Do I assume it correctly that this
> is stable-4.9 only?

I have no idea how I could find it automatically that a stable patch of
linus tree is spread out with several stable trees(Hope Greg has an
answer). I just checked 4.4 longterm kernel and couldn't find it in there.

Thanks.
