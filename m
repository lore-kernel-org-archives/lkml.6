Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3118118-1523473685-2-9321183644210436365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523473684; b=ft2gKZt3vGYqFc5/CGVSz58yqqhqxRS3CvE5VRTxFA+jxBLIFH
    cA7jrz5ake2lw0Xp7AqfxzleLTEMpwFC/EGyav1ZzaRRvaGDKRCNqI7sSi5bqw6F
    xI/TabjFybuLu+EnLN2tcwl4BLhcXudRvXEHegF39TfvYW7E24nOIu1b8CST6Xhq
    Mfz8R5dMW8XoSzo2kB3fmzBulLgzArociZOSiinveD64juzqQleUtpXRiVj1KR9O
    str/uYOo+KfiG7htFrugfKc1UR18NQf2zs0HJ45E71Ua2S3aaZS6afPlffHMZS4x
    sUmRZegSK2plhqFdC97S7EBgqGJp3/SErnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523473684; bh=DUvA5Cqbc5FGJTu+WS4xAIDzDLi9gE
    PxAYNE6jSFzPA=; b=tJgyNg+/Gc1gAiNvzNz7ZzwHgso+pqyg2VQ0qd36sJC3tj
    LiVRrKw5bSOinZ84BsXEtqpjTb1BRnpc+XbAZUfpa2sVRxF3AY4Kk5JVQ6Zm+BIu
    ymLjA/vJYbFUJ/1CVsh2jZOiqCiUI3NIiqC7CYbxk0EGMHfzlgH+TihF6JqmII2S
    SZNSAAAiW8sCgTNLrc0SZpxHahs7hGl5EtyX8fbQqDFINS9+CYzq+q+TzydJ463y
    In1w7lMbt78A0tF3lxTqSdpe6psP0ckBTa+2BD3pETW+8AhWAvS5K8zJTVCoyn1U
    0bsNmLzkVaiaIVWRBTQa3s4tr5ePKr1i8WpxrjmA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGIcPV0/NyYTzNxZz3+ga9/APxdDMEGavjDTCNLZeUTbbimCuMcvRWPKP9K7GKrHIxSbrfGalBBNjpjIzgBvMw4b581IDNgRfGHtyLtqz6FC+3uuxpro
    GQOYCwNDn94KQdUW+NNS3v0R1wCscs32BM9FrB8keG9tAB4BY63iXUaUZwVwXjJl29zIkrD/yN6yZMCxgm1vgSI694LWMbJBZUDsezzdTNvtYqxI7iWGEpgh
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=raxXJfwxAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=jtc6C1e2MCDBex_EML8A:9 a=QEXdDO2ut3YA:10 a=JSjy4Y8GK2L6deCeXoNw:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935406AbeDKTHu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 15:07:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41040 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935371AbeDKTHJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 15:07:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 292/310] bonding: process the err returned by dev_set_allmulti properly in bond_enslave
Date: Wed, 11 Apr 2018 20:37:11 +0200
Message-Id: <20180411183635.158546786@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 9f5a90c107741b864398f4ac0014711a8c1d8474 ]

When dev_set_promiscuity(1) succeeds but dev_set_allmulti(1) fails,
dev_set_promiscuity(-1) should be done before going to the err path.
Otherwise, dev->promiscuity will leak.

Fixes: 7e1a1ac1fbaa ("bonding: Check return of dev_set_promiscuity/allmulti")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1700,8 +1700,11 @@ int bond_enslave(struct net_device *bond
 		/* set allmulti level to new slave */
 		if (bond_dev->flags & IFF_ALLMULTI) {
 			res = dev_set_allmulti(slave_dev, 1);
-			if (res)
+			if (res) {
+				if (bond_dev->flags & IFF_PROMISC)
+					dev_set_promiscuity(slave_dev, -1);
 				goto err_sysfs_del;
+			}
 		}
 
 		netif_addr_lock_bh(bond_dev);
