Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477186-2-788151518030224758
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
    1523477185; b=jZ6yey5cfNlMl5EJ9zSgRlVoXmJ2Jne8YWL84BxcMdxP4jjcG5
    Gh060mGVeC070SKC2jYGIwqLUdD2EOZsYo6wrQ3d33kL6IInsOqQS+QfYJMaweOw
    uOTwXPkcAQ8KRI4WjGhoVHhmTde/JynFIyG+sMxVYZ2+g4EEaXdZzdN320bemTpF
    MD2gS4P8wrUusDYRvSJ9Z23swAsc5ZpsT3C1EsSH4yNgTZt6kzRivOrjMOhgakU9
    +CJlivk6vDQPSxjhqb38US4p8t4ZEuIQCZxvkdGCxyS7NbMPFVbmV2HgPWWV3Qff
    orQ5XOI2Q3tiZ8xCnHkdCn/Oz7QsoGQijmzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477185; bh=SZ1GwdNtAquJx57JhH8i1l0Q3n4LUk
    5DKXQCWT6V5bk=; b=vjM7u6MSge2lmTI7D9mlPuMO5LZswMr/YGfomKAiDGJle3
    htq1ykpF+kWa9ixS41bbmng0H3SwT/u9IExLBiuNpcqBXG7QGWkTPDdy5EZaSXDK
    Q6M9S8LOdCkXa1XwM39iyZ6w4AGXV3j0aDs0encu86c00nMtzR5nWz2ETkdx/3kR
    GSrqOpdGb0oEOUJ3sQK97UT23WoUOFzCWz/4J5MuxeYjxFb3ulls1Fr3AYz0R92T
    1ZXunF0EUcCTAybZIAX+aS39bm2V8MfxNtprFwkgsKSuXSm8zAnd8e/AuZIL1vNS
    usJo6caPCKTZLrJ0FtAoo14GDzuR0JPP1h8MVWkg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfFPttAGI7UpuTC20uOtANpCZWeAul2g//PS/3A+OuEJR/W0w8fpYBPzlMvflmpznaHg1zoE2AdGExdm+F6+r/JbyElbJZMmdKVgCZn4g22GBPsDkCd/a
    b9ZDyQQ7nSBiAeNGxvNXKssZzTD3qR9EKMRwpkjKuvvZoO4T8pcb5OdVxAlGv3gQElyHgrAxuAfbbm3SjNQYoVl9FC2m4D5ae88aCshsgFyAi1+MTesrZ0f1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=vrZRev11AAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=1fmkquyJTycUkjhl2ZkA:9 a=QEXdDO2ut3YA:10 a=vE9JzVuArQVVuPm_qWxV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933709AbeDKSz3 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933707AbeDKSz2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 034/310] Input: elantech - force relative mode on a certain module
Date: Wed, 11 Apr 2018 20:32:53 +0200
Message-Id: <20180411183623.745384441@linuxfoundation.org>
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

From: KT Liao <kt.liao@emc.com.tw>


[ Upstream commit d899520b0431e70279bfb5066ecb6dc91d0b7072 ]

One of Elan modules with sample version is 0x74 and hw_version is 0x03 has
a bug in absolute mode implementation, so let it run in default PS/2
relative mode.

Signed-off-by: KT Liao <kt.liao@emc.com.tw>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elantech.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1711,6 +1711,17 @@ int elantech_init(struct psmouse *psmous
 			     etd->samples[0], etd->samples[1], etd->samples[2]);
 	}
 
+	if (etd->samples[1] == 0x74 && etd->hw_version == 0x03) {
+		/*
+		 * This module has a bug which makes absolute mode
+		 * unusable, so let's abort so we'll be using standard
+		 * PS/2 protocol.
+		 */
+		psmouse_info(psmouse,
+			     "absolute mode broken, forcing standard PS/2 protocol\n");
+		goto init_fail;
+	}
+
 	if (elantech_set_absolute_mode(psmouse)) {
 		psmouse_err(psmouse,
 			    "failed to put touchpad into absolute mode.\n");
