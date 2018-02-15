Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2178418-1518719779-2-2953841376322749230
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518719779; b=PkD25h8WXc+G37BtQfTKDR3wUqsJCPIhTr7UJ+isPf8YZ8y
    UPSLg5I9t/d/8sY5QJuLirpcLGkRvrwZwPhvGNEnpN0e7tBw8DEZJUb8GcputElx
    pNn3Rz0gMNRb/Jcs+/4U+1GMHhuH4aK6P+3U4vl0N7a0OC2xukP7auVrtJ4YcFhc
    GilmR7xvU0SGsQQdmdYVUzqztsOYXRGwiAZ4+F47hApc9DMEE69ZB14/sBECHfpE
    LfaVHt3Ncnex11dZ9w3Q68A+tP11q11ZWr/LZa/LMu9DXqijZ3hzq22zaz5p1gMk
    M0lRlK4kBfrQ2uKLK7Y3LAzJS337amFGMqolgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518719779; bh=lyepY1z2GdYo0QYsDoi0vsyMz3
    wNLiLTP1T3X6hAjkY=; b=XgRJWkT3X3hYxgRy91wysC08Io7gmc/US64P50BA/u
    r2ZTQ6ozi4z3d3xEj/EOV38gerpR4ERdjCPn/WitmZa2mgnLz4/QV64U3HtIBk5o
    PRZzzmcu3iIeIv88b0c2QLrXE/gdezsjjr0l34Bryx6+Pilocbfr9VUYDPJtSD7w
    vvf2YjRW1E2ZroR/CQnKbkmF8gU3NnlShFrmm68BoOSBxuJapG37JSBxqJ0dxQ5m
    iks+ThlsCSXoluqVRn1fzGT5zgAJyVfCL+j459un8zM2RYvPLmqhJQWl9SmV+yP/
    5HBagC8kH2n5uiC75gVsrVts7gn9vYtsWGp+1qWt18xQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162875AbeBOSgC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 13:36:02 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51900 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162888AbeBOPY3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:24:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 053/108] media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner
Date: Thu, 15 Feb 2018 16:16:50 +0100
Message-Id: <20180215151229.799940328@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.267507937@linuxfoundation.org>
References: <20180215151222.267507937@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Malcolm Priestley <tvboxspy@gmail.com>

commit 7bf7a7116ed313c601307f7e585419369926ab05 upstream.

When the tuner was split from m88rs2000 the attach function is in wrong
place.

Move to dm04_lme2510_tuner to trap errors on failure and removing
a call to lme_coldreset.

Prevents driver starting up without any tuner connected.

Fixes to trap for ts2020 fail.
LME2510(C): FE Found M88RS2000
ts2020: probe of 0-0060 failed with error -11
...
LME2510(C): TUN Found RS2000 tuner
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN

Reported-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Malcolm Priestley <tvboxspy@gmail.com>
Tested-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb-v2/lmedm04.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -1083,8 +1083,6 @@ static int dm04_lme2510_frontend_attach(
 
 		if (adap->fe[0]) {
 			info("FE Found M88RS2000");
-			dvb_attach(ts2020_attach, adap->fe[0], &ts2020_config,
-					&d->i2c_adap);
 			st->i2c_tuner_gate_w = 5;
 			st->i2c_tuner_gate_r = 5;
 			st->i2c_tuner_addr = 0x60;
@@ -1150,17 +1148,18 @@ static int dm04_lme2510_tuner(struct dvb
 			ret = st->tuner_config;
 		break;
 	case TUNER_RS2000:
-		ret = st->tuner_config;
+		if (dvb_attach(ts2020_attach, adap->fe[0],
+			       &ts2020_config, &d->i2c_adap))
+			ret = st->tuner_config;
 		break;
 	default:
 		break;
 	}
 
-	if (ret)
+	if (ret) {
 		info("TUN Found %s tuner", tun_msg[ret]);
-	else {
-		info("TUN No tuner found --- resetting device");
-		lme_coldreset(d);
+	} else {
+		info("TUN No tuner found");
 		return -ENODEV;
 	}
 
