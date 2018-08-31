Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09720C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50FF2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZZjRUqY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B50FF2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeIAAcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:32:21 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:40339 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeIAAcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:32:21 -0400
Received: by mail-yw1-f66.google.com with SMTP id z143-v6so5495415ywa.7;
        Fri, 31 Aug 2018 13:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mCSyTNKfNKsNWY9w2u1+8RMVPIGW7DHIDC+leU6W8m8=;
        b=TZZjRUqYnoro5nUsjPf4UN65TUPobFhe4ZygsrYrMZsdBT8kXARk8ydRzJl1CDvRlS
         o+1t6T8YeZmEIECE+Od52gLZvTiX89eIn7xwepHE5n3plMboWl3vXM+hj1ViKIG0crH9
         TW8X6BgfTkiTWBXaJziBZiv+UxF1FYxS07PgHlynQG1heAYrfX1u7PZ2PevhvWlxsinh
         NSh9hm2HhRdZKfD66dEof/OzDNZtagZyvgCQ+vXDA3j+AGSWROafB1MOSoshXy1bA7P8
         baEisqpwl+R5vtdE9zpy6j8X9dP8/+jFCaEfutFQmvUSajV+KIGDNgTzTRCnn/H0cReI
         mYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mCSyTNKfNKsNWY9w2u1+8RMVPIGW7DHIDC+leU6W8m8=;
        b=NbeAfiFKP1ify9NRR4OaD0b8uVlcJlfwQ00r2pLdX20xXNXl0SyMY+f70ohf4jDCe9
         u4GyAGd5HCoqeH9qOaMpmEidKNk/UNUL9OIAiQTJbEJpA7yH9CqTbizIWj9Nss1rwNxy
         pxDExu3mN5wsCV/SdYEHXAOIs2jL9PKBW6m47+tdFU4EJI4VjCakAYXuSSHS4sjN0wfE
         GDQ89c6UAE4s00EMhJ2oFQAqV7D/FXCfgBvvaPTilhDdGiMFqM7vJTnkcTqyQ2My/aVx
         n/yzEeuMsYkqLFDIdq/23dOd1730HbFrcTFfd3K796I8Wa/XaV5e+PMrAn0FSZjWF3wY
         WA8g==
X-Gm-Message-State: APzg51CnjyKD63lyd1nmTKGuTF6YHMMy0bmA6Qp213Gx53OsPqLji1Gb
        S0k10iQtGB/979N7cv3Ztw4=
X-Google-Smtp-Source: ANB0VdZZPmhsWluisMIlRBklk6Lqltpx+Z+sbpekC4v0geeEM2PqMwngm8YLLyq7y+stnMI2bzda1Q==
X-Received: by 2002:a81:5c04:: with SMTP id q4-v6mr9668554ywb.465.1535746994936;
        Fri, 31 Aug 2018 13:23:14 -0700 (PDT)
Received: from dennisz-mbp.thefacebook.com ([199.201.65.129])
        by smtp.gmail.com with ESMTPSA id u8-v6sm3978961ywl.59.2018.08.31.13.23.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:23:14 -0700 (PDT)
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 0/3] fix blkcg offlining and destruction
Date:   Fri, 31 Aug 2018 16:22:41 -0400
Message-Id: <20180831202244.21678-1-dennisszhou@gmail.com>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This is a split of an earlier series I sent out [1] containing the first
3 patches with fixes from feedback. This series tackles the first
problem where blkcgs were not being destroyed.

There is a regression in blkcg destruction where references weren't
properly put causing blkcgs to never be destroyed. Previously, blkgs
were destroyed during offlining of the blkcg. This puts back the blkcg
reference a blkg holds allowing blkcg ref to reach zero. Then,
blkcg_css_free() is called as part of the final cleanup.

To address the problem, 0001 reverts the broken commit, 0002 delays
blkg destruction until writeback has finished, and 0003 closes the
window on a race condition between a css migration and dying, and
blkg association. This should fix the issue where blkg_get() was getting
called when a blkcg had already begun exiting. If a bio finds itself
here, it will just fall back to root. Oddly enough at one point,
blk-throttle was using policy data from and associating with potentially
different blkgs, thus how this was exposed.

[1] https://lore.kernel.org/lkml/20180831015356.69796-1-dennisszhou@gmail.com/T

This patchset contains the following 3 patches:
  0001-Revert-blk-throttle-fix-race-between-blkcg_bio_issue.patch
  0002-blkcg-delay-blkg-destruction-until-after-writeback-h.patch
  0003-blkcg-use-tryget-logic-when-associating-a-blkg-with-.patch

0001 reverts the broken commit.
0002 delays blkg destruction until after writeback.
0003 fixes a race condition for ongoing IO and blkcg destruction.

This patchset is on top of axboe#for-4.19/block b86d865cb1ca.

diffstats below:

Dennis Zhou (Facebook) (3):
  Revert "blk-throttle: fix race between blkcg_bio_issue_check() and
    cgroup_rmdir()"
  blkcg: delay blkg destruction until after writeback has finished
  blkcg: use tryget logic when associating a blkg with a bio

 block/bio.c                |   3 +-
 block/blk-cgroup.c         | 105 +++++++++++++++++--------------------
 block/blk-throttle.c       |   5 +-
 include/linux/blk-cgroup.h |  45 +++++++++++++++-
 mm/backing-dev.c           |   5 ++
 5 files changed, 102 insertions(+), 61 deletions(-)

Thanks,
Dennis
