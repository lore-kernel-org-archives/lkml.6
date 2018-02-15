Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710448-2-14712350638163554993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710447; b=PDibYDBk+a/yPwMJ9tjsN/a5ZL2Xp9pjpenqd1NACwsyoNY
    cuMp3Ozkz1f5sZwII8uyUV7NwI/XdnjsgpUQvbXSjnGfAR+Z/CpK7f9y0wBhfpp7
    AbQeL7flE1CwEJ0Fx/t3O824LDPnbNUYfHyykGt26LpGPHneicwHdKGgWwQL1vpQ
    lyv63jBLKvo22k+WsOnvK8SPI9SFGBYvAT2+8J/B+jlvzYbzJC+z2+Bz6xcDjvtg
    KRkFDHrwQQ4h9gpPlLCDAvAXpZxJduLLpKkAxLTIXFZr8vphQHv6rs/qzDUGabqy
    ad6c1Ln/iNfqdA8eibDkUMHD8f3bwCalFbv7VDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710447; bh=WL2vP5EQ0PKa77y7MHWejV4+5e
    vWBwOZD/xZ9B6vgVo=; b=QJQ3grCZEfPAw7lzAsHhTloQXwJMfRIaI5pdQvcwA8
    BIwNruVGINg4f/EQp+eWIvfS4NXDhmTMItD756YYAv8OMSUPAReqjpmfG7PQv8Nt
    4wFL63C+rHU1qKjcv6+qNRJcuvK7yIdztFc6LXG3WSWwYx5wZmeu40MSD2jrX1RE
    hh3fEK07Hf3GA2aKExTPttfeDR5agEE6LQwmM9TJTHlgvip1IMFxZR2fxs0zPzM4
    loJCICE+1f+TOJXn8/7CKE7yAh66XF9ORsS8pzAHxYewmu5MCmtuO74dFnAzpg+c
    XNQ9EbmLRYOimILEpAuG7wi1DQZIsLS+HkxdxkeK0ccA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424830AbeBOQA3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:00:29 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34262 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424800AbeBOPrA (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:47:00 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [[INTERNAL] PATCH 0/2] Fix STM32F7 DWC2 OTG HS binding
Date: Thu, 15 Feb 2018 16:46:39 +0100
Message-ID: <1518709601-17232-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset fixes STM32F7 DWC2 OTG HS binding. It actually
re-applies the v2 former patches adding STM32F7 DWC2 OTG HS support.

Amelie Delaunay (2):
  dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
  usb: dwc2: fix STM32F7 USB OTG HS compatible

 Documentation/devicetree/bindings/usb/dwc2.txt | 2 +-
 drivers/usb/dwc2/params.c                      | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.7.4

