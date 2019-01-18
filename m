Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CD8C5AC81
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0264620850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 17:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Th71br3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfARRME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:12:04 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33737 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbfARRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 12:12:03 -0500
Received: by mail-yb1-f193.google.com with SMTP id g17so725994yba.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 09:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yy+kA1vOcpZaoYU+BJnjwo66nMUhjetEBGne753c72A=;
        b=Th71br3ZIWXqVzix6cgs4EeSsv+xZXidib55aVqQUFpIORoaL9eEyI+jdw9DYNy2Vm
         dMd+CEYfN4qH6+bf9keQ9WSuYj4dBThoBqp5TJ/r54ikGiDXX/7l9ibumrPShSvu2+7W
         ABGAi58TH1HWfI8RHeBrRZjfw3xTQZPv0l1ElSyrepx4kE6QyEUkYLFBgokvNoFZQeCn
         IicncPHrv/+NmxcS5xH1F5Rebp7X3IesmBhbTulPF2Xh6vOL1wwrXj9XNdq9N8BfWLKB
         sPWUi5x+0hcdUaA0UJcauRrws7VwpN2Bb+UaeSyt2QyoW6JhUZS1rrKAXr1IIJSLeAhn
         gxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yy+kA1vOcpZaoYU+BJnjwo66nMUhjetEBGne753c72A=;
        b=HegFacqL10EyqKwZdDBC+h8Qd7UMb1PxjN1uri5qz1SY/uimNQ6s8pIC/mbaSdZ0QG
         801OufIztmJ+t8aPLgZlv4GTge4NIrUPmot3atSja+blkutWQY1gBIuTgPFDCNVc6WaU
         bAkh92kDCEVdK8TcJVx54eLi/XkMrwWCWdhcOaJNb9lAQHbtS3lnvtEGst/Ks++tG3H/
         a4FIwkEBn+Eav3P5r1gj+4dkfrg3D49rCctv05KFEZ8qTqaw+WoBl9g1IWEQDAnN/sOI
         HXuffmYod7pl8LUQneZZhuwGs7QBuRnto0rcrt+YuMOfG8Eeq+kBRlPhAD9HNDszqaV+
         VSwg==
X-Gm-Message-State: AJcUukcHS25EOBtXJ1ZQJ/NHAwJjnU/3dFpuvt4YBolTzrVfkz9AAar0
        ZsMw0DpK3U3r4EaezTGFwXkmPQ==
X-Google-Smtp-Source: ALg8bN7rpXGav+dYODwSoU2wNCw7ChIV9gDr9NTz+Es094wrvwWpTup3fl/CbO59pi+bwGV3Q6KLVA==
X-Received: by 2002:a5b:107:: with SMTP id 7mr7215248ybx.518.1547831522851;
        Fri, 18 Jan 2019 09:12:02 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:e09e])
        by smtp.gmail.com with ESMTPSA id t129sm2239884ywe.11.2019.01.18.09.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:12:02 -0800 (PST)
Date:   Fri, 18 Jan 2019 12:12:01 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        Andrea Righi <righi.andrea@gmail.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] cgroup: fsio throttle controller
Message-ID: <20190118171200.bxpvzeuwwiwpviet@macbook-pro-91.dhcp.thefacebook.com>
References: <20190118103127.325-1-righi.andrea@gmail.com>
 <20190118163530.w5wpzpjkcnkektsp@macbook-pro-91.dhcp.thefacebook.com>
 <F576C256-A032-4E62-99EA-F60162B6E069@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F576C256-A032-4E62-99EA-F60162B6E069@linaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 06:07:45PM +0100, Paolo Valente wrote:
> 
> 
> > Il giorno 18 gen 2019, alle ore 17:35, Josef Bacik <josef@toxicpanda.com> ha scritto:
> > 
> > On Fri, Jan 18, 2019 at 11:31:24AM +0100, Andrea Righi wrote:
> >> This is a redesign of my old cgroup-io-throttle controller:
> >> https://lwn.net/Articles/330531/
> >> 
> >> I'm resuming this old patch to point out a problem that I think is still
> >> not solved completely.
> >> 
> >> = Problem =
> >> 
> >> The io.max controller works really well at limiting synchronous I/O
> >> (READs), but a lot of I/O requests are initiated outside the context of
> >> the process that is ultimately responsible for its creation (e.g.,
> >> WRITEs).
> >> 
> >> Throttling at the block layer in some cases is too late and we may end
> >> up slowing down processes that are not responsible for the I/O that
> >> is being processed at that level.
> > 
> > How so?  The writeback threads are per-cgroup and have the cgroup stuff set
> > properly.  So if you dirty a bunch of pages, they are associated with your
> > cgroup, and then writeback happens and it's done in the writeback thread
> > associated with your cgroup and then that is throttled.  Then you are throttled
> > at balance_dirty_pages() because the writeout is taking longer.
> > 
> 
> IIUC, Andrea described this problem: certain processes in a certain group dirty a
> lot of pages, causing write back to start.  Then some other blameless
> process in the same group experiences very high latency, in spite of
> the fact that it has to do little I/O.
> 

In that case the io controller isn't doing it's job and needs to be fixed (or
reconfigured).  io.latency guards against this, I assume io.max would keep this
from happening if it were configured properly.

> Does your blk_cgroup_congested() stuff solves this issue?
> 
> Or simply I didn't get what Andrea meant at all :)
> 

I _think_ Andrea is talking about the fact that we can generate IO indirectly
and never get throttled for it, which is what blk_cgroup_congested() is meant to
address.  I added it specifically because some low prio task was just allocating
all of the memory on the system and causing a lot of pressure because of
swapping, but there was no direct feedback loop there.  blk_cgroup_congested()
provides that feedback loop.

Course I could be wrong too and we're all just talking past each other ;).
Thanks,

Josef
