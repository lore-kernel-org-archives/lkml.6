Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161869-2-5688895573847361900
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
    1527161869; b=A4OD7WmiFod3sctN0wrUMJ3Prov1dPbxMbyIJ+gKdOAp8in3Yi
    vo/4QYbLkDHxG3IL3Ab/NKePFgy8blPm4qLNfbzHdAnuUVOX9o1HF1BvaZepgBY3
    /PxY8f7xdNdS+xfR4oUcQoTK+l6tt1TyAXliIc3fGAj5L7kn8H6d6xKdBpCZ9Kof
    Yqr2vnapNST0RGxbK2b7+STcdnJfj+r4dRoIEXFQuCIpeTlJhzoH5QsqOfeIyq6C
    trZwExX9Y/U/YGSEyhZtNuC3vRBJpPR/74qcJF+RpAFRIcL/8W70Nj4S7kamrIYV
    EBzu4V8dMfwi8Tdw6DK49y9OmwTvKCHUyMDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161869; bh=CVlyoyJYTevkSukK5ng0HcXpOHteRR
    EbrfaA19CKk5c=; b=jaY+QFIbiYRfYQoo5HDUaGLP3mJB8DbRmylLNpX6aAVfDn
    oIQLd19rOs7Dtay51W6RaevnK8frwfCLj3C2Pnz98RNQTb7vOz/lGYEOo634jiyA
    SvYA+jXSljQBkgyvJSYWzETwq4MjrTvDctKwo03dMJSZFAUt03QuFNEWHNiN3xMo
    +IhUxzQ2hcqdUCv8lAonuxclOnlkxxmaLp4loBYg5/lGHXQLmwl1s7gJJxppRhAr
    yenMqM91cVguPwUSpOGxRYZ+2v5XV+FE8NkAO2f1KZ/JTcHTmsBn+URBOSseuWL2
    4Ef0n0mkqS91Hom0h6B9tt2KmSSe4VZYMViD3a5A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=UvVbuzx4 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=UvVbuzx4 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEPdOvW0hNZSnlvccvVH0kdjCZ/S9O+aRhoJlMyFtYZyRwR6yFmK5Mz3OzZO1zUyaXj8Ads8BzK6b3afUJscj/g1TVhFTGVmVHsQikp5MI8w8P5HUgso
    dezTQH/RNYPQQEpVqLoQjuqaYrDxGRkYHoMGJLgQ7D3lNAdQg9tIiwA5e7QHxtlvGbAzwdwp9WI7zI1wd3n4yHo+HSgfQy4c+v5OG+068jRm4MI/Wt9rOYxg
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=9-t-i2tgmufFbw9nmLkA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966550AbeEXLho (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:37:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967393AbeEXJtb (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 28/96] usb: gadget: fsl_udc_core: fix ep valid checks
Date: Thu, 24 May 2018 11:38:11 +0200
Message-Id: <20180524093607.185179302@linuxfoundation.org>
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

From: Stefan Agner <stefan@agner.ch>

[ Upstream commit 20c63f4089cceab803438c383631963e34c4d8e5 ]

Clang reports the following warning:
  drivers/usb/gadget/udc/fsl_udc_core.c:1312:10: warning: address of array
  'ep->name' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (ep->name)
        ~~  ~~~~^~~~

It seems that the authors intention was to check if the ep has been
configured through struct_ep_setup. Check whether struct usb_ep name
pointer has been set instead.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/fsl_udc_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1310,7 +1310,7 @@ static void udc_reset_ep_queue(struct fs
 {
 	struct fsl_ep *ep = get_ep_by_pipe(udc, pipe);
 
-	if (ep->name)
+	if (ep->ep.name)
 		nuke(ep, -ESHUTDOWN);
 }
 
@@ -1698,7 +1698,7 @@ static void dtd_complete_irq(struct fsl_
 		curr_ep = get_ep_by_pipe(udc, i);
 
 		/* If the ep is configured */
-		if (curr_ep->name == NULL) {
+		if (!curr_ep->ep.name) {
 			WARNING("Invalid EP?");
 			continue;
 		}
