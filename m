Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEDBC0044B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F390021480
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F390021480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbeJAWEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:04:04 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35973 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbeJAWEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:04:04 -0400
Received: by mail-oi1-f193.google.com with SMTP id p125-v6so11519442oic.3;
        Mon, 01 Oct 2018 08:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kZySN/D1fRaGYkVeB0WaJuKd+aEwp6HX7O0XCzNmGjE=;
        b=hmTT24SNWcL0OzzKF1RRyPvIo/IP3/Sk8hggZQGFyZetD22JSCiwzkGW33k20HAWeW
         8yAOqvhZB4yxlBNJITlE1ToZOeALFjUjtxUoqplFl0atd41e8RnofJ1kWv7AfoIrcdzG
         oO3NWe707mQ1PV9D9KNibn7vbcB2Dd3RbM0VH6TxPsokEGlf4ORcDh8BaBPS4v7/D3Nj
         jRsNl9upZ7gr+Yl40tPr3wu3tSX5yreeKhZSPEmyqQPbkoMjYhRSxSdI+XR1PmLUpFcj
         GlM87eLbWKoFNdhIsSEl2PhLJ+mBODlAKc+hzl/EaPVNXmOk3aey8pSuUpIiVaZmCRMK
         Djqw==
X-Gm-Message-State: ABuFfogdninsZ5QJfRTC0Pl6sqYQvsvaqrWMHI5bHGEDCNguhcTyoDLO
        xyLYEBs6dBEN/u0lNQghQ7qocE1SvQ==
X-Google-Smtp-Source: ACcGV60g1RkIixrz8cRA8fvgsffGMqfg2Pl3WXcA2DnoX9OvAblmC6gD5psys+jmwH5lPTREM534xQ==
X-Received: by 2002:aca:5107:: with SMTP id f7-v6mr5658237oib.223.1538407544241;
        Mon, 01 Oct 2018 08:25:44 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id s203-v6sm2047035oif.33.2018.10.01.08.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 08:25:43 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org
Subject: [PATCH v4 8/9] c6x: enable building all dtbs
Date:   Mon,  1 Oct 2018 10:25:30 -0500
Message-Id: <20181001152531.3385-9-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181001152531.3385-1-robh@kernel.org>
References: <20181001152531.3385-1-robh@kernel.org>
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

