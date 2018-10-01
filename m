Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C9DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E8F208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02E8F208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeJAWEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:04:10 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:32908 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbeJAWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:04:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id a203-v6so11556480oib.0;
        Mon, 01 Oct 2018 08:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xxRNCX3AaKi4QWh7oBGizaPAWtftQeBgmxx2yRMWe/c=;
        b=ZtVO9rTv97GJECM30Lcs5oqubKTBAcCRX7B7g4LN5gxRAfdgZtnu5A1oscW+tiVdrg
         7qH/E6Yl43CMJB2x+vvYGgINswLHfYBvZyMN3lUbSO/H7dEsKTethHiWUBjcn7rsgROD
         ELCkrwlerrk6AgvXvNkDVTmRei01rQ9nm+/wK5CPdUsYuxPJ2EBsnGq9hyzc6f33/Il9
         gbWy4BAvTmLT23pPpKDS138tG+WSJ+2IjbwxCjBqhryTImVupF5rVQ54BOeHOIMlSX6k
         p4+0QBTHOQBxHSxrBx/0aDqSAP6x6o5Owmd6IHNBG32B3mOUEPJ85urkLH2r+5HEqpDV
         MulA==
X-Gm-Message-State: ABuFfogp8ocgHKwvJ2GM5l3k6pE0ZvTwM2QBHbZDsUs4sT+RUyC1vu80
        exlJE6NLp2wA2rHAyzrfE15vH6tIFQ==
X-Google-Smtp-Source: ACcGV62DMRDzS1Ef2E71It8UkTSmheMxvKm5ddLDTkMlj1N55vVWXyuN3umeWFx/LFLq06ngdXBW6g==
X-Received: by 2002:aca:dd0a:: with SMTP id u10-v6mr5439457oig.171.1538407545071;
        Mon, 01 Oct 2018 08:25:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Michal Simek <monstr@monstr.eu>
Subject: [PATCH v4 9/9] microblaze: enable building all dtbs
Date:   Mon,  1 Oct 2018 10:25:31 -0500
Message-Id: <20181001152531.3385-10-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for microblaze. As microblaze only has one dts
file, always enable it.

Cc: Michal Simek <monstr@monstr.eu>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/microblaze/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index fe9af267f598..c7324e74f9ef 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 
+dtb-y := system.dtb
+
 ifneq ($(DTB),)
 obj-y += linked_dtb.o
 
-- 
2.17.1

