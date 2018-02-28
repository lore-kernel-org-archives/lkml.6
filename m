Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519833999-2-15507953730176478768
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
    t=1519833999; b=HwdUIsQInqiEUyvvXfaA9NQuW2TTcx6ierllCmymK2zaXGS
    dZnseh6LxFlyoGC/sLseG7vJGPE5N3C8e3WsvlqFw3bbWhZ/Fn6zXa4IKExsrRPo
    FleffvpgzQdtRWDfhCl/u78WUZY3tN0bjweOhmc12bFiyVdREcGEpDgWJXrrq6fF
    bFgW6/w7Ek8b/wWO5J0+dFBRAs0ReCx6uWAwwvIBn3qPu/MnQjYJG09WFsqyVM1G
    NIbLN7NAaOnswdpZD6kCs8mMkLD69BL3L35SOAg/P65j0sFlaW2bI1IflFxXUf6u
    KOCJQiLsizRio3OjE58QdLiQrhMSPMkRFn/7YpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833999; bh=f3TCieg7mOPuoJUS9Ey
    cuMuQkXs4NH8d4XmPUZcrcCg=; b=RyVX9xbYi5DIy2C5hhS7z1kIWtZvStYtvca
    uFg1YcbmjQ3G6IdYd64an09c04Kgsr23aNucArk3BYI9aloEZzAgnmTVNXDz16s4
    QlEtpNCP3tm3UzRxDg78QFMGx58pbz0SefXWeV8fjFWHkymhRYorFB/IQjlqOPwY
    tKSQo0i3oFw5VA8si3Aqw8bBrfmhTJvQUSJqz6R2xeay0uOmx7kh+AtH3ZYYwBmA
    rCKs3FSmqyR9Q9aSDSbszGuGSIEKv+5i3dC9BXsT8vIaqOJIjijTxx8ULrVMJ6qI
    8gtJUbxAqMnulY+sk4yThrY5NGZJBqgOokPzRz6PA++lKWoAb/A==
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
        id S934501AbeB1QFi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34895 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932732AbeB1QFg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:36 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Aaron Ma" <aaron.ma@canonical.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.512233043@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 012/254] Input: elantech - add new icbody type 15
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Ma <aaron.ma@canonical.com>

commit 10d900303f1c3a821eb0bef4e7b7ece16768fba4 upstream.

The touchpad of Lenovo Thinkpad L480 reports it's version as 15.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/mouse/elantech.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1481,7 +1481,7 @@ static int elantech_set_properties(struc
 		case 5:
 			etd->hw_version = 3;
 			break;
-		case 6 ... 14:
+		case 6 ... 15:
 			etd->hw_version = 4;
 			break;
 		default:
