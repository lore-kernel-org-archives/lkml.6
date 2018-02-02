Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2943005-1517591154-2-401838148834474574
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591153; b=exhKFEG4FCaDOLdYbI2qYuZ3xPpncgBRuH6s4qFlRxbDuDI
    6xHzcHhCrmZ6Ea46EZq+9/3P50PSZ4OzzP/nwEP5OJWPNqaZrb4aKbIJwg+3dUBh
    5odgNhi2JqISAzRjj8nb7kOB5QWoPR8UfPj310fIQ0t/f6vX3PFDLwxi67PZvLoG
    6NiXwVsgqGye5C1M9g6fWgT0leFn2vNntMR+5+jc86i4/GGMk6eVVAYNe/+btC/M
    obKPHrIlg7Fkks4ENijvuNZU6vDGx4W2xcJ3C/TgpAgUn15UWJmoLvvk+sAmfJZ0
    JXk1nH53xKJeguq2E2emEKU+Q0zlc92CwB10Gtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591153; bh=26o2MkVKVcMRy+N2lUG4NCX1CT
    yoyTL7VYf+2WUgzEc=; b=dm5nO+QNnhiTu/o69rersl5WzPdCBJRGvoCRz40LxF
    F3FQxYfCVBNeAx31mRPB5RtOvPdJgAxMUsWzeYpHx56vprRiRdCP7wVLW9uYHOij
    ibq799Or8v6MSncfqO8iVyOmsVtZHJvJPwHnMJ5HloacDB9V7Qnrhsxprjlg2NeO
    mRMit2y07/oGi7N/yrfUAT0ascs2/6NCyLYa4wFHzEPvu3D35sftl5LXd84rWtee
    tAtthKtvvOpcq7ocgrLkRGq8uX7diT3fAHHbnad1MW3SKx8Q1YNFJSKaKM7h/u3a
    ZgdCOTCR1kXi6OvR7KBfjKnUZnWgAB8/gWHUVpCsJwtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeBBRFu (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:05:50 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36604 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752538AbeBBRFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:05:46 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 67/86] media: usbtv: add a new usbid
Date: Fri,  2 Feb 2018 17:58:27 +0100
Message-Id: <20180202140828.865552542@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <icenowy@aosc.io>


[ Upstream commit 04226916d2360f56d57ad00bc48d2d1854d1e0b0 ]

A new usbid of UTV007 is found in a newly bought device.

The usbid is 1f71:3301.

The ID on the chip is:
UTV007
A89029.1
1520L18K1

Both video and audio is tested with the modified usbtv driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/usb/usbtv/usbtv-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -141,6 +141,7 @@ static void usbtv_disconnect(struct usb_
 
 static struct usb_device_id usbtv_id_table[] = {
 	{ USB_DEVICE(0x1b71, 0x3002) },
+	{ USB_DEVICE(0x1f71, 0x3301) },
 	{}
 };
 MODULE_DEVICE_TABLE(usb, usbtv_id_table);
