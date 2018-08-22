Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95B3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FC320C0F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 10:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2u8Sz86"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FC320C0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbeHVOVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 10:21:49 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42582 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbeHVOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 10:21:48 -0400
Received: by mail-lf1-f67.google.com with SMTP id z11-v6so1063125lff.9;
        Wed, 22 Aug 2018 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x9GMZqWF4Zh/JuTlwKcthoo4pQQle29zjxfN3c0RMSQ=;
        b=o2u8Sz86HYjb0GI4mYGGSSjB78V6cw/K0zTVQNDrUeEAD5WYMuaNnngIBToCCppzxK
         6fs1OhUk3yTN1oG87VYSGtnx8XaVhaNbc+YxQPChqwOeWvpqJOvCaECbcFfNQJ9NvDTJ
         8LJ29WjqinOvYsQ/0hxgkQjzwAz15Jp+1iYPDge1jIkh/SA6hUjlI7NF+fXps7HVq5bA
         zfhgzrM5eZHgD0sLiR+t4WjfZZSjkW6etE9Qs/LUthGcRKOEmBZsLIXyBhFz5N4wVurs
         6gv16HameY1cHmFYbvU8yFx8i5WmwcbJ/UBuNtKJnlO9cu4cgBRg+niPAvSaigfmHn4R
         hyOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=x9GMZqWF4Zh/JuTlwKcthoo4pQQle29zjxfN3c0RMSQ=;
        b=THEwhlPvi7yVJdEijVubPpvx+KyRC9UEMYe6uGFlxtHGFFfR/B9uzmntupFtjlMNOj
         q/kN4cMLKuCfK0avfAYxOckpD0iwNnE/AOa8vneQl8dzTIdQ7llTI4h+HsZ+iQqRXbJp
         CKmphmi/iV0hrOA6v6cpKxDs/gHzJELlgOKgYwuWNDZIHUEYxLtFXYF6dfsOcFLtiozp
         3Nx8y/G3Q/fKdavXx0IWu3bhPOcooen7II7MnzPCnXhcntypZpuOrvGvCZHHPeVOFBhU
         A9k0Ei3HGPH3WP+0dPq73sYMl1UuKRc7O/S0YbMSFye3pEmd4bKmUJ6iQOK/r5z9qBYZ
         pRvA==
X-Gm-Message-State: AOUpUlEg/xfyn+X5zzOXfo8koC5Q829x7Q3sNKGkkkWEE1pl9pScNwx6
        ApX7DmFlvAjwM8XGc6GHrpU=
X-Google-Smtp-Source: AA+uWPwGor/AViUd4Px5TV9mefKV7sitFrjcYrvpKufYFm6KqXWYltlU16qqV3iMyT59a6X3wj/+eA==
X-Received: by 2002:a19:e21b:: with SMTP id z27-v6mr9713362lfg.68.1534935442811;
        Wed, 22 Aug 2018 03:57:22 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 6-v6sm266526lfv.36.2018.08.22.03.57.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 03:57:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fsQpD-0002Xs-By; Wed, 22 Aug 2018 12:57:19 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 9/9] power: supply: twl4030-charger: fix OF sibling-node lookup
Date:   Wed, 22 Aug 2018 12:55:47 +0200
Message-Id: <20180822105547.9634-10-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822105547.9634-1-johan@kernel.org>
References: <20180822105547.9634-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the usb sibling
node instead of using of_find_compatible_node(), which searches the
entire tree and thus can return an unrelated (non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related phy-node reference leak.

Fixes: f5e4edb8c888 ("power: twl4030_charger: find associated phy by more reliable means.")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index bbcaee56db9d..b6a7d9f74cf3 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -996,12 +996,13 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 	if (bci->dev->of_node) {
 		struct device_node *phynode;
 
-		phynode = of_find_compatible_node(bci->dev->of_node->parent,
-						  NULL, "ti,twl4030-usb");
+		phynode = of_get_compatible_child(bci->dev->of_node->parent,
+						  "ti,twl4030-usb");
 		if (phynode) {
 			bci->usb_nb.notifier_call = twl4030_bci_usb_ncb;
 			bci->transceiver = devm_usb_get_phy_by_node(
 				bci->dev, phynode, &bci->usb_nb);
+			of_node_put(phynode);
 			if (IS_ERR(bci->transceiver)) {
 				ret = PTR_ERR(bci->transceiver);
 				if (ret == -EPROBE_DEFER)
-- 
2.18.0

