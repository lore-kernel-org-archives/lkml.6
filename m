Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826723-2-7150750078922092818
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826722; b=jwmJMhGRmwrMEKKvH4+5UBENphEXL8kI5b63ZTNPzWklCSm
    ITI7h9G3+5GL+HrPSsSusiuzhR0uJi93iUhL2cRsgarUpA9/xkE43k/sVSaaISxA
    cXwv7MILNjCHX2d4mPwrMobJOyEzREqEtWcEFj6+KVqOT4fdd2h7PYVk4HxBsDL2
    T+fDI2rD9SGpU8MG6/cCGRnycb2EBa61ktSh1j1bfFcDK7g1EY+lmpRPYdRfBqFr
    eZQPslYXQeU9PQlyvT6lPGpMGRJrhImx7WV4ve1X+rgRTQ5U54kMcIfQhJeOS2FC
    3zPSZe4zQpMDLO4ySumsFO746SOatDkkAcwgurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826722; bh=ePiVywAwdKogKpjrZT+
    ul+jDyPPMab7uNHhS/iKyD88=; b=K148772aeNt/zf7mizgOjr93MiwFPRpbAeA
    +ErJLiSF1ELOqK7vtvQAubDZsN1ZFfrSBXgv+SL/lc2GsiX7Z7TA9X2Ueo3dmIdk
    pJW6YI3SHbPP5mU7XR8C4g9pMH8cothhQ10cdjnS1Joeqp6mVS1zzn8z2F8sOrTH
    WySI+8nCjZUSEU78DELrGdEdL71EtjGw4bFpxAnP7w3By40mtzi3Hm7Npvj5GGeS
    5v7Lf6QZm0So5SfQbSh7cC+mUvyugQZ0dPCvhhow3aENUQc54GoE+rYLZDiNnfRg
    wGNN7GTdjQMjyJShywkp0J6yCOmoV9d05h11Sr5CfkROifUIGKw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeCLDwA (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:52:00 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41033 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932572AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Felipe Balbi" <balbi@ti.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.892374881@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 012/104] usb: renesas_usbhs: fixup __usbhs_for_each_pipe
 1st pos
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit c2fa3edc58a262dfcb7aea78e24661e90e00098c upstream.

__usbhs_for_each_pipe() is the macro which moves around each pipe,
but it has a bug which didn't care about 1st pipe's position.
Because of this bug, it moves around
pipe0, pipe2, pipe3 ... even though it requested pipe1, pipe2, pipe3...
This patch modifies it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/renesas_usbhs/pipe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -54,7 +54,7 @@ struct usbhs_pipe_info {
  * pipe list
  */
 #define __usbhs_for_each_pipe(start, pos, info, i)	\
-	for (i = start, pos = (info)->pipe;		\
+	for (i = start, pos = (info)->pipe + i;		\
 	     i < (info)->size;				\
 	     i++, pos = (info)->pipe + i)
 
