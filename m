Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710425-2-13841802919735665102
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
    t=1518710424; b=Jq8peuJX6Xsz+5WnQi0g1ut6mpbYE4s0Ad03ReXedUlhltQ
    EmlpwqcJC7tF2yUCZvzVSynI/7zs407IdjnYmoSWT4E7ZByDDA+Jn0mXe8Vk9SeP
    PzsjI2OzGxW7j8uYTPU3MFk2CYkB35jnpdISTBlkroFgnrGJemQ8PMUpWgSgMftO
    o4Obwh4ypqQGhr/tR8vPy2InGj0zBX1GPd4QP7xHzD4ir0YbFlnKx2waf8vz9peJ
    QOuWUcJ3t+giIRW5ctpnZr+ZAhrNsgLC8+1MGZQp1Pw38q2+Olf5tV/Uo2z0++dE
    YWJqJaJxbmV0yHam2zkxN62mBJUyIirv+cUDc5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518710424; bh=WL2vP5EQ0PKa77y7MHWejV4+5evWBwOZD/xZ9B6vgVo=; b=o
    SJq3X4PousrRm3ij4nUWA68kObXmW8tQ55iiHA/Jg1wXpglAnqC9DSHBFV6byIa5
    XGR7y9SIDYuoeKynJcGKgV0sMmfJZcL/2hnA2o2CxJBoy6vntImmWNOMDAEPWu1O
    JBrmwU+kfmFT8cBXDZxCO2duWGGZPIITMyMsvvgALTx4nVj6STZ/DHqrI+uxd2/0
    Tg1GpGkusQoIvxXoD520y/99lerfp3+la9JPfaBogaoAsutsSQl6XUGwjW8OIxJG
    Ldcn7o64+8ytomy8I1iMCJeUrLDP+Gs6jaMlNwavL6eniDbBw4cPULD8Pv0VIhZg
    awzCFNmsk6OhJstbR+2Hg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424972AbeBOP7i (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:59:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:8319 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424802AbeBOPrB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:47:01 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 0/2] Fix STM32F7 DWC2 OTG HS binding
Date: Thu, 15 Feb 2018 16:46:38 +0100
Message-ID: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
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

