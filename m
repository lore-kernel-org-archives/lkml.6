Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B576EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D962148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zsbih5A0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfA1SGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:06:10 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45164 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfA1SEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:04:46 -0500
Received: by mail-wr1-f68.google.com with SMTP id t6so19091554wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyqJ1ZNijojoTR5cd+qdscOqYrp/PnKLGRUwKnFmRlM=;
        b=Zsbih5A0XT1436LqD455eX3TwHSJgdMOs5dTyer3kSmE68pxW9N/15q6Wve7hhuO58
         4kNON7i+OYW7ZThzqCZtg8TaDJMY/Ytrp/CBCPR5GdEnv1gAsbPqnVVt7cHfFkXTST68
         3WB5Ol7LCzQeZeLHAZ2dksmfHJu9u75BOxP4I60de9Db00O7aiJVJmQNzthFYco4EAZR
         cM/fkxyoDEKmaLBOHxRCtoCxOk1WCUgkHdfgMh26S0iMES+syQ8ZMfjACKGGJytfg0TV
         tzuEE0kAv/jjkY7HQHcn4pJzuRQmlpH2mmuKf1BGaFIu9dUp/Xqh8QYDgW+wfOwJfpCn
         HUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyqJ1ZNijojoTR5cd+qdscOqYrp/PnKLGRUwKnFmRlM=;
        b=Gski64gTDqOkXxFlN7hLEpFDpGeg5StomdYpe1zuUtSAiqXWLF6SVAhuduxiwptTcW
         wjOTe3NipwJhwMYAAHCCeN+KDTs+G2LqQOU/CW3Y4vLnWIEu/c5X4KNKVjbuwewygO7Y
         Jn2SkGFaylNrCbK+qXfL0Dsrm81zqv/HYleINF6kUJkQ1MeABvSrMMKiDa3KAwAWs3RS
         s2Qx8hJ1acwyn1Sg2YkpX2/aJM0UXbuVwzwauB22M8bT+qL0ZjYCLdd+FQks6mVu+vSw
         Ujm0qFiiL+rsB7fSAayAT5DtwXS5gju1RvW7trSUjx/sq2glELF4YcMkhNveNkgOXw+L
         XGpQ==
X-Gm-Message-State: AJcUukcO9SPi8uQ68LzVJzMV+9smOkuymIVug7kLtDXof2mdCCaECZ1l
        LLMCaq+b3kuEqwFVQqPpESh4Vg==
X-Google-Smtp-Source: ALg8bN70L5BosbEnf2iuiICAG9QvKNUPF80NJIk18dNZI4ftldt6y16V7XP2FO29oJ5/RvoO9VsXKg==
X-Received: by 2002:a5d:40c1:: with SMTP id b1mr23743080wrq.133.1548698684743;
        Mon, 28 Jan 2019 10:04:44 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id p6sm145548193wrx.50.2019.01.28.10.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:04:44 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/14] clk: meson: use CONFIG_ARCH_MESON to enter meson clk directory
Date:   Mon, 28 Jan 2019 19:04:18 +0100
Message-Id: <20190128180430.28689-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128180430.28689-1-jbrunet@baylibre.com>
References: <20190128180430.28689-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use CONFIG_ARCH_MESON to let make enter the meson clock directory.
As part of a rework, CONFIG_COMMON_CLK_AMLOGIC is about to be removed.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 8a9440a97500..8d780c4390f1 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -78,7 +78,7 @@ obj-$(CONFIG_ARCH_K3)			+= keystone/
 obj-$(CONFIG_ARCH_KEYSTONE)		+= keystone/
 obj-$(CONFIG_MACH_LOONGSON32)		+= loongson1/
 obj-y					+= mediatek/
-obj-$(CONFIG_COMMON_CLK_AMLOGIC)	+= meson/
+obj-$(CONFIG_ARCH_MESON)		+= meson/
 obj-$(CONFIG_MACH_PIC32)		+= microchip/
 ifeq ($(CONFIG_COMMON_CLK), y)
 obj-$(CONFIG_ARCH_MMP)			+= mmp/
-- 
2.20.1

