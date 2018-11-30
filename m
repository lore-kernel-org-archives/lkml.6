Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1154FC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC77020868
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 19:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="fEy2NaYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC77020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeLAHIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 02:08:39 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:33337 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeLAHIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 02:08:38 -0500
Received: by mail-yb1-f194.google.com with SMTP id i78-v6so2717031ybg.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 11:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=PSn0bxnnPw1G6B2a7cVzIfLJVlFidqA8+Pvk6v+1aiU=;
        b=fEy2NaYeMxMp1Hq2S7PhoxSh/LDDhDKvP8zB3Ay4gdoNmcGr/6dbHB29QyFPZEzimV
         HuOnJ7LskXah/9WQTv8RA7PiIYIizvu90YJvz7X8ixder70S2hh4KUUAraP3ritYHo9s
         aotbttHU4BGLaaGz2Xu/XYjRQrd1keQKVclG4RRB6nScr2o0VO4K1lU7z4RHC5rnNqMk
         15Gm72ymcOvWYyaWBYz9mUB38XCdujjWr5GU/2jYOUekBqpSNJZwqQXMAL00kIcFfH6j
         AYZXxugRkgD+SAgjxr6UEYP9R/HF2iK6/oYXY1TYyE4kj3rdB7iH2mdHHKz4U7gpiuFk
         XcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=PSn0bxnnPw1G6B2a7cVzIfLJVlFidqA8+Pvk6v+1aiU=;
        b=cLRbMS8Rbw7VpNGWjFc2c1r4RPmpr79yOk0GtEZqj2w//Pw40rp1fKOJYsEpMD8ZlD
         r2mOdgPc6vXdfJKtBPIjX3Od5jybDvUH+wX4vsWgisSdO2/38dY7Vu6/DZW07kM6+qs7
         cQAB2K78ZY3n1ZcriZALn0q2FB9QZ5KICw4tDo224gl1EKlwk4URMvW1rFsjbawQodQs
         WRTEQGnp+CcnrCVwKWs1vEBZQOwt5qBXa9deL3EcReIC8bfnCOTinMDkJA7VRU18E8v5
         0kXjS1qeCt4lmHwb2CNJTdxDjONna3tNrMER7RV6rnMh/hM+F0FJNGtv7Qlr1AMLj4Fr
         bViQ==
X-Gm-Message-State: AA+aEWbKK5sy/OdoqvYs9QxvTp6ybzuYeMP4tNMLTLs66eWmz8+xwHnU
        MvEq2NOuEQ3+fG0gpFxJ/3N3IQ==
X-Google-Smtp-Source: AFSGD/VYUsl2xVUvkGxx4jdNiTF2u/FWco0LPBBw3S6Limd4QOomlBu0SvVfkGyqLl2fy0XYdgdLWA==
X-Received: by 2002:a25:844e:: with SMTP id r14-v6mr6679151ybm.298.1543607894605;
        Fri, 30 Nov 2018 11:58:14 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id z74sm3209138ywz.51.2018.11.30.11.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 11:58:13 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 0/4][V4] drop the mmap_sem when doing IO in the fault path
Date:   Fri, 30 Nov 2018 14:58:08 -0500
Message-Id: <20181130195812.19536-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3->v4:
- dropped the ->page_mkwrite portion of these patches, we don't actually see
  issues with mkwrite in production, and I kept running into corner cases where
  I missed something important.  I want to wait on that part until I have a real
  reason to do the work so I can have a solid test in place.
- completely reworked how we drop the mmap_sem in filemap_fault and cleaned it
  up a bit.  Once I started actually testing this with our horrifying reproducer
  I saw a bunch of places where we still ended up doing IO under the mmap_sem
  because I had missed a few corner cases.  Fixed this by reworking
  filemap_fault to only return RETRY once it has a completely uptodate page
  ready to be used.
- lots more testing, including production testing.

v2->v3:
- dropped the RFC, ready for a real review.
- fixed a kbuild error for !MMU configs.
- dropped the swapcache patches since Johannes is still working on those parts.

v1->v2:
- reworked so it only affects x86, since its the only arch I can build and test.
- fixed the fact that do_page_mkwrite wasn't actually sending ALLOW_RETRY down
  to ->page_mkwrite.
- fixed error handling in do_page_mkwrite/callers to explicitly catch
  VM_FAULT_RETRY.
- fixed btrfs to set ->cached_page properly.

-- Original message --

Now that we have proper isolation in place with cgroups2 we have started going
through and fixing the various priority inversions.  Most are all gone now, but
this one is sort of weird since it's not necessarily a priority inversion that
happens within the kernel, but rather because of something userspace does.

We have giant applications that we want to protect, and parts of these giant
applications do things like watch the system state to determine how healthy the
box is for load balancing and such.  This involves running 'ps' or other such
utilities.  These utilities will often walk /proc/<pid>/whatever, and these
files can sometimes need to down_read(&task->mmap_sem).  Not usually a big deal,
but we noticed when we are stress testing that sometimes our protected
application has latency spikes trying to get the mmap_sem for tasks that are in
lower priority cgroups.

This is because any down_write() on a semaphore essentially turns it into a
mutex, so even if we currently have it held for reading, any new readers will
not be allowed on to keep from starving the writer.  This is fine, except a
lower priority task could be stuck doing IO because it has been throttled to the
point that its IO is taking much longer than normal.  But because a higher
priority group depends on this completing it is now stuck behind lower priority
work.

In order to avoid this particular priority inversion we want to use the existing
retry mechanism to stop from holding the mmap_sem at all if we are going to do
IO.  This already exists in the read case sort of, but needed to be extended for
more than just grabbing the page lock.  With io.latency we throttle at
submit_bio() time, so the readahead stuff can block and even page_cache_read can
block, so all these paths need to have the mmap_sem dropped.

The other big thing is ->page_mkwrite.  btrfs is particularly shitty here
because we have to reserve space for the dirty page, which can be a very
expensive operation.  We use the same retry method as the read path, and simply
cache the page and verify the page is still setup properly the next pass through
->page_mkwrite().

I've tested these patches with xfstests and there are no regressions.  Let me
know what you think.  Thanks,

Josef
