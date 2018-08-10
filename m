Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E2FC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2603223C9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 03:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pV+4qH3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2603223C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeHJFtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 01:49:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33994 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbeHJFtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 01:49:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so3841524pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 20:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Me+ZYectWHujsAxD8lZUB3egYHKO4Vm/esXkM4BdyY=;
        b=pV+4qH3e15jJ+9gyTRdi4UB7nU+Ka6vh+OgRS3CokOfPxRn+5UimXyKaK5oV0SMiIu
         VT+ZMKiwKPw2EG33qxa2J/tbnmfpJfYMjM+P/SG9XGg5/IXb+35WO0vUbmnb/r2IVYxJ
         CGteMvDkZSPjFOuOQ7eoOISGm1j67Ig87LzMnLqqxBmNf1h1LK+5VbXEOgoY8eu8TTZT
         So07kHsSS/NtERHbY3Zdh2FPlr6YkWT1M5pTvKmf8GmG0g38EA56RG/YWtSG9qQRqt7k
         zUM4k7i6Q4qGMXsQp/Qd31U7SVPBAQGaBmZ4r3eQKmkN/i+AmXDCkqig5zV85pEwWtIj
         g0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Me+ZYectWHujsAxD8lZUB3egYHKO4Vm/esXkM4BdyY=;
        b=ZK+jSxJZbWFKUgNW9dNWbytc3A31Vjli6RUX/2CyhQJ/mVExWawIHBaOPNixfXKA3U
         ZV57N2h9ka41EAuZTv2avFOCwbY9At8+MF67kIDY4PA9XZ8JTVanB9BuIz2MbeXSTB7D
         FCaNj25zGFhbx2JD2Q9lAmfHM7F/+1J9yRVUjyWAPhBFWdW+YC8BJzNy/WDn9uZtwzJh
         ZHSQBqAObJsp/h64XiIHLPAsPtowflUp3f3Du+wwVNPVNQTfkE5gXbtvnyXtbYg5F9hs
         Bom+u6x3GJHkW/GBqhRO6BNAkYntoLPJqXZHDfBLVY6Cik4H0i40ifOyozfgypuEyTpa
         Q1wQ==
X-Gm-Message-State: AOUpUlF+9tsShiqWs4Kyw0LmOGz521iZ7hlaGeobBWuQJe4kWBW/1N+w
        zz31wouDzIkurx+0AJZoLOs=
X-Google-Smtp-Source: AA+uWPxg4zvJlvsjZCJNM8QaZHHHweN9CDKtW2BPkV89dBblQh+DnSZ9RpUCn16tAaSXZxq0DAskfw==
X-Received: by 2002:a63:5106:: with SMTP id f6-v6mr4456917pgb.95.1533871299375;
        Thu, 09 Aug 2018 20:21:39 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id p73-v6sm16130871pfk.186.2018.08.09.20.21.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 20:21:38 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 16/16] staging: gasket: interrupt: remove unimplemented interrupt types
Date:   Thu,  9 Aug 2018 20:21:11 -0700
Message-Id: <20180810032111.197743-17-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180810032111.197743-1-toddpoynor@gmail.com>
References: <20180810032111.197743-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Interrupt types PCI_MSI and PLATFORM_WIRE are unused and unimplemented.
Remove these.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/gasket_core.h      | 11 --------
 drivers/staging/gasket/gasket_interrupt.c | 34 +----------------------
 2 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/drivers/staging/gasket/gasket_core.h b/drivers/staging/gasket/gasket_core.h
