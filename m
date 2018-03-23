Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803736-2-3714024218668490209
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
    t=1521803735; b=I2V+nst8CtR0uxt3+FWtU9e+sPLOyZu1yDUuACE6vZIfPjz
    f0mnF81k77KrrpovixrO8+YudWjcWpeM7Werq02QQjKbVBV0lrEboE19Ve3VCPiw
    rNldJnfU2rBznuLbIFa0Oezfx9Tir6keF3LUrq/jvKnbkkra+HB2jfFKzH/Lee+t
    Diet57vgn+tEtNYjXvALg+xmaGX4xZy2QMoMoFTp19rPQWr4ntbPQax1VZABvd46
    NqYVBSXPK6pHpwhi265gbaU/FIl4bwKnZ4T/5p5Jg30kHv6jGwIB4gnkVKiGrGuf
    yPU57He6EuIixGU3M5pcEUB2zEv2mGmuObRPnag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803735; bh=IFpWUXO1InVM9zv+x5xKKO6+ri
    9Ty9wlGXMsTQAq1RU=; b=VsFQt+hhCkpNPJ0uZDL/gyjDBwIFnCTE0nPOpDPuso
    W2mVcfM8CVZDrlq3rwn8lFjOhQxpU6W87VBWoFPVE/fCR8wXoeWMIrFBhZaq2sfd
    blzh2VQJQtww5qECrAc07Vkyr6j4/r4f7s6MxVTfKPb0r3UCBK8ZX8/Zqf/rXgMu
    WBG2f3eA45HZN2hc4gWbeB4gzPrqY8LpeyHr4RyM7lSANm2fzyIXLvpe2dbw+JON
    qoNgyfzOivzq60ZgAW+W1iH2if0RQHC9fW71eMOkrtvR4ZKI+7wlc84a5Xpo9NJ+
    0xmIHvH+A026VYtzSf8BolQrC4/7teTRcvjGU778vS8Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751903AbeCWLPV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:15:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42386 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932539AbeCWKKF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 114/177] Input: twl4030-pwrbutton - use correct device for irq request
Date: Fri, 23 Mar 2018 10:54:02 +0100
Message-Id: <20180323094210.286242420@linuxfoundation.org>
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

From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>


[ Upstream commit 3071e9dd6cd3f2290d770117330f2c8b2e9a97e4 ]

The interrupt should be requested for the platform device
and not for the input device.

Fixes: 7f9ce649d267 ("Input: twl4030-pwrbutton - simplify driver using devm_*")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/misc/twl4030-pwrbutton.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/input/misc/twl4030-pwrbutton.c
+++ b/drivers/input/misc/twl4030-pwrbutton.c
@@ -70,7 +70,7 @@ static int twl4030_pwrbutton_probe(struc
 	pwr->phys = "twl4030_pwrbutton/input0";
 	pwr->dev.parent = &pdev->dev;
 
-	err = devm_request_threaded_irq(&pwr->dev, irq, NULL, powerbutton_irq,
+	err = devm_request_threaded_irq(&pdev->dev, irq, NULL, powerbutton_irq,
 			IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING |
 			IRQF_ONESHOT,
 			"twl4030_pwrbutton", pwr);
