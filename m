Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162184-2-9427385869662402149
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
    1527162184; b=VKtJbNwaavnJQgu5EeAmicbTbUKP/iI8rN+0WXRcJmiB3U5p+4
    CXoTeB9Pdkm1Iap00BP1KZn6wx2QAINHqqZBWwNuPhrXdbIqQ5dKSu3kt+aG57as
    4dSTH483FeRxDUn8OJDS4SeAkYD9MlttfY5/lF4pHwIw+izJHnnmsCleG5X0SwEF
    gCUqZZ7NQLCDmnLK0sA6G2A+FojcUU5PTMeHzingJo373Hkg5zc+UfAfN8PIouEb
    TH8yeDxQHXnfdX+kg8aa8CRcCXiH+/O5yG5cNjg2eneMswnd+QliFUl4zCt21NZl
    T5cZp/IKhGp6pijG+S+kS4ibRYCS7hrLNjSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162184; bh=gXdlPx+4XiwZ1UiPLugQpb/PEYo0iz
    VrAMclh77DiWU=; b=D+KlRr74qdkLaqFjZfAQgTgDm4fAZ4vkaf2EDTubt8q+V9
    zvLKlB42XWIksgk/LwkmPcNw4cMNtzh2GiUVqsMHW1YNMtXX9y11gil77gqosr4z
    NOiLe7u5hxeSOsUrEO0FI3hRtNAJfQw4PZmEBtRG+4pkgDlN/LhOFZHS5H4FKpGW
    HmY6TLIMcsn9kUIIAN0SvfJqzbrxa33agXkdOTrsH7Q64wqvKCy3ohGp3m32kj/m
    iKeQm4S1/X9/++wsMtPr+gDGFD2uoI9S81oqVebOyJrCeSna5OX1xGmA6+xHujgg
    EcJDFx3eDUPrj9zZnUSJEkQ6nuagq2dBkqaC04Ng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Mc6zQ8ei x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Mc6zQ8ei x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIk5vNKoUHNemL1TQiz9fR/7qhbA4q/mSEsSMDaMbnuhkXNozNCo62V+TSOZmM4GB3nxUzGx3cnlGNXy0ODzs5lixbrRQiK8c5kdH5vxh298GQ4VV5GL
    +V7B6iJvzY3T1De5S+TeRlY64itJ/8y4inTbdxZJ7QJ4oCpX3H0iIkRmJjldDhBu4pfP/76Sb3w7Q1aSfWHRn5xnJM+H9pWRrtq3++I1CKIAjNRAg3jzF+Kl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=JaPq-73m0TlQmVeIr-wA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967258AbeEXLnA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966483AbeEXJsT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 36/96] usb: dwc3: Add SoftReset PHY synchonization delay
Date: Thu, 24 May 2018 11:38:19 +0200
Message-Id: <20180524093607.649376350@linuxfoundation.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit fab3833338779e1e668bd58d1f76d601657304b8 ]

>From DWC_usb31 programming guide section 1.3.2, once DWC3_DCTL_CSFTRST
bit is cleared, we must wait at least 50ms before accessing the PHY
domain (synchronization delay).

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -161,7 +161,7 @@ static int dwc3_core_soft_reset(struct d
 	do {
 		reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 		if (!(reg & DWC3_DCTL_CSFTRST))
-			return 0;
+			goto done;
 
 		udelay(1);
 	} while (--retries);
@@ -170,6 +170,17 @@ static int dwc3_core_soft_reset(struct d
 	phy_exit(dwc->usb2_generic_phy);
 
 	return -ETIMEDOUT;
+
+done:
+	/*
+	 * For DWC_usb31 controller, once DWC3_DCTL_CSFTRST bit is cleared,
+	 * we must wait at least 50ms before accessing the PHY domain
+	 * (synchronization delay). DWC_usb31 programming guide section 1.3.2.
+	 */
+	if (dwc3_is_usb31(dwc))
+		msleep(50);
+
+	return 0;
 }
 
 /**
