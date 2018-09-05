Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E80FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DD62083E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 23:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9DD62083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbeIFE0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 00:26:06 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44749 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbeIFE0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 00:26:06 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so17090283oih.11;
        Wed, 05 Sep 2018 16:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jjE/jnUmiKPQSmhzhh4e+Dd46t+Pdv/5rhH5PoOndHA=;
        b=ScExSHV0QOidcxNN3/bMDUYeGpMmbgjJiu/Y/UFy1J9qXCTNBCoUUCpOWv7nFKhVk8
         7bLD/lmSEuMckvmqeEx7kjDvvWytC+c14FD9U6L/AMJHq0XTq+FWCFa873JFT5bL5mhr
         wtBMmKRWOw4+M/V8APXxzubfXuXw9A6e0UYi1frbDRy82jqpIa/8FQUUAiDr5NkAQAKi
         YCy4L7GU8dYyIMeLYaVRqjUt1sIpjY6iE//81mhWR1FvD3slwAyQw3ozxkYeYKF1Xn8K
         h/BBF1InH0mm1Z6UIJmEFAUxfPhOWhm2aXHQ0e0K9wdbL7cC8XbAcEhM0xXFJJEBMDBN
         G0zw==
X-Gm-Message-State: APzg51BsKipr4i/mxVO7v8FwaLGi/V5Opfb0ZHPQzHeQQWFbbkaPqpZ8
        CxKblpUPc0KFAf2rE6vzA2U96Mc=
X-Google-Smtp-Source: ANB0Vdbss+yeJog8Cex6F2pA/nEHjKrTDmeUu4uUCHUFj9TKA32CaYiRCjoH7ehSjbk1u+0X3n8q7g==
X-Received: by 2002:aca:aa8d:: with SMTP id t135-v6mr123276oie.218.1536191613633;
        Wed, 05 Sep 2018 16:53:33 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id h186-v6sm3860624oib.55.2018.09.05.16.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 16:53:33 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
Subject: [PATCH v2 4/9] nios2: fix building all dtbs
Date:   Wed,  5 Sep 2018 18:53:22 -0500
Message-Id: <20180905235327.5996-5-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180905235327.5996-1-robh@kernel.org>
References: <20180905235327.5996-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nios2 has a 'dtbs' target, but nothing is added to 'dtb-*' targets and
no dtbs were getting built. This enables building all the dts files in
arch/nios2/boot/dts/ when COMPILE_TEST and OF_ALL_DTBS are enabled.

Cc: Ley Foon Tan <lftan@altera.com>
Cc: nios2-dev@lists.rocketboards.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please ack so I can take the whole series via the DT tree.

 arch/nios2/boot/dts/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/nios2/boot/dts/Makefile b/arch/nios2/boot/dts/Makefile
index f6358e395b25..a91a0b09be63 100644
--- a/arch/nios2/boot/dts/Makefile
+++ b/arch/nios2/boot/dts/Makefile
@@ -1,3 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0

 obj-y := $(patsubst "%.dts",%.dtb.o,$(CONFIG_NIOS2_DTB_SOURCE))
+
+dtstree		:= $(srctree)/$(src)
+dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
--
2.17.1
