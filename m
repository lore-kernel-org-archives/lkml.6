Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326731-2-3051988947802659845
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326731; b=rnOaEnM/GdMxbNGyrOhfHT6AX+ChL08/w8cGbcD7XCneYRF
    WLxu9TGwi89FSqDbbB6bVq8BRL3xupDJI01eLI9/x334/juVFgaltfcjK6a9BoNg
    nKK5qiA0K5Ws3gTb2BBfkJt4zKtBeo614uNbDDpWrnfqQLvb2TcCRGU5SHJy54/f
    KB3ljfKmNbWQA57aTCXiG9xxuR9YyXgCFNSQDh8aC3QsyqCsXPUlKpbhBXj7AMTg
    zW44KIJe3KVp1/NOqE50K8+xOGfdYbL6OIi+DxW22HLrJW3IY6Xc0Uwl8fu5iHsp
    MKP/fXTFF5fx28mvbRDXRHYxTB0+BBCAriHYmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326731; bh=/iyqHlqqvLdOXKMEj6C
    C33yyRE9EInCDg5fTG6ECJuk=; b=oAtZCH9h56pUElFQsgJFwkeGLHG5L224BCt
    J81gKzJaKVI9N1nTCp2IfN6I/C+5isDYRs/chQ4t7QRZHmZKGIqb3lVzKasQevZc
    QPkQuPjUj2VPOdVvZgl64O1OZnyYMnFnc3z+l/Kz70hrzAtnAdS3AEeRvJ9LPknl
    /vJaAyH+xjVKK0wZ5BAqBjJXej9I30GyyECiZCVQ8MNY51x/1S5U3EUOqqHgtkn3
    sO9A9ivlxkOL/9Ot5PFeolCE7ZqPcRNgE42pEYeXrc/YE8zbXJdc4+UdwcgP9P1S
    HCStHmOqvkTkR7aDxSlC5VR5TXvGrt4nnm2x45CxENGDTEMHSBg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeBKFYG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:24:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41319 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752449AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Colin Ian King" <colin.king@canonical.com>,
        "Alexandre Belloni" <alexandre.belloni@free-electrons.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.113202@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 02/79] rtc: interface: ignore expired timers when
 enqueuing new timers
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 2b2f5ff00f63847d95adad6289bd8b05f5983dd5 upstream.

This patch fixes a RTC wakealarm issue, namely, the event fires during
hibernate and is not cleared from the list, causing hwclock to block.

The current enqueuing does not trigger an alarm if any expired timers
already exist on the timerqueue. This can occur when a RTC wake alarm
is used to wake a machine out of hibernate and the resumed state has
old expired timers that have not been removed from the timer queue.
This fix skips over any expired timers and triggers an alarm if there
are no pending timers on the timerqueue. Note that the skipped expired
timer will get reaped later on, so there is no need to clean it up
immediately.

The issue can be reproduced by putting a machine into hibernate and
waking it with the RTC wakealarm.  Running the example RTC test program
from tools/testing/selftests/timers/rtctest.c after the hibernate will
block indefinitely.  With the fix, it no longer blocks after the
hibernate resume.

BugLink: http://bugs.launchpad.net/bugs/1333569

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/rtc/interface.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -749,9 +749,23 @@ EXPORT_SYMBOL_GPL(rtc_irq_set_freq);
  */
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer)
 {
+	struct timerqueue_node *next = timerqueue_getnext(&rtc->timerqueue);
+	struct rtc_time tm;
+	ktime_t now;
+
 	timer->enabled = 1;
+	__rtc_read_time(rtc, &tm);
+	now = rtc_tm_to_ktime(tm);
+
+	/* Skip over expired timers */
+	while (next) {
+		if (next->expires.tv64 >= now.tv64)
+			break;
+		next = timerqueue_iterate_next(next);
+	}
+
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (&timer->node == timerqueue_getnext(&rtc->timerqueue)) {
+	if (!next) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
