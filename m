Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519981752-2-12245032305370007830
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981752; b=nuUPtai0IomgkaPqo5V7VUKMb1piLGN6lXuuRj24hOCklrs
    VvfD0gdfVszgyOQ+jWGR3QSs+VdDNP3OgUsGX0zH/eNEvIEaUV1KIkJzk5r1a1gS
    te588+MAwJfxeBYe/R0oj9Vso5dH7Wd+jCNnB5yXGsdyEVYpCYj66oEBMb6pZNoA
    BzDFqr0CscvRXx4X+qfaYgOYdbePCaAUP07eHDbOhXE9NzWuL9ssh7aBtuVs+q3d
    BoS/RfnVIfjN2NVcWutM4y1RgXsZTWifWF/NTIV48IQHyB8SYEWJeVo0fEEEvRms
    73I8Ta7iG8rX2d53ihfl9IpKUK/8UzMl0T2xuWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519981752; bh=NyElP//TBgSVZGETY41Ft58Gej
    9FljGU7vT/NDEcIi4=; b=EqJMYRZlBeplVHLX1BG2RusVWkLh9DhH68FgMfg7c0
    LWeEuEjucsIY/hlhKTKFOTH1jfmKRGWn9sVVRniCNtFPDibgMMA5FxgoPHZOAm/Y
    jLee7QkcsREOkH+NMOtsCJujp25JpN67ELMYYEbYx/FiY2jl8iRbBwwSFemxQ7Mn
    AxY6oIiUitxMOOFdqJ2m0W27qu9eSuavM9rxz/T6G6sxcXAYCOggZsS3TLN3yEiH
    O83SdXVdBF2vlzYu0vj/hWfIZgL/pirnGt8MuYvD5vAJPax9ZFHr1IvK9jWVj4qf
    XQBBr6VrVJ+jaOW4vFVEhRJke1U7w32/TcO1yZ9/uRxg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424785AbeCBJIr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 04:08:47 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425266AbeCBJFl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 04:05:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eduardo Otubo <otubo@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 097/115] xen-netfront: enable device after manual module load
Date: Fri,  2 Mar 2018 09:51:40 +0100
Message-Id: <20180302084507.766977592@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180302084503.856536800@linuxfoundation.org>
References: <20180302084503.856536800@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eduardo Otubo <otubo@redhat.com>


[ Upstream commit b707fda2df4070785d0fa8a278aa13944c5f51f8 ]

When loading the module after unloading it, the network interface would
not be enabled and thus wouldn't have a backend counterpart and unable
to be used by the guest.

The guest would face errors like:

  [root@guest ~]# ethtool -i eth0
  Cannot get driver information: No such device

  [root@guest ~]# ifconfig eth0
  eth0: error fetching interface information: Device not found

This patch initializes the state of the netfront device whenever it is
loaded manually, this state would communicate the netback to create its
device and establish the connection between them.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -1326,6 +1326,7 @@ static struct net_device *xennet_create_
 
 	netif_carrier_off(netdev);
 
+	xenbus_switch_state(dev, XenbusStateInitialising);
 	return netdev;
 
  exit:
