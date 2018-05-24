Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527160552-2-6173426855891954316
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527160552; b=Z3DiEIO7nDH5n7IXoGWmE1rdKrAf+/iEvmQShQMIyUl+6wnaIh
    uhgBIj/Pa4dznY0JPs/FgIMAJ3BcDsGmkwOgnvtT8DpIJoOk7K6Y5cdfmVl0VvYi
    xWRvvmX34V3KObngwoB85UIoF+q/7TRWFg3+nJvTCh4Qbl5ae9Is9Rse2RnC0qmP
    vDK/PjSXF08IaBeCq+Zw7aCgkYlDQHMrQpEkP0ZXJgOXiinbw37IRMvTxmpigxFu
    nWJMJ65NEHCk0n8MSp9R1wzQvf8/39CH4QmWC4pemiG81/l7vnGP0LvgoagqXx8y
    6/lfQSmSiRZPW+47Atg61+t3caPBmU8gjYOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160552; bh=DsvT2rukNL7Nulxd55ws0aT1p9Or1K
    wc+K4DpeJVpl0=; b=Hm0tMTZzhGMg4GcpbozGySCLoWBrhimQR9p+ViV/iKyNxq
    nYuHY12s21aPz0YDnOkpWSOnkNQx+bqomjvOZoM+tLqyVmq3jRUZOKBcO5ufQfI0
    KbcmnEVN1an/MjXdaK2wfim+gIB2yolQraj9bUlL/DfOQz3mTOOlVL7WpLnNCo/9
    WVkIk8sGqLcKLrRQ8f/WquyaN0mtnPe1HmpaQtzN3VMmltxtDRyZFSHoALZA+beK
    k1yA7qE0gfot9kUKhlljPdafEF8owF4VMTXD2NfkmFYDDN4p6KKWC+W+AeyLlWG3
    jayEP0Y0hxhvfjJEoVWS3fdMrBDqzuN5I5GthDaQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=szYXSsV0 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=szYXSsV0 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfG6zT8kklDCGx8uDrmimTYBh20WQs386cvV8mYdU9D9ZwlQZJIJlsNkPMdM2L5bURWtDe1ZtKW6cko+axXaPdQNcW4YGE30NotFr+IWrzrOa6TQEcyob
    +fVXXWUcD0pStPwnb7nvaYp2+IVkW0tRgcMTtXNSDvbi3HzXT5xYcSQchmNYIFbxj1az18+ziP3zFsby8jfNrOeRvgtSVGbOcyyt/JV7BFzm2wkxb0tsv4sT
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=WEBF5sqjXZMyK3CwXLsA:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968091AbeEXLPf (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:15:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968074AbeEXJxn (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:53:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 057/165] usb: gadget: core: Fix use-after-free of usb_request
Date: Thu, 24 May 2018 11:37:43 +0200
Message-Id: <20180524093624.325409354@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Manu Gautam <mgautam@codeaurora.org>

[ Upstream commit e74bd4d358e5455233f1dcc3975425905b270b91 ]

Driver is tracing usb_request after freeing it.
Fix it by changing the order.

Signed-off-by: Manu Gautam <mgautam@codeaurora.org>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -191,8 +191,8 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	ep->ops->free_request(ep, req);
 	trace_usb_ep_free_request(ep, req, 0);
+	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
 
