Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7719CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5632082A
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5632082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732314AbeKNDQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:16:59 -0500
Received: from mga14.intel.com ([192.55.52.115]:10719 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732204AbeKNDQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:16:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2018 09:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,228,1539673200"; 
   d="scan'208";a="249393042"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 Nov 2018 09:17:39 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id ACF3CB8D; Tue, 13 Nov 2018 19:17:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 19/20] mk68/mac: Switch to use %ptR
Date:   Tue, 13 Nov 2018 19:17:28 +0200
Message-Id: <20181113171729.19645-20-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
References: <20181113171729.19645-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use %ptR instead of open coded variant to print content of
struct rtc_time in human readable format.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/m68k/mac/misc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index ebb3b6d169ea..71c4735a31ee 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -605,13 +605,9 @@ int mac_hwclk(int op, struct rtc_time *t)
 		unmktime(now, 0,
 			 &t->tm_year, &t->tm_mon, &t->tm_mday,
 			 &t->tm_hour, &t->tm_min, &t->tm_sec);
-		pr_debug("%s: read %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: read %ptR\n", __func__, t);
 	} else { /* write */
-		pr_debug("%s: tried to write %04d-%02d-%-2d %02d:%02d:%02d\n",
-		         __func__, t->tm_year + 1900, t->tm_mon + 1, t->tm_mday,
-		         t->tm_hour, t->tm_min, t->tm_sec);
+		pr_debug("%s: tried to write %ptR\n", __func__, t);
 
 		switch (macintosh_config->adb_type) {
 		case MAC_ADB_IOP:
-- 
2.19.1

