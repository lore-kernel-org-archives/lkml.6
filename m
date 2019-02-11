Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED801C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9AD021773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="n4kLctD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727638AbfBKVd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:33:56 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34584 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbfBKVdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:33:55 -0500
Received: by mail-yw1-f67.google.com with SMTP id u205so185875ywe.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 13:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hVKwAqoHVFgMa2AWbKba1qi0i0vrDDmcwy0nd3S4ZKE=;
        b=n4kLctD7UE5F10ODXcqZ39+kzrDLdbwMD/i67pe02a+359+Umq6pnwTJxeC682tS0I
         DMwKL3L153uyB0BH8cvIlBADZ3lTY7S1EQfotC+bLPGgmtetWYD+UumpJZSpgLQhqSo2
         8nYsYOJQ41/OkZSt4eRCegqlBeGQWMA4PW+FYjDueMH/uRS853aNPooWC57pxrU/2RBm
         R1pHvY+LRehia/wmB9yRGoXGDUq1Nr1TxgSsHro9uaYwenJ/P5pjqiDiVWHtCrhJ6DF0
         +OKywYzSNvOJIeLEXL8HofmqrDSBmWrcFd+3M9exT9kFuM30WqqtjPEZDNLrq4k6K274
         SaAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hVKwAqoHVFgMa2AWbKba1qi0i0vrDDmcwy0nd3S4ZKE=;
        b=YPGzLjA29Q3YVxh0uXovyRt4xcf8dwqMtczKO8EzLKw9LubTV3CFy6mLkZBjBHrUuw
         KwQGDNr2ga4OiUs0HkQo8nH2XqOkyjY/AEI4V/0Y37jtHE/1rcJdVOFlMokeePObiWDm
         R5kmDS61U6hb1SSZWrYrZ8ISxChbBXk+rMOkdIbq78Ke51o5u8GC7aA7g2VU/vwTUvQA
         fELVz/Rql8bbpvYzR4Ztu7udrkHVH50CdIpTekjZERoXovMBiz+mjK8Q39A2V9EJzpe8
         qPb+NS9dY5/YMNxp8NYUZFrg0/NNDlmW3WxtWR3PjPS0kRnQoIgHTPbImPU9L4JcwYRd
         45yQ==
X-Gm-Message-State: AHQUAuZknlmoUze1z3cgOdK6E8tQS4H2omAB90O7nPTPpMOnUKEFRidR
        mfX3JHSUxIYqD20BntiGxww8/Q==
X-Google-Smtp-Source: AHgI3IZkTOaPIPYvC/IjGg93vPO/9Q0dSZWzvla0ANEDBJAYR5//2lx61kELPsB6crIwDeBWDynCqA==
X-Received: by 2002:a0d:d58d:: with SMTP id x135mr248358ywd.488.1549920834359;
        Mon, 11 Feb 2019 13:33:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::5:67a5])
        by smtp.gmail.com with ESMTPSA id o4sm1571505ywe.102.2019.02.11.13.33.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:33:53 -0800 (PST)
Date:   Mon, 11 Feb 2019 16:34:19 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrea Righi <righi.andrea@gmail.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] blkcg: prevent priority inversion problem during
 sync()
Message-ID: <20190211213417.uhfiz5iqwkfrvk25@macbook-pro-91.dhcp.thefacebook.com>
References: <20190209140749.GB1910@xps-13>
 <20190211153933.p26pu5jmbmisbkos@macbook-pro-91.dhcp.thefacebook.com>
 <20190211204029.GB1520@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211204029.GB1520@xps-13>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 09:40:29PM +0100, Andrea Righi wrote:
> On Mon, Feb 11, 2019 at 10:39:34AM -0500, Josef Bacik wrote:
> > On Sat, Feb 09, 2019 at 03:07:49PM +0100, Andrea Righi wrote:
> > > This is an attempt to mitigate the priority inversion problem of a
> > > high-priority blkcg issuing a sync() and being forced to wait the
> > > completion of all the writeback I/O generated by any other low-priority
> > > blkcg, causing massive latencies to processes that shouldn't be
> > > I/O-throttled at all.
> > > 
> > > The idea is to save a list of blkcg's that are waiting for writeback:
> > > every time a sync() is executed the current blkcg is added to the list.
> > > 
> > > Then, when I/O is throttled, if there's a blkcg waiting for writeback
> > > different than the current blkcg, no throttling is applied (we can
> > > probably refine this logic later, i.e., a better policy could be to
> > > adjust the throttling I/O rate using the blkcg with the highest speed
> > > from the list of waiters - priority inheritance, kinda).
> > > 
> > > This topic has been discussed here:
> > > https://lwn.net/ml/cgroups/20190118103127.325-1-righi.andrea@gmail.com/
> > > 
> > > But we didn't come up with any definitive solution.
> > > 
> > > This patch is not a definitive solution either, but it's an attempt to
> > > continue addressing this issue and handling the priority inversion
> > > problem with sync() in a better way.
> > > 
> > > Signed-off-by: Andrea Righi <righi.andrea@gmail.com>
> > 
> > Talked with Tejun about this some and we agreed the following is probably the
> > best way forward
> 
> First of all thanks for the update!
> 
> > 
> > 1) Track the submitter of the wb work to the writeback code.
> 
> Are we going to track the cgroup that originated the dirty pages (or
> maybe dirty inodes) or do you have any idea in particular?
> 

The guy doing the sync(), so that way we can accomplish #3.  But really this is
an implementation detail, however you want to accomplish it is fine by me.

> > 2) Sync() defaults to the root cg, and and it writes all the things as the root
> >    cg.
> 
> OK.
> 
> > 3) Add a flag to the cgroups that would make sync()'ers in that group only be
> >    allowed to write out things that belong to its group.
> 
> So, IIUC, when this flag is enabled a cgroup that is doing sync() would
> trigger the writeback of the pages that belong to that cgroup only and
> it waits only for these pages to be sync-ed, right? In this case
> writeback can still go at cgroup's speed.
> 
> Instead when the flag is disabled, sync() would trigger writeback I/O
> globally, as usual, and it goes at full speed (root cgroup's speed).
> 
> Am I understanding correctly?
> 

Yup that's exactly it.  Thanks,

Josef
