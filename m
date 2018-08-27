Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A27E3C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59F1C2174E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mb285ghV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59F1C2174E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeH0MIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:08:16 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40232 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbeH0MIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:08:15 -0400
Received: by mail-lf1-f68.google.com with SMTP id x26-v6so9179462lfi.7;
        Mon, 27 Aug 2018 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/8b6DVnUIzsW2H798QFzj6ADoL0NwgpiAyrUNGSwRwE=;
        b=mb285ghVm4Wau5IfszH1MVLJqqlfiIDtdnY9pJhqDVtSaE352NX/wQULIPAEo7ykqG
         F9i8e7MUhSeifB/MMCPsTd5NJUt9OSkY1qxQdJ6QySh+jKvL9I+XpJOBUcm5oTcnc1T2
         cXttyP0SF410L0K3KblRA1XUePvvKFuvVx4dMwO2QuKxcq2+iJyf2tnDlBxcui6fvDWT
         OoasgZdoqNV5Qa5ec9gCE2qaMhK4vVIYigEjNbSIAL8qN1W4ie9ZqPJDEM/UdArMvkWV
         kjUxSsh/lzeYC+FYgMtEy08Vg1Zrm27GCFMx4johztTTGVAInse6C7OnOPqaZjA6bfOv
         rhng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/8b6DVnUIzsW2H798QFzj6ADoL0NwgpiAyrUNGSwRwE=;
        b=rt2t1IhDPg2goFui2Ew+x/7YJTK/Y8JoNcVglgzuX+XQy9oM0HtSON0JZwzoZSBf/k
         4XKggMX9IY0N1D1+ju2M/oCWmEhetvwByiKdpJmMofVoByfeq2UXM0XYVmAxXrN5PGPF
         XanMTCe4le3Nxz0SLtynsJ2/bf8ADHiV/NgE5L5T+YN3BBqOVvkGNdU0zzVATTuv6Z4D
         TzcaJ+ZWWBnsjCTQFWJ45uq4PtWJdnRKpm2J2OktWacjQH6qJ0MzpKxQA+Q2J3SkesOQ
         psxBhjH7gn1r1I36yswTpMA3s3qpZd7wXPIYsEHYCXFwU573uKVK/z/q68SKa3Pj5s1D
         yP0g==
X-Gm-Message-State: APzg51DaI2wbikWkSBvvnV7HpxyMnRieOoalkzz36NcOh9WcPrXMoaaB
        M+5sg957+bGCEz/lRIfmE+I=
X-Google-Smtp-Source: ANB0VdarlTzCgkvFaEVEUNdrGGGjwNtNarLjpS85gmlPOiMQOJO5c+AWKsdCEjOkURYMOOeg9DILQw==
X-Received: by 2002:a19:d105:: with SMTP id i5-v6mr8016986lfg.31.1535358156779;
        Mon, 27 Aug 2018 01:22:36 -0700 (PDT)
Received: from xi.terra ([85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 22-v6sm1693893ljv.83.2018.08.27.01.22.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 01:22:31 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1fuCn7-0005t5-At; Mon, 27 Aug 2018 10:22:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        stable <stable@vger.kernel.org>, NeilBrown <neilb@suse.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>
Subject: [PATCH v2 9/9] power: supply: twl4030-charger: fix OF sibling-node lookup
Date:   Mon, 27 Aug 2018 10:21:53 +0200
Message-Id: <20180827082153.22537-10-johan@kernel.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180827082153.22537-1-johan@kernel.org>
References: <20180827082153.22537-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new of_get_compatible_child() helper to lookup the usb sibling
node instead of using of_find_compatible_node(), which searches the
entire tree from a given start node and thus can return an unrelated
(non-sibling) node.

This also addresses a potential use-after-free (e.g. after probe
deferral) as the tree-wide helper drops a reference to its first
argument (i.e. the parent device node).

While at it, also fix the related phy-node reference leak.

Fixes: f5e4edb8c888 ("power: twl4030_charger: find associated phy by more reliable means.")
Cc: stable <stable@vger.kernel.org>     # 4.2
Cc: NeilBrown <neilb@suse.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>
Reviewed-by: Sebastian Reichel <sre@kernel.org>
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

