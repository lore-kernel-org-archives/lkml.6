Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3746915-1520706306-2-6505437067161608599
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520706305; b=rrSxws9wsOHi9E0c7UCvXe56pwE8zb7k5901vfZHOWdUiNv
    5w3LCuz6/gMjHLPEQOawj5O6sAwMCQy/0DQ7PoWChq07rq9SXhNqrQnkjA0Yq+DA
    4OMSTa+KXmGj9xvL+v2iXNQnxT6HLO+q4HPl04FD8ZdUXjkYdTz1Fg8slycqgOP5
    CfrOFrcujVmowMWMvw8EQ3aUdfmsYnBE61BY8YsplWW5gfJhs7ZPRteO0tTxmwMK
    nNTZHgm/0vSnkLvD5lXDmg1cc88IxrvDAmZvwwZFpukOHpcwM90LZaA/zlofI9sQ
    derY7AraShKGhtalvLTNL7zWzOUI7ftvSSUnXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520706305; bh=nuH3vQrilnj/tIzp8REnH6o5lDeVerucNt84a7iS0IA=; b=V
    W6jU/VobIDLsdUUTO4/nqDvdIkbZNs5cl2oDi3n29Hjm2SmtBVVXwFjVVqWy8Rn2
    QqKDYelqHcMy2xpkG+kRyiKxI1Vm2hdGV6kD2m25IVeR5KhzsaEXxTmGl1xQ3aq5
    QTdpJN4fBN5Vj8djIVz6EdewOqDgjhixrT90Uyw2SO3u5J6Z+fGNAQqYNO88o3c9
    YsB6N3xN9J8CWPlvRdvYBw3ZLQV4KFbOM9NwwIyMBPEwWFQAyw3qhAhsDxVvWV2k
    cpMw+FHPqq1Jm3x7cyUUDZVu9+phmtr2h4OxZeGMynQ+HtJwCQdzeBv+Bk8Y95lE
    B+sS06X49UW376y56OSVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933073AbeCJSYq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 13:24:46 -0500
Received: from mout.web.de ([212.227.15.4]:50661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932918AbeCJSYn (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 10 Mar 2018 13:24:43 -0500
Subject: [PATCH 1/2] net/usb/ax88179_178a: Use common code in
 ax88179_chk_eee()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
Message-ID: <a7fff45f-4426-ec33-8b8d-caf1e3a9f0be@users.sourceforge.net>
Date: Sat, 10 Mar 2018 19:24:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ywsSyWmXrjl3PDmdPlC98eBHCSf+b+61ku9KfYFNTpO1maG7p4O
 fuJqfHjwP5GJphz3Ll51FNT5ApOPVho9Y0OuipRyOwbqpQh5V/POwwU9PTmxMEPOF7tb3BE
 IOhfHIupnedt7acHoNQ/CB/3xNco9gGuATiY729LIJqVWeQGn6UnvyhlQXLeQDqZJz8xk98
 p0TxseXrENh6hKr3m5d7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:8M7ZQdFj17A=:4GpDu5BGMRpO7Ln6qaUvxc
 RFKRuQ9Oqv8mfbJie88JUqmXfiYGNiCisia58WZXndUS3p5IkEf+w1CApnduFxnPyQJ1uMtU+
 Mfw8fUQyEOqsa9+dq5hYTGLUO2vhdevQF74UzIIx0YTMuQ4lJ44tyCQ58rIzws7F+j2vzab9t
 54gtiZLgYWsS6PP5MYRN5WRnpzd7eFxJyHlqNpZzrTabx7lxcs61dpDqag+jMSvqxA3Pl0wes
 eSOYDZ0HKuqWNCwIwTXnKMer3US+NCLaA/kFOVz0EbEjBggi5XeeNxEF+yD2UPzs9kiHutnzN
 urKQRHMnGvfeh9YEpaFvhSmXkKfbIkH0DQJhQsM0FbZ3Nepyl7bFJhmktlyCICLNj74dSpQ+V
 izrVx6G/gkBEd2qftgEDWxwV/PIGaZogQlIPus5D4EeKySNxM1dpjTC3pS8sZ7rnjP8tRx1xA
 aIhyxJnjviE3gDDVaDNXpkMX9y7cmzykMngBK2jnvcxlLfhgt8Z98apglQa3bXYtWS2jFD+Uz
 qqHz8NJIa0FseaeuMBVP6ap1XdAPFC/V4TfvQ8mjGa93l33cHEJyKUrYK2hymI9JMCDDjasj4
 YkouX58lDHU3WVfDe7/ArF/+FmDZdNMkM6j5Xi86h2Mv0yfU3G3aYFtbRb3I+3oDP0yEBD0Hb
 +j5QoFVMjMW4dj1FYf5Fsh4MWxIrif2bPn8rO7lp1+I3RlrEzMa1tmVbIPbr7e5LWrQRSTGu7
 mfdS/RerIoWLOcoMF+VQWPVPeW4eoNtSU2M26cVxOjzGcosOF4rrbBjP+oosMjKlY8RpT7uSJ
 mTDUR7GtIiUHbH7l2ViOf/lWz4/D73M5ajpPNgTNrXSI1k6mPI=
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 18:22:43 +0100

Adjust a jump target so that a bit of common code can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/usb/ax88179_178a.c | 34 +++++++++++-----------------------
 1 file changed, 11 insertions(+), 23 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index f32261ecd215..e4b0baa98e9a 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -689,49 +689,37 @@ static int ax88179_chk_eee(struct usbnet *dev)
 		eee_cap = ax88179_phy_read_mmd_indirect(dev,
 							MDIO_PCS_EEE_ABLE,
 							MDIO_MMD_PCS);
-		if (eee_cap < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (eee_cap < 0)
+			goto set_inactive;
 
 		cap = mmd_eee_cap_to_ethtool_sup_t(eee_cap);
-		if (!cap) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (!cap)
+			goto set_inactive;
 
 		eee_lp = ax88179_phy_read_mmd_indirect(dev,
 						       MDIO_AN_EEE_LPABLE,
 						       MDIO_MMD_AN);
-		if (eee_lp < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (eee_lp < 0)
+			goto set_inactive;
 
 		eee_adv = ax88179_phy_read_mmd_indirect(dev,
 							MDIO_AN_EEE_ADV,
 							MDIO_MMD_AN);
-
-		if (eee_adv < 0) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (eee_adv < 0)
+			goto set_inactive;
 
 		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
 		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
 		supported = (ecmd.speed == SPEED_1000) ?
 			     SUPPORTED_1000baseT_Full :
 			     SUPPORTED_100baseT_Full;
-
-		if (!(lp & adv & supported)) {
-			priv->eee_active = 0;
-			return false;
-		}
+		if (!(lp & adv & supported))
+			goto set_inactive;
 
 		priv->eee_active = 1;
 		return true;
 	}
-
+set_inactive:
 	priv->eee_active = 0;
 	return false;
 }
-- 
2.16.2

