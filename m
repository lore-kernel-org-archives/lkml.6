Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477184-2-5794862459412536703
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
    1523477184; b=vQSyolW912n5VZK8Y8BJ0BeElgUecgDVUnw/AQbqAi6p9ywqTO
    QI4fgTZ7ZcFSlh35z3/r8Ki92b6FXszQjyY6G4ZFTKRk/BrDixmxZ+3ocJ5IvJNu
    PJSQty5TlHtLi3YxapMxB4xOnwkyg5SMysnYHb7gWg6j80vVywCN5F6NkNJtHL9r
    d7XUm0HgNtkWjWjWpSHJVUd+WTQ9Ri5r/Bpd/TLx2G7L2WaNdiDCcvVWQz6TMNJO
    mBLghZabzxcvNpxGo/7ojLpPKuzAOgfUizbjjvL65dkMG61JTHeAolcMVpsUUsAJ
    tTss9ZrUHPPlyumZZJXMAA7ZUzItnhaUHWAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477184; bh=Akzedk+3ontuOjCIRb794fx3yyf1/d
    fpeFQHdVD4lmg=; b=i0no56xUtH6E/vwU6ki0YGDj2xqyX3i9oGWJqSs1t4A8hl
    /MtOppdEZILHMsviB/ZQuAhxDU0LIQS1vUfpUVMRdd0eK8eigR86OruDjzMWlS/B
    8cH74pLKQklDh62EF+olpL3S0pdH//NguZBiQ3Di8v1qDJ9BA+TX6PDVXDAT+4Wh
    LsRz3hbx1dnYDT7KU0a5WKUqqKJTjlETo7awq6oKqL1vK2Il/+ncIGvd8okp5G09
    HOdm7+C2dadYmeCY2DcwqRNv4Op+4eUGRpTeawEX7upanB5dBp2R4ljhm/dhvC5f
    pqG1SYXE+/MtsZLpcUF0HdW2Rj+u1GW46yhz4JDg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIZ2WJSUiAh+z9mQWRpvlYl4PJnzsrJaYyGmcJz0wR65qQTzIIyy+0RB6CTEJrdrZj4HUtZPIYJFqofWoOV0lZBf98hjR5tgiIgj7vJ9O95NOrycZVaN
    gci3eO3qoJStKtiCvrv2dd0r3SF7p7LPvG5X9z4ZD6cvxPdSscLTQZtfdR/93Gfe9rGMz5mIF0K8MFKeQt8cEO4wrcBseKer4/Eoj98PhM4nJ6kYJSc/gAVK
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=hIIdkus8TNf7Xlx8YsEA:9 a=BaEEf6Te64OuLOrd:21 a=Op60pOaCWP3lT6U3:21
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeDKSza (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932962AbeDKSz2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 033/310] Input: elan_i2c - check if device is there before really probing
Date: Wed, 11 Apr 2018 20:32:52 +0200
Message-Id: <20180411183623.702032725@linuxfoundation.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>


[ Upstream commit c5928551fd41b2eecdad78fa2be2a4a13ed5fde9 ]

Before trying to properly initialize the touchpad and generate bunch of
errors, let's first see it there is anything at the given address. If we
get error, fail silently with -ENXIO.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/elan_i2c_core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -1082,6 +1082,13 @@ static int elan_probe(struct i2c_client
 		return error;
 	}
 
+	/* Make sure there is something at this address */
+	error = i2c_smbus_read_byte(client);
+	if (error < 0) {
+		dev_dbg(&client->dev, "nothing at this address: %d\n", error);
+		return -ENXIO;
+	}
+
 	/* Initialize the touchpad. */
 	error = elan_initialize(data);
 	if (error)
