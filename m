Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB05ECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB997204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XTihYKiy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB997204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeJRIui (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:50:38 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41674 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:50:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so3815309wrr.8;
        Wed, 17 Oct 2018 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCB2xFu33zZBuG0YJc6qNP5Gz5dyMINDtebvPwjiXZQ=;
        b=XTihYKiy/y9w+lBb4VuW6nLFseAN/o1YQFOD3X1cFUGFIGqXp2qPYJw5TLqMba5HdT
         RvtTRGCdy1lPIptoHWRc556fyGyBcrXNcFRwVNWd1SOneCB0IWz4DMAWktN/vi8M1mmy
         1Y5cAjL4CsCAnpyHAZHNimLsWpBgjP5pYflq9jGt52dyNUCGpZC+jdSFZZd0HuEJ8C5G
         ++VJ82YBuzSUiH2iiX9K97ZAqTIvdulCc8iGyM2KxGqWfO2pooxzgTMRzxqavqkUCLLq
         uTZv2OZUnPXysw+RUoVcNlOtoIfLZ18ZqPA1Yg6GxKqoX7r0XRWmDopBJ7nG0YNZNPwm
         33DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCB2xFu33zZBuG0YJc6qNP5Gz5dyMINDtebvPwjiXZQ=;
        b=X6AZKcrG8yXkIQ6u6pVK6Fvhph01V89VUVLauI/7ZtfB7uoWq5roz/qpfvKcnp3aS/
         +wj8MJETmiEVfjGcYoE8/xyWva2c04Z8YOSKItiCrPKecekCZcXNT9NaU5PoVBKkIy3D
         o6qVbSuyItoZs+Lh6I3do8+Ij6KKklmRqD3QTZK6qg29JS1PTuKyyEgfrQ6x/Z1TniIE
         nuPg0XqHJl4XsNlF96fk8FXBUuV4DJVbGt2KXllY9UTgTf0ul4X3y98aLM4vvYz9cvmf
         r0cAcvQjg3Ib/oy/a7UFAvuRjswgTavhOUCBKYgPiMzTqNUM3ZeFqZ9UlyAbu9+/xOSb
         aeiw==
X-Gm-Message-State: ABuFfogO1JVIA0nvme8Q1yARiitLvBnfSi2ZFeFczYGtnYz6TcKMNLeW
        +34JvkawY3WwAIbPu4Gr52Y=
X-Google-Smtp-Source: ACcGV63hEi6BEhaTPZtOPAaK/Saxq4fQcy/42a8jf9lb+lVghnPRFOVxI9DXKrf02bEI1GNetpSbKw==
X-Received: by 2002:a5d:680b:: with SMTP id w11-v6mr24205756wru.186.1539823937009;
        Wed, 17 Oct 2018 17:52:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 91-v6sm5542139wrb.95.2018.10.17.17.52.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 17:52:16 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ARM: OMAP2+: hwmod: Fix some section annotations
Date:   Wed, 17 Oct 2018 17:52:07 -0700
Message-Id: <20181018005207.7201-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the kernel with Clang, the following section mismatch
warnings appears:

WARNING: vmlinux.o(.text+0x2d398): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_iclk_autoidle()
The function _setup() references
the function __init _setup_iclk_autoidle().
This is often because _setup lacks a __init
annotation or the annotation of _setup_iclk_autoidle is wrong.

WARNING: vmlinux.o(.text+0x2d3a0): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_reset()
The function _setup() references
the function __init _setup_reset().
This is often because _setup lacks a __init
annotation or the annotation of _setup_reset is wrong.

WARNING: vmlinux.o(.text+0x2d408): Section mismatch in reference from
the function _setup() to the function .init.text:_setup_postsetup()
The function _setup() references
the function __init _setup_postsetup().
This is often because _setup lacks a __init
annotation or the annotation of _setup_postsetup is wrong.

_setup is used in omap_hwmod_allocate_module, which isn't marked __init
and looks like it shouldn't be, meaning to fix these warnings, those
functions must be moved out of the init section, which this patch does.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 083dcd9942ce..921c9aaee63f 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2413,7 +2413,7 @@ static int __init _init(struct omap_hwmod *oh, void *data)
  * a stub; implementing this properly requires iclk autoidle usecounting in
  * the clock code.   No return value.
  */
-static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
+static void _setup_iclk_autoidle(struct omap_hwmod *oh)
 {
 	struct omap_hwmod_ocp_if *os;
 
@@ -2444,7 +2444,7 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
  * reset.  Returns 0 upon success or a negative error code upon
  * failure.
  */
-static int __init _setup_reset(struct omap_hwmod *oh)
+static int _setup_reset(struct omap_hwmod *oh)
 {
 	int r;
 
@@ -2505,7 +2505,7 @@ static int __init _setup_reset(struct omap_hwmod *oh)
  *
  * No return value.
  */
-static void __init _setup_postsetup(struct omap_hwmod *oh)
+static void _setup_postsetup(struct omap_hwmod *oh)
 {
 	u8 postsetup_state;
 
-- 
2.19.1

