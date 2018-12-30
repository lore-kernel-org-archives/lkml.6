Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A42220866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 10:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TR5+a22G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbeL3Kvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 05:51:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37857 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbeL3Kvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 05:51:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id g67so22704831wmd.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Dec 2018 02:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JWUjwjywYT2HDBx5N8qmoy30zOVUTve1VvW97XaZME0=;
        b=TR5+a22G4DK3TdVY/a9lONJV3eU/i6KEe0oE/NFsgSSd7Nz/3uq3eML35KbE7/F2Xl
         f2al7iIKLdRM2gYk2zxcE3aCSF+qtWzgjpxBD327FET7zkarbwOaua63+LCBUVpivIlB
         o0GdQPK6Krqt5eB7Cj5HYhCrKL5Xlv/GVCsd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JWUjwjywYT2HDBx5N8qmoy30zOVUTve1VvW97XaZME0=;
        b=ezLeBUiruFJdLRy93YLQcmgNfXj75NtfczK/UAYR0TRpflBSUimfCaDDDZrjftvDhi
         /eAERB3k92hXCjT0E1aW9znIxagdiVoLrkxEBl2zm1rzAINuMXQxKXiEkBkM4ShXR/Uq
         afXVp95R5dvtv3XAzanwmxwXHaqs9YsBFaOmEZbm73XmYdBDIVFMbJfnBQe7qYPa9PiJ
         2nwmbWnM4/n6bRP3BCK4kq3lxUPBJ44Dtx3wm4BE67JccVTn1r22WtoAX6Kk5Bwkr0nr
         wNbyU9+w9c6HGOfOsDhQT8a2GAN8ftT//ekxcjhfeMGDLEKGjFGJXGyFRc4KV3qeuD0g
         cO4w==
X-Gm-Message-State: AA+aEWbXBRZMfy5Q3afnamRZ8ZEoeoMPjPA/VJScRV++nl4QKcFOKqcB
        PDqEeck3aDkS0wHC/ddnt3gOH1x4SFuKSw==
X-Google-Smtp-Source: ALg8bN5QCndsCj1+fv6kEk3yLZS+xBnKqINNHWTy3gagTXeKrr5FX8i7Rr+q5o+H9ZU+UFlA8I9WJw==
X-Received: by 2002:a1c:b687:: with SMTP id g129mr28265309wmf.59.1546167094937;
        Sun, 30 Dec 2018 02:51:34 -0800 (PST)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id v8sm46357582wrq.53.2018.12.30.02.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Dec 2018 02:51:33 -0800 (PST)
Date:   Sun, 30 Dec 2018 10:51:31 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [GIT PULL] kgdb changes v4.21-rc1
Message-ID: <20181230105131.GA30811@wychelm.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

Happy new year!


The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-4.21-rc1

for you to fetch changes up to cc0282975b3f887005c380adcf0af95915f0c1bb:

  kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops (2018-12-30 08:33:06 +0000)

----------------------------------------------------------------
kgdb patches for 4.20-rc1

Mostly clean ups although whilst Doug's was chasing down a odd
lockdep warning he also did some work to improved debugger resilience
when some CPUs fail to respond to the round up request.

The main changes are:

 * Fixing a lockdep warning on architectures that cannot use an NMI for
   the round up plus related changes to make CPU round up and all CPU
   backtrace more resilient.

 * Constify the arch ops tables

 * A couple of other small clean ups

Two of the three patchsets here include changes that spill over into
arch/.  Changes in the arch space are relatively narrow in scope
(and directly related to kgdb). Didn't get comprehensive acks but
all impacted maintainers were Cc:ed in good time.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Christophe Leroy (2):
      mips/kgdb: prepare arch_kgdb_ops for constness
      kgdb/treewide: constify struct kgdb_arch arch_kgdb_ops

Douglas Anderson (4):
      kgdb: Remove irq flags from roundup
      kgdb: Fix kgdb_roundup_cpus() for arches who used smp_call_function()
      kgdb: Don't round up a CPU that failed rounding up before
      kdb: Don't back trace on a cpu that didn't round up

Nicholas Mc Guire (1):
      kdb: use bool for binary state indicators

 arch/arc/kernel/kgdb.c          | 12 ++------
 arch/arm/kernel/kgdb.c          | 14 +--------
 arch/arm64/kernel/kgdb.c        | 14 +--------
 arch/h8300/kernel/kgdb.c        |  2 +-
 arch/hexagon/kernel/kgdb.c      | 34 +--------------------
 arch/microblaze/kernel/kgdb.c   |  2 +-
 arch/mips/kernel/kgdb.c         | 25 +++++-----------
 arch/nios2/kernel/kgdb.c        |  2 +-
 arch/powerpc/kernel/kgdb.c      |  8 ++---
 arch/sh/kernel/kgdb.c           | 14 +--------
 arch/sparc/kernel/kgdb_32.c     |  2 +-
 arch/sparc/kernel/kgdb_64.c     |  2 +-
 arch/sparc/kernel/smp_64.c      |  2 +-
 arch/x86/kernel/kgdb.c          | 11 ++-----
 include/linux/kgdb.h            | 24 +++++++++------
 kernel/debug/debug_core.c       | 65 ++++++++++++++++++++++++++++++++++++++++-
 kernel/debug/debug_core.h       |  1 +
 kernel/debug/kdb/kdb_bt.c       | 11 ++++++-
 kernel/debug/kdb/kdb_debugger.c |  7 -----
 kernel/debug/kdb/kdb_main.c     | 14 ++++-----
 20 files changed, 125 insertions(+), 141 deletions(-)
