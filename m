Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155541-2-8923945611018259527
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155541; b=PBG+HhktxTmibBjiNDC9i0vIRIZnFmApbPNDYR3S3uwXT2b55x
    UK63lM+EPgLq6l42FsI5XiJq7szS0N/S1mF5u2yS0O1mZAmrzIjF4Kfv3+jQI60z
    f2hDvTp7dI113UsIape6ZBKplSun00cOuZ8yO0b4/PLHTY3HBMmdA+Gp+rGAlBG7
    fSa1vynW06vKaiAzLP+3BL/oCtU/xcahuYIZbTtjNIM56Eb8j0YRl2RQ/rs86JQh
    OOQ04Jgh51hTgRAAHk+xVwlzGLrw5XibshT5iQhXzTeohLrNJ9AfQ3vfP7ZbGOPJ
    ikxF88pM5HKTA7wdJbA0KFEMqZ7cxRVtywKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155541; bh=uAZ3It/JZ76SgZ+0T4D4AeM6VfC7Wp
    rYp6BPc2lE2PM=; b=YX/Td5+L+Ot8PHNmzLUDV56f6Gw2O9pHMWM7fgAopvZo4i
    RvwgyPpVsxgRUolSMec1XaImd9Zeejlp9YDQ/sfQY5eTefGgiU8Su381FDGPkAIr
    tqxT73vSNYgYSwxgF09qow2Nr7WPgXoeGKniKX12sBBlr+mgys5/LMSAnKjM/LcM
    /7rEjh7AA93ABrntLatojmY5GOvj1+YfM3w2SBGVUEVPDft3dUkbw0msMA8fFYYV
    klMUmKyKOkQUfO9JSoE7Z3g/+dQPD/PvVB+SKikuz6FMWnfQqmTYvd+bPa5wgT5p
    EBazOugvdbElex1BePKk32iMfY68Iypjq6gKashA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=BeFAYHqR x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=BeFAYHqR x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGeC7REw9AKJNscUDlW2Xy1xiBuHb31dD+QeHNpyk0KkiWYOmOruIy2EZ9+32gMgiqwxbvitQTEUcYDxLylkRFJeiOmLOci83FDHsPHR7APX4GLE73tp
    Awo0Mu+LMP9VXd6cZTW1cMI6Nw42JTycjnkDMB8z+MyU1xB7asTqlzD5vL68PPhMvGGnXE/uqAQWLQu8rGnmdGRqDSxIhiJOKIaqO1t+aRjTFUj5UKgYbzPw
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=jZVsG21pAAAA:8 a=yMhMjlubAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=BHDm2y16XEEd-IqkzioA:9 a=QEXdDO2ut3YA:10 a=3Sh2lD0sZASs_lUdrUhf:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967834AbeEXJwR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:50374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967380AbeEXJwL (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:52:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 022/165] hv_netvsc: only wake transmit queue if link is up
Date: Thu, 24 May 2018 11:37:08 +0200
Message-Id: <20180524093622.877633496@linuxfoundation.org>
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

[ Commit f4950e4586dfc957e0a28226eeb992ddc049b5a2 upstream. ]

Don't wake transmit queues if link is not up yet.

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/netvsc_drv.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -88,12 +88,11 @@ static int netvsc_open(struct net_device
 		return ret;
 	}
 
-	netif_tx_wake_all_queues(net);
-
 	rdev = nvdev->extension;
-
-	if (!rdev->link_state)
+	if (!rdev->link_state) {
 		netif_carrier_on(net);
+		netif_tx_wake_all_queues(net);
+	}
 
 	if (vf_netdev) {
 		/* Setting synthetic device up transparently sets
