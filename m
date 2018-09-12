Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7346EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1476120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 02:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOI4aUuf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1476120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbeILHlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 03:41:24 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46224 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeILHlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 03:41:24 -0400
Received: by mail-pl1-f195.google.com with SMTP id t19-v6so197140ply.13;
        Tue, 11 Sep 2018 19:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=Tx5nU6iHO41nal7I2/WfnkKuiUow8vONNI4zspcq9bk=;
        b=gOI4aUufjEwc1qKG5sCYLCUsl7CJOCTAsltLpJ/HufNg3UW1hPt0tzrx7yttLSVevh
         4QIq+9ijVxbNuHLDl/MEMyCCXgXrs0k/GIE0qeCe5jUx0yhjoTr2tr2XC1O3FKigb35w
         mwpR3UKAwzaYh4aT0YTi1woly2ZsevhXBwYSKWngusHoi4TIehbO4fU8ds68ZTsBKs8l
         gn1WK+xIxzr993CRyoQIe4leYAbNPgkJddUFi2tun1stvgmzHxHE6juv6PCo3PNguptF
         ziWriCeiVHzti2MeHyoJjsYn7SOuLz3OQrGMbj+pqHQEoesHEdQ0D3bncoH824JkaQEz
         oI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=Tx5nU6iHO41nal7I2/WfnkKuiUow8vONNI4zspcq9bk=;
        b=JjtyHAR2E7vT5b2VaNXZTv1Za+yFlRVAqZwMH22v8UK499ZoyscJVsEmKLapR37bWM
         f+6ozVgy/OW8IWXtNm4Icmrmbyr15j96snMjmpU4q11Oc632RC3oCb8kNNqDs3/cJuql
         8vMAhLbleqhnT+Zo8myGFjKznl6Gna/C33rYpcgx8qSUoX1vGsWdpIvnjwMukV/MQ2Mm
         bfF1P6kyfYG8DViAeirIn9dwh2uS074I6QVjHTqKwYEFFZmGDYJULa9MLNqDICpwbPq/
         NExT+Yf79MMNxG8fHZsN+eJYRQR4UOB5ruA2ZqEd2pu9pKopKus70MQQXt01zfifvFEF
         mwkw==
X-Gm-Message-State: APzg51D970krG7bqMZYXGDVeGENKz2g2lTcSpEUZuIjJku++tG/4lxMN
        /q1+foOOOTvGYx+IS5G2mOs=
X-Google-Smtp-Source: ANB0VdYU9nLt2DkF/Z9Vz/lW9Qr+rGdlOjimNtNqZUQ7Pza0nq0TNe3zCtvQO0kKLIw0a3Yxj/MidQ==
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr30004006plf.320.1536719951516;
        Tue, 11 Sep 2018 19:39:11 -0700 (PDT)
Received: from josh-ThinkPad-T460s (cpe-75-80-215-168.hawaii.res.rr.com. [75.80.215.168])
        by smtp.gmail.com with ESMTPSA id r1-v6sm37075604pfi.17.2018.09.11.19.39.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 19:39:11 -0700 (PDT)
Date:   Tue, 11 Sep 2018 16:39:08 -1000
From:   Joshua Abraham <j.abraham1776@gmail.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drivers: pci: remove set but unused variable
Message-ID: <20180912023908.GA5549@josh-ThinkPad-T460s>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a set but unused variable in quirks.c.

Fixes warning:
variable ‘mmio_sys_info’ set but not used [-Wunused-but-set-variable]

Signed-off-by: Joshua Abraham <j.abraham1776@gmail.com>
---
 drivers/pci/quirks.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ef7143a274e0..690a3b71aa1f 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4993,7 +4993,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 	void __iomem *mmio;
 	struct ntb_info_regs __iomem *mmio_ntb;
 	struct ntb_ctrl_regs __iomem *mmio_ctrl;
-	struct sys_info_regs __iomem *mmio_sys_info;
 	u64 partition_map;
 	u8 partition;
 	int pp;
@@ -5014,7 +5013,6 @@ static void quirk_switchtec_ntb_dma_alias(struct pci_dev *pdev)
 
 	mmio_ntb = mmio + SWITCHTEC_GAS_NTB_OFFSET;
 	mmio_ctrl = (void __iomem *) mmio_ntb + SWITCHTEC_NTB_REG_CTRL_OFFSET;
-	mmio_sys_info = mmio + SWITCHTEC_GAS_SYS_INFO_OFFSET;
 
 	partition = ioread8(&mmio_ntb->partition_id);
 
-- 
2.17.1

