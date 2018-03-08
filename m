Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbeCHBGg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 20:06:36 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:60404 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755043AbeCHBF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 20:05:56 -0500
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w28156G5018694
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Cao jin <caoj.fnst@cn.fujitsu.com>,
        Govind Singh <govinds@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] kbuild: always define KBUILD_MODNAME, and clean-up/fix modname
Date: Thu,  8 Mar 2018 10:04:58 +0900
Message-Id: <1520471103-10089-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


3/5 takes into account '-m' case for multi-used-m.

2/5 is necessary beforehand because 3/5 would cause a build error for
drivers/net/ethernet/cavium/liquidio/lio_ethtool.c

1, 4, 5 are just clean-ups.



Cao jin (1):
  kbuild: fix modname for composite modules

Masahiro Yamada (4):
  kbuild: remove unnecessary $(subst $(obj)/,,...) in modname-multi
  kbuild: define KBUILD_MODNAME even if multiple modules share objects
  kbuild: simplify modname calculation
  kbuild: move modname and modname-multi close to modname_flags

 scripts/Makefile.build | 12 ------------
 scripts/Makefile.lib   | 22 +++++++++-------------
 2 files changed, 9 insertions(+), 25 deletions(-)

-- 
2.7.4
