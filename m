Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161794-2-16265153503906548119
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES daensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161794; b=HsKNAj27+g2zrhQ7w4o+z589+cxzzy8lt0+iI4082NcPkC+LXX
    lv8vdst+acxMEfYVstQPpSLefsOJh4Iev9tX9GHuIa2FfT8vpBpKPRyZ5SQRaO+m
    Sm0g1jY342SOP4zuTJ5Ppp+t/2GKxxqmBKeHs5eo6ZtgsfAU0XGyUMrckVsI0hS9
    KlPBm5kRLN7NnUjzhU3EvP1SinqY2uksJ/7e4U0f1Kf2qzAICscpul7+79zJ4J49
    +aJwlFZvjucSwVkQGGw9KBKYBIfti74B9u1/oit+ddCQ4Jh8Mk/5yB0Kax0G79+F
    nCzcXDhqXNkZnn+cU6jzoJKvtdO7aFDY5HAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161794; bh=IHvJncXlpHQh7fyWqMWcSqTpj49oSp
    aSN0++dgkFzGU=; b=C8ayH6MCVwC1x2CQH0j/r/6osV1sgqRDgfeKNOfCxIQG+C
    kvb7qonF24CrRzIbLfenBEmDiUl5O+EJdxvWGr+KjeRxeQUMnq0MU8FxrQZFiU6X
    L0khWVx5npeGZhjOVUpi8BRvAhhwLt8y+EaxW+vlN7W/xuByRvP0R0FcUaYpJqtE
    0yRit6DOF2N8PDOflDl2XbOBraQ6mkJZC2T//GwxholNkdaKCH8uZFv7PepC5p3p
    MEgnT/BTJ4PF2TH4TRuzfgaWBEmq0+oIwbbvLZVke1+PRteulDlcH+woW2YM7Mg7
    K662b3t4k8jnz9B4eLzH/iBbE8VrxaeVC4XPA5pw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CiiLwp8S x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=CiiLwp8S x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJI+uPCbmnYQi75cyL0BNpK87bAX8SCuiwTrXCSe5zhYtFKkiBEI6Oi/F8tD9E2pawJIY38ImPKFIq/NsbNwrWJYLS/mhPt8in+MVu/8BRPxOijS3Tt8
    FbeyVOdKyoy2BhnlocCdMeFPO0ZqQ2NXHKBT1AJnXi9XnSuzoy0LIjGYG+hUJOFwkwr1wPk5Aduu2dnyNuZ9fa5XsbbojmrQWLrACTu4l5xs9M2igHaZ19LT
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=7ZN4cI0QAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=ebhwineD2bcmPdRjz5UA:9 a=QEXdDO2ut3YA:10 a=Dl0WHwQvj8hGZljrFLtM:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967118AbeEXJtq (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967432AbeEXJtm (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 32/96] net/usb/qmi_wwan.c: Add USB id for lt4120 modem
Date: Thu, 24 May 2018 11:38:15 +0200
Message-Id: <20180524093607.385121858@linuxfoundation.org>
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

From: Torsten Hilbrich <torsten.hilbrich@secunet.com>

[ Upstream commit f3d801baf118c9d452ee7c278df16880c892e669 ]

This is needed to support the modem found in HP EliteBook 820 G3.

Signed-off-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/qmi_wwan.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -942,6 +942,7 @@ static const struct usb_device_id produc
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 8)},	/* Dell Wireless 5811e */
 	{QMI_FIXED_INTF(0x413c, 0x81b6, 10)},	/* Dell Wireless 5811e */
 	{QMI_FIXED_INTF(0x03f0, 0x4e1d, 8)},	/* HP lt4111 LTE/EV-DO/HSPA+ Gobi 4G Module */
+	{QMI_FIXED_INTF(0x03f0, 0x9d1d, 1)},	/* HP lt4120 Snapdragon X5 LTE */
 	{QMI_FIXED_INTF(0x22de, 0x9061, 3)},	/* WeTelecom WPD-600N */
 	{QMI_FIXED_INTF(0x1e0e, 0x9001, 5)},	/* SIMCom 7230E */
 	{QMI_QUIRK_SET_DTR(0x2c7c, 0x0125, 4)},	/* Quectel EC25, EC20 R2.0  Mini PCIe */
