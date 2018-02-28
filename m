Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519835747-2-15897121033525681778
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
    t=1519835746; b=u6BMOQ7Udq/6WOQpCbjaCcPi2Ub8ZbiROMIF9Kgg3NLOrok
    bB0+evr+1dVp4ueclG4KYdJisqtDjtObMTwU+fPp/E9zPViiEGTEOWkFHWBFK7ib
    fa8ZmDqyCv+VIsJdgmLdPCMydswTL7olxQHZ31keqM+gpMkJLO8djuGfijnHexoC
    Uc8IGYnz90lPfVIWfRKhpmY9MchtxyX1ty0O9h0npYTogO4/FvfkmefgRE5kYCTe
    VW6q14h5bG1NpU5BTShoey6C1xXXyxy/h7ZxZDqxzSTaGsxtO0Q6b8E79lmso2oz
    lOHG7vy8DRvhbxVyh/cBgtSeQ7MbdEHVBvbTsCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835746; bh=Gz52Klt/6nnFawGNVMK
    jVphN1NJ9hGY/GLH/wTrdwSY=; b=AaTNl12W4OtWRRih58F7xG0D2lPDOYbr5/9
    liemwndAw4kDT2W7yBjB+fY8sfZnS9vH0/UbBp5Hb5UXR9YBGZj7XQATG6szfZEF
    iuNno4Qmz8wbinkcxMuiOIEY6UkaEzD+cTqlshzzMcTXeh0tfjXL4nod7aPEHNkS
    iZjf3pbbJvrH3waFyTIfi0NTXFpPPpxgAW6u9wghykSLULpJjYHL+Rcda3KmL3vD
    IVlkYdNDdnm5On2GoQhMQj349Aimj+5ytzNcc7Sls6GIX8nHQY9HsLdFrYug98wp
    8wz/quuWK9aJVWr6DJ+WWW/5BwuLMIFms81WBOsws/mC1LBAD3g==
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
        id S932358AbeB1Qfa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:35:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35066 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934578AbeB1QNm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:13:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "Nobuhiro Iwamatsu" <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.363374965@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 168/254] sh_eth: fix TSU resource handling
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

commit dfe8266b8dd10e12a731c985b725fcf7f0e537f0 upstream.

When switching  the driver to the managed device API,  I managed to break
the  case of a  dual Ether devices sharing a single TSU: the 2nd Ether port
wouldn't probe. Iwamatsu-san has tried to fix this but his patch was buggy
and he then dropped the ball...

The solution is to  limit calling devm_request_mem_region() to the first
of  the two  ports  sharing the same TSU, so devm_ioremap_resource() can't
be used anymore for the TSU resource...

Fixes: d5e07e69218f ("sh_eth: use managed device API")
Reported-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/renesas/sh_eth.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2873,10 +2873,29 @@ static int sh_eth_drv_probe(struct platf
 	/* ioremap the TSU registers */
 	if (mdp->cd->tsu) {
 		struct resource *rtsu;
+
 		rtsu = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		mdp->tsu_addr = devm_ioremap_resource(&pdev->dev, rtsu);
-		if (IS_ERR(mdp->tsu_addr)) {
-			ret = PTR_ERR(mdp->tsu_addr);
+		if (!rtsu) {
+			dev_err(&pdev->dev, "no TSU resource\n");
+			ret = -ENODEV;
+			goto out_release;
+		}
+		/* We can only request the  TSU region  for the first port
+		 * of the two  sharing this TSU for the probe to succeed...
+		 */
+		if (devno % 2 == 0 &&
+		    !devm_request_mem_region(&pdev->dev, rtsu->start,
+					     resource_size(rtsu),
+					     dev_name(&pdev->dev))) {
+			dev_err(&pdev->dev, "can't request TSU resource.\n");
+			ret = -EBUSY;
+			goto out_release;
+		}
+		mdp->tsu_addr = devm_ioremap(&pdev->dev, rtsu->start,
+					     resource_size(rtsu));
+		if (!mdp->tsu_addr) {
+			dev_err(&pdev->dev, "TSU region ioremap() failed.\n");
+			ret = -ENOMEM;
 			goto out_release;
 		}
 		mdp->port = devno % 2;
