Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128BEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F272075B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Ob2V0uLk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfBKM2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:28:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46906 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbfBKM0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:26:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so4428823wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
        b=Ob2V0uLkmrtuwWtPxVud0yokG4gomj2iZaQcTLHVWFokz4yCSMGB8kUdD1F5saDez/
         KqmOMG5mMi4nkjI1W43r+rrCdfaWJYE6T+EdJW1wUyPMsgZ6N8kBXLhpxfLCx04jRfgx
         KD4ZMBv/6Awwst3KuHkoFz91hPJphJZQlteMEzkr9tQT9LS3lNDvYrXAuIW8n4/yzEG2
         NyeiivWPLiJ3fWVjHRmwfYy1tkgFkXZGw/mPV9zQJ8ai9ee2Z1VYFL/nM/86NpFoPvMV
         O5tBGl0b9u4u3QyHX+0M5KaYPm9inYKXLjAE3uMpCEBGYtW3uy7RQQKiYRtlatJ6/hxd
         EKKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xoYgZeFd4jbYH06UIuAag4pMtuSlF7B4aVziE0WwaQ=;
        b=GStt56R88nmi2DyjiKm+zawn+/i1+EEyzIZ9NrqKb+CPv5fkIm94TsbTQ1uo+Wmq8z
         lfRtX47u5fNCYyaTRabVI0pvPjWakrEkxByYAwWs/SHaav16QdilEsytm25fM+Ajfofg
         EMr9rj2o4QVJgovLapl/wnS9edsbXt7LsyZHQWrtFA4EIcaa2q8aneT3wcqPIGWxTCqx
         BoF2gp1FMOMQhuMZvwlMpu679lcYaZt/WIchMLJkhX+wfiQ7MX5JP3Uk8luKbWnHtfme
         nXjmbqytzligFS92bDbu3eZH/WKx/Uf0ON76LDMN46jnMON4RuPOeTLx5k6anS1fs73g
         kgPw==
X-Gm-Message-State: AHQUAuZ2+3ZvnJw7sGu+oR8xI8EIBTTmAdaf0ZJzuH4YQZHfvvl47+KV
        L8mZc5zrxbMEjpsiQYma/gfNgA==
X-Google-Smtp-Source: AHgI3Ib3ufdV3JJ8HpUVVBn3lmc7RDQ/jNotQIrcWskt+PH5iDrdUGEcOKKjtpnyRjeyGH5t4kkUdQ==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr28055297wro.261.1549887989765;
        Mon, 11 Feb 2019 04:26:29 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 04:26:29 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        David Lechner <david@lechnology.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [RESEND PATCH v2 13/33] ARM: davinci: aintc: use readl/writel_relaxed()
Date:   Mon, 11 Feb 2019 13:25:46 +0100
Message-Id: <20190211122606.8662-14-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
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
 arch/arm/mach-davinci/irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 148c23728bdb..6a7205a844e1 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -36,12 +36,12 @@ static struct irq_domain *davinci_aintc_irq_domain;
 
 static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_aintc_base + offset);
+	writel_relaxed(value, davinci_aintc_base + offset);
 }
 
 static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return __raw_readl(davinci_aintc_base + offset);
+	return readl_relaxed(davinci_aintc_base + offset);
 }
 
 static __init void
-- 
2.20.1

