Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477230-2-1680542267883828839
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
    1523477230; b=dOvsGHoC5ue5JwwgARTLrRDTy3I20nwe/x4eK0IvRXSG8udVJj
    5JgrDaZrqeexVXrVJon6DGSPgiEudfCu04spfphbkhVYoEDgaGgfVVIVh9C+I2U9
    2Dnh4nT6VMrs4BIYCM3VzX/iJ2RZf2ya0QjPKJvjfQRP/NhoVC/Fj4/avEVxkxuO
    0Zcxd3jNNlAyvjvYN6N5XC/xmx5RTTvFtmVCTxrHfQkDBD19/y8TWTIZD0ld7yML
    KkJ3Ke7lpOEPyIjTpxOIvcbUJnT5YrdHxNNptZULRTSwSq04CxlwR+V9w+JKYCAY
    GHoKoBRdDMw6UTozR4CcadtHM4irwXZ+ujog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477230; bh=2ZU2lzQ9IvDZ5gc2ckoeIejqimOxWs
    Ab0z+urICEjLw=; b=dZl/cccSNQGUBAyh207T6utRS1LgRn71edq3P/F0o+C/yT
    QyXRWK5moUo48bJrQXulC5QlB2HLEO+foWPWWuC0AUWOMVbN7s1Mob6WZL7NLKl6
    vPJnaaQX4G3qvHafK+krXC1BO4xxLIfZ9+Ysn+QCr4/FwvfY7W/cz/ZLsB4i6GY2
    VbRlm7CLHKJoQQKvTxjkLz3JWJRa94J4Vc5NI9dGoIow7TL7WFtK8cICEs6gPQ08
    YVwU7yWVZGnsWX/A2cDwTz99tI6/KD/uZQrSGA3lte+ExtEfbVIpBXyz5/7hxazV
    Mk8CfMIdJZe5yZ53CcuhEl02Gv29fZSr7rZiJA+A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfLyCYGK6u3GyoEHYnGrvHdQ7Q9fBF2JXwamB4cIpCSGLFEOKPzyHYYo4xF2JIn6h+BQIDVU1PA8B8WH31inGU9sLfKfKFFgIW79ZrMXi+Mz166KX05Bz
    gLPSXfsaehp0PXUvzZuO8CKGknZcVN1HEKqJFKLXuflplrrBN54XlsxmxZGT9TEWwj/A+tAeE/njs6nXjGp+lb6flIgYbebD7c3vCFkHgfy/5Oguv/++kll0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Q-fNiiVtAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=Im1EZP1btvfpb2RkRrIA:9 a=QEXdDO2ut3YA:10 a=Fp8MccfUoT0GBdDC_Lng:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933655AbeDKSzJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:55:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34886 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933614AbeDKSzG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:55:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Mason <jon.mason@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 032/310] mdio: mux: Correct mdio_mux_init error path issues
Date: Wed, 11 Apr 2018 20:32:51 +0200
Message-Id: <20180411183623.663974819@linuxfoundation.org>
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

From: Jon Mason <jon.mason@broadcom.com>


[ Upstream commit b60161668199ac62011c024adc9e66713b9554e7 ]

There is a potential unnecessary refcount decrement on error path of
put_device(&pb->mii_bus->dev), as it is possible to avoid the
of_mdio_find_bus() call if mux_bus is specified by the calling function.

The same put_device() is not called in the error path if the
devm_kzalloc of pb fails.  This caused the variable used in the
put_device() to be changed, as the pb pointer was obviously not set up.

There is an unnecessary of_node_get() on child_bus_node if the
of_mdiobus_register() is successful, as the
for_each_available_child_of_node() automatically increments this.
Thus the refcount on this node will always be +1 more than it should be.

There is no of_node_put() on child_bus_node if the of_mdiobus_register()
call fails.

Finally, it is lacking devm_kfree() of pb in the error path.  While this
might not be technically necessary, it was present in other parts of the
function.  So, I am adding it where necessary to make it uniform.

Signed-off-by: Jon Mason <jon.mason@broadcom.com>
Fixes: f20e6657a875 ("mdio: mux: Enhanced MDIO mux framework for integrated multiplexers")
Fixes: 0ca2997d1452 ("netdev/of/phy: Add MDIO bus multiplexer support.")
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-mux.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -122,10 +122,9 @@ int mdio_mux_init(struct device *dev,
 	pb = devm_kzalloc(dev, sizeof(*pb), GFP_KERNEL);
 	if (pb == NULL) {
 		ret_val = -ENOMEM;
-		goto err_parent_bus;
+		goto err_pb_kz;
 	}
 
-
 	pb->switch_data = data;
 	pb->switch_fn = switch_fn;
 	pb->current_child = -1;
@@ -154,6 +153,7 @@ int mdio_mux_init(struct device *dev,
 		cb->mii_bus = mdiobus_alloc();
 		if (!cb->mii_bus) {
 			ret_val = -ENOMEM;
+			devm_kfree(dev, cb);
 			of_node_put(child_bus_node);
 			break;
 		}
@@ -169,8 +169,8 @@ int mdio_mux_init(struct device *dev,
 		if (r) {
 			mdiobus_free(cb->mii_bus);
 			devm_kfree(dev, cb);
+			of_node_put(child_bus_node);
 		} else {
-			of_node_get(child_bus_node);
 			cb->next = pb->children;
 			pb->children = cb;
 		}
@@ -181,9 +181,11 @@ int mdio_mux_init(struct device *dev,
 		return 0;
 	}
 
+	devm_kfree(dev, pb);
+err_pb_kz:
 	/* balance the reference of_mdio_find_bus() took */
-	put_device(&pb->mii_bus->dev);
-
+	if (!mux_bus)
+		put_device(&parent_bus->dev);
 err_parent_bus:
 	of_node_put(parent_bus_node);
 	return ret_val;
