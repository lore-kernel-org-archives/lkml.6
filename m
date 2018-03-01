Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2549546-1519897966-2-5504730097547351572
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519897966; b=w9xYA0HJg1QHeOdHySFk0znlUEj3sja4+9aQSTLugEc/0HS
    dHtmZ4u3uJdibNiLH4nLjoMvBM95TLAMG+Lhd8C0y6hPc5hPdSnjpL5qzt7U417K
    LrnUsL0yjouAv0pfmPUZ8WFl6Iu8teMa61PL4BN3hlRJB0lhcV3UvUl6PqGV81QK
    MDy+4jojrOXA+CRLpD3zGw2izmCTOuIEZzMEfB1SypUTGv9PTP1BWcFgUOCKD5dt
    JOMvTBLheFx7drjT/JirA3TRHgHC8/ruDwc4zXW6RoL2dNxikMIK/Qq4rFnpY/lC
    caDCEzZnH9hLz35bOgxvOG6gG50dF8WQW9OY51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1519897966; bh=Myewd2CFDvzB5Gpiz42MGfiRE3FI1dJt/ALQH48TvT0=; b=n
    VU2eon/Toe3Mzw05ySMMo6UM4ShHs71kBtRZVE5Kc4v9ecmGhnuupC2TjRJqlG50
    /7LZ0h0+u7lH8oS/xJbN6jY76D8GTiWMM2ZvVXs0DwyjKoRS5COzf/O3BPbWBXZd
    /OHG0ZGtIZtcP1R1Gq9kvtcv9JsA03TZxsksnMRcK1Q+Y2XUAaTjqHJ55WP9N71K
    wujg7+HdrZay9httSkt0N+b+j9NlZSaRjyf+N+y6UbpjK/RMBsRHVO274EMTfhR0
    xCTiwEzVZvni80ZZAoTic2SlhcxC9o9dO/VyYQgf1vMRsOCVRHZc+cO3hDsGQE7C
    ouuYvWrGudnFVD1n2p3Qw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967125AbeCAJwW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 04:52:22 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64942 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967107AbeCAJwV (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 04:52:21 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Roger Quadros" <rogerq@ti.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Robin Murphy" <robin.murphy@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v4 0/2] usb: host: ehci-platform: add support for optional external vbus supply
Date: Thu, 1 Mar 2018 10:51:37 +0100
Message-ID: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patchset adds support for optional external vbus supply per port in
ehci-platform.

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
per port may be used.

---
Changes in v4:
 * Address Roger Quadros comments: split dt-bindings and driver changes.
 * Address Robin Murphy comments: simplify vbus_spplies initialization.

Changes in v3:
 * Address Felipe Balbi comments: reduce indentation in
   ehci_platform_port_power.
 * Address Roger Quadros and Alan Stern comments: platforms can have one
   external vbus supply per port, so add support to get as many optional
   regulator as implemented ports on the host controller.

Changes in v2:
 * Address Roger Quadros comments: move regulator_enable/disable from
   ehci_platform_power_on/off to ehci_platform_port_power.

Amelie Delaunay (2):
  dt-bindings: usb: ehci: add optional external vbus supply property
  usb: host: ehci-platform: add support for optional external vbus
    supply

 Documentation/devicetree/bindings/usb/usb-ehci.txt |  1 +
 drivers/usb/host/ehci-platform.c                   | 51 +++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

-- 
2.7.4

