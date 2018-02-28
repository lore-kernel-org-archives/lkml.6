Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834012-2-4029023510674896738
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
    t=1519834012; b=ZjuxhBGDOJJA5CMsqJOgH8tMycm1Acjl+pd2Sju1y5QgR+B
    t+abrfqZweraE29es5YR7jV/FBGvwq4z2kY3YeumvNoIa4e3LTjzX3788Wv48d9Y
    UK39n+dBTOReVtd6xvtoefwEm8jQqzP6eoG4VPhopKXeVwkBxwMT+Xo/OzhIR3Yi
    w8UHl4Tm68liEu7QHapq2os6HoDG3NXsdI6WfdtGU7A3roknCXkK3/brK1CW0AK4
    92RyektgwN0XgFRa9bJS5StPOoAEj3z6VcaAYWggI/Rf7xBQGJCiQMgeqvFe2jR0
    zgF/kaWkzS5F0qZqbgKm0ZfhDHPdiF2HRfscSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834012; bh=sz4SFgNkwcbQsnLMVEe
    oI3FkzgKMAObh8+Z2OM/WEto=; b=K9whoYlEhpG4vptYvcXvy4RuHNGSouLB+Rd
    0X8jcDdMaCgW8DD9T3mj01X7RlE3PEMgBDkXlQxpjkze4KD97IxwRPbSPcrIwAPB
    a4n6JzJGyKm+Up9kclWn9tOcc7YzgFZVGI0PpiQQHJlrzly1CXjbgjSLsuZpVeGn
    2WxJwZtUmgOFWo+g2UpjTTVqqV+BDsl/k9G2+80t/hZrSt7N/ZfQBqfMyNic+xFq
    Vzg0wQXiFkihSrGJ19+7qNAxxEzhjTbQ4poE7SiAruamn2FXR1Pp1LrXAzh0MLYI
    Ed9AVdNnQEiGjrn5flSRyE3vcexNEaCORTOpHfH1mIpYXzcb+PQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934522AbeB1QFc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:32 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34890 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934501AbeB1QFa (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:30 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jerome Brunet" <jbrunet@baylibre.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Arnaud Patard" <arnaud.patard@rtp-net.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.831406354@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 167/254] net: stmmac: enable EEE in MII, GMII or
 RGMII only
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

From: Jerome Brunet <jbrunet@baylibre.com>

commit 879626e3a52630316d817cbda7cec9a5446d1d82 upstream.

Note in the databook - Section 4.4 - EEE :
" The EEE feature is not supported when the MAC is configured to use the
TBI, RTBI, SMII, RMII or SGMII single PHY interface. Even if the MAC
supports multiple PHY interfaces, you should activate the EEE mode only
when the MAC is operating with GMII, MII, or RGMII interface."

Applying this restriction solves a stability issue observed on Amlogic
gxl platforms operating with RMII interface and the internal PHY.

Fixes: 83bf79b6bb64 ("stmmac: disable at run-time the EEE if not supported")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Arnaud Patard <arnaud.patard@rtp-net.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.16: adjst context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -275,8 +275,14 @@ static void stmmac_eee_ctrl_timer(unsign
  */
 bool stmmac_eee_init(struct stmmac_priv *priv)
 {
+	int interface = priv->plat->interface;
 	bool ret = false;
 
+	if ((interface != PHY_INTERFACE_MODE_MII) &&
+	    (interface != PHY_INTERFACE_MODE_GMII) &&
+	    !phy_interface_mode_is_rgmii(interface))
+		goto out;
+
 	/* Using PCS we cannot dial with the phy registers at this stage
 	 * so we do not support extra feature like EEE.
 	 */
