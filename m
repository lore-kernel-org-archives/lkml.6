Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA2EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C55E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 18:34:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C55E20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbeH2WcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 18:32:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37951 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeH2WcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 18:32:14 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so10942395oix.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 11:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GKQiezdqb2dvMAN04K3bM9bn8gEYB01L2pCQBNrZbF8=;
        b=nWuImbA6VblCehVqqG2t2A70LG63XPi3dA6drYauoCWDr7d39zsRUPhQFcwMrTCOhu
         MN6H38wVG+sFOKojbd7l3Q4/iJpNUyXLhO0J2amaZrskz8pV2Qedobr+McAxDpWkwXTV
         PXSkNJBHcNRn9zts7q7tJwlIrEkdzv8YNoZlpZaejv142rhc2xIjjgDZ60jsO/0OlaVF
         lYlEzAerWn1y3XJEdH1Hw1QdjlsiCfWEQ27Hjt5BRHz4LEYP9ZFXVjyqeFPASX50cE6/
         S1sL+T1ZvyfHfzBL8rgg8ZWa4REPwh9+y1P2fyKXlZaefxXDR0InXoQbQmNm05s/g9YL
         tG+Q==
X-Gm-Message-State: APzg51B2kI9lCKiEn7F/G7qr4UlQreWUnySuYE6J+UlmDbrzEHiX2Fa3
        XaiZ1XmBhReaUWdneLsQfa8wEUY=
X-Google-Smtp-Source: ANB0VdZK74XiqD5DikxIn+Wg2e75sSz4XpK216eDZ6eDxJH5OZedMQ2JiyF4wl9FC6vCw+x5x8U+rA==
X-Received: by 2002:aca:2c5:: with SMTP id 188-v6mr4012220oic.192.1535567645090;
        Wed, 29 Aug 2018 11:34:05 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id 16-v6sm2391487oin.5.2018.08.29.11.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 11:34:04 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH] staging: mt7621-pci: remove unnecessary check of device_type == pci
Date:   Wed, 29 Aug 2018 13:34:03 -0500
Message-Id: <20180829183403.12790-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI host drivers have already matched on compatible strings, so checking
device_type is redundant. Also, device_type is considered deprecated for
FDT though we've still been requiring it for PCI hosts as it is useful
for finding PCI buses.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 0d13384b90c4..5055475bd04e 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -387,15 +387,8 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
 	struct device *dev = pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct resource regs;
-	const char *type;
 	int err;
 
-	type = of_get_property(node, "device_type", NULL);
-	if (!type || strcmp(type, "pci") != 0) {
-		dev_err(dev, "invalid \"device_type\" %s\n", type);
-		return -EINVAL;
-	}
-
 	err = of_address_to_resource(node, 0, &regs);
 	if (err) {
 		dev_err(dev, "missing \"reg\" property\n");
-- 
2.17.1

