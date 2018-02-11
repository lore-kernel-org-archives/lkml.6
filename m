Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325414-2-16650340618125779437
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
    t=1518325413; b=Wfi3GCbPXU0lQsm467LEYb2D8pneBChnIWoAoi9vrKr70qR
    EIQzpNCaVuxcf89wo2ioI0/rUjVscnm+CO4O0IUHo/8flWgFN7wKA6OnAPNEJhY6
    VUTM2z+axTLzIJDHS7Xn/XPRXpGFIIKrgTI7eMdpM/BIKBGgBlt2feOWN21Nv7uD
    QfunDE4fPmT0d5yQqengkVJt+1PbaQIhyp/7JLmnsy/cfpOkIKjsBjO2v7J1b3/l
    XYG2LPWJaNpT1V7GKcK3tx+vShDLqcREqAGssgIXWFEtx1WhtVsTQsSy4LUpWTd6
    eYT4lkdswfvAsrq+yUqp+LPcvxSDr/Bt4VDBJAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325413; bh=ceZCmMW9YuyfsVl6T6c
    XdWSymgZUr4sjK094cv2MHXc=; b=ffK+0/y/67oNxT9vzVJC0EsKJqVCyZrK+fr
    hwNSTjR6kKs4eFV49fioBH5F/ALfIxNY1cUl+NjNVUM+r9LY32fOXui7QSBBH9sO
    EStL8qbV4etjxjVt8ceU8OZerJ540tMg8/CljH8QTmVJl2xWrX3tYfafPHuPBWQB
    h+W/pUnN32zb9ejAqb5B/t9CrSRb0QJjmIqM9i81JFZIpUqnynWC0msPsmVDAvAI
    44qrcQbzl/sbpV0m2HiYlc+vQpAW3eb/4+agrdrdwwurTQhvZO3HQNw538boOYGj
    7tbkoNzmD0cDhPKiyiuPlomIFL8hMkbxQFrg6Fu02GNU5KUtH+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753445AbeBKFCJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:02:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41649 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752761AbeBKEdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:55 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Arnd Bergmann" <arnd@arndb.de>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.776765081@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 001/136] drm: gma500: fix logic error
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

From: Arnd Bergmann <arnd@arndb.de>

commit 67a3b63a54cbe18944191f43d644686731cf30c7 upstream.

gcc-8 points out a condition that almost certainly doesn't
do what the author had in mind:

drivers/gpu/drm/gma500/mdfld_intel_display.c: In function 'mdfldWaitForPipeEnable':
drivers/gpu/drm/gma500/mdfld_intel_display.c:102:37: error: bitwise comparison always evaluates to false [-Werror=tautological-compare]

This changes it to a simple bit mask operation to check
whether the bit is set.

Fixes: 026abc333205 ("gma500: initial medfield merge")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20170905074741.435324-1-arnd@arndb.de
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/gma500/mdfld_intel_display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/gma500/mdfld_intel_display.c
+++ b/drivers/gpu/drm/gma500/mdfld_intel_display.c
@@ -99,7 +99,7 @@ void mdfldWaitForPipeEnable(struct drm_d
 	/* Wait for for the pipe enable to take effect. */
 	for (count = 0; count < COUNT_MAX; count++) {
 		temp = REG_READ(map->conf);
-		if ((temp & PIPEACONF_PIPE_STATE) == 1)
+		if (temp & PIPEACONF_PIPE_STATE)
 			break;
 	}
 }
