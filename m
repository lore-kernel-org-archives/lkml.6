Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162117-5-647072539833488212
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162117; b=GhKVY95G+JA8Qws10eC1nJhsb8kbdtvxlZ0nT0FOFv9KvkbJmr
    932jyJ4pMPPMABW/AGHoSykDM255iKN5jgWv07dX2knLaVeR8h+yQPtSowbYKpmP
    ciAJsytG5ZUUKbx5Mm3lZwkiThc8JpXTPs+4ROiW78woret8dAXvIyPIlbP1OPFL
    ELPoffiYfIkqz0kduGeZI4FbMF7kA14lRuOjmt5uqt7P5mRg/BE41wFSYKHg35M1
    O2VYAoBgW05NkiG6g9txFdkOwLrywjffEpNZ05+C4TI/bp8Cjts5nQqUBPjeON2l
    5xdEUZJgn+MLm9iBMJKmL3j+maUWIyvrhngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162117; bh=W/zk9wMpztVxasYmtjLcF7cuBArHPE
    zN1cmhvgHckNk=; b=SS9fNcZwCPo4A7RpIB6q5fNnDd8LYpj1SwDI89r0zjr+el
    Slpj6l/HxYIRSnMeGs2ljAZB/oJ9MKC6bFZXQPWlGIeNnu8qMLCJO0AyrX5zOhjT
    k4ad9Z1nwuiZmxCblGIZvWnXWQG3hOFNkCfrhz8M7iudGaeqWL/EYs7unDwP4DhN
    r0f1ixR4LX/wNmMvjTOjPT8H356ZCpcUaZpzoA32rfuQw0KW2QO614XwC9kTem5S
    zRefJWhcOB1Qs2PXREDIfphnxduj7yCxkDerf5GjzmrahXMmWcYe+hFAVhV1OdxG
    b3EHUK+edRuZcIKwy8dqvdu72O499z1U7Gkzv2Yg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=teqVMbQ8 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=teqVMbQ8 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOVoEgLS6hy8UJjzYH6mgzydlAGAfFORqMNRJk7IZtiY3meKPEwWLoAtf6wbkmuwyEAtuCI60/86NMYH9cyVGdoE9VBVum+l2DEHbfCOjEUfsCoz1tq8
    ZQchtalhRDZlCsS7gxmUeqb+NeRWWTOtecvJGvr8mv5iJOdhkWHnZHqtvWL6RIFgORoS7I1k7JVkEpxUVfSI9dUexrnC1F7GjjxsYAqRnyBzLHJVo3B7aQtr
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=LDBv8-xUAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=0kv7T4GisTnoiZl4V4AA:9 a=QEXdDO2ut3YA:10 a=DZeXCJrVpAJBw65Qk4Ds:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967295AbeEXLll (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967252AbeEXJsl (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 43/96] usb: gadget: udc: change comparison to bitshift when dealing with a mask
Date: Thu, 24 May 2018 11:38:26 +0200
Message-Id: <20180524093607.989213851@linuxfoundation.org>
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

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

[ Upstream commit ac87e560f7c0f91b62012e9a159c0681a373b922 ]

Due to a typo, the mask was destroyed by a comparison instead of a bit
shift.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/goku_udc.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/gadget/udc/goku_udc.h
+++ b/drivers/usb/gadget/udc/goku_udc.h
@@ -28,7 +28,7 @@ struct goku_udc_regs {
 #	define INT_EP1DATASET		0x00040
 #	define INT_EP2DATASET		0x00080
 #	define INT_EP3DATASET		0x00100
-#define INT_EPnNAK(n)		(0x00100 < (n))		/* 0 < n < 4 */
+#define INT_EPnNAK(n)		(0x00100 << (n))	/* 0 < n < 4 */
 #	define INT_EP1NAK		0x00200
 #	define INT_EP2NAK		0x00400
 #	define INT_EP3NAK		0x00800
