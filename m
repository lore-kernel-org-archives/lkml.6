Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C97C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31192082A
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 10:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C31192082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbeKDTZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 14:25:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42995 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbeKDTZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 14:25:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wA4AA1Qu4023156
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 4 Nov 2018 02:10:01 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wA4A9tuI4023143;
        Sun, 4 Nov 2018 02:09:55 -0800
Date:   Sun, 4 Nov 2018 02:09:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Michael Kelley <tipbot@zytor.com>
Message-ID: <tip-35b69a420bfb56b7b74cb635ea903db05e357bec@git.kernel.org>
Cc:     marcelo.cerri@canonical.com, mikelley@microsoft.com,
        devel@linuxdriverproject.org, olaf@aepfle.de, jgross@suse.com,
        jasowang@redhat.com, mingo@kernel.org, apw@canonical.com,
        tglx@linutronix.de, daniel.lezcano@linaro.org, hpa@zytor.com,
        vkuznets@redhat.com, gregkh@linuxfoundation.org,
        akataria@vmware.com, kys@microsoft.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Reply-To: devel@linuxdriverproject.org, olaf@aepfle.de, jgross@suse.com,
          mikelley@microsoft.com, marcelo.cerri@canonical.com,
          vkuznets@redhat.com, akataria@vmware.com,
          gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
          tglx@linutronix.de, apw@canonical.com, mingo@kernel.org,
          jasowang@redhat.com, hpa@zytor.com,
          virtualization@lists.linux-foundation.org, kys@microsoft.com,
          linux-kernel@vger.kernel.org
In-Reply-To: <1541303219-11142-2-git-send-email-mikelley@microsoft.com>
References: <1541303219-11142-2-git-send-email-mikelley@microsoft.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] clockevents/drivers/i8253: Add support for PIT
 shutdown quirk
Git-Commit-ID: 35b69a420bfb56b7b74cb635ea903db05e357bec
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  35b69a420bfb56b7b74cb635ea903db05e357bec
Gitweb:     https://git.kernel.org/tip/35b69a420bfb56b7b74cb635ea903db05e357bec
Author:     Michael Kelley <mikelley@microsoft.com>
AuthorDate: Sun, 4 Nov 2018 03:48:54 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 4 Nov 2018 11:04:46 +0100

clockevents/drivers/i8253: Add support for PIT shutdown quirk

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
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/1541303219-11142-2-git-send-email-mikelley@microsoft.com

---
 drivers/clocksource/i8253.c | 14 ++++++++++++--
 include/linux/i8253.h       |  1 +
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index 9c38895542f4..d4350bb10b83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -20,6 +20,13 @@
 DEFINE_RAW_SPINLOCK(i8253_lock);
 EXPORT_SYMBOL(i8253_lock);
 
+/*
+ * Handle PIT quirk in pit_shutdown() where zeroing the counter register
+ * restarts the PIT, negating the shutdown. On platforms with the quirk,
+ * platform specific code can set this to false.
+ */
+bool i8253_clear_counter_on_shutdown __ro_after_init = true;
+
 #ifdef CONFIG_CLKSRC_I8253
 /*
  * Since the PIT overflows every tick, its not very useful
@@ -109,8 +116,11 @@ static int pit_shutdown(struct clock_event_device *evt)
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
-	outb_p(0, PIT_CH0);
-	outb_p(0, PIT_CH0);
+
+	if (i8253_clear_counter_on_shutdown) {
+		outb_p(0, PIT_CH0);
+		outb_p(0, PIT_CH0);
+	}
 
 	raw_spin_unlock(&i8253_lock);
 	return 0;
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index e6bb36a97519..8336b2f6f834 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -21,6 +21,7 @@
 #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
 
 extern raw_spinlock_t i8253_lock;
+extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
 
