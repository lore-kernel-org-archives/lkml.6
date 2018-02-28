Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839553-2-9090686375803838588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839553; b=xCf3vSU4t9RHsQElxmPZbg55VpK4NuVW3bCmLeYKzw41ge2
    Cny9bx4YtyceBTry9iT8d7FLwWv8E8uXtlf0je9NP3m+MuRjhovB3+qCqBupD/OE
    KNgM17FDP3cTirblBCP/y2WN2Fd7cV86FSrz0WNACwcuHUEaOMXyl3IXb4ko46E5
    cfcRFEAMPM06T3wx+7sN6xK1e0tG8dQUh7dKtt9KeNBap8hF2S91dIdClJBsiNaN
    hiDQOdw/3C0+KmWfPfRfkxr2Pds2R7pe8KDwLokG0YJ3QRbR0UoYP262FRX9nWIH
    IBhct1x3igVh3kj2WiC+Vv+YBuYJBcnsf0rKqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839553; bh=GbwJhL7ifgC0pLDXGi3
    8ecpblLzF0pdzNZraKltyi8w=; b=tlbiNXFELv7k4zo/z4X1HMsDnBJjwDUYdpt
    ELO6RueSLArPV8lGznvWxsHsTk7SPkw8kErEEGiIl57csEWzjoYb5lwfuoJ0fwe4
    l8hbBMgQkNFet7gKR1k9H+9mCZYv/r9M8w/oZ76ZXTZg78MoaXKuTEVZkSOaMbkg
    jwMBw3Z55qO2ltpErB9HENcQxeyaWtTgmln5foweBe8DTvfgtXxAvK27JQleLN2k
    4TyM0ieNHYHu3z/bRJokm32GZ2IqFwYXZ4dmhs8t5OOnue7oqi1LKR4axAahmmge
    V+kAWFSctSVcez+uvH6p5CCEdTEg9k2KilPXcLMS7h3KUeiSXyw==
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
        id S932640AbeB1Ri1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:38:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33182 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932537AbeB1PWN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:13 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Oscar Campos" <oscar.campos@member.fsf.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Peter Hutterer" <peter.hutterer@who-t.net>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.55149759@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 115/140] Input: trackpoint - assume 3 buttons when
 buttons detection fails
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Oscar Campos <oscar.campos@member.fsf.org>

commit 293b915fd9bebf33cdc906516fb28d54649a25ac upstream.

Trackpoint buttons detection fails on ThinkPad 570 and 470 series,
this makes the middle button of the trackpoint to not being recogized.
As I don't believe there is any trackpoint with less than 3 buttons this
patch just assumes three buttons when the extended button information
read fails.

Signed-off-by: Oscar Campos <oscar.campos@member.fsf.org>
Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/trackpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -298,8 +298,8 @@ int trackpoint_detect(struct psmouse *ps
 		return 0;
 
 	if (trackpoint_read(&psmouse->ps2dev, TP_EXT_BTN, &button_info)) {
-		printk(KERN_WARNING "trackpoint.c: failed to get extended button data\n");
-		button_info = 0;
+		printk(KERN_WARNING "trackpoint.c: failed to get extended button data, assuming 3 buttons\n");
+		button_info = 0x33;
 	}
 
 	psmouse->private = kzalloc(sizeof(struct trackpoint_data), GFP_KERNEL);
