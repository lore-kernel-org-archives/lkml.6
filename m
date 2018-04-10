Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-843308-1523402324-2-7507256164964849493
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
    1523402324; b=qi2laiY3mmHyyoipL4p2nCJ0WV+dJlIGOJhIvWgj7oQcVRDQZ5
    P1TxcBqejMz/1u/YsmMvvU8ezInLz/MR+Co/jZPeLt7/c5PmDhyjk7awivpJKpWR
    SaKSguVZV5iJwuP8ABOFLLm4rjfx/tmrHkKx1Pl9qvNZJESVOmyCl3dQh74Nkm86
    2zGZjCzdAcCYIprJU1dMazBWNkiIuN6smCZRcMteE48+us2vHaNzHakXiRnlfhsx
    rfxwuv3dafvxvzoqdDCis5d3VQlrkFINfRo+k6tlEaJe4Wzh5F0WyJBlWbgTGGVh
    uEHmHMIumtsGJQxskJDaRct7CwRUMiw82o4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523402324; bh=RhZZBkBqatZq0e22shFVaToDECPbFl
    UTcpcUxDYoIHA=; b=M3WdTParc1Fv/6AreJc0xJgJrta7XwAinIcku30HJ8xpdZ
    B/uJS3+5SCeZYDdIy0FL7MsPOuAjtQOJqKF0T8CASQ2c4loV/WeqoqZsEurA2dAk
    UUcjyrQw4r8sRzCuXohRt0zvdQvsS1LIHPkajZ31C3MEuDm3mnIZzjyZGy9ea341
    8lCkRvhfIWlkwjQtMNjXmV9qVgZT+rWkERLLMpjfv6U2xyrLGgs9OcYX6/SfCJey
    NpRTsbMVIEaynhgYcuEv8LV6TU1x0nuaMQH7o+5fuV0DdGPxIqnE9+7HmnfXPXU7
    ZjRvvwSCj+3DF08e+DddjihxR6Cel3VPcfqCcpvQ==
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
X-CM-Envelope: MS4wfAjPp6f4wcNPBV61UrqoZj/iV4MeqUd44JCoKteFBHV8S+K2esqjJ8mVVqxyDmXH2jNBuWBKoPB9Y0gy+l1bwpEcnc++6WhAOLNMeHklWu+OcTWUz246
    jivfHA1YcM/Jb+FfCZeghfn7AnTqdnvrzV2gX+n0k3jAKmpmZMEsS7VbK9br/O11Dzw9q9ENORudLwRk9q3MTJBFGd12xEnVq0pI7yuBk2GF5ET/oMt9vCwc
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=h6DYfe-N_5DcBJBIuqkA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeDJXS3 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 19:18:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40354 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbeDJWbX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:31:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <cphealy@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.15 124/168] net: dsa: Discard frames from unused ports
Date: Wed, 11 Apr 2018 00:24:26 +0200
Message-Id: <20180410212805.848782700@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>


[ Upstream commit fc5f33768cca7144f8d793205b229d46740d183b ]

The Marvell switches under some conditions will pass a frame to the
host with the port being the CPU port. Such frames are invalid, and
should be dropped. Not dropping them can result in a crash when
incrementing the receive statistics for an invalid port.

Reported-by: Chris Healy <cphealy@gmail.com>
Fixes: 91da11f870f0 ("net: Distributed Switch Architecture protocol support")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/dsa/dsa_priv.h |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -117,6 +117,7 @@ static inline struct net_device *dsa_mas
 	struct dsa_port *cpu_dp = dev->dsa_ptr;
 	struct dsa_switch_tree *dst = cpu_dp->dst;
 	struct dsa_switch *ds;
+	struct dsa_port *slave_port;
 
 	if (device < 0 || device >= DSA_MAX_SWITCHES)
 		return NULL;
@@ -128,7 +129,12 @@ static inline struct net_device *dsa_mas
 	if (port < 0 || port >= ds->num_ports)
 		return NULL;
 
-	return ds->ports[port].slave;
+	slave_port = &ds->ports[port];
+
+	if (unlikely(slave_port->type != DSA_PORT_TYPE_USER))
+		return NULL;
+
+	return slave_port->slave;
 }
 
 /* port.c */
