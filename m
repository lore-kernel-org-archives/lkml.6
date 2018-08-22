Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5373EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0606C20C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOnSZ/Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0606C20C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeHVOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:22:12 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37778 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbeHVOVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id v9-v6so1103436ljk.4;
        Wed, 22 Aug 2018 03:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5QF62ba+ncLY3/sXumyRGvx7IyjSI5wiwkvoCC0W+D0=;
        b=aOnSZ/AjwcNnYh9EaSdXXr3nAQ7bicNhh8Y/50GL5rum4WkfNtWBTANa1Hh1Q2APSg
         LcDGTLVXzMWC9Koky40niybQ4lBCo81gALtH4UPOo2UpmZduWWE7CKnj0qAKT95k0jiX
         tuC78a3h0zu5vs8UXJtlyTFz5QvBJtsmsCEtwavzBfo7zj4Z45GkEhqDIs6G4YRxY1bj
         rEdY4U4I6oNSJwIJpwBn7kN5WF+E5RhTMmmZ8Q4tMAUsHH6qg+IZkluY1+J+Hg7ynHAz
         SS47XIEYa6u0gchCCwa4NIR4Eg2gyCmW3PZCbvb/FPlAYT4tB91sL5O/RVnSncF08Snk
         PpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5QF62ba+ncLY3/sXumyRGvx7IyjSI5wiwkvoCC0W+D0=;
        b=o0ynS87svff9ONpRQq4er2mMBKyEFX/1BIbjlhYuyVTUDyRo8o+AwX/P7fXjuBt4Cg
         2d9zpyLhX7UPi+GbGGv4Scq4CWv7aT3N1FuKDSL0RG/UzvfYK8DkAB0ZHLEfZ5TJ2gWZ
         Nv/vYIkJnoSAPukhXcPyF8Sr6m/AVkcK8FPCJEcXQtMPen20oI1LmOsbhHzQe3a3+fU5
         eiVclvgAr3RkhuUlctus3303vYdd8/ZbuUBoVD5PXbCtPp6G77ioxvy9WM639lWufzhB
         GkE2DfXCAtFxrWTGHT/lJ595tvI0267NrxQ7xaHd4YTnpP3OB8ZDhZNow2XTQvk7B2tA
         LVRg==
X-Gm-Message-State: AOUpUlG0xjghToYs+FJnUqr+xKZgWL71r8RO0NkJnAqWSAIf392BkfGK
        vma/R13KcO6jSxfbsyeXOow=
X-Google-Smtp-Source: AA+uWPxg4F4F3uHzSpNMVz1CqQcjNfGcWqMU9OmwpCebhVFTAoLl4b946j63X8zL9gWvM22Nf7P3Fg==
X-Received: by 2002:a2e:144f:: with SMTP id 15-v6mr38850124lju.122.1534935441814;
        Wed, 22 Aug 2018 03:57:21 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id j15-v6sm233235ljg.52.2018.08.22.03.57.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpD-0002Xc-1B; Wed, 22 Aug 2018 12:57:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH 6/9] net: bcmgenet: fix OF child-node lookup
Date:   Wed, 22 Aug 2018 12:55:44 +0200
Message-Id: <20180822105547.9634-7-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the mdio child
node instead of using of_find_compatible_node(), which searches the
entire tree and thus can return an unrelated (i.e. non-child) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the node of the device being probed).

Fixes: aa09677cba42 ("net: bcmgenet: add MDIO routines")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index 5333274a283c..87fc65560ceb 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -333,7 +333,7 @@ static struct device_node *bcmgenet_mii_of_find_mdio(struct bcmgenet_priv *priv)
 	if (!compat)
 		return NULL;
 
-	priv->mdio_dn = of_find_compatible_node(dn, NULL, compat);
+	priv->mdio_dn = of_get_compatible_child(dn, compat);
 	kfree(compat);
 	if (!priv->mdio_dn) {
 		dev_err(kdev, "unable to find MDIO bus node\n");
-- 
2.18.0

