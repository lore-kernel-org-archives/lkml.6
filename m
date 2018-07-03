Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3889AC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A9424267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcg/NMhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A9424267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeGCJ0k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:26:40 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53809 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933358AbeGCJZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:25:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id b188-v6so1533826wme.3;
        Tue, 03 Jul 2018 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QOta8LcZmeGUawL7B+xnuNLz2I0M8jr3xXB4YJIaONE=;
        b=vcg/NMhIXqhAKXVeQMC22qfdh8J5STMY7z6A1anGNe7rFvoVcNkUbNgrFaxiUmH75X
         DOhig74DIz88kaGXxP2A8Y943pokScs7kTJzLjoywgoxjVsGP34Nw/tner7FQrayz16y
         0TR5YlUgjfaxnskktar+44bKIYZeACpzmFheVnYJUx1D8u9gsv/kb7k21l9T7Qc3Eltx
         T7nBt7JcytsIOFBtItA1qPRV1LGis2pd6+8QLAaZ5+jWW7khXU2ek8zsQ0iAL3xXNpsm
         fvdYAGF8tIdr0chgecRoVqJ9Ym5Y0M7LvYq/IrUMKFBK/Arn92iswavF/53tB8PGr3y8
         YM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QOta8LcZmeGUawL7B+xnuNLz2I0M8jr3xXB4YJIaONE=;
        b=dkfyC5yhRRSwbb79slYs3xGVoQWemdL6n7LbttGhKGuXCP4+y8GzoB92ogwHeoasuF
         yYc/Nrv3wfTZu7EBqlXDbeBFDLABejn4P9OPofGqLF/hQNbBYN5nVVuvK9V9+c29Udsi
         hEG9nKZFvqKaG0iLo2lblddLN4F/y4K2ufcNcrbCxUETcm+WYoOdHVw72sPp1nt+6lYN
         dV0XK5lSGxiVvgtfURWqZUN+1YRR1y/CeM73Zs7eA4PQfiQAH0e29Jk5JPiajIudWt41
         ueQOOSkScy6+zLtqoA6v3a34RkJpi5dFNBegjiANUVRFVCqVlpNpa3n/DhDF/hAdHdfh
         wJQg==
X-Gm-Message-State: APt69E1xZVY9Z7Q6QYp7VwezXHMfYyeKbE+1hm/ARGWlyBaR/Ixymag/
        b9PXT8B6nWgotvNov96Yvz8=
X-Google-Smtp-Source: AAOMgpctEii7QQdpoLfBcyhMnih7laOVRfUkjk8WOln9CgRZ9q+4j7hH3VC3poq8i0Nq+I8GEZDthw==
X-Received: by 2002:a1c:9290:: with SMTP id u138-v6mr4232642wmd.52.1530609957035;
        Tue, 03 Jul 2018 02:25:57 -0700 (PDT)
Received: from xpert.denx.de ([62.91.23.180])
        by smtp.gmail.com with ESMTPSA id r194-v6sm1819280wmd.36.2018.07.03.02.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 02:25:55 -0700 (PDT)
From:   Saravanan Sekar <sravanhome@gmail.com>
To:     afaerber@suse.de, sboyd@kernel.org,
        manivannan.sadhasivam@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org,
        support@cubietech.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, linux@cubietech.com,
        darren@cubietech.com, mp-cs@actions-semi.com, pn@denx.de,
        sravanhome@gmail.com
Subject: [PATCH v3 3/5] clk: actions: Add REGMAP as dependency
Date:   Tue,  3 Jul 2018 11:25:22 +0200
Message-Id: <20180703092524.1697111-4-sravanhome@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180703092524.1697111-1-sravanhome@gmail.com>
References: <20180703092524.1697111-1-sravanhome@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add REGMAP as dependency to avoid undefined reference to regmap symbol

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
---
 drivers/clk/actions/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/actions/Kconfig b/drivers/clk/actions/Kconfig
index 5a2dad33769e..9066eb4709b1 100644
--- a/drivers/clk/actions/Kconfig
+++ b/drivers/clk/actions/Kconfig
@@ -1,6 +1,7 @@
 config CLK_ACTIONS
 	bool "Clock driver for Actions Semi SoCs"
 	depends on ARCH_ACTIONS || COMPILE_TEST
+	select REGMAP_MMIO
 	default ARCH_ACTIONS
 
 if CLK_ACTIONS
-- 
2.14.4

