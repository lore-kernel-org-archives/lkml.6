Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D5FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC0120836
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLxvnjJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DC0120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeIEBBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:01:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44439 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbeIEBBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:01:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id g6-v6so4065185lfb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 13:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jdZPx2qgmld/MZFw3Y8fSyBtvI0SVpvEtYXr0Tb4ldM=;
        b=bLxvnjJ5W+cOMslMeHF5UMEdjeMtUhYeqm5xFv8ntpSLjtSE4zpEdx5T1u5TcSxB2Q
         noTg4mLE/NbOLx2QLv9iHvdiwFlFbNNsnStDHBbqEj953s2m4zv/JCX9hKeA7IMIVOLT
         bC8d7rucA1ITr25N+aSlT7YYqRIQkgwRrWadJmSRWkDqJesyhqdXEOI2Zft7XjjjtOfu
         Ine6KIMSB9qSQZ+Sut5SQHku0inPtPHn3IimGgrzV9oKkNJkXtmKSgctI2va23NXyLpX
         pQ9TLuXSPfZyUCVpmPxOk4KY9+la5gnRV6TkTOKKGpR/jiBZOhv9nbYlL5QIpT/8VuCr
         12iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdZPx2qgmld/MZFw3Y8fSyBtvI0SVpvEtYXr0Tb4ldM=;
        b=Cj7Emtz7mtaJrUrAricDN5QQmZa/HPIhXmW1NptauUncUzXw02syvpp9NKPEWGkuSN
         USBK3T4WM/JOMXY+m39K0U9dJQpK9KVKdDlvQurFzMR7NHKSttVzjmkODr2ZSWsjl9e1
         KwLFKWWvo/9yO+xkZz1Ma0ng75ycblqB2OJwoPzawueVb4gUQ3bmvyIUd6R17nPiwaB7
         TJUowrh+8tgqIMxvLUqsgmbv9nP2lrctV9r4m97i0RhTmkYO/CG9XCnP5xSXCo7ul7ty
         kTcvQUE+6YaKTkEsj1HBVwDB6pFSMFeUgtU6uo+m8i2PRaa39JM/gcO+xX23wIVuHDuZ
         kL2w==
X-Gm-Message-State: APzg51DSzXG5/Ixc1SRvEF8oylaF3IJd9U1U2vhEX23qNSqhoW174T5c
        r2Jj/ndiplOOCsuTocdq5o4=
X-Google-Smtp-Source: ANB0VdYhcm9FNxFAc7KAB9nwiMGFEjTcZNsh6pjKQyuThLkV/twvtEpuS5zjP2bmd6XkvWcqjGkngQ==
X-Received: by 2002:a19:f015:: with SMTP id p21-v6mr11153555lfc.56.1536093254617;
        Tue, 04 Sep 2018 13:34:14 -0700 (PDT)
Received: from esperanza (81.5.110.43.dhcp.mipt-telecom.ru. [81.5.110.43])
        by smtp.gmail.com with ESMTPSA id h16-v6sm4383533ljh.26.2018.09.04.13.34.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 13:34:13 -0700 (PDT)
Date:   Tue, 4 Sep 2018 23:34:11 +0300
From:   Vladimir Davydov <vdavydov.dev@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Josef Bacik <jbacik@fb.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: slowly shrink slabs with a relatively small number
 of objects
Message-ID: <20180904203411.haiiy22ogpj77fvx@esperanza>
References: <20180831203450.2536-1-guro@fb.com>
 <3b05579f964cca1d44551913f1a9ee79d96f198e.camel@surriel.com>
 <20180831213138.GA9159@tower.DHCP.thefacebook.com>
 <20180903182956.GE15074@dhcp22.suse.cz>
 <20180903202803.GA6227@castle.DHCP.thefacebook.com>
 <20180904070005.GG14951@dhcp22.suse.cz>
 <20180904153445.GA22328@tower.DHCP.thefacebook.com>
 <20180904161431.GP14951@dhcp22.suse.cz>
 <20180904175243.GA4889@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904175243.GA4889@tower.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 10:52:46AM -0700, Roman Gushchin wrote:
> Reparenting of all pages is definitely an option to consider,

Reparenting pages would be great indeed, but I'm not sure we could do
that, because we'd have to walk over page lists of semi-active kmem
caches and do it consistently while some pages may be freed as we go.
Kmem caches are so optimized for performance that implementing such a
procedure without impacting any hot paths would be nearly impossible
IMHO. And there are two implementations (SLAB/SLUB), both of which we'd
have to support.

> but it's not free in any case, so if there is no problem,
> why should we? Let's keep it as a last measure. In my case,
> the proposed patch works perfectly: the number of dying cgroups
> jumps around 100, where it grew steadily to 2k and more before.
> 
> I believe that reparenting of LRU lists is required to minimize
> the number of LRU lists to scan, but I'm not sure.

AFAIR the sole purpose of LRU reparenting is releasing kmemcg_id as soon
as a cgroup directory is deleted. If we didn't do that, dead cgroups
would occupy slots in per memcg arrays (list_lru, kmem_cache) so if we
had say 10K dead cgroups, we'd have to allocate 80 KB arrays to store
per memcg data for each kmem_cache and list_lru. Back when kmem
accounting was introduced, we used kmalloc() for allocating those arrays
so growing the size up to 80 KB would result in getting ENOMEM when
trying to create a cgroup too often. Now, we fall back on vmalloc() so
may be it wouldn't be a problem...

Alternatively, I guess we could "reparent" those dangling LRU objects
not to the parent cgroup's list_lru_memcg, but instead to a special
list_lru_memcg which wouldn't be assigned to any cgroup and which would
be reclaimed ASAP on both global or memcg pressure.
