Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9163CC004D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087E206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6087E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbeI2Ear (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:30:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37332 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbeI2Eaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:30:46 -0400
Received: by mail-oi1-f193.google.com with SMTP id e17-v6so5827458oib.4;
        Fri, 28 Sep 2018 15:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=86K21m2B7R+YkZWHzGQH6SjtoiDO09zFXEYtcEYvZ8g=;
        b=qXakvUvJsE68FZJ5vAAc33MfgpAsFLirYfUXOimuihFT5scvElVCs3gOVwHmgLO9YI
         sD6wOwZioc9aFjPN4P80lGu2Mj2vjcyUeTdCyR0180yOgp1PVQJzhNzMuMh93KSt/gyI
         dx2r4HXuYnlaj2VjUDHZYq0zmrruO3Cg0PTC8SheynxXwwr8fKnBUqkpPKzXwNqe7+nH
         L1VfjhNuvjIr3NernHRaHehXI7jRI2jomrOdovF64zToEC8Hoc7Bx+Lx7R3poTI3nDsN
         pClT1KCGP+o+egzBFgFo801Yjh6vL7dyIf+Ube+UuZUoRlL0/ohWWCbKSkP73S6MR+KO
         4jKw==
X-Gm-Message-State: ABuFfohIxlh7Ctwt8TCewEevRrRN0rSgM0cHU6RcAtR6V7PP94gm7bVW
        aNCaQZOb64xWhB7+Lm/C3w==
X-Google-Smtp-Source: ACcGV63Ptgdq2IkhlQPaUfGgrVILiQ4DnBNkHzSHuGcnQ+efxvBZonUoUHFzv49Gr+yQfjr5zcwBrg==
X-Received: by 2002:aca:db05:: with SMTP id s5-v6mr318453oig.173.1538172300554;
        Fri, 28 Sep 2018 15:05:00 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n26-v6sm1942563oic.5.2018.09.28.15.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 15:05:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH RESEND] net: phy: Convert to using %pOFn instead of device_node.name
Date:   Fri, 28 Sep 2018 17:04:59 -0500
Message-Id: <20180928220459.11385-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
David, Resending because you superseded this one for some reason. It 
shouldn't be. Perhaps because the subject was similar to others?

Rob

 drivers/net/phy/mdio-thunder.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/mdio-thunder.c b/drivers/net/phy/mdio-thunder.c
index 564616968cad..1546f6398831 100644
--- a/drivers/net/phy/mdio-thunder.c
+++ b/drivers/net/phy/mdio-thunder.c
@@ -73,8 +73,8 @@ static int thunder_mdiobus_pci_probe(struct pci_dev *pdev,
 		err = of_address_to_resource(node, 0, &r);
 		if (err) {
 			dev_err(&pdev->dev,
-				"Couldn't translate address for \"%s\"\n",
-				node->name);
+				"Couldn't translate address for \"%pOFn\"\n",
+				node);
 			break;
 		}
 
-- 
2.17.1

