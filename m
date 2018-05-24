Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527160939-2-11937942696611336939
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
    1527160937; b=NYYUZch9Yr6HYkrqiWdbXQMN9A0HKkWSmp9Pra3DRl4ZxjPdGJ
    dvLSYr1ab3vR5TAfb0xBm9ZfTZXDluuHUY8hcx02vCO8FP7mFBRGXo37Kzo+cBb3
    GvQGXl5JuKuMcA7m1RkFTKhzPKaVxTTT/MMfmV+tMUQkpzxTc8btvv1wT4w8HIgA
    kB/Jx56leT7I2ivijY5JYzqE987bVZSyZDInATlVx+5gseFmB1T+O8nt6iN3aefM
    G+xLGwWaAwDvV2m+2W3jEDiJ2LvstQucZCaRWgnrx5ooLU9YzSbVMzFioIxdFXZD
    YMHYUmioymO/s0ocmI6cSg90Yp4Ot/LH6vQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527160937; bh=7C4dklgNdCAxz6t6yOHkz3tFzb9lmA
    deuXS0kODjLug=; b=dJj+DUgE/XuiN4v2CX5UZeOvGvYNPBfIVNKf0qNXHT3nwR
    LJpL3ARWLU68+D6ChnlV4zZ6vbLRmbAmnSYQdSg7krr/8DchfKHXAXyAmVyipVAp
    FdawlRE5Zct8iCrId8MYpAu9Gpf2m9UWBnFv592jBZCT8Ahdh1kNwoyANdzhouv0
    mGKwY5B+kfYkCihyICToJfAawE6GPgN+rlRdd/x0b6J3/SeftABydN3wFS01UelX
    TNf6G5mFioRDjyd++HPD+RG1tcTUVfFWoFlYVTd0WGmFf58scbYO9JXeiyzmNDlB
    U01Qj+QRZ3sTVl0YtVUQd+Q8UtLU/oI/3jd7IKkg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=pBV1hEIA x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=pBV1hEIA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPZB8E8jDRZwOKDuw63vR3FOFVD9jaAkluJZ5W9uH1NyHaAzmpP8i9dkq35HUrGq59jHVC5HZ3vQZdngb7L8DIy9E931on+ACiKQn7/OfHZmPg3NtmCG
    b7KGrTGuOuw46CUPrfWFiwAXaVxCxgb5TldJWem8hA3+y6Fr1VRhpgnDQCpT795vvoEjgHaTitNuCbIeha18M/6e53igeNopmxKrLt1FcMlnpFTxOUuaz9uP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=IoLR7627HhPfafYgmrEA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968798AbeEXLWI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967845AbeEXJwV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 026/165] hv_netvsc: defer queue selection to VF
Date: Thu, 24 May 2018 11:37:12 +0200
Message-Id: <20180524093623.038208030@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Commit b3bf5666a51068ad5ddd89a76ed877101ef3bc16 upstream. ]

When VF is used for accelerated networking it will likely have
more queues (and different policy) than the synthetic NIC.
This patch defers the queue policy to the VF so that all the
queues can be used. This impacts workloads like local generate UDP.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -283,8 +283,19 @@ static u16 netvsc_select_queue(struct ne
 	rcu_read_lock();
 	vf_netdev = rcu_dereference(ndc->vf_netdev);
 	if (vf_netdev) {
-		txq = skb_rx_queue_recorded(skb) ? skb_get_rx_queue(skb) : 0;
-		qdisc_skb_cb(skb)->slave_dev_queue_mapping = skb->queue_mapping;
+		const struct net_device_ops *vf_ops = vf_netdev->netdev_ops;
+
+		if (vf_ops->ndo_select_queue)
+			txq = vf_ops->ndo_select_queue(vf_netdev, skb,
+						       accel_priv, fallback);
+		else
+			txq = fallback(vf_netdev, skb);
+
+		/* Record the queue selected by VF so that it can be
+		 * used for common case where VF has more queues than
+		 * the synthetic device.
+		 */
+		qdisc_skb_cb(skb)->slave_dev_queue_mapping = txq;
 	} else {
 		txq = netvsc_pick_tx(ndev, skb);
 	}
