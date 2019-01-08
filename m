Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2151C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50C214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:04:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729530AbfAHVEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:04:46 -0500
Received: from namei.org ([65.99.196.166]:55064 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbfAHVEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:04:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x08L4cE0025412;
        Tue, 8 Jan 2019 21:04:38 GMT
Date:   Wed, 9 Jan 2019 08:04:38 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] seccomp: build fix for v5.0-rc2
Message-ID: <alpine.LRH.2.21.1901090803120.24546@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull this fix for a build regression in seccomp.

The following changes since commit 7b55851367136b1efd84d98fea81ba57a98304cf:

  fork: record start_time late (2019-01-08 09:40:53 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git fixes-v5.0-rc1

for you to fetch changes up to cba54b44d0be4eb66dbc7709e1f3f0d65e851f69:

  samples/seccomp: fix 32-bit build (2019-01-08 13:00:00 -0800)

----------------------------------------------------------------

Tycho Andersen (1):
      samples/seccomp: fix 32-bit build

 samples/seccomp/Makefile | 1 +
 1 file changed, 1 insertion(+)

---

commit cba54b44d0be4eb66dbc7709e1f3f0d65e851f69
Author: Tycho Andersen <tycho@tycho.ws>
Date:   Mon Jan 7 14:46:34 2019 -0700

    samples/seccomp: fix 32-bit build
    
    Both the .o and the actual executable need to be built with -m32 in order
    to link correctly.
    
    Fixes: fec7b6690541 ("samples: add an example of seccomp user trap")
    
    Signed-off-by: Tycho Andersen <tycho@tycho.ws>
    Reported-by: Ingo Molnar <mingo@kernel.org>
    Signed-off-by: James Morris <james.morris@microsoft.com>

diff --git a/samples/seccomp/Makefile b/samples/seccomp/Makefile
index 4920903c8009..a5607668a5c7 100644
--- a/samples/seccomp/Makefile
+++ b/samples/seccomp/Makefile
@@ -37,6 +37,7 @@ HOSTCFLAGS_bpf-fancy.o += $(MFLAG)
 HOSTLDLIBS_bpf-direct += $(MFLAG)
 HOSTLDLIBS_bpf-fancy += $(MFLAG)
 HOSTLDLIBS_dropper += $(MFLAG)
+HOSTLDLIBS_user-trap.o += $(MFLAG)
 HOSTLDLIBS_user-trap += $(MFLAG)
 endif
 always := $(hostprogs-m)
