Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8A42086E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 10:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8A42086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbeIXQaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 12:30:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:24891 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbeIXQae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 12:30:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 03:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,297,1534834800"; 
   d="scan'208";a="76789899"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga006.jf.intel.com with ESMTP; 24 Sep 2018 03:29:02 -0700
From:   Songjun Wu <songjun.wu@linux.intel.com>
To:     yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        hauke.mehrtens@intel.com
Cc:     Songjun Wu <songjun.wu@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH 12/14] serial: lantiq: Replace lantiq_soc.h with lantiq.h
Date:   Mon, 24 Sep 2018 18:28:01 +0800
Message-Id: <20180924102803.30263-13-songjun.wu@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this existing lantiq serial driver,
lantiq_soc.h is defined in the arch directory,

./arch/mips/include/asm/mach-lantiq/falcon/lantiq_soc.h
./arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h

This driver need to be extended to support more platform,
lantiq.h is added in include/linux/ to make it
globally available and provide some wrapper code.
Use lantiq.h to make the driver can find the correct
header file.

Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
---

 drivers/tty/serial/lantiq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c983694ba24d..ba0c70b16bda 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
+#include <linux/lantiq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -25,8 +26,6 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 
-#include <lantiq_soc.h>
-
 #define PORT_LTQ_ASC		111
 #define MAXPORTS		2
 #define UART_DUMMY_UER_RX	1
-- 
2.11.0

