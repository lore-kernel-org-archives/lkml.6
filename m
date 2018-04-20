Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755192AbeDTNfI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:35:08 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36922 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754884AbeDTNdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:33:04 -0400
X-Google-Smtp-Source: AIpwx484+4H2r9vYxNbrHhCeWO3L7VHmCOF4I6MAfIkxOjKbdm03UnA0TolF6HDUXLStGJ39jyFwLg==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 2/9] nds32: Fix building error when CONFIG_FREEZE is enabled.
Date: Fri, 20 Apr 2018 21:31:08 +0800
Message-Id: <b451a1d98f3393afccb58813ac37eb2cbddfcb3a.1524229038.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
In-Reply-To: <cover.1524229035.git.greentime@andestech.com>
References: <cover.1524229035.git.greentime@andestech.com>
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
Acked-by: Arnd Bergmann <arnd@arndb.de>
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
