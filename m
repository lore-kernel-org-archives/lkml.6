Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805184-2-14693395509105024000
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805184; b=ICLJa3RSRRhOgKOuUwqVjHhCsFit6tftL3m5lCvWJjp1jnk
    IpxDr6qMeE1/TsvNGY5X8bnvvRIy/vDeHnnxJyJEVcRISnrcNkIfNPSU4ZDXBX2n
    AL265NFzYKC7ZEAzGntfCrKZc6Wresz+JKh3dLDOuWTKCkQZ0+iBQCi2OMtByDFr
    Ry/IKeeLJpCySh/TnseDjtyX9sWxHRrYyPS3ARhgE0h8ayELiNkG9TTwAlf8z9UU
    h+6fBC57qvX+eNryKz4wSVS0WN0gM+HmvBzNZzihEepwSuAMCu+L2+pJ0y16SvqV
    WdXeZtqJypPZKRdD/urimDtxN6o/KHAWa7GiwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805184; bh=VUenVBdoBaI1bUTM6qbr6VqRk4
    KN7hJdylcW4u4T4+E=; b=YLnjkaqg3cwT1ph8BdZaRYdSDLMcowqaVwPkMXLjX4
    JvMS8U3SEFZIInmBmGBdsMg4jCUI1NQ6BajySnXrqgmZF3s0Wk2TFTq9MxWndRrm
    ki9m3yMFjXPKfxzEZp1l+4k+Yo+ZL9Vd+TtGVNetY5lLUYAoWWGCEFMAe+lVfidK
    54vODMeiHtrn2nI2fan6Jrer3AYclIz6XuypHmcV++mjkxlJ7B51RHf/QvcSHWoX
    Vz+EqXwg21SVeZNGMQofPNpqT3DVYVjF+UOWUgeWfROCMVDG6GjFIYvwMUA7NcNl
    8C/Am0flRmo1mszSmBAzpH2RSyIvr/4KeqYbileMO7Gg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754702AbeCWKEY (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:04:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39126 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754686AbeCWKEW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:04:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Matthias Schiffer <mschiffer@universe-factory.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: [PATCH 4.9 006/177] Revert "led: core: Fix brightness setting when setting delay_off=0"
Date: Fri, 23 Mar 2018 10:52:14 +0100
Message-Id: <20180323094205.493198018@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacek Anaszewski <jacek.anaszewski@gmail.com>

This reverts commit 86b9fa2190907f4f550d9d6bf490c5f89ca33836 which was
commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c upstream.

The commit being reverted has two flaws:
 - it introduces a regression, fixed in the upstream
   commit 7b6af2c53192f1766892ef40c8f48a413509ed72.
 - it has truncated commit message

Reported-by: Sasha Levin <Alexander.Levin@microsoft.com>
Reported-by: Matthias Schiffer <mschiffer@universe-factory.net>
Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/leds/led-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -186,7 +186,7 @@ void led_blink_set(struct led_classdev *
 		   unsigned long *delay_on,
 		   unsigned long *delay_off)
 {
-	led_stop_software_blink(led_cdev);
+	del_timer_sync(&led_cdev->blink_timer);
 
 	led_cdev->flags &= ~LED_BLINK_ONESHOT;
 	led_cdev->flags &= ~LED_BLINK_ONESHOT_STOP;
