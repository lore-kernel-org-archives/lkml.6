Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DBBC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A932086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="vOKL819r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A932086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbeLKRiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:38:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33096 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbeLKRiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:38:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id q11so5779144ywa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 09:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=TqxTYYL678habTdU2pMfSU1dK9Ap6pTHGuRGBvTv1I4=;
        b=vOKL819ri/0ZFDVzSa9awoHdgDpkol8NKXosA/YMYh7+LcCtNQihvtDe7BEj3is1yZ
         Kxor6NV7VcXhtKu/AgNNSbNc7p4I+5Z7OjnQSsTynBjY5idkKMgtyx3dnYDyPne+LuO7
         IrVmfsZezyFy9iQIPFq6huRUR0ltDEEaxKmBswGIMmdpT5whFM1eSHDKwu9542lr4eOF
         1myZf04jVmRfz5iROSVLd0NEO+PJzAfGn0/m68ImvZ/elZZTtQkvWlQEJmu4rEeSOBj8
         UTdiKwMGm5hL/B5tpA2CJnhWW5+XrjRm3EKazFhE3O67YXRDEKwdjNTuGvCio7ErriMm
         Dq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TqxTYYL678habTdU2pMfSU1dK9Ap6pTHGuRGBvTv1I4=;
        b=ZwDI9MEQvxtgh3XQ2kG+GRmmEpmGVUIZSf/SoJ0Su2NDCuGkcZU8Gv90NvUXD+2UoQ
         ESgxR7+gplpj/YIOyk5VYaC9Z/x3l+LSKc2Y8TgrulzMtw6aII6Ps3rxSw+a/2Xi38GX
         7HpHd3WTBsY6HxyTz1YUgThc6HG/vNsRytF9liO1piYg/RCE0I8unCZF0DVdCWokBb/p
         Hmcl9+AJCtRF7UcEKnUgZSsQAbw9HeoIsfKLuX69xEomE2jezQcEMSR4xoJ9FcaXsYR+
         YqbS+0mI64axUhH1MCA20SYIcgi90JLDD+O4KTxcaDp4eO/wyrvzpfNcvljxyiohpQy3
         YpYA==
X-Gm-Message-State: AA+aEWYPUa3NKDPT9li7+xg1HH5HcN2gDwHhXPdz23i/hz1R7Znood7I
        eWw51P5JWiHZat+yuhV/6j0zUg==
X-Google-Smtp-Source: AFSGD/XomaM/Mo7pPyxnXqFG9XSwFtveYlG3CDEZ/MYoH51XeWiL7okZe7yzhc7olWc2SMNr/VdkSg==
X-Received: by 2002:a81:ac56:: with SMTP id z22mr18220920ywj.40.1544549885863;
        Tue, 11 Dec 2018 09:38:05 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id d138sm6079424ywb.44.2018.12.11.09.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 09:38:04 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, tj@kernel.org, david@fromorbit.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, riel@redhat.com, jack@suse.cz
Subject: [PATCH 0/3][V5] drop the mmap_sem when doing IO in the fault path
Date:   Tue, 11 Dec 2018 12:37:58 -0500
Message-Id: <20181211173801.29535-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's the latest version, slimmed down a bit from my last submission with more
details in the changelogs as requested.

v4->v5:
- dropped the cached_page infrastructure and the addition of the
  handle_mm_fault_cacheable helper as it had no discernable bearing on
  performance in my performance testing.
- reworked the page lock dropping logic in order to be it's own helper, which
  comments describing how to use it.
- added more details to the changelog for the fpin patch.
- added a patch to cleanup the arguments for the readahead functions for mmap as
  per Jan's suggestion.

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
