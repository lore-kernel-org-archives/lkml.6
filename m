Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AA3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7F621758
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6moaF3S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C7F621758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeH0MIN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:13 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45982 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0MIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:12 -0400
Received: by mail-lj1-f193.google.com with SMTP id u83-v6so11595338lje.12;
        Mon, 27 Aug 2018 01:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJAxMJoFGwX/EPqhoE/MvooVBoBfkGRlL2+zPLHlEYQ=;
        b=l6moaF3SeKnYmGMxxc4LNizMQmraoLfJDZmj0RYnxZ77onB/clmSPCZi+SUCWmBZAU
         0eUz4ENtQHWNBrY5XJBQ+I4iQtiorOX+5DCgTbh0Qra9qG1iYyuwhlkbEyQ/kBf7Yj8m
         DAO8hfj1HRjVqDTPNVLXI+OfMroB+xlIIVL4VTb8ExFRwqnnBWG0TsF+2U3tWixyGtRe
         8g4BPiV2nP3UivITJmbKOLYuSUJKJjgtduBXbI9YAWfXSP/87PW4cjPU1qdd4nVt/+a9
         G7w3s21IKW8XQLJwfUTG4DP9VHsaVLmQUBRvj2+g7VAMnEyqANq4S6f8HAZgRMj70P/Q
         kb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XJAxMJoFGwX/EPqhoE/MvooVBoBfkGRlL2+zPLHlEYQ=;
        b=oXmrF8w48DluHha/1cpC26536Xt0pbq7oRVYOLH5sqM5xEynhO7VGCvfzLh0fuVp1l
         3J35s85HSzn/UxT0h/uLAhEEBwfV9GPjliErv6Q8DQFbw4U6PBaXpPbnzIzCzy1X0SGn
         AfsZAjvjapk083Eb3K/XChjgTXByvUpIVBoqHNWqh/w8U159KSw31lWUwzyMAQk5cGNl
         LWk8Ht/M0rheiju/2fnB2gMXv530GC0h03aAvBd4t5YYSxH34NCZG9n8+4RCLB1A1Jcy
         rBQuCKi/V5N41GFint8T48QK/bpU5k4x1JLVZBya62l9ykZY12MObver2CuVrBfxnef+
         ccsw==
X-Gm-Message-State: APzg51De2ZfIhxTdreQb/Vbxa3+/Yz2RFiprOYnSXic14EN1V6T8f0x7
        3KxXHTjM/H5O+P88syjkUbU=
X-Google-Smtp-Source: ANB0Vda+2F47IUGtcdxV/YNPxo9NXqKaVTXTVOjtcf1868zTIKC5q08EB7HrdPmnSW4VzLCE4mUpCg==
X-Received: by 2002:a2e:5053:: with SMTP id v19-v6mr6169841ljd.84.1535358153554;
        Mon, 27 Aug 2018 01:22:33 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y17-v6sm1869165ljd.42.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn7-0005sr-1x; Mon, 27 Aug 2018 10:22:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: [PATCH v2 6/9] net: bcmgenet: fix OF child-node lookup
Date:   Mon, 27 Aug 2018 10:21:50 +0200
Message-Id: <20180827082153.22537-7-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the mdio child
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(i.e. non-child) node.

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

