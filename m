Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264AFC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4E08208D4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="Tkpg3RLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4E08208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbeHRQcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:32:35 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44160 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeHRQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:32:34 -0400
Received: by mail-ed1-f68.google.com with SMTP id f23-v6so5968293edr.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ln7mO65Hsfian0cj3md7fquGvJodOAyFVCDtxs/WyaQ=;
        b=Tkpg3RLZgAEz4SoiQjWozl16Dzx9ZGpwtN9FQgNUtfGgW7iC0IcMWDbBwv84bvLFZN
         +/IL2YObrFTKTFEes3E1/EhlvcIslubtP6kOzOMHGIRYmweEmTjVV2Jpc/gR4RqWOECT
         1C7r48e50sfvSycbk4R0uCcvgk4I3kwBOdW+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ln7mO65Hsfian0cj3md7fquGvJodOAyFVCDtxs/WyaQ=;
        b=VOjM8mzGS917qzsIHDUqf4MJRCf12ZZwQTXgBpW9HDq/RXVLLnnR1vU4eSPiYLUedL
         al3Ai+LoXJeJsF1ndbKPXHNuDBz11GMOFlu2PEPWQ3V3dhCIkol5btXvH5iB5TbKdqr2
         2aKBWOTWKiV3zrK/LGXc3gwjUDVzTpVDlKiyAY89iKcuSFvUt5mdr0DKmjhf8Uin+UVV
         F0Vpm7WOim/HIfWqf23O8zWQ6B+WH56y9e9w4jrxMWAbqhvTVlXngJljNGoi9R4tOSb3
         26Ku8ASCBS3OIi7YkeLj53HevzxiO7G09W8ZhAAT4iazc1HxiFtX1r/accx+HbGVK110
         CyCg==
X-Gm-Message-State: AOUpUlGYUIKQy7YsgsEpQ9Vl4NAig+QiwfgEPxWzkxXibDvsz7hXxkWO
        HSpWlj1AMSWrf6JD//jMMOVFCw==
X-Google-Smtp-Source: AA+uWPzBdOtX/len52i8Y3Jbfl6wxQj+7QFD7n333v6N7KGt/kjPrnJePXMHkGY7lLfxk0RfP7lSCg==
X-Received: by 2002:a50:9154:: with SMTP id f20-v6mr46101568eda.29.1534598690576;
        Sat, 18 Aug 2018 06:24:50 -0700 (PDT)
Received: from prevas-ravi.waoo.dk (dhcp-5-186-114-212.cgn.ip.fibianet.dk. [5.186.114.212])
        by smtp.gmail.com with ESMTPSA id a11-v6sm2739032edn.95.2018.08.18.06.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 06:24:50 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 8/8] PCI: tegra: use seq_open_data
Date:   Sat, 18 Aug 2018 15:24:34 +0200
Message-Id: <20180818132434.9515-8-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
References: <20180818132434.9515-1-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the code slightly by having seq_open_data do the ->private
assignment.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Depends on 1/8 introducing seq_open_data.

Not including Thierry's ack/reviewed-by since it's been half a year since v1.

 drivers/pci/controller/pci-tegra.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e00..e436db8cfe2e 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2302,17 +2302,8 @@ static const struct seq_operations tegra_pcie_ports_seq_ops = {
 static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
 {
 	struct tegra_pcie *pcie = inode->i_private;
-	struct seq_file *s;
-	int err;
-
-	err = seq_open(file, &tegra_pcie_ports_seq_ops);
-	if (err)
-		return err;
-
-	s = file->private_data;
-	s->private = pcie;
 
-	return 0;
+	return seq_open_data(file, &tegra_pcie_ports_seq_ops, pcie);
 }
 
 static const struct file_operations tegra_pcie_ports_ops = {
-- 
2.16.4

