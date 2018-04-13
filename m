Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3937186-1523632692-2-17984321565060665410
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523632691; b=p734BwrXntkhIq7MTDLrk53nHcyn/a4d7dDZ5OegGdB85DSQhj
    UwfoJGfw+NevqYQSzdAHAF5IXxpVRKiPUw3BjpH4MXLuQvh35l8u2dXiJz67T4Xc
    emsxR2iovwJREJsFjhxGao51Puf4lO6ZrNDiLCLE54OLxpGtbMZQBrlqnSWoEUfw
    0GACYq2yYb+E3fgITM81JNzMg80inebJIujrUeEtc5A0nZ2PFHqZ/LOE+lYb4yiB
    VnjVwJWekmVmXXdD/nyJ1a2MpXRAp4VvZVGxmzJ2IrUSfh34PFIdroqHBkyJwfGA
    8zoLcUSSspSMpYU7yV7mTlM/J2vDimOAMfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523632691;
    bh=LmC+UT1Dd/fIuMPzL6KUhhaEL6Z/T/LSQMaguWiBFlM=; b=Y29YV0EDAW+/
    m7KHlzkKi4XvjthEyTDF1GvYz8ATlgJXTJ3gcdmRFQfAxt6xkO29ONazlMMka+qK
    CxwYaVF9BOIQF07m0JmUCaAh9GNkgT4urRr+wipfv34wOdN/ZUVau2Aul007V8au
    qHHR6CG53XCH9tGXUWzwEf35DeVBCg4U9QekquCjBQZiDzCf3rfj7l3hS+gZhUYG
    ljqVTF6vM2sqa9jdSg+b2O3IxQgwoFn2qBmLebs4qTSTaXAHxOZ4w6VJIs81mSmU
    cmkP7GlRkrwsHm0B5bWLNz6JvJfcX1a3+cVadxSprhnlhSn3hKijKTapDVa5lKsP
    A7gWLjnsyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b//J/14U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ETStv9he;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=b//J/14U x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ETStv9he;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJp08w8DyTTR9p2Db6dIYiXW1XfTnVIELrCTKD6fcuVL6TbQNjjhDdrtxnahbTAjjwm75w8jOOEkTE/KBo2P6fxpSkBP3zLKgHp3kW5KTNT91KdwquJL
    pTp3SxXEEUr1tHSow5AfSDa32JCWs65C6j76e07gdOXZA7PgAOyg2E0hjJvSmn/frKb2R4bfLhGU86Rew+wmDSA+XM0/MhEDHzL0mSA8P3PEJZiNqB22fOSF
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=fudEY3DgEpJWKArJv6IA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeDMPR5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 11:17:57 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35145 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeDMPRR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 11:17:17 -0400
X-Google-Smtp-Source: AIpwx4+mP2K7TTtG3ul5vXDjZ+ED4Yy+QjiKqA+0Gb0WF0y+b0m/fqfxTA5vw20fgXTiqOoGq3CXJw==
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/3] USB: musb: dsps: drop duplicate phy initialisation
Date: Fri, 13 Apr 2018 17:15:03 +0200
Message-Id: <20180413151505.32663-2-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413151505.32663-1-johan@kernel.org>
References: <20180413151505.32663-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since commit 39cee200c23e ("usb: musb: core: call init and shutdown for
the usb phy") the musb USB phy is initialised by musb_core, but the
original initialisation in the dsps-glue init callback was left in
place resulting in two calls to phy init during probe (and similarly,
two shutdowns on remove).

Drop the duplicate phy init and shutdown calls from the dsps glue in
favour of the ones in musb core, which other glue drivers rely on.

Note however that any generic phy is still initialised in the glue init
callback (just as for the other drivers).

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/musb_dsps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 05a679d5e3a2..6a60bc0490c5 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -451,7 +451,6 @@ static int dsps_musb_init(struct musb *musb)
 	if (!rev)
 		return -ENODEV;
 
-	usb_phy_init(musb->xceiv);
 	if (IS_ERR(musb->phy))  {
 		musb->phy = NULL;
 	} else {
@@ -501,7 +500,6 @@ static int dsps_musb_exit(struct musb *musb)
 	struct dsps_glue *glue = dev_get_drvdata(dev->parent);
 
 	del_timer_sync(&musb->dev_timer);
-	usb_phy_shutdown(musb->xceiv);
 	phy_power_off(musb->phy);
 	phy_exit(musb->phy);
 	debugfs_remove_recursive(glue->dbgfs_root);
-- 
2.17.0

