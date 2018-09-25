Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07880C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BC72086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="iFRhY4jj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6BC72086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbeIYViS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:38:18 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]:41219 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbeIYViQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:38:16 -0400
Received: by mail-qk1-f174.google.com with SMTP id n3-v6so13242473qkn.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=fossXnE9DcMZSM5EBZ7fZb1nS+iEdBgGed53X3peolQ=;
        b=iFRhY4jj2b1wZt64GCHFbeJWUg971Xqn0aki+cWLNVkW1FFZNvqmj6B/33ZfrH3dWV
         jGwD9+fKnxgKS23X4dzYsqiB/e05IWt/jrtFCY+PlBPsQg6V7MQ9ihSMp7rbAuitCwbL
         OinPFC1wCDCRjbPo8UqY1ztvSjnNiCdaVvj1I6z+1ayB3tuUO1SA8A/IZ7/Nnh+epBRd
         Dr8Yi3hdQ2IVjoVPqh+y9wd7sHncsiosuJomQ/wcOy/+EY6J+gsR4ZWYWV5o9IX88r4X
         ffmzhdGi8+9EZRxgrP8IU0PDo/ciuEcrqV9ief3pN1eUlfcYFJrKnuLrl4Xb4OnC2VmO
         rdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=fossXnE9DcMZSM5EBZ7fZb1nS+iEdBgGed53X3peolQ=;
        b=kOag6HsZeu1bEGNjg9Q9MGM72137UEbqyLXXKqR+pL51vVE6ZU6REcmPgC2eYAPCKO
         +E0lCqzUVFHRpTBCKKhNkjo2pWFNKgsw68ZpZ1VxpaygJYxl1RZgIDXFkxJzPJvQfsN/
         gJjJrAcaA3SAgQYD3qT3iHupf8x+r6aV2tOcY5PE2ynVGnIUoDgI+KXQyhpxqshojUSS
         R5I84uVN4VslA8iE8I4919np2sYzFcmGX7zWB5k1D0FNp6K7ZSYFN06oDmz2RFRabmYP
         /YdftraVBk3+7GacJ8ZWm5C6wyqyrGZf3pzqWTHuHRXCmYKF2YEilZCWxEpog2RtwKit
         8hsg==
X-Gm-Message-State: ABuFfogo7jQUPiys9WnmfgjOsxgiZOlsj46DlujSi6XbfwTwvHS6IrOP
        EbMe5rzAbumYW0ysbwNi2Prjaw==
X-Google-Smtp-Source: ACcGV62kk8vRLoJr822RZ/P7cVu/XCIg4p5pl6cEfQRO9Blqa/qj+uVcejsv8CwAu7R17jp9koFUew==
X-Received: by 2002:a37:404d:: with SMTP id n74-v6mr1145825qka.312.1537889414512;
        Tue, 25 Sep 2018 08:30:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 72-v6sm1348539qkg.35.2018.09.25.08.30.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 08:30:13 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-btrfs@vger.kernel.org, riel@redhat.com,
        hannes@cmpxchg.org, tj@kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 0/8] drop the mmap_sem when doing IO in the fault path
Date:   Tue, 25 Sep 2018 11:30:03 -0400
Message-Id: <20180925153011.15311-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
