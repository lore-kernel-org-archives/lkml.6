Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836047-2-18103095268268685807
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
    t=1519836046; b=Pj/QJgDaQ6+oWpqXQNnEFS7suv855mTyZ9sQ9vv0Vfalvpq
    oAf8sKq+OZ08A0zucsFIKj32xJnxr6rLKoH3hR5y0Rz1z3bcxqAzHeBncyVAfyLR
    q5xIZrwcbXMWk9SmV+sL96Kzmpr78oRqe1tT80tMVRwXk+hjoDvJ55qKfzXAiGf4
    to5bZPFDKlmD5rKBqL4efb64PrV7kwSrHeKDDug5x5bS6K8r0I7+sRiMJ2iHKP+g
    WHjX/lzQYvkjjGgjunbWU8bpjOAyjH42XV07YCs5eZNF9dvfpP6NBN4jXqGt+i0p
    WqEhzJ4LLowDgze7zkfmNEONTPQbNsSM6aNeRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836046; bh=CZgj9M1imSNdeUsZYya
    FxDLxs0ppgxvpuK429eq2WMM=; b=czcvaT11IvLRpCXF7GdhOd85hi5snN8GMq2
    Qcy+JwXbBCGb2XyAjE/VZIaM7dLhWZ1oGNeqLMVGKznX8YAUR1Hpx4qCpxHV0UAu
    3ng9bfkX/P1win2Rt3wVKEZ03CbSHn9FvUPmEeUecBA1zMusVGpzl8djnubJD8KH
    rr1lL8GT4PEz1mmz9FFEuvcLrmfjXYC7VbEPFBpP1yvslS1H/sg/J55/j3H81wAx
    VFyf90NWCknP0WQHS1prtt08dBbQcLZ56E5uu/uKKKQkHv7StNgwG1pe/tOUGbkC
    MZbYfn22LNu1zx2XVkEs3/fbtCPRX33LJ47aiJVAD2kFwgOLI0w==
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
        id S932090AbeB1Qju (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:39:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34796 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934108AbeB1QD6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:03:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Christophe JAILLET" <christophe.jaillet@wanadoo.fr>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.437268828@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 183/254] mdio-sun4i: Fix a memory leak
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 56c0290202ab94a2f2780c449395d4ae8495fab4 upstream.

If the probing of the regulator is deferred, the memory allocated by
'mdiobus_alloc_size()' will be leaking.
It should be freed before the next call to 'sun4i_mdio_probe()' which will
reallocate it.

Fixes: 4bdcb1dd9feb ("net: Add MDIO bus driver for the Allwinner EMAC")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/phy/mdio-sun4i.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/mdio-sun4i.c
+++ b/drivers/net/phy/mdio-sun4i.c
@@ -128,8 +128,10 @@ static int sun4i_mdio_probe(struct platf
 
 	data->regulator = devm_regulator_get(&pdev->dev, "phy");
 	if (IS_ERR(data->regulator)) {
-		if (PTR_ERR(data->regulator) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
+		if (PTR_ERR(data->regulator) == -EPROBE_DEFER) {
+			ret = -EPROBE_DEFER;
+			goto err_out_free_mdiobus;
+		}
 
 		dev_info(&pdev->dev, "no regulator found\n");
 		data->regulator = NULL;
