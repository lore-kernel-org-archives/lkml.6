Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4DBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922A321721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EnGWdxvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBGWEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:04:42 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54511 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBGWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:04:41 -0500
Received: by mail-pf1-f202.google.com with SMTP id t72so925755pfi.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 14:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5JLckgKkr76wjKMwFcPTZOX/ShIJHQQgUEe+KdEi75o=;
        b=EnGWdxvRGKR1ZVhkEmElViQRj8gpZT2njMXkACv/O5+o/VViTgBfPMHVGHWWd2xOL0
         ITDUdq7sZY/JjiZ3vAACRuzxBzZc9/a0CPInO0eMh2esiMo0Q2Eakunyyna2T2PUFK0g
         wEpf1qG+O893d9ibpt3uZ2yLpy7FTqpN+fhWOaES3AVzUDgYxlWurgeP5ZXsxxVaw5Ve
         gPnSXv6AdZf45oMDeqS/ayGapoXb6LUC5grf5xU3DRrk8vzpFaelsxyG25zbYgaGnbWe
         Htlx7pGqoEnoCN+tWl8gLWAvVQ8cqMgUYuCMpPaeAmYKAgjhgG5btE3N+XoP8YWuV2uD
         mFGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5JLckgKkr76wjKMwFcPTZOX/ShIJHQQgUEe+KdEi75o=;
        b=otPo6sb5Q117YuH5xeddMiNEXeDuIcjmVKFYnwxkflBzej3bIJjlU3A/bJ9svllPrj
         LDYodHgvYJBq5QbWEx5qZulAaNxx4qhs6/zhcHd+MHYf6PfonvM7ORYW0KC38K2EQv2O
         CXO0JqzbZm4wUajBwZQ8WBwmgQ5Pb8mDLK7ST1egVt9VNc7zlkWyqOZG0FoPn145DIXx
         vR9paOzIKAHzMoMDXqaGz0lIoxjHVy1A/xlPKE4lr7ssZIjYxXe7BJNi+awxyx99bSOh
         ueufKrOEzB8xMwXe9RGv9a/MWrmqnXkKadjC5gx+cReYqfZ0MxDpHxZnWXZWMoF9+iiT
         Mj9Q==
X-Gm-Message-State: AHQUAuZmfxEcR1VV2jRYfu68C/Puej3/zjBNdmZfXM4TlfHa19cT2Zl1
        nU0aADSDztx/7NO0weTKHGFksU3gGPkPbEryMcU=
X-Google-Smtp-Source: AHgI3IY5vFyrwXax0/lAAYKlGCPQvQbMYQa96f8SrTz1Q4uND6CM6LFsAOdkUGcaVpWF9jKzO5jFf+BauSV7E799tR8=
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr5432816plk.132.1549577080724;
 Thu, 07 Feb 2019 14:04:40 -0800 (PST)
Date:   Thu,  7 Feb 2019 14:04:35 -0800
Message-Id: <20190207220435.85367-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH 0/4] Improve kernel LLD support
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     natechancellor@gmail.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch cleans up a few places in the Makefile to make way for
landing LLD support in the kernel.  There are still a few arch specific
fixes that need to get upstreamed, but this core set of patches should
be arch independent.

Some very rough numbers: LLD is improving the overall build time of
Google Pixel kernels by about 9%.  The build is mostly dominated by
compilation, but LLD is able to shave off quite a bit of time.

One of the included patches helps get LLD linked kernels to competitive
binary size, but there still some bugs in LLD causing it not to discard
certain sections.  Once that's fixed, I estimate an LLD linked kernel to
be just barely smaller than a BFD linked kernel (less than 1%).

Folks looking to test should use LLD built from source, as I recently
fixed a bug in LLD that prevented LLD linked kernel modules from being
loadable.

$ make LD=ld.lld

Nick Desaulniers (4):
  init/Kconfig: add config support for detecting linker
  Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
  Makefile: lld: tell clang to use lld
  Makefile: lld: set -O2 linker flag when linking with LLD

 Makefile     | 9 ++++++++-
 init/Kconfig | 9 +++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.20.1.791.gb4d0f1c61a-goog

