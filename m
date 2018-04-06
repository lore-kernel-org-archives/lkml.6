Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459510-1523021499-2-10404230399726422475
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021498; b=hX3X47K+rQkH5YY3D2+NwPsPWK6WtL9Y3Z8liAim/23josG8RJ
    vHCC9tv8EL844FGJ/1EdMo0JH7IycgMZqp2E2383EZ+HwFdC1TAUy9WLF5hVvd0V
    0pMnjKxqDHrRc5I1QUIs9O7P0dEH54/JVMlOuxKqiY1sA1+C3jot51/BV70ia352
    EEzZqvklCTxEJqk+2xbVB50LE3fXbB62XeHtUfyY3sTLlewkB3+4/zz/IwIZuQ2F
    Mb4fvmSG0ZxC8p90an+MJXU+UMa/d9PwUbvvRIvFnC6pgBkgUv/so30/t0/b5WZp
    iMpfoIFGymmABh1fyc73UNs8k09jQ9DOjYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021498; bh=qghlZMJq3+Bo2qGtiOhXepBbnLRSii
    D9iK4yrgDgfGE=; b=qrIga71euA3UNCwlpneoj2nPOTKBCvmUDjLYTpR8bC3scj
    DPalHQGHmlPlNbnjy8UDLXzss07GKJZbuJ8jo4eHwXV2cZRpnSV5gOCRI0v+S7y1
    JAZdvWimzOPtEW4nsez+7crcSplhHNK/sqJMgMwE77l7Mevdy4LGbBMFkf3pbiUH
    IhZJ3iOgNU8DDbFFnKEuQMXdEUg6B1TWQTJrYoacM4LvZ/oPAAddjllN/+JPZUo5
    ni3ys8Q/cYvygpWX2qk4dLyojve0sKRpM4Z9lCN8lIzMtT3VJMzsKNzoXojD6I/A
    F8HiU0NEB5W2CbILq73hDF+8z7qIhebaywvfHQUw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfHbgd1XvoPn8qzNE/tUPGoOOmxXtXZ8dKn8Y6T9bbFQbkhNAcISQw7+pSJiyUrgPpQOwHDtorH2D/vIPn16l0SB89iGxWrzxSMBhc7BBCSbutjnZUNX2
    t5tbZCLhOcCov9d4tXI+9UjK4pq4QzOQLs2MZCZ1HTwvVlySydmuSXXLogRd9P1KRMcdm/uH8/0qIwH9sFz7vCCvV6JorrwOw5uB4/H4xAiNGYCkXVI31Uav
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=69EAbJreAAAA:8 a=ag1SF4gXAAAA:8 a=7h-D2dbQoWSdDwx-Ib8A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755152AbeDFNb3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:31:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755149AbeDFNb2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:31:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Jansen <nattelip@hotmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 47/72] USB: serial: cp210x: add ELDAT Easywave RX09 id
Date: Fri,  6 Apr 2018 15:23:48 +0200
Message-Id: <20180406084309.128015176@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
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

From: Johan Hovold <johan@kernel.org>

commit 1f1e82f74c0947e40144688c9e36abe4b3999f49 upstream.

Add device id for ELDAT Easywave RX09 tranceiver.

Reported-by: Jan Jansen <nattelip@hotmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/cp210x.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -151,6 +151,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
 	{ USB_DEVICE(0x1555, 0x0004) }, /* Owen AC4 USB-RS485 Converter */
+	{ USB_DEVICE(0x155A, 0x1006) },	/* ELDAT Easywave RX09 */
 	{ USB_DEVICE(0x166A, 0x0201) }, /* Clipsal 5500PACA C-Bus Pascal Automation Controller */
 	{ USB_DEVICE(0x166A, 0x0301) }, /* Clipsal 5800PC C-Bus Wireless PC Interface */
 	{ USB_DEVICE(0x166A, 0x0303) }, /* Clipsal 5500PCU C-Bus USB interface */
