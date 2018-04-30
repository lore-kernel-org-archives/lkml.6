Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1292091-1525092186-2-12478586871043099384
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525092185; b=ROXu4oEZMoqOPOoCSBhmQQSp2JCL2u6pQCm8G+5m0PYtCnAbxe
    Ic9ToO/BICWDluSBrD3vHLjdshobIU43JeQgvXMzV7rlmlOujEg1qNmVg7ERmESP
    OExRbEt27/5C4gzXZgf5amiVV2N3dOKdg2Zl3Bwok8tFeqqwf9rMs217OC8fcSWQ
    0oG5r7/uM+4xINMgY9YeAp8pReNfPPcoOmHtalG/i8YN8gY8ItSv7CIYTsvKkJiw
    YqX/CoYsQu7RFnFI+sYqNV2WVa99NvA38GkH+xSWmQ+QSlZaqowcpJfOzTKmZg8i
    UuhdURZ+veDxCZJB2hTv7Ev3OZI2VR3cxk8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525092185; bh=
    YVyQ52IS6UmrRhtwWbVrKBGlpoP8zYqAGUJRz5YebaA=; b=cKHHzy8/36bORjeb
    F0qn8KH5lwd+HgNZafGQQMNYSVDE8VWzrh6NEFtaeE+Dbd4wem6ZJEtasZ3aBDaV
    booYkffzGHwPoWwU8KQFt77NQxk72fpYQkFFhRTUPZOrVU0HjDC0EcN752Lv5xnC
    jNsGTsu/v7qjfvBtJaIKnEzgh3qrH5sc0YGmgUchgAgVUVfISrTkeSOccYXBrHNZ
    ooS97Nwi/N/SwkTFGa2ICF7LwkzlBUXUGomeRL/HZvGHnHuM7PE22lriuFKAbyUc
    S7WNwlHzW9jmCuSOuwgqmYOsS1tDVgRfj0yOK5LQEUbPUjAkQqzoQm3fppkf5SHd
    mTA6rg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMN0vNtHr6GvxSlWZHbcNwe/emaqwF6wlFCi9qAM0F46FlcAJVmQN76REcGNHlQw9nZCRmm/8+91zLZbQgoJhdctZ6TL9vI0xz18t5iBVXMswmha8MWr
    SZI8kf6kWy7xBC6WGJaecweigmRbmUVeUHrJeo1rqtAahA12PCwYHd+z3W6CoOFccVWOjC1siJLZLet4yZC9iEOaEmQFcncA+WUEJ7UkSUqEep/zECw22LfV
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=VwQbUJbxAAAA:8 a=kk74zjg4mkyIWxKywmkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752312AbeD3Mmu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 08:42:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:39224 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752187AbeD3MmF (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 30 Apr 2018 08:42:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="51127007"
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/4] usb: typec: tcpm: Release the role mux when exiting
Date: Mon, 30 Apr 2018 15:41:56 +0300
Message-Id: <20180430124158.45269-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
References: <20180430124158.45269-1-heikki.krogerus@linux.intel.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The ref count for the USB role switch device must be
released after we are done using the switch.

Fixes: c6962c29729c ("usb: typec: tcpm: Set USB role switch to device mode when configured as such")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 1ee259bc14a5..66dc0773b9bf 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -4652,6 +4652,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
 	for (i = 0; i < ARRAY_SIZE(port->port_altmode); i++)
 		typec_unregister_altmode(port->port_altmode[i]);
 	typec_unregister_port(port->typec_port);
+	usb_role_switch_put(port->role_sw);
 	tcpm_debugfs_exit(port);
 	destroy_workqueue(port->wq);
 }
-- 
2.17.0

