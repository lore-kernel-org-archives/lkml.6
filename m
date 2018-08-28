Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87313C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451722088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451722088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeH1TpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:45:16 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:39649 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeH1TpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:45:14 -0400
Received: by mail-oi0-f66.google.com with SMTP id c190-v6so3716122oig.6;
        Tue, 28 Aug 2018 08:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y1hlk2S9GwjBYVlyTE/lecEc+81ZS+U6GrCrISTwDb4=;
        b=gxnXOyF5ONvQqSlq8i4k2URH4Ym598Q8v/P80y6EMWH8nl4Yi7RyCko65YOrKs73Qs
         Cdupydj9+6qfd8WRmmsKC01ZVvPZ3SeG/J2b8+zaGI/7dQm4B5zq6cL7BazXWJNYenw0
         66hUM89PLq6SYzpBmXoPIyeIuV4fhi4oZUkyVo0zcmioiXpDUCfnhTg30+fXg/kurYsQ
         /aqSI0oMRm3bYFbzeDok2g+j94shfD2wiGPnRcnmNwE2TgUWhKuKSdGjhaGxKviiTEai
         jBZvPvBHRNPo3vEv6Xnpl6nzCpyrZZqZ8daoQexu6O5PqtbtJa8BmWjuceTd95TjeEBF
         3TmQ==
X-Gm-Message-State: APzg51Ce/A/7ZMgg+kliiLGzhKTHwcuj5JOpXB1wZSf2LVwUVkx2dgy4
        rOcWy7n2ND+jS/YfsvgMnA==
X-Google-Smtp-Source: ANB0VdZNSnMIecwvdx/ru+SjJTiL1P5JbRg9PTpYyPCKJCOecmPGSVTBYLIKk/GbmlZ6dl32342QkQ==
X-Received: by 2002:aca:fd4f:: with SMTP id b76-v6mr1810244oii.307.1535471577715;
        Tue, 28 Aug 2018 08:52:57 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id o68-v6sm2902294oik.56.2018.08.28.08.52.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 08:52:56 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] of/unittest: add printf tests for node name
Date:   Tue, 28 Aug 2018 10:52:52 -0500
Message-Id: <20180828155254.10709-3-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828155254.10709-1-robh@kernel.org>
References: <20180828155254.10709-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some printf test for printing the node name (without the
unit-address).

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/unittest.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 69a522e48970..9def7be9c111 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -299,6 +299,10 @@ static void __init of_unittest_printf(void)
 
 	of_unittest_printf_one(np, "%pOF",  full_name);
 	of_unittest_printf_one(np, "%pOFf", full_name);
+	of_unittest_printf_one(np, "%pOFn", "dev");
+	of_unittest_printf_one(np, "%2pOFn", "dev");
+	of_unittest_printf_one(np, "%5pOFn", "  dev");
+	of_unittest_printf_one(np, "%pOFnc", "dev:test-sub-device");
 	of_unittest_printf_one(np, "%pOFp", phandle_str);
 	of_unittest_printf_one(np, "%pOFP", "dev@100");
 	of_unittest_printf_one(np, "ABC %pOFP ABC", "ABC dev@100 ABC");
-- 
2.17.1

