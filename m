Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713595-1523400059-2-1459189489896074986
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523400058; b=li2NzgZYOfyAzgU6CWw8vUQyujO9k+MncInMhmQNv6FgWzAiO+
    gN0DajuIJuwKY1O7D4KOP8/OCDdLQEtLInmu8iWbUjaDNqdU/T4B4U6vOxNwKv6O
    OPM9kZvP7Mnh6CrcYxaVYjh1GtagYAqHsCBbCgG/A9WCm3Rsy311YrzobaNJCRih
    L16bCKwGfCW6KaKi9ypwZg18Xfq5w1Y7bzeuZzSQKh9O/7BoGPYqeBS7eN6WTf2u
    jMt9BTpnr0BVw6DKDAtiYKms4gYawmR0eGqW3Wfb61t7v2jDuPRuCH/ZVxoBA9OF
    kxREFcee4rt+sq1zQZaAU+66mzNFxpXT/W6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523400058; bh=EWaEHRRn+5Cq+iw+hFf/jyTBN1nmuU
    Pm40mcdtVXlRg=; b=sdlaUqBl1dmd+Nef7D+sPYIIWirMTsTGzzhbMHv1iT7WNM
    xdtphsm6hIv1T67OJ6wCCFn0prKnKOn1dj/LTYpDa7gEiXdj7UzLASgglycGLSyk
    WhLJsJ2WKibpb3X0TCPQ9SZHlZbz36GKziqZvh2zHrh80WorLu3h4JvyeDklsLGS
    nbFmSGyDUhQZFEFvkLAHGCEpL+cofYOa2GkmQEirdk9TCL8+fbAb12grN0cHnviR
    2yBPnbOVeMdl06NKdB2SMLREmHfSNpg9dhER24aAyau33zJJhl9zqeltcH4GibBK
    OTrHhChqcYq/6x7PZBT6rIjxcPtejdFqTgvn0JrA==
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
X-CM-Envelope: MS4wfKAFKWudfJ1sBO36vtFp34t4cSiRaqAKL6Yq3ri6gyiOyXg1CfR89C4+5uxhTRltW7wLMlQtRrPqn+4s7y3ee1AU5iz5eNXf8+HEtvDq66wFFQPswMbA
    7CtNAXCgiqY4mjkxVsaoGVW3nN9VWfUN4B1FaaLB0QAPYfQFhlsZS2Fstn4CW76h72xxqOGj67MfeOfmziOSGS3JgXdjNBL1Inveigkxe5yHYYSSJzMAD/IT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8
    a=z1OcxMHCoMN4Ka_fV58A:9 a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932768AbeDJWk1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:40:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932736AbeDJWk0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:40:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 136/138] team: move dev_mc_sync after master_upper_dev_link in team_port_add
Date: Wed, 11 Apr 2018 00:25:26 +0200
Message-Id: <20180410212918.078087566@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit 982cf3b3999d39a2eaca0a65542df33c19b5d814 ]

The same fix as in 'bonding: move dev_mc_sync after master_upper_dev_link
in bond_enslave' is needed for team driver.

The panic can be reproduced easily:

  ip link add team1 type team
  ip link set team1 up
  ip link add link team1 vlan1 type vlan id 80
  ip link set vlan1 master team1

Fixes: cb41c997d444 ("team: team should sync the port's uc/mc addrs when add a port")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1197,11 +1197,6 @@ static int team_port_add(struct team *te
 		goto err_dev_open;
 	}
 
-	netif_addr_lock_bh(dev);
-	dev_uc_sync_multiple(port_dev, dev);
-	dev_mc_sync_multiple(port_dev, dev);
-	netif_addr_unlock_bh(dev);
-
 	err = vlan_vids_add_by_dev(port_dev, dev);
 	if (err) {
 		netdev_err(dev, "Failed to add vlan ids to device %s\n",
@@ -1241,6 +1236,11 @@ static int team_port_add(struct team *te
 		goto err_option_port_add;
 	}
 
+	netif_addr_lock_bh(dev);
+	dev_uc_sync_multiple(port_dev, dev);
+	dev_mc_sync_multiple(port_dev, dev);
+	netif_addr_unlock_bh(dev);
+
 	port->index = -1;
 	list_add_tail_rcu(&port->list, &team->port_list);
 	team_port_enable(team, port);
@@ -1265,8 +1265,6 @@ err_enable_netpoll:
 	vlan_vids_del_by_dev(port_dev, dev);
 
 err_vids_add:
-	dev_uc_unsync(port_dev, dev);
-	dev_mc_unsync(port_dev, dev);
 	dev_close(port_dev);
 
 err_dev_open:
