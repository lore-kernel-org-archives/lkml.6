Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527154982-2-15631652058901821560
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
    1527154982; b=jrFdaGX8zOLMylDchSgut0v60eZCJiOnHffluEQySFuwVsKbbg
    bP8zc4iq01V0XYO8XN/UjMFCp8QsOvjkhQFmr42MMO+9cjFL/fKAd00vUPVuPrQC
    nnFBL5cb2xCfHKziK6p0mqPbeWvD/TQqFhQZsN8PG1zHdSYagKs5+rR97leAAhOK
    FZ79OmW8lOLDHxgx9fTgYYhrN5kP9gsNMYh/o31d8h0y8ZD8VUkInMxv4xtgqrnd
    W5Z5KtXJAHxBQJU9xt8ic3VRxXKA2o6ZRXvTwzwIA2yDIFjT4zyUf2UQkvMAR27Q
    mPAD73Y+/1YR/0ZshluObdmD+wbMikoUgX+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154982; bh=G9+d3Qijb9SlsGb2KERvQnwO4sQuHk
    HYStKry4vrBxI=; b=bN3Uno2wqwL53e+ZCqb402g7w4DBfp8joDAbdv+mLxPzDb
    lQBb7h46zIDFGZE6BD6dsU7ktavfQIbHu4pJDvC4FMTQBzj9Oo+LxSAB3CV7TBxU
    skaSmkTaFU23Nv6VsgdHNzopYu0TBzXT8Ci69obM5bd0skuWh5XOCRCnTTuayk6t
    7oxdf2YCzTbAdkWpWaRU+L5/6bMpkOt4s2/tv9pdFRNTtWu/hyuKW9yaI5zwk6Cu
    McGiULjL3GyhzRvQE0bzDJRdaXO13VRF/h1HJPWbR4aRc3wGilzPZ2uE94CslvSp
    85DRzc8OZQ4OlswMTTUvAM+lfG2yviBf5H8kJa2g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=IKJqz1KA x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=IKJqz1KA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOFWzv0moyL1J1e1xx42vPk0+00MAdQWriy53S7A9pir+3a6eWYbOVFv4jqVifU7ln6bzdPEo8amlliR6S3nd3O31+ZQDG8nAG+4XaAmmlry63/Z8ALX
    +zJz2MF/ABNVfh1RWMttH85Qt44pCtHXGvMHiiVI20BL0juR3aJ90xwDkZHNaFZDZffv/qDv+Rk7QwxCXZnLHY/TyQp6bPs7hSSZrmvJ/qgVCZO3lQEmP3KV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=hSkVLCK3AAAA:8 a=CDq0vqnqAAAA:8 a=J1Y8HTJGAAAA:8
    a=ag1SF4gXAAAA:8 a=fRGPA_HIdNiQ8ehJAToA:9 a=QEXdDO2ut3YA:10
    a=cQPPKAXgyycSBL8etih5:22 a=Xn7iXEen_xUG9zZOO_Hb:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966382AbeEXJm5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966408AbeEXJm4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+de73361ee4971b6e6f75@syzkaller.appspotmail.com,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 02/92] bridge: check iface upper dev when setting master via ioctl
Date: Thu, 24 May 2018 11:37:39 +0200
Message-Id: <20180524093159.476457655@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -456,8 +456,8 @@ int br_add_if(struct net_bridge *br, str
 	if (dev->netdev_ops->ndo_start_xmit == br_dev_xmit)
 		return -ELOOP;
 
-	/* Device is already being bridged */
-	if (br_port_exists(dev))
+	/* Device has master upper dev */
+	if (netdev_master_upper_dev_get(dev))
 		return -EBUSY;
 
 	/* No bridging devices that dislike that (e.g. wireless) */
