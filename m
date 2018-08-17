Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C19C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640F8213A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 13:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="OtiZsblM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640F8213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeHQQHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 12:07:49 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36198 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbeHQQHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 12:07:49 -0400
Received: by mail-yb0-f194.google.com with SMTP id d34-v6so1893010yba.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aac5Gm9TQQkSyYqATQFmTCaoOMMkRsihgXdj1y0MZos=;
        b=OtiZsblMVy9ij4AVKGz73RvZsz9fpyEfp91t6viXYTzJ16rSUShEoEi70GV/2AG1NL
         rnz0tbi/zojUEc8iq06IMBkcEt4USlvY13ivlB6BesauDPUzgIfHkun/9Wy82ty8RSGp
         Y/lp/nQ6VeW154zdoQvhOHqqBzwEYW0rCFWO080EVbm23XmI+AXF3qLmq/cR1kqYg5GV
         YqwfLCiijolLFX6OFTKjE8fp7VVlVClG9gcDqXLLKWP1oxQVkhK50cyPpAcQhgCfZg4c
         FdkJxhqOQoQNMxkC5a7GbehJUNhojPjbMNXZL1IeICyXY4YjpPpcftysqpnqFDjKWV4m
         mGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aac5Gm9TQQkSyYqATQFmTCaoOMMkRsihgXdj1y0MZos=;
        b=BLOmDWbaUJJ//avzqK/S+BJUECiq3gpOhyl6AVWmH2FGngONfnI22a4ctY3tVVX/EY
         FhMZVYUql7S3bPviZl4+aApTqfQDWeK86iOUrFcZ91RF8ibJgymfnYnXHDNLFyJsAZLf
         nVe/PKokkSHSG0QusIhEZ9/4dyj22cn9kWh8oHS7T2H6TeVp9MnAlC4NCWTe9HBrBlw7
         n7/zXbnVxkR47E1zu65Y6Q9KswHpuhSjY/pGdiNtipOp9g4DFtIcbQL8fViqx9TQGifV
         fM4KjZ4UMkDm5wTdBMOhmSITnC7LH4t7haAAElEccSgGqKbdlSDsxBiMGop0cN7YAsZZ
         HI+g==
X-Gm-Message-State: AOUpUlHLracZDK4SKEA2SM+QL0m/lOr1hP2WILmFSIZSKo5XCS3TmeuG
        zcImTVCQb4YuLGBKvARX85DnBA==
X-Google-Smtp-Source: AA+uWPyDQSHzQFEPOujywyFsXCoAdcfvmhjO3fq/VU+xLUqpls4yfl6YIQ82a5af623YaWFNczXiFA==
X-Received: by 2002:a25:384c:: with SMTP id f73-v6mr11951670yba.196.1534511067683;
        Fri, 17 Aug 2018 06:04:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:df3])
        by smtp.gmail.com with ESMTPSA id w8-v6sm1090180ywa.12.2018.08.17.06.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Aug 2018 06:04:26 -0700 (PDT)
Date:   Fri, 17 Aug 2018 09:04:25 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 0/2] Directed kmem charging
Message-ID: <20180817130425.GA12351@cmpxchg.org>
References: <20180627191250.209150-1-shakeelb@google.com>
 <20180815152511.3ea63aa54c5fac0bfe9370da@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815152511.3ea63aa54c5fac0bfe9370da@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 03:25:11PM -0700, Andrew Morton wrote:
> On Wed, 27 Jun 2018 12:12:48 -0700 Shakeel Butt <shakeelb@google.com> wrote:
> 
> > The Linux kernel's memory cgroup allows limiting the memory usage of
> > the jobs running on the system to provide isolation between the jobs.
> > All the kernel memory allocated in the context of the job and marked
> > with __GFP_ACCOUNT will also be included in the memory usage and be
> > limited by the job's limit.
> > 
> > The kernel memory can only be charged to the memcg of the process in
> > whose context kernel memory was allocated. However there are cases where
> > the allocated kernel memory should be charged to the memcg different
> > from the current processes's memcg. This patch series contains two such
> > concrete use-cases i.e. fsnotify and buffer_head.
> > 
> > The fsnotify event objects can consume a lot of system memory for large
> > or unlimited queues if there is either no or slow listener. The events
> > are allocated in the context of the event producer. However they should
> > be charged to the event consumer. Similarly the buffer_head objects can
> > be allocated in a memcg different from the memcg of the page for which
> > buffer_head objects are being allocated.
> > 
> > To solve this issue, this patch series introduces mechanism to charge
> > kernel memory to a given memcg. In case of fsnotify events, the memcg of
> > the consumer can be used for charging and for buffer_head, the memcg of
> > the page can be charged. For directed charging, the caller can use the
> > scope API memalloc_[un]use_memcg() to specify the memcg to charge for
> > all the __GFP_ACCOUNT allocations within the scope.
> 
> This patchset is not showing signs of having been well reviewed at
> this time.  Could people please take another look?

I don't have the mailing list archives for this anymore, but the
series as it stands in mmots looks good to me and incorporates all the
feedback I remember giving.

[ My only gripe really is that it applies current->active_memcg only
  to kmem charges, not others as well. Right now it doesn't matter,
  but I can see this costing a kernel developer implementing remote
  charges for something other than kmem some time to realize. ]

Anyway, please feel free to add

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

for 1/2 and 2/2 plus their two fixlets.
