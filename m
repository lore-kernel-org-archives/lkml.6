Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3253174-1523477344-2-17270172544684637752
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
    1523477344; b=fohQe/3IbKi1jkxquhgCGiv2bU3CAKk0gLj+BV00aMwPAGjdTQ
    ZwXwOdtZ8/2UgUV3v/HolgHKTXQtFCtICgypMBQf615fhaUfmujb/XSgEwJSJvDH
    AASBhG3eb2kLj6TONKxycPZYF9zd5Vp7Bqn7J0t2BW001O2MjEqjgDyO+5vJV7Gq
    i59zT8Yz21G5etE8g++bM5RlrZmcJCTYqGaMbIlohDc+m+Nm6iLhC9dt3MDZcfaW
    CRYApmUSBSO4WEpUXp+jgMuex2zg8CQ0pwSNjIPFDHLb61IVe2DhRa5wJwRUzLZ6
    IVAObGN/NWlLUIvS+MCfjU3M7OtW5VSAlbDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477344; bh=3vtKa3oKw8PmjkK4RX+Aya0u4FcEfM
    FEMVzOjSzfPhg=; b=aJbHqu6kHl51NbOYuk4d6k72gx4lPFvU6rOSLNQccfskC9
    Z2Y1EM7qTof8PIdz75e9BKMp8ozH5IUPoF7ZVCSP1CreMHJygC0ukeslr63jVkxL
    bwV7HT2XkG2srhYZuWC3gnTPXMGCW47Nnum5SP+6JqUL4DM+QetYJVGqd2fA0UNJ
    5QqhlKNk3By/6BFV9lWy6m/X60O8oe4EFPoVGO+9ZSL7+yZh+QeuKZr8teMfrbvA
    Q9LTnJRPMLq8up5B/XJzsvXuvZrUuN8R4LuGYYJc5GLVRHGnI0UCjCh8zssw1aHD
    ryN6auOpFb4DyEZiosmwHGF7wVj3DzpeW6QmA4cw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOOymss9a6VuKaYJFfFJ8Cd8ZCfwPThFPZ/RRsiPMAhiqoIBAfFnugJdPUo3nKCExkvsTiuf00N3IFpTvPM0YvtRdQHlafa1xv0Vy1Py2wk4RvXCCdeu
    /WrbSyoCquZoHEkdMgWrYiyLdIpOoNLUduF4/YzQOldPMDW3L+k18t60OEnZwBLRi3/LhTLGhkvvHAj+xVyajQl+Enau5Pr84mlQN5kguP5Oru5/1W86bMXI
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Q-fNiiVtAAAA:8 a=QyXUC8HyAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=cJdU9Gb96vkOB649Cj8A:9 a=QEXdDO2ut3YA:10
    a=Fp8MccfUoT0GBdDC_Lng:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756391AbeDKUIu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:08:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34688 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932754AbeDKSyr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jon Mason <jon.mason@broadcom.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 052/310] mdio: mux: fix device_node_continue.cocci warnings
Date: Wed, 11 Apr 2018 20:33:11 +0200
Message-Id: <20180411183624.486848927@linuxfoundation.org>
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

From: Julia Lawall <julia.lawall@lip6.fr>


[ Upstream commit 8c977f5a856a7276450ddf3a7b57b4a8815b63f9 ]

Device node iterators put the previous value of the index variable, so an
explicit put causes a double put.

In particular, of_mdiobus_register can fail before doing anything
interesting, so one could view it as a no-op from the reference count
point of view.

Generated by: scripts/coccinelle/iterators/device_node_continue.cocci

CC: Jon Mason <jon.mason@broadcom.com>
Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/mdio-mux.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/net/phy/mdio-mux.c
+++ b/drivers/net/phy/mdio-mux.c
@@ -169,7 +169,6 @@ int mdio_mux_init(struct device *dev,
 		if (r) {
 			mdiobus_free(cb->mii_bus);
 			devm_kfree(dev, cb);
-			of_node_put(child_bus_node);
 		} else {
 			cb->next = pb->children;
 			pb->children = cb;
