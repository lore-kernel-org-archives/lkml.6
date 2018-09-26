Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08F9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365BA2157C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cf0UqgF5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365BA2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeI0DXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:23:50 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42654 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeI0DXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:23:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id z8-v6so470044qto.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=3SZMKRYMVmDdRPjAvl+mIDUi0cvHC1rXOW2VG9ITyAY=;
        b=cf0UqgF5vjizMzXoCoy5s9HUKhdGw0IoCF3VyKpHVIjPWKPFgjoc1HJC7VLl39IoKl
         2BPgi6+mlIfE1dZSZ4hDJFTW2kWTFI/vj9bly3PC3kXOU+oOkNjEvv5h57YcKixZ5dFP
         ZKioL3FKLxdFbmsNT964T+bKw0MTjj0qEnP71rvruambf7dCedyENzfjmr3CAaYCocan
         0KKg57epUNSVvVmSZ9XPHhqjeJuyScPsDrbe0xvYDKdrspP4WeLb5cwIJ9jfTEUGpugP
         O2ADcCrG3RumxPRoQfJTIvoufAC2rkU5qzOQR4921VmXJkNnAD24e4PshryVUqKW3Gtq
         Ztmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=3SZMKRYMVmDdRPjAvl+mIDUi0cvHC1rXOW2VG9ITyAY=;
        b=rpHP4v33WXLOK+WsHSOBAf+KF5OcgRupWOk5vWbmEe04rJRbL4MWKSUMngeopm6mBY
         Be4YKWorSpJlOCAu+WUuBhi7BOhf4JUYlool6H0myMsQvrrgscMkP75VJejVnNkBHC9p
         XkyMGW3s2JfsWGwixSI/qcemA/MRpZ005NggLAhl8H6z1jyyL1og+KPPozaqBbLqa8V/
         aRmaiUcNIn3GXQxDXvVg+N54RLLOR4Xt1O84pRaBFP7TcNa0JV+nayi1D6cqgwQJZnIm
         3rEAfvQQPuthY4Ww9iw6PhwxqnBqS4Y+iFLFbVi4ukuv+CS3dZYEExHV6FFG0kK9EMk5
         HRvA==
X-Gm-Message-State: ABuFfoiY0sstZ2EgbCl0FbHPjoUpOTU/R5SuJaaQTDxEtO2XnRXFuTRQ
        Mz58xe7xuaz1H9d+wZdDt5unJw==
X-Google-Smtp-Source: ACcGV62M6+hEbeqHqVou90I4+huN9MbHVcT7hhBEGLDMQSmUWN0TB4fl/YOjB8uW0onQoW2aCQZr5w==
X-Received: by 2002:ac8:3097:: with SMTP id v23-v6mr6132402qta.335.1537996139508;
        Wed, 26 Sep 2018 14:08:59 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id h37-v6sm65854qtb.37.2018.09.26.14.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:08:58 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        hannes@cmpxchg.org, tj@kernel.org, linux-fsdevel@vger.kernel.org,
        akpm@linux-foundation.org, riel@redhat.com, linux-mm@kvack.org,
        linux-btrfs@vger.kernel.org
Subject: [RFC][PATCH 0/9][V2] drop the mmap_sem when doing IO in the fault path
Date:   Wed, 26 Sep 2018 17:08:47 -0400
Message-Id: <20180926210856.7895-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
- reworked so it only affects x86, since its the only arch I can build and test.
- fixed the fact that do_page_mkwrite wasn't actually sending ALLOW_RETRY down
  to ->page_mkwrite.
- fixed error handling in do_page_mkwrite/callers to explicitly catch
  VM_FAULT_RETRY.
- fixed btrfs to set ->cached_page properly.

This time I've verified that the ->page_mkwrite retry path is actually getting
used (apparently I only verified the read side last time).  xfstests is still
running but it passed the couple of mmap tests I ran directly.  Again this is an
RFC, I'm still doing a bunch of testing, but I'd appreciate comments on the
overall strategy.

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
