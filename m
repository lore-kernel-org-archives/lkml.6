Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeCMGL5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:11:57 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39428 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751274AbeCMGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:11:55 -0400
X-Google-Smtp-Source: AG47ELv+XQ6BVS2fSjPHDgcv/7WStZRyfrDZbSZQHmpt7XqmjzorlcCUi6cy/lAoC9fgdyVrFgwx2w==
From: Douglas Anderson <dianders@chromium.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: malat@debian.org, dave.hansen@intel.com, yang.s@alibaba-inc.com,
        linux@roeck-us.net, Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Cao jin <caoj.fnst@cn.fujitsu.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Charlebois <charlebm@gmail.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 0/2] kbuild: Fix corner caches with .cache.mk
Date: Mon, 12 Mar 2018 23:11:07 -0700
Message-Id: <20180313061109.72629-1-dianders@chromium.org>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This two-patches fixes two corner cases with .cache.mk that have been
reported.  Neither problem was catastrophic, but certainly several
people ran into the problem solved by the first patch (can't build
after gcc upgrade) and wasted time debugging, so it's really a good
idea to fix.

Sorry for the big delay between v2 and v3.  I never quite caught up
with email after the holidays, but hopefully better late than never...

Changes in v3:
- Fix as per Masahiro Yamada (move change to main Makefile)
- Use "uid 0" as the heuristic instead of install
- Do the checking in the main Makefile instead of Kbuild.include

Changes in v2:
- Don't error if MAKECMDGOALS is blank.

Douglas Anderson (2):
  kbuild: Require a 'make clean' if we detect gcc changed underneath us
  kbuild: Don't mess with the .cache.mk when root

 Makefile               | 15 +++++++++++++++
 scripts/Kbuild.include |  2 ++
 2 files changed, 17 insertions(+)

-- 
2.16.2.660.g709887971b-goog
