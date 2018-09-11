Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61306C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB19020892
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4qNmhHm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB19020892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbeIKXmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:42:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:33050 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbeIKXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:42:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id x67-v6so9623580ywg.0;
        Tue, 11 Sep 2018 11:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cthYTusIC3F998o2sCwn6eTrZTeOg4eiNVFHG8JI0Cc=;
        b=q4qNmhHmABvQHh0IXaG7j8Y/PpyIbXvW5MvlQ+NHEVXSl8vcA0U8Z4oQcKZhvsMNEO
         tszNZlb9s5JioNo665WuaWwpooSrBXerR2KH3Hl7DJbHg+IkCf0vD2BBcy2kCJDMuiH/
         hkjfyAWY9ealYB/5Nmc9ZEmoP47/uw8TLRDEO9uQGau6Vyppq53JTQvzOjojhfdbXklP
         uc8wbdKp9APwqXamhzeEg94zAI2NwL8JCeU4EpS3tsAPm3aPEup64J3MRe2zR8zJpigU
         6obWzEvQbJGXAT9Hdyh9C3z/4LWXI88UmdQFkH7Ofz0oaO6FZdmrPA6ambGBRxhJzwpX
         jL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cthYTusIC3F998o2sCwn6eTrZTeOg4eiNVFHG8JI0Cc=;
        b=qDSzohtXxWo8Yn+9/4lCNG7BoaIF8WM4oIZHh2a8V3RxGUYA5fAhUH/l5/MsFMphOz
         uVIKWEh7X9ajfI6Bx8Zz1bjCCXTqeK3W69xPE3uCnzCir0HH8VhrC2z2riT5wN2wUEmp
         FrEq2vt9L//MYXFTxHy+VMOKwSsmIlyRqtXPV0mf2+3MK6GwP645HvP08Mg3flbg288e
         De8JYqPQWRrT2NHgX5+aZtts+3rkils6IBLh+x02g7M6iGR94FhsHh7OZp8et0e/9Tq7
         ewxlF/EghyVoRSwlSLSATTV7X5CLR/LJu99q89nVR0ZWnvKxQMFs6w3UY3bLbbs81YbX
         AnLg==
X-Gm-Message-State: APzg51DMMcaZ19LA3ABi6xCmlCu+l0QutAxb7cJqCCLZ0evyqBWmsyEv
        GGErJW9nf1lRXDrR/uU5ZEA=
X-Google-Smtp-Source: ANB0VdZbaupFbRWpMVw8pHZKotHg5yKHKsQaLOHf+4Jw2jMdUaItIt4CjJ2vvx+oy6RALPNC/O5f0g==
X-Received: by 2002:a81:717:: with SMTP id 23-v6mr11492850ywh.290.1536691302061;
        Tue, 11 Sep 2018 11:41:42 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id i123-v6sm7902875ywe.14.2018.09.11.11.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:41:40 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH v3 00/12] block: always associate blkg and refcount cleanup
Date:   Tue, 11 Sep 2018 14:41:25 -0400
Message-Id: <20180911184137.35897-1-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

v3: a few minor fixes.
  0003: Updated the comment to bio_associate_blkg to reflect closest
        association.
        Removed a return branch in __bio_lookup_create.
  0009: Removed an unnecessary rcu_read_(un)lock pair.
  0010: Fixed blkg null pointer... blkg->blkcg => blkcg.

This is rebased onto axboe#for-4.20/block 902d53914f64.

From v2 below (updated):
------
This is a followup to the patch series I sent out earlier [1] containing
the middle two points:
  1. always associate a bio with a blkg
  2. remove the extra css ref held by bios and utilize the blkg ref

The major difference with v2 is that error handling on blkg creation
and association failure is handled more gracefully. Rather than having
the complex logic to fallback to root, failures walk up the blkg tree.
This seems more natural and less prone to error with the many possible
failure scenarios.

Additionally, there are fixes for kbuild errors and some key details
overlooked by me in the first series that were pointed out in review.

Modified from the first patchset:
First, both blk-throttle and blk-iolatency rely on blkg association
to enable their policies. Rather than each policy (and future policies)
implement this logic independently, this consolidates it such that
all bios are tagged with a blkg.

Second, with the addition of always having a blkg reference, the blkcg
can now be referenced through it rather than maintaining an additional
pointer and reference. So let's clean this up.

[1] https://lore.kernel.org/lkml/20180831015356.69796-1-dennisszhou@gmail.com/T

This patchset contains the following 12 patches:
  0001-blkcg-fix-ref-count-issue-with-bio_blkcg-using-task_.patch
  0002-blkcg-update-blkg_lookup_create-to-do-locking.patch
  0003-blkcg-convert-blkg_lookup_create-to-find-closest-blk.patch
  0004-blkcg-always-associate-a-bio-with-a-blkg.patch
  0005-blkcg-consolidate-bio_issue_init-to-be-a-part-of-cor.patch
  0006-blkcg-associate-a-blkg-for-pages-being-evicted-by-sw.patch
  0007-blkcg-associate-writeback-bios-with-a-blkg.patch
  0008-blkcg-remove-bio-bi_css-and-instead-use-bio-bi_blkg.patch
  0009-blkcg-remove-additional-reference-to-the-css.patch
  0010-blkcg-cleanup-and-make-blk_get_rl-use-blkg_lookup_cr.patch
  0011-blkcg-change-blkg-reference-counting-to-use-percpu_r.patch
  0012-blkcg-rename-blkg_try_get-to-blkg_tryget.patch

This patchset is on top of axboe#for-4.20/block 902d53914f64.

diffstats below:

Dennis Zhou (Facebook) (12):
  blkcg: fix ref count issue with bio_blkcg using task_css
  blkcg: update blkg_lookup_create to do locking
  blkcg: convert blkg_lookup_create to find closest blkg
  blkcg: always associate a bio with a blkg
  blkcg: consolidate bio_issue_init to be a part of core
  blkcg: associate a blkg for pages being evicted by swap
  blkcg: associate writeback bios with a blkg
  blkcg: remove bio->bi_css and instead use bio->bi_blkg
  blkcg: remove additional reference to the css
  blkcg: cleanup and make blk_get_rl use blkg_lookup_create
  blkcg: change blkg reference counting to use percpu_ref
  blkcg: rename blkg_try_get to blkg_tryget

 Documentation/admin-guide/cgroup-v2.rst |   8 +-
 block/bfq-cgroup.c                      |   4 +-
 block/bfq-iosched.c                     |   2 +-
 block/bio.c                             | 158 ++++++++++++++++--------
 block/blk-cgroup.c                      | 123 ++++++++++++------
 block/blk-iolatency.c                   |  26 +---
 block/blk-throttle.c                    |  13 +-
 block/bounce.c                          |   4 +-
 block/cfq-iosched.c                     |   4 +-
 drivers/block/loop.c                    |   5 +-
 drivers/md/raid0.c                      |   2 +-
 fs/buffer.c                             |  10 +-
 fs/ext4/page-io.c                       |   2 +-
 include/linux/bio.h                     |  23 ++--
 include/linux/blk-cgroup.h              | 145 +++++++++++++++-------
 include/linux/blk_types.h               |   1 -
 include/linux/cgroup.h                  |   2 +
 include/linux/writeback.h               |   5 +-
 kernel/cgroup/cgroup.c                  |  48 +++++--
 kernel/trace/blktrace.c                 |   4 +-
 mm/page_io.c                            |   2 +-
 21 files changed, 381 insertions(+), 210 deletions(-)

Thanks,
Dennis
