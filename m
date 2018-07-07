Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EBFC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F69F224F7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrLFDRbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F69F224F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932656AbeGGHK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:10:26 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32780 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932336AbeGGHKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:10:25 -0400
Received: by mail-qt0-f194.google.com with SMTP id l10-v6so11779573qtj.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 00:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=s1bKKwVHyJHjRB9j412VV7vy5BJ7o4ZxVS9TF7xyQ9c=;
        b=HrLFDRbhz55K0TupTKTFIAJjNixGFkDSO5nMmKulRkH8mj14BxfFKs0F9aQ5QO5RCT
         omlZZlfLwLfzGO/DFiSNegGWVxNBHkiUzSHdyvPf5HbEucjUhosdjKZqjVKdGqtmkSfS
         NiL010TdGbGZktd6xv+/Pa+Nmtoqr6thgMypWqSDUKzQquc1x+KPz4cA2U2btmN7fiSq
         aBsAWwVMBgKe0MitDjJE3ugzCCsdNpOLotA0sRkvONsUYRRyKyTnTNMvwI1BoE2rgwAS
         zzbijgzxxtzaItJ1dYnxBf97lZ2cSZMY57qC2+egPk/bHj9N4vkb+QbQBbyeASXNNybt
         Z37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=s1bKKwVHyJHjRB9j412VV7vy5BJ7o4ZxVS9TF7xyQ9c=;
        b=YDH7xt7aMz0L1fJ70ZnZVgrzd6FHYNfvIvAscb1roEmp9gXn8ew7UbAmw933K+DasO
         Id2rsgX/hesFQxbZK+nTYsjBct/s2MyYYuSx5pCDG27CQGJji2oL/LlvL5eK8eiVlC3Y
         05lSbozCvAkzxZGWQhwFwYGNO96vRkGfKHkA10U96t0RCtbHd7+ivv/dTc7rB2kNtXYp
         5if3+XGZOBQjni/iovCKa3dCkvOPZ0kXEarL0weCGpvGs3B2Ceetaa4JS4Jd71xb2sr/
         UaEQ+f+GHYhKMBxYsZX1KrhIQP6HDQr/vUVXfW7VZNAsa5/hvcKIrSk/1SVc4salbzh3
         66qw==
X-Gm-Message-State: APt69E11k/94FVuN/Gj4qiiuCUjOD4lXlwc3Dn43Drw3F0tLZNs14Vlt
        6XAD5zy67dIo7Uar4N75Z/o=
X-Google-Smtp-Source: AAOMgpeSwVhQWMdCyMuFHBqi6KcAJfRROoqJVMp7f9+j3UCRHjOkho9qksDbOQSOn6MdkGl+nHG+2g==
X-Received: by 2002:aed:3cae:: with SMTP id d43-v6mr11900424qtf.379.1530947425001;
        Sat, 07 Jul 2018 00:10:25 -0700 (PDT)
Received: from peter-ThinkPad-X220-Tablet (pool-108-18-228-108.washdc.fios.verizon.net. [108.18.228.108])
        by smtp.gmail.com with ESMTPSA id v56-v6sm8026817qtv.50.2018.07.07.00.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 00:10:24 -0700 (PDT)
Date:   Sat, 7 Jul 2018 03:10:22 -0400
From:   Peter Vernia <peter.vernia@gmail.com>
To:     peter.vernia@gmail.com
Cc:     gregkh@linuxfoundation.org, neil@brown.name,
        peter.vernia@gmail.com, blogic@openwrt.org,
        sankalpnegi2310@gmail.com, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: mt7621-pci: Move open-braces to match kernel
 code style
Message-ID: <20180707071022.GA26600@peter-ThinkPad-X220-Tablet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moves some open-braces to the end of the conditional statement to match the
kernel's coding style

Signed-off-by: Peter Vernia <peter.vernia@gmail.com>
---
 drivers/staging/mt7621-pci/pci-mt7621.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/mt7621-pci/pci-mt7621.c b/drivers/staging/mt7621-pci/pci-mt7621.c
index 3c7978e..c12447d 100644
--- a/drivers/staging/mt7621-pci/pci-mt7621.c
+++ b/drivers/staging/mt7621-pci/pci-mt7621.c
@@ -532,8 +532,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 	*(unsigned int *)(0xbe000620) |= 0x1<<19 | 0x1<<8 | 0x1<<7;		// set DATA
 	mdelay(1000);
 
-	if ((RALINK_PCI0_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI0_STATUS & 0x1) == 0) {
 		printk("PCIE0 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE0_RST);
 		rt_sysc_m32(RALINK_PCIE0_CLK_EN, 0, RALINK_CLKCFG1);
@@ -543,8 +542,7 @@ static int mt7621_pci_probe(struct platform_device *pdev)
 		RALINK_PCI_PCIMSK_ADDR |= (1<<20); // enable pcie1 interrupt
 	}
 
-	if ((RALINK_PCI1_STATUS & 0x1) == 0)
-	{
+	if ((RALINK_PCI1_STATUS & 0x1) == 0) {
 		printk("PCIE1 no card, disable it(RST&CLK)\n");
 		ASSERT_SYSRST_PCIE(RALINK_PCIE1_RST);
 		rt_sysc_m32(RALINK_PCIE1_CLK_EN, 0, RALINK_CLKCFG1);
-- 
2.7.4

