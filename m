Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836635-2-6812010498273417856
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
    t=1519836634; b=lBi3iNoOk4qGnIT78WTgUWdBDCMoTequiNUw2V5vWKudu3L
    IVvaVEM3In5JGRpd4VdKBI/zW0VFYPX6yVHQgXYSGC0WjboM1j5gNk1JZ67KqJ4m
    Oc69xoVx3CwMkXUVrpxkKIA1G++BtsQmL7gqx96Cg6Ioigt/sXu7mkH79D3rJvTk
    TLjdZuylothS+eFIgLS9FAtIm+yRMAyyPJUVVBF/yMIDsO1noA7VMj11ZyruwDt/
    flCDVLBlaAh6VkYahlE0tbrzCn4ni8LM1CRaLo2OoaW5ufXp0GidYSUETUdFNNIh
    HCDdzn6UcyFBfsgU1wrEXtPNYD55j7SMzeqQebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836634; bh=zNVtqTBS0U8/LV9AZhC
    1zRfepaAGE7y4YMg2IoWIGKk=; b=mxxehcaB6WEU/wNjVlNyPrz7Oy/I3bHIWZu
    BPfzyeJsgugThysIDxs9OGTlinA8WA5qnIbJeXZ4M/kyC/ZzFRLLksCs4d5d0pPh
    xqffRd8vT1wLUdxeyszo+F5TPY39DAGKb6EQuuC7M0D1gIx54KZikvrvx0iCTtDR
    hSSw4YiAMGIM3diKUsDkt6IgH7sZijpH43yTr2f3s1IF/SlamAkic/D4oMR+pwsp
    U3rejxxa19/J6uD4U6wzx424IrqGrjX7bEDWHXCmK3IBHM+JZ01E8nQ9nflPgeaj
    YHA9NSpn8NXxCyB22wKBGncT1jiNn9Tf8fPMGhY1l60uxAXNJAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932709AbeB1QuW (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:50:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34564 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932747AbeB1P6e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:34 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Gregory CLEMENT" <gregory.clement@free-electrons.com>,
        "Dmitri Epshtein" <dima@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Yelena Krivosheev" <yelena@marvell.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.596158252@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 136/254] net: mvneta: clear interface link status on
 port disable
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Yelena Krivosheev <yelena@marvell.com>

commit 4423c18e466afdfb02a36ee8b9f901d144b3c607 upstream.

When port connect to PHY in polling mode (with poll interval 1 sec),
port and phy link status must be synchronize in order don't loss link
change event.

[gregory.clement@free-electrons.com: add fixes tag]
Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network unit")
Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
Tested-by: Dmitri Epshtein <dima@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -851,6 +851,10 @@ static void mvneta_port_disable(struct m
 	val &= ~MVNETA_GMAC0_PORT_ENABLE;
 	mvreg_write(pp, MVNETA_GMAC_CTRL_0, val);
 
+	pp->link = 0;
+	pp->duplex = -1;
+	pp->speed = 0;
+
 	udelay(200);
 }
 
