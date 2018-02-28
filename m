Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519839289-2-11221543916082995341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839289; b=tO0xDhjXYNIFlivdC7iCU1DX2ZFXg0P8ErQvZYguBcyxr9c
    yFqXiF+Yw0CBt5eQkMalGX+SwcempnI8fU9tfqL63n02wfm9E7VknG6OJqw22DET
    qXqQHWZCefIv/rOgN2Ma2h5oKsSTGhkRppFZvJoH2dw56F0eJ7Flp4dm4Jws8Ktn
    YohJacyFpZsgmZr9evxj8FuUvUL79eJ+KSQQ/XLV7c+yTNd7VXCulV98BsGqIhGi
    NJodOwv7rP8kUmBtf/Uo0jrZ13q4xjs6q4c1a+rqIHWOtT5f/R2ZAB/okYC9elMw
    gjoDIsQPGhZ/L3xvXRSaGndEc0QZCqtp6eoQnvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839289; bh=/4yMhpewt4jgtZ+769c
    gZpDXrEaiJq6n3zADMNJJSEI=; b=mgaEi+asDo2ds3xCdhHZ/mbSIYIXOAIaY4T
    MnAznSdNKPVG1giOHrVZy6HsGt3EdgiK6gd69rZ70EuvAjz54dfIp8xuTtN316gm
    DLBfqsHbvp1ZhoCX9oeVwye/x4Ocb3G5v/KCSilpzQo9l7jZE0AJFvgSd13zSbCg
    pSUaNoYmTOalDUHEwEB27bpcRmQ5q/lEhWLPXDAb/ABsM9V1b/0/EYKx+z13p54f
    M4MyLCjRoPLBuFQYSc3H4dcdYUfKbCbpfLqraVSHZqiNwdKjeTpRLr24Wv568r3R
    +tuyuQQAOyzfq2EF1SwED36SGtdhO/uiQn3diRtLWlXtge5P5Bw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbeB1RbZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:31:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33227 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Cong Wang" <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "Vlad Yasevich" <vyasevich@gmail.com>,
        "Dmitry Vyukov" <dvyukov@google.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.261078070@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 095/140] 8021q: fix a memory leak for VLAN 0 device
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 78bbb15f2239bc8e663aa20bbe1987c91a0b75f6 upstream.

A vlan device with vid 0 is allow to creat by not able to be fully
cleaned up by unregister_vlan_dev() which checks for vlan_id!=0.

Also, VLAN 0 is probably not a valid number and it is kinda
"reserved" for HW accelerating devices, but it is probably too
late to reject it from creation even if makes sense. Instead,
just remove the check in unregister_vlan_dev().

Reported-by: Dmitry Vyukov <dvyukov@google.com>
Fixes: ad1afb003939 ("vlan_dev: VLAN 0 should be treated as "no vlan tag" (802.1p packet)")
Cc: Vlad Yasevich <vyasevich@gmail.com>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: The vlan driver didn't leak memory itself, but might
 cause underlying drivers to leak resources for VID 0.  Keep the check for
 hardware acceleration.]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/8021q/vlan.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -132,11 +132,7 @@ void unregister_vlan_dev(struct net_devi
 		call_rcu(&grp->rcu, vlan_rcu_free);
 	}
 
-	/* Take it out of our own structures, but be sure to interlock with
-	 * HW accelerating devices or SW vlan input packet processing if
-	 * VLAN is not 0 (leave it there for 802.1p).
-	 */
-	if (vlan_id && (real_dev->features & NETIF_F_HW_VLAN_FILTER))
+	if (real_dev->features & NETIF_F_HW_VLAN_FILTER)
 		ops->ndo_vlan_rx_kill_vid(real_dev, vlan_id);
 
 	/* Get rid of the vlan's reference to real_dev */
