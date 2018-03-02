Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1330670-1519988998-2-15309077251223804848
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519988998; b=S33Co/3XvGs31LeEgB1f7xZ8CpTQns8KyK1N+opqGEPQHvy
    Zr6tTpncmdk0FdKKUSdtfiyhzcMNAYpNIzi0T0dQS3Nt9X2Qs/sKsqXq6br+xJLQ
    Jy9njgx6qlMZmUFHzXxkZ+zOdQGVnz/rHFxXyHZtHpc7nHjicph3Ub6ecDyUClby
    nANATkygOLXvwoHX+RISpX9BF7NW/bTOLCCv8VyAbqcm6xdFUksUgjnSjR/USSg9
    vP6YgR3wOI/jPdYF5f0TjZMWD8gKuvx9mHVDIbiDwzEcJmAeuWh8c8QajJE+ua8G
    UO0P+oqRryKtVYMCd5ceQuZB3it6X1QkLNYFjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519988998; bh=eDSQnixTR0fcoLqAFIXWt1ESg9
    wE+zQmJcnc4lQl/lU=; b=Aqdi7o1sguV4y8ufdluYu1Jh306DkUgYdElY9DPh/A
    P1VwE0fy9W1DOKqDXZpMOMX11X77jb2g5hQX5Ww3t3B2jLfTYl+wNfO+RNdUOSy7
    w6tt7I7tYwEQveEvQYSoz5sb5LEkh/e2lebYZqEC6ePXaPvzIXHic8D69WMt7Jvq
    7reK4DOO5zbfxe+OaLh+KOIXgTMnhmALjw+Ohu1T+cRWu07Pxeni1KDciv9VsAzP
    JO5+5bTmPZ0jv9Ma53aTwtjgEJ7lhVve3D8BJGoDsRAPihzIFu45JcbOHd4GWH6e
    7z1yrWf3sgCgAZnORSGaO7HCfWn8ofnONiS1H+Xl9I4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423555AbeCBLJz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 06:09:55 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50452 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423465AbeCBIy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 03:54:27 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 4.4 16/34] led: core: Fix brightness setting when setting delay_off=0
Date: Fri,  2 Mar 2018 09:51:12 +0100
Message-Id: <20180302084437.007951262@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthieu CASTET <matthieu.castet@parrot.com>


[ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]

With the current code, the following sequence won't work :
echo timer > trigger

echo 0 >  delay_off
* at this point we call
** led_delay_off_store
** led_blink_set
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -149,7 +149,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	del_timer_sync(&led_cdev->blink_timer);
+	led_stop_software_blink(led_cdev);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
