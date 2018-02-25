Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-153198-1519572435-2-1199949810209688227
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519572434; b=GB18lMjMipTTDqo+k2f7Vp9uscCA0ks60mswLW8uIcyeU8F
    SvbEqmpFa/B5cywfHlec0O9shbj9OC3RiBYVRxaYUPYFPw7Ea9geDOblKhNVLl2H
    NBA0TUAlMsl9pxUztJ0KcCZj2qBYk0/QonNixI/PgsMReM/ArkTErthhawvh5ISW
    Lu8gW8bC+fM0p1rlHdHfdvqtp1/B+0nioAM81jxNBy2PXwd9c3VPpUjuHWf5rf52
    97zb3Jwg/fKUqy9QWlPdsgybphGYkn5zis8eoiQTB+xRZLDHoX3NpnFYKcPkmtut
    BqJa36vG8TpueskMNKzl1ueoMZzlu/H6WTNggYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519572434;
    bh=zforMAla2YVcxzvNorRRAYZbHAmCEKaZJOMFkSAf1nU=; b=KLBps88zE/ef
    cZfnQdxldaUxk3FrfrIc3F/lUyL9GqPMpgJd4zP1NAiF419zP5yMXrGM7ZMcmOdH
    +8E5DQO9eChywiwe9GANw0PaE9tcYkjq9P+AyW1GNhvc+aWGAAWs2m/ftUUHbpcG
    HP4n3dFtTxYqLfupE+tlfNx7yUCZP2zeaWo/cNsoUMdwbBskT9Rv7KC8g4IIGP3J
    /0MAfCwbxMN01D1ZI1eO6E0FXZjKB7rkFr0rtYGu5ryOrnhRJWdNQ1M98wvjghrj
    cnBnvigT/JMZ75/AeI6QOo9p3S6LVVAMChNpq3WoouoHeCVv5aTgAdAQH2VJrjfC
    hbGWsHmPsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeBYP0t (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Feb 2018 10:26:49 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33754 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751827AbeBYPZ0 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Feb 2018 10:25:26 -0500
From: Hans de Goede <hdegoede@redhat.com>
To: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH v2 07/12] xhci: Add option to get next extended capability in list by passing id = 0
Date: Sun, 25 Feb 2018 16:25:05 +0100
Message-Id: <20180225152510.10159-8-hdegoede@redhat.com>
In-Reply-To: <20180225152510.10159-1-hdegoede@redhat.com>
References: <20180225152510.10159-1-hdegoede@redhat.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Modify xhci_find_next_ext_cap(base, offset, id) to return the next
capability offset if 0 is passed for id. Otherwise it will behave as
previously and return the offset of the next capability with matching id

capability id 0 is not used by xHCI (reserved)

This is useful when we want to loop through all capabilities.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Added Heikki's Reviewed-by
---
 drivers/usb/host/xhci-ext-caps.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index bf7316e130d3..631e7cc62604 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -84,7 +84,8 @@
  * @base	PCI MMIO registers base address.
  * @start	address at which to start looking, (0 or HCC_PARAMS to start at
  *		beginning of list)
- * @id		Extended capability ID to search for.
+ * @id		Extended capability ID to search for, or 0 for the next
+ *		capability
  *
  * Returns the offset of the next matching extended capability structure.
  * Some capabilities can occur several times, e.g., the XHCI_EXT_CAPS_PROTOCOL,
@@ -110,7 +111,7 @@ static inline int xhci_find_next_ext_cap(void __iomem *base, u32 start, int id)
 		val = readl(base + offset);
 		if (val == ~0)
 			return 0;
-		if (XHCI_EXT_CAPS_ID(val) == id && offset != start)
+		if (offset != start && (id == 0 || XHCI_EXT_CAPS_ID(val) == id))
 			return offset;
 
 		next = XHCI_EXT_CAPS_NEXT(val);
-- 
2.14.3

