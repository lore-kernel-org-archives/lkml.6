Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75372218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545405754;
	bh=O4r6FouiHpN1oc92s4hE456i7S7Lw9M9t+lIYNIYrW0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=F+47GoBZyKt63fMZGxTuxrlSOoIcw8Fcj5XyG+nojiwQSg8YjPoL0RYgQpvDsFaiw
	 C2JHhUuvpx0E3OY+CojQbG9Ats3H+s5T79p5gfDgPNpPRFM6tzsw7lmpMGJceJJL1b
	 DwITHxQapGnW3/vIisyLFYpPjZOLXT0C5lwk+Zgo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391017AbeLUPWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 10:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391004AbeLUPV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 10:21:29 -0500
Received: from localhost.localdomain (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15D1B21917;
        Fri, 21 Dec 2018 15:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545405688;
        bh=O4r6FouiHpN1oc92s4hE456i7S7Lw9M9t+lIYNIYrW0=;
        h=From:To:Cc:Subject:Date:From;
        b=KKpIviM9TvsCpVPJgsYE8x32R5Bh3LD3a82xN4RN01iedPJuiAXOqIvjiKWquREzO
         1yUua29SGfHUs7YT+THrwpFgOG3v/6Xpfb5dqEGAcS8NLHZW86LaFQQtQQl8gk0tVe
         jX3wT5Srn9UTA52Zm7xsqbYLK0XHaR6r42CpB5YE=
From:   Tom Zanussi <zanussi@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc:     rostedt@goodmis.org, tglx@linutronix.de, C.Emde@osadl.org,
        jkacur@redhat.com, bigeasy@linutronix.de,
        daniel.wagner@siemens.com, julia@ni.com
Subject: [PATCH RT 0/9] Linux 3.18.129-rt111-rc1
Date:   Fri, 21 Dec 2018 09:21:12 -0600
Message-Id: <cover.1545347029.git.tom.zanussi@linux.intel.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Hello RT Folks!

This is the RT stable review cycle of patch 3.18.129-rt111-rc1.

Please scream at me if I messed something up. Please test the
patches too.

The -rc release will be uploaded to kernel.org and will be
deleted when the final release is out. This is just a review
release (or release candidate).

The pre-releases will not be pushed to the git repository,
only the final release is.

If all goes well, this patch will be converted to the next
main release on 12/24/2018.

To build 3.18.129-rt111-rc1 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz

  http://www.kernel.org/pub/linux/kernel/v3.x/patch-3.18.129.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/patch-3.18.129-rt111-rc1.patch.xz


You can also build from 3.18.129-rt110 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/3.18/incr/patch-3.18.129-rt110-rt111-rc1.patch.xz

Enjoy!
   
   Tom

Changes from v3.18.129-rt110:
---
Daniel Bristot de Oliveira (1):
  sched/core: Avoid __schedule() being called twice in a row

Kurt Kanzenbach (1):
  tty: serial: pl011: explicitly initialize the flags variable

Lukas Wunner (1):
  pinctrl: bcm2835: Use raw spinlock for RT compatibility

Sebastian Andrzej Siewior (5):
  efi: Allow efi=runtime
  efi: Disable runtime services on RT
  crypto: cryptd - add a lock instead preempt_disable/local_bh_disable
  work-simple: drop a shit statement in SWORK_EVENT_PENDING
  drm/i915: disable tracing on -RT

Tom Zanussi (1):
  Linux 3.18.129-rt111-rc1

 crypto/cryptd.c                   | 18 ++++++++----------
 drivers/firmware/efi/efi.c        |  5 ++++-
 drivers/gpu/drm/i915/i915_trace.h |  4 ++++
 drivers/pinctrl/pinctrl-bcm2835.c | 16 ++++++++--------
 drivers/tty/serial/amba-pl011.c   |  2 +-
 kernel/sched/core.c               |  9 +++++++--
 kernel/sched/work-simple.c        |  2 +-
 localversion-rt                   |  2 +-
 8 files changed, 34 insertions(+), 24 deletions(-)

-- 
2.14.1

