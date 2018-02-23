Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeBWOXA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 09:23:00 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:35180 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751381AbeBWOW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 09:22:58 -0500
X-Google-Smtp-Source: AH8x225wCDuBN9OncB2zV5Axf1EJ8ULsssFLYrBDVFmvA/ExaHUASykP0QZhzJLZzRrgz2nD0N/8Xw==
From: Robin Jarry <robin.jarry@6wind.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] objtool: fix libelf detection in non-standard locations
Date: Fri, 23 Feb 2018 15:22:13 +0100
Message-Id: <cover.1519393674.git.robin.jarry@6wind.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When libelf headers and libs are not in standard locations, the check
fails and host flags are ignored.

I have encountered this issue when building linux into the buildroot
framework. host-* versions of libs may be compiled and installed in a
host staging dir removing the need to install them on the build system.

Comments are welcome.

Regards,

Robin Jarry (2):
  kbuild: introduce HOST_EXTRALDFLAGS
  objtool: use host flags to detect if libelf is missing

 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.11.0
