Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162036-2-3422021659569283562
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162035; b=Lc2jr6kIy5A0UESiPn0UEKQTj75feKVjhDADDvdr91+xMmx1id
    +XKEw2LEJEC/2fH8kEfM8AQ9hHbdSX/Rwk2L9cjrwo0zq06j35fCwKEt23592AZn
    vp5tc5OG4t52KcVxNDqPb7BKv5SPGVCo/20RBI/OSxsTTRg4H3a1J1Z0+uXeBOH6
    EQRY1wZGeRutm/5/zZoxHTwgFqomv8fbAJ0zoOcxN7yMVeWCHV2BKm5AH+MPVsgM
    NkseYIl9r1rDGShkuSW6Njd0aoBcKY0bnrk7xSANFd8buvfWS14SDe+p1LzpRETR
    ogRwSfAEg0ThkJPXXZ9byGkfxrnBFMsUt32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162035; bh=3WfwtDKk8vLEPO6bM8GgjcQh8++Maq
    yY2GtumOMYxOU=; b=c/bZSdphMzqoROExDV3SVT3yFLt8eVCpZZixu9bKKG9zTS
    pT0o+PBCDOQ+lk+sSydMq5t3CnA17ENBDdMdXvXUJIrq02nY964VJKutB/5IsBr3
    nsqNZmZ7cTO6hpU4Mv5I/aR8kyhbrmH7evBdVSZvTnVry8on9wY7M/4M9H/2m8xO
    0t0xeYYOesQRSAlZPafZW2naur3xBsLLG2fQgt0mIXO8GIYf9xq6u8X4dEJWN97n
    fPSV7AQOGdUph0L3R6g1/lnUbPgRGjb510RrXFrdRHUyGqcgUwHDR4yKS8788C/C
    iIdstQLYxV/OfeqYFwc72EdrHhwaOs+Wowh4Mvtg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1bF+x08n x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1bF+x08n x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMId0yI80RE7j0WaGrP9iqaGNJ7n/5B41J2dJHeLhZi40QO4ESMkfE+BiaC41kMA36uMOX+Ta/nueCfdz5wxZtCroYuC/L89JI5M+vHBIpJJyoZJ6RZi
    WpxxlEGo4y7H/AAGau0Ic5QVxZaJ0jqd0Ze7BVxkcpOH/tpFSHx6E7xPlxCDILYAXwCOCBeGI+cwFkBFW3fv9Nc1VXC0c/E2pshZcx2fBg0DwrdIIwt+95wC
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yQdBAQUQAAAA:8 a=pGLkceISAAAA:8 a=Dei6p5SHAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=cC1Zfw63NZkZNGFym8gA:9 a=QEXdDO2ut3YA:10
    a=SzazLyfi1tnkUD6oumHU:22 a=M-Yerj1wOn-OpK7r_3ei:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969150AbeEXLk2 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:40:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967272AbeEXJst (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hon Weng Chong <honwchong@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 46/96] Bluetooth: btusb: Add device ID for RTL8822BE
Date: Thu, 24 May 2018 11:38:29 +0200
Message-Id: <20180524093608.124458065@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Larry Finger <Larry.Finger@lwfinger.net>

[ Upstream commit fed03fe7e55b7dc16077f672bd9d7bbe92b3a691 ]

The Asus Z370-I contains a Realtek RTL8822BE device with an associated
BT chip using a USB ID of 0b05:185c. This device is added to the driver.

Signed-off-by: Hon Weng Chong <honwchong@gmail.com>
Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -355,6 +355,9 @@ static const struct usb_device_id blackl
 	{ USB_DEVICE(0x13d3, 0x3461), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3462), .driver_info = BTUSB_REALTEK },
 
+	/* Additional Realtek 8822BE Bluetooth devices */
+	{ USB_DEVICE(0x0b05, 0x185c), .driver_info = BTUSB_REALTEK },
+
 	/* Silicon Wave based devices */
 	{ USB_DEVICE(0x0c10, 0x0000), .driver_info = BTUSB_SWAVE },
 
