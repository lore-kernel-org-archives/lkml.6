Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDSNUG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 09:20:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33846 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeDSNUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 09:20:04 -0400
X-Google-Smtp-Source: AIpwx49pxlYtmVzKJXuK1OVFYfBpic8eyZCTEXuwhK2gx1goN1wddLVS7F0kaTU/VEZQ5A8TP/lNMA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net
Subject: [PATCH 2/9] nds32: Fix building error when CONFIG_FREEZE is enabled.
Date: Thu, 19 Apr 2018 21:18:08 +0800
Message-Id: <78202670b77fa27e13c82836d909c57bf1dd413d.1524143428.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
In-Reply-To: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
References: <347705ade75b5901537034561fd67311b1260358.1524143428.git.greentime@andestech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To include kernel/Kconfig.freezer to make sure the dependency between
CONFIG_CGROUP_FREEZER and CONFIG_FREEZER

It will cause building error when I make allmodconfig.

kernel/cgroup/freezer.c: In function 'freezer_css_online':
kernel/cgroup/freezer.c:116:15: error: 'system_freezing_cnt' undeclared (first use in this function)
   atomic_inc(&system_freezing_cnt);
               ^~~~~~~~~~~~~~~~~~~
kernel/cgroup/freezer.c:116:15: note: each undeclared identifier is reported only once for each function it appears in
kernel/cgroup/freezer.c: In function 'freezer_css_offline':
kernel/cgroup/freezer.c:137:15: error: 'system_freezing_cnt' undeclared (first use in this function)
   atomic_dec(&system_freezing_cnt);
               ^~~~~~~~~~~~~~~~~~~
kernel/cgroup/freezer.c: In function 'freezer_attach':
kernel/cgroup/freezer.c:181:4: error: implicit declaration of function 'freeze_task' [-Werror=implicit-function-declaration]
    freeze_task(task);
    ^~~~~~~~~~~
kernel/cgroup/freezer.c: In function 'freezer_apply_state':
kernel/cgroup/freezer.c:360:16: error: 'system_freezing_cnt' undeclared (first use in this function)
    atomic_inc(&system_freezing_cnt);
                ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/nds32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/nds32/Kconfig b/arch/nds32/Kconfig
index 98e05f997f91..b7404f2dcf5b 100644
--- a/arch/nds32/Kconfig
+++ b/arch/nds32/Kconfig
@@ -88,6 +88,7 @@ endmenu
 
 menu "Kernel Features"
 source "kernel/Kconfig.preempt"
+source "kernel/Kconfig.freezer"
 source "mm/Kconfig"
 source "kernel/Kconfig.hz"
 endmenu
-- 
1.9.5
