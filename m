Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6C5ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C30742075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 23:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="Z7SF3rPQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30742075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbeGRXjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 19:39:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44224 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbeGRXjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 19:39:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so2683596pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=puGNKRsOXkoHQ9ds45nPp7QSAjYJXFwGCuaji0Ojm3E=;
        b=Z7SF3rPQ4If5dZMRhFiLeelm43qr3VGM+/nRQ66BVea2XMGeyFKdAD7fxrm+kS3mJ/
         g+mGzXgZH9isnyIStt+MMdrnJSjwrRne1jNl4TSQPACNwkR+Cxfg2GjsPTpGNr9W+sc5
         2EfOAoGAKf366nZZGZp+7PJkm10TFH05sG21IIugaKezL4vSMgIq4mOfo8wKDY6X/O4O
         cNG/aGtid8DjiMot3T7SS+xr9iJSmcVx/4gz0RUknexAwljslIPIoAmLsAiAVf/4AyMA
         YKzZeVDExNqiWhzJVhzx6xwk9Uz5Jo/SX5r3rXaUSPbH6lUcYGSvC8jWcogGhinFNCZ3
         x1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=puGNKRsOXkoHQ9ds45nPp7QSAjYJXFwGCuaji0Ojm3E=;
        b=VgGj5OORi7t2e1SUzslEk53ooDLWvpPKTvn8nwVSU0+FPhJdRGgrvyal1ugpzKpBO0
         uLstDAhrA16h+VYppr61zJUG/O72N+rcf393W43e8nxxhCcR+sOk5eUIwbXRJNhY7XJA
         ROS2GiMwxlXvRgr69Mrohh1orgIWDFSjdI3hmKT/3vwdDXSlBQiiKvbduZKWEfsQP9fz
         1jSdNLIKUHRI5KgGHmJDKnW/f4O0eIArrOxY9eqfgv/jZcKgyFLOcBgiqa/rVCMK1jyC
         IxsBLQ11jo/NxYmMzgGfD2GZc3re3qKhDX/1hbr9HdRM55lLJUVMO7QobO781QzLVuqS
         ++1Q==
X-Gm-Message-State: AOUpUlFTTu4Us+hN0PV6Q5oqa1I085XKmW1vWjXUuRldEs4hMJ7XAqCn
        m81rWuV4PwDi4TSsMZoqbGkmH6Yhhg0=
X-Google-Smtp-Source: AAOMgpfAINobzfZj7i34F5XCRF5IkOwVCVUvMkjrlq8drquIWCCPBwAjHD3Vxmza+slL0rv+3sdqEg==
X-Received: by 2002:a17:902:48c8:: with SMTP id u8-v6mr7737779plh.152.1531954753354;
        Wed, 18 Jul 2018 15:59:13 -0700 (PDT)
Received: from vader.hsd1.wa.comcast.net ([2601:602:8800:a9a9:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s16-v6sm6377946pfm.114.2018.07.18.15.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 15:59:12 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v3 0/8] /proc/kcore improvements
Date:   Wed, 18 Jul 2018 15:58:40 -0700
Message-Id: <cover.1531953780.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series makes a few improvements to /proc/kcore. Patches 1, 2, and 3
are prep patches. Patch 4 is a fix/cleanup. Patch 5 is another prep
patch. Patches 6 and 7 are optimizations to ->read(). Patch 8 adds
vmcoreinfo to /proc/kcore.

Again, based on v4.18-rc4 + James' patch in the mm tree, and tested with
crash and readelf.

Thanks!

Changes from v2:

- Add __init to kclist_add() as per Andrew
- Got rid of conversion of kcore_need_update from int to atomic_t and
  just used xchg() instead of atomic_cmpxchg() (split out into a new
  patch instead of combining it with the rwlock -> rwsem conversion)
- Add comment about the increase in file size to patch 8

Changes from v1:

- Rebased onto v4.18-rc4 + James' patch
  (https://patchwork.kernel.org/patch/10519739/) in the mm tree
- Fix spurious sparse warning (see the report and response in
  https://patchwork.kernel.org/patch/10512431/)

Omar Sandoval (8):
  proc/kcore: don't grab lock for kclist_add()
  proc/kcore: don't grab lock for memory hotplug notifier
  proc/kcore: replace kclist_lock rwlock with rwsem
  proc/kcore: fix memory hotplug vs multiple opens race
  proc/kcore: hold lock during read
  proc/kcore: clean up ELF header generation
  proc/kcore: optimize multiple page reads
  proc/kcore: add vmcoreinfo note to /proc/kcore

 fs/proc/Kconfig            |   1 +
 fs/proc/kcore.c            | 534 +++++++++++++++++--------------------
 include/linux/crash_core.h |   2 +
 include/linux/kcore.h      |   2 +-
 kernel/crash_core.c        |   4 +-
 5 files changed, 251 insertions(+), 292 deletions(-)

-- 
2.18.0

