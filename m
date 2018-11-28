Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE273C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8EA20665
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8EA20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeK2GIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:08:30 -0500
Received: from mga04.intel.com ([192.55.52.120]:9022 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbeK2GI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:08:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 11:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="114914427"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Nov 2018 11:05:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 812DEA30; Wed, 28 Nov 2018 21:05:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 20/21] mk68/mac: Switch to use %ptR
Date:   Wed, 28 Nov 2018 21:05:36 +0200
Message-Id: <20181128190537.14074-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
References: <20181128190537.14074-1-andriy.shevchenko@linux.intel.com>
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
2.19.2

