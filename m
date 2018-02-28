Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836198-2-7373192851159570453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836197; b=eRpkUXJLfht/HnRwuOx9mTMqdF/Nd5c+XgZgFfNu7kSTaf4
    ssAxxhg0uNdX/OT7dF5RccM6J4UOP57WhYO0cEKnzFmk06SQ/scjaMOB2I+GxnoL
    f8vCPKzJJV0aBe9PD7tbBeltvaLZgLFLTquZ36G0w/Ol5kTHbQ4a1rBqvGNFw05a
    ucNI4ngea63nCFKK+Nnk1XCeLFnc08EB1ofKnP9PfPW5A7JdqLJdqv/KFzSwHcIi
    EIFybn62vjQ271Sq1YO5/pjWgt1a2sa08CNqrwKtVmJ6wNyR16t/nrpXCkzkhU7Y
    yw0qdRREd0muxm4a6n/u1NaFp+A7TBFkUEr0HOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836197; bh=fRpbx7PvixszwGSjxHQ
    Lo0cPyXrfW+B11lbgwG5xd7Q=; b=pqYZDEPT3Jr0j20ZFw4kRcxOqqERygvgfW0
    TjPczUPt+/PBLBXvj9KYbPHKTtokZd4GRlthN0oQsljxzQephkYBoPPmSNYyeU8Y
    ZXwy+AX0fkQQ0VnoytnOCDA3aai7G7rtQt4RHoUltXFCJ/uSKnCICn/SYagdBTIA
    mmlCRPXToWQaHtUZQLGwZmcxgJEZcxbG2x++7G9PbWk1MbWwhFTahcKMI64sziiB
    Y/6wQa5dk2Y7zs0PtdA/gK/ctN2DBqA0WgCFl8rN80ixePJMBG2+SH8Ysj38gPNO
    u59W33EQTIhGa4xOdfCA97YIg8SV9x/S8+VF6j9CTUL5pZwzb8w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932437AbeB1QDE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:03:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34737 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeB1QDB (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:01 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Alan Stern" <stern@rowland.harvard.edu>,
        "Felipe Balbi" <balbi@ti.com>,
        "Peter Chen" <peter.chen@freescale.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.875210007@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 191/254] usb: udc: core: add device_del() call to
 error pathway
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alan Stern <stern@rowland.harvard.edu>

commit c93e64e91248becd0edb8f01723dff9da890e2ab upstream.

This patch fixes a bug in the error pathway of
usb_add_gadget_udc_release() in udc-core.c.  If the udc registration
fails, the gadget registration is not fully undone; there's a
put_device(&gadget->dev) call but no device_del().

Acked-by: Peter Chen <peter.chen@freescale.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/gadget/udc-core.c | 1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/gadget/udc-core.c
+++ b/drivers/usb/gadget/udc-core.c
@@ -252,6 +252,7 @@ err4:
 
 err3:
 	put_device(&udc->dev);
+	device_del(&gadget->dev);
 
 err2:
 	put_device(&gadget->dev);
