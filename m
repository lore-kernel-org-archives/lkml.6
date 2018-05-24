Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157561-2-7235659487902683866
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
    1527157561; b=ct3fJarj9m7uafY+NcAeBhifAKKAHMlwiGqaHjlbOXL79N/vyn
    hs/nUq02o61ZiRzotLX3tLxI8fojESEVnOU6gfux8R9u/Euwih3m8HB09sUBrE5f
    JcaCAJZdujIEywADOLo8Fql3++hol4sfn5Cx5dfospD9JiKajz8qFKRqAL0G5htC
    adpEN38RNciD8H3vWegEqaKxl4xBEP4fQwjJaiywmBF5gaiLaKJDnod43M5RvJ47
    pQ+VYFnYGlPlnLRdreoEyMt6ooiRx1MaXXejW0vPBytgj/KT1S8mWhjTxThVwjK3
    E1w6NJquIaVWUZKKZIW/84ZiKIi1QOL4QSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157561; bh=q/IhH8LXnPJ4mowFKKzHF/2fWWxNAN
    041QkXExx51mM=; b=O8/x+p8twO5/IlZx8tX2ZCTXoqvLEM5OS9ni0tK1VgRkd4
    RNadbJv0CXZr0IDOA94EHYfkacqGXXjNTZfq0APYsNlef6vBxw6+wly4ZM6yonvM
    6A8TvvAog8bSV2aml1LewD67ExymRZBEwjOgM/bKTKn/ZknpFNN4qsKYIRvdYHvX
    vdpz94GX1zU7kuMO5Zqt0AKg4PWwu/upvJCMr+xY7IV/bFzrGpmMXnbYvWT84ZWS
    uB/42NP7XcoRcpjOIwOcntDlW70mwkBG6y0AzOS0SyGE15+lro3uCrwMiBggN8PI
    CkILoiHtbwIKEBZ3+IBnyWTERey3QPdYKpNh0now==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NMJrTIvb x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=NMJrTIvb x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfAWw3rs2II9ZZmw0nDSSNKCQMBcSWD+mkrUvxntKORuX1Gz4QEP9hToK582/GTq2ousVCEs8lQcIH91n4KbLURj7+woORfFb9wqcZGoq0GWRNbwcoOvv
    avPZ24m5Lxnkc45SLFAbQUtpr+hMs3D56xfXBRE/SSFAEFCDFvmWFe48Z5ECeMls8aD40B8fY2yYH21mwK/k41+LScYU0QrZW28XdZiWT59bbUGiqwpZSxDV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jIQo8A4GAAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=jRutK7hKn5Zijk1ZCrUA:9 a=QEXdDO2ut3YA:10 a=Lf5xNeLK5dgiOs8hzIjU:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031049AbeEXKZp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:25:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031003AbeEXKCC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:02:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Grigor Tovmasyan <tovmasya@synopsys.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 072/161] usb: dwc2: Fix interval type issue
Date: Thu, 24 May 2018 11:38:17 +0200
Message-Id: <20180524093027.135169067@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -217,7 +217,7 @@ struct dwc2_hsotg_ep {
 	unsigned char           dir_in;
 	unsigned char           index;
 	unsigned char           mc;
-	unsigned char           interval;
+	u16                     interval;
 
 	unsigned int            halted:1;
 	unsigned int            periodic:1;
