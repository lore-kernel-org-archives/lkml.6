Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A0FC169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9022177E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbfBCOVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:21:19 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:55744 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729027AbfBCOVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 09:21:16 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIe2-0006PU-Nx; Sun, 03 Feb 2019 14:21:14 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9b-00073J-4O; Sun, 03 Feb 2019 14:49:47 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "KY Srinivasan" <kys@microsoft.com>,
        "akataria@vmware.com" <akataria@vmware.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "apw@canonical.com" <apw@canonical.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "Michael Kelley" <mikelley@microsoft.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "vkuznets" <vkuznets@redhat.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.388753594@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 139/305] clockevents/drivers/i8253: Add support for
 PIT shutdown quirk
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Michael Kelley <mikelley@microsoft.com>

commit 35b69a420bfb56b7b74cb635ea903db05e357bec upstream.

Add support for platforms where pit_shutdown() doesn't work because of a
quirk in the PIT emulation. On these platforms setting the counter register
to zero causes the PIT to start running again, negating the shutdown.

Provide a global variable that controls whether the counter register is
zero'ed, which platform specific code can override.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Cc: "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: "jgross@suse.com" <jgross@suse.com>
Cc: "akataria@vmware.com" <akataria@vmware.com>
Cc: "olaf@aepfle.de" <olaf@aepfle.de>
Cc: "apw@canonical.com" <apw@canonical.com>
Cc: vkuznets <vkuznets@redhat.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>
Cc: "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Cc: KY Srinivasan <kys@microsoft.com>
Link: https://lkml.kernel.org/r/1541303219-11142-2-git-send-email-mikelley@microsoft.com
[bwh: Backported to 3.16:
 - Don't use __ro_after_init
 - Adjust context, indentation]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/i8253.h       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -19,6 +19,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -123,8 +130,11 @@ static void init_pit_timer(enum clock_ev
 		if (evt->mode == CLOCK_EVT_MODE_PERIODIC ||
 		    evt->mode == CLOCK_EVT_MODE_ONESHOT) {
 			outb_p(0x30, PIT_MODE);
-			outb_p(0, PIT_CH0);
-			outb_p(0, PIT_CH0);
+
+			if (i8253_clear_counter_on_shutdown) {
+				outb_p(0, PIT_CH0);
+				outb_p(0, PIT_CH0);
+			}
 		}
 		break;
 
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 

