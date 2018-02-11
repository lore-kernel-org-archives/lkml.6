Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324578-2-6008713046571192649
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
    t=1518324577; b=Dy5yF7BTLxtIdLe4BYM4FyOxkDURCYpH76iNOVu/kHjyuDc
    RnRmeNxZwyPftg2PQiq1XLp0ROcmiKkSYJ8JJDPyMc28ipG2kC95s5t0nQEqOQ3f
    TI7JCRIGhpr+GL5Y6b5lCwQhhzhtZTgpAYs45lILw4AN/Pdt+jvjiJybgr0G0oE/
    NLjmbn4FruqijgksXS4+tKlFPK/HQTJyykEeI5JlX+eWm0U+3y8Q4rXrU9VXmzTv
    wh2VYYPypDbK+3lLzmZRSpGZkZapJH/sgKZdKUoRDvMRG3pmruBgo3J6HXIkhiLp
    edPxJ/uUuPV5mJdNNeRBdrJSh4yg5So7lIEdgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324577; bh=78dSlsvNLzEVIUhZWrO
    vLt5Pr6qaIMhjFlgF/q2tG0s=; b=u1LeA0q6AURfGyH8Ut6hvH+8Vtw3kjWwmkc
    jIvYITQJEiZ5ZxsB2B5QkRKMIVdYyQMn0X0ARjBCWbjH8p7lygR46jrThSwvX2p3
    +03KyNHCPimzvWQHR1wKERjAzOUwuYTGMvHmqptyGcP7OxMH+HyAWzj7Hi38AWT3
    XT7wu8E1LtorpwPBWRe4eS6x+ZnJrZxL2B4hYwNOIpaons5eQr8wpy3+RZ2A+rkS
    eCniyoKh7i6RkjrnK22SIdrKDuQqM988WQK0UyQojftSv90K4+tqoOj1wgxPW28H
    yGCFbzpxlhMuoEXSUlpSJ1VHJxbBwnJK5GOQzZddz/hi3tTOgJw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeBKErt (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41826 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752847AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>,
        "Andrey Konovalov" <andreyknvl@google.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.432426794@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 107/136] ALSA: usb-audio: Add sanity checks in v2
 clock parsers
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

From: Takashi Iwai <tiwai@suse.de>

commit 0a62d6c966956d77397c32836a5bbfe3af786fc1 upstream.

The helper functions to parse and look for the clock source, selector
and multiplier unit may return the descriptor with a too short length
than required, while there is no sanity check in the caller side.
Add some sanity checks in the parsers, at least, to guarantee the
given descriptor size, for avoiding the potential crashes.

Fixes: 79f920fbff56 ("ALSA: usb-audio: parse clock topology of UAC2 devices")
Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/clock.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -43,7 +43,7 @@ static struct uac_clock_source_descripto
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SOURCE))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
 			return cs;
 	}
 
@@ -59,8 +59,11 @@ static struct uac_clock_selector_descrip
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_SELECTOR))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id) {
+			if (cs->bLength < 5 + cs->bNrInPins)
+				return NULL;
 			return cs;
+		}
 	}
 
 	return NULL;
@@ -75,7 +78,7 @@ static struct uac_clock_multiplier_descr
 	while ((cs = snd_usb_find_csint_desc(ctrl_iface->extra,
 					     ctrl_iface->extralen,
 					     cs, UAC2_CLOCK_MULTIPLIER))) {
-		if (cs->bClockID == clock_id)
+		if (cs->bLength >= sizeof(*cs) && cs->bClockID == clock_id)
 			return cs;
 	}
 
