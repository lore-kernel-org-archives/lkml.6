Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6BC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497792087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ZohvWTSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387639AbfA3T1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:27:15 -0500
Received: from mail-yb1-f181.google.com ([209.85.219.181]:40448 "EHLO
        mail-yb1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfA3T1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:27:15 -0500
Received: by mail-yb1-f181.google.com with SMTP id y13so287038ybr.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 11:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lCaOFzEC9GUOriuVkX8NdFG1tjkodE5DqXV/LschmsI=;
        b=ZohvWTSuJ0FjLHNrBU/NhCidpuP6uTp++17i5m8r0Y4BdXn5gysuarYBmwXmDnXh2E
         5q1Zg6iKy575V4xaQ+3m+w3YaXK2epGUUWapRT4Qk1pYbJ8e24CWTlXowEvP0d0EY1gj
         VGdefopA01lh0af6fU5Lw/yDe5q6HouSDwamc8EyJLf8rHD0F+4MvHD+Rji3pspKlXkr
         R6EGixTm/VAe72WpuMNrIokMPUZJvqGh3qMbrMlYCi/rzPY0ozgqJnu4a8UmGQDrTYkI
         couibxZPlwtjEDeLQU1PlYXif1ZmmnuJtzPzfiRz4zqRA+irU0fT/tlOc4Upb6sHSWXJ
         0PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lCaOFzEC9GUOriuVkX8NdFG1tjkodE5DqXV/LschmsI=;
        b=Nw7+8v7yiJyQb7yRz16+apKhlz9mBwXBMKOelFr2GHD0JaM+WnF4tseolCBaOK0PZg
         sWiSx2NT7nE5S7P+Pfdi0v0QZizIxS67TxIR2G39mMYLZQTWSF/M2TTXBCp6iJ2crgAa
         oaDnO9/5yvcwTM+1h2U4h5b6sa1eLPXxtqZuCjTwHIl3jzE+CqiOsD5pBvi0XV3q1COO
         gn2LGzx/9Te0LKD4jZsyM7ehn5jJZbH97fCUQwy+OyAevtIrdxnDT2FyiTksYdJV0mvK
         mBiNhdJfi0O8G+aRrV1PcviP0VCEgFZhyEx7oe6YduBoFDDkoDKfSGr7bGC3nyZGYj16
         5J6Q==
X-Gm-Message-State: AJcUukdh66oRaV58Yakm8xiTUO9yJWG3fvRbxudNyFtSCC/Hl0LAACrR
        KVshO0Xi1RxgECxvu5ZUvkXLKA==
X-Google-Smtp-Source: ALg8bN4HOZ2BceRWudY9fcvRQQG06wEy+HZBcWR1nYVuLTVCr2JVnKVx5gChDjnH9Skuez+BhBA8lQ==
X-Received: by 2002:a25:5e03:: with SMTP id s3mr29744932ybb.8.1548876433952;
        Wed, 30 Jan 2019 11:27:13 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:6c95])
        by smtp.gmail.com with ESMTPSA id k83sm781960ywe.90.2019.01.30.11.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 11:27:13 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:27:12 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Dennis Zhou <dennis@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team@fb.com
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Message-ID: <20190130192712.GA21279@cmpxchg.org>
References: <20190128145407.GP50184@devbig004.ftw2.facebook.com>
 <20190128151859.GO18811@dhcp22.suse.cz>
 <20190128154150.GQ50184@devbig004.ftw2.facebook.com>
 <20190128170526.GQ18811@dhcp22.suse.cz>
 <20190128174905.GU50184@devbig004.ftw2.facebook.com>
 <20190129144306.GO18811@dhcp22.suse.cz>
 <20190129145240.GX50184@devbig004.ftw2.facebook.com>
 <20190130165058.GA18811@dhcp22.suse.cz>
 <20190130170658.GY50184@devbig004.ftw2.facebook.com>
 <CALvZod5ma62fRKqrAhMcuNT3GYT3FpRX+DCmeVr2nDg1u=9T8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5ma62fRKqrAhMcuNT3GYT3FpRX+DCmeVr2nDg1u=9T8w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 11:11:44AM -0800, Shakeel Butt wrote:
> Hi Tejun,
> 
> On Wed, Jan 30, 2019 at 9:07 AM Tejun Heo <tj@kernel.org> wrote:
> >
> > Hello, Michal.
> >
> > On Wed, Jan 30, 2019 at 05:50:58PM +0100, Michal Hocko wrote:
> > > > Yeah, cgroup.events and .stat files as some of the local stats would
> > > > be useful too, so if we don't flip memory.events we'll end up with sth
> > > > like cgroup.events.local, memory.events.tree and memory.stats.local,
> > > > which is gonna be hilarious.
> > >
> > > Why cannot we simply have memory.events_tree and be done with it? Sure
> > > the file names are not goin to be consistent which is a minus but that
> > > ship has already sailed some time ago.
> >
> > Because the overall cost of shitty interface will be way higher in the
> > longer term.  cgroup2 interface is far from perfect but is way better
> > than cgroup1 especially for the memory controller.  Why do you think
> > that is?
> >
> 
> I thought you are fine with the separate interface for the hierarchical events.

Every other file in cgroup2 is hierarchical, but for recursive
memory.events you'd need to read memory.events_tree?

Do we hate our users that much? :(
