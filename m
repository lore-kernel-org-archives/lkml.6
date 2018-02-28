Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519838706-2-16398300292685543335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838705; b=Cos0OnENwEeNXjKr/T7BAVRmfhbxa73E5IhSr+r+vAUxy1f
    D/Lr+3lvCcttfTz3hc8IdJyRO8g7ZESHn8cBQ57Rfxsgx5hg93u0w3T5y3rm72RY
    J8tZw2yOgltdy027xa6Ys83tVCrceUXaM1yYHUhB0EVH7mPpTqenMgGPTAeF38RL
    +kXDWmzzaiuIhfJ2YnUjuyEMJpWcUfOU840GVsRfPi9Gh5aeIBOrAOPq4u9Mgr+u
    jOJzl2UVg57m+RsamHQAqu8Jub0Ruqfb+mb8ZRjekZ7Bzk7FPBBgkU+t50HraWK+
    TQDV8GrRsgdL4cWOh4I10AFGXFeY8sCaASa1WIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838705; bh=FWEY3UEX/UDQh2kGGXW
    SObwDK4wSN+A3jI+HbQ/99rA=; b=MJaJUG+JEK66sCUHWzbdER9bUGMbaNvbo3+
    fpIoSM96gRHgwqX8HMAMufzvakbudEjtK/0Cq1LKMMpwlSeWRhDKCw9QFxeYUhZL
    VaB8u0CUza4SNd/whGk6AN7Yi0X8r/IFDcKSbeP85obf+vsaUTzJB/yhszyFBoVF
    +gFtAdbUVuZEqb8geiWL02xLScVji7PiNwnOmSrlHMAtH8LBNwkb+LsFB0XWIUWP
    h1i3JmQTwxTdnmBsI3ofPK5Q1byFa6q3TV3QOV8YG9xHIBjjWkvj5Sv0Y+aqOJRE
    QxYdYnJigDWJex5GCP4kYu+EMV1A5lwe/DrYHx3tTiBmTq6AE6A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbeB1RXw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:23:52 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33314 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932626AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "=?UTF-8?q?Diego=20Elio=20Petten=C3=B2?=" <flameeyes@flameeyes.eu>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.585366599@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 073/140] USB: serial: cp210x: add IDs for LifeScan
 OneTouch Verio IQ
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Diego Elio Pettenò <flameeyes@flameeyes.eu>

commit 4307413256ac1e09b8f53e8715af3df9e49beec3 upstream.

Add IDs for the OneTouch Verio IQ that comes with an embedded
USB-to-serial converter.

Signed-off-by: Diego Elio Pettenò <flameeyes@flameeyes.eu>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -126,6 +126,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x10C4, 0x8470) }, /* Juniper Networks BX Series System Console */
 	{ USB_DEVICE(0x10C4, 0x8477) }, /* Balluff RFID */
 	{ USB_DEVICE(0x10C4, 0x84B6) }, /* Starizona Hyperion */
+	{ USB_DEVICE(0x10C4, 0x85A7) }, /* LifeScan OneTouch Verio IQ */
 	{ USB_DEVICE(0x10C4, 0x85EA) }, /* AC-Services IBUS-IF */
 	{ USB_DEVICE(0x10C4, 0x85EB) }, /* AC-Services CIS-IBUS */
 	{ USB_DEVICE(0x10C4, 0x85F8) }, /* Virtenio Preon32 */
