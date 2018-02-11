Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518325242-2-16595899525092095475
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
    t=1518325242; b=rs1EWGVAQZM8lNkLglaYwLaLaxXzIjKl0WZctG5H/pu3x6O
    uKr+zWf0gODrJuy8FPt1AMElrg/XR7exxBnQgU0yuX5vGIw7vBNRfRRTnT+dXB4E
    XOv4HIEyJWAa0gbiCSICnT2eBdp+vrRGcJ+GxmSZvktmRSYHawPOo8YZb70aWpwf
    4t2DL/1FhoM408bIkIrVOuY5BMT3OVdxLgPl5z1RTNYakbibI/4T1koV7P11ajud
    XM++gt6IU18ulEsLp4xHjt9DgcRnIdmpG9NL68kZ9BPlB+wosHzQlW8tx/XcClW3
    BVyr2EvckkZFdRv1AkLIKD0ogWvh440O4reXPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325242; bh=QJT8W1KTHA5dx/Ets+3
    vsp+WviDaXkVvm3ZddveDP20=; b=hFiF4P2e169/gEnMHWWkQ9ECqa6WX8xKH+/
    1xPsp9/oFTaRKFd0gLsJYg5dgh6CAylOrJru2MJlxIIx8ak4zazlLCJi9cDv7TtQ
    yxdSv6udJU3TVUOcTIoN4ShG+yXJiCQHZnYIMtrExuw6SYzOLsurx/tBOPfsPJ/V
    LYEuqzYvvKq58XuPhXPGhj/rKyxt6U94V7IzIcDYhXVw20U7CB6IPF9b1hB34Jzs
    7CEdO6edAYbI0GLuzbMM5HqrqVBMxpjMWbVnkCFGwKL2MIQepClpJmCr3KNvkv/a
    qQmk/t6g6VsDzSnjY1cXSnyBVBDO/pbbKqC2O8BFTok+qO5xM6Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753815AbeBKE6w (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:58:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41669 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752777AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alexandre Belloni" <alexandre.belloni@free-electrons.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.600461425@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 007/136] rtc: set the alarm to the next expiring timer
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

commit 74717b28cb32e1ad3c1042cafd76b264c8c0f68d upstream.

If there is any non expired timer in the queue, the RTC alarm is never set.
This is an issue when adding a timer that expires before the next non
expired timer.

Ensure the RTC alarm is set in that case.

Fixes: 2b2f5ff00f63 ("rtc: interface: ignore expired timers when enqueuing new timers")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -794,7 +794,7 @@ static int rtc_timer_enqueue(struct rtc_
 	}
 
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (!next) {
+	if (!next || ktime_before(timer->node.expires, next->expires)) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
