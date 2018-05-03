Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2941320-1525372747-2-210818367942780298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525372747; b=CXFNGglmdqIUoFE5omv0kwQgwtsoPDHUicAKvUS8U3gx2UPjpt
    9vxQfjedQe3w8/6BylUhEeMax4Ac+1GyOwupMnPU2ggayNOh/438kGaQHZcU4/eP
    LGikY0dPEqfGbRP85S8NGx9YhpJ3+UO5jYMm2xzCXuUDhP9YNuZwbWQiav2lV3PA
    81A2CyKzFM9bZR5hbAf+5SdkfcbGDPImUQOq/4fneM3iMNeT4wC9RMdk50420ebH
    nev/d25pvg6ekG30/HRjnYVbQCbYsylcLGUVUK57GZU6/1fksGjRH6gJx+XjEPid
    jnJobWJjJkbb6DXZXKPRgtl0XCHNtgIEsD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525372747; bh=aZuHMnS8HoYQvymWT9toB6eMu7hXaR
    3HCblMyZn8Yd8=; b=gNAxBDDhJU0Xzsr0EzeIrIbTIyjLDwXdObL6XNZw6f2IFC
    vM9DeJIDF+LZYQ2JKaTKk4pnrn6IUySE71NOQh3XAtyPJwiAqQ054bl0QEttczNI
    A1cWchTZ3TsfXVe8o2gc4e41N7xD+HSbPwj0LRF/wTp55nSczrVJQtIACPvL7dPF
    xBBWbtzIdN9J9IkvaPpwpMUb8ZLn1L4eGqPTSa/mjlraWpg+gOjZK8vgUcBsc4tE
    qcP99gdWNLmx1Se3nmjtGuHuAvejXl804zEbEFRssPRaPnyHDZTP1j6lunn2ncQJ
    teI06FZaiQM/XY/7OrLjBMSuwv3vNQJ6r7vJZ5bQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=AFrJSQ3g x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=gnDrxMMF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=AFrJSQ3g x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=gnDrxMMF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP0PamcdrbX70ZfHciLd1WZii0u2VV0jKGslGcmBRLY0Z9U2zamf8iMKJ7UFRZ3990WYIXAvuFlvDqKpSAHSANOKmKNtvuAZzVebATJb32L5vgeX0/qU
    /WrZacpX0BdMlR58y6EpA6TW2gQJp1EywHW0FfKl5PayePOn7iJ84BGkBjhGQcdrJ9W0d86Lc0DmPZ7WYEvENqPIQWT5iUlfdhBsgsMxLJgVoIopHS8DTX49
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=1XWaLZrsAAAA:8
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=QyXUC8HyAAAA:8 a=Aqq4grhJvZhRwofscVwA:9
    a=GHMYYBXT_GxAYqGE:21 a=Xiwt8V8h-9Bp-ZgQ:21 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751236AbeECSjE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 14:39:04 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39740 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbeECSjC (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 May 2018 14:39:02 -0400
X-Google-Smtp-Source: AB8JxZrcgQ5eOVoX6zWGPEsSZb60ZBV6e4tQHDR7GhJQ596RpyjIx9O6uIZ+P8iyzFMApGpMiWcY/w==
From: Amit Pundir <amit.pundir@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>, linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Christophe Ricard <christophe.ricard@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Todd Kjos <tkjos@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Stable <stable@vger.kernel.org>
Subject: [PATCH v3 1/4] NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
Date: Fri,  4 May 2018 00:08:53 +0530
Message-Id: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Suren Baghdasaryan <surenb@google.com>

Out of bounds kernel accesses in st21nfca's NFC HCI layer
might happen when handling ATR_REQ events if user-specified
atr_req->length is bigger than the buffer size. In
that case memcpy() inside st21nfca_tm_send_atr_res() will
read extra bytes resulting in OOB read from the kernel heap.

cc: Stable <stable@vger.kernel.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3..v1:
Resend. No changes.

 drivers/nfc/st21nfca/dep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index fd08be2917e6..3420c5104c94 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -217,7 +217,8 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 
 	atr_req = (struct st21nfca_atr_req *)skb->data;
 
-	if (atr_req->length < sizeof(struct st21nfca_atr_req)) {
+	if (atr_req->length < sizeof(struct st21nfca_atr_req) ||
+	    atr_req->length > skb->len) {
 		r = -EPROTO;
 		goto exit;
 	}
-- 
2.7.4
