Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8306EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3638020875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMP14NhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3638020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937318AbeFSFNo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:13:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37745 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937236AbeFSFNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:13:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so10277625plc.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=isp0D7fOHm2B+eMegAVDPCkhp4suKkoR3rfaJmek6NA=;
        b=WMP14NhHdhEEe1tr3TYy4Fh5PUDmWJwERjLvnD7kYaPUNW/EM057iCQl2VBgsu1bhi
         nXxleeEcUiYLziOmfPbQ3XBANbGx8Cb/Pjhs007nO90wothgdcc8SoAL3JonBg7PXYGi
         GYuk1Kt2c6Uu+cKpfcwGQGurMCtNKjrYYQUcYnmfmegT0982350lv7OSB+xCP5B4GXM9
         7IqhmY8O/uFjEzk05BByqyvD9TIuFbbdlgHlsw1siWXngcX7hzabe0HFTJcg8DuXfZ9N
         XbXujiMBhcNAFOstQTyTm026k6XijzBRfD5BPQoA+kHxLxPru3NDtXCXdzsqeuGLfWI1
         R04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=isp0D7fOHm2B+eMegAVDPCkhp4suKkoR3rfaJmek6NA=;
        b=eb9v1KtKwquDeByWkRAoE+dm+oK00AtQZ6mHiMhoBODZgwfw0ft1FQRYLiP7rSbOpR
         m76yrIm0G7GpW5IPj6JO8VOaP0M2Vbihbgi6SxXWJjMqHxLXJ0mY2OYzNPvQ5yWBUcfQ
         YDE65U/ecuixd02OHCQlwfdPr0cwDUhnGl3M24CJUBnK4DcK+2R/A355XqAzJTuvwsHH
         LrsxMdI4GlpQ1mDXh1lVr43zeJPTJCM75z1FZd9EAmH/lZTJ1Asp5zSWQ8L17DimbBfu
         KqasQHLphgL8KxbL35kOuPJ5h86GzFBHNNTKF+XARdCgw5IF+6+hsiFWqN0tC/5B2ndr
         fGNQ==
X-Gm-Message-State: APt69E0LQ8HKL7gj3eFTk6QM91SeSYEHbhR1zzBztU9KzEpZ/+4y+bQZ
        2YafksPdE8N5hpS1aQ95BNXG/w==
X-Google-Smtp-Source: ADUXVKLJY6zQyEauVQy9GxiaFAFe8H9+ib1Zv1bqZYFtyJScPbES9NGqfJaxoVZuctYHq6C8Iy9gEQ==
X-Received: by 2002:a17:902:a9:: with SMTP id a38-v6mr17416687pla.102.1529385221337;
        Mon, 18 Jun 2018 22:13:41 -0700 (PDT)
Received: from shakeelb.mtv.corp.google.com ([2620:15c:2cb:201:3a5f:3a4f:fa44:6b63])
        by smtp.gmail.com with ESMTPSA id a23-v6sm28390504pfj.117.2018.06.18.22.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 22:13:39 -0700 (PDT)
From:   Shakeel Butt <shakeelb@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jan Kara <jack@suse.com>, Greg Thelen <gthelen@google.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>
Subject: [PATCH v6 0/3] Directed kmem charging
Date:   Mon, 18 Jun 2018 22:13:24 -0700
Message-Id: <20180619051327.149716-1-shakeelb@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces memcg variant memory allocation functions.  The
caller can explicitly pass the memcg to charge for kmem allocations.
Currently the kernel, for __GFP_ACCOUNT memory allocation requests,
extract the memcg of the current task to charge for the kmem allocation.
This patch series introduces kmem allocation functions where the caller
can pass the pointer to the remote memcg.  The remote memcg will be
charged for the allocation instead of the memcg of the caller.  However
the caller must have a reference to the remote memcg.  This patch series
also introduces scope API for targeted memcg charging. So, all the
__GFP_ACCOUNT alloctions within the specified scope will be charged to
the given target memcg.

Shakeel Butt (3):
  mm: memcg: remote memcg charging for kmem allocations
  fs: fsnotify: account fsnotify metadata to kmemcg
  fs, mm: account buffer_head to kmemcg

 fs/buffer.c                          | 14 ++++-
 fs/notify/dnotify/dnotify.c          |  5 +-
 fs/notify/fanotify/fanotify.c        |  6 +-
 fs/notify/fanotify/fanotify_user.c   |  5 +-
 fs/notify/group.c                    |  6 ++
 fs/notify/inotify/inotify_fsnotify.c |  2 +-
 fs/notify/inotify/inotify_user.c     |  5 +-
 include/linux/fsnotify_backend.h     | 12 ++--
 include/linux/memcontrol.h           | 14 +++++
 include/linux/sched.h                |  3 +
 include/linux/sched/mm.h             | 24 ++++++++
 include/linux/slab.h                 | 83 ++++++++++++++++++++++++++++
 kernel/fork.c                        |  3 +
 mm/memcontrol.c                      | 54 ++++++++++++++++--
 14 files changed, 220 insertions(+), 16 deletions(-)

-- 
2.18.0.rc1.244.gcf134e6275-goog

