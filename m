Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D84C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EAB214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6EAB214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbeHVBRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 21:17:31 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35005 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbeHVBRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 21:17:30 -0400
Received: by mail-oi0-f67.google.com with SMTP id m11-v6so34828994oic.2;
        Tue, 21 Aug 2018 14:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DYdoq36w44tbxiz7aQnu4a0/sdA1BLlXIXWES4KJFKs=;
        b=QJPLxS9uNxPMDOOP0zuifECM+ztKib85tnuehwgFm25uMoxEMoPuLExD5LeX5ubg56
         GNfWHELl6v2El6Q7WLyFKh6MVwOdJ0RlH542BEA5GRO5Z8EhEq4GahCbPRMIiWbMM+PI
         wQUPyQxPkW4Cij2ZxO0Ig3oVo/it84zfLWKC02sBrglpVM68shr43mNHGkqlGkkn0xAT
         vOnvyoWJn/udoPkiWZeV2RSnqY1iLROcFYaHCv4M0XAa9M522b6MaogDixPTQ0OqL5D8
         t/0/j1FEfvDfa/6HGgEQzbOwhU/CX4OO2BowjK1l1FiN2e9exTD3z+XUjw0O7OoX28Xw
         goIQ==
X-Gm-Message-State: APzg51DVGowtn/MvPvg7ICSmszby1PcZaoAxmat3ea4Cdj2onO4PhFyr
        goqw+L+WpQhUICLD2Z6hnv50rRE=
X-Google-Smtp-Source: ANB0VdZnXTjlKHdPMXoP7aBufK+4Kzd8htDRl6gq55q9vQI+hAkgydJC1CYw1MpyJfm6DxdULwlJsw==
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr1117459oig.349.1534888534749;
        Tue, 21 Aug 2018 14:55:34 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x126-v6sm18785332oig.15.2018.08.21.14.55.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 14:55:34 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH 8/8] c6x: enable building all dtbs
Date:   Tue, 21 Aug 2018 16:55:24 -0500
Message-Id: <20180821215524.23040-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180821215524.23040-1-robh@kernel.org>
References: <20180821215524.23040-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the 'dtbs' target for c6x. This allows building all the dts
files in arch/powerpc/boot/dts/ for enabled platforms or when
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

