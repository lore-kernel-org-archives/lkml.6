Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480031-2-16639304232657364022
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
    1523480030; b=kolQyrwlrRtoXuJRN97Mk1L5jW/zF3fu8ARrJ/LPbbkpnqo6lv
    NBSdsUh2ZJ5Z+pL1jEnacA8eyd6mtbqCj+Bp5AuUV6H2kMLguCZqcR2Ln1YxOIJ8
    hrl3IIH9hzH66cPFhem0BhvJJiIH4iksClvfdIsOh1jmLuw9kECM+bIDejTZPSSG
    wPRfPi6Pzg34dwtIAic8AMLC0v0KYPVneOsLDIlqmtuLLwXoTXpicoFaNd6q/OXK
    qKaKbwdu3tfaAn7GT4FXF/MxSaXrOVAJkkAJFlhDy6Ak7AnwfT/gHMI9T21GQe4B
    3jtBegBIyxv9lX5+yRLYtdYAbDmmmle4q6Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480030; bh=fp8w1t0xKK7Hu6S3oXq00+0ZxzqHfq
    AaIeg4N1J5fKc=; b=ZOQJHqDD3wMyDOJfj9dJJJOJhQ6OSK2hIkF3P+u2WIrRiA
    SwFOODejsp5/BsvdcpzFl9yQ5YEpBnKNBVi49ayGZFma0/Ypx7tS6b6QtIHNhMnl
    AueowbI1RUQGnynkjgDAOtUnXndyOnwPRVuAk0BMadPfdZWsvjtkMr+aiGS9RgN/
    Vb2YP24+EXdOeJzQ7J8ncopHc77JeK0eKqqKa1J3jP1f9iSdqSrBf+Z5YmSNOSte
    /VokrXp1z2pGuZdm5Ki9XAm5hY7vRPYg4/1f+0/mRyT11yM7CmuVFctPDHxFJhWd
    puz06/LZp2kvVazqzKGg+nRfQ/30/XPQDgPzrHPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG4J4mGfFhZy/Nm9TgZbEASU+kkbUtEgTBcILZDeRHzouK09cUlaMBsp/Pl5ymR9GW3NjzN2dWB0JmW24kic1GiWFA/0ofRz5qGLTeQvv5E32h37SnBb
    RZV2cW/Ww36yOWZ1z7l74CmYWEvN7rORA3XcA8GYJ/9ckK2v2uIcHlqzHiOV/godrNwcUbrB2mfGdGyGHP13tnCMIUZVeJ1mpDJFGeWcYDwXac27p+wccFqZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=_jlGtV7tAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=hIIdkus8TNf7Xlx8YsEA:9 a=aL_N7TG-RDuqdsZS:21 a=Op60pOaCWP3lT6U3:21
    a=QEXdDO2ut3YA:10 a=nlm17XC03S6CtCLSeiRr:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755042AbeDKUxf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:53:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58520 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755468AbeDKSpN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 024/190] Input: elan_i2c - check if device is there before really probing
Date: Wed, 11 Apr 2018 20:34:30 +0200
Message-Id: <20180411183551.563505141@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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
