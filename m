Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75696C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E072086B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 14:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38E072086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeIHTSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 15:18:08 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44931 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbeIHTSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 15:18:08 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M2NqA-1g1O6T0GWE-003rwK; Sat, 08 Sep 2018 16:32:07 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     viro@zeniv.linux.org.uk
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] compat_ioctl: remove /dev/raw ioctl translation
Date:   Sat,  8 Sep 2018 16:28:15 +0200
Message-Id: <20180908142837.2819693-9-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908142837.2819693-1-arnd@arndb.de>
References: <20180908142837.2819693-1-arnd@arndb.de>
X-Provags-ID: V03:K1:igYwFt37Me/pBzU2cL5f50SU8QPyDjxHobFHBJxRdCx1SRjJQLQ
 hiIjs01dgrRvah7tGGbQsnWhIqUDZYUK9gybmYyjwlthMj96eKd6gE+NPNEtGvfTlW5sKkF
 e988tyZFCxgl1tduJgXZHXSxMNvZPtagM1lYlsINbQwFmBx21kkf3U9yYvZ90L6oxIcURRc
 2USiZE1Hnxfq0eFZjJwEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LXDHlHckRH8=:mzkNgCsds9MEPVh/L/x6jR
 7y3xeSQHCidanQRs+xk2iwRg1cL7XpWfsDAkO0zRlGWsJPoTppoNOL6PBEWyTA9xTBeF6Rs/T
 4ys2req1TPD4vluzkXYE06UlX5olN5OBvkjWjtVpKUA1Gi3R22F+YeYdCqWutbhHOyIhdozlu
 z35C3mk6y7Gzgi/o2W6xNcMsKR4LRJ7vKbjkMILfxikDiNBqQhCGYwGDrwVjDAJIM1wFAwBy7
 Wk+MuU+hi7jwwVCcgVtuclD8tECmu2iVdWsTV+GFhL5YIjLlZzJNYLKAfpReUULEo0QoyCTZL
 7LGCpjCI4ysp6ckBJ+niQFCv6jFemgyfGkTK7dSLf6nBDsEDFaXMFaMu/v2kN7T8Up66G0MeT
 24D1F5Ih7Zwigy8ZbOjo7f4vceOiUAMjcg0Ybr0EcJsgZ/DMZZbDFmYiMY78kQ0PiiXDTUZt9
 cMzkC981IrIKuyRbbGcPDetSoxQ5U5WCRlU3pUfAck0L5EzhWD/rOUf1urthYb63vsH+kWcpK
 n2GzXXliGPgbCUh7M18Uf/eFdsC3R+idcmM0ZZxEFCKOEEClM7Iui92pF7LC2qZBJFpfA2A7D
 ZMu2lhI1ETB/6hvHs3xf5TOyoLBEayQVOY5KvoUipDBmEHRsXZPhJZyz2r80XCG1xLrfyupCv
 EhSlMZCt+DaDVsPeJSY6J1hvxzvCtDmgfmwq9SCjzTZ33vrruAjWDyaCDmLXGCClBEmg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The /dev/rawX implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 28ebff2d1799..e755802cd887 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -41,7 +41,6 @@
 #include <linux/fb.h>
 #include <linux/videodev2.h>
 #include <linux/netdevice.h>
-#include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
 #include <linux/serial.h>
@@ -577,9 +576,6 @@ COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 /* PPP stuff */
 COMPATIBLE_IOCTL(PPPIOCGUNIT)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Watchdog */
 COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-- 
2.18.0

