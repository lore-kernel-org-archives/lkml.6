Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CF9ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312572147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="R7hFe/+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312572147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387761AbeGMAVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:21:44 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45677 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387715AbeGMAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:21:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id i26-v6so10110882pfo.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GoYn5IW+7n9rQqNM8JicsfZ+kT4nG9MwtzrX55SnyFE=;
        b=R7hFe/+bqrESIOPCIiArXF+53J3w5blMcmcP7MFn6brg3Ry4U8AWvoxKUZ/dTBq6a8
         UA0DGWh+sqdzgzE9KgwuaB7wG+6Gq4w7EUDyj9wzPkU3q8WlNWG4oz1vzmgSlE8TIIGF
         E2NuiKL6LqopBLlufdfx2YM79WqqWSudzMrtL+CKUIlM82dn376J5IGrTfuMdEpsbcSV
         gV7wZWipkEeswxaCHS9Vn1hv+a2teyKAIqQLuPOpu8DThCdgK8hxq2iwqmlhtCUzYOs0
         RRwndEz7790vBalXfJGLLj/1Rmam+DYe48xjN68jTHvLRIePda3lbUefLofn/ubmebKP
         FrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GoYn5IW+7n9rQqNM8JicsfZ+kT4nG9MwtzrX55SnyFE=;
        b=L9tCkpplmmrqvpxYGd30vc+wYeSqFGmu3ajvPqehx0sEKGC1AFz1xak+fXN1+8LCBt
         aBGpbuNTZelS6REAyOUoqVuWOmhJdLU/PfZs/P4zCrOlA1NZ8gcTnJU0j+wuOL1BLa+9
         JSMQ+6Ocz4IzU0eMzA4TUjtucZPu8ghFztLZgUFzjiGM6+t9rCk+cXgULplY5l1U23TK
         AgNgaqhUOLv4yre9mEM2rjSyk8RIPgP7aSRcxzjg21+i2yvOVvxh/MhSqGvHqbyneHiZ
         6HTFv1g3roBDCiiJ61ZbsVHLvo61dlDNOoSoY3jnMGxL4uFQL4m6aszMj3jNCV9Lf1pl
         q0OA==
X-Gm-Message-State: AOUpUlEjqk7Oa7FyoSSNsD/wyibqLBOToDG/xR5K4VBuE+gyLaImNXw0
        rlowyR6B6kp5JD5f3sVZam++9cbHUUM=
X-Google-Smtp-Source: AAOMgpewfC+Q+J+2Y9YVey7v8CVVk8uScZ/BVm9UWEhN6smwk2LxlXdOz67fcO+NxyHiYkMPq2xWkw==
X-Received: by 2002:a62:e30c:: with SMTP id g12-v6mr4584365pfh.25.1531440585820;
        Thu, 12 Jul 2018 17:09:45 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:200::5:74a0])
        by smtp.gmail.com with ESMTPSA id b86-v6sm4452067pfj.35.2018.07.12.17.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:09:45 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v2 0/7] /proc/kcore improvements
Date:   Thu, 12 Jul 2018 17:09:32 -0700
Message-Id: <cover.1531440458.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series makes a few improvements to /proc/kcore. Patches 1 and 2 are
prep patches. Patch 3 is a fix/cleanup. Patch 4 is another prep patch.
Patches 5 and 6 are optimizations to ->read(). Patch 7 adds vmcoreinfo
to /proc/kcore (apparently I'm not the only one who wants this, see
https://www.spinics.net/lists/arm-kernel/msg665103.html).

I tested that the crash utility still works with this applied, and
readelf is happy with it, as well.

Andrew, since this didn't get any traction on the fsdevel side, and
you're already carrying James' patch, could you take this through -mm?

Thanks!

Changes from v1:

- Rebased onto v4.18-rc4 + James' patch
  (https://patchwork.kernel.org/patch/10519739/) in the mm tree
- Fix spurious sparse warning (see the report and response in
  https://patchwork.kernel.org/patch/10512431/)

Omar Sandoval (7):
  proc/kcore: don't grab lock for kclist_add()
  proc/kcore: replace kclist_lock rwlock with rwsem
  proc/kcore: fix memory hotplug vs multiple opens race
  proc/kcore: hold lock during read
  proc/kcore: clean up ELF header generation
  proc/kcore: optimize multiple page reads
  proc/kcore: add vmcoreinfo note to /proc/kcore

 fs/proc/Kconfig            |   1 +
 fs/proc/kcore.c            | 536 +++++++++++++++++--------------------
 include/linux/crash_core.h |   2 +
 kernel/crash_core.c        |   4 +-
 4 files changed, 251 insertions(+), 292 deletions(-)

-- 
2.18.0

