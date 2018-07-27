Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C28C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737F720842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 21:57:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 737F720842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389974AbeG0XVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 19:21:03 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52364 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389719AbeG0XVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 19:21:03 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fjAjW-0006WX-Kw; Fri, 27 Jul 2018 23:57:10 +0200
Date:   Fri, 27 Jul 2018 23:57:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v4.16.18-rt11
Message-ID: <20180727215710.zq6gkoqzlb4ca7qv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v4.16.18-rt11 patch set. 

Changes since v4.16.18-rt10:

  - Finally fix the SIMD locking on arm64.

  - Revert the srcu based notifier in crypto code. This is no longer
    required since the rwsem on RT allows multiple reader.

  - Add a per-CPU lock in crypto's cryptd per-CPU queue. Reported by
    Mike Galbraith.

  - Add a per-CPU lock in crypto's scompress code. Patch by Mike
    Galbraith.

  - Disable runtime EFI services on ARM64. It can be enabled again via
    command line. The getTime function needs around 10ms to complete on
    one of my machines. The setVariable might take even longer. It is
    disabled by default, it can be enabled via `efi=runtime' on the
    command line.

Known issues
     - A warning triggered in "rcu_note_context_switch" originated from
       SyS_timer_gettime(). The issue was always there, it is now
       visible. Reported by Grygorii Strashko and Daniel Wagner.

The delta patch against v4.16.18-rt10 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/incr/patch-4.16.18-rt10-rt11.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v4.16.18-rt11

The RT patch against v4.16.18 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patch-4.16.18-rt11.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/4.16/older/patches-4.16.18-rt11.tar.xz

Sebastian
