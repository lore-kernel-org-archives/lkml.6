Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D72DC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFCF2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AFCF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeJBEXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 00:23:44 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35270 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeJBEXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 00:23:44 -0400
Received: by mail-oi1-f195.google.com with SMTP id m11-v6so12560064oic.2;
        Mon, 01 Oct 2018 14:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9/Q/4kaUvCR+p+k3AL0l0zXV0mtyPAnoA90nV3ubCFc=;
        b=Vg9nr146BnYPJtNBodXctaAcBmS3krSWkiLJPcZz23+4RYKYwQ5o00qSRxqNvvNhcz
         jrjNw/1r7Bkjzm5sYmCfHojehjDOs9ZmQWmrE26rYOcWIhTlVh9ok60JEqfnMxZNyid6
         mGt1w6Avb/Mz0k1Bn7WhXaadFfAoTV2vQ6VgMGCe1k3tMS53F6ztjX+DX4+OJ21gSHku
         lJzecfDzas3ABQWSCWQ3A+KWrcqqWAUXM+4XP+rMDvKPGPvt37BCc+c9YD3W5crzuPH+
         PQ/fx4o+GCDC8bg0MpCYU/HKV9kWeiF1pxwfpe08CqMNxrOa/VbRD0oQkfDVMqKuUB+/
         HmwQ==
X-Gm-Message-State: ABuFfoippyIEd5Bs03YOvfE0laD+89WVJ385TbTz8uW1ctd9ypRGH9an
        MeW3DebiMhfaRG7/G+KTLAinS8uTQA==
X-Google-Smtp-Source: ACcGV63+fKmlg6sU/xfH1T27uZFAf/vAVzorp3TCI91KsELMNckP/+pFLzqI2emP9NqmS0UyhFFOqQ==
X-Received: by 2002:aca:d489:: with SMTP id l131-v6mr5694475oig.15.1538430233643;
        Mon, 01 Oct 2018 14:43:53 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h22-v6sm6401661otd.21.2018.10.01.14.43.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 14:43:53 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] input: xilinx_ps2: Convert to using %pOFn instead of device_node.name
Date:   Mon,  1 Oct 2018 16:43:49 -0500
Message-Id: <20181001214351.13230-2-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001214351.13230-1-robh@kernel.org>
References: <20181001214351.13230-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/input/serio/xilinx_ps2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 07de1b49293c..6615c02a08fd 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -245,7 +245,7 @@ static int xps2_of_probe(struct platform_device *ofdev)
 	unsigned int irq;
 	int error;
 
-	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
+	dev_info(dev, "Device Tree Probing \'%pOFn\'\n", dev->of_node);
 
 	/* Get iospace for the device */
 	error = of_address_to_resource(dev->of_node, 0, &r_mem);
-- 
2.17.1

