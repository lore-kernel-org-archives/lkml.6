Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7488C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DF7320866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N7zarI/R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DF7320866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbeIKTTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:19:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43993 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeIKTTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:19:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id h64-v6so20471911lfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vlBGOu5rXqpxMvrqpxnpBIui/uTQDzX5bcXlv33LhAE=;
        b=N7zarI/RlHiF2iuxiXbfBaFXSehsxHfe6aSnFQsWX0b0d2YpRhNi14KFBkKxWtypEM
         deQzTcUAwe60apsYJZmAdIQVWjztZmJ2vTxl9MZQsFPIQv4KcgPUquwvLS6FUolDmtqs
         uxJFq22a9+7554Epm9BgYJlrbB/LRLbwLU4lE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vlBGOu5rXqpxMvrqpxnpBIui/uTQDzX5bcXlv33LhAE=;
        b=jcLFBDAezDZRtjcL1UCp97nSgI0UFKsRBfirWTXkRAIs5eYdWmuGJlUTvoeV505GGo
         IGXTUXMJIhgmUD6q8FVQhuuFCe2ePcuiIuoM3MUBil17+msiwZSnm4SX7Yk2HDyGckSA
         ty6U5aj2LL5hMukjAh+/Xz7LsaYB9oGAoRuGl8TbQQ2coc3tCnBdWOTFmkSOaSrGk5XK
         hFByob1ZunIemLZF2+Qerod/aBguViHLkKqtnTHaWfpj4gAoE33JUTD6SdYZTN/BPg/n
         tS4dSXoTPgpPxipTrLYEFVlszz6YsAeL+k5Rcx+bYo6cdsKZLQe7IRNzE9LGmVVMAFkQ
         Vsqw==
X-Gm-Message-State: APzg51CuB02lr719mDB01ZuC7+aOBWvFTVmTdl9oKv4g9HLSG9JfWSq6
        4wOXJ08Q+5Txcx8OTBZepFXsNRlDCZwcag==
X-Google-Smtp-Source: ANB0VdbDrsl4ptpDWhGGT68nIJWXLeY33tqOW4O2/FUKoRcRugOy39jRk9wwmt1JqImCUQsNFPb4Cw==
X-Received: by 2002:a19:7706:: with SMTP id s6-v6mr3946659lfc.84.1536675577624;
        Tue, 11 Sep 2018 07:19:37 -0700 (PDT)
Received: from localhost (c-732171d5.07-21-73746f28.bbcust.telenor.se. [213.113.33.115])
        by smtp.gmail.com with ESMTPSA id g10-v6sm3308543lfl.11.2018.09.11.07.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 07:19:37 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v2] ALSA: hda: fix unused variable warning
Date:   Tue, 11 Sep 2018 16:18:36 +0200
Message-Id: <20180911141836.14463-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <s5hbm941law.wl-tiwai@suse.de>
References: <s5hbm941law.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_X86=n function azx_snoop doesn't use the variable chip it
only returns true.

sound/pci/hda/hda_intel.c: In function ‘dma_alloc_pages’:
sound/pci/hda/hda_intel.c:2002:14: warning: unused variable ‘chip’ [-Wunused-variable]
  struct azx *chip = bus_to_azx(bus);
              ^~~~

Create a inline function of azx_snoop.

Fixes: a41d122449be ("ALSA: hda - Embed bus into controller object")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/pci/hda/hda_controller.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index 0053b704ddc4..c95097bb5a0c 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -170,11 +170,10 @@ struct azx {
 #define azx_bus(chip)	(&(chip)->bus.core)
 #define bus_to_azx(_bus)	container_of(_bus, struct azx, bus.core)
 
-#ifdef CONFIG_X86
-#define azx_snoop(chip)		((chip)->snoop)
-#else
-#define azx_snoop(chip)		true
-#endif
+static inline bool azx_snoop(struct azx *chip)
+{
+	return !IS_ENABLED(CONFIG_X86) || chip->snoop;
+}
 
 /*
  * macros for easy use
-- 
2.18.0

