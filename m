Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD41DC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6973720833
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 23:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="zmZuZPhb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6973720833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeGZBNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 21:13:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42549 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbeGZBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 21:13:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id z7-v6so3951220plo.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 16:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VSMJxf/6uVfYxcHQaf1S4C5watcXM8cOx6S+2yMNguA=;
        b=zmZuZPhbUF6K08BI3WE0sSA9HAH4gnvBzaFG/v18k1RkjWlTv2wFRc+Mit8+mUbdtw
         z+NEKmvhktknQRruec/KAHxE5R1NqEkjMMlkbTxU8TvFcfLrBQKO5VMjj2xBPwboVbgU
         AKUab7s9AbyAdWhC2S31AlR/xuCYaHmoNQjXTjvNSnCuu6W25rcVaSA9+fa1AXrNx3v6
         qGbTATlpKVRZk/EFSLYo1A1If4lbRWh4ty3I5NLVQpBISuk3ZaSJJIshoPh+uFK1ZAOh
         +lvH0SFn5tEUEksHdM1u82z6nleUGJvKbqzMu/UexTGTzcYjZtAh4i0qyke1B+kaH3v6
         XmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VSMJxf/6uVfYxcHQaf1S4C5watcXM8cOx6S+2yMNguA=;
        b=P4AaICEJLqTukHWScIkLgpFwfiRqfUfXFBfdN9z5suWKguMIl+iVjc4GDnHzRj7giF
         Lx1WhLrDc07LMgudhKXKs+ppUjts8lqRo/VmAzGyFFYvZNF+E1WgJdYtXSX+8m2HANNT
         x11WqbpFkgQyr5chR447UNKY8TNXOqRvW7ctfyK0qamIcbbg0lqy7zf3o87L1k8pF29l
         4UGIN/weOS5wKnFHiQu2ScxnAp3l92ysy9e1RfNvvcGq+WdcfZ3o7ESPsjUGolqA9NAM
         zlw3pWlI569l7p+SKvxh+bSULBNZygYm0hIn1XcSexYgodmd7wlrAIfTGmUifP20rmkG
         yPzg==
X-Gm-Message-State: AOUpUlEb5gImTtF0zZRtmArxsmA8K2dPbOI0dPhZbHeVxTO4+AdnFwew
        9wntNm8GllI7fnOi4r+CuCN6T+e+xXo=
X-Google-Smtp-Source: AAOMgpcjHMeCKBcFB+lgYtKo2RxBnN4601T1Dthk4I//DedqnpYou1OOtsFz01QsRKtpno50O2/3Bg==
X-Received: by 2002:a17:902:24e:: with SMTP id 72-v6mr17438952plc.74.1532563167527;
        Wed, 25 Jul 2018 16:59:27 -0700 (PDT)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1:8d38])
        by smtp.gmail.com with ESMTPSA id 65-v6sm23188753pfq.81.2018.07.25.16.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 16:59:27 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: [PATCH v4 0/9] /proc/kcore improvements
Date:   Wed, 25 Jul 2018 16:59:11 -0700
Message-Id: <cover.1532563124.git.osandov@fb.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

Hi,

This series makes a few improvements to /proc/kcore. It fixes a couple
of small issues in v3 but is otherwise the same. Patches 1, 2, and 3 are
prep patches. Patch 4 is a fix/cleanup. Patch 5 is another prep patch.
Patches 6 and 7 are optimizations to ->read(). Patch 8 makes it possible
to enable CRASH_CORE on any architecture, which is needed for patch 9.
Patch 9 adds vmcoreinfo to /proc/kcore.

Based on v4.18-rc6 + James' patch in the mm tree, and tested with crash
and readelf.

Thanks!

Changes from v3:

- Fixes a mixed up up_write() instead of up_read() in patch 5 reported
  by Tetsuo Handa
- Added patch 8 to fix a build failure reported by Stephen Rothwell

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

Omar Sandoval (9):
  proc/kcore: don't grab lock for kclist_add()
  proc/kcore: don't grab lock for memory hotplug notifier
  proc/kcore: replace kclist_lock rwlock with rwsem
  proc/kcore: fix memory hotplug vs multiple opens race
  proc/kcore: hold lock during read
  proc/kcore: clean up ELF header generation
  proc/kcore: optimize multiple page reads
  crash_core: use VMCOREINFO_SYMBOL_ARRAY() for swapper_pg_dir
  proc/kcore: add vmcoreinfo note to /proc/kcore

 fs/proc/Kconfig            |   1 +
 fs/proc/kcore.c            | 534 +++++++++++++++++--------------------
 include/linux/crash_core.h |   2 +
 include/linux/kcore.h      |   2 +-
 kernel/crash_core.c        |   6 +-
 5 files changed, 252 insertions(+), 293 deletions(-)

-- 
2.18.0

