Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A05C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0296A21920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KHfOqRy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbeLUWPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:15:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42162 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbeLUWPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:15:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3061854plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=1oXyv+hyR8LAS/wcEoKMlkajidxeADrKp4+muhyFn0c=;
        b=KHfOqRy4hLY3Oy5yLkM42F1EPhIhiAXcW1H5J5OdX1KxMx+E/Gp15PXT+y6p/rXQXp
         uuP4VXAtjRs/uFL+37Sgst66A6djQM21LfrMtL4qABYaf/XVx0xOPzCc7TVB6WN7nCPg
         FsleqKf4mrPDCtbSUbW+2TIQnq2+udupd9McFfKBrQgCvYfTHTLQoeMZQCCRQK0wstu/
         asVkwp7zd+268ywl1J561G268eluABV2uRrs9fEKVYw8a/px5FbfMfIZfhMQSkiSNqsN
         lCAfueQiItSFmDQBhmFgPLWFrqOraq7+x7uj3EcEMjmLw45dXB8QII3PYYyMA6WG0Jn3
         /cLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=1oXyv+hyR8LAS/wcEoKMlkajidxeADrKp4+muhyFn0c=;
        b=JnuBnOt1vJazBz4k6zhCd9abtk63s6QhrNuuCtPKwh3HYzHVB47i1bPmwyxl62A530
         +10X64x6JFVIB4YZ34ybA7uMg2/a2FA5wJVC6fwApEkE9A64qM+YvE+5AohxZh4pib2n
         FeZXS+Ky05tZwfhljNku/e/iRS/zFUEhZ6F6oSt0fZt3dfbRokbTkzERL6tI/luGjGlO
         Z5BBSIwiQTFM9Umd/LCi5IDrLQYh+f32+ByMzTu3spQR8m6C6rK5MH+3fBoHuQ+vu98i
         A13ANB8zA/62/MeRER5vampybKNd5QrwYFWJBdjRy4nGsBxAbujtFtzyYxwHPiUZ3B8l
         e8KA==
X-Gm-Message-State: AJcUukd6fONXtmLEnUMUhg1nDSaV4g8C70KR3SpVR0sDtDgCfbfBR5jT
        c0WzvYAshMn01PVPbt/iwAsXZQ==
X-Google-Smtp-Source: ALg8bN61JHwQD5PoDYot8kCjn+AxI5JKGu4kRewRO5jfN3lnoBSO3+72x7DIKlO4nOe1wwAI2d/bvw==
X-Received: by 2002:a17:902:4225:: with SMTP id g34mr4379112pld.152.1545430514776;
        Fri, 21 Dec 2018 14:15:14 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p2sm33052806pfp.125.2018.12.21.14.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 14:15:05 -0800 (PST)
Date:   Fri, 21 Dec 2018 14:15:05 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, ying.huang@intel.com,
        s.priebe@profihost.ag,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181214231147.GF29005@techsingularity.net>
Message-ID: <alpine.DEB.2.21.1812211413460.219499@chino.kir.corp.google.com>
References: <20181205233632.GE11899@redhat.com> <CAHk-=wguXjkbK8BUU998s7HD7AXJgBkuc9JmuNxiN7uGQyfSfQ@mail.gmail.com> <CAHk-=wjm9V843eg0uesMrxKnCCq7UfWn8VJ+z-cNztb_0fVW6A@mail.gmail.com> <alpine.DEB.2.21.1812061505010.162675@chino.kir.corp.google.com>
 <CAHk-=wjVuLjZ1Wr52W=hNqh=_8gbzuKA+YpsVb4NBHCJsE6cyA@mail.gmail.com> <alpine.DEB.2.21.1812091538310.215735@chino.kir.corp.google.com> <20181210044916.GC24097@redhat.com> <alpine.DEB.2.21.1812111609060.255489@chino.kir.corp.google.com>
 <0bbf4202-6187-28fb-37b7-da6885b89cce@suse.cz> <alpine.DEB.2.21.1812141244450.186427@chino.kir.corp.google.com> <20181214231147.GF29005@techsingularity.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2018, Mel Gorman wrote:

> > In other words, I think there is a lot of potential stranding that occurs 
> > for both scanners that could otherwise result in completely free 
> > pageblocks.  If there a single movable page present near the end of the 
> > zone in an otherwise fully free pageblock, surely we can do better than 
> > the current implementation that would never consider this very easy to 
> > compact memory.
> > 
> 
> While it's somewhat premature, I posted a series before I had a full set
> of results because it uses free lists to reduce searches and reduces
> inference between multiple scanners. Preliminary results indicated it
> boosted allocation success rates by 20%ish, reduced migration scanning
> by 99% and free scanning by 27%.
> 

Always good to have code to look at, I'll take a closer look.  I've 
unfortunately been distracted with other kernel issues lately :/
