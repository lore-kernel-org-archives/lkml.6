Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021628-2-4402522331472701328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021628; b=qK+lPriWFg5CcTjOD5pm+Sacw7Pah+UOQ8CE6gsC8XzzXuXEVs
    7xct3bnswMe8Xw7Bqk2SadoQE28F7vy1/EqAwzWuD4IrfE8Y9RUzlpQIhVlmZtcA
    74pU0vknsGGfQPdsLjVjoA5QEFoGdFkTCggTo464IdyOGiM0jVyJ8E0NT+FYP+I/
    2oDYEYJlWHsNPnpXxfVViSGqLAa1xeMBFYnJ6C1qbujzV68qN2nt+5OFqBqNPfUx
    pdAR4xVTkmOp/S0torIfpflCYUvAKOVdUNsf9aI4Tb2JnLbFx3UEX9dPWS52rgfP
    a0fX1UpPKKa5I7MR5jEWFiS/PtndlJV23Utg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021628; bh=pk0SBkYafF/kehhvgIZHiawIDFeeVg
    NeNUCmTt1wrMA=; b=bKqKPu8r/YtLBJWVceUWC07SAC7tHV3JvdV7XPHNxM799n
    fDI1AnFaRSUZ0CTXlh+kjATwPD7++Cgnmiz1j6hFBPdANNzn51BZXDAfwLXhnvQQ
    mu1bFfd5K7qfcnJiuWduax6VSQi0jcCGo3+blQFAukQNRD/m/2e9JN7a/hOZ6G7S
    MT2PKC1bm1H631CxN/2YZhtdd2wuA9z/cCy2xGRLB1WSImKQWmzAMrlU9USrwU/8
    F5iXNpXoix0RXvF4MgazY0KS9S7pwt3LT0nGxdWcumx7qxbiQnbxT7fOK6FsuzUQ
    1u1EPa85Wkjfel82xSYvB2HrGmK+801FS91rQYnQ==
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
X-CM-Envelope: MS4wfPBhUjDsYljXILMREEjnEVMvvvLDGoJNLRejFWrx6ba7Lozr8+FfAUGpmEFeTPGiYxOIDpcBhpXwLHqAjQ02jf5U28GlnkhEYwl+8jXFTfJk514L3HdW
    QiUaeLnzo+83j2T/FTKMsvb7fGxspQ+fDEFknBnGwCmmt1JqRaHvx/LkzDIACtGbdbZmba+SZHyQMtU4UsExIAscM5DPgvughrzdc6WZEctrUJbTXlw3cw1f
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=XAiX7ZERlGyOGA8ICjQA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755680AbeDFNdo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:33:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57986 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755670AbeDFNdm (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:33:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nobutaka Okabe <nob77413@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 003/102] ALSA: usb-audio: Add native DSD support for TEAC UD-301
Date: Fri,  6 Apr 2018 15:22:44 +0200
Message-Id: <20180406084331.948611333@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
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

From: Nobutaka Okabe <nob77413@gmail.com>

commit b00214865d65100163574ba250008f182cf90869 upstream.

Add native DSD support quirk for TEAC UD-301 DAC,
by adding the PID/VID 0644:804a.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1175,6 +1175,7 @@ static bool is_teac_dsd_dac(unsigned int
 	switch (id) {
 	case USB_ID(0x0644, 0x8043): /* TEAC UD-501/UD-503/NT-503 */
 	case USB_ID(0x0644, 0x8044): /* Esoteric D-05X */
+	case USB_ID(0x0644, 0x804a): /* TEAC UD-301 */
 		return true;
 	}
 	return false;
