Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838595-2-15950268732077720419
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciida,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519838595; b=acXd3jg3SC6GiOvTLMXau2InnjLTggJ6Yha4j8gHdBheeEP
    A4lJeLX/Dffu128UrBK6nFdSVRbeNPUL4bsdd4/tCZs0jhzDmkyzik+BRVpHKNSu
    2l7DJdbNjVXl/pGa4Xt9pOACqKiKMs7ZiyOfNtjL28P4ESpW6q3UD13Y+eD9HqVL
    vK0qNYZxNS0Z2U8OdbRnRfdT0NsAc2335pqeCvbrec99YNl8EXuMEBLH/WlKt0N1
    S6XKj8anONIXDXNTcIE1xkxUSANYK0N/jPZ12DAnqht9ryHFuOoAHe/Sc5fhxdVa
    x81W+tlexQPYxJmWVBCvSILwu1w07dT+PGcNhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838595; bh=eeEMDsgc31nFpIcFaEq
    RMATPX5oqyj8nPls/K754XIE=; b=M6i8Fq3rOzetZyweZMjQ81rG28I86P/P9Z3
    b+IgufVWv6SSoCT0a3Su2f5BPwP/LWI7+QjXj9LsfFQFkq8k61ucu9Jq18ks49+F
    XX3XopwPkTfN0jAI69OZ70lMjOmk+fA47m4OzWwgmXvv+Mxr5ZOmvUelDf/j+OXA
    NpoYwHI3FfnmBdhijOctYNWMQv0qNL4hbVikdc/RLvskNEzUdd5q8b8m+GyRHAa+
    +wfV4eZLrkPIT/Q8nWLs3jyzwea/haQ8nSZ6daSh9mSjbYXuWwIUgI3rkOLHOjE7
    WXRpD8NlWxpAfDK+Opz83HwSgXyJNdbnRLJUuK/EA0pxybNdeTQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeB1RWH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:22:07 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33307 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932121AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Christian Holl" <cyborgx1@gmail.com>,
        "Johan Hovold" <johan@kernel.org>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.717560953@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 079/140] USB: serial: cp210x: add new device ID ELV
 ALC 8xxx
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

From: Christian Holl <cyborgx1@gmail.com>

commit d14ac576d10f865970bb1324d337e5e24d79aaf4 upstream.

This adds the ELV ALC 8xxx Battery Charging device
to the list of USB IDs of drivers/usb/serial/cp210x.c

Signed-off-by: Christian Holl <cyborgx1@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -177,6 +177,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x1843, 0x0200) }, /* Vaisala USB Instrument Cable */
 	{ USB_DEVICE(0x18EF, 0xE00F) }, /* ELV USB-I2C-Interface */
 	{ USB_DEVICE(0x18EF, 0xE025) }, /* ELV Marble Sound Board 1 */
+	{ USB_DEVICE(0x18EF, 0xE030) }, /* ELV ALC 8xxx Battery Charger */
 	{ USB_DEVICE(0x18EF, 0xE032) }, /* ELV TFD500 Data Logger */
 	{ USB_DEVICE(0x1901, 0x0190) }, /* GE B850 CP2105 Recorder interface */
 	{ USB_DEVICE(0x1901, 0x0193) }, /* GE B650 CP2104 PMC interface */
