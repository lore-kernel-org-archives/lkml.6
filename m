Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835923-2-505949135762265748
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
    t=1519835923; b=jtmO6RdwIMYv7vQ7CwzpsWv5sF2yvdgAqRtAAwiIhEUfwwf
    CyKPm0tXgySy2wpBcYUkzc8dCI3qufLIYM313TpaTTpGrFwE99MGC84XQx4gx386
    kWSPy0EtgGa3yPBvJdM1+B/2X0RA+UDMHNpsrtYFCmXSRvTYUhOtkbQpET7CsMl/
    rQLpmHywSWp6ptwwD8/H+VWLaiDei8znO3Gij/wLOAySBlL7DrKBmi5AtazJmBdo
    q2N7+biwkFfP6dzwU+i5q73vxhmWplrJfs0vCBHyHtpTLRu+HzreIa3MT44L25q4
    QD/oV3UfPIs73TA9ogZ+P6b8h37lEJKBBpDJvGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835923; bh=aJRXZX/NRkzInDXCMwj
    bDAPjZWcd15leYv/FUFXKVH0=; b=enlcl1nFq/GdaeHib/OiKKyZTmYKDraIoYs
    0wKbSxFwtI/EKTHx2P/A8glN7JzOmJt4nH6Izihi78TASsNWVenQO0GJR6ywi0za
    9XJ7bPlzvA4tOdDMznUSdL75x8Dsq7KySQYHtpvnaqIMeFcBqyur7W7i9eFVZH/w
    Eun+FLe4UnGpXKKgQ2W/G5dIEWn3No47FPI9+rM4chUL3XLqMx7iHNRLB5twAYrN
    urSy1Q+UYtw5UqSNe/dHekGmeATD0eNyvgVk/5q9Q+LxIBBjvP1rUWoqA+lANpC4
    iEtSiGqSybC9fHGFTr08IBHC+49ZrW4j6YFV6gBCxPaQmLbMYnA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753203AbeB1QER (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:04:17 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34810 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753190AbeB1QEP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:04:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.18705980@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 184/254] sh_eth: fix TXALCR1 offsets
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

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 50f3d740d376f664f6accc7e86c9afd8f1c7e1e4 upstream.

The  TXALCR1 offsets are incorrect in the register offset tables, most
probably due to copy&paste error.  Luckily, the driver never uses this
register. :-)

Fixes: 4a55530f38e4 ("net: sh_eth: modify the definitions of register")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/renesas/sh_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -142,7 +142,7 @@ static const u16 sh_eth_offset_gigabit[S
 	[FWNLCR0]	= 0x0090,
 	[FWALCR0]	= 0x0094,
 	[TXNLCR1]	= 0x00a0,
-	[TXALCR1]	= 0x00a0,
+	[TXALCR1]	= 0x00a4,
 	[RXNLCR1]	= 0x00a8,
 	[RXALCR1]	= 0x00ac,
 	[FWNLCR1]	= 0x00b0,
@@ -384,7 +384,7 @@ static const u16 sh_eth_offset_fast_sh3_
 	[FWNLCR0]	= 0x0090,
 	[FWALCR0]	= 0x0094,
 	[TXNLCR1]	= 0x00a0,
-	[TXALCR1]	= 0x00a0,
+	[TXALCR1]	= 0x00a4,
 	[RXNLCR1]	= 0x00a8,
 	[RXALCR1]	= 0x00ac,
 	[FWNLCR1]	= 0x00b0,
