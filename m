Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1920597-1517561042-2-4110674019131874519
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517561042; b=KMUIaeVS0lw7yGybcagTnEzh4aprxtbcG/dWr4S7o0y7WIu
    e4Sm83gUAKm01Pan06gCE4pjqjglhTNCQnqdBvuUJEAggfdk/ZOQ+N3+dPckozyo
    sXfkJi27fQ9pmgHcOtHs6sq2kJ1XgqZmcpNvi9i3DVJn471xG+4S2etgoB2jSe9t
    QtfB1dl+Cj0Tu4HB44wuEjldLBVsyF3BiJX2Gk6O1Cp1Znq24sMBr07oBwtO1BVb
    RvmhFBd2oXfHjbYl4RpwaXDtwLOs/Ui3qpyIS54mMQOOenJLvh3oJhx45Js+KsU2
    TmnzKEacB+iZnGLGpiBh/sSwHQk1ZgeWHqX8kDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1517561042; bh=tjkyGhfTJ/ayFFJiHa8ToNyEQ6CUYwpjbO71BsqI0mw=; b=N
    Q7F24Avlo3Fj3I7ghEW1hywN095vfcE+Oi3oT39qxMG6Ii+XJ3DYYsTMERzWkE50
    tmqk422YhYIk8s5GQ9LLCZ6X7qoyPDtA6kO/D2Bluy6RPW3Gaznz3esyREXPX/dn
    Yxbq2+shCLYyKt5TWklxiuF0AAnDOKK7q0zbs7iliSoIYc4fBIR8qpS9aOKHyNuV
    clsq9mLRJXUPSrrwUskZhfzFLDO0nQrlTZMAy5kcJu2y/VSM1OO4gzZLZTXP7L2r
    Z60nUiY6vX10QfOPZ+lLrpn0KlragmRrpFVDzwgLueaAQk+DfYaE+FtMAxCw1dqF
    xUJkR/eZu7neKbwlKdQTQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=realtek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=realtek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751376AbeBBIn5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 03:43:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:46686 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750795AbeBBInz (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 2 Feb 2018 03:43:55 -0500
Authenticated-By: 
X-Remote-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID w128hrXK023468, This message is accepted by code: ctloc85258
From: Hayes Wang <hayeswang@realtek.com>
To: <netdev@vger.kernel.org>
CC: <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 0/2] r8152: fix rx issues
Date: Fri, 2 Feb 2018 16:43:34 +0800
Message-ID: <1394712342-15778-283-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.177.200]
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The two patched are used to fix rx issues.

Hayes Wang (2):
  r8152: fix wrong checksum status for received IPv4 packets
  r8152: set rx mode early when linking on

 drivers/net/usb/r8152.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.13.6

