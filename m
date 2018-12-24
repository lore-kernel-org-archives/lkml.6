Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E0C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AEE721848
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545690349;
	bh=H7oMRCS5dNQIKmln4ee+Fx3705RG7ikF0B3BvvO89P4=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lXYgIEWWBlEwaHt//xYvPjD0LPsZOmmEXOaHAbkcMPh5gOmagJQpQ+EZtgZ3rZ3ym
	 Eyj9BsvYjn65XU9DK3zVxAmGUk1p39YXKdPAlkxJ8b3FnDkQaa2RnGmsUwd4tpWWma
	 JXKGVmUIXZZ/NxmvBRvb85kc/OlJaIfIjTSM4Rys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbeLXWZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:25:47 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40850 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:25:47 -0500
Received: by mail-wm1-f51.google.com with SMTP id f188so12642888wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=F7dxlr8+0srjMc9zB+Qe8XMULZd9DNjjaBJDTK5jFVU=;
        b=Bfq9BX8/x0nHNQqFMRy/iwWolEK+496MVvmqRtwSpIjoVbsv1UvbYLsNK/c8BOJkMZ
         9+DK7EnnReAkcz3b1Qghypm28ioCpO+WIR/DxpuLs8WQFfrBRCZz8yOeY0Heuk3D3KXX
         lJRStFjmacI/PRBZkfSmYXjGTAxid+zeWpv54C21ADFV154HS1+JNkaLSGpy3Kx4jPhm
         FWMGpzMA8VKVci09dsUVK/xAq2rCuBk+bKS2zGr3V7aP9vzbAmKP2/8tLDBgeQuK1+dn
         Ab5Aty8UyN8VOvJZs0msNzz3cybg9VWOgwzETEv4ZjYTNIFeoF6y4peYhg/d1L58/Xtq
         ZVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=F7dxlr8+0srjMc9zB+Qe8XMULZd9DNjjaBJDTK5jFVU=;
        b=EWNlNPuub0fnFUh2ImdZvQ7Zf4ucPWHJNzrvOEMA4OBeyCFZh5hFX8QvjJ3+s/011x
         DH+rmDbi5qK3QHYs0gQADZfJJmKk02HdHyfJTh2SqGQj5npPMQy8OndtPy80Kc6mMpa1
         nPkPAX8xbp3/pws2S/tKm71KqU0nyB7JdvaVk0rY2MrYDPGng0ELj+lsKKbvG/GlU9pD
         bDeWz1k9NQzdfnzXVJwJp41t0t0UqixCPUPayWIEIfw0RIpqNT1hvWQiJylxbvSlLgpZ
         8d6Pjh7dUrm65A5LvntXOuDja1cHgRDLu2PiJJ4R8h5lJIrPlMfeRwdqlsI0ajYYiNl9
         4QVQ==
X-Gm-Message-State: AJcUukdbhL56/p8PzAA/IGIkSr4JQqepiDNquWC/9+9tiP2TTn1ErTeX
        u2zvbM8ADrYVZBvKByISBVxITqW7
X-Google-Smtp-Source: ALg8bN7HOFYY0SQhT0VOsISHmuqyx4NEK4fMfDgXdPuu+toEgxaxBonE25my8ajzJJplHDGoeHM8Ng==
X-Received: by 2002:a1c:8302:: with SMTP id f2mr14051875wmd.9.1545690344374;
        Mon, 24 Dec 2018 14:25:44 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q9sm16247453wrv.26.2018.12.24.14.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 14:25:43 -0800 (PST)
Date:   Mon, 24 Dec 2018 23:25:41 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [GIT PULL] locking changes for v4.21
Message-ID: <20181224222541.GA1945@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest locking-core-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-for-linus

   # HEAD: 80eb865768703c0f85a0603762742ae1dedf21f0 sched/fair: Clean up comment in nohz_idle_balance()

The main change in this cycle are initial preparatory bits of dynamic 
lockdep keys support from Bart Van Assche. There's also misc changes, a 
comment cleanup and a data structure cleanup.

 Thanks,

	Ingo

