Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbeBLEWv (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 23:22:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:28609 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932237AbeBLEWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 23:22:49 -0500
X-IronPort-AV: E=Sophos;i="5.43,368,1503331200";
   d="scan'208";a="36995210"
To: Masahiro Yamada <yamada.masahiro@socionext.com>
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: why scripts/link-vmlinux.sh has a final build of init/
CC: Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <fb60e245-86f2-53c6-79d8-bd395ef011dd@cn.fujitsu.com>
Date: Mon, 12 Feb 2018 12:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: 999D848AE761.A9646
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro-san,

  As I remember, init/ is already built during recursive make, and I did
a clean build(make mrproper, make localmodconfig) with all plugins
included on x86_64 with following patch, the kernel can boot without any
obvious problem. So, I don't figure out why we need this final build?


diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index e6818b8e7141..086b2efd4d53 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -247,9 +247,6 @@ else
        expr 0$(cat .old_version) + 1 >.version;
 fi;

-# final build of init/
-${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init
GCC_PLUGINS_CFLAGS="${GCC_PLUGINS_CFLAGS}"
-
 archive_builtin

 #link vmlinux.o

 --
Sincerely,
Cao jin
