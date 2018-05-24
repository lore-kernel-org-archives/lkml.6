Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527164517-2-12649461769829624217
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
    1527164517; b=e9hlWvYYS8PJk5OyaLgNdDXVG7WYfc01C94FVazkXT/MrB1DF5
    lPnUuePJHr6yJpAXzkmuTzwf0V/zu4v7v2lG82BR9V5cKPrA4MbgasM4++XU4gUX
    irq3qrGtvZqNbNfyWBWyvlEM0bzGiEccM/Evl9BgCs5gdnW3bH9iDbanWOAoYBPX
    jfMZJxrFqe+mHSYs9dEF5Jjw48hL5rO+ATtKo+Z4ZphYPqHO2pjMu3PJDSwIYYfj
    8I7KkXz3RaRdTO0VWMUXhBwB3DUnQTXbbvaooPGPDmnl0IJHz8N2aaEbHwEHQ8qT
    g3LooQzACDGbcgLXwug947FCzorgBxQ7s4gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527164517; bh=1G7Rxbm3/9nVbSnUshoMR2tQiDmVqx
    O05TUEfbBaeFw=; b=OFRScq8UZQhcL1cOAygJqVpZ1s3nRP+kMUf+NuVZInkY5L
    Bx/TLB+c7FR8CxFj00lF8exVddC4R2Xsjx05rlYaLsuBPlRGcA7tJQC5oXS6S5HX
    WFtCwt+LkU3By1Jstwoxq78PKk6Tqv1/yByNbjTXLT1cEGD8VUkB7k1mXyEVhas/
    cj8A2IJ5ONP3Z9YgLdc3w0Fn2IOqFsdpXCRuJlRJw0BGt0gmTV8UwN5FgNzfXdwY
    AJZhb/etZqt2RvTve6tq/l81z4ha6f8fl9kh4u0pPmMDuUet6ha7s5ZwB1cZ4n+C
    XPZdneunnmEShkMJQ6hm6QYbAIIQJ9hptdvh5xlw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=N6R8H6wr x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=N6R8H6wr x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPQi4k2AQ6LkVEaEp0juzYmnr8pFBEQyr+Ulbyyats8myKlbqETGQIJZyw39ttW7PsvwDuxbOABOcIdf+AXdG84yVXz+KgijrsS7WMjr0vkzX9/T5rl0
    D2Xua6Ss3pT7g+WciKVnTUqPPFzp90dXQnhTNXTr42qalembibYlWT5Io/bF+O7DTB9Lg7QrraWwSVOmPSJYekIFha2Ih+Uq/5NVBji1XCw0BnMDOs2BEXo7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=fRGPA_HIdNiQ8ehJAToA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966158AbeEXJlO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:41:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966153AbeEXJlI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:41:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 02/45] bridge: check iface upper dev when setting master via ioctl
Date: Thu, 24 May 2018 11:38:10 +0200
Message-Id: <20180524093120.851911577@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit e8238fc2bd7b4c3c7554fa2df067e796610212fc ]

When we set a bond slave's master to bridge via ioctl, we only check
the IFF_BRIDGE_PORT flag. Although we will find the slave's real master
at netdev_master_upper_dev_link() later, it already does some settings
and allocates some resources. It would be better to return as early
as possible.

v1 -> v2:
use netdev_master_upper_dev_get() instead of netdev_has_any_upper_dev()
to check if we have a master, because not all upper devs are masters,
e.g. vlan device.

Reported-by: syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_if.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -445,8 +445,8 @@ int br_add_if(struct net_bridge *br, str
 	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
 		return -ELOOP;
 
-	/* Device is already being bridged */
-	if (br_port_exists(dev))
+	/* Device has master upper dev */
+	if (netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
