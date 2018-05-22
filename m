Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeEVHYM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:24:12 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:45981 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751189AbeEVHYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:24:08 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4M7MRAd030337
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>, Ulf Magnusson <ulfalizer@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arvind Prasanna <arvindprasanna@gmail.com>
Subject: [PATCH v3 0/4] kconfig: refactor package checks for GUI frontends
Date: Tue, 22 May 2018 16:22:17 +0900
Message-Id: <1526973741-664-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kconfig supports 4 GUI frontends.
Each of them needs some support packages, but checks them differently:

  qconf, gconf: check packages in Makefile (pkg-config is required)
  mconf: lxdialog/check-lxdialog.sh
  nconf: needs ncurses, but its presence is not checked

This series refactor the package checks so that all of them work
in the same way.

The package check scripts have been moved to scripts/kconfig/*conf-cfg.sh

The motivation of this clean-up is Randy's following patch:
https://patchwork.kernel.org/patch/10277723/

I want to clean up existing code before adding more checks.


Masahiro Yamada (4):
  kbuild: do not display CHK for filechk
  kconfig: refactor Qt package checks for building qconf
  kconfig: refactor GTK+ package checks for building gconf
  kconfig: refactor ncurses package checks for building mconf and nconf

 scripts/Kbuild.include                     |   1 -
 scripts/kconfig/Makefile                   | 168 ++++++++++-------------------
 scripts/kconfig/gconf-cfg.sh               |  23 ++++
 scripts/kconfig/lxdialog/check-lxdialog.sh |  93 ----------------
 scripts/kconfig/lxdialog/dialog.h          |   2 +-
 scripts/kconfig/mconf-cfg.sh               |  44 ++++++++
 scripts/kconfig/nconf-cfg.sh               |  43 ++++++++
 scripts/kconfig/qconf-cfg.sh               |  25 +++++
 8 files changed, 195 insertions(+), 204 deletions(-)
 create mode 100755 scripts/kconfig/gconf-cfg.sh
 delete mode 100755 scripts/kconfig/lxdialog/check-lxdialog.sh
 create mode 100755 scripts/kconfig/mconf-cfg.sh
 create mode 100644 scripts/kconfig/nconf-cfg.sh
 create mode 100755 scripts/kconfig/qconf-cfg.sh

-- 
2.7.4
