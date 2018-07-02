Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB54C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7005C25CB5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 21:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="tUkUYaHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7005C25CB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753502AbeGBViK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 17:38:10 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45712 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbeGBViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 17:38:07 -0400
Received: by mail-qk0-f195.google.com with SMTP id c192-v6so3244783qkg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 14:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rNZTdXKNgd4DiZiSOzPVfrG0K73j5tDkUo1zVyqSojY=;
        b=tUkUYaHLKdf7Tsevh6QA6mn++CVR9OY+CjYWAbiLViTlfDBF5fRLdC9o4eRQRFKDj+
         x7P/+4xuOVkd+RqPVwsyqjFMZuUQuYYGtch33eCbyAnTrwi9ypGz/+wRevvd0UagOotY
         BxAV/nTgvGgpd4XXbtNg21glgOXtSIh/A2anmKwrxFIxA44i0Ke1ALIA/8syVCgpTqTA
         rAVzZJIefdmjVdjwZeo3LFweXZzvjvyTTC+biYxSBmkTfPjHsPJM+hYB+qN2ZYty8awE
         GurUycujqUkFdIF8s/JSwsxEx4V8PAC9kYdURc7EZigeiOq0T7GkAgu4j5pce4pcByUH
         3iaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rNZTdXKNgd4DiZiSOzPVfrG0K73j5tDkUo1zVyqSojY=;
        b=BLDpBTsh/AIaQ5mZA73pyWnFyMb+cXH/Nz6b6vDHEV3Db3LT2oLOoqAgnPrnira1Hj
         TWSY+A+NfUvjqMv6Y7jj3RJS1O/KgHJyPz4mFhvvRJzEJXpI7m54Xn/+CJSiqdi2bvOW
         fkSRtuIOFez1f/TLlE61YnQH7rdmvcAH98VsQPZq9GNEOz18sMWb5Dl+0uBh5DFkxu2s
         i7eBIpj0K6HEpK+BhVgeb8K8otV1hGd5nuCBowP/vFAHM1Ew+KNtt2yZxNRe29FUbM5W
         FfUlnw4pHQQ1+iOG5ItkCozYCc05RnkaXVWbetSt2K0nDALGPo3scTobFR6m/iaugahw
         66Ew==
X-Gm-Message-State: APt69E35OK/fVjFY5+w9hHx2qFO0lGpem/15U3LT5DX7stOENRSyK6Ah
        IdYwqw+bwY8fahha41hUREHIkw==
X-Google-Smtp-Source: AAOMgpe7Mn2DFnyGQ9MQKRWa860+FKPZ+QwMPFlCpeCbijmVDkxLt/pgccbS2D0kZtXxO2Rp08wJaA==
X-Received: by 2002:ae9:ef42:: with SMTP id d63-v6mr15033559qkg.99.1530567487138;
        Mon, 02 Jul 2018 14:38:07 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q15-v6sm6324735qtl.39.2018.07.02.14.38.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 14:38:06 -0700 (PDT)
Date:   Mon, 2 Jul 2018 17:38:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, axboe@kernel.dk,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/14][V5] Introduce io.latency io controller for cgroups
Message-ID: <20180702213804.vcfr4auvunpkd2ky@destiny>
References: <20180629192542.26649-1-josef@toxicpanda.com>
 <20180702142639.752759da566fd9074cf8edfe@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702142639.752759da566fd9074cf8edfe@linux-foundation.org>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 02:26:39PM -0700, Andrew Morton wrote:
> On Fri, 29 Jun 2018 15:25:28 -0400 Josef Bacik <josef@toxicpanda.com> wrote:
> 
> > This series adds a latency based io controller for cgroups.  It is based on the
> > same concept as the writeback throttling code, which is watching the overall
> > total latency of IO's in a given window and then adjusting the queue depth of
> > the group accordingly.  This is meant to be a workload protection controller, so
> > whoever has the lowest latency target gets the preferential treatment with no
> > thought to fairness or proportionality.  It is meant to be work conserving, so
> > as long as nobody is missing their latency targets the disk is fair game.
> > 
> > We have been testing this in production for several months now to get the
> > behavior right and we are finally at the point that it is working well in all of
> > our test cases.  With this patch we protect our main workload (the web server)
> > and isolate out the system services (chef/yum/etc).  This works well in the
> > normal case, smoothing out weird request per second (RPS) dips that we would see
> > when one of the system services would run and compete for IO resources.  This
> > also works incredibly well in the runaway task case.
> > 
> > The runaway task usecase is where we have some task that slowly eats up all of
> > the memory on the system (think a memory leak).  Previously this sort of
> > workload would push the box into a swapping/oom death spiral that was only
> > recovered by rebooting the box.  With this patchset and proper configuration of
> > the memory.low and io.latency controllers we're able to survive this test with a
> > at most 20% dip in RPS.
> 
> Is this purely useful for spinning disks, or is there some
> applicability to SSDs and perhaps other storage devices?  Some
> discussion on this topic would be useful.
> 

Yes we're using this on SSDs and spinning rust, it would work on all storage
devices, you just have to adjust your latency targets accordingly.

> Patches 5, 7 & 14 look fine to me - go wild.  #14 could do with a
> couple of why-we're-doing-this comments, but I say that about
> everything ;)
> 

So that one was fun.  Our test has the main workload going in the protected
group, and all the system specific stuff in an unprotected group and then we run
a memory hog in the system group.  Obviously this results in everybody dumping
all caches first, including pages for the binaries themselves.  Then when the
applications go to run they incur a page fault, which trips readahead.  If we're
throttling this means we'll sit in the page fault handler for a good long while.
Who cares right?  Well apparently the main workload cares, because it talks to
some daemon about the current memory on the system so it can make intelligent
adjustments on its allocation strategies.  The daemon it talks to also gathers a
bunch of other statistics, and does things like 'ps' which goes and walks
/proc/<pid>, which has entries that wait on mmap_sem.  So suddenly being block
in readahead means we have weird latency spikes because we're holding the
mmap_sem the whole time.  So instead we want to just skip readahead so we are
getting throttled as little as possible while holding our mmap_sem.

The inflight READA bio's also need to be aborted, and I have a patch for that as
well, but it depends on Jens' READA abort patches that he's still working on, so
that part will come after his stuff is ready.  Thanks,

Josef
