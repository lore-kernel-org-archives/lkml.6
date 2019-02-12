Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F957C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51F20818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TM389Kqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbfBLKkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:40:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33152 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbfBLKjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:39:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so2132075wrw.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
        b=TM389KqpbC5bwmcLby+pr8tycR9fW8iIapHqkDS3YAxCSk0GwBqD7TeL5otfm+yD/2
         YlBbaAVmGvFdmrRUbm+gQPjpzGwSaj3lUTjVwoSxERa2C6fRaMvG7WsXDQa8Rnew2z2f
         AuLVOzSvaTSBw5bhjFSZH4MuGdKJLAi4nA6YfLZ3ZjFnOMijp7x001Vz67vcxvz+LAz5
         mSkba2Jo3pe2shxwGTHLiUvD7Ek1w0omMv86dBoTTYU5WyqG9rvmpgQK7tj2AaJeOW5G
         5Gl9h/88+SPMd9p0ORmwLL6LQYcjdnrhbfU42SHd55fJUv/6G80b4R9fbLT4FQUDCPbN
         DhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okUwTyEeH6/l1M7Q6lKQuzEi41SPX2N++dZHkl6IdSI=;
        b=AiEG9nupvM4OQv/5RVgxoKSJVxMJO8uN3Z6JWDYYmCJ0hHZ05BoyUBtmNtWr0WmgNH
         bSllF+lgiOVHIc04KP8pPz6XbFZVJk2y3OlfCqdpyshbQoUdSXS4yijam91C7/UQAbiV
         H91MzdXrBYPlgJNLfonm1uQiHYv4w16eTSsKCL5GZjSwXpKPPrrJZT30v21nI/BhiReY
         5NVL/VUMwREhw0DKIZ9Plc0zlX2tJE2YvNbVzQYVVRlfve+mf20HcpA1jzK5w+1Fmr08
         1Lcfl7QPRYcpyC4KxEmmeXEXPKSYGqs1MzIMVRLXxx2yRAHA0Et3/0U70sTxwuIN9AmM
         OXmg==
X-Gm-Message-State: AHQUAuZwG497QcJmXzyacWr0PF+5bSxc++3QKgvfRk8u5+hMA5ifjwHX
        jjJvPfy4QDFDWOl/3/NnpvJwmw==
X-Google-Smtp-Source: AHgI3IartXzIlq/q5l3UPJBAx/H12112fxsKERl/fL3xF1FHDQrBG/gg0x9juN2adFb6mxtJI3klBQ==
X-Received: by 2002:adf:ba8e:: with SMTP id p14mr2273753wrg.230.1549967974733;
        Tue, 12 Feb 2019 02:39:34 -0800 (PST)
Received: from localhost.localdomain (aputeaux-684-1-38-32.w90-86.abo.wanadoo.fr. [90.86.93.32])
        by smtp.gmail.com with ESMTPSA id c14sm3708656wrn.12.2019.02.12.02.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 02:39:34 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v3 33/37] ARM: davinci: cp-intc: use readl/writel_relaxed()
Date:   Tue, 12 Feb 2019 11:38:31 +0100
Message-Id: <20190212103835.7768-34-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212103835.7768-1-brgl@bgdev.pl>
References: <20190212103835.7768-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Raplace all calls to __raw_readl() & __raw_writel() with readl_relaxed()
and writel_relaxed() respectively. It's safe to do as there's no
endianness conversion being done in the code.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 1bf11fa8be76..f88b7f0978aa 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -45,13 +45,13 @@ static struct irq_domain *davinci_cp_intc_irq_domain;
 
 static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_cp_intc_base + offset);
+	return readl_relaxed(davinci_cp_intc_base + offset);
 }
 
 static inline void davinci_cp_intc_write(unsigned long value,
 					 unsigned int offset)
 {
-	__raw_writel(value, davinci_cp_intc_base + offset);
+	writel_relaxed(value, davinci_cp_intc_base + offset);
 }
 
 static void davinci_cp_intc_ack_irq(struct irq_data *d)
-- 
2.20.1

