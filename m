Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2558661-1519898050-2-201187297261747116
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
    t=1519898049; b=cvHTqIOhrVKpyrNUsf1Wq+alt8XYvB4o8nV8mbEADMlLZCw
    hM/FLX1R2dC9wV0V5m89+B7BaeLVzm5ItfvQlIBxSB7GVrtTWVYPx21qBT8tKwT6
    WCb3f2r2ZJ3fJRdnTFJACCWiwLeIwfDJMAX+F3vwdeQSbWx+t9KHKDeTLSOwjneG
    tAjt6YIjFUYkXicvAnEULlCHY/+jX12tPSkvDEAsfPjAEo4GvIo0vvw9iZc4RBf9
    7ew6Gequzm8mIlaqMLQgIhwr5CnFh1OquSHGOq0nFKZe285UOVY977gG1WFgJXJB
    FBnZmn5ySQr9uxa40cWodICf7LcIgoqSiHluDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519898049; bh=d+GsfSfrBHAcj5bG65uUdgAXKM
    bjRLqvBF1qqZNXrCk=; b=du1Cz6lYmkkbCCT3GaiCUdtMFNz15Mbj574fNzYmjB
    byosONBeTPt1feAAyW1FH3CtMUfdGtc49BWo/KwdBJsvrnsSWzqpOLOt6yOSO6wy
    5DHgPViEUdxNYTdZ/KZIgYMdQf20Cds5FC/QamQQguYSe0FzJtHVVpMI7uZx/RUQ
    ZP/WwGUDanGYm3fFLH2zLkO4Dw5Y/Rp3GkSzhDuEXX5GGlXV6VlbKDK9I8B+A1mD
    roVjfNWS5Bd7sV/ZaRQkwXXcI1UhWijfABPPtYwOoDwiRkMkl73g4Dt7s/8Bx4ar
    xDZ7UlxggDO7xemM3adKo3Slg+6cuxncAwTqDF6v1bdA==
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
        id S967274AbeCAJxW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 04:53:22 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:16687 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967059AbeCAJxT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 04:53:19 -0500
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
Subject: [PATCH v4 1/2] dt-bindings: usb: ehci: add optional external vbus supply property
Date: Thu, 1 Mar 2018 10:51:38 +0100
Message-ID: <1519897899-8577-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
References: <1519897899-8577-1-git-send-email-amelie.delaunay@st.com>
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

On some boards, especially when vbus supply requires large current,
and the charge pump on the PHY isn't enough, an external vbus power switch
per port may be used.
Add portN_vbus-supply property to usb-ehci bindings. As the number of ports
depends on the ehci controller, and the port on which an external vbus
supply depends on the platform, <portN> is used to make it generic.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/usb-ehci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
index 3efde12..cd576db 100644
--- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
@@ -19,6 +19,7 @@ Optional properties:
  - phys : phandle + phy specifier pair
  - phy-names : "usb"
  - resets : phandle + reset specifier pair
+ - portN_vbus-supply : phandle of regulator supplying vbus for port N
 
 Example (Sequoia 440EPx):
     ehci@e0000300 {
-- 
2.7.4

