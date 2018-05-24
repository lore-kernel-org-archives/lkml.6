Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162143-2-15573578076999882294
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
    1527162142; b=YGoKPZ8N3FIfeBsf7TtN2ZxhfsbIZ7zdo0R7orQreptstheCM6
    GPymurckFmefGKugxT10OdeE66dh6cVjqwag9W402gdC+F5UrAyJawtQCJ19+5W9
    r9rXtfKuel79Oww0J0Qzvjky5mtpHNiaAylJ0DD8pGtXJR5ZZuJEbAoubpRXgggF
    75sFYqOzS9tQJ20zAstBtwl+NAXGvqaVrK++skdWtLzsqNOLcGIFhUddLQ4HD21q
    2XNQA/hE7TX+OJNPOhXESmLXQfYJTh6iy1RnyROPZaF4FK8u1x4z5dL9FtBwDO7s
    PTMdPtGhNKUkagAIzI+n5iKFCueIWE31zAwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162142; bh=uiGdUTbsaUSOWmpWmP+edvEc8J4ohr
    lZBsppbzB8ThQ=; b=NUBlBCAeCY5Pr5BU3y0pG8r8vAz8S/1X41p9iY6HDpMhga
    zr0hZH3o6qYOk71qeLNqlzr8k8G0yI+v7IojpGDdwGEjMgeIFpwhhDUGRK5I/eJU
    JIZ1BGyJiGuReD2/Ib2EnnX3rKq2Oy0i3VViohT7iy9bWGcuSZzDucrdWdtvanK2
    91mrjTY2WjIvMcFqZTFnzD5xPR7Nxpkpr0L1ptHcmgq+lgCycLV7X2ahDAJk4qPN
    EpPnfh6upraE/a34e//BNyoOb/zk3c52LY05lsfIy1IG+G9Jtl3X8AE+Tis8CGZv
    yP7Yg7tOjcXSI85kTzxaghNb5ePRNFR/JPWSTePQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=WJDLwvTf x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=WJDLwvTf x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJbksNl2rcIvCmxV9ukHZkHKwhE/6mn8yzD1TcIFPv6RORuc++JPRP2Lk99bSlyIM0Osa03TwrihWqOr0oHW0s6TnsaVJF2TJ70gQHIvicR2NGZaqNcu
    U3XVpWbya3cZKx9X8ahvttgmdugSNXtFoAKmk6++C9eN7b2KpZewkvuaC2YqZlLgJZ2NPTkw7JPdGUIYHtwUvHNZrN/FYECu8urzi0dJ3YgxNGJ2wKqRlUuI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=jRutK7hKn5Zijk1ZCrUA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966884AbeEXJsb (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:48:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967222AbeEXJs1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 39/96] usb: dwc2: Fix interval type issue
Date: Thu, 24 May 2018 11:38:22 +0200
Message-Id: <20180524093607.795045924@linuxfoundation.org>
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

From: Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>

[ Upstream commit 12814a3f8f9b247531d7863170cc82b3fe4218fd ]

The maximum value that unsigned char can hold is 255, meanwhile
the maximum value of interval is  2^(bIntervalMax-1)=2^15.

Signed-off-by: Grigor Tovmasyan <tovmasya@synopsys.com>
Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc2/core.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -209,7 +209,7 @@ struct dwc2_hsotg_ep {
 	unsigned char           dir_in;
 	unsigned char           index;
 	unsigned char           mc;
-	unsigned char           interval;
+	u16                     interval;
 
 	unsigned int            halted:1;
 	unsigned int            periodic:1;
