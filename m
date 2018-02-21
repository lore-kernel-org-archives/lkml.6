Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbeBUVqh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:46:37 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:48233 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeBUVqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:46:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] powerpc/time: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 22:46:33 +0100
Message-Id: <20180221214633.2012-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it just before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/powerpc/kernel/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a32823dcd9a4..f7d96a68ecaa 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -1234,7 +1234,7 @@ void calibrate_delay(void)
 static int rtc_generic_get_time(struct device *dev, struct rtc_time *tm)
 {
 	ppc_md.get_rtc_time(tm);
-	return rtc_valid_tm(tm);
+	return 0;
 }
 
 static int rtc_generic_set_time(struct device *dev, struct rtc_time *tm)
-- 
2.16.1
