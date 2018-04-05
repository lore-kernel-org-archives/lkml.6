Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3899735-1522967416-2-12371172436397339682
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522967416; b=gZHcKBRtCThHV6yZLSkPKO/O2K4FzqDoQlSqylm7Y66QhBS4bL
    6TBF3jeDEKemd1DTAoY2m1iEgZunlOvqai/9hX8JIM8VgaMxqy+XX4B2gloweD1J
    +VJ3WIb9cRubCBaRYg1EHIgkMHa1cmpY9UlLaJeo/iqiU1X2phuOhWhHBu2mJoql
    Chm6d4RkwvEzDbfT8u0yLY5MKFNqZdR7SWcITouuGygfzOrr/a1agLWvC1ukLEd7
    f7A9t6unPjQomGR8UNnyJUG/iEo6jXBNxh9CJvg8f0fv5ZvjwH3lBYlCjSHGYRm8
    zvxuTVpNQYu5naHS8Zf3kHlLBspq3m4SD1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1522967416; bh=4NSnhJqX1YSCB+/hAUGP+vhpfs3yqq
    LJUV5KRjsvBuY=; b=WAtBnL1pEK/2+SqlcC2lOgAJ1aYjLYkWMs5BLc8UtuygHf
    xaisw7pwTSIQwzkC6FqHN/krAIl4TbAe5hSLjEmIhOjB1zYnn2eggqwe1tpl6RlS
    jZA/cj3ybzhnAamYrOhbblhd0wQkkgfc3M/LTl1mLOyjrIEn8KMs6t7t6wEFhHHf
    z3zX9Lsc2gdfzfAw5seShj8q9DCIQKYdDiWmLC+/t9vPnPk95/ZyawH6lJlT2M91
    r6gNX6j44qcfq/H38BN/CUcGNS6WFSa3vgw9irK1/uXNKoh6NXfGg4/LewvKmwXB
    A49jd8fyLnE8LCKax/z4C7SShlDmVawJ5PS9WG0g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=osg.samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=osg.samsung.com header.result=pass header_org.domain=samsung.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJgq7CkouveUP8HTtGcRXECSuUtXG0KNHMMjgEpUeT/SoOc38JgKrxdJfPpNlvM/+WttO/kMbKQSDmYLnrh2l6ap8BVpJloRYQi4h/7nTJm+OXZ9NiZM
    TjlmdXvW/0Vl0sI3kU1ieQ2DcE7Yd/x/cUXIPnhlJCpHyCc51xewExdwvaRIMwm5c9xEo325mqQL+mV7ICY9kzqtsPJB4s4OxzDaT60eFGukOkelRRUjL+QM
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=hD80L64hAAAA:8
    a=VwQbUJbxAAAA:8 a=oDtfaQmIDhV1PU5KHfMA:9 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754135AbeDEWaO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 18:30:14 -0400
Received: from osg.samsung.com ([64.30.133.232]:51951 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeDEWaN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 18:30:13 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: [PATCH] usbip: usbip_event: fix to not print kernel pointer address
Date: Thu,  5 Apr 2018 16:29:50 -0600
Message-Id: <20180405222950.24495-1-shuahkh@osg.samsung.com>
X-Mailer: git-send-email 2.14.1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Fix it to not print kernel pointer address. Remove the conditional
and debug message as it isn't very useful.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
---
 drivers/usb/usbip/usbip_event.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/usb/usbip/usbip_event.c b/drivers/usb/usbip/usbip_event.c
index 5b4c0864ad92..5d88917c9631 100644
--- a/drivers/usb/usbip/usbip_event.c
+++ b/drivers/usb/usbip/usbip_event.c
@@ -91,10 +91,6 @@ static void event_handler(struct work_struct *work)
 			unset_event(ud, USBIP_EH_UNUSABLE);
 		}
 
-		/* Stop the error handler. */
-		if (ud->event & USBIP_EH_BYE)
-			usbip_dbg_eh("removed %p\n", ud);
-
 		wake_up(&ud->eh_waitq);
 	}
 }
-- 
2.14.1
