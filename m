Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477244-2-15518807284609521776
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477243; b=VZPfft62dpcSS0lYQHrGdPx3iZAwjLK4OJOkZ5Dka6f9sAp4aO
    iHxgA1s9pI3L4wLTAfllbr4QIlQILvjhOM48lw0DVEFj2Imly+AK2xcFhqLsNy2i
    CUcI3lGpfuxRlOVCvHDgKNX/krhHT+PeKl6Xfw5uckNEDwzRmj+Nq8kKRxx3UMY2
    03hj7yamiueFYykm0SJUPvUahit79hLqNA6LyX3QQLwlW8l2LwrttNWcvOg4stQ6
    VygfkFsSm9EmMA2jFVrUIK81GXWPCjLUBkBcwZK711vYAkJkqbeswRqrVwTdoOQA
    A4NdZMOBLELUpP+xCF2RBd6hQm+Y6ZPKnJVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477243; bh=c3XAMUenoz41o8kga/o7WTj74CYqTE
    oV+qxxrXo9sB4=; b=BOOq3wLzEEc1ssoy9KsMJjULY/qIJrWu9UGO0bogrtevZG
    X90hQOI+z2I73TzM3dWnBb5mrJXvrR/Slx6JHbmAPRAlWaSJzBWx0DBhb2TYYgo3
    Bsw4JHPGWHJxagP3Rkr43WS94BMcrRnu5mXmsNDithjEz2n/xuZbpr9e5Mo22ZRF
    8bZTGJ8tYuIM8Stmdo+T58lYghsQiM0PQ/iUdEHQpuzasRGmF+FreMQeB9POGHe7
    u7vMubNmW0uMSpgScEjluui3YrlBiLRV74nCZNBDEwVYyNJ0iMWcV9veSCANTLfF
    roUOsD+Qc7GfhktNbYhxi770eNnMUaKgpmCFvh4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJwvaNjpWdEJrc0GAYc3B4JhhI6/e0ETbdhaToTo/n84xBA+MToZpJHwDRsA7m5b1Yc06KIcl/TLo6eYtTsITZ033nY9vz8U8AJhYnYew9DRblr08zci
    2vLZ0a+FySKshfATFl6WpaJ2qzYm8v8FgS8lZf/oHeBz9kiSrpidH2H4ch7dyEtZ6iUm97oQvLpAuVpG8oMbiuZrAXIwpVpzyI0wrSSNzyWvC/VvRstgmmxP
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uP1ucDPQAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=lgeqxb1-TE-wKjQGDkEA:9 a=QEXdDO2ut3YA:10
    a=9a9ggB8z3XFZH39hjkD6:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757335AbeDKUHK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:07:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34924 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933650AbeDKSzJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 059/310] ata: libahci: properly propagate return value of platform_get_irq()
Date: Wed, 11 Apr 2018 20:33:18 +0200
Message-Id: <20180411183624.775452151@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>


[ Upstream commit c034640a32f8456018d9c8c83799ead683046b95 ]

When platform_get_irq() fails, it returns an error code, which
libahci_platform and replaces it by -EINVAL. This commit fixes that by
propagating the error code. It fixes the situation where
platform_get_irq() returns -EPROBE_DEFER because the interrupt
controller is not available yet, and generally looks like the right
thing to do.

We pay attention to not show the "no irq" message when we are in an
EPROBE_DEFER situation, because the driver probing will be retried
later on, once the interrupt controller becomes available to provide
the interrupt.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ata/libahci_platform.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -514,8 +514,9 @@ int ahci_platform_init_host(struct platf
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq <= 0) {
-		dev_err(dev, "no irq\n");
-		return -EINVAL;
+		if (irq != -EPROBE_DEFER)
+			dev_err(dev, "no irq\n");
+		return irq;
 	}
 
 	hpriv->irq = irq;
