Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAF4C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F49820880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F49820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbeIJT6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:58:49 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46840 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbeIJT6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:58:49 -0400
Received: by mail-oi0-f67.google.com with SMTP id y207-v6so40669123oie.13;
        Mon, 10 Sep 2018 08:04:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZySN/D1fRaGYkVeB0WaJuKd+aEwp6HX7O0XCzNmGjE=;
        b=Fm5qd4yMCoc0GeZFFp2Vsp5xyd6chz3tFRlJFQkPNCuUEJJ10h60NQjksVq/fUE9m/
         SbHP/+CoR44Dv9zkY/1Nissa3U7aeLIkY7kjgUxN6kKIgeqjzdNMU7eY7nHaRxvYSAE4
         iHLwBNQsx4M/8kA3RHTaKgHTjEjl6JfqtgzAvz6AVI8l5vgttCm/j/3daNG2a2v5vKyF
         IB309fhWeTWLJezBzezXlWgzj+HO75zEGZwkD+/tAF8Z7Y9+G6TIRVIFHDNFq0YCJg5v
         OYWHAHshhCcLwuDaddgcv6cx0olLjF4D6m2r1iR/5rZ1bpKzwAH7bVYiaguPKAIxuFtX
         rI4A==
X-Gm-Message-State: APzg51C4Qrww33ZSiT7LzDFVkOEON21LZ7FglOQ3SsTkNMcfn8CTgbwL
        QOeu+5IA9WIJx5jxzwWTEoDMdEo=
X-Google-Smtp-Source: ANB0Vdb3qx+fimKBsy7B5112NLkSFCSaG2w6zv2fGsGuImExfbeZ4rXyiAiE3UfACkMc8boXpvVWng==
X-Received: by 2002:aca:bb0a:: with SMTP id l10-v6mr23915252oif.153.1536591857489;
        Mon, 10 Sep 2018 08:04:17 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k85-v6sm49465631oiy.2.2018.09.10.08.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:04:15 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH v3 8/9] c6x: enable building all dtbs
Date:   Mon, 10 Sep 2018 10:04:02 -0500
Message-Id: <20180910150403.19476-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180910150403.19476-1-robh@kernel.org>
References: <20180910150403.19476-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for c6x. This allows building all the dts
files in arch/c6x/boot/dts/ for enabled platforms or when
COMPILE_TEST and OF_ALL_DTBS are enabled.

Cc: Mark Salter <msalter@redhat.com>
Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: linux-c6x-dev@linux-c6x.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/c6x/boot/dts/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/c6x/boot/dts/Makefile b/arch/c6x/boot/dts/Makefile
index fd937f781d16..f438285c3640 100644
--- a/arch/c6x/boot/dts/Makefile
+++ b/arch/c6x/boot/dts/Makefile
@@ -5,6 +5,12 @@
 
 DTC_FLAGS ?= -p 1024
 
+dtb-$(CONFIG_SOC_TMS320C6455) += dsk6455.dtb
+dtb-$(CONFIG_SOC_TMS320C6457) += evmc6457.dtb
+dtb-$(CONFIG_SOC_TMS320C6472) += evmc6472.dtb
+dtb-$(CONFIG_SOC_TMS320C6474) += evmc6474.dtb
+dtb-$(CONFIG_SOC_TMS320C6678) += evmc6678.dtb
+
 ifneq ($(DTB),)
 obj-y += $(DTB).dtb.o
 endif
-- 
2.17.1

