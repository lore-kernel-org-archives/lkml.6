Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeC2AsP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 20:48:15 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44361 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751096AbeC2AsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 20:48:13 -0400
X-Google-Smtp-Source: AIpwx49MawCXokT0CWa1ZDCIq8GEoJuqvvgBlsLREP25ZM2w1lQIp9rfywOCRnjPW7DrGfTrxHATXg==
From: Laura Abbott <labbott@redhat.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: Laura Abbott <labbott@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH 0/3] HOSTCFLAGS and HOSTLDFLAGS from the environment
Date: Wed, 28 Mar 2018 17:48:02 -0700
Message-Id: <20180329004805.7278-1-labbott@redhat.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Someone noted that scripts/tools userspace binaries packaged as part of
the Fedora kernel were not picking up the recommended compiler flags
(https://src.fedoraproject.org/rpms/redhat-rpm-config/blob/master/f/buildflags.md)
This series lets the host ld and C flags be set on the command line
similar to the kernel flags:

make AFLAGS_HOSTCFLAGS="%{build_cflags}" AFLAGS_HOSTLDFLAGS="%{build_ldflags}"

There's one more annoying case I didn't quite figure out with
tools/objtool/fixdep since that's linked with ld directly but this
covers the initial set of reports.

Thanks,
Laura

Laura Abbott (3):
  kbuild: Support HOSTLDFLAGS
  objtool: Support HOSTCFLAGS and HOSTLDFLAGS
  kbuild: Allow passing additional HOSTCFLAGS and HOSTLDFLAGS

 Documentation/kbuild/kbuild.txt | 9 +++++++++
 Makefile                        | 3 +++
 scripts/Makefile.host           | 6 +++---
 tools/build/Makefile.build      | 2 +-
 tools/objtool/Makefile          | 5 +++--
 5 files changed, 19 insertions(+), 6 deletions(-)

-- 
2.16.2