index fd7e75b765a6d..0203460f48957 100644
--- a/drivers/staging/gasket/gasket_core.h
+++ b/drivers/staging/gasket/gasket_core.h
@@ -50,8 +50,6 @@ enum gasket_interrupt_packing {
 /* Type of the interrupt supported by the device. */
 enum gasket_interrupt_type {
 	PCI_MSIX = 0,
-	PCI_MSI = 1,
-	PLATFORM_WIRE = 2,
 };
 
 /*
@@ -69,12 +67,6 @@ struct gasket_interrupt_desc {
 	int packing;
 };
 
-/* Offsets to the wire interrupt handling registers */
-struct gasket_wire_interrupt_offsets {
-	u64 pending_bit_array;
-	u64 mask_array;
-};
-
 /*
  * This enum is used to identify memory regions being part of the physical
  * memory that belongs to a device.
@@ -384,9 +376,6 @@ struct gasket_driver_desc {
 	 */
 	struct gasket_coherent_buffer_desc coherent_buffer_description;
 
-	/* Offset of wire interrupt registers. */
-	const struct gasket_wire_interrupt_offsets *wire_interrupt_offsets;
-
 	/* Interrupt type. (One of gasket_interrupt_type). */
 	int interrupt_type;
 
diff --git a/drivers/staging/gasket/gasket_interrupt.c b/drivers/staging/gasket/gasket_interrupt.c
index eb5dfbe08e214..2cd262be65ca0 100644
--- a/drivers/staging/gasket/gasket_interrupt.c
+++ b/drivers/staging/gasket/gasket_interrupt.c
@@ -45,9 +45,6 @@ struct gasket_interrupt_data {
 	/* The width of a single interrupt in a packed interrupt register. */
 	int pack_width;
 
-	/* offset of wire interrupt registers */
-	const struct gasket_wire_interrupt_offsets *wire_interrupt_offsets;
-
 	/*
 	 * Design-wise, these elements should be bundled together, but
 	 * pci_enable_msix's interface requires that they be managed
@@ -92,19 +89,6 @@ static void gasket_interrupt_setup(struct gasket_dev *gasket_dev)
 
 	dev_dbg(gasket_dev->dev, "Running interrupt setup\n");
 
-	if (interrupt_data->type == PLATFORM_WIRE ||
-	    interrupt_data->type == PCI_MSI) {
-		/* Nothing needs to be done for platform or PCI devices. */
-		return;
-	}
-
-	if (interrupt_data->type != PCI_MSIX) {
-		dev_dbg(gasket_dev->dev,
-			"Cannot handle unsupported interrupt type %d\n",
-			interrupt_data->type);
-		return;
-	}
-
 	/* Setup the MSIX table. */
 
 	for (i = 0; i < interrupt_data->num_interrupts; i++) {
@@ -351,8 +335,6 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
 	interrupt_data->interrupt_bar_index = driver_desc->interrupt_bar_index;
 	interrupt_data->pack_width = driver_desc->interrupt_pack_width;
 	interrupt_data->num_configured = 0;
-	interrupt_data->wire_interrupt_offsets =
-	    driver_desc->wire_interrupt_offsets;
 
 	interrupt_data->eventfd_ctxs = kcalloc(driver_desc->num_interrupts,
 					       sizeof(struct eventfd_ctx *),
@@ -379,12 +361,7 @@ int gasket_interrupt_init(struct gasket_dev *gasket_dev)
 		force_msix_interrupt_unmasking(gasket_dev);
 		break;
 
-	case PCI_MSI:
-	case PLATFORM_WIRE:
 	default:
-		dev_err(gasket_dev->dev,
-			"Cannot handle unsupported interrupt type %d\n",
-			interrupt_data->type);
 		ret = -EINVAL;
 	}
 
@@ -439,12 +416,7 @@ int gasket_interrupt_reinit(struct gasket_dev *gasket_dev)
 		force_msix_interrupt_unmasking(gasket_dev);
 		break;
 
-	case PCI_MSI:
-	case PLATFORM_WIRE:
 	default:
-		dev_dbg(gasket_dev->dev,
-			"Cannot handle unsupported interrupt type %d\n",
-			gasket_dev->interrupt_data->type);
 		ret = -EINVAL;
 	}
 
@@ -489,12 +461,8 @@ void gasket_interrupt_cleanup(struct gasket_dev *gasket_dev)
 		gasket_interrupt_msix_cleanup(interrupt_data);
 		break;
 
-	case PCI_MSI:
-	case PLATFORM_WIRE:
 	default:
-		dev_dbg(gasket_dev->dev,
-			"Cannot handle unsupported interrupt type %d\n",
-			interrupt_data->type);
+		break;
 	}
 
 	kfree(interrupt_data->interrupt_counts);
-- 
2.18.0.597.ga71716f1ad-goog

