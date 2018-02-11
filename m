Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326730-2-16149218240953413811
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
    t=1518326729; b=DUgx1aq02VuP+YWHYwR33q+R1V0h2wnFTREMvTDX8LvQ6NX
    FATmKqXuGrfSjeoOtaBzXXCGAcjlQfvZBZi4RUIjBA+fqZTkdKL89YQ6jghUN1i/
    Ietu4f1SIM3Z+Q5dXQI0jj7YWvca6iK30rnQF7pxeolt/lhSO79Ec4wMw7WTWW2p
    DVBrrmbD/sqdxyhjF9lIjZkiB/EdmtXZGXnp6O3mvh9VPS/E5jYhGioYiuqAVtxI
    0XAZIbz2A1Z16NqosKpFGvtJa/y1nC7a65xzXH42mJiXDTfidP50B+IGulHaN9lj
    1DkWaRYfZ8ThDRelljq06IWvU/aE99dXbK4Vgow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326729; bh=nj2y8NdaIN5QkellLQr
    Cn43I0qszntqK6+wbSzu4Nko=; b=R+dUMKofmq+Ubt9/3gchgYEVmA5hp0Z+BJl
    2gWBhtDrkb2i53YKwbsCH2aiLKXK4cYJUdRnUihXqVgtWYCrMwhZBB8g46ObE0CE
    jp2MCtTm0uA4M2ps9ROZKCop+nuFBY7dzBS9yNFD6lhYX12nIS8xfqe/1vlIS4fw
    qrcYVl+azLCnkqhiiNdiqOPuSD2SMZsUzwj0zquWchzF4MwOmdtLd+/6KPGD1azr
    ojcgiUDhdjeoIuhqSSNiB0NkGgJ9BOjB/g9/Z0Sc00KRW2yJ8+E8s79DzlqiFcMG
    9V6b8oYjA/n0MvKoTkTWjYtp2LmjfYTnhSk5lsHMjgojPz2Wmpg==
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
        id S1754134AbeBKFYG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:24:06 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41316 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752450AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alexandre Belloni" <alexandre.belloni@free-electrons.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.48787059@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 03/79] rtc: set the alarm to the next expiring timer
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

From: Alexandre Belloni <alexandre.belloni@free-electrons.com>

commit 74717b28cb32e1ad3c1042cafd76b264c8c0f68d upstream.

If there is any non expired timer in the queue, the RTC alarm is never set.
This is an issue when adding a timer that expires before the next non
expired timer.

Ensure the RTC alarm is set in that case.

Fixes: 2b2f5ff00f63 ("rtc: interface: ignore expired timers when enqueuing new timers")
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
[bwh: Backported to 3.2: open-code ktime_before()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -765,7 +765,7 @@ static int rtc_timer_enqueue(struct rtc_
 	}
 
 	timerqueue_add(&rtc->timerqueue, &timer->node);
-	if (!next) {
+	if (!next || timer->node.expires.tv64 < next->expires.tv64) {
 		struct rtc_wkalrm alarm;
 		int err;
 		alarm.time = rtc_ktime_to_tm(timer->node.expires);
