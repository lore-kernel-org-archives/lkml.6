Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324813-2-15361442336480358676
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324813; b=bDph8jLzRXSyT7uTuH0EvjDPVXzWlIswHAv+VAx83Tiw8aO
    8JeahUigHVFPaBlF1Kj67kC6du52MRMLq8dDWyhkWbx8sy4DrywausTyCeVZ29On
    uiuZxub9JreXXHk1ioW3EIT71LsfDJE7l9pqnzZNzfFzhKRAqYny3e/Foq31/edx
    t/FbLGOu5Zdas4elnh8LP1EHmGR6HlptY+MeXVHblzknCsFg3VR6h6kC81hoOOdg
    TYAiD21AfeicMV8i4XREusbIg6nF4tR8KBP5YAWFrjDmzGrgmlS3NJjDFk8/cjOV
    KNbxfhq8Bou3pAHSlpefiMA19nuW2JOxQE1BNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324813; bh=WIn1YKftudxJtRZa0a5
    UadJITcr4CgRbEjmXfvzBD7c=; b=nLcnwmRtn0aWoR2V40MKlJ8W+WALblE190u
    GxObaiO5pHet+ELUhuBt85BpH2teyRZzpBlQLC5mPyb5P0Hts7Yv3TOYSjAR4o6N
    zjRFOYLsAYyI3n+SciRC+/WhArJEcttIUj5/Wtp4q9afHQCIjSUsjPr0yWls698H
    ytcAZ/suy2TtBG3VLq0FEmheo4HDq0Z4418enlrzWkGTF9r4w66hdObJbwHdLMIn
    lzWBWnccu+/LUOFX97x0EUHifvbxnG0AsQYA8evi7Rz8WJuc82RAmU5mraGjCOp/
    cNTSNrtXG7+PIKVYS56LFYAEPSj5PRLx4OqSTzlScchIZoRSprg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbeBKEvm (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:51:42 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41750 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752815AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Andrew Bowers" <andrewx.bowers@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.363139638@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 113/136] i40evf: Use smp_rmb rather than
 read_barrier_depends
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Brian King <brking@linux.vnet.ibm.com>

commit f72271e2a0ae4277d53c4053f5eed8bb346ba38a upstream.

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with i40evf as well, as the code is
very similar. read_barrier_depends is not sufficient to ensure
loads following it are not speculatively loaded out of order
by the CPU, which can result in stale data being loaded, causing
potential system crashes.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_txrx.c
@@ -216,7 +216,7 @@ static bool i40e_clean_tx_irq(struct i40
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* we have caught up to head, no work left to do */
 		if (tx_head == tx_desc)
