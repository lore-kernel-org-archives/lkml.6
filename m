Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1758260-1527158327-2-4566036198003062703
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
    1527158326; b=cZ2/MiM3AapO+bL5eQb+tSRKQ7455sKcuVrw8IBLjLksaNvfKe
    nuCbkn5Y70yXbUahUXpfJrlubjE6Zr4JRk2b9djpiHLss2KsTVuwZVLAw1hCirCy
    lEVKhdGN4o0+QJmSUoFbJLIDOMr50HST20QftccFeL5KGKPqi6ygLBCvFrk4wM8d
    Je5yenaiTfeOSssHspDO4L4o7SCEJdB7Z+Vwlr9uvwDt5w40B5OvUQpuRkLkiPp/
    XztBtkGq6s4fqmXO3pS4SzVG0b50D1yJ77BAxKWA5ihxK2RMp7Ey94o+0ko1zyVP
    OdL4MPIfh5w+3h1bIYT/pBJ68sDjmg5O5gag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158326; bh=u2LBa2T9uIuVBuDUvYGOFgknZdzUAv
    JIi8hXzpebKTQ=; b=HOIn9aLkgZDtQHOr1AAaycouTcQz3sr15QBIvDFTaAkGqP
    5wg+jWPvEUEY/G8yHhHvYHio0DVCyOIqo1/WX4swOIl2nVHxSBxw6l1cev31GRf0
    5VJknAaDGl2CPVX3Ymo25S15fS4la72JIofIuRdjhQ5yvZgtQTFEIZxu50Ojbwkf
    jpmwPJxbzYxAXWt+2NOKN4TgXd7YX28g6CwL4DxgAF14PKn4ixJ3+EOaI/pdaoFe
    8OBfCj639qCNncwMXExHjAJs/MPT4+/y2UMaxKTQPSO/vcD8bkT77rI/m3i6+plN
    Po/HmXDIC2byN/3LKSlz5Iog2aLKm7UJP+bEtOwA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=KOmX1NJt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=KOmX1NJt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOdx8mel3azl5ENooEiKX5S+x57CbjbpedhMuXNBPpg4V0bLyHlyN1Q65QDdbrFxNPDqo5t5pIVMOkjlPFlKuDYgC9zCstbzw2+vHVBp4CpzYde9wBLU
    8/CFvsBXlyUe9UEwyMiHhDAK+1SosRC/57w2EPMHzFaP3stMWstVB5t3MUv8BnP/nO1mAj/Txs3nb/J2NOfzNw9fdjSB21YX9YLZO/zdQqBrCe9fBNqY+7U3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=A7560Iu196FLDtzmalAA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030770AbeEXJ7c (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:59:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:40432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030519AbeEXJ73 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 017/161] net: dsa: bcm_sf2: Fix IPv6 rule half deletion
Date: Thu, 24 May 2018 11:37:22 +0200
Message-Id: <20180524093020.418598043@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 1942adf64214df370350aa46954ba27654456f68 ]

It was possible to delete only one half of an IPv6, which would leave
the second half still programmed and possibly in use. Instead of
checking for the unused bitmap, we need to check the unique bitmap, and
refuse any deletion that does not match that criteria. We also need to
move that check from bcm_sf2_cfp_rule_del_one() into its caller:
bcm_sf2_cfp_rule_del() otherwise we would not be able to delete second
halves anymore that would not pass the first test.

Fixes: ba0696c22e7c ("net: dsa: bcm_sf2: Add support for IPv6 CFP rules")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/bcm_sf2_cfp.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -790,10 +790,6 @@ static int bcm_sf2_cfp_rule_del_one(stru
 	int ret;
 	u32 reg;
 
-	/* Refuse deletion of unused rules, and the default reserved rule */
-	if (!test_bit(loc, priv->cfp.used) || loc == 0)
-		return -EINVAL;
-
 	/* Indicate which rule we want to read */
 	bcm_sf2_cfp_rule_addr_set(priv, loc);
 
@@ -831,6 +827,13 @@ static int bcm_sf2_cfp_rule_del(struct b
 	u32 next_loc = 0;
 	int ret;
 
+	/* Refuse deleting unused rules, and those that are not unique since
+	 * that could leave IPv6 rules with one of the chained rule in the
+	 * table.
+	 */
+	if (!test_bit(loc, priv->cfp.unique) || loc == 0)
+		return -EINVAL;
+
 	ret = bcm_sf2_cfp_rule_del_one(priv, port, loc, &next_loc);
 	if (ret)
 		return ret;
