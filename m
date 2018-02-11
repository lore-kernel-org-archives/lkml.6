Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518323838-2-16240850944429251959
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
    t=1518323837; b=rUj4CsB1LnDk1lc5I/s5DMklzuJk15wcwNepFchNRtYPBZP
    qB/sni5v7Heigf7t+tvLf2ofcMQIa81KNPznNVqoCpF2XcbxQUXVCd0pArUU6KLN
    gxxuC4b7VhakvvMFIsGniWfOJJgp3nlkafOyu7Fk61GJe3wXXeAbwSa20eNpxiOw
    1+VokUscG0eNhZQNbzSXu1EAQ/TJHwQ5hNb5umJGAFjlZCwCB8NW12g4Nb4YZMSy
    6L0buJtdj+WK8Q14Ofz5glFc0aCpkiGGRgFeC3sbl+BEBcXUuZZ/hkzcuD5SklhI
    5V46gVf7EmR1dVb4vsBegaTxO0L3sgNdNIiAuFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323837; bh=k8TfdvWce4WPg0l51nQ
    88MU9s/wwihxvmAfn2CDFbBI=; b=dV/d6HTi7/2Kz2CZXLq0f9Qgg2lI8aro3dj
    1uDDShgkNuV55jYKGdl1vPQhFW8apVZStfcuAezfhwIF+dqyDDT9wKvyO1iBxzyO
    RHwdJdFtum29yqUDNAJNsD2yy+1PkR+9L0C32tgkXWoc5vdNrAyszd6Fp3HBeMn6
    yT2xrN9ZeRyYSdwciBzWBX/11nOZoKxG3cqEqHkjmSpplPY+gvDE1mh6ggfL2Ncz
    kz5cb56JbHE3ysntIMRSpjcvTIRay0gO5kpafhKkdS4BHE+k+l0DPmUSDt1gd9ca
    Hno5BYKUaSoZ8gCQ0VNq8HYBrm4WDaDNILE2p+Qt00qfwjG/vKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeBKEfD (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41747 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752998AbeBKEeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Nishanth Menon" <nm@ti.com>,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.834625968@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 079/136] clk: ti: dra7-atl-clock: Fix of_node
 reference counting
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

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit 660e1551939931657808d47838a3f443c0e83fd0 upstream.

of_find_node_by_name() will call of_node_put() on the node so we need to
get it first to avoid warnings.
The cfg_node needs to be put after we have finished processing the
properties.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clk/ti/clk-dra7-atl.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -262,6 +262,7 @@ static int of_dra7_atl_clk_probe(struct
 
 		/* Get configuration for the ATL instances */
 		snprintf(prop, sizeof(prop), "atl%u", i);
+		of_node_get(node);
 		cfg_node = of_find_node_by_name(node, prop);
 		if (cfg_node) {
 			ret = of_property_read_u32(cfg_node, "bws",
@@ -275,6 +276,7 @@ static int of_dra7_atl_clk_probe(struct
 				atl_write(cinfo, DRA7_ATL_AWSMUX_REG(i),
 					  cdesc->aws);
 			}
+			of_node_put(cfg_node);
 		}
 
 		cdesc->probed = true;
