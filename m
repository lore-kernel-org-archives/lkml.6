Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539CFC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA0720673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BA0720673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729297AbeGZJa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:30:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:38171 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728807AbeGZJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:30:56 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LyUFS-1g6EdG1aA2-015sFb; Thu, 26 Jul 2018 10:14:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] [stable 4.9] turn off -Wattribute-alias
Date:   Thu, 26 Jul 2018 10:13:25 +0200
Message-Id: <20180726081358.3829157-4-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180726081358.3829157-1-arnd@arndb.de>
References: <20180726081358.3829157-1-arnd@arndb.de>
X-Provags-ID: V03:K1:XIn01yMgAsUVty1ujKZVURQ3gyuZoFxWA+hFwvMi6jmLQhkrEtq
 450JtyqKYOjFus2V6Ilgt7lLmRb+qeLMbFm2OjH4zeEmqxvhxEwDdbpSNCpl+8n9t08cw4N
 uNzL5Ssm5WUH+WG8WpGQvsaTEPG/NgRqJXXYmVdqhBVpIzxJtx8oktCkOrTELV2RGSBI/xo
 sITQ78OOCJO2JtMwKHAQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a4bkbOUoQ/o=:3rSAKpvlZ2p5XMr59SE8A9
 wizGn/exYCERnb0TRIkYaFW7qoozeWL6bHqhle2MUwjoaKDJjvqTrl7A2HnFkNVlR81WgZr8F
 YMVoes/n5FvYkBiE9OQfFtBKfdbPeAZUCXPYvjS/iRqVlnPa4p8pId1UvYFD3s9MccPTjjSQj
 625KscfcGOkU+ow+yOSPuWGLkwXsM2gCqKya6KZ7k9ni1GTnkEInShFi7fwlu+cq2o2y24N/I
 Ix69xTuDvlHl2T3AAmZ2r8YDzd5f/zNnS1NsCfzjoZsaoIJJfgk1leb0t1/1jU8U3ee768x9L
 CxLZo7jN4WnxpnGQ/8WE73dJ5VDWvL/TA564p9oy1SduS7yk4EyoNizrK+JLLNogy56RmgMMm
 QkmvWtTpOjOUE4YcT3jEfY9T3/sZkWuTyG/XW2MW3r0DLjyAsTxzCsQDda0HFMEj4DtyrmFp/
 RNwkE3mS4+2BgGQZznkV4Ry60KC2BesZyeC6h8kRKgMIRcgz+tFU06+WtmJQKRHwetw6z1JPy
 mSrNjzSX9HfIhSabmpFPQjRlsnCexdmgi2d5wc/f1hDOeeEwHdVqaikcV+GdF7Tk9L5mZHrT/
 57nJbZLXiF8ZVLH3MBEwlWbbBauMjJYpGj0cAfPBXBuhcp1TgaQDAv01F9Oeg1jWigoWddjR4
 jd1QFT6ifN26MkqW3fg9WXUOcwCNBd3SFN2waikqQO/nnL/vQizI+BJPT0lqJsWt/URg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with gcc-8.1, we get a warning about all system call definitions,
which use an alias between functions with incompatible prototypes, e.g.:

In file included from ../mm/process_vm_access.c:19:
../include/linux/syscalls.h:211:18: warning: 'sys_process_vm_readv' alias between functions of incompatible types 'long int(pid_t,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)' {aka 'long int(int,  const struct iovec *, long unsigned int,  const struct iovec *, long unsigned int,  long unsigned int)'} and 'long int(long int,  long int,  long int,  long int,  long int,  long int)' [-Wattribute-alias]
  asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,
 ^~~~~~~~~~~~~~~
../include/linux/syscalls.h:215:18: note: aliased declaration here
  asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__)) \
                  ^~~
../include/linux/syscalls.h:207:2: note: in expansion of macro '__SYSCALL_DEFINEx'
  __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
  ^~~~~~~~~~~~~~~~~
../include/linux/syscalls.h:201:36: note: in expansion of macro 'SYSCALL_DEFINEx'
 #define SYSCALL_DEFINE6(name, ...) SYSCALL_DEFINEx(6, _##name, __VA_ARGS__)
                                    ^~~~~~~~~~~~~~~
../mm/process_vm_access.c:300:1: note: in expansion of macro 'SYSCALL_DEFINE6'
 SYSCALL_DEFINE6(process_vm_readv, pid_t, pid, const struct iovec __user *, lvec,

This is really noisy and does not indicate a real problem. In the latest
mainline kernel, this was addressed by commit bee20031772a ("disable
-Wattribute-alias warning for SYSCALL_DEFINEx()"), which seems too invasive
to backport.

This takes a much simpler approach and just disables the warning across the
kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index f4cd42c9b940..41b9954dc0a9 100644
--- a/Makefile
+++ b/Makefile
@@ -635,6 +635,7 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning,frame-address,)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
+KBUILD_CFLAGS	+= $(call cc-disable-warning, attribute-alias)
 
 ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 KBUILD_CFLAGS	+= $(call cc-option,-ffunction-sections,)
-- 
2.18.0

