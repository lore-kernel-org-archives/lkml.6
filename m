Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324688-2-7047838864932244416
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
    t=1518324688; b=ZAK6FZQbFw01tteaaS9bLvU77GUZk+8ew+7MYRAIFRgZwfW
    h2g99otekd48DUc2fY4Zn7MZIo6Yvfvr+tVfcw5JYq5LrTACydPM1laRouY4sXqO
    D+P1kyMzOZAMaOnjFq9oX1/7zBPSIHjPOwJistS/OTL6QvC/cLUweNvyn5lvBEoO
    41GxjvxRoP3vsbuSj99rk2bwEX/8xKiGXgBd2U3xF24nZXix2C6Z5wZY3nhu/d/F
    kfggoWnmgd0NTCmepAhq8+eWHl/1kYuYVFwMvPlxnJsVmf++e1ReSRdba5h/lcbi
    RDhWOBZkmCurLMLB1EgPfvdUlv/2+NyKiJ3O1lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324688; bh=SjdpBrAd953lo+024Wm
    S9IdLoQs9RA7OUHJ/zbJqbtc=; b=lie0E07yyIyFxMS7LmrfBdLqgj6zVwPwTr8
    ZqeD1LDEk+60UTEEjgo29DZNouUjv0Yj693Ql/mdIQFBNCInfmT8upRDyGtZlcm7
    katfr/ndJntzNXyMkwsWcDl/BOkUHQkwp2acfHWKdy7Kl3+9sZh4M5n+Rp8lZt5F
    l8lEv1jeoI0Ib62KQZ6Kh/wlojB5nmFtk1qjUxeUeHRCslnorV4ZDVfNzC+XPZjG
    hkqalBg69SnFlL2/JvHXIGWQHH/vEJFazOYaqAPZUXYwvhWCgy9F+eUXai3Og9D8
    bf+uR6vWtn+UVuQPLJNPjUL2bwfk2i7LZzV1VmJbHgylWRSV+Sw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753494AbeBKEux (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:50:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41789 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752829AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Takashi Iwai" <tiwai@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.998716058@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 105/136] ALSA: usb-audio: Fix potential out-of-bound
 access at parsing SU
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

commit f658f17b5e0e339935dca23e77e0f3cad591926b upstream.

The usb-audio driver may trigger an out-of-bound access at parsing a
malformed selector unit, as it checks the header length only after
evaluating bNrInPins field, which can be already above the given
length.  Fix it by adding the length check beforehand.

Fixes: 99fc86450c43 ("ALSA: usb-mixer: parse descriptors with structs")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 sound/usb/mixer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2020,7 +2020,8 @@ static int parse_audio_selector_unit(str
 	const struct usbmix_name_map *map;
 	char **namelist;
 
-	if (!desc->bNrInPins || desc->bLength < 5 + desc->bNrInPins) {
+	if (desc->bLength < 5 || !desc->bNrInPins ||
+	    desc->bLength < 5 + desc->bNrInPins) {
 		usb_audio_err(state->chip,
 			"invalid SELECTOR UNIT descriptor %d\n", unitid);
 		return -EINVAL;