------------------>
Andrea Parri (1):
      sched/fair: Clean up comment in nohz_idle_balance()

Bart Van Assche (13):
      tools/lib/lockdep/tests: Display compiler warning and error messages
      tools/lib/lockdep/tests: Fix shellcheck warnings
      tools/lib/lockdep/tests: Improve testing accuracy
      tools/lib/lockdep/tests: Run lockdep tests a second time under Valgrind
      tools/lib/lockdep: Rename "trywlock" into "trywrlock"
      tools/lib/lockdep: Add dummy print_irqtrace_events() implementation
      tools/lib/lockdep/tests: Test the lockdep_reset_lock() implementation
      locking/lockdep: Declare local symbols static
      locking/lockdep: Inline __lockdep_init_map()
      locking/lockdep: Introduce lock_class_cache_is_registered()
      locking/lockdep: Remove a superfluous INIT_LIST_HEAD() statement
      locking/lockdep: Make concurrent lockdep_reset_lock() calls safe
      locking/lockdep: Stop using RCU primitives to access 'all_lock_classes'

Waiman Long (1):
      locking/lockdep: Remove ::version from lock_class structure


 include/linux/lockdep.h                       |  2 -
 kernel/locking/lockdep.c                      | 76 +++++++++++++++------------
 kernel/sched/fair.c                           |  4 +-
 tools/lib/lockdep/include/liblockdep/common.h |  1 +
 tools/lib/lockdep/include/liblockdep/mutex.h  |  1 +
 tools/lib/lockdep/include/liblockdep/rwlock.h |  6 +--
 tools/lib/lockdep/lockdep.c                   |  5 ++
 tools/lib/lockdep/run_tests.sh                | 39 +++++++++-----
 tools/lib/lockdep/tests/AA.sh                 |  2 +
 tools/lib/lockdep/tests/ABA.sh                |  2 +
 tools/lib/lockdep/tests/ABBA.c                |  3 ++
 tools/lib/lockdep/tests/ABBA.sh               |  2 +
 tools/lib/lockdep/tests/ABBA_2threads.sh      |  2 +
 tools/lib/lockdep/tests/ABBCCA.c              |  4 ++
 tools/lib/lockdep/tests/ABBCCA.sh             |  2 +
 tools/lib/lockdep/tests/ABBCCDDA.c            |  5 ++
 tools/lib/lockdep/tests/ABBCCDDA.sh           |  2 +
 tools/lib/lockdep/tests/ABCABC.c              |  4 ++
 tools/lib/lockdep/tests/ABCABC.sh             |  2 +
 tools/lib/lockdep/tests/ABCDBCDA.c            |  5 ++
 tools/lib/lockdep/tests/ABCDBCDA.sh           |  2 +
 tools/lib/lockdep/tests/ABCDBDDA.c            |  5 ++
 tools/lib/lockdep/tests/ABCDBDDA.sh           |  2 +
 tools/lib/lockdep/tests/WW.sh                 |  2 +
 tools/lib/lockdep/tests/unlock_balance.c      |  2 +
 tools/lib/lockdep/tests/unlock_balance.sh     |  2 +
 26 files changed, 131 insertions(+), 53 deletions(-)
 create mode 100644 tools/lib/lockdep/tests/AA.sh
 create mode 100644 tools/lib/lockdep/tests/ABA.sh
 create mode 100644 tools/lib/lockdep/tests/ABBA.sh
 create mode 100644 tools/lib/lockdep/tests/ABBA_2threads.sh
 create mode 100644 tools/lib/lockdep/tests/ABBCCA.sh
 create mode 100644 tools/lib/lockdep/tests/ABBCCDDA.sh
 create mode 100644 tools/lib/lockdep/tests/ABCABC.sh
 create mode 100644 tools/lib/lockdep/tests/ABCDBCDA.sh
 create mode 100644 tools/lib/lockdep/tests/ABCDBDDA.sh
 create mode 100644 tools/lib/lockdep/tests/WW.sh
 create mode 100644 tools/lib/lockdep/tests/unlock_balance.sh

