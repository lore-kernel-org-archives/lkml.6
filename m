Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161868-2-14279391802661018271
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
    1527161867; b=L5/zMjFSAHnzFvKXZj5wItpiZJTSYwiVHiQAShKbaMKiOhY2pP
    ihEaQULUAN3a9OUVPa3hk5Oe2kaS9i+21cDURMg58uP2baFFDVQVo3k9A0FVS32b
    2E2xX6BXGhFXmGgfMjysNGqppIVd3I/qkrHWKVcRUa5uEpAKVeaDcWIPcKbgU5Re
    UFoV/H6j5iEW4EEewPqk3PCvfwCDXd4aeycVoghIk5uk5ODKN7zDb9KcR8VySeFv
    V0YzKurXuERUIwiZoFvF7s+AJ/RlDuot5EEYnUhENI5uaUFVZulehGCvZq2py8y9
    27qbVyk7zcOIHvNPLI7hc7ckfh57o9rOqD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161867; bh=xW0AZYo5g93NS8dimkiEgCa8+OQ8xL
    ueQ2pEOapk6qc=; b=SFKlCRDHfuMwDFfcpwMYUjlL4yF440SHyOBHUX18NMpGce
    E+/uitOfw8rrn2cRbLQ0Jmzv+Auou8r/fw3ZW39YLpSxn+Za4jKI+amxjU82GM7N
    +I+MYex3kRyIV/RtykA/7kq4dy3pBZgA0vfVOMPOugUulbvVoF5TpicLZSzV8PIv
    chY4B9XJrrtrZrW4S+jmyCLak1mTf2yuj2odMRNIJZlvEYac1ZLKFs3/1oeJNa6m
    WM6lVqPanWMXdE9LJAV9g4HjZUw6Yz0FdtXjUG/aSY9FSEubBk0repLEH2eF96GD
    rw8AOCQxPI9NJfAWWnkZ+a8WnpUU08afhYF15E9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pUwm9Fwt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pUwm9Fwt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIRxCPeDdCLikwTfKJ+CwU0wcLvN4088XWCRK885WjB5rKxT1UUJBIFhdgt16/rRmyh7R0XsuIeL9scjJYEJiA97GbSYs9q8TCrRvk4PodUGicf9gFGD
    hEudqdQ/lSOpG6sjadjIFjQvs61AegCLrTExGnIv7+AIqPTTY1alBzJT3lb+f3H2gQDXGpY5aDon7y+0a4R2F81RtgGEjr4Yn+y8jQzH4S0qWPTeqMkYw6vi
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=WEBF5sqjXZMyK3CwXLsA:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967395AbeEXJtb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967093AbeEXJt2 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:28 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manu Gautam <mgautam@codeaurora.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 27/96] usb: gadget: core: Fix use-after-free of usb_request
Date: Thu, 24 May 2018 11:38:10 +0200
Message-Id: <20180524093607.124199786@linuxfoundation.org>
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
@@ -190,8 +190,8 @@ EXPORT_SYMBOL_GPL(usb_ep_alloc_request);
 void usb_ep_free_request(struct usb_ep *ep,
 				       struct usb_request *req)
 {
-	ep->ops->free_request(ep, req);
 	trace_usb_ep_free_request(ep, req, 0);
+	ep->ops->free_request(ep, req);
 }
 EXPORT_SYMBOL_GPL(usb_ep_free_request);
 
