Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751937AbeEaESA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 00:18:00 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36780 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750868AbeEaER4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 00:17:56 -0400
X-Google-Smtp-Source: ADUXVKK//LdYndqcRsk8wLB6YWYxe0j3gVV80PvVRn/4pnpP+m66RKZFRwO5VLLjaux+fG+M3ZEhwQ==
Date: Wed, 30 May 2018 21:18:35 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Kconfig warnings with GCC 8.1.0
Message-ID: <20180531041835.GA15842@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

My apologies if this has already been reported in some capacity, I
searched the mailing list and patchwork but I didn't see anything.

With GCC 8.1.0, I am starting to see the following warnings from
Kconfig:

  CC    scripts/kconfig/zconf.tab.c
  LEX     scripts/kconfig/zconf.lex.c
  HOSTCC  scripts/kconfig/zconf.tab.o
In file included from scripts/kconfig/zconf.tab.c:2496:
scripts/kconfig/confdata.c: In function ‘conf_write’:
scripts/kconfig/confdata.c:748:22: warning: ‘%s’ directive writing likely 7 or more bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
  sprintf(newname, "%s%s", dirname, basename);
                      ^~
scripts/kconfig/confdata.c:748:19: note: assuming directive output of 7 bytes
  sprintf(newname, "%s%s", dirname, basename);
                   ^~~~~~
scripts/kconfig/confdata.c:748:2: note: ‘sprintf’ output 1 or more bytes (assuming 4104) into a destination of size 4097
  sprintf(newname, "%s%s", dirname, basename);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/kconfig/confdata.c:751:23: warning: ‘.tmpconfig.’ directive writing 11 bytes into a region of size between 1 and 4097 [-Wformat-overflow=]
   sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
                       ^~~~~~~~~~~
scripts/kconfig/confdata.c:751:3: note: ‘sprintf’ output between 13 and 4119 bytes into a destination of size 4097
   sprintf(tmpname, "%s.tmpconfig.%d", dirname, (int)getpid());
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  HOSTCC  scripts/kconfig/conf.o
  HOSTLD  scripts/kconfig/conf

I am not sure if this is a false positive or not, otherwise I would have
sent a patch. I tested on the latest linux-next with Masahiro's for-next
branch, currently at commit 57282f7da50c ("Merge branch 'kconfig' into
for-next").

Thanks!
Nathan
