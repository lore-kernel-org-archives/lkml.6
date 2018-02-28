Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519835510-2-15094760931179120131
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
    t=1519835509; b=EhQN12XM6Nyqoellc5Ga8ACvWTMN2DeDgn6Iej6LGuZXa49
    2wN/WJRtQAGNYmHqaMP9dBeg9R0SMMhcEkW3fHesFck7P+Cw+nKlYZkZM0ZQKj1q
    IaPXK95ygkeUvwAc4fqrL2knUT3nvDMAazmnpDhOUTXErxM7dqUBQe8sGFU53YDm
    exMJ2KPUfmYj2T4jp4PN4+9JGJPSaq5PqTvjUaSiWnqbYyWzECU2F/gnWVPeIrQ1
    FWtGCiesk3Hnft0sestWKTLB9DKUaoIP0xpA6mI8xXDAzbQdQVsB+G25pOhDlAPX
    WzuETvRSayHuqsmesMYQQc+iY3uVl+yxDelqYVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835509; bh=FnPEY0U5vsanmMs+nZJ
    Qatf5Shqc3rFjk25kQNqKIdk=; b=pvM7sXPh6waqrJZIJAaOxXPKdd62ZtNk1gi
    Cd9IzhIamMcTSGn2f0liLz2h5dweSzUS5jqDMaxQmXz7aTK/7scGvXBj28m7S40z
    YDHLvcP71xTvROaZWeSCcFsx4cNg7SN5TKYoHW3bJM3/qL3fvSDbhaNMsLtgBCMn
    9gykbZeg7zd1uuOtTpZcdk6kkRDQ/wDmfZUCzb+mR3TmvimRhHX3oy1Sq70YbFYH
    eXBj7RfG/5R8oeEh8gbJYi/ZkZhUbb3smzKePXIAbdS/eVorYuh9FTTjRxQTXNjy
    E9dMmVmQ5qguFO3OPsaPWfFYzs6pXumuwJFpKDJ+BTicPw9db6g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932687AbeB1QbQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:31:16 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35139 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932674AbeB1QPA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:15:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
        "Johan Hovold" <johan@kernel.org>,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.423805769@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 188/254] Input: twl6040-vibra - fix child-node lookup
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

From: Johan Hovold <johan@kernel.org>

commit dcaf12a8b0bbdbfcfa2be8dff2c4948d9844b4ad upstream.

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at parent rather than just matching on
its children.

Later sanity checks on node properties (which would likely be missing)
should prevent this from causing much trouble however, especially as the
original premature free of the parent node has already been fixed
separately (but that "fix" was apparently never backported to stable).

Fixes: e7ec014a47e4 ("Input: twl6040-vibra - update for device tree support")
Fixes: c52c545ead97 ("Input: twl6040-vibra - fix DT node memory management")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Tested-by: H. Nikolaus Schaller <hns@goldelico.com> (on Pyra OMAP5 hardware)
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/input/misc/twl6040-vibra.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -264,8 +264,7 @@ static int twl6040_vibra_probe(struct pl
 	int vddvibr_uV = 0;
 	int error;
 
-	of_node_get(twl6040_core_dev->of_node);
-	twl6040_core_node = of_find_node_by_name(twl6040_core_dev->of_node,
+	twl6040_core_node = of_get_child_by_name(twl6040_core_dev->of_node,
 						 "vibra");
 	if (!twl6040_core_node) {
 		dev_err(&pdev->dev, "parent of node is missing?\n");
