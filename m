Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC3C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471792075E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kresin-me.20150623.gappssmtp.com header.i=@kresin-me.20150623.gappssmtp.com header.b="hRMuV7vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471792075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kresin.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbeIELUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 07:20:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42825 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbeIELUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 07:20:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id v17-v6so6329645wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 23:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kresin-me.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=ri7EJN21pZemz2aQZfOHbQwdWYzT7gNlzYbBQlc8r5c=;
        b=hRMuV7vUG7c9qjmi4dfbs6ytnUOwLDK0VoJUq8g8woxXLRJqHF8oKS1hweMOqtbmXP
         iooIyVCjWhA+D20sBXVFLj3fe9AWkzhk/DlGjxy2JDKVyiHAtagg1qrkFNtMlpzrjL4A
         kYd10qkfhe2P9uFI5JmEvmDdFDtxS8BoTWwIeQaaIoOpnj8aREm+9n+JRwRr0QakrdYF
         2qItct9jZMF9FBdhdQgpGyZpPuivEl0aNn2l//+8I0ouOE0cX7bhxUeCIEh/Kx7BpxZZ
         zaXfDLQzF4guaFcMizrJPeAhKMFHfq4o8k4+gAOjzrpv1LxWzZ2h+qPhYh870uSaeG16
         rWTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ri7EJN21pZemz2aQZfOHbQwdWYzT7gNlzYbBQlc8r5c=;
        b=feM89ySAIpeqxAiTUML6wsD13fIT2RrPubjBNDIjnEs8bvz+T8lA4XT1CuF8radbe7
         664ffLar0nNMM8dm6vYKlkS/bSwavAoY7b/y5O4mZkyGN7U1Wc2Pf6LMqumlW+FmaaF3
         x0bn583B9S0sSpg81dELCSearhLVYGghioxffT2ITettk3+IzHpp0BQTG1jESCMsKxvp
         HMM/jypWDr6XZkF7KfsnJlyuNJM+5wCrcEil40qnOzl4UWxj5AgRGDTypilxVaN0JTsm
         pKUU4jaYkvLWMDWZQH6qJbdprn6fvnXzj0mtSc52fbRUXTiId9yfmrbijXRj7CPcn9gH
         TL3g==
X-Gm-Message-State: APzg51D+F/eUMNff6cNHnqcVSIOzr1mdbEjtndJgZuLP+VYYbxC3s3g3
        q35gL0E0qhvTm/gsqY7BEqJijg==
X-Google-Smtp-Source: ANB0VdbOtamYmccuSQE98uXRO0dEIaMO4OPoJOpHf9ssZRqeGf5yM0kXNwv9trcWJCdMMTS6qiV0FA==
X-Received: by 2002:adf:94c5:: with SMTP id 63-v6mr25937832wrr.247.1536130293775;
        Tue, 04 Sep 2018 23:51:33 -0700 (PDT)
Received: from desktop.wvd.kresin.me (p200300EC2BD12900A4378724D7036CAE.dip0.t-ipconnect.de. [2003:ec:2bd1:2900:a437:8724:d703:6cae])
        by smtp.gmail.com with ESMTPSA id s10-v6sm810818wrw.35.2018.09.04.23.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Sep 2018 23:51:33 -0700 (PDT)
From:   Mathias Kresin <dev@kresin.me>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Tobias Wolf <dev-NTEO@vplace.de>
Subject: [PATCH] MIPS: pci-rt2880: set pci controller of_node
Date:   Wed,  5 Sep 2018 08:51:26 +0200
Message-Id: <1536130286-32088-1-git-send-email-dev@kresin.me>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobias Wolf <dev-NTEO@vplace.de>

Set the PCI controller of_node such that PCI devices can be
instantiated via device tree.

Signed-off-by: Tobias Wolf <dev-NTEO@vplace.de>
Signed-off-by: Mathias Kresin <dev@kresin.me>
---
 arch/mips/pci/pci-rt2880.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/pci/pci-rt2880.c b/arch/mips/pci/pci-rt2880.c
index 711cdcc..f376a1d 100644
--- a/arch/mips/pci/pci-rt2880.c
+++ b/arch/mips/pci/pci-rt2880.c
@@ -246,6 +246,8 @@ static int rt288x_pci_probe(struct platform_device *pdev)
 	rt2880_pci_write_u32(PCI_BASE_ADDRESS_0, 0x08000000);
 	(void) rt2880_pci_read_u32(PCI_BASE_ADDRESS_0);
 
+	rt2880_pci_controller.of_node = pdev->dev.of_node;
+
 	register_pci_controller(&rt2880_pci_controller);
 	return 0;
 }
-- 
2.7.4

