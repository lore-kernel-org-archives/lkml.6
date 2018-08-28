Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB535C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80176208B2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 01:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80176208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbeH1FmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 01:42:19 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34206 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeH1FmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 01:42:17 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so40186ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 18:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qfbYECRu9Qxjs00hQEfRFiuswssUglS2zH0M15sSFZs=;
        b=nQQQqZ1av0kQhvT8WJbSf4+2y0YjJaJPVtY6gMZnkrYW1OmeCdhAAoDmssiFV8xRku
         mAtt5HRnQmFJ+Ftlh6ndzFk78zjCX6/lvKPTVsxhEPRSkDJLb8ItlwlBWXITRzzfoNID
         0nrYoc40vhAi3m0EIzDZnEt+YnpMLzYGZUH0e3hqn2JYJBgqHHE76RYdIXkWvWZwQXfp
         iniXv2n4eTtVb0iBDnuzyaGufIdLGe+baFV4owbmww6XRAOb07++sPkbBsGq2JTKqB0N
         RecNZAawTNYEc53uvHm1VGg5vsJHIC73+jn3MT1wGJC17QEEYP21/undapAV2Xf6ExXk
         +IzA==
X-Gm-Message-State: APzg51AK1Xji38FTAfsLvcz3z/h2UCDb0UY/dcrjdKYVi9nHg/eKiu6T
        KVWiQwxZI3LvUrU8CTZwRP/d4AY=
X-Google-Smtp-Source: ANB0VdaGGbP5HMvTNsaZLJTYHyJExU42tZmOwEs1tSmM0EmnhOZrfnwzQeWHliLdNC7g2k/2PW22gg==
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr1126067oia.195.1535421181386;
        Mon, 27 Aug 2018 18:53:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id n71-v6sm1652696oig.48.2018.08.27.18.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 18:53:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH] xtensa: Convert to using %pOFn instead of device_node.name
Date:   Mon, 27 Aug 2018 20:52:09 -0500
Message-Id: <20180828015252.28511-8-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove the node name pointer from struct device_node,
convert printf users to use the %pOFn format specifier.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/xtensa/platforms/xtfpga/setup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/platforms/xtfpga/setup.c b/arch/xtensa/platforms/xtfpga/setup.c
index 42285f35d313..820e8738af11 100644
--- a/arch/xtensa/platforms/xtfpga/setup.c
+++ b/arch/xtensa/platforms/xtfpga/setup.c
@@ -94,7 +94,7 @@ static void __init xtfpga_clk_setup(struct device_node *np)
 	u32 freq;
 
 	if (!base) {
-		pr_err("%s: invalid address\n", np->name);
+		pr_err("%pOFn: invalid address\n", np);
 		return;
 	}
 
@@ -103,12 +103,12 @@ static void __init xtfpga_clk_setup(struct device_node *np)
 	clk = clk_register_fixed_rate(NULL, np->name, NULL, 0, freq);
 
 	if (IS_ERR(clk)) {
-		pr_err("%s: clk registration failed\n", np->name);
+		pr_err("%pOFn: clk registration failed\n", np);
 		return;
 	}
 
 	if (of_clk_add_provider(np, of_clk_src_simple_get, clk)) {
-		pr_err("%s: clk provider registration failed\n", np->name);
+		pr_err("%pOFn: clk provider registration failed\n", np);
 		return;
 	}
 }
-- 
2.17.1

