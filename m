Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-497764-1524652825-2-6139183573095503079
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
    1524652825; b=mn9r6zLkhSIr64kQxdxWqdNR8iOHj5PI0qtq4pmyM6FQfwuwCx
    Ao+Y84i4laHNG+wYMC7CVdiy0VVndYOm+yr+QlYZ7SFW43bb5XfsDnQ+FY6cxYNX
    OtfPttKDOB9oO/CMG7qLugMjti1VlHtDNWh3ywOcgc3BSdZEFYv48q9qnoYDE7yB
    Jb8GDskAP02T0Oxmfqluq0AQTiCKQrQXZ8QYNMjybzVC5/HBA/fKM8OoeHM9Uhc5
    TqrPCgdDac4aj6IHQH9hWRSf1G+YB1rG0hZmsFr3U/ddr1wuzFat2JKQR+UE+GPi
    cbMlU4+1o39mmxaKp5cXN8oQ/2dugvZO5FuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652825; bh=JH8h/gSxquHkvEHxyCisI+dyNbztn8
    LWy9X5u2cbmeU=; b=W4NhOROA8/c3MdquGyIfVZbqxW0/WsEi7+l6yuOEC4fA7Y
    qR50rViZ6VahL0NoTQFSz9TFVQRPoMy5OTrokuafakJaxVkHOTX93o+v7aFxTI54
    XNV6qPvu1J7oDbP6uDNklE1nFSCGp4XJdLb5FoTe/ZQvdlZDKlf17x2vF4UEBBnh
    f1Rnz+Yh/J6GyvGw1xykGVljKAbLpyFinzj5Mgoz5+2X+6JQocFDsO4aP2Ys8Vaw
    u8sTSPrRSEGsAcDizVUoBj30RShXCoBNkVhHa3EtXkMCTCVU+BGNMbGm+pMBsayM
    SXjPDr6mlWyHgpal7O10BEZl73/VLz6l4L9asckQ==
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
X-CM-Envelope: MS4wfEnJxAjYr3bKnGK9P3mzpTA1e0F/IAIBj6ic0Mimc2M7OftBihSqMej+HqAhh0XouuZq+ldfEWC5tmfmoip/J5nHYQwYBfiBtb0tSn4ZZLmRT1/Gc6jY
    sagWK1KZulQTmeeiEPgiKKKNurW+ZRie8W7q8ozF4hyJ5J9ojNvbmbStkFWDL6CDC4k7YmyRqpZCgPF3y8pWy1h5f0TbL1DNAdloXRc2dWTaYzcVVNflwHM5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=pxVlmbZgAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=citNvokU5oaPeovvbZAA:9 a=QEXdDO2ut3YA:10
    a=L4_cbsQG0mmWe7eFWZkK:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753692AbeDYKkV (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:40:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52070 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752952AbeDYKkQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:40:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Thode <mthode@mthode.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 080/183] platform/x86: thinkpad_acpi: suppress warning about palm detection
Date: Wed, 25 Apr 2018 12:35:00 +0200
Message-Id: <20180425103245.718504139@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Herrmann <dh.herrmann@gmail.com>


[ Upstream commit 587d8628fb71c3bfae29fb2bbe84c1478c59bac8 ]

This patch prevents the thinkpad_acpi driver from warning about 2 event
codes returned for keyboard palm-detection. No behavioral changes,
other than suppressing the warning in the kernel log. The events are
still forwarded via acpi-netlink channels.

We could, optionally, decide to forward the event through a
input-switch on the tpacpi input device. However, so far no suitable
input-code exists, and no similar drivers report such events. Hence,
leave it an acpi event for now.

Note that the event-codes are named based on empirical studies. On the
ThinkPad X1 5th Gen the sensor can be found underneath the arrow key.

Cc: Matthew Thode <mthode@mthode.org>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/thinkpad_acpi.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -214,6 +214,10 @@ enum tpacpi_hkey_event_t {
 	/* AC-related events */
 	TP_HKEY_EV_AC_CHANGED		= 0x6040, /* AC status changed */
 
+	/* Further user-interface events */
+	TP_HKEY_EV_PALM_DETECTED	= 0x60b0, /* palm hoveres keyboard */
+	TP_HKEY_EV_PALM_UNDETECTED	= 0x60b1, /* palm removed */
+
 	/* Misc */
 	TP_HKEY_EV_RFKILL_CHANGED	= 0x7000, /* rfkill switch changed */
 };
@@ -3973,6 +3977,12 @@ static bool hotkey_notify_6xxx(const u32
 		*send_acpi_ev = false;
 		break;
 
+	case TP_HKEY_EV_PALM_DETECTED:
+	case TP_HKEY_EV_PALM_UNDETECTED:
+		/* palm detected hovering the keyboard, forward to user-space
+		 * via netlink for consumption */
+		return true;
+
 	default:
 		pr_warn("unknown possible thermal alarm or keyboard event received\n");
 		known = false;
